Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6FA7EF84A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346202AbjKQUOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjKQUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:58 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC12D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:55 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b6d88dbaa3so1487346b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252034; x=1700856834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwzXznL4NYavhVUNHzr4kJuVjofxWovc+jaQlF/tetc=;
        b=EUNEI5bFxbQ+wjUpIFeqryFo8RgL/jszVWX5ykUtkBoQOWq2M/e6FzFsFicDMatiqq
         cmVlUSsGgNU3HseLs/oWs1599irG5YXdWMAqYadiRsliOHB3GsgJsoNVbNwmNG/k9kPk
         +vxM2bcGHn3Tk3aYOvBNHLucWF+NGgKTQGxYvl9HElEpy0fd16OxZviC1OOGxmDdQGOM
         o+sTBaOF6AgqJn+qiBJRBC0kX0qsNV3Dj12lt30uzWQ2e1YYFBYBmxya4hkaGwPEQC7w
         LlOde6ReuyTrrIRKhc+gCL6y/uqggP0SL7IpTxaZ5z2hsXT6YFT5wYhFxDXrGVdD/sUi
         zSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252034; x=1700856834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwzXznL4NYavhVUNHzr4kJuVjofxWovc+jaQlF/tetc=;
        b=qLPfXiwEp+nV+bN6Yueubd/0rx30NhqeVMBzyPPi8kfuHySvD6AzO3ok9wvbpBkWyi
         SKLabHjw3LhlP2VzlP3b4eU8LM6ArXJJwX6xdZ4tlKilCPf4NNw29dFoBtGyZHuXTyct
         oUlMl1BrqBjyIdYgT4o2ePAbcbC9PZndFNLZny0B4FZuutgmCZraoIwkohs0UhUVkzyZ
         dLDwEr1zMclUqZSO7uLhhRZGDStKz+lwplHgsfVJLNggcuHN4PH5T4rg24c9p2UMHNTV
         EMQtkTHkHDwP1hXT8cDbqpffYjhyHxk7/FOo/NGwhcYY2oZKt5NevG8rCfTP7i0xFfVE
         YMjw==
X-Gm-Message-State: AOJu0YzIIOWCyUpicWaLzvU9uQQACYOGrhevUN1ulL+WLU21EdJLHZvc
        lawkn2mXsIYeFXTM5/vbay6P6Q==
X-Google-Smtp-Source: AGHT+IGavxcM6yTEubR3PYLm487eVYtQfilkeWcy9vAYSJ/yk+i5Xgcq3QXKWV7F/hyvpN3JwgA7IA==
X-Received: by 2002:a05:6808:1241:b0:3ae:2b43:dd47 with SMTP id o1-20020a056808124100b003ae2b43dd47mr537281oiv.22.1700252034604;
        Fri, 17 Nov 2023 12:13:54 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:54 -0800 (PST)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     David Lechner <dlechner@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] spi: axi-spi-engine: use devm_spi_alloc_host()
Date:   Fri, 17 Nov 2023 14:12:55 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-4-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modifies the AXI SPI Engine driver to use devm_spi_alloc_host()
instead of spi_alloc_host() to simplify the code a bit.

In addition to simplifying the error paths in the probe function, we
can also remove spi_controller_get/put() calls in the remove function
since devm_spi_alloc_host() sets a flag to no longer decrement the
controller reference count in the spi_unregister_controller() function.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index bdf0aa4ceb1d..77c1c115448d 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -473,7 +473,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi_engine));
 	if (!host)
 		return -ENOMEM;
 
@@ -482,22 +482,16 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spin_lock_init(&spi_engine->lock);
 
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
-	if (IS_ERR(spi_engine->clk)) {
-		ret = PTR_ERR(spi_engine->clk);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->clk))
+		return PTR_ERR(spi_engine->clk);
 
 	spi_engine->ref_clk = devm_clk_get_enabled(&pdev->dev, "spi_clk");
-	if (IS_ERR(spi_engine->ref_clk)) {
-		ret = PTR_ERR(spi_engine->ref_clk);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->ref_clk))
+		return PTR_ERR(spi_engine->ref_clk);
 
 	spi_engine->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi_engine->base)) {
-		ret = PTR_ERR(spi_engine->base);
-		goto err_put_host;
-	}
+	if (IS_ERR(spi_engine->base))
+		return PTR_ERR(spi_engine->base);
 
 	version = readl(spi_engine->base + SPI_ENGINE_REG_VERSION);
 	if (SPI_ENGINE_VERSION_MAJOR(version) != 1) {
@@ -505,8 +499,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 			SPI_ENGINE_VERSION_MAJOR(version),
 			SPI_ENGINE_VERSION_MINOR(version),
 			SPI_ENGINE_VERSION_PATCH(version));
-		ret = -ENODEV;
-		goto err_put_host;
+		return -ENODEV;
 	}
 
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
@@ -515,7 +508,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
 	if (ret)
-		goto err_put_host;
+		return ret;
 
 	host->dev.of_node = pdev->dev.of_node;
 	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
@@ -533,14 +526,12 @@ static int spi_engine_probe(struct platform_device *pdev)
 	return 0;
 err_free_irq:
 	free_irq(irq, host);
-err_put_host:
-	spi_controller_put(host);
 	return ret;
 }
 
 static void spi_engine_remove(struct platform_device *pdev)
 {
-	struct spi_controller *host = spi_controller_get(platform_get_drvdata(pdev));
+	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -548,8 +539,6 @@ static void spi_engine_remove(struct platform_device *pdev)
 
 	free_irq(irq, host);
 
-	spi_controller_put(host);
-
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);

-- 
2.42.0

