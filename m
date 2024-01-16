Return-Path: <linux-kernel+bounces-27071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B447B82E9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B90284150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDD10A3E;
	Tue, 16 Jan 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LViGTcfc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984CF10A30;
	Tue, 16 Jan 2024 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so7865739b3a.2;
        Mon, 15 Jan 2024 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389910; x=1705994710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFU8V44giJ9TqpBstuJqgsawkBd+gwhzF3e12FlfS0Q=;
        b=LViGTcfc+2hEbvVLqgu7Ab/c5GFEbJ0/EUnCWV8lyOw3B3ADs4nF0PiQZLFJ4QUIbX
         LEYWIC1n0zN1821+g0ruLZZVispET4bAdN4+YeDk/Az0VD/GQcdeehj5PjAWdR/LT+Ht
         tM5+huWXgNpzCMnp6RhYnEQERtanmoA1nGMcKsfYQw+pwcsfvb5F7DTkCxGNLb6guRgh
         EirO36KzzV/6aL+XjG65uWUP0r7cfO+ayaRmIUCebMT09e2Ji39CN9tlsLaU+PYdwvtr
         kr8/dixocCYYraGeDgyzAHk0pAhn7HmZy46gPhmJZTI47M7/urdd2aMl38etDGzqLq3r
         qdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389910; x=1705994710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFU8V44giJ9TqpBstuJqgsawkBd+gwhzF3e12FlfS0Q=;
        b=gI/ZxjuK+9HISimxIVUeBvUvIQqs8bLKj0DioJBHj/HE3vsuZcIa0YFIMso1Xe9JsK
         l+NMffYCwATkuFGs1Fb3Kzp6yM6emerjipkd6nDXrC3/xAKSlK9ffoSV8mydpnS9hoqo
         ZmdpqCbF740/veswIOWihUsrKWED3G9K1/FZ45oR+vKvdrm8yn3LZs7cd6YJGdwtNNEk
         KmEZUo13xnJx7WIRHSEKfEoUnCoPyS7PSRjOjE1ch200ohYI7oCuGODPmlPMXsDOEX3X
         an1XFMqUjn8aZ92sAH+VJwfX/ceCUNTxanAgz5CyNP/0ZKt2M18S61rOt3JlEnjmxVBD
         tbyw==
X-Gm-Message-State: AOJu0Yz7nRa9IUfr2RL8YbBbmtPSbmNR9T4XCe14LU4w/D9BIJRzeOhI
	C62H4yx9nNpuZZeIjjeP6xI=
X-Google-Smtp-Source: AGHT+IGAbSbVrbiKZ/CglJ3QzFOrQSx/78jF/361yQ4BQFSCLIL9XJjqe4MDGnOamYNJcFJWg6vmtQ==
X-Received: by 2002:a05:6a00:b4c:b0:6d9:b075:a7d6 with SMTP id p12-20020a056a000b4c00b006d9b075a7d6mr9267851pfo.19.1705389909792;
        Mon, 15 Jan 2024 23:25:09 -0800 (PST)
Received: from amiden.localdomain ([2402:e280:2243:161:4f40:49bc:8675:1a83])
        by smtp.gmail.com with ESMTPSA id t12-20020a056a00138c00b006d9ecb8e956sm8853148pfg.173.2024.01.15.23.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:25:09 -0800 (PST)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: pavel@ucw.cz
Cc: lee@kernel.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH] leds/pca963x: implement power management
Date: Tue, 16 Jan 2024 12:54:57 +0530
Message-ID: <20240116072457.383438-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements power management in upstream driver
for pca9633 which enables device sleep and resume
on system-wide sleep/hibernation

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
 drivers/leds/leds-pca963x.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 47223c850e4b..2474e40d8479 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -39,6 +39,7 @@
 #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
 #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */
 
+#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power mode, oscillator off */
 #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
 #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
 #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
@@ -380,6 +381,42 @@ static int pca963x_register_leds(struct i2c_client *client,
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pca963x_suspend(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg | (1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static int pca963x_resume(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg & ~(1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops pca963x_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pca963x_suspend, pca963x_resume)
+};
+
+static SIMPLE_DEV_PM_OPS(pca963x_pm, pca963x_suspend, pca963x_resume);
+
 static const struct of_device_id of_pca963x_match[] = {
 	{ .compatible = "nxp,pca9632", },
 	{ .compatible = "nxp,pca9633", },
@@ -430,6 +467,7 @@ static struct i2c_driver pca963x_driver = {
 	.driver = {
 		.name	= "leds-pca963x",
 		.of_match_table = of_pca963x_match,
+		.pm = &pca963x_pmops
 	},
 	.probe = pca963x_probe,
 	.id_table = pca963x_id,
-- 
2.43.0


