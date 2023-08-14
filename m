Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B177B84B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjHNMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjHNMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC5C18B;
        Mon, 14 Aug 2023 05:08:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c47ef365cso584147866b.0;
        Mon, 14 Aug 2023 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014895; x=1692619695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgT6v6UPoUfFOEUtDJqn1N6hvfyW8RNyW84EUc6M0z0=;
        b=rywnj7s716WZyrQzAdtSqvMFFJNF6ZdMjujK+7SJPOzKfdS0wsJSgtlnFbo7YAXwT7
         sLnePqhEt66PLFxg4flNMjEiCDHjsNiXkpSPNA4hvKzU8D9kIwj5GP+FNUHT/8hkzy8h
         5YOJh/ILCw/Dd2CK0mAY2WhroHdh7O/PqLmagZhDl6myVIAVpH/Gn7tktEmjvbbxv4Tz
         NZh37RDza4lCWkb2kD0yFgg2ngVDE5xIE7scGpI9qHdKHcw80wJpRfSkc4ts27O+g0Sx
         7RV2KQRxvvWwmB2aRlV0IjQOVk2V6eEUGgj35dqHcNb90efS77IiXdMg5AaXrBx6rLeC
         2f7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014895; x=1692619695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgT6v6UPoUfFOEUtDJqn1N6hvfyW8RNyW84EUc6M0z0=;
        b=inOVCWow/8gBgDYSH5/huWeB36v9a1pDsJFaUmBeRRvyo5Ym7EW3oJY1kkZrFzUaFF
         9rBZUHN7EJ3smn1kJDJCuy+KO5pM9LwQzU/IS0+qL/+IPZryY3jXMU89JdVgTf7hD7Fz
         y9rZsS0lQiLBk7nEYARnYidBtEaYXs6lJkViVisGGZLKzY/GN62AO//5KeqkO+OUQjei
         25gBxydS6KRFtqP7/pR0Lkr6kFaFCFTRQrkAJ/bvX55BfRTcN/UakrzrCMOjple3bmh9
         HxgqPOpzb6JzGDcEjBRnTLvqpgIzBhGE+Tt4QOonahQXavUDofweOp7r/4mGZnU/lSOQ
         1dEw==
X-Gm-Message-State: AOJu0Yx5fwXhDfBaP+5bu6Ro9NShx5zpESr0MxxUyTf3RJ0FOuzmEvVX
        zkmxAGXXFWwobQQmxb2+kv8=
X-Google-Smtp-Source: AGHT+IFGNhgy+vN64qKYVTzYuxfbpzO1QK/h/dDdlbknBqHLK/nPBjAubMLi/BSaSuS2kTfitygBow==
X-Received: by 2002:a17:907:2ce9:b0:992:a9c3:244f with SMTP id hz9-20020a1709072ce900b00992a9c3244fmr8303966ejc.4.1692014895324;
        Mon, 14 Aug 2023 05:08:15 -0700 (PDT)
Received: from goliat.isc.local (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b009930042510csm5600433ejf.222.2023.08.14.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:08:14 -0700 (PDT)
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
Subject: [PATCH v5 2/6] iio: adc: mcp3911: make use of dev_err_probe()
Date:   Mon, 14 Aug 2023 14:10:06 +0200
Message-ID: <20230814121010.184842-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814121010.184842-1-marcus.folkesson@gmail.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
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

Simplify code by switch to dev_err_probe().

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
        - New patch in this series

 drivers/iio/adc/mcp3911.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 974c5bd923a6..681248a3ddde 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -468,6 +468,7 @@ static int mcp3911_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct mcp3911 *adc;
+	struct device *dev = &spi->dev;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
@@ -482,10 +483,7 @@ static int mcp3911_probe(struct spi_device *spi)
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
@@ -504,10 +502,7 @@ static int mcp3911_probe(struct spi_device *spi)
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

