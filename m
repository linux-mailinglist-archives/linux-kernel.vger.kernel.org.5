Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B17812B61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjLNJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjLNJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:30 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D844136
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:35 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f43042268so32322885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545154; x=1703149954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkhidzmVun0Q+RVPRPkagjowO4OR2Vwj/TtI5d1pEJU=;
        b=clxzH0FPsT5iPZx+DVeG9g4dLw9kIzROfXH+lilTPy2AD9hGKVHriS6EV++/jMeops
         /W1L4Bk0k8kS1kB/BixiOHaMlv99z014kiZxEiD1k5A28yo4q1YNmhfRGXM9UNg7S1wA
         /lFHKtgr+3QdgfcP9fVihw4fky1fRiA/B+KqMfAW/e7HP6Bvj6uOsyjQZsL1v2KzCIBc
         Yj7mqYsaBXzRgG8G6vq09rsJ+swGufRz90D/aR2QQmRVCVFufC8hhCAEMn/urh6epb+G
         YYcNuwVJG7HSe0sDrxkAi1iNzeh53Iu81YE0XL6/r1d5F7MO/PQ9ErAC9BaKagtNx8OW
         wEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545154; x=1703149954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkhidzmVun0Q+RVPRPkagjowO4OR2Vwj/TtI5d1pEJU=;
        b=gdR7CxJmO2Y0S0okmJYbsvY7JYASn3fJsWr9gymEk/BEJfjnkL1XGp0U/QKhSlJGQF
         GlLD88bl3BdV30gz0NBKECn+nWRQHlK81NfbawOrzYUShmrjiGdT9kqB1qv1kJtosPK4
         i6FwrrPLDsxJ2lAJy4rVtsOHc7s18JwsyIbwXPQk41OBRcVMme6dc61iC5IMGs9k0TQo
         jwvEd0mHEmiWz+oZVrtpKd2wDBjHgLWtggNXU7o5/mn05P+6XXbyrAW7eHpEOlUpVrUI
         feXlI8r1gRy/4YqEAa3hvTasCoSr2Ks33xYfBANKcOIQgdC09hKooyuxxqxmiTyL+MU0
         l4/w==
X-Gm-Message-State: AOJu0YxJ46fkU74CyMkfJ9yClOzUzHUyKjWaOU0arSenALTGeWfzaTxJ
        xa/LVfFxUpDfasiJut4mzv3F
X-Google-Smtp-Source: AGHT+IHEtm7mEgCIyDmSr/wXhkhEOgi12WL0DLU2N7twPYVrahWhPEqWyDCKPCHrKSIdtshq633qyw==
X-Received: by 2002:a05:620a:14af:b0:77e:fba3:3e61 with SMTP id x15-20020a05620a14af00b0077efba33e61mr12750317qkj.42.1702545154261;
        Thu, 14 Dec 2023 01:12:34 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/16] arm64: dts: qcom: sc8180x: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:58 +0530
Message-Id: <20231214091101.45713-14-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SC8180X requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 8bcc8c0bb0d0..5591e147bde1 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2122,9 +2122,11 @@ ufs_mem_phy: phy-wrapper@1d87000 {
 			reg = <0 0x01d87000 0 0x1000>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_EN>;
 			clock-names = "ref",
-				      "ref_aux";
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

