Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC349812B51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjLNJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235660AbjLNJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:18 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769911F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:23 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f58040770so405354585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545142; x=1703149942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NpBpw87ancReoayxiYNLEpdh+qbLyvkQJUBfcAOaoQ=;
        b=i0x1jBDtKLGBSHWJe6Y5P8awCV4vjrBhYub4s5xNckoIF1vPLDN59GTsfMUebze/I+
         IBiMHqpy+V3baWZHsw2W4UWAk33Bo08J+iF0RCJ/vf2cy3fov/Ryqsut5i8HJW2Sdnqk
         oiXV4JKPHMgshO0ACaFFhpin5RbCNH0qZMy71Bz7+NUyyegtQXu+AxRsZydhZSohJAAw
         h9TtttUvYsJSBtKFKuWa915707Y55mEqevxlKIpJcOdwTLjU+IIYbYNsnjkuM2Hm3Mk+
         Hvd9DfgK2GMhT31GtcFbLWd+9k+uxeppfgIjWLFmY6/Ux72DBJ6s7RnusGtgO2XT+eFg
         xO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545142; x=1703149942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NpBpw87ancReoayxiYNLEpdh+qbLyvkQJUBfcAOaoQ=;
        b=WMH0BLTDgcJhEDCfHAVFImU09HEpZT89D5FQ9lmp524FTANj8exbmzWr6l44nkKyTR
         V+SiZpeOhXVLIxzqBbZ6kdPJG+K6oMqPNGpF9iSWPCWA0IxuAzupDqyiMGnJSd1ZmpPF
         vUcGKUlts9/ipskrRsGDtEX5r8yEYbacgZ7Ill4qojFgvctfxwGpAZLy/ZAE/VIiZydi
         5ToWtUWrVzMbCSwT5GdAar5lwr7Kj3zlI/08bS2MOD5z50bcCLQG57MJReSgHHLbkD4w
         DXJM5icvtpxO7mLyAPu6K2nyBR56fYJ7T16z3oP0gOa7GrvgahLrfLjP3LcBOqUWa28p
         D6Ew==
X-Gm-Message-State: AOJu0YxMxivNOxpFJTEyWkGQQNEubdVKJi6QCQSfrkh5aUk7zJ/0337g
        KUcmVInW4ZCkXBpKOaShsiY6
X-Google-Smtp-Source: AGHT+IHkKGZjjk5nJUoZ+N0uLM2h0SgrsFVpX/16fIAjacSPXopzF1OgPVpV/nLmed6E8PzbjRaw7w==
X-Received: by 2002:a05:620a:260e:b0:77e:fba3:81e5 with SMTP id z14-20020a05620a260e00b0077efba381e5mr10587915qko.123.1702545142533;
        Thu, 14 Dec 2023 01:12:22 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/16] arm64: dts: qcom: sm8150: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:56 +0530
Message-Id: <20231214091101.45713-12-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SM8150 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: 3834a2e92229 ("arm64: dts: qcom: sm8150: Add ufs nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 43d56968a382..18af94852974 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2065,10 +2065,12 @@ ufs_mem_phy: phy@1d87000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				      "ref_aux",
+				      "qref";
 
 			power-domains = <&gcc UFS_PHY_GDSC>;
 
-- 
2.25.1

