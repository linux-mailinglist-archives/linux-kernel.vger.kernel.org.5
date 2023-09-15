Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2667A1ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjIOMei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjIOMef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:34:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160D8193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:34:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4018af103bcso14058485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694781268; x=1695386068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a84fzKCzx4Lh1OZKpKQr9OcyKJOlraxzLNN52YI1hEE=;
        b=pV69U8x2y2E7TrkvPybl1AbIGU/vZH6heaNEpfqXM+BfiARsDzWrs/C2B5PGm2nYcs
         sHdfxMHbUiy6d1ItM/+COrdcDRcOGPqn73ScHkczyr4VVVOEKFJIZbRzfJXEc8ODdpDw
         P8N5dBfa+tncnmTfahvfKTXr9n+++0T4CqbXNz1l/vnlbIB0oEaAQHbEgh0TgvvMBoaG
         TVpaQjqxU6vvTzMO2Tk/6fV4nnF3sd7s7wPfth5HL/9e8ffJrMjoHmqtLUzVaMOT0QMV
         /xnkDT8Pp/C2Q1OthX73zDiFGfw+Iww54cVaTDvQ4lcmeIokXT5jZVITxp5GKdWI29XO
         aHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694781268; x=1695386068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a84fzKCzx4Lh1OZKpKQr9OcyKJOlraxzLNN52YI1hEE=;
        b=jhbZ+ZuRd9hgRTGARc98PT2E5g1TfFMykBKwLElPLQaejiWv6bK1xvoZ4eUH+1dM3t
         GUAPJEh72zli87aY3zp4iZYe/5NNfPck2pxjZrvsY+Uz10E/wJqbTtA06uGJ7Qa96o3p
         XSSH76xsQT2Ckda1ri85ajc5DsGB+jAGXyi74SuKuKUbGG/w0hI4Fp1ZhBbTF/DNiJsQ
         DB5LdPqY/on4zIDLLlBjvBZgzQ2kjNAMTElJa1X02KjOZA4CkaI23ZvFjkTO+X7R2AHy
         YtauLYGU9qOxYZIPNKsH9eSqt4z1EbnM4dKSamOUtqcTGPWWfHqhfFo4P23yKFXw4ijA
         9/Wg==
X-Gm-Message-State: AOJu0YyVSCSJUghFUAWp7kCdNjRAggoqoCA9z2Zs7baVDu0o46wR15ZS
        J6+LRzNy1xcCxox1XGqw5B/E6A==
X-Google-Smtp-Source: AGHT+IHZpExjeLucadZx6gbnHX4mOvdY0Tl0Z1COO3eqQ76w2kvxj39S38pV2dQ0h8gGBO7/qj6cPQ==
X-Received: by 2002:a05:600c:2218:b0:402:ea5c:1845 with SMTP id z24-20020a05600c221800b00402ea5c1845mr1191529wml.5.1694781268300;
        Fri, 15 Sep 2023 05:34:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c204300b003fefaf299b6sm4553110wmg.38.2023.09.15.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:34:27 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpio: sim: include a missing header
Date:   Fri, 15 Sep 2023 14:34:23 +0200
Message-Id: <20230915123423.75948-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915123423.75948-1-brgl@bgdev.pl>
References: <20230915123423.75948-1-brgl@bgdev.pl>
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

We're using various ERR macros from linux/err.h but the include is
missing. Add it.

Fixes: cb8c474e79be ("gpio: sim: new testing module")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index b4e6d06d08a2..d9d7df7bd387 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/configfs.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
-- 
2.39.2

