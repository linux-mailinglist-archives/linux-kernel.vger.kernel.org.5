Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8E762C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGZHGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjGZHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:05:27 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082449CB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe1344b707so99663e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690355013; x=1690959813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CX68KTNlS373FwdWF/UAKpFV3pcBsBsg1fSNG+Fkfc=;
        b=vnjThvalLQH0gZeIBxJIzOoMx7W8K66THSq8d+a9PnbhXAECqX6QQFEmVUNqh5RhX0
         xtuIXa+Wxi+InwlFdSnmi1iPPWFbBc46n/Hhq8IJDX2PFdyUrisRZJR7y5+DQAOV6KES
         nRGO1HpL0xFHBuQAgKmBGigkjmwbhPy7QyS+LDn5YtqpSdL8rxurRDdRotctHt7FqjRq
         bOsja3t93bf0KxlZ3U7/1/RRo7ZoZYT7OjfKOQbWiLwxZCQWuSm08H5gkQUJQIWah0rp
         1R19878jRCJJqmb34JCwGJLHjWD5NdzS1EZFYIhYVgjyXzFwp/wEMt1Erh/r10EnaCKW
         mGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690355013; x=1690959813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CX68KTNlS373FwdWF/UAKpFV3pcBsBsg1fSNG+Fkfc=;
        b=l2B+EfflTQbmrzpym7tS4Fwzmr5aTBZVscuBzrBFem13gKqfruXDq3BOftlsShSoMo
         s3BkTWgQHvaqL4i3Nl0SCJpdYt+rfQu3VGcue7L9bEv//UDO5KwSQENzr2SWU+ypQPpo
         Q3GKA+sc3RD5kyMk3XaJwCF9CXep4tCAW3jZ//TzHacbvKTS9gAmJ+567vJMN2TvaaRy
         l2n8Rig07jEzGK7lveXsz8kVOmPmvIVo3pGqWGrMEq+OahusGaYxxaQHsc/LVBOye9tB
         EdMpqq9090KZF56xHX5gDSIOlaxoVEaUSrfV6K96iLFmoYrTOcbLfy+Rc6QmcFxCZ9GR
         vnqw==
X-Gm-Message-State: ABy/qLbPGlmiY02vj3zBebkqpajhkOBfFHHsLliuQv+NIaKwC3jKZhm0
        8X5oOcdH4fmDOsCTP5ykqsrDGg==
X-Google-Smtp-Source: APBJJlFWMqrZSd7R434rksbmHZdzfMht3VzmZAjhddWpsJvotnhmve2a41K+HTjtylzz7YkKhHjUkg==
X-Received: by 2002:a19:6447:0:b0:4fb:52f1:9ab4 with SMTP id b7-20020a196447000000b004fb52f19ab4mr702858lfj.50.1690355013734;
        Wed, 26 Jul 2023 00:03:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b005224f840130sm1572003edb.60.2023.07.26.00.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:03:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] AMR: dts: imx50-kobo-aura: switch to enable-gpios
Date:   Wed, 26 Jul 2023 09:03:18 +0200
Message-Id: <20230726070322.103871-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
References: <20230726070322.103871-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended name for enable GPIOs property in regulator-gpio is
"enable-gpios".  This is also required by bindings:

  imx50-kobo-aura.dtb: gpio-regulator: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
index 467db6b4ed7f..b1a6a9c58ac3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx50-kobo-aura.dts
@@ -73,7 +73,7 @@ sd2_vmmc: gpio-regulator {
 		states = <3300000 0>;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		enable-gpio = <&gpio4 12 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
 		startup-delay-us = <100000>;
 	};
 };
-- 
2.34.1

