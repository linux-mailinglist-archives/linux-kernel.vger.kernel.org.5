Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8ED7E1569
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKERGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKERGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:06:34 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86726CC;
        Sun,  5 Nov 2023 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1699203989; bh=DHrB2MDEvgLvMGiiGW4ysBRF9ISWcTsdFhQXpZT8qmk=;
 b=qmG2UqLYMHESXsPdAlgbWWmznBQ+5Rc/W8EIDO0qSi+1yFUmMT+7+LjPru6aNwNGUsKKRYzb/
 EY6npsho/gelDfv/bMhMUH5ndDkQCcOqZCToPdUe0PMb38XzUz5XHCLQMEYwMYTtgLjz4KhCRUu
 g2nf26aFjz09K1jtw4iXOLCLAUYi36nTcDGJD9A13XdIsr8M7IWP/XQB+e7g+eWEKqsgD4JOqzH
 Nab8uOYS4hQZIMT/Ova8vLF2KuzcAjAK6OQVaDE3MvKT7EjLO0Ole1+rQ98P5NmDGs12WosfF9m
 4StMPGZuIZleIWK657/cEYge1ZXLPL+xPAI2af7/C2uQ==
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
Subject: [PATCH v4 07/11] media: rkvdec: Move rkvdec_reset_decoded_fmt helper
Date:   Sun,  5 Nov 2023 16:55:06 +0000
Message-ID: <20231105165521.3592037-8-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6547c91a42ad2f8d15246935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rkvdec_reset_decoded_fmt() and the called rkvdec_reset_fmt() helper
functions in preparation for adding a new caller in an upcoming patch.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v4:
- No change

v3:
- New patch

 drivers/staging/media/rkvdec/rkvdec.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 0570c790ad08..7a79840470e1 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -37,6 +37,29 @@ static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
 		DIV_ROUND_UP(pix_mp->height, 16);
 }
 
+static void rkvdec_reset_fmt(struct rkvdec_ctx *ctx, struct v4l2_format *f,
+			     u32 fourcc)
+{
+	memset(f, 0, sizeof(*f));
+	f->fmt.pix_mp.pixelformat = fourcc;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
+{
+	struct v4l2_format *f = &ctx->decoded_fmt;
+
+	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
+	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
+	f->fmt.pix_mp.height = ctx->coded_fmt.fmt.pix_mp.height;
+	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -169,18 +192,6 @@ rkvdec_find_coded_fmt_desc(u32 fourcc)
 	return NULL;
 }
 
-static void rkvdec_reset_fmt(struct rkvdec_ctx *ctx, struct v4l2_format *f,
-			     u32 fourcc)
-{
-	memset(f, 0, sizeof(*f));
-	f->fmt.pix_mp.pixelformat = fourcc;
-	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
-	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
-	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
-	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
-}
-
 static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
 {
 	struct v4l2_format *f = &ctx->coded_fmt;
@@ -196,17 +207,6 @@ static void rkvdec_reset_coded_fmt(struct rkvdec_ctx *ctx)
 		ctx->coded_fmt_desc->ops->adjust_fmt(ctx, f);
 }
 
-static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
-{
-	struct v4l2_format *f = &ctx->decoded_fmt;
-
-	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
-	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
-	f->fmt.pix_mp.height = ctx->coded_fmt.fmt.pix_mp.height;
-	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
-}
-
 static int rkvdec_enum_framesizes(struct file *file, void *priv,
 				  struct v4l2_frmsizeenum *fsize)
 {
-- 
2.42.0

