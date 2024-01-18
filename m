Return-Path: <linux-kernel+bounces-29874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA48314AA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D180283294
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAA2D7AE;
	Thu, 18 Jan 2024 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMUFabhc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785B1F610;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=gLd56l7LhY7Bf+1TH+4V7977DOmaSy1xuVS5t0fBlKb791pHLZlg1iCiNPXuylOp4+2E95g5E84oNMG49FFJAE+hlqnRGuMomy9U0cpF9R4l6cRSG6s3YyYKcgNzWjf4hJBPrWkT6okRYOD1xCa4dY9aD69DiK9YaSYGMXPzDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=axzOW/bLfk48A9ZCiMw4d+If5yhSQO0oy0KThVKKlAA=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=EUBxTFR2YXU9SBZPri9s3oaz3TOuWaZBaodDCFPSJgoK6oSB9FXzf5xq3hLaKRfaTNJ5czw+AQlqJZTSEeT+Dac1CgcpMBzSw4TAlUh3MeBdg7Z6oDN8Q2rVfnwukcNckA7xyIk8JB0I8L8GNICM/GtL5vy5OmsOycaITLBcJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMUFabhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB68BC4AF6F;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=axzOW/bLfk48A9ZCiMw4d+If5yhSQO0oy0KThVKKlAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IMUFabhcaF9kTdZCkkoQxd0wEEcKpz4gGOHSeo9fv8eWUqAaf9gVuCnubAmDvVcyk
	 ARUaiuDPVL/JQYTlBbEgFskUWvReXVFTaxZSCOPwPnCTQU5kk7b9+lhS0DPJ3gxObd
	 xrMpD6eim6gx1kYSEcu8dcp2iN23tk7ZRf8UvldnoYG+Or894xmU8xXPOnXIRdV93I
	 o8F8fpFuJGoam2fMRSqmDBmJEPE+9+f094ua0UyWYi2/oXdLLVOiCLmVLn0PHPaBcK
	 1zczJXtMr+N0leFxWHEyKg6lYPEbZhOnMRvAfJ0v7aA+KFRyPb+Dyr54XruUb4UqwX
	 46FJOI/YNyr/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC18C47DD6;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:21:08 +0300
Subject: [PATCH v7 25/39] wdt: ts72xx: add DT support for ts72xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-25-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=1140;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=1rWEe31MzZtFeQGF9K/nSefILZAuLYwUQNOfnETpfJQ=; =?utf-8?q?b=3D9Xpk5KuNgIps?=
 =?utf-8?q?Dd4rKPSMsKfKNPCjZK0ETNzmurGMDoVGObVMmlHsnFchMcYaOa7wFGUloM6rgxdn?=
 yGmp4GguDLck5fHmjU9czA+y5hL0aBv7/GkeEdHl4PkLWPWGGVqZ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ts72xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 3d57670befe1..ac709dc31a65 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
@@ -160,10 +161,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ts72xx_wdt_of_ids[] = {
+	{ .compatible = "technologic,ts7200-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ts72xx_wdt_of_ids);
+
 static struct platform_driver ts72xx_wdt_driver = {
 	.probe		= ts72xx_wdt_probe,
 	.driver		= {
 		.name	= "ts72xx-wdt",
+		.of_match_table = ts72xx_wdt_of_ids,
 	},
 };
 

-- 
2.41.0


