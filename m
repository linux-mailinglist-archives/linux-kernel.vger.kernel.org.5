Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C778D2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbjH3Exr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbjH3Exh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:53:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A1CCF;
        Tue, 29 Aug 2023 21:53:34 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.251.226.104])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B0B0DE2;
        Wed, 30 Aug 2023 06:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693371131;
        bh=towQ2H8NltBDF1fWdRSieCZdXaLAdwWxSAFfmDmWsPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XN1KbXqnzUAvU7z3lR47hd0EFM2KRoPBsQnwa96lsSkVH4ZSMmyHLsBLKxnxFQZNU
         ifIK+qLkQ/Q88iHd+03H/r7ovnfua0BESSj+sPkxSxAf4I8W9gd44p9DoUM84JZe8x
         gCKykoLh1zLoHuoowanGqDXaDADNbpWXqt/IB2eI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 1/2] media: i2c: imx214: Use v4l2_subdev_get_fmt()
Date:   Wed, 30 Aug 2023 10:23:22 +0530
Message-Id: <20230830045323.71768-2-umang.jain@ideasonboard.com>
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

The imx214 driver uses the subdev active state, there's no
need to implement the .get_fmt() operation manually. Use the
v4l2_subdev_get_fmt() helper instead.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx214.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 2f9c8582f940..d8bdc52f552a 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -548,21 +548,6 @@ __imx214_get_pad_format(struct imx214 *imx214,
 	}
 }
 
-static int imx214_get_format(struct v4l2_subdev *sd,
-			     struct v4l2_subdev_state *sd_state,
-			     struct v4l2_subdev_format *format)
-{
-	struct imx214 *imx214 = to_imx214(sd);
-
-	mutex_lock(&imx214->mutex);
-	format->format = *__imx214_get_pad_format(imx214, sd_state,
-						  format->pad,
-						  format->which);
-	mutex_unlock(&imx214->mutex);
-
-	return 0;
-}
-
 static struct v4l2_rect *
 __imx214_get_pad_crop(struct imx214 *imx214,
 		      struct v4l2_subdev_state *sd_state,
@@ -842,7 +827,7 @@ static const struct v4l2_subdev_pad_ops imx214_subdev_pad_ops = {
 	.enum_mbus_code = imx214_enum_mbus_code,
 	.enum_frame_size = imx214_enum_frame_size,
 	.enum_frame_interval = imx214_enum_frame_interval,
-	.get_fmt = imx214_get_format,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = imx214_set_format,
 	.get_selection = imx214_get_selection,
 	.init_cfg = imx214_entity_init_cfg,
-- 
2.41.0

