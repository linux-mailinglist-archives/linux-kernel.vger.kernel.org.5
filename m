Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD127687DF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjG3UUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjG3UT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:19:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE21723
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:19:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c0cb7285fso101707466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690748357; x=1691353157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=out/Q40ODaDczCCdOyB/xqmUqSDZmlaofXUk01AB65g=;
        b=fKxtcaSdcT8bH7VrE+QhAegnLRS8O6Nm9x/wziovFu8TnP53TX/XXLEqXZhnQKJbhB
         Nki8wL9phBqkEHDniP5QzuTTyn4QJLQxAixyocskvgebj8MQOzJI36YoQP14JJytQ7MU
         bvM3qv/a0RQ7ZCoa5t6ISrCQoum+Te1I4sTT3drdrM/lHb3/sjHu/lIddRe6g+8vRnBM
         xtecL9ak0fa25jBRS72ItWM0J0zPIbc+uJUq/iOqXVdA7T5RBUA1L+X+sGGpwNCJtI0P
         nIv2RwXybmZygEz68GYpsb6aCDv/OOeAr2XvWPOPa5cTpvASF46ELPb2BMWcgTysm49D
         nHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690748357; x=1691353157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=out/Q40ODaDczCCdOyB/xqmUqSDZmlaofXUk01AB65g=;
        b=XL0QJv3fFNrQQyNPwiINnvJAhCWQwCoNNjcY5Y7fwwT8Ll6dLR/Pb3FXAnMfJ4lurd
         4XzZb30kYfO1/wouMvB76dVTv7fv7y3d7GpsbQ1ItaC0VLZ4Fz4XteyDQwx/WHBbnQRB
         PJYI4gwQPBmbld2TDONvc5tBfGYFbvbn1jHfATxneLRCj8uFGm0hQ125bZECglLDu4TL
         vTOac/Z3v081ulfrCTfLkOvFT9iuyKDdybTS3demt4HDE+/ONb9GbVIXxCklot2d7Ijs
         4dRQQ4LOwBkFG9ZSHdMWcT0WlNcrTp5a2fW+FvnKY1M7F5ag+j/fNWGz504poamPqd5X
         rpXg==
X-Gm-Message-State: ABy/qLbhr0Vgw8Kb43ZSdsTmILkcd8QQSP64F91BUSSa4ToDTgzyQDY1
        ADFnx3Ir4Mtk8Xj4XwPdw5wrAg==
X-Google-Smtp-Source: APBJJlFvEEGxJ/hMAIyBj4/fO1CefNoL30i3WJ4oALs3HotLTPXCDb47HutWaE1MorBkVGXhw0AlOA==
X-Received: by 2002:a17:906:300f:b0:99b:c949:5ef9 with SMTP id 15-20020a170906300f00b0099bc9495ef9mr4853164ejz.11.1690748357349;
        Sun, 30 Jul 2023 13:19:17 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id gq15-20020a170906e24f00b00992b510089asm5066885ejb.84.2023.07.30.13.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 13:19:17 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845-enchilada: use 0 as speaker DAI cells
Date:   Sun, 30 Jul 2023 22:19:13 +0200
Message-Id: <20230730201913.70667-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230730201913.70667-1-krzysztof.kozlowski@linaro.org>
References: <20230730201913.70667-1-krzysztof.kozlowski@linaro.org>
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

MAX98927 speaker amplifier has only one DAI, so DAI cells can be just 0
(as expected by bindings).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index 62fe72ff3763..4005e04d998a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -39,7 +39,7 @@ &i2c4 {
 	max98927_codec: max98927@3a {
 		compatible = "maxim,max98927";
 		reg = <0x3a>;
-		#sound-dai-cells = <1>;
+		#sound-dai-cells = <0>;
 
 		pinctrl-0 = <&speaker_default>;
 		pinctrl-names = "default";
@@ -66,7 +66,7 @@ &sound {
 
 &speaker_playback_dai {
 	codec {
-		sound-dai = <&max98927_codec 0>;
+		sound-dai = <&max98927_codec>;
 	};
 };
 
-- 
2.34.1

