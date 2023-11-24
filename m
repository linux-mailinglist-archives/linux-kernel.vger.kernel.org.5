Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419197F7054
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjKXJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjKXJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:47:41 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4710F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:47:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00a9d677fcso230002566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819265; x=1701424065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+ThUuyBMc8tE0TTrcKzb0NqRa+0wf0OPRYLrcEY5ZA=;
        b=jBX/q0KPtbod539+8aRQWyi7xSGlzH21pfUXMdplLLp7IiduAMwi0F5fUdiiBgL0IG
         9/g6+jxFHbF2mbE+T4JHZ/8KAAc/imsQYmjLEqWm7+TEfUpWkSOQL2WNGZZ3FFaBAMoW
         7Qz4wdTiBfiKUD8JCj584r5npEwUeCupfyREk245w7MMvICf5nvi91di64W4xARpRlZP
         wJIoWvCwfnsPf9DQqHv5KJk3uh/Ei2qx3beJNa7w7xr32zTUj7z7qmfmlyeVQT/SztUm
         jiXxIJMJGcDclJgd20D6xoiZfhf8H3lHliOPngGAEA0FN5tMdzuGDXXI+fnb/RLeoa1w
         Tarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819265; x=1701424065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+ThUuyBMc8tE0TTrcKzb0NqRa+0wf0OPRYLrcEY5ZA=;
        b=AQ5EIcHUeFGsUCpDd6NF/lWA6uqn1Jv9C1+FAy/YlW+WS/NaBBdSwJj3sSt5OspPAt
         XoyjUbmEF6mGpJwD7iJkHCli6I+Qw7/gEJqT05+TLD5/cx8/JkHZvdGf0qeJIgsdv4bG
         l3eRUCZefXsjvKODEp0k+gJgN9d4FAAvTdmV7ChhUalTnBaIJsdm7q29zksot/V3aalP
         DG1wkKebbPv82fGSFpNBIOwA9Soc6H1SI+641TiMU03kDS7kJ0w+nV+/4R6Sto3Mb0T/
         Fh2+ANRGPy/38MSLJAIHZltZsFBuRMQEYGAe5oZt9ckHQmfplwKMQQbzIyHPT2Sp+GIR
         E7vA==
X-Gm-Message-State: AOJu0Yzc6WsTD2M5QXxNV5YVl5Ip5+ggNxzCK1n/6RWgIlGWDAIK/ZPb
        nPMqVlBNuQiY4q86FHdNOuAPDZzke7zcp/LKMSg=
X-Google-Smtp-Source: AGHT+IHiC5jOSc+vYNtalwC9n1F+/QoS4nBpsEIqcldYuy36Nbcsh8V81quxWNDRZ8JD4MVzRbIwMA==
X-Received: by 2002:a17:906:7f96:b0:9c2:a072:78c4 with SMTP id f22-20020a1709067f9600b009c2a07278c4mr1615067ejr.25.1700819264730;
        Fri, 24 Nov 2023 01:47:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b009de11bcbbcasm1859767ejb.175.2023.11.24.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:47:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: ti: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:47:38 +0100
Message-Id: <20231124094739.58163-1-krzysztof.kozlowski@linaro.org>
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

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 9868c7049bfb..d6a7ae086244 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -671,7 +671,7 @@ exp1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names	= "BOARDID_EEPROM_WP", "CAN_STB", "GPIO_uSD_PWR_EN",
+		gpio-line-names = "BOARDID_EEPROM_WP", "CAN_STB", "GPIO_uSD_PWR_EN",
 				"IO_EXP_MCU_RGMII_RST#", "IO_EXP_PCIe0_4L_PERST#",
 				"IO_EXP_PCIe1_M.2_RTSz", "IO_EXP_PCIe3_M.2_RTSz",
 				"PM_INA_BUS_EN", "ENET1_EXP_PWRDN", "EXP1_ENET_RSTz",
-- 
2.34.1

