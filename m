Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D35812B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjLNJLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbjLNJLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:47 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181C10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f8e4702a6so149226885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545113; x=1703149913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7tHzmERAQbZImeje4EMokx1gYyccc/9b3w+T8ZyCDU=;
        b=nsoE5GvvuR4zeneIC7GSzPT0AE4uvcjN4jG7MFp3iU905/kDfZHPPrsgmUXfjw7NEw
         ye7bSdc40al4BmMT3hLPxeLCfw50luTh4oh2DLnSwh9f4QW19lD704cPd/FPT0BTUZ/M
         /JDWMR5NHdfS9lbHEPytFosz3Bm6NDxACuuhOuyx5RdBWSgTTGAFPCngvXEKts0nBQK8
         Lo/XCWwchlQ5XQgJXaiMgcKkyhbMEdafWdb0Y0NJ6nim2FXenci8vYjCwzBlOa2rMGIu
         Us9Zp9VbpznRnkVYE60ukVe4VdW642pXFwzevxIBw7CbArQnqTnTzqbVE7jb0w2lY6g9
         B56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545113; x=1703149913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7tHzmERAQbZImeje4EMokx1gYyccc/9b3w+T8ZyCDU=;
        b=dBHQY/I/SScwPM8xD5cbQ0boQHkpRDQwDFgsZTirgV4EZrHoVnIiQGm3wJ2Usnne+r
         e1QR23ezHCNMiCcE9J2w7ZenTXUNwErZjzCw+8rcGdurwqWZGffi3RSZLWidDBHFSfed
         o/0A+2MRZZyr0ZDW8MH4xW+FFm2zMdIt9REM394XKGD1cek+/0xSyXT17L1nposNiD2Y
         2OkKzgALX/3XMA4zoL2Tz6gza/I2+VW3JC3jvfHiGhbl//edx/l9F1T43mMLccYTI8fp
         5KWe7QDNhcvrJiz0uWxbVSfaGG53iHQni1XHNtquf/yIlAo2uAhAwH0wCoNk0ZTIJRU9
         +Geg==
X-Gm-Message-State: AOJu0Yw8YDXaiFyijlA7Qa1gJoNGFB1QlLHZIxYo0THPq2JFngXJZ7mY
        dCWlCTcy2Pe09KYx8DTyUW+8
X-Google-Smtp-Source: AGHT+IGGOd9jlu9qhHJFGypL3G+lZIGRt/9aClzI8nCmgZYkeu4ehYfW0e9S6L8lARh5IDvJykKmNA==
X-Received: by 2002:a05:620a:21d5:b0:77f:3813:4212 with SMTP id h21-20020a05620a21d500b0077f38134212mr11387231qka.86.1702545112885;
        Thu, 14 Dec 2023 01:11:52 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:11:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/16] arm64: dts: qcom: msm8998: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:51 +0530
Message-Id: <20231214091101.45713-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PHY used in MSM8998 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: cd3dbe2a4e6c ("arm64: dts: qcom: msm8998: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b6a3e6afaefd..d4c55e2b0043 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1051,12 +1051,12 @@ ufsphy: phy@1da7000 {
 			status = "disabled";
 			ranges;
 
-			clock-names =
-				"ref",
-				"ref_aux";
-			clocks =
-				<&gcc GCC_UFS_CLKREF_CLK>,
-				<&gcc GCC_UFS_PHY_AUX_CLK>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK1>,
+				 <&gcc GCC_UFS_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			reset-names = "ufsphy";
 			resets = <&ufshc 0>;
-- 
2.25.1

