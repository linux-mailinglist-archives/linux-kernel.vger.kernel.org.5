Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F707B1CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjI1Mpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjI1Mpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41BA191
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695905103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZJst60DtOTAcHM/+YWWARhoXyKu+0XsCA0kzc+cFAY=;
        b=La8hgH+wm8PNysOZie+g+sSzH/3WkhUSQd7cvjUdVBDyy/3hhMx4ib7bP2tALPh0U3B6bN
        fDJDNMbiyDSS4fMZ+RIOtnTIGOmFknmkzmNCLL7e3y8nUExm0aWXy8eqI+fDRrJVoLQDjF
        Sq4uHyl/YyjgBoyf9NNzGNjNOu+Ww3E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-8-3pv7yzPmyhiVK7Qqxhmg-1; Thu, 28 Sep 2023 08:45:01 -0400
X-MC-Unique: 8-3pv7yzPmyhiVK7Qqxhmg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993d7ca4607so1104811866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905100; x=1696509900;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZJst60DtOTAcHM/+YWWARhoXyKu+0XsCA0kzc+cFAY=;
        b=pyvXCTkjve2/0IH7zWepbYQFMWZ52aqSdv9s9R/7m+TUVdVs7lqpqiPgRVYIEN8ZDK
         CCP9D5zgawAsyxdOcBDdXTOJnDY38qGCx5Xc3MCwxi7GaV1TeP+Jtz785HEvJqwXbVk0
         zQBvi3/aNdYZiphVvnlkvlruvM+sW+zfUNjbuHEcV16FwFXxJlJUD/9bCbUMAiJiCN99
         Ma96cTxSXzH3hvYBPYbbnoFUSdaixxNO1kld7MUvpW0TiGCE2Ck05KBLxR9NKDpkKD8c
         UyiSz3FwHlmx4LipUSkttjMGm/2vlQ8LS7faE5f1Xah/QKdeMDE2Q+zikQAs1Dn/iCho
         K6mw==
X-Gm-Message-State: AOJu0Yw9YdXE8qFveXMAGRoxabjXwC5wXTvzi4+U7INFt299iuvrlgtt
        C79DPdMiLUi5R/rVpcBp8iqGXIKaLPOvAhQojHs/W+Kz8jlKGY/c37zKBQXhZx/lkOmAHXT5eka
        nzGj3UgS53OtbVK4um4IWPwEZ
X-Received: by 2002:a17:906:cc53:b0:9b2:8df4:c692 with SMTP id mm19-20020a170906cc5300b009b28df4c692mr1366418ejb.27.1695905100591;
        Thu, 28 Sep 2023 05:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBWHwp7nkBmFn/W7pmHIIzcfB55rotTWDT0eMe3PWuqOnoH9kN78RUdFR8Q28Hzep+vmDFMw==
X-Received: by 2002:a17:906:cc53:b0:9b2:8df4:c692 with SMTP id mm19-20020a170906cc5300b009b28df4c692mr1366399ejb.27.1695905100238;
        Thu, 28 Sep 2023 05:45:00 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm10849655ejc.153.2023.09.28.05.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:44:59 -0700 (PDT)
Message-ID: <d65e65c1-3a20-6aef-f25a-a261420e8a3d@redhat.com>
Date:   Thu, 28 Sep 2023 14:44:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 4/5] platform/x86: int3472: Switch to devm_get_gpiod()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to devm_get_gpiod() for discrete GPIOs for clks / regulators / LEDs
and let devm do the cleanup for us.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../x86/intel/int3472/clk_and_regulator.c     | 23 ++++---------------
 drivers/platform/x86/intel/int3472/discrete.c |  2 +-
 drivers/platform/x86/intel/int3472/led.c      |  7 +-----
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 459f96c04ca1..16e36ac0a7b4 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -177,10 +177,8 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 
 	init.name = kasprintf(GFP_KERNEL, "%s-clk",
 			      acpi_dev_name(int3472->adev));
-	if (!init.name) {
-		ret = -ENOMEM;
-		goto out_put_gpio;
-	}
+	if (!init.name)
+		return -ENOMEM;
 
 	int3472->clock.frequency = skl_int3472_get_clk_frequency(int3472);
 
@@ -206,8 +204,6 @@ int skl_int3472_register_gpio_clock(struct int3472_discrete_device *int3472,
 	clk_unregister(int3472->clock.clk);
 out_free_init_name:
 	kfree(init.name);
-out_put_gpio:
-	gpiod_put(int3472->clock.ena_gpio);
 
 	return ret;
 }
@@ -219,7 +215,6 @@ void skl_int3472_unregister_clock(struct int3472_discrete_device *int3472)
 
 	clkdev_drop(int3472->clock.cl);
 	clk_unregister(int3472->clock.clk);
-	gpiod_put(int3472->clock.ena_gpio);
 }
 
 /*
@@ -266,7 +261,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	struct regulator_config cfg = { };
 	const char *second_sensor = NULL;
 	const struct dmi_system_id *id;
-	int i, j, ret;
+	int i, j;
 
 	id = dmi_first_match(skl_int3472_regulator_second_sensor);
 	if (id)
@@ -309,21 +304,11 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	int3472->regulator.rdev = regulator_register(int3472->dev,
 						     &int3472->regulator.rdesc,
 						     &cfg);
-	if (IS_ERR(int3472->regulator.rdev)) {
-		ret = PTR_ERR(int3472->regulator.rdev);
-		goto err_free_gpio;
-	}
 
-	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->regulator.gpio);
-
-	return ret;
+	return PTR_ERR_OR_ZERO(int3472->regulator.rdev);
 }
 
 void skl_int3472_unregister_regulator(struct int3472_discrete_device *int3472)
 {
 	regulator_unregister(int3472->regulator.rdev);
-	gpiod_put(int3472->regulator.gpio);
 }
diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index eb0cded5b92a..8171b16882b7 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -119,7 +119,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
 		return ERR_PTR(ret);
 
 	gpiod_add_lookup_table(lookup);
-	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	desc = devm_gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
 	gpiod_remove_lookup_table(lookup);
 
 	return desc;
diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/x86/intel/int3472/led.c
index 476cd637fc51..9cbed694e2ca 100644
--- a/drivers/platform/x86/intel/int3472/led.c
+++ b/drivers/platform/x86/intel/int3472/led.c
@@ -39,7 +39,7 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 
 	ret = led_classdev_register(int3472->dev, &int3472->pled.classdev);
 	if (ret)
-		goto err_free_gpio;
+		return ret;
 
 	int3472->pled.lookup.provider = int3472->pled.name;
 	int3472->pled.lookup.dev_id = int3472->sensor_name;
@@ -47,10 +47,6 @@ int skl_int3472_register_pled(struct int3472_discrete_device *int3472, struct gp
 	led_add_lookup(&int3472->pled.lookup);
 
 	return 0;
-
-err_free_gpio:
-	gpiod_put(int3472->pled.gpio);
-	return ret;
 }
 
 void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
@@ -60,5 +56,4 @@ void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472)
 
 	led_remove_lookup(&int3472->pled.lookup);
 	led_classdev_unregister(&int3472->pled.classdev);
-	gpiod_put(int3472->pled.gpio);
 }
-- 
2.41.0

