Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E280D491
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjLKRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345066AbjLKRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:59 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CC5CD;
        Mon, 11 Dec 2023 09:51:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so59319011fa.3;
        Mon, 11 Dec 2023 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317058; x=1702921858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3YUfzGsaBsOQXR1nI75uclXXzs9bCDdUPhKf4IBE2Q=;
        b=GvFMWsSqknLhstpCt60WroNMg+GRrecTOd7anjl1ExvUwRNmXGWRcmL41L+pNYNE0h
         +FCDjqk4vSrnqH+XfCEgMwcKYvv7FXxFAlOOspRjNFkXyFNaz+E5FrXrww//TscEE+PX
         yMmcWuMmU/zMY50y7DLfJ98D9xxcG0Vs0ci5nXhDCX5f9wb25FabbmoofCHCf50WnqLT
         gtqmayDLc6eJuAArqwW3Gqd9p/ICalpLTCAqcuTOXy2SMQ0CWM2YQXn2+KoB0WPDkQZy
         6bscfGTdXENY/BzJ9Dal/fQQXjZ6xl9Jmyx2OQLk7LSc7lymnnOiTb0y9c9515CO1Egn
         YDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317058; x=1702921858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3YUfzGsaBsOQXR1nI75uclXXzs9bCDdUPhKf4IBE2Q=;
        b=wkbgjaYZTfhjagHTPJdphRAA1itv/UiaabuurMw63L5DCpqidUanw790IYFsuEjrwW
         oKkxq15As0tA6Y4eOZT4E2Icvei1Z7yISgUBcBbf6M1oxZBH/LsYtNPx8QaJhxvuK42G
         IMKEVxQIpnIJ8Dd7GS2Bc0KtKo/OBEHHk2hD/1Cww1+8gCLpwMmfcmOKTRFh4FcQtlrV
         svcvTvlFC0Cf4QQCEVZIn29FQjFosZYMIgh7lIYVq8TBGOh+3o15ScF1PDxZvNv0XwcX
         +0ND0r8wolmwQJI+isMvsFIGriQElJtec/27OkbHTkcPPrSiDXBkbkdSLpHWsdKLbDcO
         Xlzw==
X-Gm-Message-State: AOJu0Yz95qHl/OF4Fl1Vc3QFX1mr9kMKu8tpWZNilxaNhBAS/QqJg+yB
        bGp1QCXB63i9JBo5V4QEmMal80EazvsjxvId
X-Google-Smtp-Source: AGHT+IEUTze6+kiPfuLFxTrJcm7nGoTnjUhsTepJG64TDBBAJ32AXfTumvsiddUwnDi5pJ9/MZhmBA==
X-Received: by 2002:a2e:5309:0:b0:2cc:275c:3dd1 with SMTP id h9-20020a2e5309000000b002cc275c3dd1mr314444ljb.57.1702317058477;
        Mon, 11 Dec 2023 09:50:58 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id r17-20020a2eb611000000b002c9f5039a86sm1280249ljn.87.2023.12.11.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:58 -0800 (PST)
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
Subject: [PATCH 12/19] media: i2c: ov4689: Implement digital gain control
Date:   Mon, 11 Dec 2023 20:50:15 +0300
Message-ID: <20231211175023.1680247-13-mike.rudenko@gmail.com>
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

The OV4689 sensor supports digital gain up to 16x. Implement
corresponding control in the driver. Default digital gain value is not
modified by this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 62aeae43d749..ed0ce1b9e55b 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -35,6 +35,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352A)
+#define OV4689_DIG_GAIN_MIN		1
+#define OV4689_DIG_GAIN_MAX		0x7fff
+#define OV4689_DIG_GAIN_STEP		1
+#define OV4689_DIG_GAIN_DEFAULT		0x800
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 
 	/* AEC PK */
 	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
-	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
 
 	/* ADC and analog control*/
 	{CCI_REG8(0x3603), 0x40},
@@ -622,6 +627,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 				OV4689_TIMING_FLIP_MASK,
 				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
 		break;
+	case V4L2_CID_DIGITAL_GAIN:
+		cci_write(regmap, OV4689_REG_DIG_GAIN, val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, val);
@@ -650,7 +658,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 13);
+	ret = v4l2_ctrl_handler_init(handler, 14);
 	if (ret)
 		return ret;
 
@@ -693,6 +701,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_DIGITAL_GAIN,
+			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
+			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0

