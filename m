Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13748759ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjGSQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGSQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:34:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C601BB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8a8154f9cso7284265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689784491; x=1690389291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY7X996NeRiPR/Rn6FoiwTLGW7DQeNpFoBjkmVc9GgI=;
        b=Or+/RZwQvNw8bCsOMpm2hSeXLxwp0YuvAcpxKF/K2j6mFJlt3xZGR9ukX+ORaAabKc
         S/BtVbCvnXG7wClDGpbGAMoCX/el65aEgzRnBn5+XjPwirv+/sC6G+nt5vaK46C5cJ5Q
         ut6Z72dE3exsn0wXnTpjlmU3IG8rj8ONqqZoL8UZAZ87q1sQR9ZrY3TIcTYSO5eCMkN0
         K2GBSS6WcrAdlz0eN/pd/f6gjwGcO56TIdZ8xhNSkqMOd3fcEa1E8jsNB3SSSPRXacMs
         RVqOmrJEu4o7Dpfa3m8IquxXcYW+JF2mpl9Bh8EWRGF9EJMZ5WhDBUiufGw+kw8cGlnV
         I0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689784491; x=1690389291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY7X996NeRiPR/Rn6FoiwTLGW7DQeNpFoBjkmVc9GgI=;
        b=UHr5KDW1ZlxPR8mErL7q2qCin4JSar1ZmveNYFK75xBNsJFaa0Tx/LXSPiyAmBKjb8
         fOFNz0iBPqYMj6qDfb01gHAY8wswMWK93hgxnt0JzyUR1tEenvULMktkkjO3iabBpkLG
         nQO+7pGocWsu8Y41hH8yirt1W5cOWgTAmiMiA7ezuPBXiVr56ucMWx9tGeFxkPZdIRuj
         RAWrYJTj0Rcy5bPPQtXbPAt9iQziqTKekdN2xsn+gu/mgGJWSjM2iPtn2/NpNe6YgnA4
         UamoLsM6UsPGSmnHCOZz7FE07/rL6Y5JBwcIm4ifwlK9sAMc5Yu0YObkHvzx/AVriHtd
         DIYA==
X-Gm-Message-State: ABy/qLbWlXi1OqHvlK093kRBjX62s+ywAaOQLJTczKUg+3/pbdwZeZCW
        WzmSibxeBRTgeUVxh2raKRr6Kg==
X-Google-Smtp-Source: APBJJlEdZ4LQSFXZ1B6gqxnku1+mdn1+YmhZhDbIEaXe7GUhYDR8hCg+4i71OKmpuzxzwsW+MP9rUw==
X-Received: by 2002:a17:902:bb84:b0:1b8:8728:d776 with SMTP id m4-20020a170902bb8400b001b88728d776mr2926304pls.0.1689784491343;
        Wed, 19 Jul 2023 09:34:51 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709027c0600b001b0358848b0sm4199276pll.161.2023.07.19.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:34:51 -0700 (PDT)
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
Subject: [PATCH v2 2/4] gpio: sifive: Look up IRQs only once during probe
Date:   Wed, 19 Jul 2023 09:34:43 -0700
Message-Id: <20230719163446.1398961-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719163446.1398961-1-samuel.holland@sifive.com>
References: <20230719163446.1398961-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_irq_count(), or eqivalently platform_irq_count(), simply looks up
successively-numbered IRQs until that fails. Since this driver needs to
look up each IRQ anyway to get its virq number, use that existing loop
to count the IRQs at the same time.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 drivers/gpio/gpio-sifive.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index ab32c952c61b..6606c919d957 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -185,7 +185,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	struct irq_domain *parent;
 	struct gpio_irq_chip *girq;
 	struct sifive_gpio *chip;
-	int ret, ngpio, i;
+	int ret, ngpio;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -202,13 +202,6 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-	ngpio = of_irq_count(node);
-	if (ngpio > SIFIVE_GPIO_MAX) {
-		dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
-			SIFIVE_GPIO_MAX);
-		return -ENXIO;
-	}
-
 	irq_parent = of_irq_find_parent(node);
 	if (!irq_parent) {
 		dev_err(dev, "no IRQ parent node\n");
@@ -221,11 +214,11 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < ngpio; i++) {
-		ret = platform_get_irq(pdev, i);
+	for (ngpio = 0; ngpio < SIFIVE_GPIO_MAX; ngpio++) {
+		ret = platform_get_irq_optional(pdev, ngpio);
 		if (ret < 0)
-			return ret;
-		chip->irq_number[i] = ret;
+			break;
+		chip->irq_number[ngpio] = ret;
 	}
 
 	ret = bgpio_init(&chip->gc, dev, 4,
-- 
2.40.1

