Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC667805BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbjLEPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbjLEPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:54:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B861122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:54:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3333a3a599fso1817815f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 07:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701791673; x=1702396473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqo9Y6wByno136zo48BkFSxhAKPxHUv7Wp3L8ZrdTEM=;
        b=bAjpRaiVhmzYD7gkdz40m6XIt+2FQrzmq7tdZDufU9onna4t3YaRDLMk28JcGYMW01
         R47sadeZrz+YJ+84GCxIztkJqpJBeJdQJ1DfV1xAHug72Y4/gaRxPzzlk5bXhxciCjLT
         1kjB+hX7/3ng/5pSCxOxddVljomw/4XVc/Mvh/dNYZLYWPqPae0ArtBy2ROZF2Je4reM
         FC81xo304R15DuzU4/GD0fhUx4qZKClSUO/WoStrjkyO/iJpnRMe9aCPB+vo8clgrCy+
         U+H2T4GgKNcYIe/LNI2yIlxBJb8Dwy9lBPN+46HW7ywdKPwGgMm4r68sQK5ud2N/wgYa
         q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791673; x=1702396473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqo9Y6wByno136zo48BkFSxhAKPxHUv7Wp3L8ZrdTEM=;
        b=glQW0nDxNhT5nwBMebrAqpvFIph+MgOHBSFI4f/M76a7QdT0JCcIEu0KeW5bHCLLe9
         jVPeR5Nh0+8rhNpEXfIoJcw/RH/EWfw/1VUKalF9OlKDG2p8DT/+74uZbEt+UFR+RfYv
         rM7xCzJ8T2E7EinHEsSqu0vnP59GrqgTVVWUwb4VTbyejIdEKwltUgF/y2hVY0ASqkJ9
         4uzxzTvcw58EL3gOxHOrf9S990Ws2BLahlRVlPPi1hYGxz9mu//eUoEPnhThTVJVxcD5
         qzpGWwRAI7MNLbggy2TzMwoudL10GZmejSbTL1oQNSzeDvh1lPrjIzOELFncY6+uG/Kk
         wRHw==
X-Gm-Message-State: AOJu0Yzmctt3zMpk+A6YGT43NyRIQGBZAew1x/i4M52mil4HjAaGEP6T
        gKAkrQu0Mccrdr9ZHwei2ZjuVeJSc7RyQUVuong=
X-Google-Smtp-Source: AGHT+IECqsfgRq8K6R184xNf+VSY/KGmg5NZsm3ozjh8A6tYGdUwKPJiHKqBa8dbr4M88/Gm61uUug==
X-Received: by 2002:a05:600c:4a83:b0:40b:5e56:7b70 with SMTP id b3-20020a05600c4a8300b0040b5e567b70mr734511wmp.185.1701791673497;
        Tue, 05 Dec 2023 07:54:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2dd9:dce:96c5:9e9a])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b0040b4b2a15ebsm18948318wmq.28.2023.12.05.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:54:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: fix the email address in MODULE_AUTHOR()
Date:   Tue,  5 Dec 2023 16:54:30 +0100
Message-Id: <20231205155430.31761-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Fix unterminated angle brackets in the email address in MODULE_AUTHOR().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 1928209491e1..1e8b92e9df80 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -1546,6 +1546,6 @@ static void __exit gpio_sim_exit(void)
 }
 module_exit(gpio_sim_exit);
 
-MODULE_AUTHOR("Bartosz Golaszewski <brgl@bgdev.pl");
+MODULE_AUTHOR("Bartosz Golaszewski <brgl@bgdev.pl>");
 MODULE_DESCRIPTION("GPIO Simulator Module");
 MODULE_LICENSE("GPL");
-- 
2.40.1

