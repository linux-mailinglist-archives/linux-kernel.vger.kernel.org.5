Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F680394C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343835AbjLDP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjLDP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:57:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9A7C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:57:50 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a18b478e4e9so586233966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701705469; x=1702310269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IE69eKUaclA1I+ClHsriNEM4oABBoVrGfcljQTrsZuY=;
        b=sF4kk+alDLkd/hq4ZWOvrArvd/VYEFkfWaf2yGMgy3KinMPvfHjGK0n7iU1hs5JmZr
         KVV8j1r/bjj9fbOkeKW+YeZ3J+n8NStpvo/yH7w9nyQloXR3+abOCDeGDsieaPCA28Xu
         ZOP8b+er0sHEmPIjTlN/MlUY/eoi1T/FILtiAlSB+pTNlxT6ODFkhqqXkzEs0eV/gEsc
         sHJdnBuW5hhUCAfGJllruIOQ7pd0An9b0oTvzvuKUDadZ4l1FOzT2ExDEwH6cl9zG3LK
         gxUfxj73uQK/m5hJ6jL6og6NSQ1DTGTt/bgBwcNhEcQVy8UQKEBKOqbwVfo42HxB6M4C
         2XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705469; x=1702310269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE69eKUaclA1I+ClHsriNEM4oABBoVrGfcljQTrsZuY=;
        b=ur7ruPdd9iQZzIL8KuJMrY/6f+8HW3lrkBGEpaj0+NYSruw+hhrkCsww74H3KhfSa6
         xqxkYFJjWoi4UYw3ix/bTVR/3OeK9ieKPelMOAvdL1RXlBlyPY+UoZa49+6WhhGNP8gV
         RTmsA4BIazVNQkh+rn8DpgqHYTdhLr+3kNugpaSkjSvn2W23oSlDr3VnEA70GMYJ9oPM
         U0+OkLxNBM3ZqvZBXNdBjeDiqVOZ9KcqBJIZlmuImmIXSV4UN08HYsV9Gjr2/y27QGJ0
         N12zFEWDNvktXJ2GnuVm0D4fpd4IgwfdjB/SBXSQ/1c1qlhYzyWVAbSGhiK/pu4daiLb
         K7hQ==
X-Gm-Message-State: AOJu0Yx/lIvd6B2Jr1Z+21ENFOV1nPrggtMmCMUikhoFcfAun4EohKrf
        OKFpNdqxbyEPo3bSjkneCNSLig==
X-Google-Smtp-Source: AGHT+IHOI+4vYdxqb5izumtihzMzU/uShXgmoAJB4b1wtT+GLPyhUbfA4tz0MAun8Cc6GYKblWuxng==
X-Received: by 2002:a17:906:3f88:b0:a02:a2cc:66b8 with SMTP id b8-20020a1709063f8800b00a02a2cc66b8mr2881716ejj.14.1701705469161;
        Mon, 04 Dec 2023 07:57:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060e5300b009a19701e7b5sm5429304eji.96.2023.12.04.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:57:48 -0800 (PST)
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
Subject: [PATCH v2 1/5] arm64: dts: qcom: sm8650: add ADSP GPR
Date:   Mon,  4 Dec 2023 16:57:42 +0100
Message-Id: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Changes in v2:
1. bedais/dais order (Konrad)
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 41dfa5e19a15..8d327f83edc8 100644
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
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1001 0x80>,
+								 <&apps_smmu 0x1061 0x0>;
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

