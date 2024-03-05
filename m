Return-Path: <linux-kernel+bounces-92356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705C6871F08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BA628763B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE75B660;
	Tue,  5 Mar 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="YgK6NkcV"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383C5A7BF;
	Tue,  5 Mar 2024 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641291; cv=none; b=AQ6UYvHYU1yQ29T/5Ai6cuadjhDanItvaWSf20XXrhEfOL0DWx5+XerFoyPnqc/eF/ZyIAV0m6LiucFtKQrMrNP39IyHif4+4xdM8/5woQXlgh4YLmKyB7pIbl7CVxWjE1RRQy/0rvlMLJ7dwrbOsylmT4ZldxCixW1uHAthK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641291; c=relaxed/simple;
	bh=zA1QI3pTmF4PVrGfMGQ4T6AJuBZkkUOxdUv7rVLqvq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nz7kYky820fdOILkwplylmQZQEPVjALFx5LnVgQRREigF+HI0r3cB9MUyg0cOtcWT5k49u7n/3IN99pEjtrpixDgmlYYzFjw8C/ZktHVeafr2I/ys+vyJUBXqzCv1gdrXEwWWQ5WfdTrlcdrDoj1kWITc6RJDQAI1e1/IqnBsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=YgK6NkcV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4594423a12.1;
        Tue, 05 Mar 2024 04:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641289; x=1710246089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEx+zb9TSgK4yB6p6tHYNUfZEDI6oNw+ZcHBjx9ShfU=;
        b=RHwX4XeTzRqIcVDP0sPxA97P9Ic5w7V54Mn8E09KDaANsj/VogTaqWz7st6k+LcbUR
         RHI1M6stmE7hcQEZOvjeA68717rxWOtTSK8NZwu93UUnJP/uAU0xCOl5F12753hkhG+g
         oXYhl6M+QExS7/bHEhnL1iEMpW0y8DwnE3vEWmZ/6OHAjuj/J7LLi/mA/xfoqJY1ffuc
         lCCyLYxe8ByPEZj5w9rpZK/CbUmZBVlTRw4sz8GNXM/a4X9nPE22vY/mLKW9K8vhK6Ch
         W67Ql98EuBKHkiyM3P55WjEQP1jx0bkgCckMFC+fNGO7/IzlqoeNyRRkYf+8PLpHDy8b
         br7A==
X-Forwarded-Encrypted: i=1; AJvYcCWXs82xVYHmp2/rczeBddjTQskHqk3OoqnH4DEEBK7Y5Nc1kJFqZKyn0Lbo7haY0VfmezYfpNa/i+wGf0LuuCfRCcIo43vFp7GjwBZgNy/hOBfuyCWpjZB9V78FCR9VssKTT3THRsBFrUc=
X-Gm-Message-State: AOJu0Yz3Z8Y2i7DkKpf5sODPIJXBl8qIGI4NzHfqx6BZmtsBc/GMxJ9p
	iakhNyzc9wEdbG7eF8Z+4CAq33mXahxXPNxZgJ+EitP9XQxKX1kA
X-Google-Smtp-Source: AGHT+IGmOCmr/nPchd/IbKo+mLmdiGP2sn/dFWTak1HHJNlB1jMqv56PTesOXkry/3ewNFEhPLEIng==
X-Received: by 2002:a17:902:da86:b0:1dd:2bc2:ed25 with SMTP id j6-20020a170902da8600b001dd2bc2ed25mr1645988plx.42.1709641288888;
        Tue, 05 Mar 2024 04:21:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902e9c400b001d7252fef6bsm10369231plk.299.2024.03.05.04.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:21:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709641287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEx+zb9TSgK4yB6p6tHYNUfZEDI6oNw+ZcHBjx9ShfU=;
	b=YgK6NkcV2HDpRzMn7ctoup6zYb4x8csJ7THtUKcJzzjJ8RcVsmDRAsPh4Yfvkh2QaPSsaE
	JzOn9WH/glkdghz21tc3GPWUrUDeE7BnH2ybn4ms06a+w72XsjUDASvRLOFLWL+rBPg9ef
	fh+GPzYNlr3V+Kl7meY8aFAlHLT3PrDL8yPha+WydzDgR8udWGjKKBvVsABH45S0HIts00
	m6unjkmPUmZbjwEqDDOro6CmzU3Rso4OEfHdrv0WfT9loTGwFFs4J+EM4O6PhKpTylotpa
	qLFXuvR0MWsh/pmh7Zl048oqbcMUfKrzja8mzI0FWCoq/M7E5Gq0UxYlMJ+c/Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 09:21:18 -0300
Subject: [PATCH 2/2] video: backlight: lcd: make lcd_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-backlight-v1-2-c0e15cc25be1@marliere.net>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
In-Reply-To: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=zA1QI3pTmF4PVrGfMGQ4T6AJuBZkkUOxdUv7rVLqvq8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5w4+iSyNLDZC3tRX7TPpVThd4AQXUWdlE0ijV
 xMPTkgRv36JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecOPgAKCRDJC4p8Y4ZY
 pobYD/4jQPHj7hJi/so8GQHNZhM9h2mU0OKK45lxlhm1Q3dv8hDKlVyL9rq7nXJl4ST4ztys0VI
 trz7QE3BfAjjJqPjqFyxGRXNNGG9DCAjc5iYeMao8xiYOIDrXQWikf81wWNtJJ2jPWmBVIfQgQ3
 qksMZFWx5vVy7oITR3JGVurioxGUV8/MkG7CbiaLqyboIRMseZ5K+I9PIK1QIQ+u26knlbcsIEC
 WC0fckurcLyEnqXEd+ILPgiXzMpm6RpdvZQB058YL9sSkgkFEzg53EtaoeyM2f4yyLv4p/j9tUG
 sybiXdf+j9AXLbKebqkgrJ1oy3k+2F/9CpqO3GfOOfDTqhkheUhALj1B6cpiuMdyxuQe9KoLeAU
 VPXSNHC+Hz4hx2irj88cHO2aYFFRQXIUSYO4Di4Q0b4xYNTGMnV5M8iDAQ1WMFRYVpRMJoD4vcl
 7j3OyKLoRjiF2tUzyc7cK3UsOEEvmv5qD+u45T6y+Gv1nZ6KKfytun2qzJYjm/w7m5wIFjH/EER
 uf6f/GhL3OcKs/MLSRkBETzFm4hPdZJrc9fmZCfV+Pes0dEfGYYlvEIrQRL4bL/SNeZ33AN3OVp
 Ti8gaoYCLznvyG71OlDEdm9Sor7/Tr0kwK8fA1Sco+2c1XHKdYjlrv2ko835i16JDo5RFgu6F+8
 CCmkHoOql2/vOgw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the lcd_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/video/backlight/lcd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 77c5cb2a44e2..ba4771cbd781 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -159,8 +159,6 @@ static ssize_t max_contrast_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_contrast);
 
-static struct class *lcd_class;
-
 static void lcd_device_release(struct device *dev)
 {
 	struct lcd_device *ld = to_lcd_device(dev);
@@ -175,6 +173,11 @@ static struct attribute *lcd_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(lcd_device);
 
+static const struct class lcd_class = {
+	.name = "lcd",
+	.dev_groups = lcd_device_groups,
+};
+
 /**
  * lcd_device_register - register a new object of lcd_device class.
  * @name: the name of the new object(must be the same as the name of the
@@ -202,7 +205,7 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
 	mutex_init(&new_ld->ops_lock);
 	mutex_init(&new_ld->update_lock);
 
-	new_ld->dev.class = lcd_class;
+	new_ld->dev.class = &lcd_class;
 	new_ld->dev.parent = parent;
 	new_ld->dev.release = lcd_device_release;
 	dev_set_name(&new_ld->dev, "%s", name);
@@ -318,19 +321,19 @@ EXPORT_SYMBOL(devm_lcd_device_unregister);
 
 static void __exit lcd_class_exit(void)
 {
-	class_destroy(lcd_class);
+	class_unregister(&lcd_class);
 }
 
 static int __init lcd_class_init(void)
 {
-	lcd_class = class_create("lcd");
-	if (IS_ERR(lcd_class)) {
-		pr_warn("Unable to create backlight class; errno = %ld\n",
-			PTR_ERR(lcd_class));
-		return PTR_ERR(lcd_class);
+	int ret;
+
+	ret = class_register(&lcd_class);
+	if (ret) {
+		pr_warn("Unable to create backlight class; errno = %d\n", ret);
+		return ret;
 	}
 
-	lcd_class->dev_groups = lcd_device_groups;
 	return 0;
 }
 

-- 
2.43.0


