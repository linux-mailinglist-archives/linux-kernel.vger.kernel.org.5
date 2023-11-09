Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155667E72AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345124AbjKIUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjKIUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:16:54 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD83AAC;
        Thu,  9 Nov 2023 12:16:51 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F1D21C0004;
        Thu,  9 Nov 2023 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699561010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qlw7B5/Bx/59SQf3CbtCdO7WmqSG7NYa1WOTVO0Qk80=;
        b=WgEq9pmqEnbuW6waH6m/ZSGL/NBzEuXlBpDxFBA2lGrCWWtOe/4nwymHgzG3MSGAZiSxlS
        J0ch5GA0xJRwfSm2GEJ4Hcy4TPCj9ZYmkExXAJYP/Zw6HmbvX64xuRhpUo80hriotvgVNk
        hhKX5A+o6QIGwuqX/WaPyLI+knh0Vnv+KVnOFA3471FomaQ71k+NrClfDNCRga5SYRH/CA
        xtZAp3SVnpGXsk5Y1SIaNqfagMAEn9nCrFiBbRUcp7WuOsp4i2v52aF4JeWJ6WE7quUx5I
        1/8xWkx1HCfNbs9XY4ylpXB9sQWlEsLzOwckLPo9PTn4tgPvXv/uz2wm8gB6YQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/4] media: vicodec: Disable (TRY_)DECODER_CMD for the stateless case
Date:   Thu,  9 Nov 2023 21:16:37 +0100
Message-ID: <20231109201640.340556-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (TRY_)DECODER_CMD ioctls are only useful for stateful decoders and for
stateless decoders that support holding capture buffers (which is not the case
for this driver).

Disable them when registering the stateless decoder.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/test-drivers/vicodec/vicodec-core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 6f0e20df74e9..8f7a2b153ee9 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1240,6 +1240,12 @@ static int vicodec_decoder_cmd(struct file *file, void *fh,
 	struct vicodec_ctx *ctx = file2ctx(file);
 	int ret;
 
+	/*
+	 * This ioctl should not be used with a stateless codec that doesn't
+	 * support holding buffers and the associated flush command.
+	 */
+	WARN_ON(ctx->is_stateless);
+
 	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, dc);
 	if (ret < 0)
 		return ret;
@@ -2025,7 +2031,7 @@ static const struct v4l2_m2m_ops m2m_ops = {
 
 static int register_instance(struct vicodec_dev *dev,
 			     struct vicodec_dev_instance *dev_instance,
-			     const char *name, bool is_enc)
+			     const char *name, bool is_enc, bool is_stateless)
 {
 	struct video_device *vfd;
 	int ret;
@@ -2045,10 +2051,11 @@ static int register_instance(struct vicodec_dev *dev,
 	strscpy(vfd->name, name, sizeof(vfd->name));
 	vfd->device_caps = V4L2_CAP_STREAMING |
 		(multiplanar ? V4L2_CAP_VIDEO_M2M_MPLANE : V4L2_CAP_VIDEO_M2M);
-	if (is_enc) {
+	if (is_enc || is_stateless) {
 		v4l2_disable_ioctl(vfd, VIDIOC_DECODER_CMD);
 		v4l2_disable_ioctl(vfd, VIDIOC_TRY_DECODER_CMD);
-	} else {
+	}
+	if (!is_enc) {
 		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
 		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
 	}
@@ -2107,17 +2114,17 @@ static int vicodec_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 
 	ret = register_instance(dev, &dev->stateful_enc, "stateful-encoder",
-				true);
+				true, false);
 	if (ret)
 		goto unreg_dev;
 
 	ret = register_instance(dev, &dev->stateful_dec, "stateful-decoder",
-				false);
+				false, false);
 	if (ret)
 		goto unreg_sf_enc;
 
 	ret = register_instance(dev, &dev->stateless_dec, "stateless-decoder",
-				false);
+				false, true);
 	if (ret)
 		goto unreg_sf_dec;
 
-- 
2.42.1

