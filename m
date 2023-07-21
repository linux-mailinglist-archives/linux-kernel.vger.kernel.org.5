Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9175C84E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGUNus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjGUNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FFE30C7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso17232905e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947420; x=1690552220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRBYGxiJV+fUO8L5x5OkCA3grJdrnxlxanjlGq4MKP4=;
        b=pfR7mREr9aayrh+8f9nOd5qtIuFl435AvZJdQGv4nHPrajIcHM6UzskadI1FY3Jaxs
         NQS9yZsNmtZ22/yZjmm60KISaFO6zMnpY9KAevpevBTm4ZT4WNkfwH/P3qCRjmc8V9pX
         N1ff8VZXBWBZmIVdkVV0SBJH4slQeFxdXn09zAK+U12hTq9eShicztoNnxb3wLdWlp2N
         oCP5Zq610M8aEHl94yIKan/Lmk46W5ONk3k+hSSk3wwXqg9gLr3BGnLot2bedPF5OYtX
         TT760rAP4bbDEajDXH44a9AKHxRJfj7wzq337I1DRLVeYTf51pk7Jr8PCKH2TFu4igwA
         iN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947420; x=1690552220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRBYGxiJV+fUO8L5x5OkCA3grJdrnxlxanjlGq4MKP4=;
        b=cRs1IqoTYWqgFgk8EehBrmveFYIvb82ZkJ1Mj89uH2PlHde+MfSn642TgvPA1R2YX7
         XVzWRMt5DE7NjgSOxFVRQeTSxdiyG3+DwJcZ/hGXBur00rksFyWQlTFyBzwIDjMaaeeM
         P4DLC/ZqK/CRLy4QwdQc8H9OyxiibBrksu8P5HSJ97tsO+h9Yh1JO4Imgp2ar3pM5Mg4
         KBgt76MqsJ9CodRdbTZvWQjJt/VYDKV5JTEmtUcckrrbKYeKF67cQjJDA6fkrfZ9yEv/
         IoEGiHvhlW6x10DJFCWAPcgI80xthQ6S9h4/IPZqFldUg4N1ApnAY/2pocnUAehqvGS4
         nagg==
X-Gm-Message-State: ABy/qLYMac+ULpQIF6S39Kb7MkYRmpEsHuteTR4c7Nnp2SRlmIafOAKO
        JKzlslM05EmezNaapXqd5Ix/qw==
X-Google-Smtp-Source: APBJJlFgG2WeFkm/yf/wlFlPZiCNsdoffBh//BtztWnERSfUFPNj2OMuWQPhdMMl7iGF3Y9DuEJvtA==
X-Received: by 2002:a05:600c:20c4:b0:3f4:d18f:b2fb with SMTP id y4-20020a05600c20c400b003f4d18fb2fbmr1623924wmm.8.1689947419766;
        Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:19 -0700 (PDT)
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
Subject: [PATCH v3 6/6] can: tcan4x5x: Add error messages in probe
Date:   Fri, 21 Jul 2023 15:50:09 +0200
Message-Id: <20230721135009.1120562-7-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721135009.1120562-1-msp@baylibre.com>
References: <20230721135009.1120562-1-msp@baylibre.com>
MIME-Version: 1.0
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

To be able to understand issues during probe easier, add error messages
if something fails.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2d329b4e4f52..60380b50e553 100644
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
@@ -420,16 +422,22 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	/* Configure the SPI bus */
 	spi->bits_per_word = 8;
 	ret = spi_setup(spi);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "SPI setup failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_regmap_init(priv);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "regmap init failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	ret = tcan4x5x_power_enable(priv->power, 1);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Enabling regulator failed %d\n", ret);
 		goto out_m_can_class_free_dev;
+	}
 
 	version_info = tcan4x5x_find_version(priv);
 	if (IS_ERR(version_info)) {
@@ -438,16 +446,22 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	}
 
 	ret = tcan4x5x_get_gpios(mcan_class, version_info);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Getting gpios failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = tcan4x5x_init(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "tcan initialization failed %d\n", ret);
 		goto out_power;
+	}
 
 	ret = m_can_class_register(mcan_class);
-	if (ret)
+	if (ret) {
+		dev_err(&spi->dev, "Failed registering m_can device %d\n", ret);
 		goto out_power;
+	}
 
 	netdev_info(mcan_class->net, "TCAN4X5X successfully initialized.\n");
 	return 0;
-- 
2.40.1

