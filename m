Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5396F7E8A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjKKJqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 04:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjKKJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 04:46:31 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496B3AAE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:46:27 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c72e275d96so38268171fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 01:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699695986; x=1700300786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVTtu6pYkR0UVEWdHben4O/LG/815s2RPg8sTMtWYG0=;
        b=aX/h6miS8GIX1ZqLQdTQnIJFOrRp+Yh+gJHkquxLun1HP6tNXdLEDOHj04ZNuyOS2o
         z3xY3EewxcCt54GTcuSNehVEFTngByzBt1LmSaBKjjWE93KY7MokriWwWDKIgZI8X07E
         6A5oFj8yjNAL0BySsjoL/R/PSr0gqC0Alvd32MsyXfv0OZ6F6WCw4P6aeCLD1tHs686F
         LS+XAR68BTfRTkAePV2tu4EbkluYEc2PZtzzXxtwEmgNpp1j/vR3vRrXN60TzXyYuI4z
         EdVa2S7BTDOStYrpn1K2PnbXnxIvf1x5wI793i2yFmLFDS4liXbkhnbSKxeoEAt8Shyv
         v9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699695986; x=1700300786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVTtu6pYkR0UVEWdHben4O/LG/815s2RPg8sTMtWYG0=;
        b=u5Tb+2B51Rfu0aAlF4OPiIv6+GVgOm8GY6ejYIcRqbL7u8epSUyyp3saX0aBsueghu
         yB0HP0hFtwKNpnh0rALWd/j6JlEXIRTOxlJ8reob7qUsrvT0kml6aZActiPBzJvXLd4+
         EdRnI5HuKfuyGDPvNvFStFgcV60qq7OkDBt7kg2K0NaeZ3f4PZVo6CF/90D3cxy2MttY
         cyoUdOvevjRBtC24yCKcb9pLwj/k/ZhKcNhf72MhgJLxSh9jKhl9E7vcmqhm77GwrNqt
         X861kwcGo2XnYPAOAB9S/jU3uGuGdKeayrGXhxu7CKSktqjeUcVb1e4jgDFvmB0mCevS
         57Tg==
X-Gm-Message-State: AOJu0YzEvLJ8LHrty6vZNooVCabLdBdaK95CKSGjgoq2r2kRybD5TR00
        44sNqlKSpulCl1uCFgoN3wXv9w==
X-Google-Smtp-Source: AGHT+IF0eidGM7AYzIhV9yHBXmFKLt3sGRz9bIZrJcfxgiQ2gg4MZdPcbDoNPd4tb0nwmba7lVRVRQ==
X-Received: by 2002:a2e:9915:0:b0:2c0:52e:eafa with SMTP id v21-20020a2e9915000000b002c0052eeafamr1064875lji.29.1699695985873;
        Sat, 11 Nov 2023 01:46:25 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id p37-20020a05600c1da500b004064ac107cfsm1695052wms.39.2023.11.11.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 01:46:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
Date:   Sat, 11 Nov 2023 10:46:23 +0100
Message-Id: <20231111094623.12476-1-krzysztof.kozlowski@linaro.org>
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

There is no "panic-indicator" default trigger but a property with that
name:

  qrb5165-rb5.dtb: leds: led-user4: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)

Fixes: b5cbd84e499a ("arm64: dts: qcom: qrb5165-rb5: Add onboard LED support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 3bd0c06e7315..e43f73f1be1b 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -64,8 +64,8 @@ led-user4 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8150_gpios 10 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "panic-indicator";
 			default-state = "off";
+			panic-indicator;
 		};
 
 		led-wlan {
-- 
2.34.1

