Return-Path: <linux-kernel+bounces-31872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D562E8335B4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5AA28380E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB314F75;
	Sat, 20 Jan 2024 18:30:08 +0000 (UTC)
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43182125DA;
	Sat, 20 Jan 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705775407; cv=none; b=o5BjNpiFuNZeuxgJ5euNU2xZWFYtDH5tDrLmIKngnifR86G9IioCCAUD1/NXfzI6HyoJ1lknNvM2NfysEscBo5mctS/0/PwTNqlBkizln5BLB4/iOv4UPA4Ho0XHTgKe6Y7DNEjaQIU8kCmeKWzAE0O3S6ffoUM2SHB56g7ojOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705775407; c=relaxed/simple;
	bh=ZozKb2DSW5ARGRmpcf8M9RKu0CAMeRbLeLSR3ulc1uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXRiPzlOz+3/mJsr79BIsyt5XG6xDUE+Uzt5oXyQ2HXbIDVuIUB+E2nxwPE07KG8/Q07Q3N2Ni0XMqfx9I+aTHdsb8Fbj7nu/JA6URi8ROg1Gjj05/CmhNkf1FZtcJs/vx+3HuBUgmB+J/IGVCf4maW1oPaHate6czOH7o9/ZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from dslb-178-004-202-210.178.004.pools.vodafone-ip.de ([178.4.202.210] helo=martin-debian-2.paytec.ch)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1rRG6L-000BIC-1D;
	Sat, 20 Jan 2024 19:29:53 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 1/3] gpio: vf610: allow disabling the vf610 driver
Date: Sat, 20 Jan 2024 19:29:27 +0100
Message-Id: <20240120182929.1129183-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120182929.1129183-1-martin@kaiser.cx>
References: <20240120182929.1129183-1-martin@kaiser.cx>
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
selectable by make config etc.

Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v3:
 - split the changes into three patches

v2:
 - enable the vf610 gpio driver in the defconfig files for arm_v7
   (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)

 drivers/gpio/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


