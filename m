Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F65785BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbjHWPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjHWPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:14:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B26E71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:14:02 -0700 (PDT)
X-UUID: ad2590bc41c711eeb20a276fd37b9834-20230823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cHATK6viKkGDZhKywYn8zN66A3OsF3Nqsyx9GSoHCCM=;
        b=VEGrz0j90CoT0D8M6J3KzAu7/XL1f75VEJ0yRAwOOYB4pJxwr9sccBRGhW9f4gtAB8apKpa366slx71H4dWFb261DducW98KMQToJa6DANWjoROZ3/pc/CsBBlvfQqi5jC+yQ2LSiEpp1WwBnbFXzQ9rvfrAbJADEtyIuhyzLjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:48ac8acf-4a1c-41f7-b162-993f40702b95,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:7c271b13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: ad2590bc41c711eeb20a276fd37b9834-20230823
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <shawn.sung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 529386914; Wed, 23 Aug 2023 23:13:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Aug 2023 23:13:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Aug 2023 23:13:54 +0800
From:   Hsiao Chien Sung <shawn.sung@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Hsiao Chien Sung <shawn.sung@mediatek.com>
Subject: [PATCH 11/15] drm/mediatek: Support CRC in VDOSYS0
Date:   Wed, 23 Aug 2023 23:13:28 +0800
Message-ID: <20230823151332.28811-12-shawn.sung@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230823151332.28811-1-shawn.sung@mediatek.com>
References: <20230823151332.28811-1-shawn.sung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We choose OVL as CRC generator from other hardware
components that are also capable of calculating CRCs,
since its frame done event triggers vblanks, it can be
used as a signal to know when is safe to retrieve CRC of
the frame.

Please note that position of the hardware component
that is chosen as CRC generator in the display path is
significant. For example, while OVL is the first module
in VDOSYS0, its CRC won't be affected by the modules
after it, which means effects applied by PQ, Gamma,
Dither or any other components after OVL won't be
calculated in CRC generation.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 121 +++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   1 +
 3 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 2254038519e1..d2753360ae1e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -100,6 +100,7 @@ void mtk_ovl_enable_vblank(struct device *dev);
 void mtk_ovl_disable_vblank(struct device *dev);
 const u32 *mtk_ovl_get_formats(struct device *dev);
 size_t mtk_ovl_get_num_formats(struct device *dev);
+u32 mtk_ovl_crc_cnt(struct device *dev);
 
 void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex);
 void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 824f81291293..453db2de3e83 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -25,6 +25,13 @@
 #define OVL_FME_CPL_INT					BIT(1)
 #define DISP_REG_OVL_INTSTA			0x0008
 #define DISP_REG_OVL_EN				0x000c
+#define OVL_EN						BIT(0)
+#define OVL_OP_8BIT_MODE				BIT(4)
+#define OVL_HG_FOVL_CK_ON				BIT(8)
+#define OVL_HF_FOVL_CK_ON				BIT(10)
+#define DISP_REG_OVL_TRIG			0x0010
+#define OVL_CRC_EN					BIT(8)
+#define OVL_CRC_CLR					BIT(9)
 #define DISP_REG_OVL_RST			0x0014
 #define DISP_REG_OVL_ROI_SIZE			0x0020
 #define DISP_REG_OVL_DATAPATH_CON		0x0024
@@ -44,6 +51,8 @@
 #define DISP_REG_OVL_RDMA_CTRL(n)		(0x00c0 + 0x20 * (n))
 #define DISP_REG_OVL_RDMA_GMC(n)		(0x00c8 + 0x20 * (n))
 #define DISP_REG_OVL_ADDR_MT2701		0x0040
+#define DISP_REG_OVL_CRC			0x0270
+#define OVL_CRC_OUT_MASK				GENMASK(30, 0)
 #define DISP_REG_OVL_CLRFMT_EXT			0x02D0
 #define DISP_REG_OVL_CLRFMT_EXT1		0x02D8
 #define OVL_CLRFMT_EXT1_CSC_EN(n)			(1 << ((n) * 4 + 1))
@@ -151,6 +160,10 @@ static const u32 mt8195_formats[] = {
 	DRM_FORMAT_YUYV,
 };
 
+static const u32 mt8195_ovl_crcs[] = {
+	DISP_REG_OVL_CRC,
+};
+
 struct mtk_disp_ovl_data {
 	unsigned int addr;
 	unsigned int gmc_bits;
@@ -161,6 +174,8 @@ struct mtk_disp_ovl_data {
 	const u32 *formats;
 	size_t num_formats;
 	bool supports_clrfmt_ext;
+	const u32 *crcs;
+	size_t crc_cnt;
 };
 
 /*
@@ -176,8 +191,82 @@ struct mtk_disp_ovl {
 	const struct mtk_disp_ovl_data	*data;
 	void				(*vblank_cb)(void *data);
 	void				*vblank_cb_data;
+	struct cmdq_client		*cmdq_client;
+	struct cmdq_pkt			*cmdq_pkt;
+	u32				cmdq_event;
 };
 
+u32 mtk_ovl_crc_cnt(struct device *dev)
+{
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+
+	return (u32)ovl->data->crc_cnt;
+}
+
+static void mtk_ovl_crc_loop_start(struct device *dev)
+{
+	int i;
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+	struct mtk_drm_crtc *mtk_crtc = container_of(ovl->crtc,
+						struct mtk_drm_crtc, base);
+
+	if (!ovl->cmdq_event || ovl->cmdq_client)
+		return;
+
+	ovl->cmdq_client = cmdq_mbox_create(dev, 0);
+	if (IS_ERR(ovl->cmdq_client)) {
+		pr_err("failed to create mailbox client\n");
+		return;
+	}
+
+	ovl->cmdq_pkt = cmdq_pkt_create(ovl->cmdq_client, PAGE_SIZE);
+	if (!ovl->cmdq_pkt) {
+		pr_err("failed to create cmdq packet\n");
+		return;
+	}
+
+	cmdq_pkt_wfe(ovl->cmdq_pkt, ovl->cmdq_event, true);
+
+	for (i = 0; i < ovl->data->crc_cnt; i++) {
+		/* put crc to spr1 register */
+		cmdq_pkt_read_s(ovl->cmdq_pkt, ovl->cmdq_reg.subsys,
+				ovl->data->crcs[i], CMDQ_THR_SPR_IDX1);
+		cmdq_pkt_assign(ovl->cmdq_pkt, CMDQ_THR_SPR_IDX0,
+				CMDQ_ADDR_HIGH(mtk_crtc->crc.pa + i * sizeof(u32)));
+
+		/* copy spr1 register to crc.pa */
+		cmdq_pkt_write_s(ovl->cmdq_pkt, CMDQ_THR_SPR_IDX0,
+				 CMDQ_ADDR_LOW(mtk_crtc->crc.pa + i * sizeof(u32)),
+				 CMDQ_THR_SPR_IDX1);
+	}
+
+	/* reset crc */
+	mtk_ddp_write_mask(ovl->cmdq_pkt, ~0, &ovl->cmdq_reg, ovl->regs,
+			   DISP_REG_OVL_TRIG, OVL_CRC_CLR);
+	/* clear reset bit */
+	mtk_ddp_write_mask(ovl->cmdq_pkt, 0, &ovl->cmdq_reg, ovl->regs,
+			   DISP_REG_OVL_TRIG, OVL_CRC_CLR);
+
+	cmdq_pkt_finalize_loop(ovl->cmdq_pkt);
+	cmdq_pkt_flush_async(ovl->cmdq_pkt);
+}
+
+static void mtk_ovl_crc_loop_stop(struct device *dev)
+{
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+
+	if (ovl->cmdq_pkt) {
+		cmdq_pkt_destroy(ovl->cmdq_pkt);
+		ovl->cmdq_pkt = NULL;
+	}
+
+	if (ovl->cmdq_client) {
+		mbox_flush(ovl->cmdq_client->chan, 2000);
+		cmdq_mbox_destroy(ovl->cmdq_client);
+		ovl->cmdq_client = NULL;
+	}
+}
+
 static irqreturn_t mtk_disp_ovl_irq_handler(int irq, void *dev_id)
 {
 	struct mtk_disp_ovl *priv = dev_id;
@@ -201,6 +290,7 @@ void mtk_ovl_register_vblank_cb(struct device *dev,
 
 	ovl->vblank_cb = vblank_cb;
 	ovl->vblank_cb_data = vblank_cb_data;
+	ovl->crtc = (struct drm_crtc *)vblank_cb_data;
 }
 
 void mtk_ovl_unregister_vblank_cb(struct device *dev)
@@ -216,14 +306,14 @@ void mtk_ovl_enable_vblank(struct device *dev)
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
 	writel(0x0, ovl->regs + DISP_REG_OVL_INTSTA);
-	writel_relaxed(OVL_FME_CPL_INT, ovl->regs + DISP_REG_OVL_INTEN);
+	writel(OVL_FME_CPL_INT, ovl->regs + DISP_REG_OVL_INTEN);
 }
 
 void mtk_ovl_disable_vblank(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
-	writel_relaxed(0x0, ovl->regs + DISP_REG_OVL_INTEN);
+	writel(0x0, ovl->regs + DISP_REG_OVL_INTEN);
 }
 
 const u32 *mtk_ovl_get_formats(struct device *dev)
@@ -258,6 +348,7 @@ void mtk_ovl_start(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 	unsigned int reg = 0;
+	unsigned int val = OVL_EN;
 
 	if (ovl->data->smi_id_en) {
 		reg = readl(ovl->regs + DISP_REG_OVL_DATAPATH_CON);
@@ -265,13 +356,22 @@ void mtk_ovl_start(struct device *dev)
 	}
 	reg |= OVL_OUTPUT_CLAMP;
 	writel_relaxed(reg, ovl->regs + DISP_REG_OVL_DATAPATH_CON);
-	writel_relaxed(0x1, ovl->regs + DISP_REG_OVL_EN);
+
+	if (ovl->data->crcs)
+		val |= OVL_OP_8BIT_MODE | OVL_HG_FOVL_CK_ON | OVL_HF_FOVL_CK_ON;
+
+	writel_relaxed(val, ovl->regs + DISP_REG_OVL_EN);
+	writel_relaxed(OVL_CRC_EN, ovl->regs + DISP_REG_OVL_TRIG);
+
+	mtk_ovl_crc_loop_start(dev);
 }
 
 void mtk_ovl_stop(struct device *dev)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
+	mtk_ovl_crc_loop_stop(dev);
+
 	writel_relaxed(0x0, ovl->regs + DISP_REG_OVL_EN);
 	if (ovl->data->smi_id_en) {
 		unsigned int reg;
@@ -321,7 +421,8 @@ void mtk_ovl_config(struct device *dev, unsigned int w,
 	if (w != 0 && h != 0)
 		mtk_ddp_write_relaxed(cmdq_pkt, h << 16 | w, &ovl->cmdq_reg, ovl->regs,
 				      DISP_REG_OVL_ROI_SIZE);
-	mtk_ddp_write_relaxed(cmdq_pkt, 0x0, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_ROI_BGCLR);
+	mtk_ddp_write_relaxed(cmdq_pkt, 0xff000000, &ovl->cmdq_reg, ovl->regs,
+			      DISP_REG_OVL_ROI_BGCLR);
 
 	mtk_ddp_write(cmdq_pkt, 0x1, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_RST);
 	mtk_ddp_write(cmdq_pkt, 0x0, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_RST);
@@ -677,6 +778,16 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 #endif
 
 	priv->data = of_device_get_match_data(dev);
+
+	if (priv->data->crcs) {
+		if (of_property_read_u32_index(dev->of_node,
+					       "mediatek,gce-events", 0,
+					       &priv->cmdq_event)) {
+			dev_err(dev, "failed to get gce-events\n");
+			return -ENOPARAM;
+		}
+	}
+
 	platform_set_drvdata(pdev, priv);
 
 	ret = devm_request_irq(dev, irq, mtk_disp_ovl_irq_handler,
@@ -771,6 +882,8 @@ static const struct mtk_disp_ovl_data mt8195_ovl_driver_data = {
 	.formats = mt8195_formats,
 	.num_formats = ARRAY_SIZE(mt8195_formats),
 	.supports_clrfmt_ext = true,
+	.crcs = mt8195_ovl_crcs,
+	.crc_cnt = ARRAY_SIZE(mt8195_ovl_crcs),
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index f114da4d36a9..1b747a34a06b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -347,6 +347,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl = {
 	.clk_enable = mtk_ovl_clk_enable,
 	.clk_disable = mtk_ovl_clk_disable,
 	.config = mtk_ovl_config,
+	.crc_cnt = mtk_ovl_crc_cnt,
 	.start = mtk_ovl_start,
 	.stop = mtk_ovl_stop,
 	.register_vblank_cb = mtk_ovl_register_vblank_cb,
-- 
2.18.0

