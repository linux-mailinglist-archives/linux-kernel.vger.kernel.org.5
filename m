Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5391777B84C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjHNMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjHNMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CBEF5;
        Mon, 14 Aug 2023 05:08:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-986d8332f50so572485366b.0;
        Mon, 14 Aug 2023 05:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014897; x=1692619697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWoGZr69/zL66ym22bwxiAL63PVvg4kqD1dTeOz6J98=;
        b=pO1lmFz89wBRElBTFda36fMMlECfvstv1gwhlD9ZamYwwMCJgT1sz9fpWbSkRYeOXK
         xrUFTHAHyny5ybwLlEuq+xnagbFQSdjOLS7W7REfzauEw/4ie17Zvuag0QnSRVOVPv5d
         e923JDOTNJxuEBrkR+dZL9Gd5UR4uL/iHfZjyjBNUyVTUthPxNujra/3W7A94b9/we80
         ceSJYsDf9bOpgnUvuG1ZQ8RuZbrATbj51FjvPFWwRBpRmVs8YDKHB1klMmo8KNSby9HS
         nU+OHag4WzpATdJheEgXTT8m7Q6ZQ0nn+obEwIp3kqmEZir6w8KX+ghmwmh2QE/RdWOj
         zjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014897; x=1692619697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWoGZr69/zL66ym22bwxiAL63PVvg4kqD1dTeOz6J98=;
        b=ANvqFR7cpsSI6bb1lK9EdVAllLNqe3HXfjfeNvulEam4qXnOxFYAcXSPVAkoc0SDfr
         NlqnDUj4vCOwLr8jqGw6yZIX28oGUOEx11ySyt4OvuWaTvTNd/mBpPSY6I47mlYV97CB
         S5XZe2kz7oxj49/BZ4sib85kJOjKLVM7oWH38QXQGhdcOLRffGzAP5lagVsuPPbrtc55
         AuwGjgb+ET0NXiJ39IqeoHBgqvWKgvooEiNZcPMXkzv99zVvrosk9s4CQfQD8dq1c1P6
         6w6f77+m+KbQ9FuwSUdS0r3qOSM2pnExBMeqhrl4aU13PPKmbFe4BiRf+fqV8FdCPgqw
         Z0Cg==
X-Gm-Message-State: AOJu0YwF9HnCKEkTkRNklpjikPeXBuAD4cPWYaAtGlwI/Im3iPcxfTd2
        gupHGBSY98HRgwTsR4827betxsMWkOlIG3vD
X-Google-Smtp-Source: AGHT+IFEtF605rnSZffsIwmwuf7YL13/5Bluv/QlOycy5OU1oZ2o/Ed1DFhMGAai9qQAzFyfsZ9T+g==
X-Received: by 2002:a17:906:31d3:b0:99c:f966:9e9d with SMTP id f19-20020a17090631d300b0099cf9669e9dmr7316428ejf.10.1692014897487;
        Mon, 14 Aug 2023 05:08:17 -0700 (PDT)
Received: from goliat.isc.local (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b009930042510csm5600433ejf.222.2023.08.14.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:08:16 -0700 (PDT)
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
Subject: [PATCH v5 3/6] iio: adc: mcp3911: simplify usage of spi->dev
Date:   Mon, 14 Aug 2023 14:10:07 +0200
Message-ID: <20230814121010.184842-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814121010.184842-1-marcus.folkesson@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the usage of `adc->spi->dev` with `dev` to make the code prettier.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series
    v5:
        - Introduce `struct device *dev` to more functions

 drivers/iio/adc/mcp3911.c | 59 ++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 681248a3ddde..12fa635ed199 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -270,6 +270,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 {
 	u32 ref = MCP3911_INT_VREF_MV;
+	struct device *dev = &adc->spi->dev;
 	u32 div;
 	int ret;
 	u64 tmp;
@@ -277,9 +278,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	if (adc->vref) {
 		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0) {
-			dev_err(&adc->spi->dev,
-				"failed to get vref voltage: %d\n",
-			       ret);
+			dev_err(dev, "failed to get vref voltage: %d\n", ret);
 			return ret;
 		}
 
@@ -337,6 +336,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mcp3911 *adc = iio_priv(indio_dev);
+	struct device *dev = &adc->spi->dev;
 	struct spi_transfer xfer[] = {
 		{
 			.tx_buf = &adc->tx_buf,
@@ -354,8 +354,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 	adc->tx_buf = MCP3911_REG_READ(MCP3911_CHANNEL(0), adc->dev_addr);
 	ret = spi_sync_transfer(adc->spi, xfer, ARRAY_SIZE(xfer));
 	if (ret < 0) {
-		dev_warn(&adc->spi->dev,
-				"failed to get conversion data\n");
+		dev_warn(dev, "failed to get conversion data\n");
 		goto out;
 	}
 
@@ -396,12 +395,10 @@ static int mcp3911_config(struct mcp3911 *adc)
 	if (ret)
 		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
+		dev_err(dev, "invalid device address (%i). Must be in range 0-3.\n", adc->dev_addr);
 		return -EINVAL;
 	}
-	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
+	dev_dbg(dev, "use device address %i\n", adc->dev_addr);
 
 	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, &regval, 2);
 	if (ret)
@@ -409,21 +406,19 @@ static int mcp3911_config(struct mcp3911 *adc)
 
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
 
@@ -471,14 +466,14 @@ static int mcp3911_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
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
@@ -491,13 +486,12 @@ static int mcp3911_probe(struct spi_device *spi)
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
@@ -510,7 +504,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+	if (device_property_read_bool(dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
 				0, 2);
 	else
@@ -544,15 +538,15 @@ static int mcp3911_probe(struct spi_device *spi)
 	mutex_init(&adc->lock);
 
 	if (spi->irq > 0) {
-		adc->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
-				indio_dev->name,
-				iio_device_id(indio_dev));
+		adc->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						   indio_dev->name,
+						   iio_device_id(indio_dev));
 		if (!adc->trig)
 			return -ENOMEM;
 
 		adc->trig->ops = &mcp3911_trigger_ops;
 		iio_trigger_set_drvdata(adc->trig, adc);
-		ret = devm_iio_trigger_register(&spi->dev, adc->trig);
+		ret = devm_iio_trigger_register(dev, adc->trig);
 		if (ret)
 			return ret;
 
@@ -561,20 +555,21 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
-		ret = devm_request_irq(&spi->dev, spi->irq,
-				&iio_trigger_generic_data_rdy_poll, IRQF_NO_AUTOEN | IRQF_ONESHOT,
-				indio_dev->name, adc->trig);
+		ret = devm_request_irq(dev, spi->irq,
+				       &iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-			NULL,
-			mcp3911_trigger_handler, NULL);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      NULL,
+					      mcp3911_trigger_handler, NULL);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&adc->spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.41.0

