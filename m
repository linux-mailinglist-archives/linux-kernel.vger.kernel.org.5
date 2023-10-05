Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F77B99D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbjJEBwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbjJEBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:52:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F68CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:52:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2DAC433CC;
        Thu,  5 Oct 2023 01:52:42 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qoDYk-005FIy-3B;
        Wed, 04 Oct 2023 21:53:50 -0400
Message-ID: <20231005015350.799850910@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 04 Oct 2023 21:53:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: [for-next][PATCH 2/7] ring_buffer: Use try_cmpxchg instead of cmpxchg in rb_insert_pages
References: <20231005015310.859143353@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
rb_insert_pages. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Link: https://lore.kernel.org/linux-trace-kernel/20230914163420.12923-1-ubizjak@gmail.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 515cafdb18d9..43cc47d7faaf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2056,7 +2056,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	retries = 10;
 	success = false;
 	while (retries--) {
-		struct list_head *head_page, *prev_page, *r;
+		struct list_head *head_page, *prev_page;
 		struct list_head *last_page, *first_page;
 		struct list_head *head_page_with_bit;
 		struct buffer_page *hpage = rb_set_head_page(cpu_buffer);
@@ -2075,9 +2075,9 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 		last_page->next = head_page_with_bit;
 		first_page->prev = prev_page;
 
-		r = cmpxchg(&prev_page->next, head_page_with_bit, first_page);
-
-		if (r == head_page_with_bit) {
+		/* caution: head_page_with_bit gets updated on cmpxchg failure */
+		if (try_cmpxchg(&prev_page->next,
+				&head_page_with_bit, first_page)) {
 			/*
 			 * yay, we replaced the page pointer to our new list,
 			 * now, we just have to update to head page's prev
-- 
2.40.1
