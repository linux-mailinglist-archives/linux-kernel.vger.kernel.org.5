Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6316A783445
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjHUUpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHUUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98191731
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pSrtzJTe3IU8p+1cAoPm0gIDtB8SqdaEhhREkvHFPcI=; b=Ceq6MGoywPDgt/xWZ3yRxd/WSL
        RkzO1yVGelML9XeqBKiR4+8SdApxY7F+p7ljHaoG0D6HLhXJ/sG+nrVXduVmXoAnrfZEpqL80lGco
        PoD2MLxNIaGzT2hN7NjKhPe5egBOm4TJfy5VI1r7rVR9CmQKcSySZHP3AUk2xjdkJ77tCaAyHS0vx
        ib8C07J9p0tmPvrdpd8PxYCPF2p/XZzUiI4BGZZXoZlZbjFfdiSg/7BiSvdoFBaKTt3KLueh+mhML
        4uATzCFca0yv3rmigKvdTN8NCsXT3KZJSUPYy4NcdFmF/mR/U4BIKVyhYr4O78PyWou7n71PDyXbO
        kuyzOn5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlF-00CL0b-Tr; Mon, 21 Aug 2023 20:44:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 7/7] mm: Use free_unref_folios() in put_pages_list()
Date:   Mon, 21 Aug 2023 21:44:25 +0100
Message-Id: <20230821204425.2940496-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821204425.2940496-1-willy@infradead.org>
References: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
 <20230821204425.2940496-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break up the list of folios into batches here so that the
folios are more likely to be cache hot when doing the
rest of the processing.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 8ebb10d44de7..51a613f477a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -138,22 +138,26 @@ EXPORT_SYMBOL(__folio_put);
  */
 void put_pages_list(struct list_head *pages)
 {
-	struct folio *folio, *next;
+	struct folio_batch fbatch;
+	struct folio *folio;
 
-	list_for_each_entry_safe(folio, next, pages, lru) {
-		if (!folio_put_testzero(folio)) {
-			list_del(&folio->lru);
+	folio_batch_init(&fbatch);
+	list_for_each_entry(folio, pages, lru) {
+		if (!folio_put_testzero(folio))
 			continue;
-		}
 		if (folio_test_large(folio)) {
-			list_del(&folio->lru);
 			__folio_put_large(folio);
 			continue;
 		}
 		/* LRU flag must be clear because it's passed using the lru */
+		if (folio_batch_add(&fbatch, folio) > 0)
+			continue;
+		free_unref_folios(&fbatch);
+		fbatch.nr = 0;
 	}
 
-	free_unref_page_list(pages);
+	if (fbatch.nr)
+		free_unref_folios(&fbatch);
 	INIT_LIST_HEAD(pages);
 }
 EXPORT_SYMBOL(put_pages_list);
-- 
2.40.1

