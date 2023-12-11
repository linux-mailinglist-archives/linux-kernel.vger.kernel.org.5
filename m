Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5A80D492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbjLKRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjLKRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A4F4;
        Mon, 11 Dec 2023 09:51:02 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so59262231fa.2;
        Mon, 11 Dec 2023 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317060; x=1702921860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZV+qykvCHEWTicA8pud0kxh1xP8XT+s6VE1pgxnwgAs=;
        b=nXddlOjKA7x/J0WEj/achhmSAow85xddAX76If+PlbriwksNZ194VYPuAJgnIPY00u
         H0HCZX0YCZlB9VsezCuazu/Ru6fS8z887AcTy48Tr7fZxVEirHLp0kthBgH4SAfczUMf
         LpeY/3GyULA/FC1C26QoiDLE6J78P8KElouljtsV4NhzaT7A+jcE+/ohsBP/ydm0T2V6
         3y3LbfhY17p6fxL5hKZrdDWbVDPKUxsBaKIaXmKGhzCjq3NDubt2oDxSZ1Fd/Gs/Fovz
         eu61bRQhVOmef/pPklBhI5GAPHhI7nVovhFlYzn0QoNuqgkj9ObnBFCQxfkNs0uWkp7D
         1DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317060; x=1702921860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV+qykvCHEWTicA8pud0kxh1xP8XT+s6VE1pgxnwgAs=;
        b=URr/RQAcwL3t+ClsjbKcGBY8EM0hBvQgRBh8WSZ1rIb0HAXpGRSacsFFoH0Pks/RIq
         HktgDl3gcK5WBtQkQb4xjGQuESbjbc7F5RLovkOx7bkMb9XHFLcCkh0IR0/etRjU9Q1G
         vRwoXJQar14Hb5E77CRrTrXyfZDWMc4d8z0mh1zz0Z35GLNClsCMzKI9uiUwQX3mwnue
         3m/R4TPKhFXMNK3Od+P4w87jlgtckwCaCgKY58W+7aBLVHZOaP5XEuiWKty3rJlPI1Jc
         Hh/fUosu08FLWXCeR1zD+jFUZKOafPNlQJrAFDhgqeCIJATSN7TcuqrRH38OHrWbGI5x
         BpSg==
X-Gm-Message-State: AOJu0YwLFfqEPVqkMMkFCSO8k694ItczbQL/XCFcGcachrSNBkdteG1S
        FIWXqqXH9WI58ll4OkVXR6lm5V2L8jwDSwIV
X-Google-Smtp-Source: AGHT+IEccW+UpLdSJWpoAvmT80r9rc8lBNJIOQ/CbsEYPYa9E0E5gq2P8EHnKFR5xIY7HoxeUXzViQ==
X-Received: by 2002:a2e:a178:0:b0:2c9:fa32:4261 with SMTP id u24-20020a2ea178000000b002c9fa324261mr1222745ljl.60.1702317059731;
        Mon, 11 Dec 2023 09:50:59 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id s14-20020a05651c200e00b002c9f3e0a075sm1296088ljo.55.2023.12.11.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:59 -0800 (PST)
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
Subject: [PATCH 13/19] media: i2c: ov4689: Implement manual color balance controls
Date:   Mon, 11 Dec 2023 20:50:16 +0300
Message-ID: <20231211175023.1680247-14-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OV4689 sensor has separate red and blue gain settings (up to
4x). Implement appropriate controls in the driver. Default gain values
are not modified.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index ed0ce1b9e55b..18e1fd564ec0 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -41,6 +41,13 @@
 #define OV4689_DIG_GAIN_STEP		1
 #define OV4689_DIG_GAIN_DEFAULT		0x800
 
+#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
+#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
+#define OV4689_WB_GAIN_MIN		1
+#define OV4689_WB_GAIN_MAX		0xfff
+#define OV4689_WB_GAIN_STEP		1
+#define OV4689_WB_GAIN_DEFAULT		0x400
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -630,6 +637,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_DIGITAL_GAIN:
 		cci_write(regmap, OV4689_REG_DIG_GAIN, val, &ret);
 		break;
+	case V4L2_CID_RED_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_RED, val, &ret);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, val);
@@ -658,7 +671,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 14);
+	ret = v4l2_ctrl_handler_init(handler, 16);
 	if (ret)
 		return ret;
 
@@ -705,6 +718,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
 			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0

