Return-Path: <linux-kernel+bounces-112359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904F08878DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32E11C22742
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FFC3E48F;
	Sat, 23 Mar 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntVC5tUZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E52942A;
	Sat, 23 Mar 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200533; cv=none; b=iUGTnAMto+NR0769WRL5p8z6nWxcwuMS7SsVkmShH5xpQOcoIXlAhGJ+4P4pj1Y13HsfWW3qmRVM+glZDkjzPO26v0sLDBKsbM+9ybfBbRt+nigeKrzECaY17Cti0/NQchFhaVFYYWJhKTbXZeINdWJPGBIcLhc9Xhlk01GoNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200533; c=relaxed/simple;
	bh=iN1S4d4yj5HPZX9bvcI3GrCiM7vt6EdgyVF6SuvXuIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvAQPIa+pSqtcd3uUPK633MhCKDyeeXGGglAuL2V2GTtQMfGyEyfGuYzRHonIau8hd475o2CBxfV23/bHeCQUM4tNiH+cIZkLVJfA53MMWg2Wjykiax8hPydCB4+FLA/atmWZGPqwivYzrQLp93PZ8r/5XsEiX1OR7AAbSdjLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntVC5tUZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41484f67d07so1162545e9.2;
        Sat, 23 Mar 2024 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711200530; x=1711805330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUiCR1svhxxRL5lsxc2pQcGa6DHnWjaA4pAZ506382o=;
        b=ntVC5tUZnIOju9zovdRrXxUCmlezqc6PH9oHRIeGA9g8vjKUEbtjW3B5LF6pP5ySjX
         2errtE0M80MyDgSiRruudSfUOwDNrSGyr61lYaFcQmqHUYr+Tku3Yh736Y9OdDJy8lMz
         B2RSJCoO8QsH5vIwyhiXyrV+Y3013NpSLGfleTBH4IbCdAJ8biCX1af+0J54C25eCXWI
         zpOQr/Z59ng6dpFCJb2AayJKvi8aM43L8r3suT85pKYJw6P6x9QcN4WMNJAbNaq8sYqq
         66ZGVkfBXL4vYCpuZA0fdwCy8+T3H2SV+GVfxE1alRNOS0e0uCMLpechlrynIi2qVfF2
         vovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711200530; x=1711805330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUiCR1svhxxRL5lsxc2pQcGa6DHnWjaA4pAZ506382o=;
        b=BH1qtmOTOhaQz1qd8uvA1mlw3YRgU1xwXcB7pj1I3NAs/bJdW+gZz0hMKKU6aHsW/u
         ZJog+bAk/avgbADIeAIJkJChfxxWipIW1XrSGa3wq4gzvZK3Fre8HKwmFLBnXF0tnjB5
         iGTzkUZRcBO4t4oKEJj1igc0CGYeqBdMx8xaiB3EsOdyZljzuta3PBDZYA287XHTcjNk
         BChnR/8bEXASCWRS3xfuZmkUrmg6PxwWRT/j4gIN2ZbRTvBbHMJ8rYQcAFblN7kNB/t6
         hEX4p+ddf/WQNfkt3McWmTu9aYf9YTskIVBxbL8hjAd+JmUfG2KCj52fXDDy2XQQdN5x
         QM8w==
X-Forwarded-Encrypted: i=1; AJvYcCX3LbJVK8PuokYFY+zKzi7DmkOHmYoA2/GgdYn3b9UC2j4zqACped0A3oDZ+zhdx+brxOsqV2YvlgJDbUPohm0uSYeYvSjL1sZaWDtyMMhMmtbI+19ucNbIzVu2SUTICkRBqwDlEL1MF273n1iQL25vWQd4ZTaH+6JfOVV27akS7JuTZSg=
X-Gm-Message-State: AOJu0Ywpd+pAFU8q4/60I7l2Nddzmg0aZ8cls0yqB2TKQX4Ol5aW1PWG
	WTZYn0cNCbndX4forTnAVMKBZt/OXgvuLtyJpXYJgz6soq5PZBAgsXzDGAk=
X-Google-Smtp-Source: AGHT+IHzQSMFL9RPxcJ9QjzOAZc3/V8flkS2jnnKJRQJaTuRc4ShAzjt4kpGZ1Lo0ud05wW1Xfo0SQ==
X-Received: by 2002:a05:600c:1554:b0:414:63c2:23cc with SMTP id f20-20020a05600c155400b0041463c223ccmr1881222wmg.2.1711200529952;
        Sat, 23 Mar 2024 06:28:49 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:fbb8:7547:139d:a40f])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm3076061wrs.7.2024.03.23.06.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 06:28:49 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 3/5] pinctrl: rk805: Add rk816 pinctrl support
Date: Sat, 23 Mar 2024 14:27:59 +0100
Message-ID: <20240323132757.141861-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323132757.141861-2-knaerzche@gmail.com>
References: <20240323132757.141861-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for RK816 to the exising rk805 pinctrl driver

It has a single pin which can be configured as input from a thermistor (for
instance in an attached battery) or as a gpio.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
  - rename pin-function names according to the updated binding
  - added missing fun_reg for rk816_gpio_cfgs

changes since v2:
  - aligned pin-function names with binding (dropped "pin_fun"-prefix)

 drivers/pinctrl/pinctrl-rk805.c | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 56d916f2cee6..c42f1bf93404 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -93,6 +93,11 @@ enum rk806_pinmux_option {
 	RK806_PINMUX_FUN5,
 };
 
+enum rk816_pinmux_option {
+	RK816_PINMUX_THERMISTOR,
+	RK816_PINMUX_GPIO,
+};
+
 enum {
 	RK805_GPIO0,
 	RK805_GPIO1,
@@ -104,6 +109,10 @@ enum {
 	RK806_GPIO_DVS3
 };
 
+enum {
+	RK816_GPIO0,
+};
+
 static const char *const rk805_gpio_groups[] = {
 	"gpio0",
 	"gpio1",
@@ -115,6 +124,10 @@ static const char *const rk806_gpio_groups[] = {
 	"gpio_pwrctrl3",
 };
 
+static const char *const rk816_gpio_groups[] = {
+	"gpio0",
+};
+
 /* RK805: 2 output only GPIOs */
 static const struct pinctrl_pin_desc rk805_pins_desc[] = {
 	PINCTRL_PIN(RK805_GPIO0, "gpio0"),
@@ -128,6 +141,11 @@ static const struct pinctrl_pin_desc rk806_pins_desc[] = {
 	PINCTRL_PIN(RK806_GPIO_DVS3, "gpio_pwrctrl3"),
 };
 
+/* RK816 */
+static const struct pinctrl_pin_desc rk816_pins_desc[] = {
+	PINCTRL_PIN(RK816_GPIO0, "gpio0"),
+};
+
 static const struct rk805_pin_function rk805_pin_functions[] = {
 	{
 		.name = "gpio",
@@ -176,6 +194,21 @@ static const struct rk805_pin_function rk806_pin_functions[] = {
 	},
 };
 
+static const struct rk805_pin_function rk816_pin_functions[] = {
+	{
+		.name = "gpio",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_GPIO,
+	},
+	{
+		.name = "thermistor",
+		.groups = rk816_gpio_groups,
+		.ngroups = ARRAY_SIZE(rk816_gpio_groups),
+		.mux_option = RK816_PINMUX_THERMISTOR,
+	},
+};
+
 static const struct rk805_pin_group rk805_pin_groups[] = {
 	{
 		.name = "gpio0",
@@ -207,6 +240,14 @@ static const struct rk805_pin_group rk806_pin_groups[] = {
 	}
 };
 
+static const struct rk805_pin_group rk816_pin_groups[] = {
+	{
+		.name = "gpio0",
+		.pins = { RK816_GPIO0 },
+		.npins = 1,
+	},
+};
+
 #define RK805_GPIO0_VAL_MSK	BIT(0)
 #define RK805_GPIO1_VAL_MSK	BIT(1)
 
@@ -255,6 +296,20 @@ static struct rk805_pin_config rk806_gpio_cfgs[] = {
 	}
 };
 
+#define RK816_FUN_MASK		BIT(2)
+#define RK816_VAL_MASK		BIT(3)
+#define RK816_DIR_MASK		BIT(4)
+
+static struct rk805_pin_config rk816_gpio_cfgs[] = {
+	{
+		.fun_reg = RK818_IO_POL_REG,
+		.fun_msk = RK816_FUN_MASK,
+		.reg = RK818_IO_POL_REG,
+		.val_msk = RK816_VAL_MASK,
+		.dir_msk = RK816_DIR_MASK,
+	},
+};
+
 /* generic gpio chip */
 static int rk805_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
@@ -439,6 +494,8 @@ static int rk805_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK805_PINMUX_GPIO);
 	case RK806_ID:
 		return _rk805_pinctrl_set_mux(pctldev, offset, RK806_PINMUX_FUN5);
+	case RK816_ID:
+		return _rk805_pinctrl_set_mux(pctldev, offset, RK816_PINMUX_GPIO);
 	}
 
 	return -ENOTSUPP;
@@ -588,6 +645,18 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 		pci->pin_cfg = rk806_gpio_cfgs;
 		pci->gpio_chip.ngpio = ARRAY_SIZE(rk806_gpio_cfgs);
 		break;
+	case RK816_ID:
+		pci->pins = rk816_pins_desc;
+		pci->num_pins = ARRAY_SIZE(rk816_pins_desc);
+		pci->functions = rk816_pin_functions;
+		pci->num_functions = ARRAY_SIZE(rk816_pin_functions);
+		pci->groups = rk816_pin_groups;
+		pci->num_pin_groups = ARRAY_SIZE(rk816_pin_groups);
+		pci->pinctrl_desc.pins = rk816_pins_desc;
+		pci->pinctrl_desc.npins = ARRAY_SIZE(rk816_pins_desc);
+		pci->pin_cfg = rk816_gpio_cfgs;
+		pci->gpio_chip.ngpio = ARRAY_SIZE(rk816_gpio_cfgs);
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported RK805 ID %lu\n",
 			pci->rk808->variant);
-- 
2.43.2


