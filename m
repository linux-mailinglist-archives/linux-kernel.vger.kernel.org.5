Return-Path: <linux-kernel+bounces-9467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844681C607
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4153286B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE03C15B;
	Fri, 22 Dec 2023 07:58:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24439468;
	Fri, 22 Dec 2023 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BM7wODs91988916, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BM7wODs91988916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Dec 2023 15:58:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 22 Dec 2023 15:58:24 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 22 Dec 2023 15:58:24 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 22 Dec 2023 15:58:24 +0800
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
Subject: [PATCH v4 0/2] Add gpio driver support for Realtek DHC SoCs
Date: Fri, 22 Dec 2023 15:58:10 +0800
Message-ID: <20231222075812.6540-1-tychang@realtek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXDAG01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

These patches add the bindings and the gpio driver for Realtek
DHC(Digital Home Center) RTD SoCs, including RTD1295, RTD1395,
RTD1619, RTD1319, RTD1619B, RTD1319D and RTD1315E.

Change log:
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
 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-rtd.c                       | 616 ++++++++++++++++++
 4 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
 create mode 100644 drivers/gpio/gpio-rtd.c

-- 
2.43.0


