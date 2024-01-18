Return-Path: <linux-kernel+bounces-29856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E46E831495
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410F8B255BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B5288D7;
	Thu, 18 Jan 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny4yKgOh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2A125A6;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566179; cv=none; b=gqnKCeb7smX8ZwqCADRfozllBLzaEas2T88hSyhoKKYtcYp8ly3F7TPBA/lPjN1MQ87TImFoCu9ow73zsmwjcOW1jdK7O3DINrM2xCfqzRmowsD0rjHNhj89lm/K4+yyt33e5f6n0ayLcae+1ktgfIC1N7qOYU3+t01r0lXLng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566179; c=relaxed/simple;
	bh=r5b5AEVCSYZ5mC7ion+JuijTW0hSH+qXbQTw9BAVvjI=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=cd0qPKTQUZkknGsMFBsdJItUqUr8/iBeRxiiD80CZvvd6JZHptHTSDvV/zOuVr1Nny+nyfxid0yPE+Hlvv45SsgKYWT8JoCJDQ3bmL3GGZk9Z7HTbUMXhQ0zzf7aWRIlgeePisRKiLwcWFAY1iku/xplXfxWMpR0Vg6lDSp303Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny4yKgOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46BEBC32785;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566179;
	bh=r5b5AEVCSYZ5mC7ion+JuijTW0hSH+qXbQTw9BAVvjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ny4yKgOh0nZOTz66Jl6KMWHP6CrEwzNazPXglqD1StbyIX+5ES//qfnZ3hcy26ImF
	 aA1aKe8Ebhtet2/QHcw7vzrE4ts96rEd68hTdb0g3vLpPA/31F+SDPI0swHtYhUp9z
	 dKwNH6YNhl37fmcJs/NbRRud+Ur/mz92eabwrjP6+W9nI60orV8T0FQ4S2t+sURYB9
	 /t1lMF800TGNWXOHqaw/P1hYFp8LPDGcRCa5nw38XsMrQvHeFvT/VeSo05i2YlCS8e
	 MD4OkF8P0Wrk9iglVW/+RCY2tjQunfEINZbKpgw+Wvd5oLC/yO/TIbVqAzR92joJbO
	 UyxqduqhXQinA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C0EC47DA2;
	Thu, 18 Jan 2024 08:22:59 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:20:55 +0300
Subject: [PATCH v7 12/39] watchdog: ep93xx: add DT support for Cirrus
 EP93xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-12-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=1193;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=vpQ5XpDs4mC6MjpYUOCLjEKX9upQoF4eyWW0iqon84s=; =?utf-8?q?b=3DT7QZPx057YrW?=
 =?utf-8?q?gNU/WfzXs8XuYBj16fySSgmYNZl+MqH1j4FNvLXi9GGw8F6q/TNc9AN/cZi3CDbT?=
 2fuXCI52B909LA/5da3/v4Fevynzs0Bo8v0vQ7qG0+nyJitmJ0mZ
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


