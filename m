Return-Path: <linux-kernel+bounces-69319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545AA858743
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F3A1C25720
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC921419B0;
	Fri, 16 Feb 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Pb6XyWpV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B3153BCC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115618; cv=none; b=hAt9eIRbsca7ku88SaOgeKwMmJcYcY1aMlpqalJ/uGSTYi/qy6U2WErMTstKoYc16ClJthoFsC+KfNTYFCdLug5jmTiGWiSvNRYxs7Zs3T5Jw9c9I6mdFyydQ2ayqzfuQ1jccSeSJUb4zPPRbjqrqd3PwtF4pa96CVrNEl1LukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115618; c=relaxed/simple;
	bh=yx9oNf9d3eA1FlLSpotJY/uy8bPphhk+h+RPxHa1al0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkgnZcUqjInTyNjvz5Ih21hUpv8Dsq2S0MyQdJuLodmLifd7CgIjZJKwhvzUDEd5qnW32EjN6Wi4uol5RRvMON9RNjB1TrZXT71//DH8L9ddnow/tfoHxh22eddYFjjpdpoqxdOR8osyuAFjrrDKcwnMm24ALbasxdHxIFw1SjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Pb6XyWpV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d10ae127ffso31935791fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115613; x=1708720413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiAgZXD5R5oyKE5kvpTu1Xl8SVVb50mDoXKZHDVMF3g=;
        b=Pb6XyWpVwDbIYabChrT2njYtuWzXrM7tQ4+lP6XtchjVJY/hIvgDhIk5waBW9aypVb
         4av6eZQpVGzknbr4L71sVR9W7g17bX1uZLAL4bjR5uogLyd46dbiO2TsbmiCvAeXVWy1
         o+yBvWgtxLnAjrk68YnBWTESHcXDCPi0d5b93xlU7H/l6KyQex5bHHbuXali1zfukm1l
         Dvg3PTpRg8UZh9OF4YoMqnadhLpzX2PRTi+kDmQyW5x/gQxny2Q3tGkQ2gjrufrtSMl8
         E6K11IpDvKhsqKLcdJGwN3Yb+xqen7TWGIdj0LU5vkmwVAeSS3r+O4UJ7xWzWt8CR6ZD
         DY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115613; x=1708720413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiAgZXD5R5oyKE5kvpTu1Xl8SVVb50mDoXKZHDVMF3g=;
        b=ShUGuHt3a5tjkhs3DqtqHrL2QwsIQi/bmHVxCa7CjroRnxxhll3uYo+/6cwLsTca1C
         7lk5c2SVkbWJyOJP9U7ufsiMjlqD4R4oxaWSUSySXtlw01GYXBMd2+Pm6hV+bCkinM7H
         xPD/+EPUoE3c2SZS3vkxilaQ3/3FRwMkElgMBZQKW0Zz3zGyyWEdxLcjENgwGxnIw1ku
         EG2kdOrcydntiOV1P6ViyA8ZQ0WILUNAjvoujGjj3mIYnXJ8zj2Ujnitr99FFA5XCp5Q
         i1NNL7DsO93R3MtM7MNeBJJEjSVDp6NtTXXj5be97gJMgZYuPeNCwz55o9EfWmbCinYo
         eiKg==
X-Forwarded-Encrypted: i=1; AJvYcCXdqeotjyUQxtp/GCJnTLoW38DBOuhqKuI4L7CHZTk2YP5JNVJGtmRO3maxWQmn7YM+t8otfXdiZP383y8FszNOurms5XAAd07Pz9Pf
X-Gm-Message-State: AOJu0YxHVPUDqjF3ul2Ei2mIb9510POU3uoQLlnmP9C7nX2+yojxwrzP
	6m+7Flxy72Qz+jvSZbSmKurAmV6EMjM5808my3bwLvGeV+psTyem+NmRcD+1QxY=
X-Google-Smtp-Source: AGHT+IEuflH9wQzsx8TrMcwmwhz38pYeg7QRtUYyjKydmIUvwvFOOto2iAhoyBREDsH8Oy9snBTz1A==
X-Received: by 2002:a2e:b8c6:0:b0:2d1:1dae:c562 with SMTP id s6-20020a2eb8c6000000b002d11daec562mr4928843ljp.6.1708115613459;
        Fri, 16 Feb 2024 12:33:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:33 -0800 (PST)
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
Subject: [PATCH v5 14/18] PCI/pwrctl: add a power control driver for WCN7850
Date: Fri, 16 Feb 2024 21:32:11 +0100
Message-Id: <20240216203215.40870-15-brgl@bgdev.pl>
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

Add a PCI power control driver that's capable of correctly powering up
the ath12k module on WCN7850 using the PCI pwrctl functionality.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig              |   8 +
 drivers/pci/pwrctl/Makefile             |   2 +
 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c | 202 ++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 96195395af69..b91170ebfb49 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,4 +5,12 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_WCN7850
+	tristate "PCI Power Control driver for WCN7850"
+	select PCI_PWRCTL
+	default m if (ATH12K && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for the ath12k
+	  module of the WCN7850 WLAN/BT chip.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index 52ae0640ef7b..de20c3af1b78 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_WCN7850)	+= pci-pwrctl-wcn7850.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c b/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
new file mode 100644
index 000000000000..e2b2c53bff29
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrctl_wcn7850_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pci_pwrctl_wcn7850_pdata {
+	struct pci_pwrctl_wcn7850_vreg *vregs;
+	size_t num_vregs;
+	unsigned int delay_msec;
+};
+
+struct pci_pwrctl_wcn7850_ctx {
+	struct pci_pwrctl pwrctl;
+	const struct pci_pwrctl_wcn7850_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_desc *en_gpio;
+	struct clk *clk;
+};
+
+static struct pci_pwrctl_wcn7850_vreg pci_pwrctl_wcn7850_vregs[] = {
+	{
+		.name = "vdd",
+		.load_uA = 16000,
+	},
+	{
+		.name = "vddio",
+		.load_uA = 5000,
+	},
+	{
+		.name = "vddio1p2",
+		.load_uA = 16000,
+	},
+	{
+		.name = "vddaon",
+		.load_uA = 26000,
+	},
+	{
+		.name = "vdddig",
+		.load_uA = 126000,
+	},
+	{
+		.name = "vddrfa1p2",
+		.load_uA = 257000,
+	},
+	{
+		.name = "vddrfa1p8",
+		.load_uA = 302000,
+	},
+};
+
+static struct pci_pwrctl_wcn7850_pdata pci_pwrctl_wcn7850_of_data = {
+	.vregs = pci_pwrctl_wcn7850_vregs,
+	.num_vregs = ARRAY_SIZE(pci_pwrctl_wcn7850_vregs),
+	.delay_msec = 50,
+};
+
+static int pci_pwrctl_wcn7850_power_on(struct pci_pwrctl_wcn7850_ctx *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ctx->clk);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(ctx->en_gpio, 1);
+
+	if (ctx->pdata->delay_msec)
+		msleep(ctx->pdata->delay_msec);
+
+	return 0;
+}
+
+static int pci_pwrctl_wcn7850_power_off(struct pci_pwrctl_wcn7850_ctx *ctx)
+{
+	gpiod_set_value_cansleep(ctx->en_gpio, 0);
+	clk_disable_unprepare(ctx->clk);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static void devm_pci_pwrctl_wcn7850_power_off(void *data)
+{
+	struct pci_pwrctl_wcn7850_ctx *ctx = data;
+
+	pci_pwrctl_wcn7850_power_off(ctx);
+}
+
+static int pci_pwrctl_wcn7850_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctl_wcn7850_ctx *ctx;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->pdata = of_device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	if (ctx->pdata->vregs) {
+		ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
+					 sizeof(*ctx->regs), GFP_KERNEL);
+		if (!ctx->regs)
+			return -ENOMEM;
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++)
+			ctx->regs[i].supply = ctx->pdata->vregs[i].name;
+
+		ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs,
+					      ctx->regs);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get all regulators\n");
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++) {
+			if (!ctx->pdata->vregs[1].load_uA)
+				continue;
+
+			ret = regulator_set_load(ctx->regs[i].consumer,
+						 ctx->pdata->vregs[i].load_uA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set vreg load\n");
+		}
+	}
+
+	ctx->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ctx->clk))
+		return dev_err_probe(dev, PTR_ERR(ctx->clk),
+				     "Failed to get clock\n");
+
+	ctx->en_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->en_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->en_gpio),
+				     "Failed to get enable the GPIO\n");
+
+	ret = pci_pwrctl_wcn7850_power_on(ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_wcn7850_power_off,
+				       ctx);
+	if (ret)
+		return ret;
+
+	ctx->pwrctl.dev = dev;
+
+	ret = devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrctl wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrctl_wcn7850_of_match[] = {
+	{
+		.compatible = "pci17cb,1107",
+		.data = &pci_pwrctl_wcn7850_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctl_wcn7850_of_match);
+
+static struct platform_driver pci_pwrctl_wcn7850_driver = {
+	.driver = {
+		.name = "pci-pwrctl-wcn7850",
+		.of_match_table = pci_pwrctl_wcn7850_of_match,
+	},
+	.probe = pci_pwrctl_wcn7850_probe,
+};
+module_platform_driver(pci_pwrctl_wcn7850_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("PCI Power Sequencing module for WCN7850");
+MODULE_LICENSE("GPL");
-- 
2.40.1


