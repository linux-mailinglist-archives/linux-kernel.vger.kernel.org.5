Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CBD7E8BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjKKQmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjKKQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:42:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C293AA8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so4760382a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699720957; x=1700325757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZtZpqpD7PI5hInoKuA8AJf2BgTNbdfTd6JZaJSUskY=;
        b=eIKK1R08q4FHpu5Gm6lTseOE0osL7GrTQFJMw32k8W+FI8ED659t7KY1BTuwChPLmW
         C4ZdJGgjXHczdPbBv+0YpmKcpDGRDvobhv+XvkDyyLHtAipMsbfF929OeOhfiU0JpuAu
         zytR+djXVUD8SozMmT7PBFP8ghUJQi+oqcE17wnvtsVJxqFPr24cSpRSuQgoaK4Uk7Fw
         /wvSvk5ByGlROvuBINvQNs9ZJ5PRBpgldm+0lO8B1eGUiKOKSCSybBTm1QCUjdD33yB6
         2JG6VvHohuawx38e22UAHKSQDDTew91VHPasAcK4+hHil7sHCAXgaG2VaRPCOOiF4zQ2
         1ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720957; x=1700325757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZtZpqpD7PI5hInoKuA8AJf2BgTNbdfTd6JZaJSUskY=;
        b=OpRL31cXM5flLhpo+mRIJQ2Xo1txM2HAPPL6SIWndb0ME88NSM/gDKJXB2xLa7jHvm
         SNooptZZgcH+uREC+wBqE/PqYn5UMqcC7PbEnhSqGpMnQedfX7r5i53ugrJ7+87Xvgm/
         trZKuZw+EaggQR3aVtdkSqXuzu1yF/LhD2GZcxKcCveDtYVBheYxxzAzAL2wyiRVtVDD
         phinupc9QAE+SHFF8aIUhFGBC2/4F3eynXlOuQffQfxLzB1S6n9+VDCxUwMYvwzqFg8U
         HDrKwWHeFH/iWQB6XuYnDLUYcHQurCN2bFMXChtxS9fUHFlQFTaOZvZKVVpDA2wU5/8D
         sNQA==
X-Gm-Message-State: AOJu0YzckFfvfIGA+ocpufmsF78M8FJqKXfuV544UT3k4EAxIPdWlbah
        MIqFdzCPEq/sPNPUq/JhKFWYqw==
X-Google-Smtp-Source: AGHT+IGAtPcwRvSatgGms7htwrIxAVeJwcy61t1r/5P1aZ1Z1l/XVtxkY39FmlIle/QrmM2KsCXaOg==
X-Received: by 2002:a05:6402:1001:b0:533:c75a:6f6 with SMTP id c1-20020a056402100100b00533c75a06f6mr1813319edu.12.1699720957548;
        Sat, 11 Nov 2023 08:42:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0053dd8898f75sm1161917edo.81.2023.11.11.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:42:37 -0800 (PST)
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
Subject: [PATCH 4/6] arm64: dts: qcom: sm6115: align mem timer size cells with bindings
Date:   Sat, 11 Nov 2023 17:42:27 +0100
Message-Id: <20231111164229.63803-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
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

Commit 70d1e09ebf19 ("arm64: dts: qcom: sm6115: Use 64 bit addressing")
converted all addresses to 64-bit addressing, but the ARMv7 memory
mapped architected timer bindings expect sizes up to 32-bit.  Keep
64-bit addressing but change size of memory mapping to 32-bit
(size-cells=1) and adjust the ranges to match this.

This fixes dtbs_check warnings like:

  sm6115p-lenovo-j606f.dtb: timer@f120000: #size-cells:0:0: 1 was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I hope I got the ranges right. Not tested on hardware.
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 20dec687fa3b..ed6065ccd214 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2559,54 +2559,54 @@ timer@f120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x0f120000 0x0 0x1000>;
 			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x0 0x0 0x20000000>;
 			clock-frequency = <19200000>;
 
 			frame@f121000 {
-				reg = <0x0 0x0f121000 0x0 0x1000>, <0x0 0x0f122000 0x0 0x1000>;
+				reg = <0x0 0x0f121000 0x1000>, <0x0 0x0f122000 0x1000>;
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			frame@f123000 {
-				reg = <0x0 0x0f123000 0x0 0x1000>;
+				reg = <0x0 0x0f123000 0x1000>;
 				frame-number = <1>;
 				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f124000 {
-				reg = <0x0 0x0f124000 0x0 0x1000>;
+				reg = <0x0 0x0f124000 0x1000>;
 				frame-number = <2>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f125000 {
-				reg = <0x0 0x0f125000 0x0 0x1000>;
+				reg = <0x0 0x0f125000 0x1000>;
 				frame-number = <3>;
 				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f126000 {
-				reg = <0x0 0x0f126000 0x0 0x1000>;
+				reg = <0x0 0x0f126000 0x1000>;
 				frame-number = <4>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f127000 {
-				reg = <0x0 0x0f127000 0x0 0x1000>;
+				reg = <0x0 0x0f127000 0x1000>;
 				frame-number = <5>;
 				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			frame@f128000 {
-				reg = <0x0 0x0f128000 0x0 0x1000>;
+				reg = <0x0 0x0f128000 0x1000>;
 				frame-number = <6>;
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
-- 
2.34.1

