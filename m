Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40515760427
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGYAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGYAkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:40:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9D4171E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8a462e0b0so27916375ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690245650; x=1690850450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ4si2ANa5XEPPWMZ9PO8V5jNsPRui14yTgaPNCpuo4=;
        b=l4ktA2eQh99fN+gk7I24zvtI+5PZYFbVckqw44nSX4ED6yEtC9WPgWj5ibE5ZKyUpd
         5outgAZ4AGtaHnx8CUSLGFBgija0550Es4ZHdCs8hEoL/irxd0ZRYV621oTzrCKiH4bE
         2fnRPF9IbVCTjwm4SE6r9zv3iF5VsUOk8IWaBpkPsg0DJw3t+Ge6qZT9QUpQg6FvUPUe
         reo2RCg7Ig3GbXwa2n6VYb536XSRo4s439LWR8PQECFlFqXZA7XQjQ07atUv8KNXIs0R
         E3u5LOjPl534zqDpW38rL4wtQgIYV0cqlwZUvUUzWK6R25wjiD0CvPYlIZ7eMADOKDqT
         XMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690245650; x=1690850450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ4si2ANa5XEPPWMZ9PO8V5jNsPRui14yTgaPNCpuo4=;
        b=HG8P+AM0fFlJtyfw41J71sITgzDXfXDMQClHJckbnal4Oscy9NA0OZNTAsxeeW/PJ8
         wibOzi0+CfxEhdocTRI4wDr0sHupi8tXRwFTGsx2VjC1IiFjn5cU2pBnvMWHcJ6ZlmBY
         IeGlyZgFuMni4Gc1wyqVWmw50/BiPv8khJLWtU8zoLKwPo4J6KoVYPBS5SnieI16Kg1Z
         /QXyniFCVF0hSD/GkdDRSeBOXDuv6XXMYGyzp3aBJ4B8+JOL9MN7bquC9OjpiXbdqdxO
         HPxlPpMvWb9J0br2JYRBVLR4BY4Hsl/aeEoho1wTioMy+N25gfQDoMGIRB4QV0MvGTaZ
         +sBQ==
X-Gm-Message-State: ABy/qLZL4D5XvdVI9ah0LlcF+hhBMmLye/bR8qfstuz1RuNE8jaCpEUo
        gkWhFOhToA/334PVS1ox8IAK3A==
X-Google-Smtp-Source: APBJJlF54q1B8nWOxzcZtLj8JrVNRf6Ffas/NcjytDBVLJF5ZOTC1n+Z+6A9MbTuRw17TV2FuLMY9Q==
X-Received: by 2002:a17:902:b083:b0:1b1:9d43:ad4c with SMTP id p3-20020a170902b08300b001b19d43ad4cmr8706634plr.40.1690245649916;
        Mon, 24 Jul 2023 17:40:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id be11-20020a170902aa0b00b001b8a3e2c241sm9528297plb.14.2023.07.24.17.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 17:40:49 -0700 (PDT)
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
Subject: [PATCH v3 3/4] gpio: sifive: Get the parent IRQ's domain from its irq_data
Date:   Mon, 24 Jul 2023 17:40:41 -0700
Message-Id: <20230725004043.381573-4-samuel.holland@sifive.com>
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

Do not parse the devicetree again when the data is already available
from the IRQ subsystem. This follows the example of the ThunderX and
X-Gene GPIO drivers. The ngpio check is needed to avoid a possible
out-of-bounds read.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - Keep the variable for the parent IRQ domain
 - Add a comment explaining why the IRQ data lookup will succeed

Changes in v2:
 - New patch for v2

 drivers/gpio/gpio-sifive.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index e96829ac731d..3545bc0fad13 100644
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
@@ -181,8 +180,6 @@ static const struct regmap_config sifive_gpio_regmap_config = {
 static int sifive_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *irq_parent;
 	struct irq_domain *parent;
 	struct gpio_irq_chip *girq;
 	struct sifive_gpio *chip;
@@ -203,24 +200,22 @@ static int sifive_gpio_probe(struct platform_device *pdev)
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
+
+	/*
+	 * The check above ensures at least one parent IRQ is valid.
+	 * Assume all parent IRQs belong to the same domain.
+	 */
+	parent = irq_get_irq_data(chip->irq_number[0])->domain;
 
 	ret = bgpio_init(&chip->gc, dev, 4,
 			 chip->base + SIFIVE_GPIO_INPUT_VAL,
-- 
2.40.1

