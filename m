Return-Path: <linux-kernel+bounces-9799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87181CB96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5392B1C21B74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741A23751;
	Fri, 22 Dec 2023 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhgiFGbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779E23743
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1fae88e66eso231923066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703257304; x=1703862104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIsLTUxJE1cxBBiiifVCcvawbyJ4lrohtOQb+rAqVac=;
        b=hhgiFGbwHUwz52j8mNsxeXgT1VIxJE8NIpT0RNJvC97hWVt/cBgE6Yc8NELwVLReyI
         Zy7Cl3m/UUH9vrvfbXPRA8qk7CrhoeVZACNkX1+bWAAIrDO+lY+k25qeJ+bffRVdARxV
         tlDWIiKYTVEyZ8MIjs0J+ECescmIeL/HctVW/llmsbrlmlRmw1RnZB6PlpyrmQ12aggr
         DiFUCWenO4pkNdPiALv6N1gVFKHgyg9x04H9pFZ0bK9Gi6p/zRDo0JyLU+bnI/iK6NTK
         sVTh2s1e4ogikW0a1kQ7VbZhV/cUJgjIlPlQKqMLivSIDbj/lbjF2dUy3H8K0g8FW3xs
         Y2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257304; x=1703862104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIsLTUxJE1cxBBiiifVCcvawbyJ4lrohtOQb+rAqVac=;
        b=GVOnwB5U9EzkOD8q8BfsmVq+1zg25mlu5PX21IrOdUqk82J6wrL6YGDxHwDMc6R+t3
         uihVrbV4ZMVTE3lrH/MzMxSd26SSopxfBRZuWeXUbUCNiEW20goEn4cMnO3Erme3/UI/
         QpXdBHHQDXPctyibtJXPPa8rzEcUFX1BRsRD4+NnVYnBRkChzx+61TD9ypRlXwftuDuI
         ZhxvT7ue5ohqD61xDc2o7NpusHN8S2kKIYZmVryi8ptLAO1K8mXstjWMN1IOjIJKObZW
         y0cpChklHtQC1Wmyp2bDAxlXix12ZIuNz5jl/OYfaVYEM5VpMFxRN7TZI5jqkDFvBCDG
         A1tA==
X-Gm-Message-State: AOJu0YwaoPaz8F989Fk2PizpiNiZB/MR+81CG3ulczdCJ4UgDzPJn53C
	itxA8hjF3LOXFuIAkGhTceWN8vQqaJWy1w==
X-Google-Smtp-Source: AGHT+IFOVAFE/3mSgxDg8r0BmeFffXjHPsKVAmnpzZGOR+G92xcuwjc1mM3+0AL59eOzOUdBtOOHBQ==
X-Received: by 2002:a17:906:eb51:b0:a26:858b:b76e with SMTP id mc17-20020a170906eb5100b00a26858bb76emr831943ejb.105.1703257304630;
        Fri, 22 Dec 2023 07:01:44 -0800 (PST)
Received: from krzk-bin.. ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090791c100b00a26af35c171sm1275671ejz.0.2023.12.22.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:01:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 1/4] reset: instantiate reset GPIO controller for shared reset-gpios
Date: Fri, 22 Dec 2023 16:01:30 +0100
Message-Id: <20231222150133.732662-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
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

If Devicetree-based device requests a reset line which is missing but
there is a reset-gpios property, instantiate a new "reset-gpio" platform
device which will handle such reset line.  This allows seamless handling
of such shared reset-gpios without need of changing Devicetree binding [1].

The "reset-gpio" driver follows shortly.

Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/reset/core.c             | 70 +++++++++++++++++++++++++++-----
 include/linux/reset-controller.h |  2 +
 2 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d5a78d3c085..a1f0f515a7e0 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -10,9 +10,12 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
@@ -813,13 +816,59 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
+static int __reset_add_reset_gpio_device(struct device_node *node,
+					 const struct gpio_desc **out)
+{
+	struct platform_device *pdev;
+	int gpio;
+
+	/* Don't care about deprecated '-gpio' suffix. */
+	gpio = of_get_named_gpio(node, "reset-gpios", 0);
+	if (!gpio_is_valid(gpio))
+		return gpio;
+
+	pdev = platform_device_register_data(NULL, "reset-gpio",
+					     PLATFORM_DEVID_AUTO, &node,
+					     sizeof(node));
+	if (!IS_ERR(pdev))
+		*out = gpio_to_desc(gpio);
+
+	return PTR_ERR_OR_ZERO(pdev);
+}
+
+static struct reset_controller_dev *__reset_find_rcdev(const struct of_phandle_args *args,
+						       const void *cookie)
+{
+	struct reset_controller_dev *r, *rcdev;
+
+	lockdep_assert_held(&reset_list_mutex);
+
+	rcdev = NULL;
+	list_for_each_entry(r, &reset_controller_list, list) {
+		if (args && args->np) {
+			if (args->np == r->of_node) {
+				rcdev = r;
+				break;
+			}
+		} else if (cookie) {
+			if (cookie == r->cookie) {
+				rcdev = r;
+				break;
+			}
+		}
+	}
+
+	return rcdev;
+}
+
 struct reset_control *
 __of_reset_control_get(struct device_node *node, const char *id, int index,
 		       bool shared, bool optional, bool acquired)
 {
+	const struct gpio_desc *gpio = NULL;
+	struct of_phandle_args args = {0};
 	struct reset_control *rstc;
-	struct reset_controller_dev *r, *rcdev;
-	struct of_phandle_args args;
+	struct reset_controller_dev *rcdev;
 	int rstc_id;
 	int ret;
 
@@ -839,17 +888,16 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 					 index, &args);
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
-	if (ret)
-		return optional ? NULL : ERR_PTR(ret);
+	if (ret) {
+		ret = __reset_add_reset_gpio_device(node, &gpio);
+		if (ret)
+			return optional ? NULL : ERR_PTR(ret);
+
+		args.args_count = 1; /* reset-gpio has only one reset line */
+	}
 
 	mutex_lock(&reset_list_mutex);
-	rcdev = NULL;
-	list_for_each_entry(r, &reset_controller_list, list) {
-		if (args.np == r->of_node) {
-			rcdev = r;
-			break;
-		}
-	}
+	rcdev = __reset_find_rcdev(&args, gpio);
 
 	if (!rcdev) {
 		rstc = ERR_PTR(-EPROBE_DEFER);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 0fa4f60e1186..c0a99a8ea29e 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -61,6 +61,7 @@ struct reset_control_lookup {
  * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
  * @of_reset_n_cells: number of cells in reset line specifiers
+ * @cookie: for reset-gpios controllers: corresponding GPIO instead of of_node
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops, defaults
  *            to :c:func:`of_reset_simple_xlate`.
@@ -74,6 +75,7 @@ struct reset_controller_dev {
 	struct device *dev;
 	struct device_node *of_node;
 	int of_reset_n_cells;
+	const void *cookie;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
 	unsigned int nr_resets;
-- 
2.34.1


