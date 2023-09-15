Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBE17A1BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjIOKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOKRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:17:55 -0400
Received: from out-212.mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA677E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:17:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694773067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=W4OXJL+60MT/EpFD3EhGCH+RY9u8YTytGadp3nozILg=;
        b=d+A5SamuPrYPNNn5I5tuWu15eKBGHtzGvFPIOVyX5iIJHBTtNqpTcrJ4kHMGFctF3C1GHl
        /nJLrNcJGp9LFBxZV2o50jGkbr8XPT0xca3odbgRo54CViZ/Apqqnu/I8er1HP8kEwZ4VG
        QphZ2hyKu976OWwgN6KYRxN1dI4RYJw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/rmap: convert __page_check_anon_rmap() to folio
Date:   Fri, 15 Sep 2023 18:17:31 +0800
Message-Id: <20230915101731.1725986-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter page in __page_check_anon_rmap() is redundant. Remove it,
and convert __page_check_anon_rmap() to __folio_check_anon_rmap().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/rmap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 789a2beb8b3a..520607f4d91c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1154,13 +1154,12 @@ static void __folio_set_anon(struct folio *folio, struct vm_area_struct *vma,
 }
 
 /**
- * __page_check_anon_rmap - sanity check anonymous rmap addition
+ * __folio_check_anon_rmap - sanity check anonymous rmap addition
  * @folio:	The folio containing @page.
- * @page:	the page to check the mapping of
  * @vma:	the vm area in which the mapping is added
  * @address:	the user virtual address mapped
  */
-static void __page_check_anon_rmap(struct folio *folio, struct page *page,
+static void __folio_check_anon_rmap(struct folio *folio,
 	struct vm_area_struct *vma, unsigned long address)
 {
 	/*
@@ -1176,8 +1175,8 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 	 */
 	VM_BUG_ON_FOLIO(folio_anon_vma(folio)->root != vma->anon_vma->root,
 			folio);
-	VM_BUG_ON_PAGE(page_to_pgoff(page) != linear_page_index(vma, address),
-		       page);
+	VM_BUG_ON_FOLIO(folio_pgoff(folio) != linear_page_index(vma, address),
+		       folio);
 }
 
 /**
@@ -1245,7 +1244,7 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
 		__folio_set_anon(folio, vma, address,
 				 !!(flags & RMAP_EXCLUSIVE));
 	} else if (likely(!folio_test_ksm(folio))) {
-		__page_check_anon_rmap(folio, page, vma, address);
+		__folio_check_anon_rmap(folio, vma, address);
 	}
 	if (flags & RMAP_EXCLUSIVE)
 		SetPageAnonExclusive(page);
-- 
2.25.1

