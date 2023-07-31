Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA50E769593
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGaMGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGaMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:06:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BE1728
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:05:53 -0700 (PDT)
X-UUID: 966417702f9a11eeb20a276fd37b9834-20230731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=C6CrSBdjoAyzVpB6u/w8qzO48wNDLvceWe2rRQBmWzY=;
        b=dkhSndMqGlZ9VYhEzuPygaPnNLY9kuMGzrE1CW1EF5p95rcnNJCh3NNOPBMSAulzKmf6KTd30rHaRdqPE7z9Di4S6NqY9EuQsAue8GtsE+tZI3xErMmWtZWu9awXTNE8rGnAhFU/j7xLogUg32HLadMU65hG/BzHrDtnSVY4PUw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:e10c6e47-7cf2-4c21-9392-b58fe3e93d76,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:1fcc6f8,CLOUDID:c39bfbb3-a467-4aa9-9e04-f584452e3794,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 966417702f9a11eeb20a276fd37b9834-20230731
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1546789419; Mon, 31 Jul 2023 20:05:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 31 Jul 2023 20:05:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 31 Jul 2023 20:05:47 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] arm: kasan: Use memblock_alloc_try_nid_raw for shadow page allocation
Date:   Mon, 31 Jul 2023 20:05:36 +0800
Message-ID: <20230731120537.13152-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_pte_populate fill KASAN_SHADOW_INIT in the newly
allocated shadow page, so it's unnecessary to
use memblock_alloc_try_nid, which always zero the
new allocated memory.

Use memblock_alloc_try_nid_raw instead of
memblock_alloc_try_nid like arm64 does which
can make kasan init faster.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 arch/arm/mm/kasan_init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 24d71b5db62d..111d4f703136 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -28,6 +28,12 @@ static pgd_t tmp_pgd_table[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
 
 pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
 
+static __init void *kasan_alloc_block_raw(size_t size)
+{
+	return memblock_alloc_try_nid_raw(size, size, __pa(MAX_DMA_ADDRESS),
+				      MEMBLOCK_ALLOC_NOLEAKTRACE, NUMA_NO_NODE);
+}
+
 static __init void *kasan_alloc_block(size_t size)
 {
 	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
@@ -50,7 +56,7 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 			if (!pte_none(READ_ONCE(*ptep)))
 				continue;
 
-			p = kasan_alloc_block(PAGE_SIZE);
+			p = kasan_alloc_block_raw(PAGE_SIZE);
 			if (!p) {
 				panic("%s failed to allocate shadow page for address 0x%lx\n",
 				      __func__, addr);
-- 
2.18.0

