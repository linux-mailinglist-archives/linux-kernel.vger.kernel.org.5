Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5D7E8BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjKKQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjKKQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:42:41 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0072590
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:38 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c7369df9d6so41735681fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699720956; x=1700325756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArNDVIi+I4WcQ+l8h9DJ1wx6t4xBoPH7FgGqFbtahBs=;
        b=EqOSH7uAB+hLrc6VdJ7wgp+6CCavpxYjWRrNCvJG8LMFXcHWVi8uAdO2QFoTerj3ed
         WUnYOxMMPUzNnkfaeLsedq2lrnJyavHsvKAD8Ww3c02gxHBK98Q8THYez5v7WUe6IDxl
         wUyBk2F78jJF9a7t/j72o1jmJFjGDEmmk0ZW1SAdSxhNbmt9bcQjfA4vc36oVMMkJDhJ
         ZQnlrQkgpKJv6AXAhrCQQG2Jx5saxEIv4OjLrK4JkQeLOwVZrsZsXPhg4kwHI67ZZmEA
         Gpy3AUNDY4xHE+S/ujcpWtWSksv6JT6v3tK9XVOTPWbX+2FMAIG8mo1I7ypT4reGFH3r
         TAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699720956; x=1700325756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArNDVIi+I4WcQ+l8h9DJ1wx6t4xBoPH7FgGqFbtahBs=;
        b=WDWgvwNG/cffynsfH7/Vt8V7jZJDRtkPdN0/TqgaGuAD9eTVeUHSDWEzUbXhklod1w
         IfGjBR1VsrIQ6UB+16Gk40ud2PUbqm5Q214DZlP7KSFhy/dnndfZ+jn/0Jl/THbY4R2L
         /dKOYXCtNNq7CdES+oQ49/+ywnlW2+mNEcTDreFsYdzX8Wb0Bb+GTnQd+0gZY8Ewlnxt
         MJAMgeQUDZPOxjzQDMfkZTSum3hQHt398mPwrCVY8l51B3GJGmfL42v3wfjyu044eyDg
         e8DZzU4lyaucwBvW+6KteFleRVSmDxzfYc7wQMpURAK6Az1vBH2GhGImcjXKeH91W4uT
         5MXA==
X-Gm-Message-State: AOJu0YwvwuIqE3piMGovBuB2bPIJYpgZREfLaT0PfSqSEz4g+NGRWQm9
        2EEyQAryvqDJ5Q+zXzmdIIbXLg==
X-Google-Smtp-Source: AGHT+IF+At48VBZ+wvrVPfmY34DhAOWVE5MBtQWhRwaMnvz02bNtk/Gq7LFsSjO8UFsQGfcOXZT9tQ==
X-Received: by 2002:a05:6512:3ca5:b0:509:8a47:3672 with SMTP id h37-20020a0565123ca500b005098a473672mr1394287lfv.34.1699720956174;
        Sat, 11 Nov 2023 08:42:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0053dd8898f75sm1161917edo.81.2023.11.11.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 08:42:35 -0800 (PST)
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
Subject: [PATCH 3/6] arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
Date:   Sat, 11 Nov 2023 17:42:26 +0100
Message-Id: <20231111164229.63803-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
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

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sa8155p-adp.dtb: pci@1c00000: Unevaluated properties are not allowed ('perst-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index e39de6596a1e..9bcdc485c73a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1878,7 +1878,7 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_phy>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
@@ -1972,7 +1972,7 @@ pcie1: pci@1c08000 {
 			phys = <&pcie1_phy>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
-- 
2.34.1

