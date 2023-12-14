Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2427D812B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjLNJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjLNJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:06 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E3129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:11 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f9c7d35deso56579985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545130; x=1703149930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R/hqTzd/o8JpkxBFS0sj0AJtadDOIWSQt92Ki/rlFQ=;
        b=Y9U5aAtVpuqyaHEOhPjqJQWRjaWfK1VHaRThfYhNah5w7ATQgZ0rivTV+d77wPCCiE
         plEpYJekA13ZFYgCc9Csi3/3D+9voMgdSJibOfuTwbEOsFvbQb/hBxaDAIKIEkHdHR89
         G7QT/qHSVGRzRDbRhJQDIUqVc7HAGrfG1opQpW7CBILy+jKDZhjgKcJD5Q+/m3GxHln7
         DoR4VphYtNiJNQwJkZZr4arLGaVGIGEPAOUsd1ptKciVukh50p91Btun05BYLUBoJSQI
         yfPaXM1GZYgIjgwXyKTyMn+IurijwBDdSOYYNx/aImODFtH+7m1b6bye+Rnd4Zj0Q9rU
         AHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545130; x=1703149930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R/hqTzd/o8JpkxBFS0sj0AJtadDOIWSQt92Ki/rlFQ=;
        b=h5mfymrsV1hrTM8hzc0/Ex9XqQSZ0FxvSy1fC6H45KAiIZz6n2LbZGcGMz2gTCZfxR
         ExG4NBBG3H56AJ3UGynXZVt442CtNrCoJbkod13iZyuctzmrerTuZ/07YUj735On8IO7
         G1sqYoQ04qTK8dyaWmHw2Q54WqycPgHmBmYbdau5y21rnE5d7I5Vi1l1YHF2OSDzNulD
         tCyCDsI0Ni7MT3Cvi9NzUmm7zLarsEfnOsm6zcL5QbkAhdvK5nYv7b0d+JXOYeV6+Iam
         n+QnSRLe8YhuetJ5a6evJ6QFSUr3GjjCwrWUf8ampeQ6FEnYut+7Z+h0fn7gd0WpN1GK
         /BdA==
X-Gm-Message-State: AOJu0YzWL+U1qqwwJs9JEu+Iv09J24v4003JZxMlaios8c6Dbq8Y5HeP
        ak9/WuAhu4YpZIDYyEItb+FQ
X-Google-Smtp-Source: AGHT+IH8nNO0Z2A5qhy/eFw6w9HCLUFnLPwuisRFUq9Zu9qVpiWOG+IrWYg6mGZN6+oEXnqT2Pz8tQ==
X-Received: by 2002:a05:620a:2707:b0:776:f5bb:f2fc with SMTP id b7-20020a05620a270700b00776f5bbf2fcmr8186278qkp.9.1702545130709;
        Thu, 14 Dec 2023 01:12:10 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/16] arm64: dts: qcom: sm6125: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:54 +0530
Message-Id: <20231214091101.45713-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SM6125 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: f8399e8a2f80 ("arm64: dts: qcom: sm6125: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index eb07eca3a48d..b46d3c1fa47a 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -812,10 +812,12 @@ ufs_mem_phy: phy@4807000 {
 			compatible = "qcom,sm6125-qmp-ufs-phy";
 			reg = <0x04807000 0xdb8>;
 
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

