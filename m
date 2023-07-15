Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951457546D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGOEYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGOEX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:23:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E4835A9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KykWwNFW2V5pOcZKvJr7OCs/yVc8LncYJ9HLsA6CPzQ=; b=jimt36fM3V2iDkBnN5O5trWSrN
        FlJBU1FP9iOdaPzGGDEwRK0PQkIz+abiL64QteduGF4avMCfp/sqSib/NlWF1uIEUt/IO1EvMFhW8
        AZN/J89Ziu1jEY6N+WGhB2NKc7yI/U1k5bkfFpGbGaVGHVnDBKuIkPggMndS8IJ0zV+meTRlIsyk6
        Sb+YVmtMbBk7CEF9Bhl5ErBDCP8IB0fkHQ0wK7q9TxU+yKgtSHi4djyP5TITP9aaY3An8fbZja4tw
        GqP8YcETFt2VMwO64AwsUDCF9R+HhaJCX6t08E5D12BU9qrlv98oNS2nymFr0bWg8gX8NRenLOcir
        TC8VPDyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3u-Ii; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 4/5] swap: Remove some calls to compound_head() in swap_readpage()
Date:   Sat, 15 Jul 2023 05:23:42 +0100
Message-Id: <20230715042343.434588-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230715042343.434588-1-willy@infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <20230715042343.434588-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace six implicit calls to compound_head() with one call to
page_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page_io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index b9fda7fb4e75..e5b6f1402506 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -495,14 +495,15 @@ static void swap_readpage_bdev_async(struct page *page,
 
 void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 {
+	struct folio *folio = page_folio(page);
 	struct swap_info_struct *sis = page_swap_info(page);
-	bool workingset = PageWorkingset(page);
+	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
 
-	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(PageUptodate(page), page);
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
 	/*
 	 * Count submission time as memory stall and delay. When the device
@@ -516,8 +517,8 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 	delayacct_swapin_start();
 
 	if (zswap_load(page)) {
-		SetPageUptodate(page);
-		unlock_page(page);
+		folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_readpage_fs(page, plug);
 	} else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
-- 
2.39.2

