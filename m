Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C752C781D66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHTK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHTK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:27:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39BAE40;
        Sun, 20 Aug 2023 03:23:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so3462022e87.3;
        Sun, 20 Aug 2023 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527037; x=1693131837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqWrQxkbWf9wYQs+sFA06GminTdHA58J91bgcXwAllQ=;
        b=dWkqiQZ66jhFMPav1vMLgdgoNnPR96Rr2tGAiIFNA/b59heVTP5eTqNk12VTRQrSsA
         LPG4tDab08BT09tR3DYZ+WXPiZ0G2HdP1eMZLPwxWXoOgz7QMcdCTwnm0mwMJbftey6M
         R/T3PaG3XGhFtvCIb3iV7DVLJr0BHUNFIOY31j8ZxZcVfFBUqmltMhLo424iXZwmANjL
         tuRoXKswn/RxpwjaLlZRd3ZZJE2tmSWFXwO+v76NTRs/7iNgIf4N9h2FzZYuSethMTU0
         TgSXEDEPo7wQsRjjm/sKN8Qurd3o1rs599bn8Fb01uj+wH4EZeXkcBnJVhA0F4XvcFUz
         HiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527037; x=1693131837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqWrQxkbWf9wYQs+sFA06GminTdHA58J91bgcXwAllQ=;
        b=eA9HjVGb7CI1p2FO5B2I0B27T2aIhwm6g3Mvk+Kl7ZEjn0V0Vd/cLPawfMOKzpQqU4
         QFMZv0LGWeIeA/7c3F6OikaHNp6w13RlL2gNSjgFnt1WeGwBj0se4wwU78xdXguu4gjF
         8RlcP+87XfkXRz4h6EGKNBFO017XFWDkHgoKh8o1eUt8ZL6EQmLw66ilgQG2huxxLfAh
         Qo0wlluM8GU6BeOcoHfUuvTCMfGF/eZo9dly3nkOIhJj4NiwsrfMgI+QplRz8C4ndKEm
         Wu1l2/otMur6nUd94OL02e+PlZRAq4D4NO+sDN4CFOX8cl15S4QVFHbD9ZkyLigRKTz2
         z6sQ==
X-Gm-Message-State: AOJu0YyIteA1PWfJaxbKhuB00gFBFgEiWYKVfkm86vUCRgAPhEwbfj15
        mmqGQ8WzXwruN9rDsM8dMy8=
X-Google-Smtp-Source: AGHT+IG2tlht0icg5joxlVGWuLL+ilBRuAUZn7Ntxe6Fsv9Qr7bdJWCsmTKwDYuTw90L1bSLM2QvFQ==
X-Received: by 2002:a05:6512:39c1:b0:4ff:8b28:7b22 with SMTP id k1-20020a05651239c100b004ff8b287b22mr2526638lfu.68.1692527036989;
        Sun, 20 Aug 2023 03:23:56 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ff9d22e486sm1193787lfq.226.2023.08.20.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:23:56 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] iio: adc: mcp3911: simplify usage of spi->dev
Date:   Sun, 20 Aug 2023 12:26:07 +0200
Message-ID: <20230820102610.755188-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820102610.755188-1-marcus.folkesson@gmail.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the usage of `adc->spi->dev` with `dev` to make the code prettier.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Introduce `struct device *dev` to more functions
    v6:
        - cosmetics
    v7:
        - compress some calls to two lines

 drivers/iio/adc/mcp3911.c | 50 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 7fb3ab4a4256..31ee8d7f81de 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -269,6 +269,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 
 static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 {
+	struct device *dev = &adc->spi->dev;
 	u32 ref = MCP3911_INT_VREF_MV;
 	u32 div;
 	int ret;
@@ -277,7 +278,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	if (adc->vref) {
 		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0) {
-			return dev_err_probe(&adc->spi->dev, ret, "failed to get vref voltage\n");
+			return dev_err_probe(dev, ret, "failed to get vref voltage\n");
 		}
 
 		ref = ret / 1000;
@@ -334,6 +335,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mcp3911 *adc = iio_priv(indio_dev);
+	struct device *dev = &adc->spi->dev;
 	struct spi_transfer xfer[] = {
 		{
 			.tx_buf = &adc->tx_buf,
@@ -351,8 +353,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
-		dev_warn(&adc->spi->dev,
-				"failed to get conversion data\n");
+		dev_warn(dev, "failed to get conversion data\n");
 		goto out;
 	}
 
@@ -397,7 +398,7 @@ static int mcp3911_config(struct mcp3911 *adc)
 				     "invalid device address (%i). Must be in range 0-3.\n",
 				     adc->dev_addr);
 	}
-	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
+	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
 	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
@@ -405,21 +406,19 @@ static int mcp3911_config(struct mcp3911 *adc)
 
 	regval &= ~MCP3911_CONFIG_VREFEXT;
 	if (adc->vref) {
-		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
+		dev_dbg(dev, "use external voltage reference\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 1);
 	} else {
-		dev_dbg(&adc->spi->dev,
-			"use internal voltage reference (1.2V)\n");
+		dev_dbg(dev, "use internal voltage reference (1.2V)\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_VREFEXT, 0);
 	}
 
 	regval &= ~MCP3911_CONFIG_CLKEXT;
 	if (adc->clki) {
-		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
+		dev_dbg(dev, "use external clock as clocksource\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 1);
 	} else {
-		dev_dbg(&adc->spi->dev,
-			"use crystal oscillator as clocksource\n");
+		dev_dbg(dev, "use crystal oscillator as clocksource\n");
 		regval |= FIELD_PREP(MCP3911_CONFIG_CLKEXT, 0);
 	}
 
@@ -467,14 +466,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	struct mcp3911 *adc;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
+	adc->vref = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(adc->vref)) {
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
@@ -487,13 +486,12 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 
-		ret = devm_add_action_or_reset(&spi->dev,
-				mcp3911_cleanup_regulator, adc->vref);
+		ret = devm_add_action_or_reset(dev, mcp3911_cleanup_regulator, adc->vref);
 		if (ret)
 			return ret;
 	}
 
-	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
+	adc->clki = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(adc->clki)) {
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
@@ -506,7 +504,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+	if (device_property_read_bool(dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
 				0, 2);
 	else
@@ -540,15 +538,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	if (spi->irq > 0) {
-		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-				indio_dev->name,
-				iio_device_id(indio_dev));
+		adc->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						   iio_device_id(indio_dev));
 		if (!adc->trig)
 			return -ENOMEM;
 
 		adc->trig->ops = &mcp3911_trigger_ops;
 		iio_trigger_set_drvdata(adc->trig, adc);
-		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		ret = devm_iio_trigger_register(dev, adc->trig);
 		if (ret)
 			return ret;
 
@@ -557,20 +554,19 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
-		ret = devm_request_irq(&spi->dev, spi->irq,
-				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
-				indio_dev->name, adc->trig);
+		ret = devm_request_irq(dev, spi->irq, &iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-			NULL,
-			mcp3911_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      mcp3911_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&adc->spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.41.0

