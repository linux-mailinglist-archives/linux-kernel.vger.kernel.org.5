Return-Path: <linux-kernel+bounces-80643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFDB866AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960B4285747
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C58335BC;
	Mon, 26 Feb 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApmiFZVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C141C2B2;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=UzAC4LU98NLVQI65YraP+LcJ9GBg/VehfPb2mZNu3xrKmvGvTq4ZGV123f5MQzpI9hv7OkBvbyymY3V1+gB8Jkxf2zX9OtNjGXN+G08lMzCOagS9fv1ofDSEo4CUyILaAEnvvh+PfUwdjiCh5/jPQlsYIAKagCPRrcDkRvKeQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=r5b5AEVCSYZ5mC7ion+JuijTW0hSH+qXbQTw9BAVvjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWaZChbXZUEReU2h4an//ktbLcV5opdJ7XHik1+FouhXPzEy8jdwMm+XwrokI/LIbGe/yomL9FTmk6SCEMN+2nMoRfPuXyHSw9xstXSb9JPypEChJ6UNLApOlc1q5tF5/sP19vPgOCXStRXhjA6tV+z8obvHxqiOKktm03pOF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApmiFZVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 622DEC32786;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932682;
	bh=r5b5AEVCSYZ5mC7ion+JuijTW0hSH+qXbQTw9BAVvjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ApmiFZVy3BZ9aZoaf56S6nH3v4Pe+BYL0Al8hhKj9aOqHwUnhpvljRRyqfWMBo/Ed
	 wz3kR1zw2UIC9jmsLPnsU8T9/kmy8+jWbuAbPR0fNZ8Of5Rrrid5REkKCSk6VWuJnK
	 W3KuVZ1sjkw+HZf93W1iKXCnuZWtnl9QEVHksLCtgBjekmmeiPclYNy3IIifZiFok0
	 tZh8KJTZj5/HIhChWKIwIHzGn7Qkg4q2MWpIjTff5CIak+p+vFxF6NbOlcR7SVnFHt
	 1/cCd5RWc8LpAsd2o7BxHFg0bay1Hipgm4l1lKyMy5cD8h13/dLTMOOfhVo2OAVRKE
	 d8tNePWVcfxRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D4C54E4F;
	Mon, 26 Feb 2024 07:31:22 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:30:07 +0300
Subject: [PATCH v8 11/38] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-11-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1193;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=vpQ5XpDs4mC6MjpYUOCLjEKX9upQoF4eyWW0iqon84s=; =?utf-8?q?b=3DzudkFc4p/VJx?=
 =?utf-8?q?BJoDE4nLTeBY86C4/TnNPxGKL+YoRuxBurVlWTVmV1gswdu6Ahl5wTpbiSDaU0WS?=
 gDMIBb/6BHP0SiTkBGJkxa/7DticBXk9jzJH3dKkkaCHugO0EZDJ
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add OF ID match table.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/watchdog/ep93xx_wdt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 59dfd7f6bf0b..af89b7bb8f66 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/watchdog.h>
 #include <linux/io.h>
@@ -127,9 +128,16 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_wdt_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-wdt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_wdt_of_ids);
+
 static struct platform_driver ep93xx_wdt_driver = {
 	.driver		= {
 		.name	= "ep93xx-wdt",
+		.of_match_table = ep93xx_wdt_of_ids,
 	},
 	.probe		= ep93xx_wdt_probe,
 };

-- 
2.41.0


