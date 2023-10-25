Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E249A7D6959
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbjJYKpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbjJYKpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:45:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D2130;
        Wed, 25 Oct 2023 03:45:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9becde9ea7bso157075466b.0;
        Wed, 25 Oct 2023 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698230703; x=1698835503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5Q/ILeNPwJV2QjahLVWKif6XkSVenjAn/qwU0ighgI=;
        b=TCeB9jmfs1mbxcE4FVTNTcSWsRrkn26YIpP/aaX0JaTb+qbjplZiRgncaL3MObP/Id
         e0xmWiapIHlB8kQ9O1DqJxGMBA5fFvV1oX39ipOAI5J9WtpPYD+jgXRDwEstq2ZH5pWJ
         kJXQaZzO2Dx/uv8XQ+wMjDoukpoYW8Dxw4W6KPAHhtqm0rHrU4vptsIUQzz5xX8KyVB6
         vZ4AdHDquJT5YGSzsbtrarILRLqC5hgZ5VJjr0bssRgbcDLNN/qUKtkbeQp3RpizRaVd
         SYy3MZVFTtBtM3tl+ODZal9phcvDXRA3Bi9pVv3hUsfcN7gaFSeN/JK7opNGGmc9mXR/
         U11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230703; x=1698835503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5Q/ILeNPwJV2QjahLVWKif6XkSVenjAn/qwU0ighgI=;
        b=fR/KHOW59I4ON2C2QygnU6r7UI2yTVuQt7LZ2QvFoCqlA6YHB7J/AzxHP83fpbh5sW
         92V9Ma9IRyTo1LWNF7tlfdG8SmBByNA00a3RXGjCMnXHJmP8sTOhXtvTFH7RQ8pcTl4B
         gtzq8q0FvFkDV+1U0QEsNQrOlemDs7OuAwwRZ4YsbW0cbfuzGyZhafZTgjTg86i3rCdr
         4+/44xsuKcJALPufyBbMQ4g8ckIpWIrEizRHDm7S6DxxziPTYk4NPpCrxXqdOzOUXEwG
         /hkvY54DOiFhwFtcpQZQ+R0g18EYpckvero8bxOYBc1H2tWQPNSaddzRM7B4rmgRqg2Y
         odkg==
X-Gm-Message-State: AOJu0YwdWQhVCsNQEl7Ux2M6/8C/hlz/m2uMtoPZvz9QK/WDDw3VHimy
        K3fG+WRB6ZLfj0wOQqcpQFc=
X-Google-Smtp-Source: AGHT+IHzKyCpvZWhaCMz6XJErxrbVu8BO1pTjJeTxOZVkEtgWaMQ1uDkJotO6VTnitq2RlPEvUYJQg==
X-Received: by 2002:a17:907:7212:b0:9bd:d405:4e8a with SMTP id dr18-20020a170907721200b009bdd4054e8amr13626532ejc.17.1698230703511;
        Wed, 25 Oct 2023 03:45:03 -0700 (PDT)
Received: from fedora.. (dh207-97-46.xnet.hr. [88.207.97.46])
        by smtp.googlemail.com with ESMTPSA id t11-20020a1709066bcb00b009be14e5cd54sm9626292ejs.57.2023.10.25.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:45:02 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq6018: add USB power domains
Date:   Wed, 25 Oct 2023 12:44:11 +0200
Message-ID: <20231025104457.628109-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025104457.628109-1-robimarko@gmail.com>
References: <20231025104457.628109-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB power domains provided by GCC GDSCs.
Add the required #power-domain-cells to the GCC as well.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 846cd73c7436b..720f1eeaf0443 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -402,6 +402,7 @@ gcc: gcc@1800000 {
 			clocks = <&xo>, <&sleep_clk>;
 			clock-names = "xo", "sleep_clk";
 			#clock-cells = <1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 		};
 
@@ -433,6 +434,9 @@ usb2: usb@70f8800 {
 					  <&gcc GCC_USB1_MOCK_UTMI_CLK>;
 			assigned-clock-rates = <133330000>,
 					       <24000000>;
+
+			power-domains = <&gcc USB1_GDSC>;
+
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
@@ -581,6 +585,8 @@ usb3: usb@8af8800 {
 					       <133330000>,
 					       <20000000>;
 
+			power-domains = <&gcc USB0_GDSC>;
+
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
-- 
2.41.0

