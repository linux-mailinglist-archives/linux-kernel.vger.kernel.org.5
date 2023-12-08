Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B080A07B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573487AbjLHKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573473AbjLHKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:20:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47952171F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:20:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332c46d5988so2004297f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702030826; x=1702635626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcBt1H06VnpfQ+udlk19+9Kb0QwElKrjTxgmIfyINVE=;
        b=EP/4/5PzeliOihBSme+38ywRnGlLD66AtuLseXgTuycU+ECUhwT+OU7b+wfjw6JAEd
         XJvfgXcFymhoMF377pSpRmjGSZLPDPBwqBZ8K40Hx+EB8vH1ZGN579M03/yLtiXqJ2q7
         1vs+86Z0TEDigQOYzWUXxl02ZN7nHxcU1fzzmfVv5+EniOLFMt7t93bdTzDOpHZV7ZK6
         HN0y9dNxR2oHi+oDcxShw/k4c4EdDJ2ZxJADcwdHtg/+1z84KbqMsif+MQOlJV4ta4Xe
         pR1m7HEDJmxu4i3O7h308iqL9Vrp2yrJYj72MoeLZ0AHq0PlugDwrCJlEtJmEh5S7P5t
         jyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030826; x=1702635626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcBt1H06VnpfQ+udlk19+9Kb0QwElKrjTxgmIfyINVE=;
        b=K/DpH4K0dJhHTvwVA51glVt3iVj1o3Gd8TGxb/tUpVgw5AIBimmiGxCxgw7afIthuP
         Jxi4CMNRtxn4YMLps+o+FpRMPDuVLsRwj0PTuouzjqoZlahlu8AeRD62Q6XUcSPSfZ6u
         y/q/fpxBL3sNOIwZze8fHbuzERqstgWDiPHy8VKvoAIyMPvtv5Yrbwcqa2CvVxwFZOmX
         n5iVlgkafczywXUBMH6x6Pm167/ZcMCYE4JeN02OsKViPhhvwooJGUVomeuoQw37tSv3
         oMupYBgGpGhhFIeye7DMDlwHql+5AYnMI04Swz4Yu2Up4Z8l1Gf/uyOijj5w/1q1ppOK
         QonQ==
X-Gm-Message-State: AOJu0YyO9MBd4pTzz5cztG7dR2Euq4QaYdgazxYjOBEMBjYDMoNwpUZj
        PxN0SpN7Jb33Tm+BYbixjTVr8A==
X-Google-Smtp-Source: AGHT+IEpU9lE4FCaeTWGdOHg5eeTKFEHWPUdBguqaSRXsB3xDodFBETQgvOVjS81LezAfe+3OSSyow==
X-Received: by 2002:adf:ed06:0:b0:333:380f:2d2d with SMTP id a6-20020adfed06000000b00333380f2d2dmr2777351wro.92.1702030826702;
        Fri, 08 Dec 2023 02:20:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b003334926fb81sm1678026wrs.90.2023.12.08.02.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:20:24 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] gpiolib: rename static functions that are called with the lock taken
Date:   Fri,  8 Dec 2023 11:20:19 +0100
Message-Id: <20231208102020.36390-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208102020.36390-1-brgl@bgdev.pl>
References: <20231208102020.36390-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Rename two functions that read or modify the global GPIO device list but
don't take the lock themselves (and need to be called with it already
acquired). Use the _unlocked() suffix which seems to be used quite
consistently across the kernel despite there also existing the _locked()
suffix for the same purpose.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4e190be75dc2..779f8b21bf05 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -290,7 +290,7 @@ struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
 EXPORT_SYMBOL_GPL(gpio_device_get_chip);
 
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
-static int gpiochip_find_base(int ngpio)
+static int gpiochip_find_base_unlocked(int ngpio)
 {
 	struct gpio_device *gdev;
 	int base = GPIO_DYNAMIC_BASE;
@@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_direction);
  * Return -EBUSY if the new chip overlaps with some other chip's integer
  * space.
  */
-static int gpiodev_add_to_list(struct gpio_device *gdev)
+static int gpiodev_add_to_list_unlocked(struct gpio_device *gdev)
 {
 	struct gpio_device *prev, *next;
 
@@ -907,7 +907,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	 */
 	base = gc->base;
 	if (base < 0) {
-		base = gpiochip_find_base(gc->ngpio);
+		base = gpiochip_find_base_unlocked(gc->ngpio);
 		if (base < 0) {
 			spin_unlock_irqrestore(&gpio_lock, flags);
 			ret = base;
@@ -927,7 +927,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	}
 	gdev->base = base;
 
-	ret = gpiodev_add_to_list(gdev);
+	ret = gpiodev_add_to_list_unlocked(gdev);
 	if (ret) {
 		spin_unlock_irqrestore(&gpio_lock, flags);
 		chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-- 
2.40.1

