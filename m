Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402BE811BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjLMSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjLMSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:01:29 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC321106
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:34 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35f49b80192so9753895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702490494; x=1703095294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5zuCDShIaj0o7q9TPAVHj0YHPrBoAtuRhnP9FUDw7o=;
        b=J6eczgrwbWgdDPGiRuPfM5edVOXCS5pQoBRo5/m5283Ukcpmt/nAU71lpjCTvezXaF
         6j6xjXrU8D021eqO9ewkYU3bJ9x3uDaX1zcOrgpvJ2nXs7yL98zH6zym+odteLBbQv23
         4wQmqoXQt5ZZtda+oRCQOVA8XdSGT6zoIOrXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702490494; x=1703095294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5zuCDShIaj0o7q9TPAVHj0YHPrBoAtuRhnP9FUDw7o=;
        b=TV1YKxdENgdIIrVQwZGhD/vy+aqX1MaY0QoqoNKvi/+f7vhi7aWG1niG3xvGasLtPZ
         5YnCeLygX9DJH30WaDbJmuT/mRwz74p7ajYckynzcXhN38K+qBSydcRDPL7sZYxG6d5R
         CCtEY5L6IobhDg58qXth4M9/CRLC09hGF/Ka/Ixxj8rLODtKYgfm5hS4yf6q+Tq/CbEG
         DTq76N2AecuiazLjqWUlGjhfhmsQTXnWUoRx+s1j8z3o+SmUcmtp1GCXgHMHoiTZ2T3b
         rz9r2G9te06SSKnrv2QgFYiY25xd4ZsTW6ICKnemu91ydR1MvMtoYDrWPpVne78dl47H
         r+5w==
X-Gm-Message-State: AOJu0YwNNEcEfC3HcyN+OKwFGGtguDZGT2TTeb3UkDlPkzg7/Mfp2WWE
        OErNc+X5ptG5OMCbO0Whgw1KTqUdQySUXv71obo=
X-Google-Smtp-Source: AGHT+IE3/HSNrRJPaBs8k9n6oBhvz1doncfHJus7cM9rn2UGZel6thpApfXme8BPQw4RfQqHUzV+yw==
X-Received: by 2002:a05:6e02:1907:b0:35d:59b3:2f8b with SMTP id w7-20020a056e02190700b0035d59b32f8bmr8224233ilu.32.1702490492036;
        Wed, 13 Dec 2023 10:01:32 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.224])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0046671f9717csm3161206jap.109.2023.12.13.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:01:31 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH v1 1/6] gpiolib: acpi: Modify acpi_dev_irq_wake_get_by to use resource
Date:   Wed, 13 Dec 2023 11:00:19 -0700
Message-ID: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other information besides wake capability can be provided about GPIO
IRQs such as triggering, polarity, and sharability. Use resource flags
to provide this information to the caller if they want it.

This should keep the API more robust over time as flags are added,
modified, or removed. It also more closely matches acpi_irq_get which
take a resource as an argument.

Rename the function to acpi_dev_get_gpio_irq_resource to better describe
the function's new behavior.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/gpio/gpiolib-acpi.c | 25 ++++++++++++++++---------
 drivers/i2c/i2c-core-acpi.c | 10 ++++++++--
 include/linux/acpi.h        | 23 ++++++++++-------------
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 51e41676de0b8..3f6d28e1860f9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -111,6 +111,7 @@ struct acpi_gpio_info {
 	int polarity;
 	int triggering;
 	bool wake_capable;
+	bool shareable;
 	unsigned int debounce;
 	unsigned int quirks;
 };
@@ -784,6 +785,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		lookup->info.debounce = agpio->debounce_timeout;
 		lookup->info.gpioint = gpioint;
 		lookup->info.wake_capable = acpi_gpio_irq_is_wake(&lookup->info.adev->dev, agpio);
+		lookup->info.shareable = agpio->shareable == ACPI_SHARED;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
@@ -1028,11 +1030,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 }
 
 /**
- * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ number
+ * acpi_dev_get_gpio_irq_resource() - Find GpioInt and populate resource struct
  * @adev: pointer to a ACPI device to get IRQ from
  * @name: optional name of GpioInt resource
  * @index: index of GpioInt resource (starting from %0)
- * @wake_capable: Set to true if the IRQ is wake capable
+ * @r: pointer to resource to populate with irq information. It is not modified on failure.
  *
  * If the device has one or more GpioInt resources, this function can be
  * used to translate from the GPIO offset in the resource to the Linux IRQ
@@ -1047,10 +1049,12 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
  * The GPIO is considered wake capable if the GpioInt resource specifies
  * SharedAndWake or ExclusiveAndWake.
  *
- * Return: Linux IRQ number (> %0) on success, negative errno on failure.
+ * Irq number will be available in the resource structure.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
-int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
-				  bool *wake_capable)
+int acpi_dev_get_gpio_irq_resource(struct acpi_device *adev, const char *name, int index,
+				   struct resource *r)
 {
 	int idx, i;
 	unsigned int irq_flags;
@@ -1108,16 +1112,19 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, in
 			}
 
 			/* avoid suspend issues with GPIOs when systems are using S3 */
-			if (wake_capable && acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
-				*wake_capable = info.wake_capable;
+			if (info.wake_capable && !(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+				info.wake_capable = false;
 
-			return irq;
+			*r = (struct resource)DEFINE_RES_IRQ(irq);
+			r->flags = acpi_dev_irq_flags(info.triggering, info.polarity,
+						      info.shareable, info.wake_capable);
+			return 0;
 		}
 
 	}
 	return -ENOENT;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_wake_get_by);
+EXPORT_SYMBOL_GPL(acpi_dev_get_gpio_irq_resource);
 
 static acpi_status
 acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 69c50e8506d32..b89bc383ff627 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -203,6 +203,7 @@ int i2c_acpi_get_irq(struct i2c_client *client, bool *wake_capable)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	struct list_head resource_list;
+	struct resource irqres;
 	struct i2c_acpi_irq_context irq_ctx = {
 		.irq = -ENOENT,
 	};
@@ -217,8 +218,13 @@ int i2c_acpi_get_irq(struct i2c_client *client, bool *wake_capable)
 
 	acpi_dev_free_resource_list(&resource_list);
 
-	if (irq_ctx.irq == -ENOENT)
-		irq_ctx.irq = acpi_dev_gpio_irq_wake_get(adev, 0, &irq_ctx.wake_capable);
+	if (irq_ctx.irq == -ENOENT) {
+		ret = acpi_dev_get_gpio_irq_resource(adev, NULL, 0, &irqres);
+		if (ret)
+			return ret;
+		irq_ctx.irq = irqres.start;
+		irq_ctx.wake_capable = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
+	}
 
 	if (irq_ctx.irq < 0)
 		return irq_ctx.irq;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8af..20d9f3d088dbc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1238,8 +1238,8 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio);
-int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name, int index,
-				  bool *wake_capable);
+int acpi_dev_get_gpio_irq_resource(struct acpi_device *adev, const char *name, int index,
+				   struct resource *r);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
@@ -1251,28 +1251,25 @@ static inline bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 {
 	return false;
 }
-static inline int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name,
-						int index, bool *wake_capable)
+static inline int acpi_dev_get_gpio_irq_resource(struct acpi_device *adev, const char *name,
+						 int index, struct resource *r)
 {
 	return -ENXIO;
 }
 #endif
 
-static inline int acpi_dev_gpio_irq_wake_get(struct acpi_device *adev, int index,
-					     bool *wake_capable)
+static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index)
 {
-	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, wake_capable);
-}
+	struct resource r;
+	int ret;
 
-static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
-					   int index)
-{
-	return acpi_dev_gpio_irq_wake_get_by(adev, name, index, NULL);
+	ret = acpi_dev_get_gpio_irq_resource(adev, name, index, &r);
+	return ret ?: r.start;
 }
 
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
-	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, NULL);
+	return acpi_dev_gpio_irq_get_by(adev, NULL, index);
 }
 
 /* Device properties */
-- 
2.43.0.472.g3155946c3a-goog

