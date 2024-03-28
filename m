Return-Path: <linux-kernel+bounces-122332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31D88F552
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7251C27B34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A23BBEB;
	Thu, 28 Mar 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdCn67Y6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C363BBE6;
	Thu, 28 Mar 2024 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592575; cv=none; b=i+oMvwKJudVGtXSWAkvYSmYdMHit6NB0UVxkTvyEiT2I2KvXD5WIHpf9qHYk+S1fC2XbkwCyEzv+CoTOu+Us6J9G5Hw7i4MLKN7IDTAxCrCP0mxTwmQyDM0Gnu9Nz6/8iByIjUxTvIQ2gBIb3rbuki9CBQDt2LMjCqy+OhbOous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592575; c=relaxed/simple;
	bh=Txw5w1mXvAlE3ttKOsRB1KC6yqApC7+pEpAOdfCaZNg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6bLjZizRJXDTCaskTJEsp+YxqzbwsjZj7yY0gI5FL1efep1Co9Lz72cKZ1UwhNsVbuQfjhDv5Q6ilj8OTvFaDtRbNG63l+OmVUhK91exKT4sCgQiiC2NnCLP3glgNuYmy/7vSyopPqlCUrST+PmDaH503DZKxJBVUL4FnVbqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdCn67Y6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e709e0c123so483712b3a.1;
        Wed, 27 Mar 2024 19:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592573; x=1712197373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTnAwOa2uvPcM/ekFIY9I6q6Jkplpwwz1KPt6Wpm9+I=;
        b=PdCn67Y6d+JJCwJvJQ3zXSJBp+5qwsesAJLn7a6SsnNtdYuX0/W5cvogCpkTmzGQko
         SkIxQpwjYCl076BUxUVlnkt2jervBtl0IuAYTuZ8/9mHVgnKO7rK9QZbOOHbpixkxQkx
         qPBBXVsHfGjydG2CDGyggrAAjOwFKcDuZWNwzOWGUeWVu1Vx4cjRfj9nOMT8JWgbjT+q
         fT0ghGy2iuqmkwEWy6dQt8haUGaIeWNpPa1gjmRWiM85wToqIKyA1qe12snMwf8F63S9
         fg7uZy8tT6RmR7Y1BkrSskBFZ9EZwrI7NzsrYbN1tX5JHXVonq6HNRPXel+4LShVfTVy
         LcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592573; x=1712197373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTnAwOa2uvPcM/ekFIY9I6q6Jkplpwwz1KPt6Wpm9+I=;
        b=rz05bjzRmNI5C3rrQoutXVyw8YQmTHzMkQSbGshWMp8urucmL0pnpk52c6nSvjXt/1
         wKZj5UPs8i4wFJdnw6UTvv+OjSms+p1wd6vcioC/LG/ZnySHEuQZvIOTziOzoR9S8+CF
         y3eVCYT76SYOFdg2TTYSBwMVJFgxO8tcKdTjfp/fzYCbNhCxmdNuoNhHMYZJrgO4gjv3
         xcEPYHcp2kfoT9u57+US67zG9HWaPyvgiQG4X7gU4/h0I24xyUf7mVhuIOhRVOF1FxJL
         lLE5yJCUXvpsEK20L2zfXWroVuNP5i5GCgHb/5kvMS713HPt5BWer0f8SkOJL8KawE/l
         0TKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwsWKnHg01GpHlFl286D9IXEtSSeCi/LGG3KgqYhkiAJ2lsE2+cCRH/b2sYogxek6BJm37zN5KziEkkiSKyq8d8zheFg+odddwyAoKftsPORZnDULQXL6VBpXEGr72vLIpoxlvWlq+drX+wL73OhdwzwkZOpR0hJ35ZT0u3vsXBWOno575UoQb
X-Gm-Message-State: AOJu0Yz/PGUekI5YRR2/6YSYkaOaQHIXa4QMQkpn4JM4SoaUSQOg2+cu
	g3kfAIlD9LpexhqYJRXctyuE9UD3D8hUzWNkHDnKzPT8eEx4rl84
X-Google-Smtp-Source: AGHT+IHyluQj3/cCpsmHi5qOqzz/QMCSs1jG33c9hrW1m6MP1TsWwfE6CQM9fOkeDUivtVwLq6k/8A==
X-Received: by 2002:a05:6a00:4b4a:b0:6ea:c634:ca0f with SMTP id kr10-20020a056a004b4a00b006eac634ca0fmr1790243pfb.21.1711592573087;
        Wed, 27 Mar 2024 19:22:53 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e355-7eb0-17c6-c47d-d4ee-f9e8.emome-ip6.hinet.net. [2001:b400:e355:7eb0:17c6:c47d:d4ee:f9e8])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78699000000b006ea858ea901sm229256pfo.210.2024.03.27.19.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:22:52 -0700 (PDT)
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
Subject: [PATCH v6 4/4] drivers: watchdog: ast2500 and ast2600 support bootstatus
Date: Thu, 28 Mar 2024 10:22:31 +0800
Message-Id: <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
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
 drivers/watchdog/aspeed_wdt.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index b4773a6aaf8c..0e7ef860cbdc 100644
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
@@ -77,11 +79,19 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
 #define WDT_TIMEOUT_STATUS	0x10
 #define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
 #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
+#define   WDT_TIMEOUT_STATUS_EVENT		BIT(0)
 #define WDT_CLEAR_TIMEOUT_STATUS	0x14
 #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
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
@@ -330,6 +340,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "aspeed,scu");
+	if (IS_ERR(scu_base))
+		return PTR_ERR(scu_base);
+
 	wdt->wdd.info = &aspeed_wdt_info;
 
 	if (wdt->cfg->irq_mask) {
@@ -459,14 +474,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
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


