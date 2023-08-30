Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E696E78D2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbjH3Exr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbjH3Exi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:53:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF8CC5;
        Tue, 29 Aug 2023 21:53:36 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.251.226.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6C81B10FE;
        Wed, 30 Aug 2023 06:52:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693371133;
        bh=r78Ey/3mCQEZBydNa5/i6pNT9NCVYnpDcX91M+kE4Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6xjQeOpkM/4WQkouPbCVZiCcbK8glJ0lRVARV6Hl+wgu2FXA5G8aKv3QeplyG10R
         3xajTIs4swufSlEZRozdt8XB2DJJtqXDa4Xc1+IE9oJpk7+aazWmOSDqBH0d1F5BMg
         aY/SAFiZrRsJy1JRrIs1TB7xwtmXbWtoqX1qJvXg=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/2] media: i2c: imx415: Use v4l2_subdev_get_fmt()
Date:   Wed, 30 Aug 2023 10:23:23 +0530
Message-Id: <20230830045323.71768-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230830045323.71768-1-umang.jain@ideasonboard.com>
References: <20230830045323.71768-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx415 driver uses the subdev active state, there's
no need to implement the .get_fmt() operation manually. Use
the v4l2_subdev_get_fmt() helper instead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx415.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index 3f00172df3cc..9a7ac81edc28 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -842,15 +842,6 @@ static int imx415_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int imx415_get_format(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_state *state,
-			     struct v4l2_subdev_format *fmt)
-{
-	fmt->format = *v4l2_subdev_get_pad_format(sd, state, fmt->pad);
-
-	return 0;
-}
-
 static int imx415_set_format(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state,
 			     struct v4l2_subdev_format *fmt)
@@ -913,7 +904,7 @@ static const struct v4l2_subdev_video_ops imx415_subdev_video_ops = {
 static const struct v4l2_subdev_pad_ops imx415_subdev_pad_ops = {
 	.enum_mbus_code = imx415_enum_mbus_code,
 	.enum_frame_size = imx415_enum_frame_size,
-	.get_fmt = imx415_get_format,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = imx415_set_format,
 	.get_selection = imx415_get_selection,
 	.init_cfg = imx415_init_cfg,
-- 
2.41.0

