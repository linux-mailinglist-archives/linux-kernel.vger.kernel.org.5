Return-Path: <linux-kernel+bounces-80635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B6B866AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DA28380A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFE1CA96;
	Mon, 26 Feb 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAbuOUmH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE31BDE6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932682; cv=none; b=ftd4lpNoKb7rXXgpBC8hmch6/vhtfkCLHR2uJ2opDO0doV+52MN49inXv77x2UDZG9MsFbsM5DjGZZEplHe9cSt45e1NZUU2hklESh+Rlfcca4aHhsH9DtS5wsOnLWj8gSe6KMQfuAlcKqgWIJfMCn5alpboDTp8wq63NSpP6NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932682; c=relaxed/simple;
	bh=ufkbGUAlYUoKulI00K9+ehWHAATX13BMFcYZ+siKI5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlYxOXtSSudcyE7qjAdaZic34cUls6cFoJ6dgzwo22RTaSZrmWpZnFXnSQU+SxInRSTgQfR7swUVKjo3Qo15wH46pfR885b4ldmx4PdhysB4dEJq0Og+uYPjEsseLqFxC9acDCqvolovfUJFPE7stRBSAgDM9KQJducALpkDdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAbuOUmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD13FC43394;
	Mon, 26 Feb 2024 07:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708932681;
	bh=ufkbGUAlYUoKulI00K9+ehWHAATX13BMFcYZ+siKI5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cAbuOUmHTAP+4f51xPbOUxMd639TljHnVyHiB6J3p8oVreplHyUn8D9S7o8rVTDtw
	 undfub15lW7LpXCuC7OB8HgZTQ7yGclN2LS5TQ9DxddXe9Ep4iTQ3gFDCGtF0g+X5q
	 fumQqWkT4/OcvKEZGyeogKYiImj51grCiVYm8iXtsNDsTKr2jj1gPg/SO9M093gyAN
	 pt8xlyHTT4SEOHxWVsy/evQlwhIQQS3wc4KLWoBVjMr44JfGBpjVLREQYejyFe7BIE
	 1BCur4yN6nWnDLkKWTJJ37SGO8hWkYFWSdvZevIbHQoIypW6hVIIBU8oOjYfl+Zx5y
	 5qgQzvcxPWYiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D83C54E4A;
	Mon, 26 Feb 2024 07:31:21 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 26 Feb 2024 10:29:58 +0300
Subject: [PATCH v8 02/38] ARM: ep93xx: add regmap aux_dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-ep93xx-v8-2-3136dca7238f@maquefel.me>
References: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
In-Reply-To: <20240226-ep93xx-v8-0-3136dca7238f@maquefel.me>
To: Nikita Shubin <nikita.shubin@maquefel.me>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Damien Le Moal <dlemoal@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708932678; l=1819;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=EhQQyDo+EFlJ9/0Xh2mELcKKDmANhg1EW47ZiNjCdIA=; =?utf-8?q?b=3DY/wJhJdBka7A?=
 =?utf-8?q?LmdNlgr1QmMZ84oAa6Z4CKmE0L+2lz4nfS82zov/TioZIAnfoHpLmVlO1gXNF9Sn?=
 vJUOd+zeCQxZjc5T28Yi7rX8FVrWB2vNuV+X+ZPBKaFUX4Rn4WmU
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

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


