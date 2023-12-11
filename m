Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246F280D484
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbjLKRvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344797AbjLKRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:48 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ACFD8;
        Mon, 11 Dec 2023 09:50:54 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so59317491fa.3;
        Mon, 11 Dec 2023 09:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317052; x=1702921852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNY858fptfzHBCj2MypAYw/Wf6IpNmLWS0ucyNJkm2A=;
        b=eWLScynttCeFKklww37oAkdqxr3wBwT2+pBCyDOTRqUKxPoOrXq1EUt+zdFnqAx6Zc
         6Zp8BwLzCM1tkBUew7uqhtEDSsB+xYOt9a5KnfwyrZMslxfihiroXdpQiMLzLNE6IwPN
         XVeJ1aQ9gLDxAEDCq2sb4/Il/wqIrZ3ZXzdH4AjlQrBoL2pJuZOUAqgNKYIg9FEBFQDd
         p99ydF7l5qcqrnBRBsJk91Wt32Xh787GT1PMIPef8WRaa65MqTUSJQDwQRZrOrOQPnCR
         HrGzCpAbC4PHiecnJtXuamTvpcMTNDdzZn0Ywf//tvYzikEmBOE5vBQpCP7bwBebpMiG
         OZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317052; x=1702921852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNY858fptfzHBCj2MypAYw/Wf6IpNmLWS0ucyNJkm2A=;
        b=HmFBsbMi56YrGIICwnCndgUSCuCx0E38Ac4a6p9J1W6/sb3mT98x4O2Cexulo0QTdC
         nvMAdHWfUeUj76ZVUsskSy/Fjg0m0vVlQrOdczKsSS+mMaWMwbr4SaaYzGcXIuK1ja1F
         oa01saVB3q9HvujK3y+5Gur8lEAFrjd70JLb+vXFzJUCy18tadaUwL+W44YklR3LxMaF
         CEFCJ0uDooCtBcHpQKSo0fmd420SW1ab/d+l/Q3FlOeCe0cJv5cJkrF0Wqau3rmtWbUk
         uawJYq/t4fhMr6KWKVyE7YjUVaVLKoXsbod0O7uBbhbff2AK2CegwoKw/rUuZX88iUUa
         uyUA==
X-Gm-Message-State: AOJu0YyCm5547Stu1AZ59ZM7SvWJ33ZRh9pFCcdo9PHfNoWIS3etPbfQ
        eEWL2FS7uRU7vR4r1EkZzvn0M0ZRH2cnHxIZ
X-Google-Smtp-Source: AGHT+IH26GtRvX/KgEuwocMcOiixU+UU/MaEbyQx18L+a9Mob6SQ0CLGoU2SnAAFJy/Z4duQpho9dw==
X-Received: by 2002:a19:655a:0:b0:50b:fe63:ef9 with SMTP id c26-20020a19655a000000b0050bfe630ef9mr1413617lfj.73.1702317051775;
        Mon, 11 Dec 2023 09:50:51 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b0050bfdb13929sm1130734lfe.73.2023.12.11.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:51 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 07/19] media: i2c: ov4689: Use sub-device active state
Date:   Mon, 11 Dec 2023 20:50:10 +0300
Message-ID: <20231211175023.1680247-8-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sub-device active state. Employ control handler lock to
synchronize access to the active state and s_stream.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 68 +++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 41 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 5392f650960c..2eef64cd0070 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -86,7 +86,6 @@ struct ov4689 {
 
 	u32 clock_rate;
 
-	struct mutex mutex; /* lock to protect ctrls and cur_mode */
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *exposure;
 
@@ -319,19 +318,6 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ov4689_get_fmt(struct v4l2_subdev *sd,
-			  struct v4l2_subdev_state *sd_state,
-			  struct v4l2_subdev_format *fmt)
-{
-	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
-	struct ov4689 *ov4689 = to_ov4689(sd);
-
-	/* only one mode supported for now */
-	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
-
-	return 0;
-}
-
 static int ov4689_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
@@ -405,10 +391,11 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_subdev_state *sd_state;
 	struct device *dev = ov4689->dev;
 	int ret = 0;
 
-	mutex_lock(&ov4689->mutex);
+	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
 
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
@@ -443,7 +430,7 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 	}
 
 unlock_and_return:
-	mutex_unlock(&ov4689->mutex);
+	v4l2_subdev_unlock_state(sd_state);
 
 	return ret;
 }
@@ -506,19 +493,15 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
 	return 0;
 }
 
-static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+static int ov4689_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *sd_state)
 {
-	struct ov4689 *ov4689 = to_ov4689(sd);
-	struct v4l2_mbus_framefmt *try_fmt;
-
-	mutex_lock(&ov4689->mutex);
+	struct v4l2_mbus_framefmt *try_fmt =
+		v4l2_subdev_state_get_format(sd_state, 0);
 
-	try_fmt = v4l2_subdev_state_get_format(fh->state, 0);
 	/* Initialize try_fmt */
 	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
 
-	mutex_unlock(&ov4689->mutex);
-
 	return 0;
 }
 
@@ -526,18 +509,15 @@ static const struct dev_pm_ops ov4689_pm_ops = {
 	SET_RUNTIME_PM_OPS(ov4689_power_off, ov4689_power_on, NULL)
 };
 
-static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
-	.open = ov4689_open,
-};
-
 static const struct v4l2_subdev_video_ops ov4689_video_ops = {
 	.s_stream = ov4689_s_stream,
 };
 
 static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
+	.init_cfg = ov4689_init_cfg,
 	.enum_mbus_code = ov4689_enum_mbus_code,
 	.enum_frame_size = ov4689_enum_frame_sizes,
-	.get_fmt = ov4689_get_fmt,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ov4689_set_fmt,
 	.get_selection = ov4689_get_selection,
 };
@@ -649,7 +629,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	ret = v4l2_ctrl_handler_init(handler, 10);
 	if (ret)
 		return ret;
-	handler->lock = &ov4689->mutex;
 
 	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
 				      link_freq_menu_items);
@@ -862,13 +841,14 @@ static int ov4689_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				     "Failed to get power regulators\n");
 
-	mutex_init(&ov4689->mutex);
-
 	sd = &ov4689->subdev;
 	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
+
 	ret = ov4689_initialize_controls(ov4689);
-	if (ret)
-		goto err_destroy_mutex;
+	if (ret) {
+		dev_err(dev, "Failed to initialize controls\n");
+		return ret;
+	}
 
 	ret = ov4689_power_on(dev);
 	if (ret)
@@ -878,19 +858,26 @@ static int ov4689_probe(struct i2c_client *client)
 	if (ret)
 		goto err_power_off;
 
-	sd->internal_ops = &ov4689_internal_ops;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
 	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
-	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
 	if (ret < 0)
 		goto err_power_off;
 
+	sd->state_lock = ov4689->ctrl_handler.lock;
+	ret = v4l2_subdev_init_finalize(sd);
+
+	if (ret) {
+		dev_err(dev, "Could not register v4l2 device\n");
+		goto err_clean_entity;
+	}
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
-		goto err_clean_entity;
+		goto err_clean_subdev;
 	}
 
 	pm_runtime_set_active(dev);
@@ -899,14 +886,14 @@ static int ov4689_probe(struct i2c_client *client)
 
 	return 0;
 
+err_clean_subdev:
+	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
 err_power_off:
 	ov4689_power_off(dev);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
-err_destroy_mutex:
-	mutex_destroy(&ov4689->mutex);
 
 	return ret;
 }
@@ -918,9 +905,8 @@ static void ov4689_remove(struct i2c_client *client)
 
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
-
+	v4l2_subdev_cleanup(sd);
 	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
-	mutex_destroy(&ov4689->mutex);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.43.0

