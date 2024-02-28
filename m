Return-Path: <linux-kernel+bounces-84780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8A86AB79
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEDD1C21D26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FD2E64F;
	Wed, 28 Feb 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrBkc9Da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2B2E635;
	Wed, 28 Feb 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113120; cv=none; b=Vz1tQdrwNK26w+KnAO9vowzo7HjE+iL0MDHc6lMzEp+QGmxlEtgEvP2IcJwN7YrSYWOzlAFkVoKVRt15+xJpO7I9zJxurHlL/rzUsEALoZi9AuonZzIpd7A75EWuVeQrERqjxDyt6cPqKhAW323qCJx1bD0A2RdmXA0xXg7xl54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113120; c=relaxed/simple;
	bh=s0eA/dog/BIyORieb5kXF1PEAqm7fES6Z5v+ym+lFOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WAb+UOZPsIk+VTdsVc4gzwT4Fa5J1MWdWiFYUwDCSbQ9iCuEHkvRjPVQMpevXEBmV2MtaslQPbEPU2gTKl+UvvGw5+lpz2q3zZDuD608FqXqotvwRZ/JqjPQ3hQi91+2gK8ATFnsO11YBrP4vBnIqHwfvx7UFeijLmG+2q7ixrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrBkc9Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D4EC433F1;
	Wed, 28 Feb 2024 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709113120;
	bh=s0eA/dog/BIyORieb5kXF1PEAqm7fES6Z5v+ym+lFOk=;
	h=From:To:Cc:Subject:Date:From;
	b=FrBkc9DaRryR/jXV9gywA49xnynLya6TnzHXID1+9nIUYGXeHuSBPQDgFzWrOyd0s
	 Psu9Wt168ud26SN2nUWG7fM7gBvG7aoRiOFB3/V+m8RK2EmfczRb534/D5Yj2PX9oW
	 0SM/dfBWows5H5aICQinkMD59RQRaEogvh7DCvfZCbD/FqCXXxDfkWsmh640cgVRRB
	 Dhh33KvLB1b6mYyBm0ZYe7JacrSsdt/dHIS8OfyRrUVqfWCn2Vx25r1qmh+d+zvkRP
	 GdHwYqPrU+/aTN9n/T/dqB170/FUB6QpsHazh9Yb18AOht9LNSjU7C87ff9di7HQrA
	 IGGsUQxG7O81g==
From: Arnd Bergmann <arnd@kernel.org>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] leds: fix ifdef check for gpio_led_register_device()
Date: Wed, 28 Feb 2024 10:38:26 +0100
Message-Id: <20240228093834.2230004-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gpio_led_register_device() is built whenever CONFIG_LEDS_GPIO_REGISTER is
enabled, and this may be used even when CONFIG_NEW_LEDS is turned off.

However, the stub declaration in the header is provided for all configs
without CONFIG_NEW_LEDS, resulting in a build failure:

drivers/leds/leds-gpio-register.c:24:1: error: redefinition of 'gpio_led_register_device'
   24 | gpio_led_register_device(int id, const struct gpio_led_platform_data *pdata)
      | ^
include/linux/leds.h:646:39: note: previous definition is here

Change the #ifdef check to match the definition.
Note: this apparently took years of randconfig builds to hit, since
a number of other drivers just 'select NEW_LEDS' anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/leds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7598d472903a..db6b114bb3d9 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -639,7 +639,7 @@ struct gpio_led_platform_data {
 	gpio_blink_set_t	gpio_blink_set;
 };
 
-#ifdef CONFIG_NEW_LEDS
+#ifdef CONFIG_LEDS_GPIO_REGISTER
 struct platform_device *gpio_led_register_device(
 		int id, const struct gpio_led_platform_data *pdata);
 #else
-- 
2.39.2


