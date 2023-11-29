Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D217FD7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjK2NWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjK2NWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:22:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536121990
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso1677464a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701264173; x=1701868973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8cKP8tRfrnJA83704gxkzdOYrlmQTMNSgQeXlvMQfk=;
        b=RbDR8dYcHiCTBz0d01OTO+c+eOfW23uwsI9HwIng3gsuLf3xtHa/8vP1AlpD095NmH
         R6vmGA3KZGH4/OLNWf5i7hFSoPIryrnsMWmV8jAkUnfkq8tlWFQwL1vElERLIAg4dvHq
         OLKZIVOCPgwcWsFSGGvxvYzMb3LFy7cXB9lmniSBTLX0mENS/mKu57Bz+ZuCAgGJxCDc
         Rx+gzm5duLiCZM8VXnKNGDaWHKcSFl4LaXlcg5fEHQ5Q6EGvJJiopmd1+rbNiuvaTX9n
         sCLd9W6kLV34cRM9fqkhJIwk5ngE1jTgGuoJtZ3xmr5zPTDS+TQ52KzYoZ5nmvWtJm5x
         NJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264173; x=1701868973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8cKP8tRfrnJA83704gxkzdOYrlmQTMNSgQeXlvMQfk=;
        b=dAI20AGKAZUNfYGFoo59DrQRFtkKfz3QeZU2NgURoyWiydruEZ9izY7ClSA6fuyRh0
         je6kafaAlu+BwaFj1Ra+7+mMNJy9GcC/qG9wn0XOJXIbZ1Y3GJuiAEaVQvDOWUW0RGUE
         qHzO3EfTOU+OIbzpUHeFD+LqIU2CwhOjxt/NdJy0Mqo8cCCGkzHMnagjXoqTq7o+u7Mg
         bDedMFDiA2JOxxisp5WghzM0Q6isoHm+vBkt4a9GyWsDjJ+ABPKLuOkVnPAjHtTjjPAt
         11RkyPTkxoRIPzN+WSZrrymONvluxZmAoMIAFdCvI3e6a2prdVPGLwsGalUN8Tb6dddP
         JKKw==
X-Gm-Message-State: AOJu0Yy0auTy+Ln07VxIctkTth8uG2RDDuMcvPlKRpHwlfNF69mt2Iku
        RWOr9ifQolIuow1M+QOXE9NwPw==
X-Google-Smtp-Source: AGHT+IECkp9Gbm6qzKkc7lwm9UVyumqJ4XPBZZczUNpzbW2fxEIkSaFfkE7RSlm6QoOYEMMEqbPhSg==
X-Received: by 2002:a17:906:b88d:b0:9ae:50ec:bd81 with SMTP id hb13-20020a170906b88d00b009ae50ecbd81mr17811111ejb.21.1701264172765;
        Wed, 29 Nov 2023 05:22:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm7844842ejc.22.2023.11.29.05.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:22:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 1/5] arm64: dts: qcom: sm8650: add ADSP GPR
Date:   Wed, 29 Nov 2023 14:22:43 +0100
Message-Id: <20231129132247.63721-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129132247.63721-1-krzysztof.kozlowski@linaro.org>
References: <20231129132247.63721-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ADSP Generic Packet Router (GPR) device node as part of audio
subsystem in Qualcomm SM8650 SoC.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 41dfa5e19a15..9df79297dad7 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4326,6 +4326,46 @@ fastrpc {
 					#address-cells = <1>;
 					#size-cells = <0>;
 				};
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1001 0x80>,
+								 <&apps_smmu 0x1061 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
 			};
 		};
 
-- 
2.34.1

