Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9979BD13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbjIKVLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbjIKM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:59:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F04DE58;
        Mon, 11 Sep 2023 05:59:51 -0700 (PDT)
X-UUID: 15066e7e50a311ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=j6bBjs0ZaTsm2hx93sdo83qPGubxS6EmozJAA1dFYg8=;
        b=duH2qBQDBWFIa+2fivxZSy5K1YqJ8pswihW4fxBsrhs5pNdafBb7WN9kPOTTcJeDgh7M/BdElviKWFIGtxJY3ChrQREETZ8pfEh2M31CpRxyeYS5I4+QqcAuVpJXBBd0mOOeX+qbF0GM2eWR5wGWRxM98sLWxyMj0p1edoJqbHA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:8229e5ce-3dd0-4764-b7f4-a6c72b92d236,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:2c3fce13-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 15066e7e50a311ee8051498923ad61e6-20230911
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 829643934; Mon, 11 Sep 2023 20:59:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:43 +0800
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
        Steve Cho <stevecho@chromium.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 06/14] media: mediatek: vcodec: add interface to allocate/free secure memory
Date:   Mon, 11 Sep 2023 20:59:28 +0800
Message-ID: <20230911125936.10648-7-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911125936.10648-1-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Need to call dma heap interface to allocate/free secure memory when playing
secure video.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mediatek/vcodec/Kconfig    |   1 +
 .../mediatek/vcodec/common/mtk_vcodec_util.c  | 123 ++++++++++++++++--
 .../mediatek/vcodec/common/mtk_vcodec_util.h  |   3 +
 3 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/Kconfig b/drivers/media/platform/mediatek/vcodec/Kconfig
index 74b00eb1bc97..182fd95c9fda 100644
--- a/drivers/media/platform/mediatek/vcodec/Kconfig
+++ b/drivers/media/platform/mediatek/vcodec/Kconfig
@@ -17,6 +17,7 @@ config VIDEO_MEDIATEK_VCODEC
 	depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
 	depends on MTK_SCP || !MTK_SCP
 	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
+	depends on DMABUF_HEAPS
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
 	select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
index 62bb7290c56d..9bac6a90c5c5 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c
@@ -8,6 +8,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
+#include <linux/dma-heap.h>
+#include <uapi/linux/dma-heap.h>
 
 #include "../decoder/mtk_vcodec_dec_drv.h"
 #include "../encoder/mtk_vcodec_enc_drv.h"
@@ -45,11 +47,11 @@ int mtk_vcodec_write_vdecsys(struct mtk_vcodec_dec_ctx *ctx, unsigned int reg,
 }
 EXPORT_SYMBOL(mtk_vcodec_write_vdecsys);
 
-static int mtk_vcodec_mem_dec_alloc(void *priv, struct mtk_vcodec_mem *mem)
+static int mtk_vcodec_mem_dec_alloc_nor(struct mtk_vcodec_dec_ctx *ctx,
+					struct mtk_vcodec_mem *mem)
 {
-	unsigned long size = mem->size;
-	struct mtk_vcodec_dec_ctx *ctx = priv;
 	struct device *dev = &ctx->dev->plat_dev->dev;
+	unsigned long size = mem->size;
 
 	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
@@ -57,12 +59,89 @@ static int mtk_vcodec_mem_dec_alloc(void *priv, struct mtk_vcodec_mem *mem)
 		return -ENOMEM;
 	}
 
+	return 0;
+}
+
+static int mtk_vcodec_mem_dec_alloc_sec(struct mtk_vcodec_dec_ctx *ctx,
+					struct mtk_vcodec_mem *mem)
+{
+	struct device *dev = &ctx->dev->plat_dev->dev;
+	struct dma_buf *dma_buffer;
+	struct dma_heap *vdec_heap;
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
+	unsigned long size = mem->size;
+	int ret = 0;
+
+	if (!size)
+		return -EINVAL;
+
+	vdec_heap = dma_heap_find("mtk_svp");
+	if (!vdec_heap) {
+		mtk_v4l2_vdec_err(ctx, "dma heap find failed!");
+		return -EPERM;
+	}
+
+	dma_buffer = dma_heap_buffer_alloc(vdec_heap, size, DMA_HEAP_VALID_FD_FLAGS,
+					   DMA_HEAP_VALID_HEAP_FLAGS);
+	if (IS_ERR_OR_NULL(dma_buffer)) {
+		mtk_v4l2_vdec_err(ctx, "dma heap alloc size=0x%lx failed!", size);
+		return PTR_ERR(dma_buffer);
+	}
+
+	attach = dma_buf_attach(dma_buffer, dev);
+	if (IS_ERR_OR_NULL(attach)) {
+		mtk_v4l2_vdec_err(ctx, "dma attach size=0x%lx failed!", size);
+		ret = PTR_ERR(attach);
+		goto err_attach;
+	}
+
+	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR_OR_NULL(sgt)) {
+		mtk_v4l2_vdec_err(ctx, "dma map attach size=0x%lx failed!", size);
+		ret = PTR_ERR(sgt);
+		goto err_sgt;
+	}
+
+	mem->va = dma_buffer;
+	mem->dma_addr = (dma_addr_t)sg_dma_address((sgt)->sgl);
+
+	if (!mem->va || !mem->dma_addr) {
+		mtk_v4l2_vdec_err(ctx, "dma buffer size=0x%lx failed!", size);
+		ret = -EPERM;
+		goto err_addr;
+	}
+
+	mem->attach = attach;
+	mem->sgt = sgt;
+
+	return 0;
+err_addr:
+	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
+err_sgt:
+	dma_buf_detach(dma_buffer, attach);
+err_attach:
+	dma_buf_put(dma_buffer);
+
+	return ret;
+}
+
+static int mtk_vcodec_mem_dec_alloc(void *priv, struct mtk_vcodec_mem *mem)
+{
+	struct mtk_vcodec_dec_ctx *ctx = priv;
+	int ret;
+
+	if (ctx->is_svp_mode)
+		ret = mtk_vcodec_mem_dec_alloc_sec(ctx, mem);
+	else
+		ret = mtk_vcodec_mem_dec_alloc_nor(ctx, mem);
+
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d]  - va      = %p", ctx->id, mem->va);
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d]  - dma     = 0x%lx", ctx->id,
 			  (unsigned long)mem->dma_addr);
-	mtk_v4l2_vdec_dbg(3, ctx, "[%d]    size = 0x%lx", ctx->id, size);
+	mtk_v4l2_vdec_dbg(3, ctx, "[%d]    size = 0x%lx", ctx->id, (unsigned long)mem->size);
 
-	return 0;
+	return ret;
 }
 
 static int mtk_vcodec_mem_enc_alloc(void *priv, struct mtk_vcodec_mem *mem)
@@ -96,6 +175,31 @@ int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
 }
 EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
 
+static void mtk_vcodec_mem_dec_free_nor(struct mtk_vcodec_dec_ctx *ctx,
+					struct mtk_vcodec_mem *mem)
+{
+	struct device *dev = &ctx->dev->plat_dev->dev;
+
+	dma_free_coherent(dev, mem->size, mem->va, mem->dma_addr);
+
+	mem->va = NULL;
+	mem->dma_addr = 0;
+	mem->size = 0;
+}
+
+static void mtk_vcodec_mem_dec_free_sec(struct mtk_vcodec_mem *mem)
+{
+	dma_buf_unmap_attachment(mem->attach, mem->sgt, DMA_BIDIRECTIONAL);
+	dma_buf_detach((struct dma_buf *)mem->va, mem->attach);
+	dma_buf_put((struct dma_buf *)mem->va);
+
+	mem->attach = NULL;
+	mem->sgt = NULL;
+	mem->va = NULL;
+	mem->dma_addr = 0;
+	mem->size = 0;
+}
+
 static void mtk_vcodec_mem_dec_free(void *priv, struct mtk_vcodec_mem *mem)
 {
 	unsigned long size = mem->size;
@@ -112,10 +216,10 @@ static void mtk_vcodec_mem_dec_free(void *priv, struct mtk_vcodec_mem *mem)
 			  (unsigned long)mem->dma_addr);
 	mtk_v4l2_vdec_dbg(3, ctx, "[%d]    size = 0x%lx", ctx->id, size);
 
-	dma_free_coherent(dev, size, mem->va, mem->dma_addr);
-	mem->va = NULL;
-	mem->dma_addr = 0;
-	mem->size = 0;
+	if (ctx->is_svp_mode)
+		mtk_vcodec_mem_dec_free_sec(mem);
+	else
+		mtk_vcodec_mem_dec_free_nor(ctx, mem);
 }
 
 static void mtk_vcodec_mem_enc_free(void *priv, struct mtk_vcodec_mem *mem)
@@ -210,3 +314,4 @@ EXPORT_SYMBOL(mtk_vcodec_get_curr_ctx);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Mediatek video codec driver");
+MODULE_IMPORT_NS(DMA_BUF);
diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
index 85f615cdd4d3..22078e757ed0 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.h
@@ -18,6 +18,9 @@ struct mtk_vcodec_mem {
 	size_t size;
 	void *va;
 	dma_addr_t dma_addr;
+
+	struct dma_buf_attachment *attach;
+	struct sg_table *sgt;
 };
 
 struct mtk_vcodec_fb {
-- 
2.18.0

