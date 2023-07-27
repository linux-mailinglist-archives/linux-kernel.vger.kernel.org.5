Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA47646D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjG0G33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0G32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:29:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19A1FC4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:29:20 -0700 (PDT)
X-UUID: e9bf20422c4611ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HVj27kBDVpPvZ+j4dkr5RIuiJz1r0HErENAsJMpj6ng=;
        b=tj+XxvzvVKQqp4VEbm1pCbjkR0B2LfxdiN/GXsGp7S++KvdCOrDDoRbUdPH8oG2lgCtG//3WMwTZ/GOuDSrjsrAVow/viUZ2/axaZOYhXIhsFwf4Y7Nf/Sb1tl2b1s93QhjH6PxFsnNusGIiQMTh+nR2IzCLCCmwSRxfe0AJvd4=;
X-CID-CACHE: Type:Local,Time:202307271429+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:ad4990f3-2b3c-4715-848b-f9457ef32fab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:e7562a7,CLOUDID:364ad8b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e9bf20422c4611ee9cb5633481061a41-20230727
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <andrew.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1091215193; Thu, 27 Jul 2023 14:29:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 14:29:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 14:29:13 +0800
From:   Andrew Yang <andrew.yang@mediatek.com>
To:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <wsd_upstream@mediatek.com>, <casper.li@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] zsmalloc: Fix races between modifications of fullness and isolated
Date:   Thu, 27 Jul 2023 14:29:07 +0800
Message-ID: <20230727062910.6337-1-andrew.yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fullness and isolated share the same unsigned int,
modifications of them should be protected by the same lock.

Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for migration")
---
v2: Moving comment too
---
 mm/zsmalloc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 32f5bc4074df..b58f957429f0 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1777,6 +1777,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
 	/*
@@ -1786,9 +1787,10 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	pool = zspage->pool;
+	spin_lock(&pool->lock);
 	inc_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&pool->lock);
 
 	return true;
 }
@@ -1854,12 +1856,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
+	dec_zspage_isolation(zspage);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
 	 * it's okay to release the pool's lock.
 	 */
 	spin_unlock(&pool->lock);
-	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
 
 	get_page(newpage);
@@ -1876,14 +1878,16 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 static void zs_page_putback(struct page *page)
 {
+	struct zs_pool *pool;
 	struct zspage *zspage;
 
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	migrate_write_lock(zspage);
+	pool = zspage->pool;
+	spin_lock(&pool->lock);
 	dec_zspage_isolation(zspage);
-	migrate_write_unlock(zspage);
+	spin_unlock(&pool->lock);
 }
 
 static const struct movable_operations zsmalloc_mops = {
-- 
2.18.0

