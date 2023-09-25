Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1DA7AD8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjIYNRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIYNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:17:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4887FE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:34 -0700 (PDT)
X-UUID: e0a73a565ba511ee8051498923ad61e6-20230925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6cnfI5ytzDCvg+dOj6lTpy2XkiFT0LZU5C3nD7lJxK8=;
        b=kKPDUhqHDfjVpJYyjDBiYY/bZMVvJqSEKdOESTe5uUshKX11md0XKsjOriiCmfJYHs5C1r2u2rMvCdhA+ReP52TFOhF/uJ57xny+/Ij2wnCxwr1XM7K+Yyp7/+PqCy5is0+zBnJSiPvUrSp+fCJ6/FyjTuJgo+vaQqLfp4Ydr9o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3f2a2951-c247-495f-8481-6456795d22d9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:43461cf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e0a73a565ba511ee8051498923ad61e6-20230925
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 191219675; Mon, 25 Sep 2023 21:17:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 25 Sep 2023 21:17:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 25 Sep 2023 21:17:27 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <yj.chiang@mediatek.com>, <robin.murphy@arm.com>,
        <xuewen.yan@unisoc.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2] ARM: vfp: Add missing VFP instructions to neon_support_hook
Date:   Mon, 25 Sep 2023 21:17:19 +0800
Message-ID: <20230925131720.7672-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing "Unconditional Advanced SIMD and floating-point
instructions" in [1] to the VFP undef hook.

This commit addresses the issue reported in [2], where
executing the vudot instruction on a platform with FEAT_DotProd
support resulted in an undefined instruction error.

Link: https://developer.arm.com/documentation/ddi0597/2023-06/?lang=en [1]
Link: https://lore.kernel.org/lkml/20230920083907.30479-1-mark-pk.tsai@mediatek.com/ [2]
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 arch/arm/vfp/vfpmodule.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 7e8773a2d99d..b68efe643a12 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -800,6 +800,24 @@ static struct undef_hook neon_support_hook[] = {{
 	.cpsr_mask	= PSR_T_BIT,
 	.cpsr_val	= PSR_T_BIT,
 	.fn		= vfp_support_entry,
+}, {
+	.instr_mask	= 0xff000800,
+	.instr_val	= 0xfc000800,
+	.cpsr_mask	= 0,
+	.cpsr_val	= 0,
+	.fn		= vfp_support_entry,
+}, {
+	.instr_mask	= 0xff000800,
+	.instr_val	= 0xfd000800,
+	.cpsr_mask	= 0,
+	.cpsr_val	= 0,
+	.fn		= vfp_support_entry,
+}, {
+	.instr_mask	= 0xff000800,
+	.instr_val	= 0xfe000800,
+	.cpsr_mask	= 0,
+	.cpsr_val	= 0,
+	.fn		= vfp_support_entry,
 }};
 
 static struct undef_hook vfp_support_hook = {
-- 
2.18.0

