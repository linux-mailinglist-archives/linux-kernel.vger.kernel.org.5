Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390BA781D61
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHTK1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjHTK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:27:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5937A1BC;
        Sun, 20 Aug 2023 03:23:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff882397ecso3422469e87.3;
        Sun, 20 Aug 2023 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527035; x=1693131835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZgU6wA7Pmpp+VVi1e/SiyvYotk5nrCsae8fMfP/TU8=;
        b=YvDF/i2IMPF/LEfh21+Oe5D8maqlyzoWZjma8ygZbTlESoDO1wFDnMkcrFj3+NDM+C
         CRqjAFLnYYfNmPImCO35w7WMEwYn7QinutBlnA/7AlGu+IdAA1B7Th3uYDqbPEKziMTC
         qtgKWMKtSyU3d97Fjum+rR4ZT0351MIznM+ZxkdiUI1Oh/0c3qFDExFS29YPABBhfAkZ
         EJTmLluhMx2a8PhUrzUkxrx17FeNVq+j4LJwwg5Qr/kGFwsOYtdUGl1rcMy3h5y0Y3K1
         u06FTo32hka4+/l2CEGWAqrZxGYbV3pCKim7Wv4GG6kYAE+C/xHLsifyiYcM0mqpvYIy
         p/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527035; x=1693131835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZgU6wA7Pmpp+VVi1e/SiyvYotk5nrCsae8fMfP/TU8=;
        b=OnojUomBt/U2YEfykhrvlxO0DKi2if55ybtUmTLHbvT8s0gK4YHuwrA0XzGfvm3l0u
         j0jL+wcmE2hlfsDvHO2YeHvn7hXat3hF/D1Shli0S5w3r85ZVDg4Zof7ONf2M1uAivvZ
         HUBRurw8405RBr3utRaCmoTSaFkPU6Ng1rCiowRfpBsmR2yj8m0lA0s4mXFf+SUXk3Q9
         EKbVvEEw4ekCweX31kWdPlzBA6/OYXbpTTFfdFXGoSrGMPD/10FuEPsUxviWBMQAscV5
         X+vvh1/O+GwhGLwGPiUdfhCfWDNaJxWhIji7P5ZxNBZrfh1r/JIjDSzgS0qHBwnV/odq
         WzIQ==
X-Gm-Message-State: AOJu0YyteXVNYQo2mJ4HesOI38nwaor+V18zGTUF+xqo6xIobPK9o2D2
        R+Yidi3exPg+RBi8AOUedEQ=
X-Google-Smtp-Source: AGHT+IHZ2HBQXFW0qIFZcelvjHk+6eC+3aJ/KAG/NUT1m74UVHtr4nHQpBk3pWdFiv85+yN4zrKN2A==
X-Received: by 2002:a05:6512:615:b0:4fd:d213:dfd4 with SMTP id b21-20020a056512061500b004fdd213dfd4mr2350539lfe.20.1692527035484;
        Sun, 20 Aug 2023 03:23:55 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ff9d22e486sm1193787lfq.226.2023.08.20.03.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:23:54 -0700 (PDT)
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
Subject: [PATCH v7 2/6] iio: adc: mcp3911: make use of dev_err_probe()
Date:   Sun, 20 Aug 2023 12:26:06 +0200
Message-ID: <20230820102610.755188-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820102610.755188-1-marcus.folkesson@gmail.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
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

Simplify code by switch to dev_err_probe().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series
    v6:
        - fix xmas tree order
    v7:
        - use dev_err_probe for config and scale function as well

 drivers/iio/adc/mcp3911.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..7fb3ab4a4256 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -277,10 +277,7 @@ static int mcp3911_calc_scale_table(struct mcp3911 *adc)
 	if (adc->vref) {
 		ret = regulator_get_voltage(adc->vref);
 		if (ret < 0) {
-			dev_err(&adc->spi->dev,
-				"failed to get vref voltage: %d\n",
-			       ret);
-			return ret;
+			return dev_err_probe(&adc->spi->dev, ret, "failed to get vref voltage\n");
 		}
 
 		ref = ret / 1000;
@@ -396,10 +393,9 @@ static int mcp3911_config(struct mcp3911 *adc)
 	if (ret)
 		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {
-		dev_err(&adc->spi->dev,
-			"invalid device address (%i). Must be in range 0-3.\n",
-			adc->dev_addr);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid device address (%i). Must be in range 0-3.\n",
+				     adc->dev_addr);
 	}
 	dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);
 
@@ -466,6 +462,7 @@ static const struct iio_trigger_ops mcp3911_trigger_ops = {
 
 static int mcp3911_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
 	int ret;
@@ -482,10 +479,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get regulator (%ld)\n",
-				PTR_ERR(adc->vref));
-			return PTR_ERR(adc->vref);
+			return dev_err_probe(dev, PTR_ERR(adc->vref), "failed to get regulator\n");
 		}
 
 	} else {
@@ -504,10 +498,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
-				"failed to get adc clk (%ld)\n",
-				PTR_ERR(adc->clki));
-			return PTR_ERR(adc->clki);
+			return dev_err_probe(dev, PTR_ERR(adc->clki), "failed to get adc clk\n");
 		}
 	}
 
-- 
2.41.0

