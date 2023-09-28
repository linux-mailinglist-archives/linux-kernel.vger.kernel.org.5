Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDB7B1CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjI1Mnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjI1Mnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10846199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695904976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIgaek/2vaj0JutvpQK/iD5J0G41ovSmgWF0taiXJOo=;
        b=ABnrU8gadb0LF5VFST68oT/RuNSM96XzrjGVavQwZAwyQuqyisMkamQbdSAvdoOBnQDdGT
        97ChURdTQth5gbFu1W+zRLEXaGT52yVPaaT7DUZ4ipXvO+yUCLGIvZQOoFXyQ8fG+ASPuT
        u8NRBfMCVaNEP9bZqomYqCFSxiK+6XI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Zxjyr6-RO4aPOY1GhBmHqw-1; Thu, 28 Sep 2023 08:42:54 -0400
X-MC-Unique: Zxjyr6-RO4aPOY1GhBmHqw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9f282713fso1074085066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695904973; x=1696509773;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIgaek/2vaj0JutvpQK/iD5J0G41ovSmgWF0taiXJOo=;
        b=gKUtgRse33qKzFGT5xSDByXGib9yCy2t5Bd52RrEIaGxLDblxM+MPym0rC15YjSa/M
         N4arZ8bn3xAWGZXoHsRKfX4ysgVZHsrN9iaQLz8mkTk6i7mpW1y0sV5ACfGYTu0E52SC
         nRfFKX++CXXqxfZG9y4cHXU20/wrkotXyxN1L9DYO1ob5It0/V1cXzo7ZFBgGxT0JeyK
         Vf74AOrcvp26xo21zkkX92fPlaoeGewTRPhnrO4Sme62s3qfQUMdqRLDvtBrgsf/ECzn
         IqUo5ZkMgVTfHxpsLmW1T6fE8DNwRb/2cGh8nQf8uQkgD59mbP+gXVYrJgrqNix1PfCc
         v/MA==
X-Gm-Message-State: AOJu0Ywy3bTJ9kUfkovkPkn8vhUuTGeLCWzrsBLEa/95+r8iBVEAqwGy
        5nJmkRTemC4RHKZGamOvz65NzTPc1eBHfyrU2M1BPQGNCKhVNW5SIURrQoRBkUCY1X8vgQBA0i/
        iFf0S+xOy2e9rfiCpQhBrvfCa
X-Received: by 2002:a17:906:209e:b0:9a5:874a:9745 with SMTP id 30-20020a170906209e00b009a5874a9745mr1015779ejq.26.1695904973509;
        Thu, 28 Sep 2023 05:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlywnIyNYShfOZQqUKF/nPnEpW/BE9ULWRGFQaKFsFKQmtPIGivvU6o7bT5pQ/APNJZdsd4A==
X-Received: by 2002:a17:906:209e:b0:9a5:874a:9745 with SMTP id 30-20020a170906209e00b009a5874a9745mr1015758ejq.26.1695904973121;
        Thu, 28 Sep 2023 05:42:53 -0700 (PDT)
Received: from [192.168.1.217] ([109.36.138.103])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00993a37aebc5sm10864511ejb.50.2023.09.28.05.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 05:42:52 -0700 (PDT)
Message-ID: <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
Date:   Thu, 28 Sep 2023 14:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: [PATCH v2 2/5] platform/x86: int3472: Add new
 skl_int3472_gpiod_get_from_temp_lookup() helper
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

Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 351ecf047944..a46c3a206aa3 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -99,6 +99,32 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	return 0;
 }
 
+/* This should *really* only be used when there's no other way... */
+static struct gpio_desc *
+skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
+				       struct acpi_resource_gpio *agpio,
+				       const char *func, u32 polarity)
+{
+	struct gpio_desc *desc;
+	int ret;
+
+	struct gpiod_lookup_table *lookup __free(kfree) =
+			kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup)
+		return ERR_PTR(-ENOMEM);
+
+	lookup->dev_id = dev_name(int3472->dev);
+	ret = skl_int3472_fill_gpiod_lookup(&lookup->table[0], agpio, func, polarity);
+	if (ret)
+		return ERR_PTR(ret);
+
+	gpiod_add_lookup_table(lookup);
+	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	gpiod_remove_lookup_table(lookup);
+
+	return desc;
+}
+
 static void int3472_get_func_and_polarity(u8 type, const char **func, u32 *polarity)
 {
 	switch (type) {
-- 
2.41.0

