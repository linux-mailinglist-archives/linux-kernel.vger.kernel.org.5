Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FD79BFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377723AbjIKW2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjIKNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:00:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652BE58;
        Mon, 11 Sep 2023 05:59:56 -0700 (PDT)
X-UUID: 17fb1cb050a311ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i8lf/NQkzqcIVQSywOYprcMBzCK/pk6C1DTn4KOOSno=;
        b=X0gx9aQ/p5/JiTK8FqIJduCAeVnzm8jpeTN1GdySvXrubHshipc4F6ZbsqJxE8/OJlXCCNM4mLn/goXTd3OS6qtRpfNhBTBj5MpzVgDbGlYDsyQ5gvEB9SCXba9coQJoyXOHnaBwZ8BJ9BbmJZHRULYbO5X116AQNV4aQggkVOI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:259c6499-b2ae-49a2-9392-f086b9c7ac76,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:0ad78a4,CLOUDID:19c4e4c2-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 17fb1cb050a311ee8051498923ad61e6-20230911
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 291558597; Mon, 11 Sep 2023 20:59:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 20:59:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 20:59:48 +0800
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
Subject: [PATCH 11/14] media: medkatek: vcodec: covert secure fd to secure handle
Date:   Mon, 11 Sep 2023 20:59:33 +0800
Message-ID: <20230911125936.10648-12-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911125936.10648-1-yunfei.dong@mediatek.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.534500-8.000000
X-TMASE-MatchedRID: P/hT4jlJcUSvVT6bfkFW/hafLXbshfog0uu9IYFQ6w7wTO+AdP0/mjcG
        i0cOVVasTiQecD9aKoRYo3G+rvxrNVc6r+JSY5jbtw+xHnsmQjNbAoaK+wS4jV6Ic79Y87/7tqn
        6zdLiUfc1C2f8ND2KYOY2eV25VpuBroQgRZf2+t7nx2TmxvCbKCi16p3/NdojZ5yuplze9pt6Ra
        SpHJq/AIiyX6xrn0xcn5u7YzlPkLcm4SY1UdFN+ZA6S0SjvcYU1M2UyPXKJXkUtdRZTmEaIQOku
        VkkJKW7Ntt/7UYCnkS1L0WZKCITP3uLfgSBmtT0dXu122+iJtqFKXsoBdprwpsoi2XrUn/Jn6Kd
        MrRsL14qtq5d3cxkNZd/mwLf2BVUgrupyzvJJhmo24LNhuZ3v3/2nGZwJmNDFPsCg1345/BgO21
        BQaodlQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.534500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: AA197EF0F13D4AED8583911B1312E64C584D5BAA8073AC167BEE49505D876A7A2000:8
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

User driver will fill or parse data in optee-os with secure handle,
need to covert secure fd to secure handle in kernel.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../vcodec/decoder/mtk_vcodec_dec_drv.c       |  1 +
 .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 54 ++++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  5 ++
 include/uapi/linux/v4l2-controls.h            |  4 ++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
index 0a89ce452ac3..64e006820f43 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
@@ -571,3 +571,4 @@ module_platform_driver(mtk_vcodec_dec_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Mediatek video codec V4L2 decoder driver");
+MODULE_IMPORT_NS(DMA_BUF);
diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
index 2ea517883a86..d2b09ce9f1cf 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
@@ -426,6 +426,46 @@ static int mtk_vcodec_get_pic_info(struct mtk_vcodec_dec_ctx *ctx)
 	return ret;
 }
 
+static int mtk_dma_contig_get_secure_handle(struct mtk_vcodec_dec_ctx *ctx, int fd)
+{
+	int secure_handle = 0;
+	struct dma_buf *buf;
+	struct dma_buf_attachment *dba;
+	struct sg_table *sgt;
+	struct device *dev = &ctx->dev->plat_dev->dev;
+
+	buf = dma_buf_get(fd);
+	if (IS_ERR(buf)) {
+		mtk_v4l2_vdec_err(ctx, "dma_buf_get fail fd:%d", fd);
+		return 0;
+	}
+
+	dba = dma_buf_attach(buf, dev);
+	if (IS_ERR(dba)) {
+		mtk_v4l2_vdec_err(ctx, "dma_buf_attach fail fd:%d", fd);
+		goto err_attach;
+	}
+
+	sgt = dma_buf_map_attachment(dba, DMA_BIDIRECTIONAL);
+	if (IS_ERR(sgt)) {
+		mtk_v4l2_vdec_err(ctx, "dma_buf_map_attachment fail fd:%d", fd);
+		goto err_map;
+	}
+	secure_handle = sg_dma_address(sgt->sgl);
+
+	dma_buf_unmap_attachment(dba, sgt, DMA_BIDIRECTIONAL);
+	dma_buf_detach(buf, dba);
+	dma_buf_put(buf);
+
+	return secure_handle;
+err_map:
+	dma_buf_detach(buf, dba);
+err_attach:
+	dma_buf_put(buf);
+
+	return 0;
+}
+
 static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct mtk_vcodec_dec_ctx *ctx = ctrl_to_dec_ctx(ctrl);
@@ -436,7 +476,7 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct v4l2_ctrl *hdr_ctrl;
 	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
 	const struct mtk_video_fmt *fmt;
-	int i = 0, ret = 0;
+	int i = 0, ret = 0, sec_fd;
 
 	hdr_ctrl = ctrl;
 	if (!hdr_ctrl || !hdr_ctrl->p_new.p)
@@ -489,6 +529,12 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
 			return -EINVAL;
 		}
 		break;
+	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
+		sec_fd = ctrl->val;
+
+		ctrl->val = mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
+		mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d => 0x%x", sec_fd, ctrl->val);
+		break;
 	default:
 		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id: 0x%x\n", hdr_ctrl->id);
 		return ret;
@@ -525,8 +571,9 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops = {
 static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 {
 	unsigned int i;
+	struct v4l2_ctrl *ctrl;
 
-	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS);
+	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
 		return ctx->ctrl_hdl.error;
@@ -543,6 +590,9 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
 		}
 	}
 
+	ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl_ops,
+				 V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
+
 	v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
 
 	return 0;
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..d8cf01f76aab 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -1041,6 +1041,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:	return "HEVC Size of Length Field";
 	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return "Reference Frames for a P-Frame";
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		return "Prepend SPS and PPS to IDR";
+	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:		return "MediaTek Decoder get secure handle";
 
 	/* AV1 controls */
 	case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:			return "AV1 Profile";
@@ -1437,6 +1438,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_VPX_NUM_REF_FRAMES:
 		*type = V4L2_CTRL_TYPE_INTEGER_MENU;
 		break;
+	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
+		break;
 	case V4L2_CID_USER_CLASS:
 	case V4L2_CID_CAMERA_CLASS:
 	case V4L2_CID_CODEC_CLASS:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..7b3694985366 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -954,6 +954,10 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
 #define V4L2_CID_MPEG_MFC51_VIDEO_H264_ADAPTIVE_RC_STATIC		(V4L2_CID_CODEC_MFC51_BASE+53)
 #define V4L2_CID_MPEG_MFC51_VIDEO_H264_NUM_REF_PIC_FOR_P		(V4L2_CID_CODEC_MFC51_BASE+54)
 
+/*  MPEG-class control IDs specific to the MediaTek Decoder driver as defined by V4L2 */
+#define V4L2_CID_MPEG_MTK_BASE			(V4L2_CTRL_CLASS_CODEC | 0x2000)
+#define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE	(V4L2_CID_MPEG_MTK_BASE+8)
+
 /*  Camera class control IDs */
 
 #define V4L2_CID_CAMERA_CLASS_BASE	(V4L2_CTRL_CLASS_CAMERA | 0x900)
-- 
2.18.0

