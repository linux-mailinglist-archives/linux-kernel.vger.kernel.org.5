Return-Path: <linux-kernel+bounces-161376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D335B8B4B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C42B214DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E4542053;
	Sun, 28 Apr 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5JYYEMA"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5E3BB3D;
	Sun, 28 Apr 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301321; cv=none; b=ECWqbTUSJi8mKFhEJTLXH9qELKyCZp8zlVqXcR5zgI5bauyktZSTxD5xa9H4b46Yy/NnCYpY4m6gj6RuewRGGg2bImrC25fpRC7oYvPKvNOIs9FsL9/R7A5OA6p6EzoExJ1Zqu2N0o17qsPZwsb+es/13P9AzD7QU9kIphIy23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301321; c=relaxed/simple;
	bh=yHfnhevvABtbYT0VDo7iO8XzoHMalScnR2cRW91uPg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=reld7mCU6WBLSV5t2E1WWdSVW27XhndsmSyjVaSHGsLFfJoZnVyDoyUksCZ1naLqrfZK8QoUuZ/q+fUFxyYWhgwQA6FMMry2aBWsbGMuSv0WuCuUcQTUeh+Ks2oXh7F69X8gn0kmGlTA23OZxjejU4zcTyHBOsYa6sxBc/W8794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5JYYEMA; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518f8a69f82so4010263e87.2;
        Sun, 28 Apr 2024 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714301317; x=1714906117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bhd2a0Eqkp8IZ1N8LLGEseQKkeOBndMtMGE0U0sjq4=;
        b=a5JYYEMANNNeLdytFr0gMuM2ckU1f0LnZXZ+h1D3LGdIxq4YCQmZZPw5QZWjxEsCMa
         vOseIyOJEceAkOze7OGx3waH6dOYbDJqF40ZIUp6kfIu1DhN1nEbRyG3xzhybQELsjDQ
         83n2ap041LKyxQQwmI16CLHuExjcVUqFwW1oI+rn6l8PFFMNiW6I0P+a/Et5h3xBN97u
         x+y9OeQoVhqtr6zQpcEvwy2kJ1xwtFnD+e7olpkALSXCc2hfG+Qgd9LaVR0qBwKxSvIN
         ya+sqArxSzKsdmK5bhRzT0HqUgTN3Tyk7DyabwIuzZ/UfnQimqD3XerBoM/GbF8F7K2w
         9IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714301317; x=1714906117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bhd2a0Eqkp8IZ1N8LLGEseQKkeOBndMtMGE0U0sjq4=;
        b=er5hS9CCE9AMhAcmyBl4I7aV51o6hA7MTiiFqfJRZIB1Zio2W/1XvIWTqf3DcHb69K
         INVcpsQZWzpNu8d1oUF00ERLAlTjm80+/KYMfK6nGQigYyv0ChpdhzR9vDzy30UGCEXG
         DtQtqcWO29PlUYXYtyYbZ0ZV4SyOXsEB2iux3/XoqhLo5ew/rDwHVvMavkioqKas61GZ
         1cwQuHClkWbAajs6zC1zi9hilu1p/trbtlciJdsvgW5qAopWrHF5LTrF+ai2uWFYjV3y
         TeDSQawuVq9u0TABmZSUdfFmqBr1JxdIACYKPHQ56AWa2M6cyFLgTOVvJAqs8S4HjaQ1
         9cSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxsQpE4GuHw+8eCHdWbkrwky0dqqXSz9O3qMn69p5hWqR+sEJ0zN++o7+kbObAIaOf2jJvr+HAsvsZDfPrk+uM9iCK9BCGvin8WRJuackQp5PIbpQDgdx4l968OXzzbpf8tQw4pLw0
X-Gm-Message-State: AOJu0Yy5GKHVzjzCkWGld7jUU8eDBKj2mkG73I0s0R1uyKmFDWmqh8ia
	AqkHeFnlQ3TpANkLlWJDpxG9sMRTJ66BBhf7GtQFjmCxTTUoUNrE4aUnC46NNC4=
X-Google-Smtp-Source: AGHT+IGFy2rpKDP2QWpbh6F3/fB9mB0IFdQoSnPSV7jqoDjPmJKD6CEfQysZupVB+LWbBD5KWkwE2A==
X-Received: by 2002:a19:5f19:0:b0:51b:e0f0:e4f8 with SMTP id t25-20020a195f19000000b0051be0f0e4f8mr2956818lfb.31.1714301316809;
        Sun, 28 Apr 2024 03:48:36 -0700 (PDT)
Received: from fedora.. (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041c24321934sm1268352wmq.41.2024.04.28.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:48:36 -0700 (PDT)
From: Aleksa Savic <savicaleksa83@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jonas Malaco <jonas@protocubo.io>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (nzxt-kraken3) Decouple device names from kinds
Date: Sun, 28 Apr 2024 12:48:10 +0200
Message-ID: <20240428104812.14037-2-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428104812.14037-1-savicaleksa83@gmail.com>
References: <20240428104812.14037-1-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the support of new models, for which the relationship
between device name (for hwmon and debugfs) and kind (for the selection
of appropriate code paths within this driver) will no longer be 1:1.

Originally-from: Jonas Malaco <jonas@protocubo.io>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 drivers/hwmon/nzxt-kraken3.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/nzxt-kraken3.c b/drivers/hwmon/nzxt-kraken3.c
index 5806a3f32bcb..571087e3fd3e 100644
--- a/drivers/hwmon/nzxt-kraken3.c
+++ b/drivers/hwmon/nzxt-kraken3.c
@@ -27,11 +27,6 @@
 enum kinds { X53, Z53 } __packed;
 enum pwm_enable { off, manual, curve } __packed;
 
-static const char *const kraken3_device_names[] = {
-	[X53] = "x53",
-	[Z53] = "z53",
-};
-
 #define DRIVER_NAME		"nzxt_kraken3"
 #define STATUS_REPORT_ID	0x75
 #define FIRMWARE_REPORT_ID	0x11
@@ -849,14 +844,14 @@ static int firmware_version_show(struct seq_file *seqf, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(firmware_version);
 
-static void kraken3_debugfs_init(struct kraken3_data *priv)
+static void kraken3_debugfs_init(struct kraken3_data *priv, const char *device_name)
 {
 	char name[64];
 
 	if (!priv->firmware_version[0])
 		return;		/* Nothing to display in debugfs */
 
-	scnprintf(name, sizeof(name), "%s_%s-%s", DRIVER_NAME, kraken3_device_names[priv->kind],
+	scnprintf(name, sizeof(name), "%s_%s-%s", DRIVER_NAME, device_name,
 		  dev_name(&priv->hdev->dev));
 
 	priv->debugfs = debugfs_create_dir(name, NULL);
@@ -866,6 +861,7 @@ static void kraken3_debugfs_init(struct kraken3_data *priv)
 static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct kraken3_data *priv;
+	const char *device_name;
 	int ret;
 
 	priv = devm_kzalloc(&hdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -905,9 +901,11 @@ static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id
 	case USB_PRODUCT_ID_X53:
 	case USB_PRODUCT_ID_X53_SECOND:
 		priv->kind = X53;
+		device_name = "x53";
 		break;
 	case USB_PRODUCT_ID_Z53:
 		priv->kind = Z53;
+		device_name = "z53";
 		break;
 	default:
 		break;
@@ -936,8 +934,7 @@ static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id
 	if (ret < 0)
 		hid_warn(hdev, "fw version request failed with %d\n", ret);
 
-	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev,
-							  kraken3_device_names[priv->kind], priv,
+	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, device_name, priv,
 							  &kraken3_chip_info, kraken3_groups);
 	if (IS_ERR(priv->hwmon_dev)) {
 		ret = PTR_ERR(priv->hwmon_dev);
@@ -945,7 +942,7 @@ static int kraken3_probe(struct hid_device *hdev, const struct hid_device_id *id
 		goto fail_and_close;
 	}
 
-	kraken3_debugfs_init(priv);
+	kraken3_debugfs_init(priv, device_name);
 
 	return 0;
 
-- 
2.44.0


