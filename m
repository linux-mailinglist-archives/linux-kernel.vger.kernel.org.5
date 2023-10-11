Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3077C52F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjJKMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbjJKMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFCA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406609df1a6so64977665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697026146; x=1697630946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV89mjd+2xCaNvtlIxB557w1lQgJK6QeusQPNsiKVbM=;
        b=f+1ftpCKWvEGw1eQXYxvhgTinG5HkrUIqR1HBU+8kWHis2oaAlW55v6UPb6gtEPiSK
         BbPthDU2OIxReIfNljmajPCoXlyVv/L2eElJJtBBSaWoX2WCwcaxnL674Cy+wBYr4tsY
         herbUAtV97ByFoMzJjD5EkkXJaNZSrwNtwMJpWoqmKMpLUHUHnwPt++bzBfQSvvUN88y
         ZHP7PJhKMXqUxBI8kmje08CUrPh3uEaPoL1Qab98ZUEt8P8gChirscRfeZStSse/89RP
         qDjYaMjybBwf6DEBL4EaG/MZkrNILj18UV3Dllw3BU2Nb4/ZgnmZcknCQdmpv3A1vXxK
         EOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026146; x=1697630946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV89mjd+2xCaNvtlIxB557w1lQgJK6QeusQPNsiKVbM=;
        b=AIbonoEZTnLOZEUEh5u2XY4kb8NQbFZhoL/bRZmCl/d5pGpVXQrb8Y76iW9LPkWU0j
         /N9TD8Xqrk4QKucT5nxHuFXaWCRiB43krz/uPNaKPy9zO2xXmkRFSZoYMXDQkTzl+hs6
         mTUY8EOMhlkL9OWLlWsn0slVX37RunZ31+KtMggVrlYwwPrDwYdYCQtsIdpOy85botYv
         aR3+VYuijgmwGf8aenLkeP6yCBaf66MP1zaeEW0grxxibUe8AnO5UKCidnSgsgK099DW
         sqEiiLrhuJ6qtks1+EizSRdzBH5mDESvLCo0GNC8aEpZ5+PnPJK6jnAMKMsUkxNYehZ3
         iYKw==
X-Gm-Message-State: AOJu0YzYn4IzCN4r+nP9n7zSqpvcUGi1so4dmjRP0NPBI069oj2tDDgO
        3KB5LrKvCfcrXbyoOlFF2W0e1X35V7gq3kbZb8U=
X-Google-Smtp-Source: AGHT+IHQE+KY+f3/Lkd1mCf3FW8G05LBSM3hjSTxs8brJpped3ZXC1ExcdkjwHWVKyKG5dpDSYM9wA==
X-Received: by 2002:a1c:4b1a:0:b0:403:cc79:44f3 with SMTP id y26-20020a1c4b1a000000b00403cc7944f3mr17642504wma.19.1697026145681;
        Wed, 11 Oct 2023 05:09:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e551:3946:26fc:f94])
        by smtp.gmail.com with ESMTPSA id w21-20020a05600c015500b0040652e8ca13sm19012253wmm.43.2023.10.11.05.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 01/62] pinctrl: remove unneeded extern specifiers from consumer.h
Date:   Wed, 11 Oct 2023 14:07:29 +0200
Message-Id: <20231011120830.49324-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011120830.49324-1-brgl@bgdev.pl>
References: <20231011120830.49324-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The 'extern' specifiers are not needed for function declarations. Remove
all of them from the pinctrl/consumer.h header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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

