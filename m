Return-Path: <linux-kernel+bounces-14847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68F822325
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BF0283213
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612761A59A;
	Tue,  2 Jan 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UfHrPRyq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E119BAF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b7a9f90f34so534023839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229744; x=1704834544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Hw1xlFNdgkxULgKG3GwEV3Tvyifb1Pre98NYX4zJtY=;
        b=UfHrPRyq1K9c0fjROBFDROpkjVV6Z50HJqMAJpG8fOpr/uhXpbzrD1pKOfcXkEQa+s
         mm2PgWG4g6H+26K96NqcZttpagvkW34EJW8+cbLAZQEo6MA35vUcGEwSUvQ/cWX/+oJ7
         Sl3uYn4dTikDMei4/omb3FJyPq5XSGvZRlgZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229744; x=1704834544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Hw1xlFNdgkxULgKG3GwEV3Tvyifb1Pre98NYX4zJtY=;
        b=qSwaUCEJrqk34CarG6D4Oa9tRxvHE5+ujsjzR5rpIH9PrkoZaa+J70gviA3eINNykg
         nlA67Oj4TAp3qySeX0TlZwgSDWgzHaElA2qt0q9NPXyoORtlBnmrP76b6yMEcJsRtz/7
         JMx7PVzu2rHH16UtLYmN5HvPkJQxPxs7+NF4mjurIEnXdez6YsaK9er2PrsKwX6maQ6r
         e5bm6tk55aMQsVaSmwGPqNy4A1cLOTE/WQnrgFgzGbUdH5f6R371g9qqEJmTVjKznOhm
         Fdyj2LOTTVWSix+jATnY89o9Cx/JpV8ciM75fSAPY7WAUEc3Xz/U+s+mYVha082gpPCk
         NLtA==
X-Gm-Message-State: AOJu0YyRax78fdLRSFPSEo/wn3lpF1fIQeJ3QoGgvgHPLizGVUMZzUDO
	1yLgP1hwO0CRsvuLm0CqDQHNzYIgM5JneTUMwQ/WKNj0uuJ1
X-Google-Smtp-Source: AGHT+IGAcEK3EYkLyXzYhh0D70uGgywH+FK/tVqwGL/00V/2ysJdiNcQHdqv0vUPAVh1zNTtSWFZiw==
X-Received: by 2002:a05:6602:e03:b0:7ba:a232:30fe with SMTP id gp3-20020a0566020e0300b007baa23230femr13087873iob.20.1704229744185;
        Tue, 02 Jan 2024 13:09:04 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:09:03 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 23/24] platform: Modify platform_get_irq_optional() to use resource
Date: Tue,  2 Jan 2024 14:07:47 -0700
Message-ID: <20240102140734.v4.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Changes in v4:
-platform_get_irq_optional() returns 0 on success

Changes in v3:
-Remove PTR_ERR check
-Move platform_res assignment
-Check for irq == 0 to trigger WARN msg
-Refactor error handling of acpi_dev_get_gpio_irq_resource() to be
consistent with fwnode_irq_get_resource()
-Remove extra blank lines
-Initialize struct resource on stack

Changes in v2:
-irq->IRQ
-Remove cast to struct resource
-Conform to get_optional() function naming
-Revert move of irq_get_irq_data()
-Add NULL check on struct resource*
-Use fwnode to retrieve IRQ for DT/ACPI

 drivers/base/platform.c         | 90 +++++++++++++++++++++------------
 include/linux/platform_device.h |  3 ++
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c5779634182..8a42b48922e68 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -151,50 +151,45 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
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
- * value for errors so as to not pass a negative integer value to the
- * request_irq() APIs. This is the same as platform_get_irq(), except that it
- * does not print an error message if an IRQ can not be obtained.
+ * value for errors. If no error is returned, the IRQ can be found in r->start.
  *
  * For example::
  *
- *		int irq = platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
- *			return irq;
+ *		int res = platform_get_irq_resource_optional(pdev, 0, &res);
+ *		if (!res)
+ *			return res.start;
  *
- * Return: non-zero IRQ number on success, negative error number on failure.
+ * Return: 0 on success, negative error number on failure.
  */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+int platform_get_irq_resource_optional(struct platform_device *dev,
+				       unsigned int num, struct resource *r)
 {
 	int ret;
+
+	if (!r)
+		return -EINVAL;
+
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
 		goto out_not_found;
-	ret = dev->archdata.irqs[num];
+	*r = DEFINE_RES_IRQ(dev->archdata.irqs[num]);
+	ret = 0;
 	goto out;
 #else
 	struct fwnode_handle *fwnode = dev_fwnode(&dev->dev);
-	struct resource *r;
 
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
+	ret = ret < 0 ? ret : 0;
+	if (!ret || ret == -EPROBE_DEFER)
+		goto out;
 
 	/*
 	 * The resources may pass trigger flags to the irqs that need
@@ -202,7 +197,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
 	 * settings.
 	 */
-	if (r && r->flags & IORESOURCE_BITS) {
+	struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
+
+	if (platform_res && platform_res->flags & IORESOURCE_BITS) {
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
@@ -211,8 +208,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	if (r) {
-		ret = r->start;
+	if (platform_res) {
+		*r = *platform_res;
+		ret = 0;
 		goto out;
 	}
 
@@ -224,9 +222,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * allows a common code path across either kind of resource.
 	 */
 	if (num == 0 && is_acpi_device_node(fwnode)) {
-		ret = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), num);
+		ret = acpi_dev_get_gpio_irq_resource(to_acpi_device_node(fwnode), NULL, num, r);
 		/* Our callers expect -ENXIO for missing IRQs. */
-		if (ret >= 0 || ret == -EPROBE_DEFER)
+		if (!ret || ret == -EPROBE_DEFER)
 			goto out;
 	}
 
@@ -234,11 +232,11 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 out_not_found:
 	ret = -ENXIO;
 out:
-	if (WARN(!ret, "0 is an invalid IRQ number\n"))
+	if (WARN(!ret && !r->start, "0 is an invalid IRQ number\n"))
 		return -EINVAL;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(platform_get_irq_optional);
+EXPORT_SYMBOL_GPL(platform_get_irq_resource_optional);
 
 /**
  * platform_get_irq - get an IRQ for a device
@@ -270,6 +268,34 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
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
+	int ret;
+	struct resource r = {};
+
+	ret = platform_get_irq_resource_optional(dev, num, &r);
+	return ret ?: r.start;
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


