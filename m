Return-Path: <linux-kernel+bounces-7674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4781AB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5322CB2526F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233451C55;
	Wed, 20 Dec 2023 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDBMRblI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15E51013
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fd9e17d8so8882039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116527; x=1703721327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtp1XFn63K+PU8VMmKC4HIoyuYSE41ytBO8LFSmozbo=;
        b=CDBMRblImIqmjF/lsOH/ZBxJ6FBTAtLOGyyBjPP1sEk/Qp6VWnUvU2kqDu4dm9bZ8S
         PYSvxyHKx2wPl/WcyPzs8Vj2MroB6mLt4Wj499MmA3IjKagfF6e3jBPtBg+kqwqWowXX
         BwG7/B8PqKArydf9XrNuBvMSpwbX0EZ+1SsWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116527; x=1703721327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtp1XFn63K+PU8VMmKC4HIoyuYSE41ytBO8LFSmozbo=;
        b=gpbKTnblJoUKaVBgHnvmGuJZpKNlvv3dp82BVy6g3GbOHeF15a1IcPO1of6DKSrRXR
         Ta+IK4MTqZwuerNouZc0xQ2tTITrqLDf3ya7BG6NzT4O6Vly0CyYdgzGnlUJdktAKs+S
         T7FHWFa4l/+FkjN8UJOkjhSt+SYI0ZLTMAzz6MYfBrM16O51mSEPPT8sOnyysTT2WwQB
         2m3axhKlB9/xfJ218hChf67Q5Cxd/m8ZEtggCyxJhj5gQpiD9cFtKfZJKvQQ0MSvUWsF
         BosRVZMZCYslJYaK8y0+n+AJUp2VhvDMA6EYvQbdWAxKildxjx8NU3Kurs0S4MguZpi0
         zdWQ==
X-Gm-Message-State: AOJu0YyjzQeRGUs5f+yICdA0jI9AVIMlezX/OB2RRsymCbQ9RdTGtj26
	6U6i4Ya0GzbD29bu/8kexJ0m+FZseTxrr8SZsBU=
X-Google-Smtp-Source: AGHT+IFpqpe0ud1ShLHI3kINFwVEaIzgWl/hreygLsaoS9WRasmIZYA5LMmQCQbESPNP3ZHJJ+Ud9Q==
X-Received: by 2002:a6b:f108:0:b0:7ba:84bc:7438 with SMTP id e8-20020a6bf108000000b007ba84bc7438mr308808iog.12.1703116527121;
        Wed, 20 Dec 2023 15:55:27 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:26 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 21/22] platform: Modify platform_get_irq_optional() to use resource
Date: Wed, 20 Dec 2023 16:54:35 -0700
Message-ID: <20231220165423.v2.21.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify handling of ACPI, GPIO, devictree, and platform resource
interrupts in platform_get_irq_optional(). Each of these subsystems
provide their own APIs which provide IRQ information as a struct
resource. This simplifies the logic of the function and allows callers
to get more information about the IRQ by looking at the resource flags.
For example, whether or not an IRQ is wake capable.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-irq->IRQ
-Remove cast to struct resource
-Conform to get_optional() function naming
-Revert move of irq_get_irq_data()
-Add NULL check on struct resource*
-Use fwnode to retrieve IRQ for DT/ACPI

 drivers/base/platform.c         | 74 +++++++++++++++++++++++----------
 include/linux/platform_device.h |  3 ++
 2 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c5779634182..3a556faddd40d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -151,9 +151,11 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
 
 /**
- * platform_get_irq_optional - get an optional IRQ for a device
+ * platform_get_irq_resource_optional - get an optional IRQ for a device and
+ *					populate the resource struct
  * @dev: platform device
  * @num: IRQ number index
+ * @r: pointer to resource to populate with IRQ information.
  *
  * Gets an IRQ for a platform device. Device drivers should check the return
  * value for errors so as to not pass a negative integer value to the
@@ -162,47 +164,42 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  *
  * For example::
  *
- *		int irq = platform_get_irq_optional(pdev, 0);
+ *		int irq = platform_get_irq_resource_optional(pdev, 0, &res);
  *		if (irq < 0)
  *			return irq;
  *
  * Return: non-zero IRQ number on success, negative error number on failure.
  */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+int platform_get_irq_resource_optional(struct platform_device *dev,
+				       unsigned int num, struct resource *r)
 {
 	int ret;
+	if (IS_ERR_OR_NULL(r))
+		return -EINVAL;
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
 		goto out_not_found;
 	ret = dev->archdata.irqs[num];
+	if (ret > 0)
+		*r = DEFINE_RES_IRQ(ret);
 	goto out;
 #else
 	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
-	struct resource *r;
+	struct resource *platform_res;
 
-	if (is_of_node(fwnode)) {
-		ret = of_irq_get(to_of_node(fwnode), num);
-		if (ret > 0 || ret == -EPROBE_DEFER)
-			goto out;
-	}
-
-	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
-	if (is_acpi_device_node(fwnode)) {
-		if (r && r->flags & IORESOURCE_DISABLED) {
-			ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), num, r);
-			if (ret)
-				goto out;
-		}
-	}
+	ret = fwnode_irq_get_resource(fwnode, num, r);
+	if (ret > 0 || ret == -EPROBE_DEFER)
+		goto out;
 
+	platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	/*
 	 * The resources may pass trigger flags to the irqs that need
 	 * to be set up. It so happens that the trigger flags for
 	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
 	 * settings.
 	 */
-	if (r && r->flags & IORESOURCE_BITS) {
+	if (platform_res && platform_res->flags & IORESOURCE_BITS) {
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
@@ -211,7 +208,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	if (r) {
+	if (platform_res) {
+		*r = *platform_res;
 		ret = r->start;
 		goto out;
 	}
@@ -224,10 +222,12 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * allows a common code path across either kind of resource.
 	 */
 	if (num == 0 && is_acpi_device_node(fwnode)) {
-		ret = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), num);
+		ret = acpi_dev_get_gpio_irq_resource(to_acpi_device_node(fwnode), NULL, num, r);
 		/* Our callers expect -ENXIO for missing IRQs. */
-		if (ret >= 0 || ret == -EPROBE_DEFER)
+		if (!ret || ret == -EPROBE_DEFER) {
+			ret = ret ?: r->start;
 			goto out;
+		}
 	}
 
 #endif
@@ -238,7 +238,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		return -EINVAL;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(platform_get_irq_optional);
+EXPORT_SYMBOL_GPL(platform_get_irq_resource_optional);
+
 
 /**
  * platform_get_irq - get an IRQ for a device
@@ -270,6 +271,33 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
+
+/**
+ * platform_get_irq_optional - get an optional IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device. Device drivers should check the return
+ * value for errors so as to not pass a negative integer value to the
+ * request_irq() APIs. This is the same as platform_get_irq(), except that it
+ * does not print an error message if an IRQ can not be obtained.
+ *
+ * For example::
+ *
+ *		int irq = platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: non-zero IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	struct resource r;
+
+	return platform_get_irq_resource_optional(dev, num, &r);
+}
+EXPORT_SYMBOL_GPL(platform_get_irq_optional);
+
 /**
  * platform_irq_count - Count the number of IRQs a platform device uses
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c19591..2117f817d9c9c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -102,6 +102,9 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
+extern int platform_get_irq_resource_optional(struct platform_device *dev,
+					      unsigned int num,
+					      struct resource *r);
 extern int platform_irq_count(struct platform_device *);
 extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
 					   struct irq_affinity *affd,
-- 
2.43.0.472.g3155946c3a-goog


