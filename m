Return-Path: <linux-kernel+bounces-128379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF8895A19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AF31C21229
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952E15CD40;
	Tue,  2 Apr 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daC+otSK"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C9915B964;
	Tue,  2 Apr 2024 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076398; cv=none; b=FKj6X/hn4vu9z/CJzGW0y3r+Au2y6Zoe6021qUlzZu4JNjLnsIu4EapvJe/QOnoxK8KzM5jZPEZFQWSGJ5sgX47eetHzjC9b8LGqakzXM0z7Lt/shRdgj0UymmCqWz3z9PO/EWUYUBnH5aPQoh1aQjx5Ldya0x+QnFBu/93YEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076398; c=relaxed/simple;
	bh=VWMjBLtpezc1ufn9H4LnDcue5nHJTvgwtmgm7z5BxNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RssD8+HbEfKcHsJKM7K3q0pKtg5l4mih/8AY7H/QYOFpGQgyMM6QUZoGc4N/9d+F06EQmXUjroWjDnHdh5XiwdHp5lq3Kwesj0HqJL0F6oajGur4FQkdXbAHHsEgiPTo7Bfq1Iw4lfTWj1w24VFuvbvR+f1pvxqXF+Qvucc9UYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daC+otSK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515a81928faso6652539e87.1;
        Tue, 02 Apr 2024 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076394; x=1712681194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rs1fA8q8pnFFWd/L/CJUxBXCA40zHYc015Vko75nZtY=;
        b=daC+otSKDxguczD1GYIJ8CTVfcNyktaa6eHu+p/2ylc7Te7VTY3olGRhMVoqBpXIyb
         auvD/xDq6ATXHafRYQTURlawEP9N2koH6A5AxktqYeB7Z6ACwGsUIh13TCs2Pj43wdch
         yGb4LnYdFfRf9R2zdQoJqx+bBeM7GuZPcnyx8bMLRiEnCISLdHKyVhLsj4XeRBdWhAgj
         0/TWbx4s/qkyy3cclp5k+mdn3XLNDEI4Flf9ROnQIS304GIySCPh+nFWjl265mxSsAZV
         4ZAdUG9edGFyTAj+bhlZw2vgZI/K7wJSU2ngAb42Dt75Rzdshh8K6VEydYzPWzW5mS7I
         +PRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076394; x=1712681194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs1fA8q8pnFFWd/L/CJUxBXCA40zHYc015Vko75nZtY=;
        b=Vi6ruURzArunefZ0/D/+8w0T+zhWXOkbP0324UmOfFSh2Z4KlhpK13lKgkbFygPPCe
         Yx4I44BtytL9v/sfmwJcGxnneX6kdTB2b/FJWcArPcWx1c/0LbAf8vWVnNH20uWqU3RE
         aIWsjLTFDvdLaxlFAvMxWmXJkFDgjExMWcDbJ8tgBBHL044LBFcnB99hd+JAw7/HMciF
         3rSs4Tv8t2A9ZAp5uvNfPu4RMniK/Cbp5/s//o34ccWC0g65nRHDCy/kauqCyCQ+aalR
         iRh9fHQF7qh+C8WFSkybeu2FH3gXHbdRl8TMk+6nwVh8O23mMJq69PfPKOn60/UK12YB
         DXQw==
X-Forwarded-Encrypted: i=1; AJvYcCV278tlvDz+E8LyhIbmpke8S+c0yyN3zIjhCel3nn4qDbSWehOnl87CqZEEP8TBS5ounJ536iPob9OyUT+0WRvFkfPrHi62167jti0d
X-Gm-Message-State: AOJu0YzVJojonWnBe0knnIPk9DLaS+90CA1M6cRilFx4Jo6qk875HjPH
	pCiNiAzn16fGK5oAu7xyne2Drp6rWw7s7U/tjBH8yjoeyXfXkzLhyF8JIb2cyKrX7w==
X-Google-Smtp-Source: AGHT+IFEIJuyVR623EEA6SOpMPrrtjiNd0Tohl6Ot+9zEPdk+kD17XfUNs0f/L4gIRkk0v9LkkbRWw==
X-Received: by 2002:a19:2d5c:0:b0:513:172d:5b46 with SMTP id t28-20020a192d5c000000b00513172d5b46mr91663lft.39.1712076394101;
        Tue, 02 Apr 2024 09:46:34 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id h16-20020ac25970000000b00512b19d4908sm1759840lfp.307.2024.04.02.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:33 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 13/20] media: i2c: ov4689: Implement digital gain control
Date: Tue,  2 Apr 2024 19:45:44 +0300
Message-ID: <20240402164552.19171-14-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OV4689 sensor supports digital gain up to 16x. Implement
corresponding control in the driver. Default digital gain value is not
modified by this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 60c60bbfe3bb..d6be0856afe1 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -35,6 +35,12 @@
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_DIG_GAIN		CCI_REG16(0x352a)
+#define OV4689_DIG_GAIN_MIN		1
+#define OV4689_DIG_GAIN_MAX		0x7fff
+#define OV4689_DIG_GAIN_STEP		1
+#define OV4689_DIG_GAIN_DEFAULT		0x800
+
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
 #define OV4689_HTS_DIVIDER		4
 #define OV4689_HTS_MAX			0x7fff
@@ -131,7 +137,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 
 	/* AEC PK */
 	{CCI_REG8(0x3503), 0x04}, /* AEC_MANUAL gain_input_as_sensor_gain_format = 1 */
-	{CCI_REG8(0x352a), 0x08}, /* DIG_GAIN_FRAC_LONG dig_gain_long[14:8] = 0x08 (2x) */
 
 	/* ADC and analog control*/
 	{CCI_REG8(0x3603), 0x40},
@@ -624,6 +629,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 				OV4689_TIMING_FLIP_MASK,
 				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
 		break;
+	case V4L2_CID_DIGITAL_GAIN:
+		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -654,7 +662,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 12);
+	ret = v4l2_ctrl_handler_init(handler, 13);
 	if (ret)
 		return ret;
 
@@ -697,6 +705,10 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
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
2.44.0


