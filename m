Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7607EF84C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjKQUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjKQUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:59 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D68D57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:56 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b3f55e1bbbso1513212b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700252035; x=1700856835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Uy/nGn2rChA8c7KicPA5RLHwOBZWkxwdXoqQs+T9FI=;
        b=2+XdxDiOVAUwEHBmlFn/U/iOIbLMEN6BE1ylmm/F72DBfFvWneB9Tkwbs1kV7Iwmxa
         WKhZLCP1UztnIUpLY4l02FHU/eobad4LFjrmvcLwrBj7/3bfUQrorKrx1vWKdjHRwVlY
         KsgfhFJKSp2EJMzx56Nbc8GJpZfrV4qEhEcxmvcOl9xsOGWjjt5STQzCRDpT7uH4gBOp
         9jZVIJDO2OKaKOSFL0uvUu7e+TVErcRkMLqvdvm7f/r8mmI91rHVgv3Y1P51V8h4+jXP
         fkUsoamL9iJYFbTS1JhmEOCIgbpvfmrm8U2ht0qXHba0UcZWk84RQ/yoLFA3R37/TO8R
         5naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252035; x=1700856835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Uy/nGn2rChA8c7KicPA5RLHwOBZWkxwdXoqQs+T9FI=;
        b=WfBAF98ih7L9z3cUCHXTl0hdPs5QST9A/yzTqbhekIxqugNHamwl6EK0xdkG7RFHBk
         g0ohF4iG5zqur0eS4mzelyXMni3B9i7XqXsPmiCN+/8KleYDcsQWB0bzY2ltmkL2bVlg
         cTmdR4OQhPtQyG0xhSqlt5qQ1glO2gY69s/UnEhjvkbfBjk5ehcJMpIZzttXMTxC47HB
         Q+pO8hUA6uvErA1WanC8izm1tfG25XmDDOA30m56Vai/JfFYj1g2Kpvole/rF/8DAIcn
         WVtk6lf25vi8LB8enCn4z4G56Fs4OGiQv93JYkHs2IxRCazo91hG69Qlztx6Cioho4q9
         HiPQ==
X-Gm-Message-State: AOJu0Yyjew+Ft7rG0q4yVmAX+mN29SQ6pPoiZcj3huhxFkPdWXYeA4wI
        ucF8khiT+XMPpInIoxbOfvqTFg==
X-Google-Smtp-Source: AGHT+IEpNY443K2DTvic/4nX3g59+w/t2iGjY1+g+xvMgSfgHtSIdUiY9qzOZHhk0/Foi7Fgc7LpRw==
X-Received: by 2002:a05:6808:14cd:b0:3a4:3b56:72b2 with SMTP id f13-20020a05680814cd00b003a43b5672b2mr589101oiw.8.1700252035422;
        Fri, 17 Nov 2023 12:13:55 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b003a8560a9d34sm393814oil.25.2023.11.17.12.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:55 -0800 (PST)
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
Subject: [PATCH 05/14] spi: axi-spi-engine: use devm action to reset hw on remove
Date:   Fri, 17 Nov 2023 14:12:56 -0600
Message-ID: <20231117-axi-spi-engine-series-1-v1-5-cc59db999b87@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the reset of the hardware to a devm action in the AXI SPI
Engine driver. This will allow us to use devm on later calls in the
probe function while preserving the order during cleanup.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 77c1c115448d..c18a4b34777e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -461,6 +461,15 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	return 0;
 }
 
+static void spi_engine_release_hw(void *p)
+{
+	struct spi_engine *spi_engine = p;
+
+	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
+	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
+	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);
+}
+
 static int spi_engine_probe(struct platform_device *pdev)
 {
 	struct spi_engine *spi_engine;
@@ -506,6 +515,11 @@ static int spi_engine_probe(struct platform_device *pdev)
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
 
+	ret = devm_add_action_or_reset(&pdev->dev, spi_engine_release_hw,
+				       spi_engine);
+	if (ret)
+		return ret;
+
 	ret = request_irq(irq, spi_engine_irq, 0, pdev->name, host);
 	if (ret)
 		return ret;
@@ -532,16 +546,11 @@ static int spi_engine_probe(struct platform_device *pdev)
 static void spi_engine_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
 	int irq = platform_get_irq(pdev, 0);
 
 	spi_unregister_controller(host);
 
 	free_irq(irq, host);
-
-	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
-	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
-	writel_relaxed(0x01, spi_engine->base + SPI_ENGINE_REG_RESET);
 }
 
 static const struct of_device_id spi_engine_match_table[] = {

-- 
2.42.0

