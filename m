Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850B760424
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjGYAkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGYAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:40:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CCA1728
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8ad356f03so25294885ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690245647; x=1690850447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whF81jM7MxzV+FT+tijidotVjimKPtD8G7YJMe5VYT8=;
        b=Y7GUiu94wEBaKDhmb78iePTU5on4Y8af9I2D4KfrJx0c0JhIJBSRxWayKzgqvjmnOS
         5LPHTZAppCbaxsEmtyQSbWzbp6i6vAQT6d8PZRKl4zoDuWsyYwMj5k+/WmvN3iFDIVD5
         ENo/xB84IHvM25lxI+DrkCISNIo9ZvSYFA0IfdPDwfFM2/NhkRZMKBMJEM6gTRN2BAqf
         8NRSfFyztf8TfsLhhRk2xs8RCtcNKPbbbrffPegyGnI+gmeNU5YkRTIHxdJrCueNvQan
         K6CXnrRwZfIkIYH9fNB2g0kIXYiXyWjXB8Ha3zgWiqOQG+kb9u9YsM49vOs1+EAH60ab
         wNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690245647; x=1690850447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whF81jM7MxzV+FT+tijidotVjimKPtD8G7YJMe5VYT8=;
        b=K+44Rl7zzjnXvv++Q0kxORATot1ui8wdTwkeFSdt5VD4gNT4hzWTIBaszGukzeQSfb
         Fz6jUUFeYjEJfh2SEF11UtZMd2rtbj9c3gEM3W73fvtdtasn+FnzN2Br4si2t1nNBXjU
         9wSJWeAfl/bb5W3tfbxy8QA1jzabzUugCvEdCQ42x0+333X0krhfYzC88EY6Pyiwx5Mv
         Z90BlRFHyKgO/2AAhxoaVC/t+zqiuO+MO2SkLO2vFvODASbrvtLu71xRSFvSx+Un2p7M
         WamPZq3dCxh+7ZDr3/1kcOmfEGAiBSlPvk7bh3sRLpJQuPFLH/ps8kiDuIUKGjKrCkN5
         HbjQ==
X-Gm-Message-State: ABy/qLZ/RKyYM97alI2Xl1TF0nObuSqRCBHOa4pAEUv9UEyWnFAeC2tN
        60+3S3U72G6EfW1CT79NO7Iaww==
X-Google-Smtp-Source: APBJJlGtHTO7CDSyW8ZxxmrwBceXzI8CW1XujT4EsoRt4RpIH7jo6YBL5pbDPxWysOIgsa2tw7yuCw==
X-Received: by 2002:a17:903:41cc:b0:1b8:9044:9ede with SMTP id u12-20020a17090341cc00b001b890449edemr10398291ple.62.1690245647479;
        Mon, 24 Jul 2023 17:40:47 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id be11-20020a170902aa0b00b001b8a3e2c241sm9528297plb.14.2023.07.24.17.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:40:47 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/4] gpio: sifive: Directly use the device's fwnode
Date:   Mon, 24 Jul 2023 17:40:39 -0700
Message-Id: <20230725004043.381573-2-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725004043.381573-1-samuel.holland@sifive.com>
References: <20230725004043.381573-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to convert dev->of_node back to a fwnode_handle.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Use dev_fwnode() instead of member access

Changes in v2:
 - New patch for v2

 drivers/gpio/gpio-sifive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 745e5f67254e..db480cd7271a 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/regmap.h>
@@ -254,7 +255,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	chip->gc.owner = THIS_MODULE;
 	girq = &chip->gc.irq;
 	gpio_irq_chip_set_chip(girq, &sifive_gpio_irqchip);
-	girq->fwnode = of_node_to_fwnode(node);
+	girq->fwnode = dev_fwnode(dev);
 	girq->parent_domain = parent;
 	girq->child_to_parent_hwirq = sifive_gpio_child_to_parent_hwirq;
 	girq->handler = handle_bad_irq;
-- 
2.40.1

