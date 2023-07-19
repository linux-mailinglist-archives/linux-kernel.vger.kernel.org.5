Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DE9759E91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGST2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjGST2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:28:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A381FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:28:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9922d6f003cso13077666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689794896; x=1692386896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcNmIsuW97qQDEgueal6oZwyfTvcbga5wSv8p96tsDE=;
        b=AeiVpxzYqw1J8CS8ahzshvssmNLZoPlbRPOo3TE+s8oOGabZx7kYQEzFJTJxvFm6NN
         2eJOZRGqri+1pGvHfmmqo0VWoduIACmzb7LIHYfavPRma3b49mzs+G0WmXUNjbmg1F4r
         AT9KwRb+mSAfjHETLFzacqSPXjpuby7p9V10CmYNx/I3V998/6YnTN00nAsfwPgm1G3d
         UDFjeUynmwYCD+DE8rOmBg/FfmU63ZsYt7F0SeWkGCg8OJla7FHncHhl7AoYjyffobfz
         qzmDc5rz/tsA8feYW6Wukpw0FLEEscGL5Lm9si/qztMPRUTaALAXFfwxb7dhKnd8T+BT
         ia5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794896; x=1692386896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNmIsuW97qQDEgueal6oZwyfTvcbga5wSv8p96tsDE=;
        b=GICQ2zrTQk+jKhNfGL0EvU41gGELTMO3sxTZ2WqDT6Gzj+5qtSxRPjU8ogZ67dzfGr
         v2MpEnqfev4XvZrDaLwscrim002+UMpTXF9uOw0z14Vqvk9u5Hq1CDaG0Pp7jV83XSxU
         sND2bxvQ73gJoP9+5JtkHMSyXxKKaPPyl9ETRXgHv24oqSe0PCMhYB4WOV2SgWmVXOsw
         aeAE8LufDfJyFO4ZXqavNqqozIl2CPI5IwrEInsAwGv3EtaTWGyoxAiiVx39mUqq4WTH
         7+psAgSJQNHI6nl2uIBeddK79kRI/RcqqdfmqzEkf/C3JrGta5qWvshdpwqiPnIghTIm
         b0nQ==
X-Gm-Message-State: ABy/qLZMLXJruLUrzk2anv9WfxAhecWmaCe7wjR0z5pQ9tl2i+KFROst
        +xYdyAK2ILLyaX/vrXmck7cU7g==
X-Google-Smtp-Source: APBJJlEhpxysmSlsUa5KsviCsOAPYZaY2KzsGJpRjCmWaqkRbLK3f4l4BX361s9nVHpem2OwAYRbtg==
X-Received: by 2002:a17:906:151:b0:992:ef60:aae0 with SMTP id 17-20020a170906015100b00992ef60aae0mr3392724ejh.54.1689794896644;
        Wed, 19 Jul 2023 12:28:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906119a00b00991e2b5a27dsm2720966eja.37.2023.07.19.12.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:28:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8350: add APR and LPASS TLMM
Date:   Wed, 19 Jul 2023 21:28:09 +0200
Message-Id: <20230719192809.434709-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
References: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio-related nodes: the APR in the ADSP (same as on SM8250) and
LPASS TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Bindings for SM8350:
https://lore.kernel.org/linux-arm-msm/20230616185742.2250452-1-krzysztof.kozlowski@linaro.org/T/#t

Changes in v2:
1. Use "0" as size in "reg" (Konrad).
2. Add missing blank lines between child nodes (Konrad).
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 85 ++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 557a3d8e889b..84044d0610fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -15,7 +15,9 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 
@@ -1814,6 +1816,20 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		lpass_tlmm: pinctrl@33c0000 {
+			compatible = "qcom,sm8350-lpass-lpi-pinctrl";
+			reg = <0 0x033c0000 0 0x20000>,
+			      <0 0x03550000 0 0x10000>;
+
+			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 15>;
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-660.1", "qcom,adreno";
 
@@ -3223,6 +3239,75 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1801 0x0>;
+
+							dai@0 {
+								reg = <0>;
+							};
+
+							dai@1 {
+								reg = <1>;
+							};
+
+							dai@2 {
+								reg = <2>;
+							};
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";
-- 
2.34.1

