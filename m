Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678EB759AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGSQfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGSQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:34:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7393B19B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:53 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9e93a538dso40656435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689784493; x=1690389293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKYrsbwFkQq7mxSa9jMwKApOtesu39YvxU4CShJxAhI=;
        b=ZvLnrY1568MZhaU/qXPqlRY4i0xnbvv+JpUWdEukxuSZl/js2HLyiHv64/36av5u3L
         kUf3LGIWVHKuEZeht318sYiL3rd50EHbqXS0SXHIx8tUVeo1gBBrSfKjl0evGs6RA3Ph
         g15fyNoVbYvClluNk5HufnB5tU27SwjMx5sRXAV13WPnOgbqZokaYWmyXm001+hU3wzZ
         pjyGKQGGSPgDbmCq74EU+FgzpiZ9qp8PbTz5jkNX35QqD0fTRTcLxPkTgUTIUr7UjxPB
         WIr+kn52YPa2S/ZaOznqmSXXYvLlDmov1AW9dqDgYj+1cv1QQdhKmZolsnN5t/wTas0R
         BFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784493; x=1690389293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKYrsbwFkQq7mxSa9jMwKApOtesu39YvxU4CShJxAhI=;
        b=H9lhJTOdLY+WgBvXR+pNP3r6kgsFXywKDZM8sztRNhpxcpp8JNoMEYweOjV+wiBt6a
         PZocsGAHLDqlP8zidMbi6vIgvOC/WHq7q9n+SB9mVrfLdVnj7bF1fCbG1DGXvDUIrMOc
         yc9DDueRCKzji9BioizBBEBSAt/UYaEUkw/X0j1yllTO+ozqJauQDoTxezHl+c6CmzcJ
         EJo3X9Dph/2WGFUOBL92rYS5m29wO1yJKhDJ2l8HRvBtNRGghdUt7G693JeGKnig8R3y
         +dloS2PKX9SZryC2IWzuo0FPxDWa4+wPaVlGnICPDRbFODt1xgaubYjbUVw6ANvc3msp
         I8GA==
X-Gm-Message-State: ABy/qLZhfGzqxBxckEu2KQlpeDkLq6oE+le2VrHAwCueSPKUyPjq2cym
        +qL+iP6eaRWqK780UXFJWi5tcQ==
X-Google-Smtp-Source: APBJJlFipcbSu/NojN35HkrEsviKbFWtcYcx3WLvCCXo8NC5ZDt1xR4dBGQY2EMiUvSm/R5cz/pIvg==
X-Received: by 2002:a17:903:48c:b0:1b8:7483:d47a with SMTP id jj12-20020a170903048c00b001b87483d47amr15035853plb.37.1689784492938;
        Wed, 19 Jul 2023 09:34:52 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b001b0358848b0sm4199276pll.161.2023.07.19.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:34:52 -0700 (PDT)
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
Subject: [PATCH v2 3/4] gpio: sifive: Get the parent IRQ's domain from its irq_data
Date:   Wed, 19 Jul 2023 09:34:44 -0700
Message-Id: <20230719163446.1398961-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719163446.1398961-1-samuel.holland@sifive.com>
References: <20230719163446.1398961-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not parse the devicetree again when the data is already available
from the IRQ subsystem. This follows the example of the ThunderX and
X-Gene GPIO drivers. The ngpio check is needed to avoid a possible
out-of-bounds read.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 drivers/gpio/gpio-sifive.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 6606c919d957..46a42109d6f5 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -6,7 +6,6 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/of_irq.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -180,9 +179,6 @@ static const struct regmap_config sifive_gpio_regmap_config = {
 static int sifive_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *irq_parent;
-	struct irq_domain *parent;
 	struct gpio_irq_chip *girq;
 	struct sifive_gpio *chip;
 	int ret, ngpio;
@@ -202,24 +198,16 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-	irq_parent = of_irq_find_parent(node);
-	if (!irq_parent) {
-		dev_err(dev, "no IRQ parent node\n");
-		return -ENODEV;
-	}
-	parent = irq_find_host(irq_parent);
-	of_node_put(irq_parent);
-	if (!parent) {
-		dev_err(dev, "no IRQ parent domain\n");
-		return -ENODEV;
-	}
-
 	for (ngpio = 0; ngpio < SIFIVE_GPIO_MAX; ngpio++) {
 		ret = platform_get_irq_optional(pdev, ngpio);
 		if (ret < 0)
 			break;
 		chip->irq_number[ngpio] = ret;
 	}
+	if (!ngpio) {
+		dev_err(dev, "no IRQ found\n");
+		return -ENODEV;
+	}
 
 	ret = bgpio_init(&chip->gc, dev, 4,
 			 chip->base + SIFIVE_GPIO_INPUT_VAL,
@@ -248,7 +236,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	girq = &chip->gc.irq;
 	gpio_irq_chip_set_chip(girq, &sifive_gpio_irqchip);
 	girq->fwnode = dev->fwnode;
-	girq->parent_domain = parent;
+	girq->parent_domain = irq_get_irq_data(chip->irq_number[0])->domain;
 	girq->child_to_parent_hwirq = sifive_gpio_child_to_parent_hwirq;
 	girq->handler = handle_bad_irq;
 	girq->default_type = IRQ_TYPE_NONE;
-- 
2.40.1

