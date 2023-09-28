Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D527B1CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjI1MmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjI1MmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6419D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695904885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEs40AJ4lM3j9ffIIAlvF9xgj3FRAy6IbL4eThz+ihA=;
        b=VLn0JNEGRwi6K/0KGkoQnsC9JoJLBtaHbrkiJHoPR0EwIyA0sijPkvZqi93NDuf2PdvzXY
        30hO+OjuXj/Y/KnVczbs6mL8kAcqqJd0MLe1cGZZWfxFkpwQ1DRAEBAenGf3EXWvJ6nRul
        UAfQ/XPgfj1xRV7+Sv5G6Ybnjo6VHCo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-cLBlcGmxM5u1toRevJ-nSg-1; Thu, 28 Sep 2023 08:41:22 -0400
X-MC-Unique: cLBlcGmxM5u1toRevJ-nSg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae0601d689so1087222666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904880; x=1696509680;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEs40AJ4lM3j9ffIIAlvF9xgj3FRAy6IbL4eThz+ihA=;
        b=dPUyXaiER2Hfhvz40wtWp//+rIcV4bl3V0Y9z0DzcOELmDD5oK4aijp0z9hUSqGZr0
         5tx4E3xxX3uQKBaCdMj1McMGlT9tFNmLRQbFLMpEzV6fmgz4Ad0/N/IXuxxSa7iJKfQh
         aFgL9Ny+6YUYckfdSIev6x5fSARE4LH3T5v7hhUhCraWJ+ldNfOqq7FuYkwIJOwjq744
         ae24wHX7ZkeTBMa/e827pa1XVSXXDHX0Ffg5sA39tThnyEH68bVDQkFtYY036mMXRwiS
         zs3cI32iuhGEjHt77uhl0ONwm2n+TmmYvTT72/M23/lucU07oN2WF2f0hS93QJGon0mL
         XAdA==
X-Gm-Message-State: AOJu0Yw/BSiI/b6nZYM0HQ8xyc0tlAgJ29nQFhWx6FeJObiUS8tXQvy2
        TN1grmgOX/ECcgQYozGnzqIrQxwa5igXiwfyHUeh7vUgHmgn8VP3o3jwizrGzdQX6E3N54JdNzG
        KgQu4jhkGD46FbMmz6WJx+A1r
X-Received: by 2002:a17:907:2e19:b0:9ae:1de:f4fb with SMTP id ig25-20020a1709072e1900b009ae01def4fbmr1021199ejc.46.1695904880750;
        Thu, 28 Sep 2023 05:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQrMMPDdnzZMDPC6CzY2Wn/lmJ+Y++1/fNcc2MkMjcM125ZfydcGSvD4w4OtcykeO+6t+gXA==
X-Received: by 2002:a17:907:2e19:b0:9ae:1de:f4fb with SMTP id ig25-20020a1709072e1900b009ae01def4fbmr1021183ejc.46.1695904880436;
        Thu, 28 Sep 2023 05:41:20 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm10937525ejb.144.2023.09.28.05.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:41:19 -0700 (PDT)
Message-ID: <a783ec82-79da-6235-0af8-505d252c59ff@redhat.com>
Date:   Thu, 28 Sep 2023 14:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 1/5] platform/x86: int3472: Add new
 skl_int3472_fill_gpiod_lookup() helper
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
In-Reply-To: <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new skl_int3472_fill_gpiod_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index e33c2d75975c..351ecf047944 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -52,21 +52,15 @@ static void skl_int3472_log_sensor_module_name(struct int3472_discrete_device *i
 	}
 }
 
-static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
-					  struct acpi_resource_gpio *agpio,
-					  const char *func, u32 polarity)
+static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
+					 struct acpi_resource_gpio *agpio,
+					 const char *func, u32 polarity)
 {
 	char *path = agpio->resource_source.string_ptr;
-	struct gpiod_lookup *table_entry;
 	struct acpi_device *adev;
 	acpi_handle handle;
 	acpi_status status;
 
-	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
-		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
-		return -EINVAL;
-	}
-
 	status = acpi_get_handle(NULL, path, &handle);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
@@ -75,13 +69,31 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	if (!adev)
 		return -ENODEV;
 
-	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
 	table_entry->key = acpi_dev_name(adev);
 	table_entry->chip_hwnum = agpio->pin_table[0];
 	table_entry->con_id = func;
 	table_entry->idx = 0;
 	table_entry->flags = polarity;
 
+	return 0;
+}
+
+static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
+					  struct acpi_resource_gpio *agpio,
+					  const char *func, u32 polarity)
+{
+	int ret;
+
+	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
+		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
+		return -EINVAL;
+	}
+
+	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
+					    agpio, func, polarity);
+	if (ret)
+		return ret;
+
 	int3472->n_sensor_gpios++;
 
 	return 0;
-- 
2.41.0

