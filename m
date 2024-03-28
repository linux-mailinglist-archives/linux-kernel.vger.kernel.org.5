Return-Path: <linux-kernel+bounces-122284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56588F4BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE502287624
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C335D2B9C1;
	Thu, 28 Mar 2024 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5LBGQ2h"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95524208DA;
	Thu, 28 Mar 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589607; cv=none; b=JLeMsstzNc+8GQbtGpGreH/sm6FrZh6kOnGQHTavmncsFxl2rhVPmS9O8ONK9XeZOhZULXeyy9uyP+fcZsU3Sg50hTIEDvp/nZyfU085/A3KqkEFfdtbU12j0yc+jid64B77FK2PHd9XayCQubyYk1ENJpFLrzCWCmrM6gUNJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589607; c=relaxed/simple;
	bh=e6LmR+kcXCwdJyinw0c4KFjrt9Hcyg2W04CBm0MAL98=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQCmhW6nv6my63e6sTO4Nzovk7eM57nljYvUq4qZVIK77J7HlCGp9+DN92YSd1L1dwh+7cRLYzjIEjNKzmR9PqdfOUXR2FprWBF8DaSkZF+T6KryPiI3nTTpiGAttswZzrgtupqf/LyBHYc7R9UHkAddlHfYdGXV2I50Yppamvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5LBGQ2h; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0bfc42783so4312125ad.0;
        Wed, 27 Mar 2024 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589604; x=1712194404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0IynxA3JbozA3TAjnZstACddkpz8hoX6OU7xoU+2fw=;
        b=g5LBGQ2hbTsfaVuTZbsjdgM2Ol2VGbVU+9qzcchBq9TLOCZr0PvIrcFR5YSZNp30BH
         ECT7P9RWvi5d/ow3xY5VDAgp4SvLAM1yNG0w/+YCZ5Lj/sZdHnayogwhTGNEcG/wO3EO
         IDQiBaic+uIs9Y/KcJuR01VyHQb0IORw6lbQJ/oxEKBORY15l8ixKrBSRcX2VitdGBUu
         XlgD33VI49FQSApY9NUwDqf2mmsUuy2NT1NrPkdzwi2Bc1lQOPGZH3iJF2MyuhVpXvT5
         X7dBYrv7mfV9MON03uj0MErAU/CZTcmufHJRL1jbmEpE3No3aS9y5MNOfbrHBDtPp2pj
         COpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589604; x=1712194404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0IynxA3JbozA3TAjnZstACddkpz8hoX6OU7xoU+2fw=;
        b=QvzNAskWlHqNnSo2MtAWULJvw7Pq01w0C8nr6OrSPlju5mWUvIYm5UZ/oGsJDcg7F2
         9jrhJAoXLWmNA3pGvO5B/+JYoqIFhiVRm6VkXWEmmVMXEDClhdIDgYO0VLxuytB4P5dd
         1ATVyswNCP6hqrKlch+zxOf9poExO1jPyqF//iFnz3nevphwezcUsmK+O2znTCY+7jNA
         sAug6SAlgkH2k7Sg3jZpQ7FFOoPY+QuhAU+fbBetWNALlnVMwGaH9SQA9g/hOwEBzSsm
         PQote36hR1yjGQI29Ze14IdSnOL7Y3BgrA26/LW5rmPcnz7Wm2gDwh9MH7NzJ/glYipJ
         Zk2g==
X-Forwarded-Encrypted: i=1; AJvYcCXGaWvYL5Zh+5h1/OFhGfBj3CI/jMDE+se+sFFIQd/ncTa3vzFWTsP+gIvuoM1FFpFVa564bdEDKBgPsMAn/28KtOngXMqC1x07YPCVSr+kcPnHnw3iRcFIUss1ZkvT7aytzksvKVqRF9RKuR0Zg81m2ieYLiSxJdN/i7alCpHpYlNNUhLIQZMR
X-Gm-Message-State: AOJu0Yx5obrgJ7juDaox8yVCH3HJAMCIHh+zVkJfvTp4PFZ2EUhVAxZj
	sVKC/qIVdIYeFkV4HRInT5zAMr1T58OC+37UQgOkE9/tsYtLHlLg
X-Google-Smtp-Source: AGHT+IErqe1JgPY/tC+iEEwyWTtpp/xy7QUKcZTy0vIiStxw4d/K5SUR+QGLZAGX83Ujl4LUNDIuFw==
X-Received: by 2002:a17:903:8cc:b0:1e0:a2cf:62f2 with SMTP id lk12-20020a17090308cc00b001e0a2cf62f2mr1579482plb.23.1711589604023;
        Wed, 27 Mar 2024 18:33:24 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-b4d0-66d2-2269-ef6c.emome-ip6.hinet.net. [2001:b400:e355:7eb0:b4d0:66d2:2269:ef6c])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001e0e85a21f5sm201338plg.32.2024.03.27.18.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:33:23 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Thu, 28 Mar 2024 09:33:02 +0800
Message-Id: <20240328013303.3609385-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
References: <20240328013303.3609385-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600

Regarding the AST2600 specification, the WDTn Timeout Status Register
(WDT10) has bit 1 reserved. Bit 1 of the status register indicates
on ast2500 if the boot was from the second boot source.
It does not indicate that the most recent reset was triggered by
the watchdog. The code should just be changed to set WDIOF_CARDRESET
if bit 0 of the status register is set.

Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
ast2500 SCU3C when bit1 is set.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 drivers/watchdog/aspeed_wdt.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..c3c8098c035d 100644
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
@@ -82,6 +84,13 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_RESET_MASK1		0x1c
 #define WDT_RESET_MASK2		0x20
 
+/*
+ * Ast2600 SCU74 bit1 is External reset flag
+ * Ast2500 SCU3C bit1 is External reset flag
+ */
+#define AST2500_SYSTEM_RESET_EVENT	0x3C
+#define AST2600_SYSTEM_RESET_EVENT	0x74
+#define   EXTERN_RESET_FLAG		BIT(1)
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
  * enabled), specifically:
@@ -330,6 +339,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "aspeed,scu");
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
 	wdt->wdd.info = &aspeed_wdt_info;
 
 	if (wdt->cfg->irq_mask) {
@@ -459,14 +473,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 
 	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
-	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
+	if (status & WDT_TIMEOUT_STATUS_EVENT)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
-		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
-		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
-			wdt->wdd.groups = bswitch_groups;
+	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
+		ret = regmap_read(scu_base,
+				  AST2600_SYSTEM_RESET_EVENT,
+				  &status);
+	} else {
+		ret = regmap_read(scu_base,
+				  AST2500_SYSTEM_RESET_EVENT,
+				  &status);
+		wdt->wdd.groups = bswitch_groups;
 	}
 
+	/*
+	 * Reset cause by Extern Reset
+	 */
+	if (status & EXTERN_RESET_FLAG && !ret)
+		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
+
 	dev_set_drvdata(dev, wdt);
 
 	return devm_watchdog_register_device(dev, &wdt->wdd);
-- 
2.25.1


