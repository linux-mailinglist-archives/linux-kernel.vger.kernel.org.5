Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B257798CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjHKUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbjHKUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431012D70
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso3811111e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691786926; x=1692391726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zbe6rwLIqAzfnDpJ3MJUpo4QwqSNk+XAj+k3Lr/1SgI=;
        b=X46Gf6vMDFNYaY53fAVYDltZHoWEgQf3ko2XbNsFQKFeym06D38HqXIm+JxdRueYC2
         8RYmby4BSsY7RzedpPRe57xxNb9Rj9WiCC8mnk+hisEkCp6Qp/gCNxi4g7C4FWhXTkWJ
         FUKnCm0zjjjzbL0dKw48zuKSNSYub280HkDSv/9Lku3xvG/6ttC/0PA2Bl1HFvMXy8ni
         NiH+jM1MDNoFs0SmNJELTHMnPFMyzXt1Yiolh0bG35aw+4z91vIoIaLwKyNTGYdM8SvR
         /pQkuO5b1jQhVqs20lNe5B8lNRNceHUbKGKRQBhKWsFbGcygmLyWgdAgBzeaoUw9EeVb
         WDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786926; x=1692391726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zbe6rwLIqAzfnDpJ3MJUpo4QwqSNk+XAj+k3Lr/1SgI=;
        b=fFwhmJp1gYAp8fl+KZKE+J7P8n8Vr1UjU8S1EoeIZqnXd2RJ/7mWnVRqUs38iC0Yo8
         s0wVehMP0OoHWEkHgazqCnjan62MAXqVvzaFhZoX3HWbpvTZliA7ixsPYZYMDrNiRCFY
         fqkGv0Tui3YeC4MHvZwUlIMJ25oLiQLw047pNYT+unxMR1WZSr2ZfV0Fr3vrSiJigvrB
         QsfB568oq8FhZOnMFfrayalxXzVAcIbN0/1a5dHDyNKVFdO/I+Ivy/kiXruI/dd5filj
         WPIM+D1GUb3jWGwpqLVKq0BCAslS9sjnED0ij9GxQSexuT5aPS5d7Gw+0FX8DETFipbg
         4csg==
X-Gm-Message-State: AOJu0Yx0bP+Dgxu6jA4LZeZMsfp02p/LUJFn/mjEypJVOTRAxhaFy5jo
        ris3SDwGopuVeML4wEjt4Rd49Q==
X-Google-Smtp-Source: AGHT+IE28w/RRIwwZ6DOTisDKzxi/o9RRQAr6KDMUn21Z1qmRFMoHuIcy1IeSg6C5Q0r3Lu8//8+8g==
X-Received: by 2002:a05:6512:104b:b0:4fe:1a99:45e3 with SMTP id c11-20020a056512104b00b004fe1a9945e3mr2722908lfb.30.1691786926671;
        Fri, 11 Aug 2023 13:48:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w1-20020ac24421000000b004fe8d684172sm843603lfl.234.2023.08.11.13.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:48:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 22:48:38 +0200
Subject: [PATCH 5/6] arm64: dts: qcom: sdm670: Hook up PDC as wakeup-parent
 of TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-tlmm_wakeup-v1-5-5616a7da1fff@linaro.org>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691786918; l=749;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=noEdJDXBq+yIg8vLz/heyQKfgGe2fGcgrZnodZXu4VU=;
 b=JcI1HqpLHV7+mVhfa+Rgpgw8Ur/EObC7sGINBPp/i7We3U3MqoU9hgNmah+LsiEc3xETe95b6
 QI0TGXgnKsECQUAC7VN6Cym1/rjKj/svvCl9LD/IL6h7p4aLanDmQnb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some TLMM pins are wakeup-capable. Describe the relationship between
these two peripherals to enable this functionality.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index da10f0a6d92e..a2354fe94d98 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -969,6 +969,7 @@ tlmm: pinctrl@3400000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 151>;
+			wakeup-parent = <&pdc>;
 
 			qup_i2c0_default: qup-i2c0-default-state {
 				pins = "gpio0", "gpio1";

-- 
2.41.0

