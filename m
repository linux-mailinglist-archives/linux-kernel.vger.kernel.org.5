Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265DE762C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjGZHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGZHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:04:23 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D552D196
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:02:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fe70f21bso1000889666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690354966; x=1690959766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YecLEf8qZprCEU7ERZ9Wc6P5u7z1nwmeCE8OvgcZdt0=;
        b=x1if1as6W99o+6uXX8NnHX/RMLQ27OspYAaqhE7gnduJ8Sso/MCinYGaz2wiW1O6Xs
         u0MkL+1SOr5L1h03uxgGMksTZ3TkqAg0pSgFkRKAP8CPai9nRNf7yQ5/YTmM/SmDie/W
         X7GPSGAJZ6SZ6uR8kEvU7siFKJdYJfMR1ZQsF8EAhnLUl24I/mB8wtLPmuDO0Czkecom
         ylQlnDKYvKg7iRJwcDO0rRu/EoJ9OQOONPEM+bQflXXdJ/iHO009pKZ+L/sYyt4TB20w
         G0wix0WrIHcqBnsYvp1tmRD3KofOSV6iBwQP2FvY0A/jxXu9a2fOI52BPxyMUMmFPZ27
         hwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690354966; x=1690959766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YecLEf8qZprCEU7ERZ9Wc6P5u7z1nwmeCE8OvgcZdt0=;
        b=HwWNgeLeDoOg9ncD5Jb39wZW6yDlIpfsR5P4fxY1Qpyt+FAUb/Ez1xz/TYMUiI7MHq
         04ZLBUtWrZPoPKy5QUPmJ29pKeNtY2CelzM2LI2RmqOXgnHUakDkJF1x6wqWeNKys+wV
         v6r4krs6ZmrzQu5FYUrni++nUvw9dVJ9mkbwTqitJIOX1d+lJh/H7B5YKL7S0PqR/4b7
         X+eDHoYV1jJ2mcKSC0ls+sttkMwbCRhmeGLkMb1vSbsmXDq3GjTLeafHV5TseiPa/uKm
         vmmlHGzhBB3/r9W3puHfXI3uMH0tt0gw+OHW+PF4D1joX+qmzLeUE9C62blojFQsHcrJ
         KPcA==
X-Gm-Message-State: ABy/qLaIPnFG/8EoVtipVDIiL90p3wQM9ake/niS124h7ok6pHxIUncs
        AXWx7fPr7n+ggV1WEgcY34hUfA==
X-Google-Smtp-Source: APBJJlHvdJs2n1j0lsHu5vxNDRHqv8G7d/t6TqS0C9zPnPwi9a+WpMhy76XTDv1NOzIDpeFfDB0pGg==
X-Received: by 2002:a17:906:539a:b0:994:5396:e32c with SMTP id g26-20020a170906539a00b009945396e32cmr880369ejo.3.1690354966393;
        Wed, 26 Jul 2023 00:02:46 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id si2-20020a170906cec200b0099304c10fd3sm9180093ejb.196.2023.07.26.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 00:02:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] AMR: dts: renesas: r8a7740-armadillo: switch to enable-gpios
Date:   Wed, 26 Jul 2023 09:02:41 +0200
Message-Id: <20230726070241.103545-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  r8a7740-armadillo800eva.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
index fa09295052c6..d21e00e1f401 100644
--- a/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/renesas/r8a7740-armadillo800eva.dts
@@ -58,7 +58,7 @@ vccq_sdhi0: regulator-vccq-sdhi0 {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_sdhi0>;
 
-		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pfc 74 GPIO_ACTIVE_HIGH>;
 		gpios = <&pfc 17 GPIO_ACTIVE_HIGH>;
 		states = <3300000 0>, <1800000 1>;
 
-- 
2.34.1

