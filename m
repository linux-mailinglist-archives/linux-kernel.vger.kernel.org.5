Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C97B6C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240193AbjJCOvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjJCOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:51:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333BEAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:51:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-406618d0991so9903735e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696344682; x=1696949482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyuhYPCwOLu0O2gzn4k4yrcKyM3Az3Y2GYcVhizJ7Sc=;
        b=QadaSl02uf8qvyaoJZ7OL5fB0k/E0gBR02Wo0GjtPEsH8nLsCm1Ci/zwfVf+oILIG+
         a6OHpB/WYOb/bdJA9/Rw7SBxE/nGGpmhfZacEFDy/PJWLx3BUK5QDRNJMQHWSNlyIZf2
         7ThH6PygPj64YD8NXejDZzwd08VeQ9hHvRrooD8LkYARWP81RapY5v5SToTnPZUAwYfI
         43Cb4TeOSiAFCbtOPv9O+9HkH/Pan9nLjviUeVq2jqObi6x463thIxkj3lHA2JTUIPwY
         3eALhQkNqJdEDQxOx0cxV6jhOCUNTTQOSs2kHQVFSS7crfBHA5rKzD1cQ75N6JhxuMJd
         PTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344682; x=1696949482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyuhYPCwOLu0O2gzn4k4yrcKyM3Az3Y2GYcVhizJ7Sc=;
        b=p+6t9CyaqcXLLcgz0Kr1dbO1tYAhnRq+tsVWEu8p17YE8N1PtqTU0Reve6eryLb7fJ
         44Hr0g9ZIfYA4XGU2gi2gtOUHbw5wcNr1mSR8Jr4TLV0zgszck0GHqN+d2R7zEtzX7NV
         Q0esAiOiabXU59ln0YmhZqKioouBvzXwv5SO9uBC3yx1YNpMxWVPQUV8j3IRDeQXMqXN
         z+6gpv2Gerb+Cr9ALUf5Oa2IGf7sAFCU+S4pbeAl6FPzs0b2ln86bSjFzKvL4xCsZIps
         1uGe9SCnQno2JXoUGj/dYIG8WNWsb4SoEFBWBds3X09jcsWufVtrzlfVUm37vCvPGQjt
         oSjQ==
X-Gm-Message-State: AOJu0YwnbcIO81D8VgsN5tuWERYtogEJAXJ2ApdaNNl9E6PH6bJLRXSm
        7a0R8NXaEcSxpgtz86TztZ7txeWmKvfMC8lbQlc=
X-Google-Smtp-Source: AGHT+IHrgEwIZbE90/GuAFcQmGzVT/ubFLAMqxTD3UneTpTMukRoF6ZQ6eTpwmOartiyncz7lMc4hA==
X-Received: by 2002:a1c:4c1a:0:b0:401:23fc:1f92 with SMTP id z26-20020a1c4c1a000000b0040123fc1f92mr13196023wmf.25.1696344682502;
        Tue, 03 Oct 2023 07:51:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:1f2d:3479:a5de:fa35])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003fe29f6b61bsm1462773wmr.46.2023.10.03.07.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:51:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 01/36] pinctrl: remove unneeded extern specifiers from consumer.h
Date:   Tue,  3 Oct 2023 16:50:39 +0200
Message-Id: <20231003145114.21637-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003145114.21637-1-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The 'extern' specifiers are not needed for function declarations. Remove
all of them from the pinctrl/consumer.h header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/pinctrl/consumer.h | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4729d54e8995..22eef0a513ce 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -25,27 +25,27 @@ struct pinctrl_state;
 #ifdef CONFIG_PINCTRL
 
 /* External interface to pin control */
-extern bool pinctrl_gpio_can_use_line(unsigned gpio);
-extern int pinctrl_gpio_request(unsigned gpio);
-extern void pinctrl_gpio_free(unsigned gpio);
-extern int pinctrl_gpio_direction_input(unsigned gpio);
-extern int pinctrl_gpio_direction_output(unsigned gpio);
-extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
+bool pinctrl_gpio_can_use_line(unsigned gpio);
+int pinctrl_gpio_request(unsigned gpio);
+void pinctrl_gpio_free(unsigned gpio);
+int pinctrl_gpio_direction_input(unsigned gpio);
+int pinctrl_gpio_direction_output(unsigned gpio);
+int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 
-extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
-extern void pinctrl_put(struct pinctrl *p);
-extern struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
-								const char *name);
-extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
+struct pinctrl * __must_check pinctrl_get(struct device *dev);
+void pinctrl_put(struct pinctrl *p);
+struct pinctrl_state * __must_check pinctrl_lookup_state(struct pinctrl *p,
+							 const char *name);
+int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
 
-extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
-extern void devm_pinctrl_put(struct pinctrl *p);
-extern int pinctrl_select_default_state(struct device *dev);
+struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
+void devm_pinctrl_put(struct pinctrl *p);
+int pinctrl_select_default_state(struct device *dev);
 
 #ifdef CONFIG_PM
-extern int pinctrl_pm_select_default_state(struct device *dev);
-extern int pinctrl_pm_select_sleep_state(struct device *dev);
-extern int pinctrl_pm_select_idle_state(struct device *dev);
+int pinctrl_pm_select_default_state(struct device *dev);
+int pinctrl_pm_select_sleep_state(struct device *dev);
+int pinctrl_pm_select_idle_state(struct device *dev);
 #else
 static inline int pinctrl_pm_select_default_state(struct device *dev)
 {
-- 
2.39.2

