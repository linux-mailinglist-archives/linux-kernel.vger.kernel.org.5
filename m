Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736F18013CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379571AbjLAT7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbjLAT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:59:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA6AFA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:59:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAEDC433C9;
        Fri,  1 Dec 2023 19:59:11 +0000 (UTC)
Date:   Fri, 1 Dec 2023 14:59:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/rmap: Fix misplaced parenthesis of a likely()
Message-ID: <20231201145936.5ddfdb50@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

Running my yearly branch profiler to see where likely/unlikely annotation
may be added or removed, I discovered this:

correct incorrect  %        Function                  File              Line
 ------- ---------  -        --------                  ----              ----
       0   457918 100 page_try_dup_anon_rmap         rmap.h               264
[..]
  458021        0   0 page_try_dup_anon_rmap         rmap.h               265

I thought it was interesting that line 264 of rmap.h had a 100% incorrect
annotation, but the line directly below it was 100% correct. Looking at the
code:

	if (likely(!is_device_private_page(page) &&
	    unlikely(page_needs_cow_for_dma(vma, page))))

It didn't make sense. The "likely()" was around the entire if statement
(not just the "!is_device_private_page(page)"), which also included the
"unlikely()" portion of that if condition.

If the unlikely portion is unlikely to be true, that would make the entire
if condition unlikely to be true, so it made no sense at all to say the
entire if condition is true.

What is more likely to be likely is just the first part of the if statement
before the && operation. It's likely to be a misplaced parenthesis. And
after making the if condition broken into a likely() && unlikely(), both
now appear to be correct!

Cc: stable@vger.kernel.org
Fixes:fb3d824d1a46c ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b26fe858fd44..3c2fc291b071 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -261,8 +261,8 @@ static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
 	 * guarantee the pinned page won't be randomly replaced in the
 	 * future on write faults.
 	 */
-	if (likely(!is_device_private_page(page) &&
-	    unlikely(page_needs_cow_for_dma(vma, page))))
+	if (likely(!is_device_private_page(page)) &&
+	    unlikely(page_needs_cow_for_dma(vma, page)))
 		return -EBUSY;
 
 	ClearPageAnonExclusive(page);
