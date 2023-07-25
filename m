Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E24761BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGYO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjGYO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:27:39 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84BB2680
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:27:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9924ac01f98so949726566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690295226; x=1690900026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hU8lSjQ6M9yd48ULuSbmUnhhWGLQGOdsfRMZvGDHUYg=;
        b=qtCYt7lSSrdZZ8iQAVofiekLVvwLzUwagNxRSeFzg960F3nJujWU25uL4zNn/svJ43
         KvBY7KqPvhZRA/Og/tInPY0nPEozrpR4/etavmBxkjejRJdO7HuxwMMOl9Mg4/4oJzRu
         izdUVCpDnvIsmGGYfMao9YyEIJ3ftaz9NHcg8tr2zLAZr1inbVBx1QbVZJMQxlaDOwWB
         hEnO4gJABuwF3kouzb8hIaNxEEkpRgcX6H6Gd+5XEVViB0J5ZYaa/hlMS7jEKJfj8tt+
         VizO7MUsM7bAAWLtnFH90JrogdmuG5VoDogTrS4nRbTbWJvAA2tRoXzNxjMDE2aEI1sG
         S/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295226; x=1690900026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU8lSjQ6M9yd48ULuSbmUnhhWGLQGOdsfRMZvGDHUYg=;
        b=kToELL0noveGieTv+Qd9vcPA2O0enW0WLnVDrjtZB4Pb70c8X3GOkHm2J8tieNarB2
         0aOEW93Cjguc0QerRFy8KOkhvSBSsejpy+3+cZHA9VOmHVtD7VRaWh3KKMjRhMTtjkAc
         HIz5UaLv5o67Ha9LdEDMMya+ZfZrZJQzkQ1XHpuiwG7MfRiWANfRQq6sDguD8cOvxI/h
         5mg6kCXfc5le+7/PZTynOk+0hqoVy9tOIFrhjW49mQpJsfIhNAf6wAr28flQKVVHUbzt
         +bvQkR+2Q13YGlIXFnhilyfDFTkmaCpH2ZR/i5w2ub2tAZAwMQmRvlFgqMCW6+ZFBqHD
         7Lyg==
X-Gm-Message-State: ABy/qLaAB/mmtV5svStNikIUuxIBdmXj6eu7kR5IsjTWM5Oazb7jXQF5
        udxjwWXIFWDTtHj9WKXoXjd7jQ==
X-Google-Smtp-Source: APBJJlHFnc3Sz1DBUjgwnuSooCSHfG5qz85DMBZy79oDPNK7BX03+ekkae7x1UZx4sl9fM+H2KxFXA==
X-Received: by 2002:a17:907:760d:b0:993:e752:1a6a with SMTP id jx13-20020a170907760d00b00993e7521a6amr13195406ejc.21.1690295226116;
        Tue, 25 Jul 2023 07:27:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm8201027ejd.164.2023.07.25.07.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:27:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amlogic: meson-g12b-bananapi: switch to enable-gpios
Date:   Tue, 25 Jul 2023 16:27:03 +0200
Message-Id: <20230725142703.157547-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recommended name for enable GPIOs property in regulator-gpio is
enable-gpios.  This is also required by bindings:

  meson-g12b-bananapi-cm4-cm4io.dtb: regulator-vddio-c: Unevaluated properties are not allowed ('enable-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
index 97e522921b06..86adc1423385 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
@@ -56,7 +56,7 @@ vddio_c: regulator-vddio-c {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		enable-gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
+		enable-gpios = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.34.1

