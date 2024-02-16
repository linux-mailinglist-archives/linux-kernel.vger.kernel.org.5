Return-Path: <linux-kernel+bounces-69321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504DF85875E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071DA28C1A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B29D157E8B;
	Fri, 16 Feb 2024 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ima8Razl"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741D154BE3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115624; cv=none; b=ITT1OGmT8XNGSyB9N2XVOiR3uQ/BdYexNdc20LsmZp8NG5vp49+yM/a+a+TRVGsGa1DYdGL2F2XbTo+pb2WvXkfbweAps9ZZLCCD+Ju9VMr+2js7Hmq5LvFxHM1H+q68SxAwcPr3kvydyiPhskq0tObjAPLZQk/saUQRSAaDi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115624; c=relaxed/simple;
	bh=uxQvnPI8/bGrVMuVI5gjeJIZtyIinJjoJ9no/gq7xoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/mRy+6a4qyBWopyAYqpNeojLa9V2LSumIE/LdK1qNgmqIZXw/g7f1CoBkZ4MLGrMi/YQ8HLLtSP0ygGYdsfPTsOcOVDi3XYpQTQD3r6j2x+xjxDETSMufk+d2zmcxWE/4MaxFv6o/+G1Txl/S2YMYVNAqd8Fc5rUc8jh3fT/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ima8Razl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394b892691so1621241f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115617; x=1708720417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQHWuFoizOSDk7qTx/YRGg03f0p2QHBA18E+Wk2phRk=;
        b=ima8RazlHxQgrhYUtLazcByVb/KfgI7dsyQqZ0aIfBHwMqW4I47iJlZk4IGfnGQJIA
         ehB9c1mG0+kpBC3Gx7/qr2Ne9bqIYra099A7WMajVzhs/X1HXDh9B0NYLV+wLDEynaAa
         bPagwOVue6iYIKRXn5Ev8bxDzBB8nLvEboYDbA5H7Z3o3H2rrCGICZohoSNXyTjUIp5u
         sYMq2ozIzJhwNF5yQdcZiAdekbVfJ58LS8RhLe2jcjjFfcREpZcWtZ8lkttQFror3h/X
         sphpIQ4AUHc1FmNebvywyEuZGp5qC9kRg8/N/VrtY5Zobvcc7ENnnhSkF0v2i+j7vXrp
         qCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115617; x=1708720417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQHWuFoizOSDk7qTx/YRGg03f0p2QHBA18E+Wk2phRk=;
        b=Qq0lHW1eLWiGiqHmr+K7lFzp2eRRHzNDEbp0cWOM721snW+eqLVqdt7iJ5EYk3Qed2
         q06AYnW7GhOgob6sYDStunjZ6H6LO9i+j4/9kZkV7C8MSfdMON+jv9Yr/I3w9ailyJh+
         PXL5da4TXcIsCPB5AgTaLIwaq/Y6TvXPiYC35VFJABVVE4JREwry9fCE/Roy9SlESsWh
         gqCawxHRTGMoQNnbRl+nVvIJ2nZ0OIK8Y4hyolMZJTV89lDSm57yaCSl3C0LYZ4yO6G3
         00AQ2rjy2i7ZAW7zR1tG0HrxxiNJTyxmOI+DabOsa7jdH9COKxT6NeqljeSxUAbmVwV0
         gtbA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVEdxbeH9race/EgXjyC9Ir5DQMeD9fJEwp5cTKK3g0/7gV9GD+sW8m+Tg/Jw17k8DGhtRanUQbm8tNzGvlGwNbnCNPaUmGAZm/NM
X-Gm-Message-State: AOJu0YzP5emX1A2UOAq30mqURYWx7gY3Bl0LhTbNZY1xGSkUh7ZFlNz7
	wyD+r85HuISH4o8oQXicHDr/fQWcr8koTKppsY5QN67UXkW/KxZWoPk4hTsnRDY=
X-Google-Smtp-Source: AGHT+IGinJo+FpgyRjl2kJ/ySAi2AYljBCrn99NoRGeBpUSzr8brtEvQeJbO+Rn9M6cn5QFIJHX91A==
X-Received: by 2002:adf:fd0b:0:b0:33d:119e:2ca1 with SMTP id e11-20020adffd0b000000b0033d119e2ca1mr3839965wrr.5.1708115616769;
        Fri, 16 Feb 2024 12:33:36 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:36 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 16/18] power: pwrseq: add a driver for the QCA6390 PMU module
Date: Fri, 16 Feb 2024 21:32:13 +0100
Message-Id: <20240216203215.40870-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This adds the power sequencing driver for the QCA6390's PMU module. It
uses the pwrseq subsystem and knows how to match the sequencer to the
consumer device by verifying the relevant properties and DT layout.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig          |  16 +
 drivers/power/sequencing/Makefile         |   2 +
 drivers/power/sequencing/pwrseq-qca6390.c | 353 ++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index ba5732b1dbf8..84ddf3b4ae56 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -10,3 +10,19 @@ menuconfig POWER_SEQUENCING
 	  during power-up.
 
 	  If unsure, say no.
+
+if POWER_SEQUENCING
+
+config POWER_SEQUENCING_QCA6390
+	tristate "QCA6390 PMU driver"
+	default m if ARCH_QCOM
+	help
+	  Say U here to enable the power sequencing driver for Qualcomm
+	  QCA6390.
+
+	  The QCA6390 package contains the BT and WLAN modules whose power
+	  is controlled by the PMU module. As the former two share the power-up
+	  sequence which is executed by the PMU, this driver is needed for
+	  correct power control.
+
+endif
diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
index dcdf8c0c159e..628345c4e7ae 100644
--- a/drivers/power/sequencing/Makefile
+++ b/drivers/power/sequencing/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_POWER_SEQUENCING)		+= pwrseq-core.o
 pwrseq-core-y				:= core.o
+
+obj-$(CONFIG_POWER_SEQUENCING_QCA6390)	+= pwrseq-qca6390.o
diff --git a/drivers/power/sequencing/pwrseq-qca6390.c b/drivers/power/sequencing/pwrseq-qca6390.c
new file mode 100644
index 000000000000..5f254f9c71d7
--- /dev/null
+++ b/drivers/power/sequencing/pwrseq-qca6390.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pwrseq/provider.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+struct pwrseq_qca6390_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pwrseq_qca6390_pdata {
+	const struct pwrseq_qca6390_vreg *vregs_common;
+	size_t num_vregs_common;
+	const struct pwrseq_qca6390_vreg *vregs_wlan;
+	size_t num_vregs_wlan;
+	unsigned int pwup_delay_msec;
+};
+
+struct pwrseq_qca6390_ctx {
+	struct pwrseq_device *pwrseq;
+	struct device_node *of_node;
+	const struct pwrseq_qca6390_pdata *pdata;
+	struct regulator_bulk_data *regs_common;
+	struct regulator_bulk_data *regs_wlan;
+	struct gpio_desc *bt_gpio;
+	struct gpio_desc *wlan_gpio;
+	unsigned long last_gpio_enable;
+};
+
+static const struct pwrseq_qca6390_vreg pwrseq_qca6390_vregs_common[] = {
+	{
+		.name = "vddio",
+		.load_uA = 20000,
+	},
+	{
+		.name = "vddaon",
+		.load_uA = 100000,
+	},
+	{
+		.name = "vddpmu",
+		.load_uA = 1250000,
+	},
+	{
+		.name = "vddrfa0p95",
+		.load_uA = 200000,
+	},
+	{
+		.name = "vddrfa1p3",
+		.load_uA = 400000,
+	},
+	{
+		.name = "vddrfa1p9",
+		.load_uA = 400000,
+	},
+};
+
+static const struct pwrseq_qca6390_vreg pwrseq_qca6390_vregs_wlan[] = {
+	{
+		.name = "vddpcie1p3",
+		.load_uA = 35000,
+	},
+	{
+		.name = "vddpcie1p9",
+		.load_uA = 15000,
+	},
+};
+
+static void pwrseq_qca6390_ensure_gpio_delay(struct pwrseq_qca6390_ctx *ctx)
+{
+	unsigned long diff_jiffies = jiffies - ctx->last_gpio_enable;
+	unsigned int diff_msecs = jiffies_to_msecs(diff_jiffies);
+
+	if (diff_msecs < 100)
+		msleep(100 - diff_msecs);
+}
+
+static const struct pwrseq_qca6390_pdata pwrseq_qca6390_of_data = {
+	.vregs_common = pwrseq_qca6390_vregs_common,
+	.num_vregs_common = ARRAY_SIZE(pwrseq_qca6390_vregs_common),
+	.vregs_wlan = pwrseq_qca6390_vregs_wlan,
+	.num_vregs_wlan = ARRAY_SIZE(pwrseq_qca6390_vregs_wlan),
+	.pwup_delay_msec = 16,
+};
+
+static int pwrseq_qca6390_vregs_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_enable(ctx->pdata->num_vregs_common,
+				     ctx->regs_common);
+}
+
+static int pwrseq_qca6390_vregs_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs_common,
+				      ctx->regs_common);
+}
+
+static const struct pwrseq_unit_data pwrseq_qca6390_vregs_unit_data = {
+	.name = "regulators-enable",
+	.enable = pwrseq_qca6390_vregs_enable,
+	.disable = pwrseq_qca6390_vregs_disable,
+};
+
+static const struct pwrseq_unit_data *pwrseq_qca6390_unit_deps[] = {
+	&pwrseq_qca6390_vregs_unit_data,
+	NULL
+};
+
+static int pwrseq_qca6390_bt_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	pwrseq_qca6390_ensure_gpio_delay(ctx);
+	gpiod_set_value_cansleep(ctx->bt_gpio, 1);
+	ctx->last_gpio_enable = jiffies;
+
+	return 0;
+}
+
+static int pwrseq_qca6390_bt_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpiod_set_value_cansleep(ctx->bt_gpio, 0);
+
+	return 0;
+}
+
+static const struct pwrseq_unit_data pwrseq_qca6390_bt_unit_data = {
+	.name = "bluetooth-enable",
+	.deps = pwrseq_qca6390_unit_deps,
+	.enable = pwrseq_qca6390_bt_enable,
+	.disable = pwrseq_qca6390_bt_disable,
+};
+
+static int pwrseq_qca6390_wlan_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs_wlan, ctx->regs_wlan);
+	if (ret)
+		return ret;
+
+	pwrseq_qca6390_ensure_gpio_delay(ctx);
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 1);
+	ctx->last_gpio_enable = jiffies;
+
+	return 0;
+}
+
+static int pwrseq_qca6390_wlan_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	gpiod_set_value_cansleep(ctx->wlan_gpio, 0);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs_wlan,
+				      ctx->regs_wlan);
+}
+
+static const struct pwrseq_unit_data pwrseq_qca6390_wlan_unit_data = {
+	.name = "wlan-enable",
+	.deps = pwrseq_qca6390_unit_deps,
+	.enable = pwrseq_qca6390_wlan_enable,
+	.disable = pwrseq_qca6390_wlan_disable,
+};
+
+static int pwrseq_qca6390_pwup_delay(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	if (ctx->pdata->pwup_delay_msec)
+		msleep(ctx->pdata->pwup_delay_msec);
+
+	return 0;
+}
+
+static const struct pwrseq_target_data pwrseq_qca6390_bt_target_data = {
+	.name = "bluetooth",
+	.unit = &pwrseq_qca6390_bt_unit_data,
+	.post_enable = pwrseq_qca6390_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_qca6390_wlan_target_data = {
+	.name = "wlan",
+	.unit = &pwrseq_qca6390_wlan_unit_data,
+	.post_enable = pwrseq_qca6390_pwup_delay,
+};
+
+static const struct pwrseq_target_data *pwrseq_qca6390_targets[] = {
+	&pwrseq_qca6390_bt_target_data,
+	&pwrseq_qca6390_wlan_target_data,
+	NULL
+};
+
+static int pwrseq_qca6390_match(struct pwrseq_device *pwrseq,
+				struct device *dev)
+{
+	struct pwrseq_qca6390_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	struct device_node *dev_node = dev->of_node;
+
+	/*
+	 * The PMU supplies power to the Bluetooth and WLAN modules. both
+	 * consume the PMU AON output so check the presence of the
+	 * 'vddaon-supply' property and whether it leads us to the right
+	 * device.
+	 */
+	if (!of_property_present(dev_node, "vddaon-supply"))
+		return 0;
+
+	struct device_node *reg_node __free(device_node) =
+			of_parse_phandle(dev_node, "vddaon-supply", 0);
+	if (!reg_node)
+		return 0;
+
+	/*
+	 * `reg_node` is the PMU AON regulator, its parent is the `regulators`
+	 * node and finally its grandparent is the PMU device node that we're
+	 * looking for.
+	 */
+	if (!reg_node->parent || !reg_node->parent->parent ||
+	    reg_node->parent->parent != ctx->of_node)
+		return 0;
+
+	return 1;
+}
+
+static struct regulator_bulk_data *
+pwrseq_qca6390_get_regs(struct device *dev, size_t num_regs,
+			const struct pwrseq_qca6390_vreg *pdata)
+{
+	struct regulator_bulk_data *regs;
+	int ret, i;
+
+	regs = devm_kcalloc(dev, num_regs, sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num_regs; i++)
+		regs[i].supply = pdata[i].name;
+
+	ret = devm_regulator_bulk_get(dev, num_regs, regs);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	for (i = 0; i < num_regs; i++) {
+		if (!pdata[i].load_uA)
+			continue;
+
+		ret = regulator_set_load(regs[i].consumer, pdata[i].load_uA);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
+	return regs;
+}
+
+static int pwrseq_qca6390_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwrseq_qca6390_ctx *ctx;
+	struct pwrseq_config config;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->of_node = dev->of_node;
+
+	ctx->pdata = of_device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	ctx->regs_common = pwrseq_qca6390_get_regs(dev,
+						   ctx->pdata->num_vregs_common,
+						   ctx->pdata->vregs_common);
+	if (IS_ERR(ctx->regs_common))
+		return dev_err_probe(dev, PTR_ERR(ctx->regs_common),
+				     "Failed to get all regulators\n");
+
+	ctx->regs_wlan = pwrseq_qca6390_get_regs(dev,
+						 ctx->pdata->num_vregs_wlan,
+						 ctx->pdata->vregs_wlan);
+	if (IS_ERR(ctx->regs_wlan))
+		return dev_err_probe(dev, PTR_ERR(ctx->regs_wlan),
+				     "Failed to get all regulators\n");
+
+	ctx->bt_gpio = devm_gpiod_get_optional(dev, "bt-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->bt_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
+				     "Failed to get the Bluetooth enable GPIO\n");
+
+	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->wlan_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
+				     "Failed to get the WLAN enable GPIO\n");
+
+	memset(&config, 0, sizeof(config));
+
+	config.parent = dev;
+	config.owner = THIS_MODULE;
+	config.drvdata = ctx;
+	config.match = pwrseq_qca6390_match;
+	config.targets = pwrseq_qca6390_targets;
+
+	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+				     "Failed to register the power sequencer\n");
+
+	return 0;
+}
+
+static const struct of_device_id pwrseq_qca6390_of_match[] = {
+	{
+		.compatible = "qcom,qca6390-pmu",
+		.data = &pwrseq_qca6390_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwrseq_qca6390_of_match);
+
+static struct platform_driver pwrseq_qca6390_driver = {
+	.driver = {
+		.name = "pwrseq-qca6390",
+		.of_match_table = pwrseq_qca6390_of_match,
+	},
+	.probe = pwrseq_qca6390_probe,
+};
+module_platform_driver(pwrseq_qca6390_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("QCA6390 PMU power sequencing driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1


