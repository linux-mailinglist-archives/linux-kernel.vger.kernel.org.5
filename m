Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9779B0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354184AbjIKVwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjIKM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:59:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCDBE40;
        Mon, 11 Sep 2023 05:59:50 -0700 (PDT)
X-UUID: 14c0c5c250a311ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CPMWACJAgviKQmxWnosmzeeZGzhy0KOH7WEjCylhAbA=;
        b=UXrlXGnLtlvmK/Ecl0mGTFJZNqLesmpcXlsLvHcOQGs3HCRSgUGtC0n0nQRP6tjhvz1TSrV26aDflrIBrUiwbiXwpoVnCB9ov62gQVe9wc1BzpnU4x7Mixh0Cvis4+IcWixwuqGpUp2b+kLlDugHzo7vSKTaM4fzGkSsR4yZnkk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:93868120-3ad3-4977-87d1-055a39356b7a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:ba17b4be-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 14c0c5c250a311ee8051498923ad61e6-20230911
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1323316282; Mon, 11 Sep 2023 20:59:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:43 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:42 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
CC:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Steve Cho" <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 05/14] media: mediatek: vcodec: using encoder's device to alloc/free memory
Date:   Mon, 11 Sep 2023 20:59:27 +0800
Message-ID: <20230911125936.10648-6-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911125936.10648-1-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.085200-8.000000
X-TMASE-MatchedRID: zZxKUkmlWrQ/IVzSvtxQYQI0yP/uoH+DxKAxBgoYewn2MjGUf5GHscRr
        vjvFKTaxteurRsMx+tiioN2/kJflOJCoy9iDotiwDB+ErBr0bAMoUVkB7ifJngFfXDffRHpWo8W
        MkQWv6iXBcIE78YqRWvcUt5lc1lLgjMejjvPkBr48VX82z7b6LJCqOkDtL4siGdAHOCGgtWJQ+s
        FRlQzcIsYGgHVcQ3yHEgBWaZYZAD/VgtwXM1+7jEdjxzx4+7OW49jp+6BdmVYc/j4aI5S1Lnr9G
        D0zfOvEAaqvv/mhgrEIcy9ODq9nmVZca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.085200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0048BDD6841D6C775C768961CDCE27A7FD85A2B3FAE2FF121962545F219E47C02000:8
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

Using encoder's device to allocate/free secure memory calling:
mtk_vcodec_mem_alloc/mtk_vcodec_mem_free, not decoder's.

'Fixes: 01abf5fbb081c ("media: mediatek: vcodec: separate struct 'mtk_vcodec_ctx'")'
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 66 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 908602031fd0..62bb7290c56d 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -45,7 +45,7 @@ int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg,
 }
 EXPORT_SYMBOL(mtk_vcodec_write_vdecsys);
 
-int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
+static int mtk_vcodec_mem_dec_alloc(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
 	struct mtk_vcodec_dec_ctx *ctx = priv;
@@ -64,9 +64,39 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 
 	return 0;
 }
+
+static int mtk_vcodec_mem_enc_alloc(void *priv, struct mtk_vcodec_mem *mem)
+{
+	unsigned long size = mem->size;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
+	struct device *dev = &ctx->dev->plat_dev->dev;
+
+	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
+	if (!mem->va) {
+		mtk_v4l2_venc_err(ctx, "%s dma_alloc size=%ld failed!", dev_name(dev), size);
+		return -ENOMEM;
+	}
+
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]  - va      = %p", ctx->id, mem->va);
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]  - dma     = 0x%lx", ctx->id,
+			  (unsigned long)mem->dma_addr);
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]    size = 0x%lx", ctx->id, size);
+
+	return 0;
+}
+
+int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
+{
+	enum mtk_instance_type inst_type = *((unsigned int *)priv);
+
+	if (inst_type == MTK_INST_ENCODER)
+		return mtk_vcodec_mem_enc_alloc(priv, mem);
+	else
+		return mtk_vcodec_mem_dec_alloc(priv, mem);
+}
 EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
 
-void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
+static void mtk_vcodec_mem_dec_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
 	struct mtk_vcodec_dec_ctx *ctx = priv;
@@ -87,6 +117,38 @@ void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
 	mem->dma_addr = 0;
 	mem->size = 0;
 }
+
+static void mtk_vcodec_mem_enc_free(void *priv, struct mtk_vcodec_mem *mem)
+{
+	unsigned long size = mem->size;
+	struct mtk_vcodec_enc_ctx *ctx = priv;
+	struct device *dev = &ctx->dev->plat_dev->dev;
+
+	if (!mem->va) {
+		mtk_v4l2_venc_err(ctx, "%s dma_free size=%ld failed!", dev_name(dev), size);
+		return;
+	}
+
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]  - va      = %p", ctx->id, mem->va);
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]  - dma     = 0x%lx", ctx->id,
+			  (unsigned long)mem->dma_addr);
+	mtk_v4l2_venc_dbg(3, ctx, "[%d]    size = 0x%lx", ctx->id, size);
+
+	dma_free_coherent(dev, size, mem->va, mem->dma_addr);
+	mem->va = NULL;
+	mem->dma_addr = 0;
+	mem->size = 0;
+}
+
+void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
+{
+	enum mtk_instance_type inst_type = *((unsigned int *)priv);
+
+	if (inst_type == MTK_INST_ENCODER)
+		mtk_vcodec_mem_enc_free(priv, mem);
+	else
+		mtk_vcodec_mem_dec_free(priv, mem);
+}
 EXPORT_SYMBOL(mtk_vcodec_mem_free);
 
 void *mtk_vcodec_get_hw_dev(struct mtk_vcodec_dec_dev *dev, int hw_idx)
-- 
2.18.0

