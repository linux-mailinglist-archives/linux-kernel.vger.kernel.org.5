Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C966783462
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjHUUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjHUUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:52:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC0172C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XRi9y87QqXh4JZ1r/Njdw8M+xnng3qBCOABUAXt/gvk=; b=tLZ3qEXllptACApUZPH235uOkb
        aThCwnrkMLDWUHcF9GtWTqx3jKpPdBX4/PfR8p0avHhtlsbSI7K0SOA87zZo19o0xFiisQoDR9zmy
        yukem8YeS7ZPMv1v/XH3oCQIO+Ch64oLqjVTBRjuL2ACD2r1fKNxBjovhH16h42r28DEl5pzvNwUR
        NcfxgknnO1iWC0NnDPkrK+5gqa6mFnQx5bN8HMY7Uu2ZNlNK6X4WjGNubRiac+NWyzcijOPUcV4eH
        NBphd5Z7PmwM1uyl/DYOTuxF+ZwSJDUI99VbMKZbbtJsX3fSJlZT8pINjV0KwTHd0mARG+4f0LapW
        dRaj01nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlF-00CL0U-Mc; Mon, 21 Aug 2023 20:44:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 6/7] mm: Remove use of folio list from folios_put()
Date:   Mon, 21 Aug 2023 21:44:24 +0100
Message-Id: <20230821204425.2940496-6-willy@infradead.org>
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

Instead of putting the interesting folios on a list, delete the
uninteresting one from the folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 9d31185dc27b..8ebb10d44de7 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -958,12 +958,11 @@ void lru_cache_disable(void)
  */
 void folios_put(struct folio_batch *folios)
 {
-	int i;
-	LIST_HEAD(pages_to_free);
+	int i, j;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 
-	for (i = 0; i < folios->nr; i++) {
+	for (i = 0, j = 0; i < folios->nr; i++) {
 		struct folio *folio = folios->folios[i];
 
 		if (is_huge_zero_page(&folio->page))
@@ -1012,13 +1011,18 @@ void folios_put(struct folio_batch *folios)
 			count_vm_event(UNEVICTABLE_PGCLEARED);
 		}
 
-		list_add(&folio->lru, &pages_to_free);
+		if (j != i)
+			folios->folios[j] = folio;
+		j++;
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
+	folios->nr = j;
+	if (!j)
+		return;
 
-	mem_cgroup_uncharge_list(&pages_to_free);
-	free_unref_page_list(&pages_to_free);
+	mem_cgroup_uncharge_batch(folios);
+	free_unref_folios(folios);
 }
 EXPORT_SYMBOL(folios_put);
 
-- 
2.40.1

