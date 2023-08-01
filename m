Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D076BD62
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjHATKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHATKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:10:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E397F1BF5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:10:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so53851371fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690917006; x=1691521806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmKT/3Oo08LVt2NMcE4zYHICX9fi+Y9rB10UuqFHh6o=;
        b=3XmUC0Q8brIbSP5QuPUb5aCeMXEYVuPPHRsqiVwfMw7t0L0vSOAtXNu/IpKQWrgZcp
         XdAZIrwx251SEbk2Gs228dtggMwI2b6Wbqlga3hBpQZ690/YjN+nLvCFQ91Ji/6NjAMM
         GkOAguMx8smqBM5ca1oGT3YvIzfTuE20vpU/PECgVBNFDcrV+Xkky0iaZgh6T8jvftqi
         yM2Vt1bZ1ZjKwoU9OUQ6SRU40tU9D4ORF+kuHQGJrv2fv/sxcaFeuMKqRFL6sTdDVKZC
         EoBerXZWbyZ8GOiLWCmLEycttWfScXxFqyAHEj9E/R1JvZYa8XjwWCXRZemEoHoC+esM
         IPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917006; x=1691521806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmKT/3Oo08LVt2NMcE4zYHICX9fi+Y9rB10UuqFHh6o=;
        b=EPXnX71xmhluPF73SCuvHsTTfTaP+0prL8BPHm7b++biPXMNSuIdtZtE0mkI3u3deK
         qfYjlMfC7VIJbDoDKxVP27zXiyo92ekEoMh9WJ1J5OfB5oljVD0OUjN10WgcqzM3iKB8
         /OZSdj3WqfNQMi+ROCpV4wT4oaNbXPgYut3zXD4OrUOcWys3bA6MJZr9eh9PWK2f95lE
         tBl4Fj/4u0Bl3ARl1JtaH8NdHRWv1BVsX4uF9cUyKDnP3g+VCBLvMIbzbsb9jNpvLj2L
         szYoTVEDmbxj+xDGHnZvFklo9aQXU4eV6zFIx1mrmL7JspzWDwAFXHVTy8qmxflezgQA
         9AqQ==
X-Gm-Message-State: ABy/qLYXEJcvPtV6nwO/Kd9WZa281Jk2v8Kyx5hNGBXya4X1VyG8WGcj
        f+j9trYP+JN9JYhMYNTrfzUlRg==
X-Google-Smtp-Source: APBJJlFqFMHkbgbmCMnEeP4fKpt0dYgMXseu9Xgaa++cHob1JnYsrGPuHwa9soFKdMCcSi/iBBxPcg==
X-Received: by 2002:a2e:9903:0:b0:2b9:b904:74d7 with SMTP id v3-20020a2e9903000000b002b9b90474d7mr3219510lji.18.1690917006011;
        Tue, 01 Aug 2023 12:10:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f283:106b:b69e:b5a])
        by smtp.gmail.com with ESMTPSA id l27-20020a05600c1d1b00b003fe1b3e0852sm5075713wms.0.2023.08.01.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 12:10:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: sim: mark the GPIO chip as a one that can sleep
Date:   Tue,  1 Aug 2023 21:09:51 +0200
Message-Id: <20230801190951.51818-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Simulated chips use a mutex for synchronization in driver callbacks so
they must not be called from interrupt context. Set the can_sleep field
of the GPIO chip to true to force users to only use threaded irqs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index cfbdade841e8..5f8723ad0048 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -429,6 +429,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	gc->set_config = gpio_sim_set_config;
 	gc->to_irq = gpio_sim_to_irq;
 	gc->free = gpio_sim_free;
+	gc->can_sleep = true;
 
 	ret = devm_gpiochip_add_data(dev, gc, chip);
 	if (ret)
-- 
2.39.2

