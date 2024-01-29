Return-Path: <linux-kernel+bounces-42599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E277884039C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6A1285874
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C15DF1E;
	Mon, 29 Jan 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+YWEDC3"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF045D725;
	Mon, 29 Jan 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526920; cv=none; b=AllQLDxeizvoxr/JDz8ILjqArOjm+2ZGqkQNYRGdZ/srSRv4/ljsyGSMu8dVb3YUtQaZR+15uBMdkZwgFmAa+hrqPrWSTh292Qf4v+syUFrtkLBtIteBq3m0nvwt6zdPfBTbgUMMFF2etlxB8RqYrVtzpJJy0KptrYkmwaxPrY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526920; c=relaxed/simple;
	bh=tf5Q0HIbO4qTabgW0ywf4WwR+VLIcexBLSXGEFNXWSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNkCWUaHNDsPHQlLNTjSi8Zgk41MAvv/wUxNECOVjhaAM9GZ0GYELbHPP2POy++Ka2GJJTcMauxqXj9JCbkFPIxdyN36HA9106P3nuSbmwoXlP9Vie8aYqfZDqIwkgj+3Ue8svgDJBzR/vUYhKSGRk+1n+0Tqt6jESmu9NAY4+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+YWEDC3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8e7ebbbadso2618235ad.3;
        Mon, 29 Jan 2024 03:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706526918; x=1707131718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7scJMGxeFHrcGgXPLEWFIweNtSat17qmnJuRxoKTd0Y=;
        b=G+YWEDC3CoRMcjRO/YMPmX7lBTRhutGX0sH/JqFIIlZeIts00Q3GJNa5m9IqouYxPc
         t6pEYI2tz8hgG8AyKYneyEukiLJxiyca0cUt3bSRXJME/n63qkH6XDOuXpD3MV5lTXJo
         FZ5vxwAXIlXGwe9Sq+C1Ac3B6DsjhHbjdQPpnUNC5GcaD/oviwWF2chbxPTSCTQnlRen
         HZwMWc8lHPdO+n5c9O8LJKvCQ46xtrTU21Wjs+cNKMnZO3gm6KWxXc4qNvz1U4m/jXb2
         E7HMDptNhtSTECRwQBsd1+FrgMbgbHAJtkTOlnPI3DZbZQMZNvx4AH4yXqyzjporQuPx
         98+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526918; x=1707131718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7scJMGxeFHrcGgXPLEWFIweNtSat17qmnJuRxoKTd0Y=;
        b=DIOdRFrhDon1R5KNz6N1pmcioYS2egtqDNEzsrBqUTgXBXcZSTqLtJ+kpUPsgcnusS
         FSjCl5tjurmmP0iPG2lZ4sdSIbzScRMds0e+cOYzN+lYtH7M5Xq3k8TmddpBNKZY4K7X
         zVZxMOVXQ/JSoiviR9c8N+pQRLO1p3ASZ58VfwtIlqOSLjlQJRRxT8cOJMQfR28bU1QS
         PG7fJkEh4hosGzoilSHLrrJI3xwQZu2EiQC92iuc/fRrzkMFmAVosts1U94B118GJU9F
         ri5VCy2cD6yS0LznVUwvmqqf720GbApNDgSFfAqps13UOza6wKuXhwACxjHFG05v5dm5
         JvSQ==
X-Gm-Message-State: AOJu0YxyEbEGpT8qymR18ogujD7d7Yu8WO1Xe6nsRf1d/jaRQvpkeWsf
	4VnO7TMzhCveB9xWvepzT4TGZtTFZUT1D49dlZqWJqssKA4kxgoj
X-Google-Smtp-Source: AGHT+IFvXX4X2fhRJiLfvsjdhKeTqwEJL7/3Zm8hG3tmqNGudgqdTwzkbfiRHFPbuJ05EB4lVChLQw==
X-Received: by 2002:a17:903:41cf:b0:1d8:f07a:ba78 with SMTP id u15-20020a17090341cf00b001d8f07aba78mr629036ple.55.1706526918293;
        Mon, 29 Jan 2024 03:15:18 -0800 (PST)
Received: from amiden.localdomain ([2402:e280:2243:161:f722:9af3:1e16:1363])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79892000000b006d9a13b491csm5501124pfl.212.2024.01.29.03.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:15:17 -0800 (PST)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH v2] leds/pca963x: implement power management
Date: Mon, 29 Jan 2024 16:45:05 +0530
Message-ID: <20240129111505.196068-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements power management for pca9633
which enables device sleep and resume on system-wide
sleep/hibernation

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 drivers/leds/leds-pca963x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 47223c850e4b..227f24ba2ca2 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -39,6 +39,7 @@
 #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
 #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
 
+#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode, oscillator off */
 #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
 #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
 #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
@@ -380,6 +381,34 @@ static int pca963x_register_leds(struct i2c_client *client,
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pca963x_suspend(struct device *dev)
+{
+	struct pca963x *chip = dev_get_drvdata(dev);
+	u8 reg;
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg | BIT(PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static int pca963x_resume(struct device *dev)
+{
+	struct pca963x *chip = dev_get_drvdata(dev);
+	u8 reg;
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg & ~BIT(PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);
+
 static const struct of_device_id of_pca963x_match[] = {
 	{ .compatible = "nxp,pca9632", },
 	{ .compatible = "nxp,pca9633", },
@@ -430,6 +459,7 @@ static struct i2c_driver pca963x_driver = {
 	.driver = {
 		.name	= "leds-pca963x",
 		.of_match_table = of_pca963x_match,
+		.pm = &pca963x_pm
 	},
 	.probe = pca963x_probe,
 	.id_table = pca963x_id,
-- 
2.43.0


