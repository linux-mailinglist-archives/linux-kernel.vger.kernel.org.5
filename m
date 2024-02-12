Return-Path: <linux-kernel+bounces-61538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A11851370
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587AFB26BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679E39FCB;
	Mon, 12 Feb 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIOm69G7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61D39FEB;
	Mon, 12 Feb 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740268; cv=none; b=OP/iuQa2d/fLNV/RZeDffUcj+qCtHWG9MebuxnUkXNgYriFOrI0NkhJoVRRwbwnAXNKhrUY6X9xlxXswZ79jd+Li/HnHRBhuD0W0vovle3CA+u4XJUuY/u4hYCIZcSwfaARVZ+k3upogkWlHwi5Ffy9Wvel98IfsmXfZZ2O5IBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740268; c=relaxed/simple;
	bh=wvglWGO75Qjvj5RpZfPRJJ6urx7SCXxgZ1mdrXsCA3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0xOhL7K7tGQwNrD0r1u+R3UBhUEXHZruyx5ZaeN5JBKb+h/UGrWrSxPIcwjAD72/KUE5AWrEsHcfmpq1VX9r5eadnLjTWLyrbBVhOsm6RuHXRUyGzrcg1ErazrTNXZMTJCvcz92vkDLX5m7yD0uD4et7VuUnpxsigdSYUkLeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIOm69G7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7881b1843so28118545ad.3;
        Mon, 12 Feb 2024 04:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707740266; x=1708345066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8JsWK1VjXINCCnx1TiFd25vutvpFxoA0z9S5qj1OSU=;
        b=bIOm69G7q11IbA3TwSInJV7/Cavyfu9v4V9kRuwMu3zeRUMzJxnL+sBq/wyM0sDveQ
         CihQLsjW4Gr2apY2dA6Zk45H5vpR/pcgKLz0/SA96Ob/IBKoDMae99RFABmRiRnaJTcV
         NwbPmJCAcq9QtTNO6veRj7SKD0RlqRHB0cv12JAkuf/LuCulAMVzUwWPG87Vg1BIZrj2
         94uX9SJl/M8hWrB2kRgxbyLbtAgCbkdxAfwv4mle4J/lh1j99e8i9k3vRgIVCpNB1YJD
         evCseAWxugI+QjJlSojyM2tUsTqiH+BBmiZa2AC0bi5Uh5uoefyP45rDuSIeDeYbsMTr
         R/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740266; x=1708345066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8JsWK1VjXINCCnx1TiFd25vutvpFxoA0z9S5qj1OSU=;
        b=e7C0pVEIx5C+Q6/WK/c+mJvutov5OM9Or9Xw4YQpLrmONDhfNbhsC9TJKljrkLnDry
         P9xiSt3D7fi7BKzSezp6muJGxaLGTtxuxXrOleztJ22X5E7O/2hULNNSayolmlSMAfs7
         UoZXsd1NEuzQCh2ZiMaVOL+mnCR1b33s8b7IpjplFL+GV51lnn3kT+4JNPtHFCeWL2lC
         ia0MXVV2ODghiYA2VFNUejmpQegJ3TcTJPe1CsFIqmFpZ/R19rsucItocv5TWfuxuzZ7
         ZWjzaBBixE7M+enPY8/spbHZHXU0Z7Hy3kmJ/VmngfL6mauqBol1Is9+3pNKK0ynKd4O
         CRlg==
X-Forwarded-Encrypted: i=1; AJvYcCXGTlUT0Qz7t8j3rF4O15rtrS5KOESbU47cZTmyrXgeVHAv9a55TN3lktveed6TsK655528U6kFFMKk8hVEv7quXhdqB9gKaSIdMBVrnv86UCqjNHYr+RvCu0zHKOeG4KQRQBHtw1Twqw==
X-Gm-Message-State: AOJu0YxLXWxG+84dK774rx2ey6kFgfSHfGR/ftMBRFdzVdCF+/M6WbXi
	N0HQl8Uq07W/BycBl+mT6QdI9dEiqLI+C4Y6RyfEc3CGXw6sr4SL
X-Google-Smtp-Source: AGHT+IFZ00zMOJPjjtHPiprchx1xR6W+J665tjo+QgpFWjdeLeZAgzp5M7EJmB7qZ029QdeOR3Gk6Q==
X-Received: by 2002:a17:902:d2c5:b0:1d9:4282:4be8 with SMTP id n5-20020a170902d2c500b001d942824be8mr9730577plc.25.1707740265161;
        Mon, 12 Feb 2024 04:17:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVasJX8HbaV+JHQS7zJZ5KCEG6WsX49qi8aXZxsxyWDMHwnDN0nqoB9lc2zyaJAK+DAT4nt4GxvyMKPBfO78IcR5kEdLNU0+WDI/q3MiSlkNMQ76Dtk2+7f92illLqJG8BqevZBcjbu6dVKhu5RfCohultVxNUau91iwyCyGCr4V5kNrgu/5x63kwuLyYODSltWWqf/NwSZc1zrqdURKWPfR6cBB2L+kuq0Cl7rbiphAGXjycJcwBLnRCxPUiwGZo1yXC2X9N25If/OwhcJxjdjKR9JQZFddTpg6dRzKQQdkcYSnrqZWWU/1tOPNdCYABWEIV8kc/szQTbgDmUhI/y6WDxCULqBK2hYzocsIy6aU+0zZcsZVz5AWaPtEXeJcAF0FVNWvyBDr4/2TA14ZnzVfQkHcuL2TAHXUgtKlpC7IJITakQ3jxoAHHHi32qENFH9EKq+aA00MBCn7Fjh
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id jx8-20020a170903138800b001d705b43724sm247721plb.169.2024.02.12.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:17:44 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Date: Mon, 12 Feb 2024 20:17:29 +0800
Message-Id: <20240212121729.1086718-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
References: <20240212121729.1086718-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the PWM driver for CV1800.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-cv1800.c | 248 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/pwm/pwm-cv1800.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..455f07af94f7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -186,6 +186,16 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_CV1800
+	tristate "Sophgo CV1800 PWM driver"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Sophgo CV1800 series
+	  SoCs.
+
+	  To compile this driver as a module, build the dependecies
+	  as modules, this will be called pwm-cv1800.
+
 config PWM_DWC_CORE
 	tristate
 	depends on HAS_IOMEM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..6c3c4a07a316 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_CV1800)	+= pwm-cv1800.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
new file mode 100644
index 000000000000..3d7f2ff3a6c2
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * pwm-cv1800.c: PWM driver for Sophgo cv1800
+ *
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ *
+ * Limitations:
+ * - It output low when PWM channel disabled.
+ * - This pwm device supports dynamic loading of PWM parameters. When PWMSTART
+ *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) will be
+ *   temporarily stored inside the PWM. If you want to dynamically change the
+ *   waveform during PWM output, after writing the new value to HLPERIODn and
+ *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value effective.
+ * - Supports up to Rate/2 output, and the lowest is about Rate/(2^30-1).
+ * - By setting HLPERIODn to 0, can produce 100% duty cycle.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define PWM_CV1800_HLPERIOD_BASE       0x00
+#define PWM_CV1800_PERIOD_BASE         0x04
+#define PWM_CV1800_PWM_CV1800_POLARITY 0x40
+#define PWM_CV1800_START               0x44
+#define PWM_CV1800_DONE                0x48
+#define PWM_CV1800_UPDATE              0x4c
+#define PWM_CV1800_OE                  0xd0
+#define PWM_CV1800_HLPERIOD_SHIFT      0x08
+#define PWM_CV1800_PERIOD_SHIFT        0x08
+
+#define PWM_CV1800_HLPERIOD(n)         \
+	(PWM_CV1800_HLPERIOD_BASE + ((n) * PWM_CV1800_HLPERIOD_SHIFT))
+#define PWM_CV1800_PERIOD(n)           \
+	(PWM_CV1800_PERIOD_BASE + ((n) * PWM_CV1800_PERIOD_SHIFT))
+
+#define PWM_CV1800_UPDATE_MASK(n) (BIT(0) << (n))
+#define PWM_CV1800_OE_MASK(n)     (BIT(0) << (n))
+#define PWM_CV1800_START_MASK(n)  (BIT(0) << (n))
+
+#define PWM_CV1800_MAXPERIOD      (BIT(30) - 1)
+#define PWM_CV1800_MINPERIOD      BIT(1)
+#define PWM_CV1800_MINHLPERIOD    BIT(0)
+#define PWM_CV1800_PERIOD_RESET   BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET BIT(0)
+#define PWM_CV1800_REG_DISABLE    0x0U
+#define PWM_CV1800_REG_ENABLE(n)  (BIT(0) << (n))
+
+struct cv1800_pwm {
+	struct pwm_chip chip;
+	struct regmap *map;
+	struct clk *clk;
+	unsigned long clk_rate;
+};
+
+static const struct regmap_config cv1800_pwm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
+{
+	return container_of(chip, struct cv1800_pwm, chip);
+}
+
+static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			     bool enable)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 pwm_enable;
+
+	regmap_read(priv->map, PWM_CV1800_START, &pwm_enable);
+	pwm_enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
+
+	/*
+	 * If the parameters are changed during runtime, Register needs
+	 * to be updated to take effect.
+	 */
+	if (pwm_enable && enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
+				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+		regmap_update_bits(priv->map, PWM_CV1800_UPDATE,
+				   PWM_CV1800_UPDATE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+	} else if (!pwm_enable && enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_OE,
+				   PWM_CV1800_OE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_ENABLE(pwm->hwpwm));
+	} else if (pwm_enable && !enable) {
+		regmap_update_bits(priv->map, PWM_CV1800_OE,
+				   PWM_CV1800_OE_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+		regmap_update_bits(priv->map, PWM_CV1800_START,
+				   PWM_CV1800_START_MASK(pwm->hwpwm),
+				   PWM_CV1800_REG_DISABLE);
+	}
+
+	return 0;
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 tem;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	tem = mul_u64_u64_div_u64(state->period, priv->clk_rate, NSEC_PER_SEC);
+	if (tem > PWM_CV1800_MAXPERIOD || tem < PWM_CV1800_MINPERIOD)
+		return -EINVAL;
+	period_val = (u32)tem;
+
+	tem = mul_u64_u64_div_u64(state->period - state->duty_cycle,
+				  priv->clk_rate, NSEC_PER_SEC);
+	if (tem > period_val)
+		return -EINVAL;
+	hlperiod_val = (u32)tem;
+
+	regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_val);
+	regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_val);
+
+	cv1800_pwm_enable(chip, pwm, state->enabled);
+
+	return 0;
+}
+
+static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 period_ns = 0;
+	u64 duty_ns = 0;
+	u32 enable = 0;
+
+	regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val);
+	regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
+
+	if (period_val != PWM_CV1800_PERIOD_RESET ||
+	    hlperiod_val != PWM_CV1800_HLPERIOD_RESET) {
+		period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC, priv->clk_rate);
+		duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * period_ns, period_val);
+
+		regmap_read(priv->map, PWM_CV1800_START, &enable);
+
+		enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
+	}
+
+	state->period = period_ns;
+	state->duty_cycle = duty_ns;
+	state->enabled = enable;
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops cv1800_pwm_ops = {
+	.apply = cv1800_pwm_apply,
+	.get_state = cv1800_pwm_get_state,
+};
+
+static void devm_clk_rate_exclusive_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_rate_exclusive_put(clk);
+}
+
+static int cv1800_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_pwm *priv;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(&pdev->dev, base,
+					  &cv1800_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "clk not found\n");
+
+	ret = clk_rate_exclusive_get(priv->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get exclusive rate\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
+				       priv->clk);
+	if (ret) {
+		clk_rate_exclusive_put(priv->clk);
+		return ret;
+	}
+
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", priv->clk_rate);
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &cv1800_pwm_ops;
+	priv->chip.npwm = 4;
+	priv->chip.atomic = true;
+
+	return devm_pwmchip_add(dev, &priv->chip);
+}
+
+static const struct of_device_id cv1800_pwm_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
+
+static struct platform_driver cv1800_pwm_driver = {
+	.driver = {
+		.name = "cv1800-pwm",
+		.of_match_table = cv1800_pwm_dt_ids,
+	},
+	.probe = cv1800_pwm_probe,
+};
+module_platform_driver(cv1800_pwm_driver);
+
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 PWM Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1


