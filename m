Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F6A779921
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjHKVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjHKVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:01:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9608BE7E;
        Fri, 11 Aug 2023 14:01:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c1d03e124so309364566b.2;
        Fri, 11 Aug 2023 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691787708; x=1692392508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DYyGWbRtCO4yoK4SpfLbt8Gh2hUExhG65bK4fLynWs=;
        b=FMXr7eZGhmfYRJY0IK5IWx2P9eQ3rVyjUhTYxy0OXQoePLMH7Yti5dzRE2Jn3l6r0b
         kW9yjCgwIxuRHM8X4R35Y+TbWL4dNJtMY/f3YPV0yvLXvuWjhdfAKli6aqZXCgxairZJ
         HB5Yd8+3UWRjnPQ/4hOQgIhZNFttgvoNJm/vJ5NnSMM3nFJbmmBSvZUJOHnxX0fNbNed
         MHd7IBI6UWEBM6TxYe3PNgsMWuVw/vEn7nWWc+g4o7KZDscmf/RqkgZhH02uMp3k1Arb
         9nBuGOW1vovPpcVOWZCSIdhdyP9epr5+UpS+4ek7V9yMVU4OZ7Ab3GeMYhSe0W8GvgBA
         OkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691787708; x=1692392508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DYyGWbRtCO4yoK4SpfLbt8Gh2hUExhG65bK4fLynWs=;
        b=c/FlY7pKmHizVHo7qECcuYnbhr4mqJkZILIO4s5n8TxD2VrBKvTu1UDGUf12GJqkGj
         IF6O54qemx1St7SR5lxM9hFCZuiGVqxuGZVnr2yaVyP+xYNGrO11F3ZJeaxcuDmEnlLj
         4nIobjtV3bcCOjriy0VasafduEVI29EqL0SqWZTHnJoJLOufkqSS1lRF5Aghd/YhsYTT
         OViq4i5fLTjK8nlkWTDLUbdnMF5XN0+uLEsai77h/dSDHibtrLM1ajc7pGsgMTEzT2R2
         hPM4wsEg1j/7WxSVS+QdTHhm/f9wW0SdO0sMDhtgv3kL/7UEogivfE8H+4YOEkeRpo19
         qH3A==
X-Gm-Message-State: AOJu0YwceViE4GbcdH2Y8niVzv7mO+MX7h1QomvbRkgUstqwOOP4Qm2n
        LTll2Vuf8ekkBTjHzdccVm8=
X-Google-Smtp-Source: AGHT+IFb7wDhNodcMalFrwvQqlCnFZSqMr/l8ySqyls/nBvv3xEJCy0Z65gDeSPpPeu0UJZ2H8jdyw==
X-Received: by 2002:a17:907:2beb:b0:993:f9d4:eab3 with SMTP id gv43-20020a1709072beb00b00993f9d4eab3mr2724971ejc.18.1691787707834;
        Fri, 11 Aug 2023 14:01:47 -0700 (PDT)
Received: from fedora.. ([188.252.220.253])
        by smtp.googlemail.com with ESMTPSA id d3-20020a1709063ec300b0099bcb44493fsm2694907ejj.147.2023.08.11.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 14:01:46 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node with bindings
Date:   Fri, 11 Aug 2023 23:01:03 +0200
Message-ID: <20230811210142.403160-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811210142.403160-1-robimarko@gmail.com>
References: <20230811210142.403160-1-robimarko@gmail.com>
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

Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
as they should be under the partitions subnode and use the generic
jedec,spi-nor compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
index 0714616c9e45..f7ac8f9d0b6f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019-ap.dk01.1.dtsi
@@ -75,11 +75,9 @@ &blsp1_spi1 {
 	status = "okay";
 	cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>;
 
-	mx25l25635e@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
+	flash@0 {
 		reg = <0>;
-		compatible = "mx25l25635e";
+		compatible = "jedec,spi-nor";
 		spi-max-frequency = <24000000>;
 	};
 };
-- 
2.41.0

