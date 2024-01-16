Return-Path: <linux-kernel+bounces-27226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1282EC6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D82F61C22659
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1EF134C7;
	Tue, 16 Jan 2024 09:59:10 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C17134A4;
	Tue, 16 Jan 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-188-097-211-099.188.097.pools.vodafone-ip.de ([188.97.211.99] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rPgDU-000bCp-21;
	Tue, 16 Jan 2024 10:58:44 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] gpio: vf610: allow disabling the vf610 driver
Date: Tue, 16 Jan 2024 10:58:45 +0100
Message-Id: <20240116095845.47458-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vf610 gpio driver is enabled by default for all i.MX machines,
without any option to disable it in a board-specific config file.

Most i.MX chipsets have no hardware for this driver. Change the default
to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

Add a text description after the bool type, this makes the driver
selectable by make config etc. Enable the driver in arm64's default
config and in imx_v6_v7_defconfig to support chips like i.MX7ULP,
i.MX8QM, DXL, ULP and i.MX93.

Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - enable the vf610 gpio driver in the defconfig files for arm_v7
   (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 arch/arm64/configs/defconfig         | 1 +
 drivers/gpio/Kconfig                 | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..3cdcb786f33f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -208,6 +208,7 @@ CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MXC=y
 CONFIG_GPIO_SIOX=m
+CONFIG_GPIO_VF610=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCF857X=y
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..915c7c8fd13f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -632,6 +632,7 @@ CONFIG_GPIO_SYSCON=y
 CONFIG_GPIO_UNIPHIER=y
 CONFIG_GPIO_VISCONTI=y
 CONFIG_GPIO_WCD934X=m
+CONFIG_GPIO_VF610=y
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1301cec94f12..353af1a4d0ac 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -711,7 +711,8 @@ config GPIO_UNIPHIER
 	  Say yes here to support UniPhier GPIOs.
 
 config GPIO_VF610
-	def_bool y
+	bool "VF610 GPIO support"
+	default y if SOC_VF610
 	depends on ARCH_MXC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.39.2


