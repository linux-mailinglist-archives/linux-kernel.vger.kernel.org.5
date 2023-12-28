Return-Path: <linux-kernel+bounces-12574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB881F705
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468721F2335B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCD6FC3;
	Thu, 28 Dec 2023 10:48:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D56AA4;
	Thu, 28 Dec 2023 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BSAmIoH51892682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BSAmIoH51892682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Dec 2023 18:48:18 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 28 Dec 2023 18:48:18 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 28 Dec 2023 18:48:17 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Thu, 28 Dec 2023 18:48:17 +0800
From: Tzuyi Chang <tychang@realtek.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
	<brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, TY Chang <tychang@realtek.com>
Subject: [PATCH v5 0/2] Add gpio driver support for Realtek DHC SoCs
Date: Thu, 28 Dec 2023 18:47:58 +0800
Message-ID: <20231228104800.24913-1-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS05.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

These patches add the bindings and the gpio driver for Realtek
DHC(Digital Home Center) RTD SoCs, including RTD1295, RTD1395,
RTD1619, RTD1319, RTD1619B, RTD1319D and RTD1315E.

Change log:
v4->v5:
1. Add more description in the Kconfig.
2. Add comment for the counter-intuitive number 31.
3. Convert to use cleanup API and module_platform_driver() macro.
4. Simplify some of the code as suggested in patch v4.
v3->v4:
1. Arrange the compatible list in alphanumerical order.
2. Remove the size check for the offset array.
3. Add the debounce callback.
4. Conducted a review of the critical section, employing raw_spinlock_t for locking purposes.
5. Add gpiochip_enable_irq/gpiochip_disable_irq to fulfill the immutability requirements.
6. Use irqd_to_hwirq to get hwirq.
v2->v3:
1. Remove generic compatible and use SoC-specific compatible instead.
2. Add the missing descriptions for the rtd_gpio_info structure members.
3. Assign gpio_chip fwnode.
v1->v2:
1. Add description for DHC RTD SoCs in the bindings.
2. Revise the compatible names in the bindings.
3. Transitioned from OF API to platform_device API.
4. Use u8 for the offset array within the rtd_gpio_info structure.
5. Record the size of each array within the rtd_gpio_info structure and
   implement checks to prevent out-of-bounds access.
6. Use GPIOLIB_IRQCHIP helpers to register interrupts.
7. Use dynamic allocation for GPIO base.

Tzuyi Chang (2):
  dt-bindings: gpio: realtek: Add realtek,rtd-gpio
  Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.

 .../bindings/gpio/realtek,rtd-gpio.yaml       |  69 ++
 drivers/gpio/Kconfig                          |  13 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rtd.c                       | 604 ++++++++++++++++++
 4 files changed, 687 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
 create mode 100644 drivers/gpio/gpio-rtd.c

-- 
2.43.0


