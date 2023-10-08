Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56A17BCBDF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 05:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjJHDT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 23:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjJHDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 23:19:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27758BD;
        Sat,  7 Oct 2023 20:19:19 -0700 (PDT)
X-UUID: 75bb6f30658911eea33bb35ae8d461a2-20231008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2lncwbw67fIZafoqWE9u36La+aHXLXeJrzy1kQnUnk4=;
        b=PjAVUJJuSHqHzRTKGPA5OXNAW2UMD/ShP7lruTxpWR84/Y7K5Nbff6s5UWPEiJaggLjKylCKpU4T8hXIcfSiSoLNDmWRODH4VzBlUeoos4aT6J30/7+hCFNquUFmtB5gaRhLcBjZcJ2a5Xq5kyzI9Sq2STdEZcL9FzzMlSfUBnA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6c9a4b80-1fa8-48ca-b766-41ba7fce0e95,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:1f1fb3bf-14cc-44ca-b657-2d2783296e72,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 75bb6f30658911eea33bb35ae8d461a2-20231008
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1277965314; Sun, 08 Oct 2023 11:19:15 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 8 Oct 2023 11:19:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 8 Oct 2023 11:19:12 +0800
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
Subject: [PATCH] media: mediatek: vcodec: using encoder device to alloc/free encoder memory
Date:   Sun, 8 Oct 2023 11:19:09 +0800
Message-ID: <20231008031909.32146-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.270600-8.000000
X-TMASE-MatchedRID: EvLd3cwGQhEtJMbDWD8p3hWCVBr+Ay98uoYFb0nRiqOCsBeCv8CM/Xf3
        4BoKFzcHTg/jfa6b1OczYorSrzJ8m2MAzi+7d0chF6z9HGHKwNuIrmqDVyayv8lgi/vLS272INi
        phQlaWRN2ZsQ86ifK0L+R4Fk68cCxoXHg+KoW2Ubil2r2x2PwtYfsPVs/8Vw6Ydn5x3tXIpcota
        sKsNUdSeLzNWBegCW2xl8lw85EaVQLbigRnpKlKWxlRJiH4397GKedVHUXrT7KIf/D+oFxIU+rs
        1+BI9BmqizkboPGhHnzIgp4i3lt2A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.270600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 115D3AFDCB6F7F683D4B83FD3D6673B22C9D90B17C7C1E4CDDFDB2404A119D962000:8
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to use encoder device to allocate/free encoder memory when calling
mtk_vcodec_mem_alloc/mtk_vcodec_mem_free, or leading to below crash log
when test encoder with decoder device.

pc : dma_alloc_attrs+0x44/0xf4
lr : mtk_vcodec_mem_alloc+0x50/0xa4 [mtk_vcodec_common]
sp : ffffffc0209f3990
x29: ffffffc0209f39a0 x28: ffffff8024102a18 x27: 0000000000000000
x26: 0000000000000000 x25: ffffffc00c06e2d8 x24: 0000000000000001
x23: 0000000000000cc0 x22: 0000000000000010 x21: 0000000000000800
x20: ffffff8024102a18 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000009 x16: ffffffe389736a98 x15: 0000000000000078
x14: ffffffe389704434 x13: 0000000000000007 x12: ffffffe38a2b2560
x11: 0000000000000800 x10: 0000000000000004 x9 : ffffffe331f07484
x8 : 5400e9aef2395000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000cc0
x2 : ffffff8024102a18 x1 : 0000000000000800 x0 : 0000000000000010
Call trace:
 dma_alloc_attrs+0x44/0xf4
 mtk_vcodec_mem_alloc+0x50/0xa4 [mtk_vcodec_common 2819d3d601f3cd06c1f2213ac1b9995134441421]
 h264_enc_set_param+0x27c/0x378 [mtk_vcodec_enc 772cc3d26c254e8cf54079451ef8d930d2eb4404]
 venc_if_set_param+0x4c/0x7c [mtk_vcodec_enc 772cc3d26c254e8cf54079451ef8d930d2eb4404]
 vb2ops_venc_start_streaming+0x1bc/0x328 [mtk_vcodec_enc 772cc3d26c254e8cf54079451ef8d930d2eb4404]
 vb2_start_streaming+0x64/0x12c
 vb2_core_streamon+0x114/0x158
 vb2_streamon+0x38/0x60
 v4l2_m2m_streamon+0x48/0x88
 v4l2_m2m_ioctl_streamon+0x20/0x2c
 v4l_streamon+0x2c/0x38
 __video_do_ioctl+0x2c4/0x3dc
 video_usercopy+0x404/0x934
 video_ioctl2+0x20/0x2c
 v4l2_ioctl+0x54/0x64
 v4l2_compat_ioctl32+0x90/0xa34
 __arm64_compat_sys_ioctl+0x128/0x13c
 invoke_syscall+0x4c/0x108
 el0_svc_common+0x98/0x104
 do_el0_svc_compat+0x28/0x34
 el0_svc_compat+0x2c/0x74
 el0t_32_sync_handler+0xa8/0xcc
 el0t_32_sync+0x194/0x198
Code: aa0003f6 aa0203f4 aa0103f5 f900

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

