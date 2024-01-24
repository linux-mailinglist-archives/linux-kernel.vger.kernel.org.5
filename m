Return-Path: <linux-kernel+bounces-36586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F404A83A375
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BB92884E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7517BA1;
	Wed, 24 Jan 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ik41KPyC"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23017730
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082345; cv=none; b=coI3NOrXGEx6NOv05Z9UcV0BB+vHLwu245EKA7/6wCboPppUsmob5kwjjpKNO+glYQ4gSws5wZTIn/P0Int2141hc0iLAAV6uEBvL7OjA6NUfT7+xBM2o3bubZ8RHg4cPnPbM/B1h5GcueFGBjqPqjTe94Y2Sh5GLiCM3pNCHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082345; c=relaxed/simple;
	bh=GryOK2WVcAShxcw9ALS3eyUBe11Jg8gdOpY4P9IFJC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3VCelynbOixXAJJG+8kydhEuQmY2hstwH7CJyOc+YUQC9UTCyX/z78sYF2vKsUHcJw+I85IBwvPzlZjxYcXKx5wgzHwymSn2hU3UbOHtKu3RAN3LEkY91QH/PlQ2AqQOFZpaz50lp7wPB3IhB0+GjwJkJ1auXHwkc4ARV5u0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ik41KPyC; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so6396842a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082340; x=1706687140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbbgB2jGb5iix1JEFZ5ptTFKMdT0kRT1hLXtledxTNc=;
        b=Ik41KPyCp53tFo233gttdDy6NmTio0DC42bbTIuUdfNUyDMgKhch/c4SvF8ak+mBuP
         SacoEFKC30e6LTSwtjQ69tY9GLM5fB/qoYD9mPW0ZaQg7NnSky6FEVQG9q5qfIAQ0z2K
         KlpUNsaBEg/VhMhP+s8j65L2Nw5jHEqX/Hl29CKm23KHFDIwBpCHjQishoKf0NX6OZ/h
         AfvZ1bIjJAN/s2eF0GBZQN09RSH1tpg6VYWOyQQfBrr9h4g4sOhoA8C8YmwWFkCjaoAW
         7ezysJ3lvi3DSuZVP+A/BhpJ7nx/qTowQKdR75+gjiX0Z5CvhHfvbfTeqphGLwLy2/JZ
         Yr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082340; x=1706687140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbbgB2jGb5iix1JEFZ5ptTFKMdT0kRT1hLXtledxTNc=;
        b=v+L2iT0/zKnMO+CBTIPizQH+A+/rrHAVDtX9YEsbHI6nLNClgMBzttwSzdX5tIYsx6
         T1H7dlRrHcmTQOF/JQVeruucOxbaoeOFtPPjpuZflhOy3i10+4k8vKYGKfUXUtEkwGvH
         h/kwyfGO7YyFs8V19XzIzNFDuchyHly1GDvbeECD77VlejUueHKHG1e8w/1Py0wda7uZ
         9yv/bfC05oHzRUl12zlRLFzPI2FELpe6aFpvBa6nxl2/ZJN8vjasXl6PSZFiSC+3twVU
         n1/lJObeGoOd6nB9asNZVHHhbes3nbLIhzhZCXPOPIQsCmwA6Tz91YrQ7D9gj9X1YouX
         VHvg==
X-Gm-Message-State: AOJu0YyN0syEJ7Z69TBcSCWIdVFdCOJSwrHdX3/JMo08Zk5ksMBsih5u
	rhcTCWz9ocs68MsP5ElRF8D435TbabkOzk8TQdsyb9/JOnHxhkJRgEL/Gr34Pyw=
X-Google-Smtp-Source: AGHT+IEQkZ17Xxu4UhThSYaaYVmGQU1hlHS0XtEM/o5SerofGnKso07erFONxvp37r0P5aTqZTmUTw==
X-Received: by 2002:a05:6402:350e:b0:55c:a84b:ca58 with SMTP id b14-20020a056402350e00b0055ca84bca58mr1163018edd.18.1706082340480;
        Tue, 23 Jan 2024 23:45:40 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:40 -0800 (PST)
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
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v5 4/6] reset: Instantiate reset GPIO controller for shared reset-gpios
Date: Wed, 24 Jan 2024 08:45:25 +0100
Message-Id: <20240124074527.48869-5-krzysztof.kozlowski@linaro.org>
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

Devices sharing a reset GPIO could use the reset framework for
coordinated handling of that shared GPIO line.  We have several cases of
such needs, at least for Devicetree-based platforms.

If Devicetree-based device requests a reset line, while "resets"
Devicetree property is missing but there is a "reset-gpios" one,
instantiate a new "reset-gpio" platform device which will handle such
reset line.  This allows seamless handling of such shared reset-gpios
without need of changing Devicetree binding [1].

To avoid creating multiple "reset-gpio" platform devices, store the
Devicetree "reset-gpios" GPIO specifiers used for new devices on a
linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
controller, GPIO number and GPIO flags) is used to check if reset
controller for given GPIO was already registered.

If two devices have conflicting "reset-gpios" property, e.g. with
different ACTIVE_xxx flags, this would allow to spawn two separate
"reset-gpio" devices, where the second would fail probing on busy GPIO
request.

Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1]
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on previous of change.
---
 drivers/reset/core.c             | 215 +++++++++++++++++++++++++++++--
 include/linux/reset-controller.h |   4 +
 2 files changed, 206 insertions(+), 13 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d5a78d3c085..60a8a33c4419 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -5,14 +5,19 @@
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
 #include <linux/atomic.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -23,6 +28,11 @@ static LIST_HEAD(reset_controller_list);
 static DEFINE_MUTEX(reset_lookup_mutex);
 static LIST_HEAD(reset_lookup_list);
 
+/* Protects reset_gpio_lookup_list */
+static DEFINE_MUTEX(reset_gpio_lookup_mutex);
+static LIST_HEAD(reset_gpio_lookup_list);
+static DEFINE_IDA(reset_gpio_ida);
+
 /**
  * struct reset_control - a reset control
  * @rcdev: a pointer to the reset controller device
@@ -63,6 +73,16 @@ struct reset_control_array {
 	struct reset_control *rstc[] __counted_by(num_rstcs);
 };
 
+/**
+ * struct reset_gpio_lookup - lookup key for ad-hoc created reset-gpio devices
+ * @of_args: phandle to the reset controller with all the args like GPIO number
+ * @list: list entry for the reset_gpio_lookup_list
+ */
+struct reset_gpio_lookup {
+	struct of_phandle_args of_args;
+	struct list_head list;
+};
+
 static const char *rcdev_name(struct reset_controller_dev *rcdev)
 {
 	if (rcdev->dev)
@@ -71,6 +91,9 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
 	if (rcdev->of_node)
 		return rcdev->of_node->full_name;
 
+	if (rcdev->of_args)
+		return rcdev->of_args->np->full_name;
+
 	return NULL;
 }
 
@@ -99,6 +122,9 @@ static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
  */
 int reset_controller_register(struct reset_controller_dev *rcdev)
 {
+	if (rcdev->of_node && rcdev->of_args)
+		return -EINVAL;
+
 	if (!rcdev->of_xlate) {
 		rcdev->of_reset_n_cells = 1;
 		rcdev->of_xlate = of_reset_simple_xlate;
@@ -813,12 +839,162 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
+static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+					 unsigned int gpio,
+					 unsigned int of_flags)
+{
+	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
+	unsigned int lookup_flags;
+	const char *label_tmp;
+
+	/*
+	 * Later we map GPIO flags between OF and Linux, however not all
+	 * constants from include/dt-bindings/gpio/gpio.h and
+	 * include/linux/gpio/machine.h match each other.
+	 */
+	if (of_flags > GPIO_ACTIVE_LOW) {
+		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
+		       of_flags, gpio);
+		return -EINVAL;
+	}
+
+	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
+	if (!gdev)
+		return -EPROBE_DEFER;
+
+	label_tmp = gpio_device_get_label(gdev);
+	if (!label_tmp)
+		return -EINVAL;
+
+	char *label __free(kfree) = kstrdup(label_tmp, GFP_KERNEL);
+	if (!label)
+		return -ENOMEM;
+
+	/* Size: one lookup entry plus sentinel */
+	struct gpiod_lookup_table *lookup __free(kfree) = kzalloc(struct_size(lookup, table, 2),
+								  GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
+	lookup->dev_id = kasprintf(GFP_KERNEL, "reset-gpio.%d", id);
+	if (!lookup->dev_id)
+		return -ENOMEM;
+
+	lookup_flags = GPIO_PERSISTENT;
+	lookup_flags |= of_flags & GPIO_ACTIVE_LOW;
+	lookup->table[0] = GPIO_LOOKUP(no_free_ptr(label), gpio, "reset",
+				       lookup_flags);
+
+	/* Not freed on success, because it is persisent subsystem data. */
+	gpiod_add_lookup_table(no_free_ptr(lookup));
+
+	return 0;
+}
+
+/*
+ * @args:	phandle to the GPIO provider with all the args like GPIO number
+ */
+static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
+{
+	struct reset_gpio_lookup *rgpio_dev;
+	struct platform_device *pdev;
+	int id, ret;
+
+	/*
+	 * Registering reset-gpio device might cause immediate
+	 * bind, resulting in its probe() registering new reset controller thus
+	 * taking reset_list_mutex lock via reset_controller_register().
+	 */
+	lockdep_assert_not_held(&reset_list_mutex);
+
+	mutex_lock(&reset_gpio_lookup_mutex);
+
+	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
+		if (args->np == rgpio_dev->of_args.np) {
+			if (of_phandle_args_equal(args, &rgpio_dev->of_args))
+				goto out; /* Already on the list, done */
+		}
+	}
+
+	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
+	if (id < 0) {
+		ret = id;
+		goto err_unlock;
+	}
+
+	/* Not freed on success, because it is persisent subsystem data. */
+	rgpio_dev = kzalloc(sizeof(*rgpio_dev), GFP_KERNEL);
+	if (!rgpio_dev) {
+		ret = -ENOMEM;
+		goto err_ida_free;
+	}
+
+	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+					    args->args[1]);
+	if (ret < 0)
+		goto err_kfree;
+
+	rgpio_dev->of_args = *args;
+	/*
+	 * We keep the device_node reference, but of_args.np is put at the end
+	 * of __of_reset_control_get(), so get it one more time.
+	 * Hold reference as long as rgpio_dev memory is valid.
+	 */
+	of_node_get(rgpio_dev->of_args.np);
+	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+					     &rgpio_dev->of_args,
+					     sizeof(rgpio_dev->of_args));
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret)
+		goto err_put;
+
+	list_add(&rgpio_dev->list, &reset_gpio_lookup_list);
+
+out:
+	mutex_unlock(&reset_gpio_lookup_mutex);
+
+	return 0;
+
+err_put:
+	of_node_put(rgpio_dev->of_args.np);
+err_kfree:
+	kfree(rgpio_dev);
+err_ida_free:
+	ida_free(&reset_gpio_ida, id);
+err_unlock:
+	mutex_unlock(&reset_gpio_lookup_mutex);
+
+	return ret;
+}
+
+static struct reset_controller_dev *__reset_find_rcdev(const struct of_phandle_args *args,
+						       bool gpio_fallback)
+{
+	struct reset_controller_dev *rcdev;
+
+	lockdep_assert_held(&reset_list_mutex);
+
+	list_for_each_entry(rcdev, &reset_controller_list, list) {
+		if (gpio_fallback) {
+			if (rcdev->of_args && of_phandle_args_equal(args,
+								    rcdev->of_args))
+				return rcdev;
+		} else {
+			if (args->np == rcdev->of_node)
+				return rcdev;
+		}
+	}
+
+	return NULL;
+}
+
 struct reset_control *
 __of_reset_control_get(struct device_node *node, const char *id, int index,
 		       bool shared, bool optional, bool acquired)
 {
+	bool gpio_fallback = false;
 	struct reset_control *rstc;
-	struct reset_controller_dev *r, *rcdev;
+	struct reset_controller_dev *rcdev;
 	struct of_phandle_args args;
 	int rstc_id;
 	int ret;
@@ -839,39 +1015,52 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 					 index, &args);
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
-	if (ret)
-		return optional ? NULL : ERR_PTR(ret);
+	if (ret) {
+		if (!IS_ENABLED(CONFIG_RESET_GPIO))
+			return optional ? NULL : ERR_PTR(ret);
 
-	mutex_lock(&reset_list_mutex);
-	rcdev = NULL;
-	list_for_each_entry(r, &reset_controller_list, list) {
-		if (args.np == r->of_node) {
-			rcdev = r;
-			break;
+		/*
+		 * There can be only one reset-gpio for regular devices, so
+		 * don't bother with the "reset-gpios" phandle index.
+		 */
+		ret = of_parse_phandle_with_args(node, "reset-gpios", "#gpio-cells",
+						 0, &args);
+		if (ret)
+			return optional ? NULL : ERR_PTR(ret);
+
+		gpio_fallback = true;
+
+		ret = __reset_add_reset_gpio_device(&args);
+		if (ret) {
+			rstc = ERR_PTR(ret);
+			goto out_put;
 		}
 	}
 
+	mutex_lock(&reset_list_mutex);
+	rcdev = __reset_find_rcdev(&args, gpio_fallback);
 	if (!rcdev) {
 		rstc = ERR_PTR(-EPROBE_DEFER);
-		goto out;
+		goto out_unlock;
 	}
 
 	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
 		rstc = ERR_PTR(-EINVAL);
-		goto out;
+		goto out_unlock;
 	}
 
 	rstc_id = rcdev->of_xlate(rcdev, &args);
 	if (rstc_id < 0) {
 		rstc = ERR_PTR(rstc_id);
-		goto out;
+		goto out_unlock;
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
 
-out:
+out_unlock:
 	mutex_unlock(&reset_list_mutex);
+out_put:
 	of_node_put(args.np);
 
 	return rstc;
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 0fa4f60e1186..357df16ede32 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -60,6 +60,9 @@ struct reset_control_lookup {
  * @reset_control_head: head of internal list of requested reset controls
  * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
+ * @of_args: for reset-gpios controllers: corresponding phandle args with
+ *           of_node and GPIO number complementing of_node; either this or
+ *           of_node should be present
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops, defaults
@@ -73,6 +76,7 @@ struct reset_controller_dev {
 	struct list_head reset_control_head;
 	struct device *dev;
 	struct device_node *of_node;
+	const struct of_phandle_args *of_args;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
-- 
2.34.1


