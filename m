Return-Path: <linux-kernel+bounces-105717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6A87E360
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB051C20B47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F062209D;
	Mon, 18 Mar 2024 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssq9KoyX"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E5219E4;
	Mon, 18 Mar 2024 05:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741147; cv=none; b=nV4GbPX4AQDkBG0NIdk/KWBJNi86xz0TCu0eVLqsQ77lFMbJFfxPIOACkxUSK+O+rKOWYbLbq79+y5MY9dnACCEEhZ989WhN/xH/Ei8TWXzb4UkSr/pAzlbY8gmDeecEfDgL/g5oF7IvJFNkfxgfcWzykMgVn+tk1/TQUpDc2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741147; c=relaxed/simple;
	bh=kVtWJwmgGzGWFvVb5ZU5qxatxchEdFKYX19+Ui8XHf8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fmWRUarBsM6jwRLYhwKcpshxRccp9rYF9dMiNJZUnT986t0Dlyh7teOa//vfi6vn/9ys5GvTdSqld8LY6JogzbfCZBeoabCpnmjpgg+TPttwd/NF7f1OyxSIIdlYiTJtLKQ1VAJolJBoXD9o7b4K4S6co5arWVXpvQAfJn10COM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssq9KoyX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1deefb08b9eso13489335ad.3;
        Sun, 17 Mar 2024 22:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710741145; x=1711345945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=90ypWIse8KDEw4JedjK1HuYEeI8yW2/WFlhRVCHxDPE=;
        b=Ssq9KoyXvSNwFSNBZvq3TNUjNZ20FHtZe0n0Yl31PW3giYPWC0pCNjysxf+GOB6QOQ
         EEC7mOa10jMilQ/nr6KyQ6kcl4sxwP3x3PlDLZKwHmdMxWxbQWTqse5etFzMDKB/aFwi
         OGmk5JmLEG6Ob2ljR72ELBwbwkYGxuJidgFIsL/OLyTpoNtpoN1X2G/HrLGt4ZPQOAEc
         yHYvML9yvJg6OPJ0qJS7YgPcuhSm0ZOu6fp7c9nQBOCEl6tWq7zolR5aEjcg9+mPCpg7
         g3zvLNEUted+sd3JZvOLTfzAinRRNvPBcEMXnSIqEPCXbkcBP5yJ6ZaJbZL3qq3RvY6S
         Odfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710741145; x=1711345945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90ypWIse8KDEw4JedjK1HuYEeI8yW2/WFlhRVCHxDPE=;
        b=I5O5l6NnOHhDZDKgyYPCq5LrxVoq0CA95I61cWxihHzgiGAtzOzln+5WQIGhCPCCqz
         9Xd9wyQ316LscHs/15XePIDu+1n79E2QFNh3ScU0BORjxUEPp2x8qHrgckWtFMiVdRYF
         bJQBHYDLO2rcyizoxSigCbyzf6EBP08PUCZWuLXTxs2sDQxgxt1ZiWB4H1+AHXoXgSQI
         5BiVOfnvI0gSHbMdPhSBJa1ZUUDgbsj85ntcuTriZn+giUp5Md//BChxXSmGk9AZr52T
         SpJ0Q9X9bZwdpGTO7BJiWaF21Z/4EGvgcXYs+RyJauPgJvvzswi6+WSVy22sXiZ69vZN
         EB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIH5d1h69IWRFZ2WK6n2CYbT58pCPD2vyQb0mU+cnvMvjGgWMCxoiJML/P1/YwxfuT2MhZ909GSiB5w+fDE0mOwglSelfgB+BXifjeNIaKNSnhPFOYS3S+X+2Fiw19o9/3p4UNrdHIg9qjtY60YYbf9CiINFVG8HpgkyuOtp6nSCEjFMV4ij8n
X-Gm-Message-State: AOJu0YzGL2qCDBLlDLOsVaZc55ILflfXncGTqRepUXjn+tEZV45tcUOQ
	FeHyhxPX+3okXXSVdVRj7ZdBhMrbailRY5eJnNCa8lWWo9HBRD4VLBFFZd0j
X-Google-Smtp-Source: AGHT+IEzjVGGcpD2wdQdh4nNr8UA/bFIGmLYxCfglYwg6FzxomdZCRU5LfqgjRQaFqyKaDckZNH2Sg==
X-Received: by 2002:a17:902:c412:b0:1dd:76f0:4455 with SMTP id k18-20020a170902c41200b001dd76f04455mr13656970plk.49.1710741145494;
        Sun, 17 Mar 2024 22:52:25 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e454-a466-01a3-78b9-4898-3442.emome-ip6.hinet.net. [2001:b400:e454:a466:1a3:78b9:4898:3442])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902da8900b001dd6c0800b4sm3975907plx.188.2024.03.17.22.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:52:25 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2] drivers: watchdog: ast2600 support bootstatus
Date: Mon, 18 Mar 2024 13:52:19 +0800
Message-Id: <20240318055219.3460121-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. To verify the second boot source,
we need to check SEC14 bit 12 and bit 13.
The bits 8-23 in the WDTn Timeout Status Register are the Watchdog
Event Count, which we can use to verify WDIOF_EXTERN1.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Change log:

v1 -> v2
  - Add comment and support WDIOF_CARDRESET in ast2600

v1
  - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi |  8 ++---
 drivers/watchdog/aspeed_wdt.c           | 45 ++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index e0b44498269f..23ae7f0430e9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -556,24 +556,24 @@ uart5: serial@1e784000 {
 
 			wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2600-wdt";
-				reg = <0x1e785000 0x40>;
+				reg = <0x1e785000 0x40>, <0x1e6f2000 0x20>;
 			};
 
 			wdt2: watchdog@1e785040 {
 				compatible = "aspeed,ast2600-wdt";
-				reg = <0x1e785040 0x40>;
+				reg = <0x1e785040 0x40>, <0x1e6f2000 0x020>;
 				status = "disabled";
 			};
 
 			wdt3: watchdog@1e785080 {
 				compatible = "aspeed,ast2600-wdt";
-				reg = <0x1e785080 0x40>;
+				reg = <0x1e785080 0x40>, <0x1e6f2000 0x020>;
 				status = "disabled";
 			};
 
 			wdt4: watchdog@1e7850c0 {
 				compatible = "aspeed,ast2600-wdt";
-				reg = <0x1e7850C0 0x40>;
+				reg = <0x1e7850C0 0x40>, <0x1e6f2000 0x020>;
 				status = "disabled";
 			};
 
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..65118e461130 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -33,6 +33,7 @@ struct aspeed_wdt {
 	void __iomem		*base;
 	u32			ctrl;
 	const struct aspeed_wdt_config *cfg;
+	void __iomem		*sec_base;
 };
 
 static const struct aspeed_wdt_config ast2400_config = {
@@ -82,6 +83,15 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
 
+/*
+ * Only Ast2600 support
+ */
+#define   WDT_EVENT_COUNTER_MASK	(0xFFF << 8)
+#define   WDT_SECURE_ENGINE_STATUS	(0x14)
+#define   ABR_IMAGE_SOURCE		BIT(12)
+#define   ABR_IMAGE_SOURCE_SPI		BIT(13)
+#define   SECOND_BOOT_ENABLE		BIT(14)
+
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -313,6 +323,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const char *reset_type;
 	u32 duration;
 	u32 status;
+	u32 sec_st;
 	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
@@ -330,6 +341,12 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		wdt->sec_base = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(wdt->sec_base))
+			return PTR_ERR(wdt->sec_base);
+	}
+
 	wdt->wdd.info = &aspeed_wdt_info;
 
 	if (wdt->cfg->irq_mask) {
@@ -459,12 +476,30 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		/*
+		 * The WDTn Timeout Status Register bit 1 is reserved.
+		 * To verify the second boot source,
+		 * we need to check SEC14 bit 12 and bit 13.
+		 */
+		sec_st = readl(wdt->sec_base + WDT_SECURE_ENGINE_STATUS);
+		if( sec_st & SECOND_BOOT_ENABLE)
+			if (sec_st & ABR_IMAGE_SOURCE ||
+			    sec_st & ABR_IMAGE_SOURCE_SPI)
+				wdt->wdd.bootstatus |= WDIOF_CARDRESET;
+
+		/*
+		 * To check Watchdog Event Count for WDIOF_EXTERN1
+		 */
+		if (status & WDT_EVENT_COUNTER_MASK) {
+			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+		}
+	} else {
+		wdt->wdd.groups = bswitch_groups;
+
+		if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
 	}
 
 	dev_set_drvdata(dev, wdt);
-- 
2.25.1


