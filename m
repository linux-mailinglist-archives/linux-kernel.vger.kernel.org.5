Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BAD7AEF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjIZPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjIZPAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:00:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0A120
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:59:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f71b25a99so8908186f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695740392; x=1696345192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JlgJB8QI0EX98WcT+eE7uEPjq//nnV5NSDnPP83OC4=;
        b=QOEf7hjuT0l4WBz4752PrDciv1tUKsPuy3vsqzwR9P3r+SvYiiQdiyqoxcOBCU2nEz
         oCqKbDgvbwDt1BPuIRea7SAXZIOk5ArBt+X+BZi9X710A+OXLUblvhMY+QKvB4dzBgED
         5TJ8MmN/L17oHo3FAk+xHPw+2OVXrxopLQPHKblC3uKs2clOEGDnJCUUvk3fCPxYYGoz
         fGGgYnO8bzNMbkjkReuRg5uJrmQrDFV/z1qB0UrHb9PWBns9UaH0yN8MZsh1zMloJNjH
         W1i9N0eZ+t60v3O97ArAgo/5gryTKaWbM9f8S47DyV7NtPKLOibDBO974ENjIyFBmPIL
         sdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740392; x=1696345192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JlgJB8QI0EX98WcT+eE7uEPjq//nnV5NSDnPP83OC4=;
        b=EBNssfZnjzFMgSfpyQyn//8jw7HSQvo7lQveGqzts8P8Nb8L7vAJWGJBHcULQ7JS9j
         xHtLRU+cauTLXzARzNKb4V+OoR0vjOjdeWlp3sdT24bHezij7riCdokw3VkgYz/IPngi
         tdTaVScdxyjTlXvQU2v4Ac6e4AMSyJASYV7XODU0JnUZCtyVmQAA0fVxLz+eGXGfkihJ
         y10YThpUY39Etj8tCAhni0CdnBvj7s/0L2w8aVvHvtiskfTEsa2dpVgvRljPCNByeMj6
         uYgdrNa2/Fsn3jiGjyv2/7KybK+fnRmhzKIwcTRvMFuCPgNFqgexnne6Uo9uXVq5Czx/
         43nQ==
X-Gm-Message-State: AOJu0Yxt+q1YdXfUgYmWnW3Hasc6XyNo39KoHZGX32/iypwP0WuPExQp
        UHZWTmknO4Nsz7tBSp1axYBZHw==
X-Google-Smtp-Source: AGHT+IEry51pvRXcR/Bg3Ovg+pDmNC+cZF8nAceS0yECUnNz+7mE5ZPaS3ORz3jPT6CvosswbIBsEA==
X-Received: by 2002:a5d:658b:0:b0:321:708d:3374 with SMTP id q11-20020a5d658b000000b00321708d3374mr8387415wru.3.1695740392138;
        Tue, 26 Sep 2023 07:59:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:686:c497:30b1:d2b9])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d5102000000b0031f82743e25sm14871634wrt.67.2023.09.26.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:59:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 1/4] platform/x86: int3472: provide a helper for getting GPIOs from lookups
Date:   Tue, 26 Sep 2023 16:59:40 +0200
Message-Id: <20230926145943.42814-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926145943.42814-1-brgl@bgdev.pl>
References: <20230926145943.42814-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

gpiod_toggle_active_low() should have never existed in the first place
and once it was added, it should have never been used outside the MMC
slot code.

Stop using it in the int3472 driver and use temporary lookup tables
instead. First: add a helper wrapping the common code in one function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/platform/x86/intel/int3472/common.c | 29 +++++++++++++++++++++
 drivers/platform/x86/intel/int3472/common.h |  9 +++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/common.c b/drivers/platform/x86/intel/int3472/common.c
index 9db2bb0bbba4..61a8240ed6db 100644
--- a/drivers/platform/x86/intel/int3472/common.c
+++ b/drivers/platform/x86/intel/int3472/common.c
@@ -2,6 +2,10 @@
 /* Author: Dan Scally <djrscally@gmail.com> */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/gpio/machine.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include "common.h"
@@ -80,3 +84,28 @@ int skl_int3472_get_sensor_adev_and_name(struct device *dev,
 
 	return ret;
 }
+
+/* This should *really* only be used when there's no other way... */
+struct gpio_desc *
+skl_int3472_gpiod_get_from_temp_lookup(struct device *dev,
+				       const char *chip_label, u16 hwnum,
+				       const char *con_id,
+				       enum gpio_lookup_flags lflags,
+				       enum gpiod_flags rflags)
+{
+	struct gpio_desc *desc;
+
+	struct gpiod_lookup_table *lookup __free(kfree) =
+			kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup)
+		return ERR_PTR(-ENOMEM);
+
+	lookup->dev_id = dev_name(dev);
+	lookup->table[0] = GPIO_LOOKUP(chip_label, hwnum, con_id, lflags);
+
+	gpiod_add_lookup_table(lookup);
+
+	desc = gpiod_get(dev, con_id, rflags);
+	gpiod_remove_lookup_table(lookup);
+	return desc;
+}
diff --git a/drivers/platform/x86/intel/int3472/common.h b/drivers/platform/x86/intel/int3472/common.h
index 9f29baa13860..85ef9b630044 100644
--- a/drivers/platform/x86/intel/int3472/common.h
+++ b/drivers/platform/x86/intel/int3472/common.h
@@ -5,6 +5,8 @@
 #define _INTEL_SKL_INT3472_H
 
 #include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/leds.h>
 #include <linux/regulator/driver.h>
@@ -129,4 +131,11 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472,
 			      struct acpi_resource_gpio *agpio, u32 polarity);
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472);
 
+struct gpio_desc *
+skl_int3472_gpiod_get_from_temp_lookup(struct device *dev,
+				       const char *chip_label, u16 hwnum,
+				       const char *con_id,
+				       enum gpio_lookup_flags lflags,
+				       enum gpiod_flags rflags);
+
 #endif
-- 
2.39.2

