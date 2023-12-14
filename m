Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E051E812C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443493AbjLNJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443498AbjLNJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:58:50 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DC112;
        Thu, 14 Dec 2023 01:58:55 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5e2cfece112so15108177b3.2;
        Thu, 14 Dec 2023 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702547935; x=1703152735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOksdqNs08pbi9TocVeWukoOqtj/lhUt0q7v2+r1tcg=;
        b=IvwKkqDFvQ79fSJcSUACq+Zzt8AZ7u804/Fl/HbTtt/3P/tJ01Sm6VazoSnAwfGvJv
         5iwZjTQOi8lVjlmwfPTFDHSjG6T/d6/pbhYeMKwVWF8nciE0d26ge+INz5Nl/RZ0gHQI
         0UKNwdSXw8JPUOB7otdkVXB2k0/TpUEYl2JJktWE+aM2RGVMw07G+fnHIBa0uEW/nOmN
         6OHRDMbyk/qBOsan6fMm5mtzuWsH9WA13MJLgQkjyPcKLjrhshSXc8S7/A9Zr6ZMaqxy
         7FPjos/WP6/aHNNSPhvDCiED6QLEhyzRh6Txdw7C3zdA22THfx/6YSe3m0xXeG3N8syW
         40hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547935; x=1703152735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOksdqNs08pbi9TocVeWukoOqtj/lhUt0q7v2+r1tcg=;
        b=fpD0v/GHmhoVanaMRvNFksR1RA38k0/+mYvul7hXro2J/6UjbudcWrTuTA+p16Sekr
         RH++wypEkZpvrfzF5GG+Yo+Rs+IOlbLIuUUXX8NGT2nB1IHbfPwPeGqoVNWspNwGyX54
         k68jiLJMFKhOv7C/gqTAb2ovZqKEEvsFpt16nwdF9ZhL0lsRe9+ByZkloRcQix4V7aWB
         LJyn2eBtKgljAxvdeMsiNW37Vhs67OMrhVdqobp1UTKise3aOa/C9ofymgc7MmlkTDEo
         dZ4q79iCoXh+3PAAp2TZgGfS0x8QtcawBeKCAEaOUyXyBNhjeNVWr+RtAvavGYSoqzIV
         z7Zg==
X-Gm-Message-State: AOJu0Yw+rZSuCuRnUt0hDV6otVn9q2tCYyea66wfCZBnugPg+A3UqcUw
        sXtSk8janvYlO16rzSnHs9Zxtd43U78=
X-Google-Smtp-Source: AGHT+IE4O7DjJhqUVlsakmDVEsoUcqbLt+ADyUOQJRGKR3JVlLeYk1aXb9JApzurKr8NS/499GQegw==
X-Received: by 2002:a81:6042:0:b0:5d8:e5e8:b775 with SMTP id u63-20020a816042000000b005d8e5e8b775mr7562773ywb.15.1702547934961;
        Thu, 14 Dec 2023 01:58:54 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709028bc200b001bc6e6069a6sm922807plo.122.2023.12.14.01.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:58:54 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 3/5] gpiolib: remove debounce_period_us from struct gpio_desc
Date:   Thu, 14 Dec 2023 17:58:12 +0800
Message-Id: <20231214095814.132400-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214095814.132400-1-warthog618@gmail.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdev is the only user of the debounce_period_us field in
struct gpio_desc, and it no longer uses it, so remove it.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib.c | 3 ---
 drivers/gpio/gpiolib.h | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 95d2a7b2ea3e..b1e81a561141 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2330,9 +2330,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 #ifdef CONFIG_OF_DYNAMIC
 		desc->hog = NULL;
-#endif
-#ifdef CONFIG_GPIO_CDEV
-		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif
 		ret = true;
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3ccacf3c1288..a4a2520b5f31 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -147,7 +147,6 @@ void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
  * @label:		Name of the consumer
  * @name:		Line name
  * @hog:		Pointer to the device node that hogs this line (if any)
- * @debounce_period_us:	Debounce period in microseconds
  *
  * These are obtained using gpiod_get() and are preferable to the old
  * integer-based handles.
@@ -185,10 +184,6 @@ struct gpio_desc {
 #ifdef CONFIG_OF_DYNAMIC
 	struct device_node	*hog;
 #endif
-#ifdef CONFIG_GPIO_CDEV
-	/* debounce period in microseconds */
-	unsigned int		debounce_period_us;
-#endif
 };
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
-- 
2.39.2

