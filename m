Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510C7E20EA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjKFMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjKFMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:05:34 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499D10FE;
        Mon,  6 Nov 2023 04:04:55 -0800 (PST)
X-UUID: afce76667c9c11eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yChL9KtBQ6/tQ7hgRGeDtJ4sTQoQIi+cpocmej7Gugc=;
        b=AmDVhBBcc3fFD4HY637OfwLFcP+v5YSpwdso+JEFW0b29icoo2RrphJJiFQSHiIIqVl8pKJyEO+yb0jfBeGR5KnVJQPTtw+0Kl6FKhyF+W7oY+KqWl4P2P1qE5yFfE8R8GzeNvK1M4eVt3cdGR3TAFMBqK2wlC6JmyHoi94/Hoc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:40d53a91-71ce-41f6-b3dd-811f1221dea4,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:8b2135fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: afce76667c9c11eea33bb35ae8d461a2-20231106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1775787449; Mon, 06 Nov 2023 20:04:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 20:04:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 20:04:48 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        John Stultz <jstultz@google.com>,
        Yong Wu <yong.wu@mediatek.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
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
Subject: [PATCH v2,21/21] media: mediatek: vcodec: move vdec init interface to setup callback
Date:   Mon, 6 Nov 2023 20:04:23 +0800
Message-ID: <20231106120423.23364-22-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231106120423.23364-1-yunfei.dong@mediatek.com>
References: <20231106120423.23364-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting secure video playback (svp) flag when request output buffer, then
calling init interface to init svp parameters in optee-os.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 144 ++++++++++++------
 1 file changed, 94 insertions(+), 50 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
index cede9b387eb2..be832fce1e60 100644
--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
@@ -184,6 +184,74 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_dec_ctx *ctx)
 	q_data->bytesperline[1] = q_data->coded_width;
 }
 
+static int mtk_vcodec_dec_init_pic_info(struct mtk_vcodec_dec_ctx *ctx, enum v4l2_buf_type type)
+{
+	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
+	struct mtk_q_data *q_data;
+	int ret;
+
+	if (!ctx->current_codec)
+		return 0;
+
+	if (V4L2_TYPE_IS_OUTPUT(type) && ctx->state == MTK_STATE_FREE) {
+		q_data = mtk_vdec_get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+		if (!q_data)
+			return -EINVAL;
+
+		ret = vdec_if_init(ctx, q_data->fmt->fourcc);
+		if (ret) {
+			mtk_v4l2_vdec_err(ctx, "[%d]: vdec_if_init() fail ret=%d",
+					  ctx->id, ret);
+			return -EINVAL;
+		}
+		ctx->state = MTK_STATE_INIT;
+	}
+
+	if (!dec_pdata->uses_stateless_api)
+		return 0;
+
+	/*
+	 * If get pic info fail, need to use the default pic info params, or
+	 * v4l2-compliance will fail
+	 */
+	ret = vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo);
+	if (ret) {
+		mtk_v4l2_vdec_err(ctx, "[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail",
+				  ctx->id);
+	}
+
+	ctx->last_decoded_picinfo = ctx->picinfo;
+
+	if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1) {
+		ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
+			ctx->picinfo.fb_sz[0] +
+			ctx->picinfo.fb_sz[1];
+		ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =
+			ctx->picinfo.buf_w;
+	} else {
+		if (ctx->is_secure_playback)
+			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
+				ctx->picinfo.fb_sz[0] + ctx->picinfo.fb_sz[1];
+		else
+			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] = ctx->picinfo.fb_sz[0];
+
+		ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] = ctx->picinfo.buf_w;
+		ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] = ctx->picinfo.fb_sz[1];
+		ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] = ctx->picinfo.buf_w;
+	}
+
+	ctx->q_data[MTK_Q_DATA_DST].coded_width = ctx->picinfo.buf_w;
+	ctx->q_data[MTK_Q_DATA_DST].coded_height = ctx->picinfo.buf_h;
+	mtk_v4l2_vdec_dbg(2, ctx,
+			  "[%d] init() plane:%d wxh=%dx%d pic wxh=%dx%d sz=0x%x_0x%x",
+			  ctx->id, q_data->fmt->num_planes,
+			  ctx->picinfo.buf_w, ctx->picinfo.buf_h,
+			  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
+			  ctx->q_data[MTK_Q_DATA_DST].sizeimage[0],
+			  ctx->q_data[MTK_Q_DATA_DST].sizeimage[1]);
+	return 0;
+}
+
 static int vidioc_vdec_qbuf(struct file *file, void *priv,
 			    struct v4l2_buffer *buf)
 {
@@ -501,17 +569,7 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		ctx->ycbcr_enc = pix_mp->ycbcr_enc;
 		ctx->quantization = pix_mp->quantization;
 		ctx->xfer_func = pix_mp->xfer_func;
-
 		ctx->current_codec = fmt->fourcc;
-		if (ctx->state == MTK_STATE_FREE) {
-			ret = vdec_if_init(ctx, q_data->fmt->fourcc);
-			if (ret) {
-				mtk_v4l2_vdec_err(ctx, "[%d]: vdec_if_init() fail ret=%d",
-						  ctx->id, ret);
-				return -EINVAL;
-			}
-			ctx->state = MTK_STATE_INIT;
-		}
 	} else {
 		ctx->capture_fourcc = fmt->fourcc;
 	}
@@ -524,46 +582,11 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 		ctx->picinfo.pic_w = pix_mp->width;
 		ctx->picinfo.pic_h = pix_mp->height;
 
-		/*
-		 * If get pic info fail, need to use the default pic info params, or
-		 * v4l2-compliance will fail
-		 */
-		ret = vdec_if_get_param(ctx, GET_PARAM_PIC_INFO, &ctx->picinfo);
-		if (ret) {
-			mtk_v4l2_vdec_err(ctx, "[%d]Error!! Get GET_PARAM_PICTURE_INFO Fail",
-					  ctx->id);
-		}
-
-		ctx->last_decoded_picinfo = ctx->picinfo;
-
-		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 1) {
-			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
-				ctx->picinfo.fb_sz[0] +
-				ctx->picinfo.fb_sz[1];
-			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =
-				ctx->picinfo.buf_w;
-		} else {
-			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
-				ctx->picinfo.fb_sz[0];
-			ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =
-				ctx->picinfo.buf_w;
-			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =
-				ctx->picinfo.fb_sz[1];
-			ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] =
-				ctx->picinfo.buf_w;
-		}
-
-		ctx->q_data[MTK_Q_DATA_DST].coded_width = ctx->picinfo.buf_w;
-		ctx->q_data[MTK_Q_DATA_DST].coded_height = ctx->picinfo.buf_h;
-		mtk_v4l2_vdec_dbg(2, ctx,
-				  "[%d] init() plane:%d wxh=%dx%d pic wxh=%dx%d sz=0x%x_0x%x",
-				  ctx->id, pix_mp->num_planes,
-				  ctx->picinfo.buf_w, ctx->picinfo.buf_h,
-				  ctx->picinfo.pic_w, ctx->picinfo.pic_h,
-				  ctx->q_data[MTK_Q_DATA_DST].sizeimage[0],
-				  ctx->q_data[MTK_Q_DATA_DST].sizeimage[1]);
+		if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
+			ret = mtk_vcodec_dec_init_pic_info(ctx, f->type);
 	}
-	return 0;
+
+	return ret;
 }
 
 static int vidioc_enum_framesizes(struct file *file, void *priv,
@@ -744,7 +767,7 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 {
 	struct mtk_vcodec_dec_ctx *ctx = vb2_get_drv_priv(vq);
 	struct mtk_q_data *q_data;
-	unsigned int i;
+	unsigned int i, ret;
 
 	q_data = mtk_vdec_get_q_data(ctx, vq->type);
 
@@ -753,6 +776,25 @@ int vb2ops_vdec_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		return -EINVAL;
 	}
 
+	if (vq->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		ret = mtk_vcodec_dec_init_pic_info(ctx, vq->type);
+		if (ret) {
+			mtk_v4l2_vdec_err(ctx, "Failed to init picture information");
+			return ret;
+		}
+
+		if (vq->secure_mem && !ctx->is_secure_playback) {
+			ret = mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
+			if (ret) {
+				mtk_v4l2_vdec_err(ctx, "Failed to open decoder optee os");
+				return ret;
+			}
+			ctx->is_secure_playback = vq->secure_mem;
+			mtk_v4l2_vdec_dbg(1, ctx, "Getting secure decoder mode:%d",
+					  ctx->is_secure_playback);
+		}
+	}
+
 	if (*nplanes) {
 		if (vq->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 			if (*nplanes != q_data->fmt->num_planes)
@@ -1002,6 +1044,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->lock		= &ctx->dev->dev_mutex;
 	src_vq->dev             = &ctx->dev->plat_dev->dev;
 	src_vq->allow_cache_hints = 1;
+	src_vq->allow_secure_mem = 1;
 
 	ret = vb2_queue_init(src_vq);
 	if (ret) {
@@ -1018,6 +1061,7 @@ int mtk_vcodec_dec_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->lock		= &ctx->dev->dev_mutex;
 	dst_vq->dev             = &ctx->dev->plat_dev->dev;
 	dst_vq->allow_cache_hints = 1;
+	dst_vq->allow_secure_mem = 1;
 
 	ret = vb2_queue_init(dst_vq);
 	if (ret)
-- 
2.18.0

