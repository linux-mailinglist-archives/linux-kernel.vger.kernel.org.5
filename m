Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A24C7741E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjHHRaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjHHR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:29:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA077D92;
        Tue,  8 Aug 2023 09:12:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3179ed1dfbbso5027768f8f.1;
        Tue, 08 Aug 2023 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511138; x=1692115938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OElZr8BTpJ7JNneHnhrzYnj3mSvt2d3fP42MAZf4FtQ=;
        b=aWQU4B/4bA9BeO/gkbRGrnBvv3RiFnqPVL5h442qBPhaI2BOCz1lwgedWS2CVdPvv7
         QowLNtjpwOTs1uStm9MRTlJTelwrWbvy1P4J7XCzcEMAMmqCd10zUqr90dAZqxWLC7tl
         XWkSvjDoHFsj3ZXpBVN8guI4gG7KenN6lY7k23H/vU0YiGCT+hy8HwqYjvW8DL6gPSqZ
         VE/KQmaoGad2G4O4w2nmXXorJr1SF136oFvpmEBppwd89DSCjf9Z38u6IMCi4qmZCa4+
         SwMXKNCJbCCmIGgl5ry+Hk1+wcrBUApcTlBIJ/QmxvwBSpZR7R5KPn+uuXff6JeTWtJY
         gKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511138; x=1692115938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OElZr8BTpJ7JNneHnhrzYnj3mSvt2d3fP42MAZf4FtQ=;
        b=mE36iJ0fOaMnhBB8JzOrE2X+UbpCng0UbThYHsHjsKf5qX0/Yg0KScFQnhlPFPV6Gv
         R0ANY/iIT+EdxpGAyzqqcmJS2qZItpkoO2c+oon5Vi2/jhUKFafCKvcrLmN8PNpleYbB
         lsnTZWtTy2ejvgA9MxqlKX0SOv4H0wkIZ9j4QXTnvUJA5uSLj/Q0+fCKO1YONGQzjJVs
         aMJEhI4kc7AyJjYnYUvFwhbfcd0VD+R3Gw1fhcchJao/euSyYkk/8KbTIXpY52xhQ9kt
         DMAa3TNh6zsrENV+YBRBQ3DQcul4OozIC8DpP52AnxL1+BK4MqYASuiQoN/wJ8icYmGp
         ZhaQ==
X-Gm-Message-State: AOJu0YziolYwrK2fTJ4CUdsVOO44VBk1qs5XArzFDKa0tFhIGkMYqaI4
        Th3BMIXmitCMSkrEBJrMuMKf6oIHIxZqgfYC
X-Google-Smtp-Source: AGHT+IHFF7dDPQhzQUQPghx+XHCvh67UlBo8NKyyS0a+44thDgRrQOJu7WvNFuXvCHV8vzaj6Te4/g==
X-Received: by 2002:a05:6512:31cd:b0:4fc:265d:fc62 with SMTP id j13-20020a05651231cd00b004fc265dfc62mr8564067lfe.18.1691492570400;
        Tue, 08 Aug 2023 04:02:50 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b004fbad682ffesm1826587lfo.88.2023.08.08.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:02:48 -0700 (PDT)
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
Subject: [PATCH v4 2/4] iio: adc: mcp3911: simplify usage of spi->dev in probe function
Date:   Tue,  8 Aug 2023 13:04:30 +0200
Message-Id: <20230808110432.240773-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808110432.240773-1-marcus.folkesson@gmail.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
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

Replace the usage of adc->spi->dev with spi->dev to make the code prettier.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
        - New patch in this series

 drivers/iio/adc/mcp3911.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..8bbf2f7c839e 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -477,12 +477,12 @@ static int mcp3911_probe(struct spi_device *spi)
 	adc = iio_priv(indio_dev);
 	adc->spi = spi;
 
-	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
+	adc->vref = devm_regulator_get_optional(&spi->dev, "vref");
 	if (IS_ERR(adc->vref)) {
 		if (PTR_ERR(adc->vref) == -ENODEV) {
 			adc->vref = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
+			dev_err(&spi->dev,
 				"failed to get regulator (%ld)\n",
 				PTR_ERR(adc->vref));
 			return PTR_ERR(adc->vref);
@@ -499,12 +499,12 @@ static int mcp3911_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
+	adc->clki = devm_clk_get_enabled(&spi->dev, NULL);
 	if (IS_ERR(adc->clki)) {
 		if (PTR_ERR(adc->clki) == -ENOENT) {
 			adc->clki = NULL;
 		} else {
-			dev_err(&adc->spi->dev,
+			dev_err(&spi->dev,
 				"failed to get adc clk (%ld)\n",
 				PTR_ERR(adc->clki));
 			return PTR_ERR(adc->clki);
@@ -515,7 +515,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))
+	if (device_property_read_bool(&spi->dev, "microchip,data-ready-hiz"))
 		ret = mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSCOM_DRHIZ,
 				0, 2);
 	else
@@ -579,7 +579,7 @@ static int mcp3911_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&adc->spi->dev, indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct of_device_id mcp3911_dt_ids[] = {
-- 
2.40.1

