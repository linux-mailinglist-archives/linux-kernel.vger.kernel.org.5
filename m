Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866F7DADE0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJ2SqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjJ2SqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:46:00 -0400
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE03C5;
        Sun, 29 Oct 2023 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1698605142; bh=CDI7CU66wEs270/rnVxpiW23n/7qKyJzphHa0D78l20=;
 b=MwHhazQcJbCZWxHN3Dq+D/NALM9dhM8cOWgiysWhVZYfTh8arisAjxDc+XkWrCZ9uBNPHd/PE
 ylT6YMCinGthBAM4pOtp20nVHxJcBERP2haw+AGx08QZXtIVcVpW7zy1QR0RnQFqo+mmIjq3WqY
 du8CevgaGkUCwP3SM5x0Jg4Zmv3u3wiCAbsV5xLkT+NQTZbfwA861F+maZAEHAB15uHDt907mQh
 gPgUSGZr7O/+C7+r5pfxomNJYCIKP99vr4TqI5dfoKgAbWZT2zOPsy/R2EOPyIeUVjsviz5nyRW
 h0sGCY+ziYMqlcGPUJsCOgrWhzcVMH+2jBDYC7iokgcA==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 10/10] media: rkvdec: h264: Support High 10 and 4:2:2 profiles
Date:   Sun, 29 Oct 2023 18:34:17 +0000
Message-ID: <20231029183427.1781554-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029183427.1781554-1-jonas@kwiboo.se>
References: <20231029183427.1781554-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 653ea5df8fe0ffca230b0f8a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support and enable decoding of H264 High 10 and 4:2:2 profiles.

Decoded CAPTURE buffer width is aligned to 64 pixels to accommodate HW
requirement of 10-bit format buffers.

The get_fmt_opaque and valid_fmt ops is implemented to select a CAPTURE
format suited for the provided SPS control.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3:
- Add get_fmt_opaque ops, the expected pixelformat is used as opaque
- Add new valid_fmt ops that validate pixelformat matches opaque
- Update H264_PROFILE control max value

 drivers/staging/media/rkvdec/rkvdec-h264.c | 45 +++++++++++++++++-----
 drivers/staging/media/rkvdec/rkvdec.c      | 21 ++++++----
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 815d5359ddd5..f773a3f5ecb7 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1027,24 +1027,49 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	return 0;
 }
 
+static u32 rkvdec_h264_get_fmt_opaque(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
+{
+	const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
+
+	if (ctrl->id != V4L2_CID_STATELESS_H264_SPS)
+		return 0;
+
+	if (sps->bit_depth_luma_minus8 == 0) {
+		if (sps->chroma_format_idc == 2)
+			return V4L2_PIX_FMT_NV16;
+		else
+			return V4L2_PIX_FMT_NV12;
+	} else if (sps->bit_depth_luma_minus8 == 2) {
+		if (sps->chroma_format_idc == 2)
+			return V4L2_PIX_FMT_NV20;
+		else
+			return V4L2_PIX_FMT_NV15;
+	}
+
+	return 0;
+}
+
+static bool rkvdec_h264_valid_fmt(struct rkvdec_ctx *ctx, u32 fourcc, u32 opaque)
+{
+	if (!opaque)
+		return true;
+
+	return fourcc == opaque;
+}
+
 static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
 				    const struct v4l2_ctrl_h264_sps *sps)
 {
 	unsigned int width, height;
 
-	/*
-	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
-	 * but it's currently broken in the driver.
-	 * Reject them for now, until it's fixed.
-	 */
-	if (sps->chroma_format_idc > 1)
-		/* Only 4:0:0 and 4:2:0 are supported */
+	if (sps->chroma_format_idc > 2)
+		/* Only 4:0:0, 4:2:0 and 4:2:2 are supported */
 		return -EINVAL;
 	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
 		/* Luma and chroma bit depth mismatch */
 		return -EINVAL;
-	if (sps->bit_depth_luma_minus8 != 0)
-		/* Only 8-bit is supported */
+	if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
+		/* Only 8-bit and 10-bit is supported */
 		return -EINVAL;
 
 	width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
@@ -1171,6 +1196,8 @@ static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 
 const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.adjust_fmt = rkvdec_h264_adjust_fmt,
+	.get_fmt_opaque = rkvdec_h264_get_fmt_opaque,
+	.valid_fmt = rkvdec_h264_valid_fmt,
 	.start = rkvdec_h264_start,
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 5c7e1b91e908..fce5cba343a3 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -50,7 +50,7 @@ static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
 				       struct v4l2_pix_format_mplane *pix_mp)
 {
 	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
-			    pix_mp->width, pix_mp->height);
+			    ALIGN(pix_mp->width, 64), pix_mp->height);
 	pix_mp->plane_fmt[0].sizeimage += 128 *
 		DIV_ROUND_UP(pix_mp->width, 16) *
 		DIV_ROUND_UP(pix_mp->height, 16);
@@ -169,7 +169,7 @@ static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
 	{
 		.cfg.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
 		.cfg.min = V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
-		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+		.cfg.max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422,
 		.cfg.menu_skip_mask =
 			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
 		.cfg.def = V4L2_MPEG_VIDEO_H264_PROFILE_MAIN,
@@ -186,8 +186,11 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls = {
 	.num_ctrls = ARRAY_SIZE(rkvdec_h264_ctrl_descs),
 };
 
-static const u32 rkvdec_h264_vp9_decoded_fmts[] = {
+static const u32 rkvdec_h264_decoded_fmts[] = {
 	V4L2_PIX_FMT_NV12,
+	V4L2_PIX_FMT_NV15,
+	V4L2_PIX_FMT_NV16,
+	V4L2_PIX_FMT_NV20,
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_vp9_ctrl_descs[] = {
@@ -210,6 +213,10 @@ static const struct rkvdec_ctrls rkvdec_vp9_ctrls = {
 	.num_ctrls = ARRAY_SIZE(rkvdec_vp9_ctrl_descs),
 };
 
+static const u32 rkvdec_vp9_decoded_fmts[] = {
+	V4L2_PIX_FMT_NV12,
+};
+
 static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_H264_SLICE,
@@ -223,8 +230,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 		},
 		.ctrls = &rkvdec_h264_ctrls,
 		.ops = &rkvdec_h264_fmt_ops,
-		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
-		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
+		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_decoded_fmts),
+		.decoded_fmts = rkvdec_h264_decoded_fmts,
 		.subsystem_flags = VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
 	},
 	{
@@ -239,8 +246,8 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 		},
 		.ctrls = &rkvdec_vp9_ctrls,
 		.ops = &rkvdec_vp9_fmt_ops,
-		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
-		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
+		.num_decoded_fmts = ARRAY_SIZE(rkvdec_vp9_decoded_fmts),
+		.decoded_fmts = rkvdec_vp9_decoded_fmts,
 	}
 };
 
-- 
2.42.0

