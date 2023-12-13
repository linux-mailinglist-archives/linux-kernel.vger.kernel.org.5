Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B97811BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjLMSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378704AbjLMSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:01:34 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD35F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:39 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35f56f06142so17764045ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702490499; x=1703095299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8hy9U0u31jlEXJskU1SvJZS3MimHWM0Shv24H/JxDk=;
        b=jQEeNqHaeqvEnFMbR9H2xtfqblBPVg7S0SdUBk6zV+bO7Ux2TbUbWZCC1nclJ1lwDc
         ZYWpDW4ITC6cOHx/eABo5M55KATMCwsTBQIhnhN0HO9IXtJPZKFDcZ1iz4U55zhYKkvB
         6J3DQvlxUoWKpRg7zOhW16wRD6S3e0rOgoOF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490499; x=1703095299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8hy9U0u31jlEXJskU1SvJZS3MimHWM0Shv24H/JxDk=;
        b=wx62O2Ask2A/IjEEONbhyGULo/WNg3xQ5j/NopWjMKq76gWCo03OpTbsBuBL2pywdx
         srmWI0fpoD4NHlmFHwICsE3qjcMJp66m+WHZBcqbqi2nDchtmv65KTFENiRcMEHaGgAN
         wXASX8TS9MgBwiS5nU7zd70JjI0S8n9jzreqHU1HtBYg4dhJCkoLolmy9LZndQY0naH1
         EfzbBnJDfyPG9yKuPpVJZi9QJdnFRAIOXKpA3qbAE3pFYicanhCKhvyk6NkISr9/BFrT
         6XFnIrsNcjtk16RDrtfhIUYZFNqoMcuUUzz6KL62be7Elrc2N6Kezxe4khUJClUlDFCc
         FoLw==
X-Gm-Message-State: AOJu0YyxnuI7UACRxlCOchda7QVK5rbpJgjs0LUSNKcTqga71HJtE7ty
        EAKX73fnDU97oEnFEpfpoDPW4Zte5Rvlf2PYku0=
X-Google-Smtp-Source: AGHT+IFUTm6Fuy7kMGXvsoFTORv7BSsMnWCJ3NRu5ZqG6Q6+qVfSMpMhy8Zo5p/SP7lfluTU26XEZA==
X-Received: by 2002:a05:6e02:1d84:b0:35d:5995:7993 with SMTP id h4-20020a056e021d8400b0035d59957993mr10706467ila.45.1702490499016;
        Wed, 13 Dec 2023 10:01:39 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.224])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0046671f9717csm3161206jap.109.2023.12.13.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:01:38 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 5/6] platform: Modify platform_get_irq_optional() to use resource
Date:   Wed, 13 Dec 2023 11:00:23 -0700
Message-ID: <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify handling of ACPI, GPIO, devictree, and platform resource
interrupts in platform_get_irq_optional(). Each of these subsystems
provide their own apis which provide IRQ information as a struct
resource. This simplifies the logic of the function and allows callers
to get more information about the irq by looking at the resource flags.
For example, whether or not an irq is wake capable.

Rename the function to platform_get_irq_resource() to better describe
the function's new behavior.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/base/platform.c         | 78 ++++++++++++++++++---------------
 include/linux/platform_device.h |  9 +++-
 2 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba250039..6b58bde776d4f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -151,9 +151,10 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
 
 /**
- * platform_get_irq_optional - get an optional IRQ for a device
+ * platform_get_irq_resource - get an IRQ for a device and populate resource struct
  * @dev: platform device
  * @num: IRQ number index
+ * @r: pointer to resource to populate with irq information. It is not modified on failure.
  *
  * Gets an IRQ for a platform device. Device drivers should check the return
  * value for errors so as to not pass a negative integer value to the
@@ -162,59 +163,47 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  *
  * For example::
  *
- *		int irq = platform_get_irq_optional(pdev, 0);
+ *		int irq = platform_get_irq_resource(pdev, 0, &res);
  *		if (irq < 0)
  *			return irq;
  *
  * Return: non-zero IRQ number on success, negative error number on failure.
  */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+int platform_get_irq_resource(struct platform_device *dev, unsigned int num, struct resource *r)
 {
 	int ret;
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		goto out_not_found;
+		return -ENXIO;
 	ret = dev->archdata.irqs[num];
+	if (ret >= 0)
+		*r = (struct resource)DEFINE_RES_IRQ(ret);
 	goto out;
 #else
-	struct resource *r;
+	struct resource *platform_res;
 
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		ret = of_irq_get(dev->dev.of_node, num);
+		ret = of_irq_to_resource(dev->dev.of_node, num, r);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			goto out;
 	}
 
-	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
-	if (has_acpi_companion(&dev->dev)) {
-		if (r && r->flags & IORESOURCE_DISABLED) {
-			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
-			if (ret)
-				goto out;
-		}
-	}
-
-	/*
-	 * The resources may pass trigger flags to the irqs that need
-	 * to be set up. It so happens that the trigger flags for
-	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
-	 * settings.
-	 */
-	if (r && r->flags & IORESOURCE_BITS) {
-		struct irq_data *irqd;
-
-		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			goto out_not_found;
-		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
-	}
-
-	if (r) {
+	platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
+	if (platform_res && !(platform_res->flags & IORESOURCE_DISABLED)) {
+		*r = *platform_res;
 		ret = r->start;
 		goto out;
 	}
 
+	if (has_acpi_companion(&dev->dev)) {
+		ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
+		if (!ret || ret == -EPROBE_DEFER) {
+			ret = ret ?: r->start;
+			goto out;
+		}
+	}
+
 	/*
 	 * For the index 0 interrupt, allow falling back to GpioInt
 	 * resources. While a device could have both Interrupt and GpioInt
@@ -223,21 +212,38 @@ int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 	 * allows a common code path across either kind of resource.
 	 */
 	if (num == 0 && has_acpi_companion(&dev->dev)) {
-		ret = acpi_dev_gpio_irq_get(ACPI_COMPANION(&dev->dev), num);
+		ret = acpi_dev_get_gpio_irq_resource(ACPI_COMPANION(&dev->dev), NULL,
+						     num, r);
 		/* Our callers expect -ENXIO for missing IRQs. */
-		if (ret >= 0 || ret == -EPROBE_DEFER)
+		if (!ret || ret == -EPROBE_DEFER) {
+			ret = ret ?: r->start;
 			goto out;
+		}
 	}
-
 #endif
-out_not_found:
 	ret = -ENXIO;
 out:
 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
 		return -EINVAL;
+
+	/*
+	 * The resources may pass trigger flags to the irqs that need
+	 * to be set up. It so happens that the trigger flags for
+	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
+	 * settings.
+	 */
+	if (ret > 0 && r->flags & IORESOURCE_BITS) {
+		struct irq_data *irqd;
+
+		irqd = irq_get_irq_data(r->start);
+		if (!irqd)
+			ret = -ENXIO;
+		else
+			irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
+	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(platform_get_irq_optional);
+EXPORT_SYMBOL_GPL(platform_get_irq_resource);
 
 /**
  * platform_get_irq - get an IRQ for a device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c19591..cdaddab4d9241 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -101,7 +101,14 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 #endif
 
 extern int platform_get_irq(struct platform_device *, unsigned int);
-extern int platform_get_irq_optional(struct platform_device *, unsigned int);
+extern int platform_get_irq_resource(struct platform_device *dev, unsigned int num,
+				     struct resource *r);
+static inline int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
+{
+	struct resource r;
+
+	return platform_get_irq_resource(dev, num, &r);
+}
 extern int platform_irq_count(struct platform_device *);
 extern int devm_platform_get_irqs_affinity(struct platform_device *dev,
 					   struct irq_affinity *affd,
-- 
2.43.0.472.g3155946c3a-goog

