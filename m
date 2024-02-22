Return-Path: <linux-kernel+bounces-76044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488C185F252
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C1728544B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A110A18654;
	Thu, 22 Feb 2024 08:02:32 +0000 (UTC)
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB17C7C;
	Thu, 22 Feb 2024 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588952; cv=none; b=MdtXaVli1spfAnwGhwd1iXrSPjwt3fBMq0k5Qn8nCZu6rlysyFOvfzKU+jw7pEfvxiEbaFt4kDrDqpspamyGfhO3XhO1FUcTQBI4O6JHJ53AhwpoP8qBmQO/FkNfnF6MQuue5ksKlwfb1UxK6+gRGe2unpqnvgKizYZjub7CFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588952; c=relaxed/simple;
	bh=qIygGq4laBZ5hKLDwCrWRP0SAoByZ0qSN3CFLnDgXWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYm8xZP3nW+i1yVrH/sKWhPlXlH1c1DEEe39kxewaRBn62fiM1z3RpLfT3Wwl763wB1rhg+Qar9KB8FUxx82mBapCfDQ0iQEzyR1ezCad/tmpHu2FrD1Pt/lHMhCKvUd4SWuStZDzJ8ReV9tFO7dCc7KoFXP/2dA6yNFs+q6lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Thu, 22 Feb 2024
 15:47:18 +0800
From: Huqiang Qin <huqiang.qin@amlogic.com>
To: <tglx@linutronix.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [RESEND PATCH 2/3] irqchip: Add support for Amlogic-T7 SoCs
Date: Thu, 22 Feb 2024 15:46:38 +0800
Message-ID: <20240222074640.1866284-3-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-1-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Amlogic-T7 SoCs support 12 GPIO IRQ lines compared with previous
serial chips and have something different, details are as below.

IRQ Number:
- 156      1 pin  on bank TESTN
- 155:148  8 pins on bank H
- 147:129 19 pins on bank Y
- 128:115 14 pins on bank M
- 114:91  24 pins on bank T
- 90:77   14 pins on bank Z
- 76:70    7 pins on bank E
- 69:57   13 pins on bank D
- 56:40   17 pins on bank W
- 39:20   20 pins on bank X
- 19:13    7 pins on bank C
- 12:0    13 pins on bank B

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/irqchip/irq-meson-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index f88df39f4129..9a1791908598 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -154,6 +154,10 @@ static const struct meson_gpio_irq_params c3_params = {
 	INIT_MESON_S4_COMMON_DATA(55)
 };
 
+static const struct meson_gpio_irq_params t7_params = {
+	INIT_MESON_S4_COMMON_DATA(157)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -165,6 +169,7 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
 	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
+	{ .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
 	{ }
 };
 
-- 
2.42.0


