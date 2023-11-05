Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841537E1801
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjKEXhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKEXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:37:29 -0500
X-Greylist: delayed 24086 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 15:37:12 PST
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE1D71;
        Sun,  5 Nov 2023 15:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699227416; bh=XVtjEwFhjX1gWgLnbrFR5jIgtMuIAsHK43IwNQGtM/8=;
 b=U/+Kusm6JhPEPIsgn2zk0lEWzXZHYQgKgOO7BcqypNPNSnXExP4HxCSMmfDSnFnzks1CPbAHT
 GUBZUh7UZQ6GZN4kQgckeFrUDUFIAlSkhsQH2ZfGD4cATg/Ho09y5PSz2Gg10zWlTNSsfP9VD1d
 vPQGBLAlhCg1X9bex8BG2ygqOKrlOLMvJyp/L1dZuBgFj5KA1w/kYejOz0+Qr5oxS1TrMPfHaw/
 sVSY2u66JXloC9CfF3CplrE5a+FQBXQpT6tUaTZJD0rVSEyAOU+EdBxvJRu9BjTiV1qmSo9pJ61
 9v947ZFSx18Maul7JysDseFew8W6Ovhp8pHcc66MJIeA==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/9] media: rkvdec: Implement capability filtering
Date:   Sun,  5 Nov 2023 23:36:10 +0000
Message-ID: <20231105233630.3927502-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231105233630.3927502-1-jonas@kwiboo.se>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 654827171b004d4cddbe0c73
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filtering of coded formats and controls depending on a variant
capabilities.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec.c | 63 +++++++++++++++++++--------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index dc1f75dd1c4f..9cf7b63c1371 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -370,13 +370,34 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 	}
 };
 
+static inline bool rkvdec_is_capable(struct rkvdec_ctx *ctx,
+				     unsigned int capability)
+{
+	return (ctx->dev->capabilities & capability) == capability;
+}
+
 static const struct rkvdec_coded_fmt_desc *
-rkvdec_find_coded_fmt_desc(u32 fourcc)
+rkvdec_enum_coded_fmt_desc(struct rkvdec_ctx *ctx, int index)
+{
+	unsigned int i, j;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(rkvdec_coded_fmts); i++) {
+		if (rkvdec_is_capable(ctx, rkvdec_coded_fmts[i].capability) &&
+		    index == j++)
+			return &rkvdec_coded_fmts[i];
+	}
+
+	return NULL;
+}
+
+static const struct rkvdec_coded_fmt_desc *
+rkvdec_find_coded_fmt_desc(struct rkvdec_ctx *ctx, u32 fourcc)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(rkvdec_coded_fmts); i++) {
-		if (rkvdec_coded_fmts[i].fourcc == fourcc)
+		if (rkvdec_is_capable(ctx, rkvdec_coded_fmts[i].capability) &&
+		    rkvdec_coded_fmts[i].fourcc == fourcc)
 			return &rkvdec_coded_fmts[i];
 	}
 
@@ -387,7 +408,7 @@ static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
 {
 	struct v4l2_format *f = &ctx->coded_fmt;
 
-	ctx->coded_fmt_desc = &rkvdec_coded_fmts[0];
+	ctx->coded_fmt_desc = rkvdec_enum_coded_fmt_desc(ctx, 0);
 	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->fourcc);
 
 	f->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
@@ -401,17 +422,18 @@ static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
 static int rkvdec_enum_framesizes(struct file *file, void *priv,
 				  struct v4l2_frmsizeenum *fsize)
 {
-	const struct rkvdec_coded_fmt_desc *fmt;
+	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
+	const struct rkvdec_coded_fmt_desc *desc;
 
 	if (fsize->index != 0)
 		return -EINVAL;
 
-	fmt = rkvdec_find_coded_fmt_desc(fsize->pixel_format);
-	if (!fmt)
+	desc = rkvdec_find_coded_fmt_desc(ctx, fsize->pixel_format);
+	if (!desc)
 		return -EINVAL;
 
 	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-	fsize->stepwise = fmt->frmsize;
+	fsize->stepwise = desc->frmsize;
 	return 0;
 }
 
@@ -469,10 +491,10 @@ static int rkvdec_try_output_fmt(struct file *file, void *priv,
 	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
 	const struct rkvdec_coded_fmt_desc *desc;
 
-	desc = rkvdec_find_coded_fmt_desc(pix_mp->pixelformat);
+	desc = rkvdec_find_coded_fmt_desc(ctx, pix_mp->pixelformat);
 	if (!desc) {
-		pix_mp->pixelformat = rkvdec_coded_fmts[0].fourcc;
-		desc = &rkvdec_coded_fmts[0];
+		desc = rkvdec_enum_coded_fmt_desc(ctx, 0);
+		pix_mp->pixelformat = desc->fourcc;
 	}
 
 	v4l2_apply_frmsize_constraints(&pix_mp->width,
@@ -549,7 +571,7 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	if (ret)
 		return ret;
 
-	desc = rkvdec_find_coded_fmt_desc(f->fmt.pix_mp.pixelformat);
+	desc = rkvdec_find_coded_fmt_desc(ctx, f->fmt.pix_mp.pixelformat);
 	if (!desc)
 		return -EINVAL;
 	ctx->coded_fmt_desc = desc;
@@ -601,10 +623,14 @@ static int rkvdec_g_capture_fmt(struct file *file, void *priv,
 static int rkvdec_enum_output_fmt(struct file *file, void *priv,
 				  struct v4l2_fmtdesc *f)
 {
-	if (f->index >= ARRAY_SIZE(rkvdec_coded_fmts))
+	struct rkvdec_ctx *ctx = fh_to_rkvdec_ctx(priv);
+	const struct rkvdec_coded_fmt_desc *desc;
+
+	desc = rkvdec_enum_coded_fmt_desc(ctx, f->index);
+	if (!desc)
 		return -EINVAL;
 
-	f->pixelformat = rkvdec_coded_fmts[f->index].fourcc;
+	f->pixelformat = desc->fourcc;
 	return 0;
 }
 
@@ -968,14 +994,17 @@ static int rkvdec_init_ctrls(struct rkvdec_ctx *ctx)
 	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(rkvdec_coded_fmts); i++)
-		nctrls += rkvdec_coded_fmts[i].ctrls->num_ctrls;
+		if (rkvdec_is_capable(ctx, rkvdec_coded_fmts[i].capability))
+			nctrls += rkvdec_coded_fmts[i].ctrls->num_ctrls;
 
 	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, nctrls);
 
 	for (i = 0; i < ARRAY_SIZE(rkvdec_coded_fmts); i++) {
-		ret = rkvdec_add_ctrls(ctx, rkvdec_coded_fmts[i].ctrls);
-		if (ret)
-			goto err_free_handler;
+		if (rkvdec_is_capable(ctx, rkvdec_coded_fmts[i].capability)) {
+			ret = rkvdec_add_ctrls(ctx, rkvdec_coded_fmts[i].ctrls);
+			if (ret)
+				goto err_free_handler;
+		}
 	}
 
 	ret = v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
-- 
2.42.0

