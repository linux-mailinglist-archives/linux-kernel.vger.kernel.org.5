Return-Path: <linux-kernel+bounces-144091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564988A41AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98E02818B3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71EB2E63B;
	Sun, 14 Apr 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMN2QLYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7123775;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089051; cv=none; b=OHQm2iLYvGF/O3/sVLnPgJdNVjW0hnjLKYZyBYi3b6y/tWTSQt7mwp4vXjGnWQhHQZK1ed5EuLEZ4IOOEQzK6f4Mel/ooy2xGaau+25zpN/i0Trsd8JLVhuS7C2ZAKGFtuB/UIl+gFBiEZ8vPaEJf9Ct8OyOphcDqaDSdzEnI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089051; c=relaxed/simple;
	bh=MaaPz/uVBSgOz0414tAOXag61hG+3FxUKeQJ2X/omo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2CPXnz1OPnXBALvx+riU5gsD45Bb77PIr84YfPVC9qbT+/mfkmC/QmwUlZCNGwyyhtdbjPVv7u5J+ySbjksdcdlIfjaDLzEk/wV9wA+6vros/sKWUVh7IufusaeOs7IiCwO+E5UUxpv+yZ+pGTkD4v32X4CEN8ptw7O39LYR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMN2QLYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A35DC32781;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713089050;
	bh=MaaPz/uVBSgOz0414tAOXag61hG+3FxUKeQJ2X/omo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KMN2QLYj9iNLVquunOIYL1kONzZGFuktTbVYfK0I25udYOYqsq8sUP1C9vTsfZm5x
	 g1SEhF2cjm9o7EsW2nHBqke4JN54rRoBd1P35n5hIWMRBCiXIAOZg0kxVmV/yYELm8
	 WS9rbq0ae6Lf4l+zXZeZXes4/0qrRIyD9Vug4I18K9EqzjhSrsCjVcAgMqTcG6Fd/U
	 eaV3QNg0cUuJPYsmMTc81JNhXqoq276Kfz0xEYbqFcucvG5UduhKOyTFrcHreNe+9v
	 hOM3bQlBDE6Fjg2tLJIVrWyX1vPwUOWYnj8rY/i8/300glRyFNViE0tkr6XxshVk8j
	 P0mD2iL53d0bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85692C001CC;
	Sun, 14 Apr 2024 10:04:10 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Sun, 14 Apr 2024 13:03:48 +0300
Subject: [PATCH v2 1/4] ARM: ep93xx: add regmap aux_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-ep93xx-clk-v2-1-9c5629dec2dd@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
In-Reply-To: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713089049; l=1982;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=WN2FKVS9xdOOC9UEV7iQOB/IuHcF3+VzCPA/Q1z8yUU=;
 b=jXC02TPN0LcH/R7S6PbAId7UeBQfc+StkYj5hC03Fux9swFIrp8ILYGU9GfG3qXfPNQcafrSP2LR
 UXbgJYX3Af4OaLeRmkkw/Y9j0dS9kHbO2+eKvUnO5nfoLEGcEzLq
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

The following driver's should be instantiated by ep93xx syscon driver:

- reboot
- pinctrl
- clock

They all require access to DEVCFG register with a shared lock held, to
avoid conflict writing to swlocked parts of DEVCFG.

Provide common resources such as base, regmap and spinlock via auxiliary
bus framework.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/soc/cirrus/ep93xx.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index 56fbe2dc59b1..a27447971302 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -3,6 +3,18 @@
 #define _SOC_EP93XX_H
 
 struct platform_device;
+struct regmap;
+struct spinlock_t;
+
+enum ep93xx_soc_model {
+	EP93XX_9301_SOC,
+	EP93XX_9307_SOC,
+	EP93XX_9312_SOC,
+};
+
+#include <linux/auxiliary_bus.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
 
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
@@ -10,6 +22,20 @@ struct platform_device;
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
+struct ep93xx_regmap_adev {
+	struct auxiliary_device adev;
+	struct regmap *map;
+	void __iomem *base;
+	spinlock_t *lock;
+	void (*write)(struct regmap *map, spinlock_t *lock, unsigned int reg,
+		      unsigned int val);
+	void (*update_bits)(struct regmap *map, spinlock_t *lock,
+			    unsigned int reg, unsigned int mask, unsigned int val);
+};
+
+#define to_ep93xx_regmap_adev(_adev) \
+	container_of((_adev), struct ep93xx_regmap_adev, adev)
+
 #ifdef CONFIG_ARCH_EP93XX
 int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
 void ep93xx_pwm_release_gpio(struct platform_device *pdev);

-- 
2.41.0



