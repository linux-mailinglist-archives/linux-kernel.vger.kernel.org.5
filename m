Return-Path: <linux-kernel+bounces-88265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110686DF63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A612871A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB76A8DE;
	Fri,  1 Mar 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SgxOeAM9"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7EC69D22;
	Fri,  1 Mar 2024 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289577; cv=none; b=qhupJOkWXSeCNlbUwzRq9IQ7Rtu3suabQoKmEP/G+aPJQErYtQQTQ8xFHdnFDQpNBNdod7SMTVRfKjArv88eDynHai3LN/svo0HmfyYn/jSzyVvz4fVxae1WzVgHNZTUB+fs8hhQwGS0x2eeMhkcyYBOF7SivgEvcNu2Q1r+F7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289577; c=relaxed/simple;
	bh=pNebpWfsA+jspsdFsOJW/LSf558UZwWkGzieJ+R8+uI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fzHhMiqOHrBXYaWfuOux/tNxHuSDKPjMl6SOXFfG0KvxXFX8GgwIWdQ9boT1+CstbU4Gz6fbrKGnvaO5S3yXoteyeYWiL3mjLpzKKvIMPH4H1c3Jiff1BLxv3jhzRZsV0TBcX8lGfCKXgDNWCOkpeQO67WSrPfqRwfBNcnFMPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SgxOeAM9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2D2FFF80B;
	Fri,  1 Mar 2024 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709289573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o5NiKL8r/W+kJucjBrQoKtnviioRK6Ax5P082kWhSJE=;
	b=SgxOeAM92J8bU9MnEeveG4HXHNVeROmThLtiIEtkdLm+tkpTnaN4GYsQYzx/ZH19ymOkph
	8rUnWBIxrtRBhcxSVL1JLb35kkV8q5HzcaaNen6qAjhGX4DsEwHwXc9DkFRYOXqTtByrQR
	b+VurREC5sJtBtaagcy1WMWUyk/021AnHUC+CWy0wLsQ7OpBkDrmEjwNoPTysavuwLHPis
	SI3w/NGr9mDDzH3zcPabXJd98WrUoOYRQbrwPjvLb4vP/VWHSi6OwHcc1AdP5VASKGInE6
	BwiB//gQ+Prlgcgs9eMsglkhVP177jJa0+SRzmvIWGhWrHE9wCWh1CUh7R/tyg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 01 Mar 2024 11:39:26 +0100
Subject: [PATCH] gpio: nomadik: fix Kconfig dependencies inbetween pinctrl
 & GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240301-mbly-gpio-kconfig-fix-v1-1-2785cebd475d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAF2w4WUC/x2MSwqAMAwFryJZG6itgnoVceEnrUFtpQVRxLsbX
 M4b3jyQKDIlaLMHIp2cOHiBIs9gWgbvCHkWBq10qYwqcB+3G93BAdcpeMsOLV9IjRlFV9rWNcj
 3iCTz3+369/0AhkLXv2cAAAA=
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

PINCTRL_NOMADIK cannot select GPIO_NOMADIK without first selecting
GPIOLIB on which GPIO_NOMADIK depends. GPIO_NOMADIK depends on OF_GPIO,
it is a direct dependency.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403010917.pnDhdS1Y-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403011102.v8w2zPOU-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403011329.1VnABMRz-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202403011546.Hpt8sBTa-lkp@intel.com/
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Test robot usefully reported four related issues; see Closes
trailers for links. Here is a proposed fix. It applies on
top of ib-nomadik-gpio [0].

I'm fine with squashing if you prefer keeping the tree
clean of such commits. Unsure if that is what you usually do.

Have a nice day,
Théo

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-nomadik-gpio
---
 drivers/gpio/Kconfig            | 2 +-
 drivers/pinctrl/nomadik/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index fe6112abb73a..f633be517654 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -481,7 +481,7 @@ config GPIO_MXS
 config GPIO_NOMADIK
 	bool "Nomadik GPIO driver"
 	depends on ARCH_U8500 || ARCH_NOMADIK || MACH_EYEQ5 || COMPILE_TEST
-	select OF_GPIO
+	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to support the Nomadik SoC GPIO block. This block is also
diff --git a/drivers/pinctrl/nomadik/Kconfig b/drivers/pinctrl/nomadik/Kconfig
index 59d0d885651c..aafecf348670 100644
--- a/drivers/pinctrl/nomadik/Kconfig
+++ b/drivers/pinctrl/nomadik/Kconfig
@@ -25,6 +25,7 @@ config PINCTRL_NOMADIK
 	depends on OF
 	select PINMUX
 	select PINCONF
+	select GPIOLIB
 	select GPIO_NOMADIK
 
 config PINCTRL_STN8815

---
base-commit: 6ad679cfaeea9291e9dce3247e34656080fc1d29
change-id: 20240301-mbly-gpio-kconfig-fix-e93b03052f88

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


