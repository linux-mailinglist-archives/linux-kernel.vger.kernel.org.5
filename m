Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE247E8F16
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 09:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjKLIBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 03:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKLIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 03:01:45 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B607230CB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:42 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso4625283e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699776101; x=1700380901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YkEVGPbnVHL4DFLlBtIPj1GLSIh3cepxMx8cCgbs64=;
        b=cBmwDQGrTkmSdSKV6sa+N1dNC1QkNQchWndIs2HhImACMyeNPD4C7O7WwAMpGS1BX2
         9sjIL3vx6yNhlOdrJ5HeOWqB/rZOxPIJX4ocoI+rKHi7zBFIPQZepaZZyxpQSlPbif1l
         1+ACwjiQ2gpGiFE/3kgy7AHzI0dBGjFUjda8hWnh3s2sCS09Zs1ARFVJkQtIDnZsUhmJ
         zo1ogYtdkZDMiS9yco9pT4privbXvIUAgF10MRGghvRktkq4GXnk8Z5DkToxgNoBP7C8
         37pAU7/x1eyphQbauCxL84BW21lwSBJCeK7d1SCAdP0wt1ELlX/NtCoGe6rT+nn5zjQ3
         IBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699776101; x=1700380901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YkEVGPbnVHL4DFLlBtIPj1GLSIh3cepxMx8cCgbs64=;
        b=fFRzm1qdT/B4e7zq5QkATFdme+WMaF6guwhZjUprHMIHqyigALfAsEE4+/1UBRB5z2
         I3x1rrkGlfJeg8d71bzqfLD0mdLEvHvQwIj/VoQaxHjinIe+sUCl6bRA2KDguPsU4V0y
         5bRt2alGjCDw86zOeJgLy8eolFawl+iI5qKdLx95lfoVKAYKsE0oAcDNUy4CfPoLlTtw
         UAoxHNSBWLgkdT1pNTvA/S8uqUA5cucehlxRg9O4NhrLs5nh2U7a8OcNWwG2ctuMPMLr
         GvKoxp1rIrBnH0W4S21ASeCZpukciH1YAy+7Z+RUzbnmnGAW/+MVUenZLusGgO6vZ664
         SZtQ==
X-Gm-Message-State: AOJu0YwVQlUrVtc2Lz+X+ajXkaBfzmGH1r078hxHBBeRrej2aoFA/HOl
        Q3rwE5MOVE8GPT97//pCNmH1Ow==
X-Google-Smtp-Source: AGHT+IHckzJzCr9O+a6Q5rN/TZclctvopWIQCNS9enTdQVVVfe+8kPGEh77l+iGTPFvs3Szh6kwycQ==
X-Received: by 2002:ac2:54b3:0:b0:507:b14f:e3bc with SMTP id w19-20020ac254b3000000b00507b14fe3bcmr2230278lfk.33.1699776100696;
        Sun, 12 Nov 2023 00:01:40 -0800 (PST)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id bf17-20020a0564021a5100b0054351b5a768sm1940853edb.82.2023.11.12.00.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:01:40 -0800 (PST)
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
Subject: [PATCH 2/3] ARM: dts: qcom: sdx65: correct clock order in DWC3 node
Date:   Sun, 12 Nov 2023 09:01:35 +0100
Message-Id: <20231112080136.12518-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
References: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the order of clocks in Qualcomm DWC3 USB controller to match
bindings.  Linux driver does not care about the order.  This fixes
dtbs_check warning:

  qcom-sdx65-mtp.dtb: usb@a6f8800: clock-names:3: 'sleep' was expected
  qcom-sdx65-mtp.dtb: usb@a6f8800: clock-names:4: 'mock_utmi' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 49c16ee2e169..7a86bcb52cfd 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -496,10 +496,10 @@ usb: usb@a6f8800 {
 			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_USB30_MSTR_AXI_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>;
-			clock-names = "cfg_noc", "core", "iface", "mock_utmi",
-					"sleep";
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc", "core", "iface", "sleep",
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
 					  <&gcc GCC_USB30_MASTER_CLK>;
-- 
2.34.1

