Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65529766F47
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjG1OTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjG1OTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1243C29
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-314172bac25so2076302f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553972; x=1691158772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giuTVJOpvmU1j6SJtXvrs5HolX4CC90ajhkJHQ0pjgw=;
        b=GrtnL7/fM1SgKRl6fxfIk1pgHVZc0FLNnQTNXNMpxFHXajx2rXR3OjONZAlZAyreCW
         wS0ZA56RjkbAQzV8dIXlnRLIgoKTDUHRohsAmJAfzMuVkjr5Eksf9+y24egs7pWkz1Lt
         t6aWo+pYRTaeAVlx7aJyRoDnL18L8ci+c0IkUlTPPt30Grj5WLBSNu/++YOtqK/AV7FR
         9AujkEv8QZrtBVNklyS4rjjO33pUWkVGZt9xTwemXM3VcFrc2pmM0EiFIJ173U7bccTe
         df3kQRxZyHLxaduu/v6G27VyPG8qfOPqqqKdg5koRtkWD54WPU55vPL1pHXtI8X+BVMr
         W/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553972; x=1691158772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giuTVJOpvmU1j6SJtXvrs5HolX4CC90ajhkJHQ0pjgw=;
        b=buZPkLTO2WXDd5AvDUO7w/VAM1iCQa+kfnOPzdJr7rIJmhmwQvDNSIc6ybyJ5D/gXZ
         zPXHoMImWJZ46QsUyfjYhrLhZ280xDd4+Kv7P/esmFIeHJf/guLAvIuPGvRDMoGUO3j/
         LTCa8aFja80AKdH4WIOCwIu8lIbdOf2x2oJSlBJCO6lGCfCdRAiHTDxWM+/WtET0zzw8
         O30873haAHvzmVdpba6+7TsE70RGxKXTqcW3R8ZKlMvRUwJAmuAGSVmQgj/1BA2xWd+/
         IiB4zSvraTnp3ZiwflFmOfPVAaQL42PrXpaX9C3zP9iewg7bRILuaGq7hKhSKcdDa26n
         Ac7Q==
X-Gm-Message-State: ABy/qLbCjklCxJJQ3+n3381lavk7CgqLOsOB+Ip+DKp2B5OqzFiphJ1J
        uijGoIpkCHq0VIPgRO8FRO/m7w==
X-Google-Smtp-Source: APBJJlEjiAZn1StP/CczL78boawHSDHTP+/5VlogrBFTZtZZTRb0ONZC3/06apTOOVB9xk0UI4TTYg==
X-Received: by 2002:a5d:6849:0:b0:313:f347:eea0 with SMTP id o9-20020a5d6849000000b00313f347eea0mr1951153wrw.60.1690553971785;
        Fri, 28 Jul 2023 07:19:31 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:31 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 6/6] can: tcan4x5x: Add error messages in probe
Date:   Fri, 28 Jul 2023 16:19:23 +0200
Message-Id: <20230728141923.162477-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
References: <20230728141923.162477-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 29 +++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2d329b4e4f52..8a4143809d33 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -402,6 +402,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	/* Sanity check */
 	if (freq < 20000000 || freq > TCAN4X5X_EXT_CLK_DEF) {
+		dev_err(&spi->dev, "Clock frequency is out of supported range %d\n",
+			freq);
 		ret = -ERANGE;
 		goto out_m_can_class_free_dev;
 	}
@@ -420,16 +422,23 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	/* Configure the SPI bus */
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed %pe\n", ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_regmap_init(priv);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "regmap init failed %pe\n", ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Enabling regulator failed %pe\n",
+			ERR_PTR(ret));
 		goto out_m_can_class_free_dev;
+	}
 
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
@@ -438,16 +447,24 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	}
 
 	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %pe\n", ERR_PTR(ret));
 		goto out_power;
+	}
 
 	ret = tcan4x5x_init(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "tcan initialization failed %pe\n",
+			ERR_PTR(ret));
 		goto out_power;
+	}
 
 	ret = m_can_class_register(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Failed registering m_can device %pe\n",
+			ERR_PTR(ret));
 		goto out_power;
+	}
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
-- 
2.40.1

