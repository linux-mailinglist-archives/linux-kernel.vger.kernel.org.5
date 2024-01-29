Return-Path: <linux-kernel+bounces-42642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621F840443
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB86C2850F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB460B9A;
	Mon, 29 Jan 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icU/uHwT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8B605A0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529153; cv=none; b=bPv+pYietuNfOree6nKsupzdOQCmh/zBHN0sfcutEXzjdVGRyXKCJGxTUVjgOvuIz+KNg3vBBKEAjSNnP2FZ/DOqwk5qBT4xEcmxzgAi5wys36IqcXV0sQ8/b/1YGEviFvMLXizl/IsWz6ynMvlsSuNdrX5g8Z7X4LAB0Bziy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529153; c=relaxed/simple;
	bh=RDKdQXX40OiNl7/3DjOh16dFowMeZxhASXBGszdgn6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJchxClP3nQv3xyoBTYytTD0zT2RFrCKGpzg7uCcyZF+xfA/U8AZbMw7mZplwgfuK55PDO57nJSfAyJQ3vHyobjmQBpFU+ZERN2TjjwOLaxzQVOKZ0t0zFpAUEAtg8LIjCnKWybGB0oF3OqW+wvSnlPqBF4RgmF4mOSsNnr/kYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icU/uHwT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so27960761fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706529149; x=1707133949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TBfXvR6pIfyFCcQcCo2FCNn/31lFzDY7nyc0/6S74g=;
        b=icU/uHwTulyJH2PiVM/qmhPZgbJDeyZ2rY9EoYLZliZkYUyFuIrLnS6rVUlCXmhO8B
         QvKCRFRM11G2S5qGhySC7nMexrpYRdGoDgteTIqrKHqUTFLYuIano568nB27PugETOgJ
         PqbJhq53NYCqUPI0/BLClE1Y0voG6RhNhH++aCMC3y2a9aTgoRtW0oKEb0iAmyZEHlZP
         0mjlgJyPaWVAzZj2YbpZ421lpiPoXf4tm1c+x5y07OED2gJcVrD5kSGL5gdPMcSWNTaP
         729DvRXXmEZMpD/Bb18Skl8HHTSVPCUC4G6kFmnBuPmzyNm/atKempDUlflk0qhXXNZg
         tNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529149; x=1707133949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TBfXvR6pIfyFCcQcCo2FCNn/31lFzDY7nyc0/6S74g=;
        b=Alhl747Nxj+9qE94jl6Vho4y4l9KIr3Xqb/gkf1pRZLAqIOCpOhy6fv46rO/tneHGX
         POgkyg8y+KgF0Nu7/2f9mOTRTPTTIur7bPSqe2Q7nAUSfB+smIC4mbVrhBXKD2Ek+Hsr
         QqKJkLlKxa9OWI+Vh14e5betIPGbfc3DiNPRzlEOcQeEb35Z9a0rEywY/2g2B8nGujqo
         dE5ygalFofc8v0X4FKMmhiWxD0M7mYWAQlBKy6JbVFCl1D9ZHgpfVN59f3doyMIVvLAp
         JDMsbt0qs/gXHmuQNWP7NP+3eEPtZFI3U3w5X1VVaSij8KPdjetFdFgfMnEnuKxHGR6t
         B5ig==
X-Gm-Message-State: AOJu0YyzDIWy17ybZyLcJp9/e4rncydjweKYuP5KGso96hyFC8JLbgKa
	KalYeDJXMbzWXrC2uA5TX76KxDZuIPikJiCnSTvIFKTz5MpQt1dqnT3d3qODwko=
X-Google-Smtp-Source: AGHT+IEOGZ6MfF3HmlXB4x4R5GOlcW0mTpY+bx5fMK/MIU4Sr7wowYDUrzOBo9Az3e9nhPMxZs/twQ==
X-Received: by 2002:a2e:a796:0:b0:2cd:ef2c:b43e with SMTP id c22-20020a2ea796000000b002cdef2cb43emr4500136ljf.2.1706529149616;
        Mon, 29 Jan 2024 03:52:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ec19-20020a0564020d5300b0055f29ececeasm19907edb.57.2024.01.29.03.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:29 -0800 (PST)
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
Subject: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for shared reset-gpios
Date: Mon, 29 Jan 2024 12:52:14 +0100
Message-Id: <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on:
1. Previous OF change.
2. !GPIOLIB stub:
   https://lore.kernel.org/all/20240125081601.118051-3-krzysztof.kozlowski@linaro.org/
---
 drivers/reset/core.c             | 224 +++++++++++++++++++++++++++++--
 include/linux/reset-controller.h |   4 +
 2 files changed, 215 insertions(+), 13 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d5a78d3c085..dba74e857be6 100644
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
@@ -813,12 +839,171 @@ static void __reset_control_put_internal(struct reset_control *rstc)
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
+	 * Currently only #gpio-cells=2 is supported with the meaning of:
+	 * args[0]: GPIO number
+	 * args[1]: GPIO flags
+	 * TODO: Handle other cases.
+	 */
+	if (args->args_count != 2)
+		return -ENOENT;
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
@@ -839,39 +1024,52 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
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


