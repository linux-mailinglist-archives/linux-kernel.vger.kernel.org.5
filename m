Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152FD7E1557
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjKEQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 11:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKEQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 11:56:16 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192910C8;
        Sun,  5 Nov 2023 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699203367; bh=lpnBJaNiSOXF2fbVkARa+33opskrlpRAhdbPZ7vR6lI=;
 b=VM49k8elFZ6RRgB1nf7LwO33PFuV3oU0yPReic/VjHWVuJIWjF1BAAqQeJ/kSNr4WviBYt7wc
 yoAzmSrMaXchniGD9+P+AClnI10zGhD6Ms5PVd5D3+60btZDafhrPK3z58o1orIkwbQorItpCN7
 C9SwGc78iqWSqt00jt/1LXXtxIPZmJidD6Hl8dszXb/mSxHFCy02zpZeMCQSZ1t0WPI2jokH9c8
 SI4a8ajRdYOEWjyKSv9R54v8NGjE99w9sBKIJDgTSNbokoEgRzO2xFaBXHTHmM3jEMIvJDFRn04
 LvpAtA46NwI+N4+6y/C2XtBij8WOvmhPWH3EmiP1bMHQ==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 10/11] media: rkvdec: Add get_image_fmt ops
Date:   Sun,  5 Nov 2023 16:55:09 +0000
Message-ID: <20231105165521.3592037-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231105165521.3592037-1-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6547c92642ad2f8d1524695c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for a get_image_fmt() ops that return the required image
format.

The CAPTURE format is reset when required image format changes and the
buffer queue is not busy.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4:
- Change fmt_opaque into an image format
- Split patch into two

v3:
- New patch

 drivers/staging/media/rkvdec/rkvdec.c | 49 +++++++++++++++++++++++++--
 drivers/staging/media/rkvdec/rkvdec.h |  2 ++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 5949d59d4cf9..225aa1f0ac48 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -108,15 +108,60 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
 	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+	struct v4l2_pix_format_mplane *pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+	enum rkvdec_image_fmt image_fmt;
+	struct vb2_queue *vq;
+	int ret;
+
+	if (desc->ops->try_ctrl) {
+		ret = desc->ops->try_ctrl(ctx, ctrl);
+		if (ret)
+			return ret;
+	}
+
+	if (!desc->ops->get_image_fmt)
+		return 0;
 
-	if (desc->ops->try_ctrl)
-		return desc->ops->try_ctrl(ctx, ctrl);
+	image_fmt = desc->ops->get_image_fmt(ctx, ctrl);
+	if (ctx->image_fmt == image_fmt)
+		return 0;
+
+	if (rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat, image_fmt))
+		return 0;
+
+	/* format change not allowed when queue is busy */
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+			     V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
+	if (vb2_is_busy(vq))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
+	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+	struct v4l2_pix_format_mplane *pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+	enum rkvdec_image_fmt image_fmt;
+
+	if (!desc->ops->get_image_fmt)
+		return 0;
+
+	image_fmt = desc->ops->get_image_fmt(ctx, ctrl);
+	if (ctx->image_fmt == image_fmt)
+		return 0;
+
+	ctx->image_fmt = image_fmt;
+	if (!rkvdec_is_valid_fmt(ctx, pix_mp->pixelformat, ctx->image_fmt))
+		rkvdec_reset_decoded_fmt(ctx);
 
 	return 0;
 }
 
 static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
 	.try_ctrl = rkvdec_try_ctrl,
+	.s_ctrl = rkvdec_s_ctrl,
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 6f8cf50c5d99..e466a2753ccf 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -73,6 +73,8 @@ struct rkvdec_coded_fmt_ops {
 		     struct vb2_v4l2_buffer *dst_buf,
 		     enum vb2_buffer_state result);
 	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
+	enum rkvdec_image_fmt (*get_image_fmt)(struct rkvdec_ctx *ctx,
+					       struct v4l2_ctrl *ctrl);
 };
 
 enum rkvdec_image_fmt {
-- 
2.42.0

