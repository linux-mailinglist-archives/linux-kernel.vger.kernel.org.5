Return-Path: <linux-kernel+bounces-70028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B318591FC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303C51F22BE2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD37E567;
	Sat, 17 Feb 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Pv1oJgBe"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0466DCF5;
	Sat, 17 Feb 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708197099; cv=none; b=qufFA+7vXvQiFXtSLX7dzUcfdxpqcpdyIt4IavlU01N1fUzzMIIQgZ2BODy+kawROFuKqiQff2c85zKdpBBdGuI/QcHyeZ6+hJ2fyynlWYL9DwpkRpBx1GwRDx52+WUInR3TRxW5QA75HxpMnA+kn834nSadWTpOF1Ul8pClZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708197099; c=relaxed/simple;
	bh=GXGNf/8UKXSGI7yOkkdhqhIWE80JGkrZF+91e9t4620=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QI5KOXMFox1wI+gssot3XSO2WmFd3KRriAHHqMj6QqglHRMUdX2lxf0n+bg6+e+Jn51JRgG3gVfxjlvK0Y3HS1wIN0f+f7IYpa5qWkqz7YtF9TzxW3zzoWk6ZptSvHS/QxR2q6DUZ0FMJxslxC5Q3MoAWRchPfW1Z/zuNt5naVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Pv1oJgBe; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708197094; bh=GXGNf/8UKXSGI7yOkkdhqhIWE80JGkrZF+91e9t4620=;
	h=From:To:Cc:Subject:Date:From;
	b=Pv1oJgBex+u11cRTONnBTCfm4kJcvGpqNkMhXzkPIkxQkAcGruP2BAM9PW0W7wCCu
	 GEmysxPg/OuZgVNd0aymo+T6JJNSOPfBBhYk7h5iCsCA0mP2HBkVmGotj5V7KlLUP+
	 xgYVbODzu9UApAVV5TQF5ri08rtaVMCWcG4AHOUI=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Raymond Hackley <raymondhackley@protonmail.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	linux-leds@vger.kernel.org (open list:LED SUBSYSTEM)
Subject: [PATCH] leds: sgm3140: Add missing timer cleanup and flash gpio control
Date: Sat, 17 Feb 2024 20:11:30 +0100
Message-ID: <20240217191133.1757553-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Enabling strobe and then setting brightness to 0 causes the driver to enter
invalid state after strobe end timer fires. We should cancel strobe mode
resources when changing brightness (aka torch mode).

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
I also have a sense the driver has other issues, like running regulator_disable
in atomic context, and lacking locking in general. But that's for another time.

I don't think this device is typically used from multiple threads/processes.
But writing strobe = 1 and then brightness = 0 affects real usecases.

 drivers/leds/flash/leds-sgm3140.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index eb648ff54b4e..db0ac6641954 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -114,8 +114,11 @@ static int sgm3140_brightness_set(struct led_classdev *led_cdev,
 				"failed to enable regulator: %d\n", ret);
 			return ret;
 		}
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 1);
 	} else {
+		del_timer_sync(&priv->powerdown_timer);
+		gpiod_set_value_cansleep(priv->flash_gpio, 0);
 		gpiod_set_value_cansleep(priv->enable_gpio, 0);
 		ret = regulator_disable(priv->vin_regulator);
 		if (ret) {
-- 
2.43.0


