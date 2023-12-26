Return-Path: <linux-kernel+bounces-11651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4681E96D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E757B21D08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3B1EB36;
	Tue, 26 Dec 2023 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bHItEUsm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E51C2B3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso199200339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618542; x=1704223342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6tsT/7sNyFm2KzBYrGyHG8VbifTdBXO1YqorM6Zb+w=;
        b=bHItEUsmLdLELfxu2a7Vav32ZUZKFGm/r2pKp6NddrvcTDMD3tUiN6xgdz9R+y0EOG
         9mKwOb6vsMh/rGTBpfcAa0V1Z1YVYUvUJd8ORvZJJazCURZhu+NpdsN4IRKwXRZ/wA2h
         77xCpoxKFfUUdwBxSQe4jk7WoRyn2g8hWI6Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618542; x=1704223342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6tsT/7sNyFm2KzBYrGyHG8VbifTdBXO1YqorM6Zb+w=;
        b=NQSZym0Ox+lOFwcZsYEd4+Rp2ly61X0Jt73xCCu6wv9DNL5C/auAV06YVJkGz2Iumw
         Ydrxkas3DnpZaoyGYee+T08w7yk3FwUOItC0qqcez/61R5ZzHaIA6A6af/hbcgHT3y3O
         GS+T2pPyQaJu6iZ9lIF8SdInGcMm4BTV5wJBWklvB2UWkb4niiUEeVQefZsR0YBhHgES
         KfME+hSKl8u/yutS8rExZvbkIgdI9A9R/qdlhS+xf5ZjNUjm8QAIcLXfk3HG8KnTAa5/
         fvUp876GRmqvNRZ/xZI7n7FHeAOijI4XRyCmPwfXPPKm8LIjKog8V33jEyvxTrDJWwJB
         kO6Q==
X-Gm-Message-State: AOJu0YwaEVNLluhovCW5/bBn8REuEmBJq6KGEgWmN7IHiQIhB24CHfMS
	XbiDwbsZWs0NDOZXE9m26paMecvHkEURkwh3BEQ0d8nJRSx5
X-Google-Smtp-Source: AGHT+IERechMaC3iD6M6tDF0p2jDjZ84jAh0OVsFAvat03jaAmnhahDwtdIVJI6dxXkg63oXuGThoA==
X-Received: by 2002:a05:6602:181a:b0:7ba:9ac4:3a49 with SMTP id t26-20020a056602181a00b007ba9ac43a49mr8155131ioh.17.1703618541957;
        Tue, 26 Dec 2023 11:22:21 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:21 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 23/24] platform: Modify platform_get_irq_optional() to use resource
Date: Tue, 26 Dec 2023 12:21:27 -0700
Message-ID: <20231226122113.v3.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
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

 drivers/base/platform.c         | 70 ++++++++++++++++++++++-----------
 include/linux/platform_device.h |  3 ++
 2 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c5779634182..bb6ece1303746 100644
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
@@ -162,39 +164,33 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
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
+
+	if (!r)
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
-
-	if (is_of_node(fwnode)) {
-		ret = of_irq_get(to_of_node(fwnode), num);
-		if (ret > 0 || ret == -EPROBE_DEFER)
-			goto out;
-	}
 
-	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
-	if (is_acpi_device_node(fwnode)) {
-		if (r && r->flags & IORESOURCE_DISABLED) {
-			ret = acpi_irq_get(ACPI_HANDLE_FWNODE(fwnode), num, r);
-			if (ret)
-				goto out;
-		}
-	}
+	ret = fwnode_irq_get_resource(fwnode, num, r);
+	if (ret >= 0 || ret == -EPROBE_DEFER)
+		goto out;
 
 	/*
 	 * The resources may pass trigger flags to the irqs that need
@@ -202,7 +198,9 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
 	 * settings.
 	 */
-	if (r && r->flags & IORESOURCE_BITS) {
+	struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
+
+	if (platform_res && platform_res->flags & IORESOURCE_BITS) {
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
@@ -211,7 +209,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	if (r) {
+	if (platform_res) {
+		*r = *platform_res;
 		ret = r->start;
 		goto out;
 	}
@@ -224,7 +223,8 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * allows a common code path across either kind of resource.
 	 */
 	if (num == 0 && is_acpi_device_node(fwnode)) {
-		ret = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), num);
+		ret = acpi_dev_get_gpio_irq_resource(to_acpi_device_node(fwnode), NULL, num, r);
+		ret = ret ?: r->start;
 		/* Our callers expect -ENXIO for missing IRQs. */
 		if (ret >= 0 || ret == -EPROBE_DEFER)
 			goto out;
@@ -238,7 +238,7 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 		return -EINVAL;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(platform_get_irq_optional);
+EXPORT_SYMBOL_GPL(platform_get_irq_resource_optional);
 
 /**
  * platform_get_irq - get an IRQ for a device
@@ -270,6 +270,32 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
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
+	struct resource r = {};
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


