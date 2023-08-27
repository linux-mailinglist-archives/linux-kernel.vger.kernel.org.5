Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72274789D51
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjH0Lpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjH0Lp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:45:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44986186
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:45:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500a398cda5so3712968e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693136724; x=1693741524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa3H2iefcQlYYWOvTv26OeJQbCdCn/zWrEM8kKvHomY=;
        b=eHY14BrrVoJsqDZDlPmLXbfPcayLOiTnqDAlXbHg7ehMmSIOWMz1H27x6kgwhpWZVC
         vQfyfuO3Zsp3HGy6YGd4c2geiNp8b2Qh2pQifShJIk3rMFtYo7hpcsS2/a7hM8NNup3g
         OF8emR+k8et2vMDOu9msuvc5YBA2IuCGLh7GnIj9zvsH4Js/AwP/6p9ghqrv0GeYHs0Y
         7nZVo6OZ3sh3Hw5vSO59rMCSBucuC5mehw3KvVWHsKAA7FjaTxc71RnPsG1f1kBK/C/i
         ZGQvewGK+W60IS8jBZ7ZmtdhQjQ9mMVrhu4wwaXgCqWaALjIxYESrvVJ2P8MF1bouyB+
         3x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693136724; x=1693741524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa3H2iefcQlYYWOvTv26OeJQbCdCn/zWrEM8kKvHomY=;
        b=dMZsl40o3+ir+A138tPa8v3MqgSCaN8N2G//r+gFYe1UMSELHbCz+YvKS3ICVLWV86
         wq/j3WPXbvuCM1MsRXnIS5UUiqhXZXndgIgkQj+2ITSZRdK7fJVAYJSJ/QCqWTf758VS
         oF3CcICARpIFUdsKegZ2vhRorlxOfVCxfRI44CzR0LXu2S0BvwdKtuhuaq22sl/dzFlb
         aAXDCxD+ZahZ9CuspzVFGTp/kQeieyTb0MRzJQzON5pcl1ueCpOBTE9XVWOEZr8zmwjd
         CurYpzBoo2IneZM3q/eI3khXAKTQUe7Xv5s7PbvnNqS0ICmNyHc8VZnplQXc1NeX3d66
         y2Aw==
X-Gm-Message-State: AOJu0Yw7oil0Pcap5Y0SUIcWe3Lqcfe0N4KWtJpuup9sHmHiPo4rDLQR
        egqYpRoKr8cWYC6t3tiuzuGD2g==
X-Google-Smtp-Source: AGHT+IGwC58vPd6gVaZ2rZzjpBpbfeahrxbw4hICOCqX+x4aGvq7mANdbs1Ik/uE29QdPQiIlixvYg==
X-Received: by 2002:a05:6512:304f:b0:500:b890:fb38 with SMTP id b15-20020a056512304f00b00500b890fb38mr554588lfb.24.1693136724245;
        Sun, 27 Aug 2023 04:45:24 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b005254b41f507sm3239024eds.32.2023.08.27.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 04:45:23 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: qcom: sdx65: add missing GCC clocks
Date:   Sun, 27 Aug 2023 13:45:19 +0200
Message-Id: <20230827114519.48797-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827114519.48797-1-krzysztof.kozlowski@linaro.org>
References: <20230827114519.48797-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDX65 GCC clock controller expects two required clocks:
pcie_pipe_clk and usb3_phy_wrapper_gcc_usb30_pipe_clk.  The first one is
provided by existing phy node, but second is not yet implemented.

  qcom-sdx65-mtp.dtb: clock-controller@100000: clocks: [[11, 0], [11, 1], [12]] is too short
  qcom-sdx65-mtp.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 93c6c80dc379..58635bbc1123 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -204,8 +204,16 @@ soc: soc {
 		gcc: clock-controller@100000 {
 			compatible = "qcom,gcc-sdx65";
 			reg = <0x00100000 0x001f7400>;
-			clocks = <&rpmhcc RPMH_CXO_CLK>, <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>;
-			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>,
+				 <&pcie_phy>,
+				 <0>;
+			clock-names = "bi_tcxo",
+				      "bi_tcxo_ao",
+				      "sleep_clk",
+				      "pcie_pipe_clk",
+				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
 			#power-domain-cells = <1>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.34.1

