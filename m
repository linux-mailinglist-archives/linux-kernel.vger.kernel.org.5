Return-Path: <linux-kernel+bounces-158247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E781B8B1D78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EE8B25990
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C985293;
	Thu, 25 Apr 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVbxElZX"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC618526C;
	Thu, 25 Apr 2024 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036057; cv=none; b=DWEn4K0I8wy2s/CX0bUy870B2N3lbo2HKJ0N8aha3YLafmES/QQUD/7bHvo4/6T5oFrJcIBSJfPQcWMh6jqC2VKe4ofnsYXIvkbDkD+e5SjnFZuq1V534bcreDXqpIsd6ksbR5rwH1DTp+VwPaEIuQiMWT7jtrMogaWHnWppbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036057; c=relaxed/simple;
	bh=J9zpMjgX641/ha7upheVUaN23xc/7Lgx5lf5coU6wa8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dE7CTMTbwo6Rk5KlyoJxf0xRXQIUnFCF3rGhn9PfVmFR98NAx/B9v0W+YFk6wqJ/i089GshG58KEC6K7Bd+AyJbaua+ITc/Myc/kGlhmPKi3le2Jn7s3IEKPd6/jIsEFf7vDxaWqJCqstcFBvYvx6ajkQchMIQwtfWp7ydh9kx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVbxElZX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1289001b3a.1;
        Thu, 25 Apr 2024 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036055; x=1714640855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4wTUU05Xd7j3sy440urBnEwP2fHUD5P7kgF0xvHMjc=;
        b=fVbxElZXiRSOWpBb6By7Kj33JVed+cenqi1u0J27LubgSuYGkN+DkUDUIp3vrF8YB1
         xFG/smZrhRjCXREphxjcU6iwJ5X1QnAEEPSa7aADo/sipSpLwpjI2mQXTvA/QBxktzgR
         zWlWOiRDtvXubN3bPTEUjnu9LRkla2Gc8tilLf2YCGzQqAzhcU5hjC3u5z+JmNyBIfiq
         apcwK2bLkeMyDbzIgCz9eOQFRKBUGgJOrxS8PY94RFXeAOj7z7BAg3lz0/+iTv3T65gw
         qDVA4YalTI5L68+u6v5cglveo/iYBBNFLCajf9JNPP7Vnldh0ja3qoDB8kHZHbj8OCDh
         NDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036055; x=1714640855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4wTUU05Xd7j3sy440urBnEwP2fHUD5P7kgF0xvHMjc=;
        b=UFLMzNsNRfeW3uCZaklMYKRXMN9NXbWOTDUvLSNlW8CytZQ+qCXXmYTNUQ3OafcgLl
         g9T4fBVYsrUzrz+cXfV/kiNWQF1HKXsWs99RUBxdGt45yub1FDAKXubF5NkNo5caIVGv
         sKepStQllWb91sTpcl5YLs/o1/xHNrWzHGiZNz0hkHFGgVpSCiOvxw75hibA7QOw77ib
         1829Jv1K7aTxqhZp11/h3x9HDmAGsQWtrV76zE4PrBQYupt4yrQpKuxF+mznioSsNGzX
         DOWyB3/79K176QDVXAMQXeZnTUVNinOvnzRxT7Ti+fkyRmUtFfRs2cQeXbytSanC+Pxz
         EPxA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJcMqJB/crArg3rbWaA4GB6bCvyGd9dktD+CHTxfeeV3JO4ackEeyWY8VNtiIHm9pt9kDAG9X1qSOfLJNZcX1yrj6SDfjGfBFYhS9z+c6XyDHp9k3+2ChqdAnDVXthl6NhTPzjGnKRGpgIbc=
X-Gm-Message-State: AOJu0YwcRTwIA65SAlQZHku2K6QhKZCeHE4/5mqg0cwl0grGmakF1ZoW
	uqukoxRW53LdpmK9FALlD9OK4RteDBsqg1SDTUnd2+dK01MDxrRGIMORSA==
X-Google-Smtp-Source: AGHT+IH00G50r60em0IVFLInu1mkzKCgJhWo7ypEjI8FeXomqiULAZ2cCuQIn+gE3UsYxotvJkPddw==
X-Received: by 2002:a17:90a:7306:b0:2a2:9e5d:9bf9 with SMTP id m6-20020a17090a730600b002a29e5d9bf9mr3363222pjk.8.1714036055337;
        Thu, 25 Apr 2024 02:07:35 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e339-24b8-1743-5d70-cc45-1c02.emome-ip6.hinet.net. [2001:b400:e339:24b8:1743:5d70:cc45:1c02])
        by smtp.gmail.com with ESMTPSA id g21-20020a17090a7d1500b002a574ab7f5esm12489938pjl.53.2024.04.25.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:07:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
Date: Thu, 25 Apr 2024 17:07:26 +0800
Message-Id: <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set. However, this bit can be clear when
watchdog register 0x0c bit1(Reset System after timeout) is enabled.
Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
in ast2600 SCU74 or ast2400/ast2500 SCU3C.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
 1 file changed, 103 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..4c58593658bc 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -11,10 +11,12 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/watchdog.h>
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -82,6 +84,16 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
 
+//AST SCU Register
+#define AST2400_AST2500_SYSTEM_RESET_EVENT	0x3C
+#define   AST2400_WATCHDOG_RESET_FLAG	BIT(1)
+#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
+#define   AST2500_WATCHDOG_RESET_FLAG	GENMASK(4, 2)
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+#define   POWERON_RESET_FLAG		BIT(0)
+#define   EXTERN_RESET_FLAG		BIT(1)
+#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
+
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -310,6 +322,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	const struct of_device_id *ofdid;
 	struct aspeed_wdt *wdt;
 	struct device_node *np;
+	struct regmap *scu_base;
 	const char *reset_type;
 	u32 duration;
 	u32 status;
@@ -458,15 +471,99 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
-	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
-		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+	/*
+	 * Power on reset is set when triggered by AC or SRSRST.
+	 * Thereforce, we clear flag to ensure
+	 * next boot cause is a real watchdog case.
+	 * We use the external reset flag to determine
+	 * if it is an external reset or card reset
+	 */
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2600-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2600_WATCHDOG_RESET_FLAG) {
+			if(status & EXTERN_RESET_FLAG)
+				wdt->wdd.bootstatus = WDIOF_EXTERN1;
+			else
+				wdt->wdd.bootstatus = WDIOF_CARDRESET;
+		}
+		status = AST2600_WATCHDOG_RESET_FLAG |
+			 POWERON_RESET_FLAG |
+			 EXTERN_RESET_FLAG;
+
+		ret = regmap_write(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  status);
+	} else if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2500-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2500_WATCHDOG_RESET_FLAG) {
+			if(status & EXTERN_RESET_FLAG)
+				wdt->wdd.bootstatus = WDIOF_EXTERN1;
+			else
+				wdt->wdd.bootstatus = WDIOF_CARDRESET;
+		}
+
+		status = AST2500_WATCHDOG_RESET_FLAG |
+			 POWERON_RESET_FLAG |
+			 EXTERN_RESET_FLAG;
+
+		ret = regmap_write(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  status);
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+		wdt->wdd.groups = bswitch_groups;
+	} else {
+		scu_base = syscon_regmap_lookup_by_compatible(
+							"aspeed,ast2400-scu");
+		if (IS_ERR(scu_base))
+			return PTR_ERR(scu_base);
+
+		ret = regmap_read(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		if (ret)
+			return ret;
+		/*
+		 * Ast2400 external reset can clear watdog dog rest flag, so
+		 * only support WDIOF_CARDRESET
+		 */
+		if ((status & POWERON_RESET_FLAG) == 0 &&
+		     status & AST2400_WATCHDOG_RESET_FLAG)
+			wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
+		status = AST2400_RESET_FLAG_CLEAR;
+
+		ret = regmap_write(scu_base,
+				  AST2400_AST2500_SYSTEM_RESET_EVENT,
+				  status);
+
+		wdt->wdd.groups = bswitch_groups;
 	}
 
+	if (ret)
+		return ret;
+
 	dev_set_drvdata(dev, wdt);
 
 	return devm_watchdog_register_device(dev, &wdt->wdd);
-- 
2.25.1


