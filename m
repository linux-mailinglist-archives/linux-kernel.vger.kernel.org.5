Return-Path: <linux-kernel+bounces-6513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D392F8199D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D9BB224F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB932168C4;
	Wed, 20 Dec 2023 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eTgT4jLA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101E15AFF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1f5004a09f0c11eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zWnIxvvt9i9Arc7rR/Bktc59NaeLptNqSNuvQsls8/s=;
	b=eTgT4jLA87EuL8ZD2Xc5k1/KIXqXnUPNmvI5RRYrSTyHXXl7Nf+3mbe6IQeeutC31Hz4+rfhf0VDl7jz0xxIEam6In3creyP8txNSXs/h2IgStMj0MrH59OhVy5RVrhmB0acvPMr0iNaKUHHGsmMrOjE1ZnD6gJ427S4qiUnHtE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:bdd8cb7b-dc44-4d0a-b6b9-8fd9036d6d26,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:f7edf881-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1f5004a09f0c11eeba30773df0976c77-20231220
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <kuan-ying.lee@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 91579362; Wed, 20 Dec 2023 15:48:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 15:48:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 15:48:09 +0800
From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To: Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <casper.li@mediatek.com>, <chinwen.chang@mediatek.com>,
	<qun-wei.lin@mediatek.com>, <linux-mm@kvack.org>, Kuan-Ying Lee
	<Kuan-Ying.Lee@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mm: page_alloc: remove duplication of free_one_page()
Date: Wed, 20 Dec 2023 15:47:56 +0800
Message-ID: <20231220074757.3656-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.042100-8.000000
X-TMASE-MatchedRID: JWnFpJnSkzs5HWa1kxc3Mc36paW7ZnFoBCxvLPUx407fUZT83lbkEK1r
	wNdVdYipgrCec5Bjx+qAMuqetGVetnyef22ep6XYro1URZJFbJvd1KJkmiEcSkExS0sIXgpfF27
	mDyBvZ5CSjwm7NH6qsNECzCqMxVGBuUqn/hcBctSNWcj5w63xsn8wdqmWSBW9n1s5w+bk2xuOh+
	wyNBrFXDJiNuKohDcKzKSG3JdyKAPqtV2AGMNPavWdclq8lU1q
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.042100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F5135FF66DB980116838C225763DDE80253B6A99B2BB8055C0B14DC95FFE14C42000:8
X-MTK: N

Remove duplication of free_one_page().

Cc: Casper Li <casper.li@mediatek.com>
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/page_alloc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2f646773a934..f46af8616cac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1262,7 +1262,6 @@ static void free_one_page(struct zone *zone,
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags)
 {
-	unsigned long flags;
 	int migratetype;
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
@@ -1277,13 +1276,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	 */
 	migratetype = get_pfnblock_migratetype(page, pfn);
 
-	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
-	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
-	spin_unlock_irqrestore(&zone->lock, flags);
+	free_one_page(zone, page, pfn, order, migratetype, fpi_flags);
 
 	__count_vm_events(PGFREE, 1 << order);
 }
-- 
2.18.0


