Return-Path: <linux-kernel+bounces-36585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE083A36D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45A81C28B21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32217757;
	Wed, 24 Jan 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMG1h4Ki"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC6171C1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082341; cv=none; b=AI8kpYPC3gCaJ36OBIWQmiXvwQUajHjR1QwsCb8a3MDFK6tENejImnGfoJkM1m1UEBuQHTS0dVEwOTJJAqOv3o5hS4gYUQFo8XdND6A7Z3tNtbrf3BHSH25hIPcwduFFn/hpGJt9NwwWcobSUo0dhWrkwiDODfNhCj0pwjl5jRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082341; c=relaxed/simple;
	bh=NVwcdnW8A7XQhpx5K/4jQMW8pILNh3MbaRAEeStWSEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VL0ItmkcR+4g7sR+GwauUWp/nGP7JRAMrpVePRCzo925vEm3eYm0Zv/QSyfdjRhkdqc4r/BZDkqNQtVYaUyMWz1IWXh2J4vgMydedTTrKNrug3sTtWpPqqvEqD+2y9TL27LRCmp1DrtjfgCJXq9JcDi1AqJuypExRKRsvPPuSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XMG1h4Ki; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so5781227a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082338; x=1706687138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ+XlfeIIIA0X9gDeF4vw53ttOCM6tywn9BtgTzvNSE=;
        b=XMG1h4KiyScDqO/k+Mjuh3zR8YCXzqVEB35ZpUSA/8biLsfTLVf7zO1ywmPjeIZgcu
         qW+/OcYhc8/SsQ9ZCgmDtQzMKBRviNwRUFlW3sUlboLfWifr3wyGQye2LMPSokTNzJsh
         u3FRuREmIGfM8zE2GTQ2E3tBJJ5F0+UyCR9CjRoMDKySPWxpu3FWhDjqCMfQkNciFzcl
         vBqoiLyoxv97CTWdyQ+Xa+1Hd49RECKoHFx6LEaJuDKly+QJOopUJBbojehfH8i1EDXc
         gcWP96mA68pFpuR4awur6uUlFWGho7Fz2tB7avlrCulqDtoCpx4L3SUyiCsYr1Ls8r8J
         VYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082338; x=1706687138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ+XlfeIIIA0X9gDeF4vw53ttOCM6tywn9BtgTzvNSE=;
        b=JFrC8KlAL+OR0q4FmteUSbbICwjLDD3jYQwrvpARmtrauken+VMqbbzyMrjWhtvbD9
         tE4sqMnUAXU7M9uo/C/6Kl5GI5kMHornQ4q//+EccnJdRVq582ZYJYFBrU+E3mDNwbSy
         jXzKBWuM1nIKnXbCtg28LKqf+QqMORypfQxAoVYhB5umCjfPI1e+tGOt8H4DQsOTb/zL
         +PlCIZTztfOemh57Zv9uYFA52Dp5k4pW3z24uCscf4Q+XVh7ZfqQl08rT6uO5f1XZzAk
         HVGqcJBkMxYGHs1DSN+gJhIPRJnigd+4faDA1NAzYwWKCkDkYk7RhIXcpRN/HE+24sAY
         xj4g==
X-Gm-Message-State: AOJu0YwCLQcHzPONBKGx0bYhKI4N36/p8P5IDKeorwkaWvFlbP9gf8df
	x+Plm1DdqXKPx9+Q359vjsXk+JJ+Na7+w1zaisMVIMlb4pcFj/cWQLpv4UJpVNs=
X-Google-Smtp-Source: AGHT+IGZ3WZqu8E/kuNAqO+g4gJy1D8hCmt3gBVkyHQRj9iAqi9DfkcAKYGkOIdHJOz9P4YOCYeyvQ==
X-Received: by 2002:aa7:c351:0:b0:55c:79db:1546 with SMTP id j17-20020aa7c351000000b0055c79db1546mr1235554edr.58.1706082338067;
        Tue, 23 Jan 2024 23:45:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Sean Anderson <sean.anderson@seco.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 3/6] reset: gpio: Add GPIO-based reset controller
Date: Wed, 24 Jan 2024 08:45:24 +0100
Message-Id: <20240124074527.48869-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple driver to control GPIO-based resets using the reset
controller API for the cases when the GPIOs are shared and reset should
be coordinated.  The driver is expected to be used by reset core
framework for ad-hoc reset controllers.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS                |   5 ++
 drivers/reset/Kconfig      |   9 +++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-gpio.c | 119 +++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 drivers/reset/reset-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5e1049921..91d45c6bade7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8905,6 +8905,11 @@ F:	Documentation/i2c/muxes/i2c-mux-gpio.rst
 F:	drivers/i2c/muxes/i2c-mux-gpio.c
 F:	include/linux/platform_data/i2c-mux-gpio.h
 
+GENERIC GPIO RESET DRIVER
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+S:	Maintained
+F:	drivers/reset/reset-gpio.c
+
 GENERIC HDLC (WAN) DRIVERS
 M:	Krzysztof Halasa <khc@pm.waw.pl>
 S:	Maintained
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..bb1b5a326eb7 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -66,6 +66,15 @@ config RESET_BRCMSTB_RESCAL
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
 	  BCM7216.
 
+config RESET_GPIO
+	tristate "GPIO reset controller"
+	help
+	  This enables a generic reset controller for resets attached via
+	  GPIOs.  Typically for OF platforms this driver expects "reset-gpios"
+	  property.
+
+	  If compiled as module, it will be called reset-gpio.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 8270da8a4baa..fd8b49fa46fc 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
 obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
+obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
new file mode 100644
index 000000000000..2290b25b6703
--- /dev/null
+++ b/drivers/reset/reset-gpio.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+struct reset_gpio_priv {
+	struct reset_controller_dev rc;
+	struct gpio_desc *reset;
+};
+
+static inline struct reset_gpio_priv
+*rc_to_reset_gpio(struct reset_controller_dev *rc)
+{
+	return container_of(rc, struct reset_gpio_priv, rc);
+}
+
+static int reset_gpio_assert(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	gpiod_set_value_cansleep(priv->reset, 1);
+
+	return 0;
+}
+
+static int reset_gpio_deassert(struct reset_controller_dev *rc,
+			       unsigned long id)
+{
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	gpiod_set_value_cansleep(priv->reset, 0);
+
+	return 0;
+}
+
+static int reset_gpio_status(struct reset_controller_dev *rc, unsigned long id)
+{
+	struct reset_gpio_priv *priv = rc_to_reset_gpio(rc);
+
+	return gpiod_get_value_cansleep(priv->reset);
+}
+
+static const struct reset_control_ops reset_gpio_ops = {
+	.assert = reset_gpio_assert,
+	.deassert = reset_gpio_deassert,
+	.status = reset_gpio_status,
+};
+
+static int reset_gpio_of_xlate(struct reset_controller_dev *rcdev,
+			       const struct of_phandle_args *reset_spec)
+{
+	return reset_spec->args[0];
+}
+
+static void reset_gpio_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
+static int reset_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args *platdata = dev_get_platdata(dev);
+	struct reset_gpio_priv *priv;
+	int ret;
+
+	if (!platdata)
+		return -EINVAL;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, &priv->rc);
+
+	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "Could not get reset gpios\n");
+
+	priv->rc.ops = &reset_gpio_ops;
+	priv->rc.owner = THIS_MODULE;
+	priv->rc.dev = dev;
+	priv->rc.of_args = platdata;
+	ret = devm_add_action_or_reset(dev, reset_gpio_of_node_put,
+				       priv->rc.of_node);
+	if (ret)
+		return ret;
+
+	/* Cells to match GPIO specifier, but it's not really used */
+	priv->rc.of_reset_n_cells = 2;
+	priv->rc.of_xlate = reset_gpio_of_xlate;
+	priv->rc.nr_resets = 1;
+
+	return devm_reset_controller_register(dev, &priv->rc);
+}
+
+static const struct platform_device_id reset_gpio_ids[] = {
+	{ .name = "reset-gpio", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, reset_gpio_ids);
+
+static struct platform_driver reset_gpio_driver = {
+	.probe		= reset_gpio_probe,
+	.id_table	= reset_gpio_ids,
+	.driver	= {
+		.name = "reset-gpio",
+	},
+};
+module_platform_driver(reset_gpio_driver);
+
+MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
+MODULE_DESCRIPTION("Generic GPIO reset driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


