Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B63792C24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354158AbjIERHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbjIEQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 12:37:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A975258
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:34:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ffa248263cso4254852e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693931584; x=1694536384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH0Ng8oy03X8SMHsmTArDNYyeNPd8XC1y8dXMDsLWIc=;
        b=Nz34wP6NMoMv2hLGyfWSHxKUIFi3wZ69TiTVOboI2xftZG1PzguYksIRQPBqyB3EJB
         eIh/CzVNGLBPIKn5njsJCJkcbN0K/SswKeLx9elGn+BDKjFFDVuxNAUppUEF0tO/hv9X
         bLr6MHummi9yy+QxHhWBhQ/Vt+iT/p2NMXkJWHyGgjC9lpboqxzvh8+7K2mj1wusRLzl
         Ry0GTLyeTwz0tdQ1aRFlGM+4q37DBXQBqgNPB1Hxn719OvcW6Ev0wG2td0k6NTXwPz0Y
         Zhgg57ilj/c+eG1p4ud3zAYsb66mtQYFRlf1pL1kcGQ9oRNluwmlhLh9ORPUOevz6p3x
         iZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693931584; x=1694536384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH0Ng8oy03X8SMHsmTArDNYyeNPd8XC1y8dXMDsLWIc=;
        b=gir3F9lwr1iN/hC/M8RSm1s9CojSAuKC/idpPK0a6/Bfr/5PqencSwXDrD+cOksRSK
         /IAdPaEGcI5xv8TFl26MBmEr+2NM0nnw0KkUx/C81pKbgXJFdPmtermPyFAMdp4OPw5m
         nP/9pLcwCQSCR5eIqV4GWf8hrWvqsxR14B6hY4o7JL1PE7jp4UBJvvUIgkBTlwoXAwXo
         NnH3Xma32Lqn74Le8nPlWyNCxKpK+8x4WaKjrHwE17yItN2wxag72WdNBHtbnsBXuTo5
         U0wj7OMRozFutdvu2nvNLLsGoQJQJxb2qR+AYaBh/xiIijqVv14U7BAAD7w3deF+Fy/z
         mkaQ==
X-Gm-Message-State: AOJu0YwEJTvShughUFCuyQ9pwWCdXCEZCinC2LEknSeefVzgw4VuvNJh
        l3FMKIc/XWRmZD6AtnZoOpaqORbq5+E9KCcUC1U=
X-Google-Smtp-Source: AGHT+IEnMq/K+PBH4fIwWFHDZIzZQAuV6yDEJtoSosWhc0PuWlIX9lGFDqQXnARU4PSyDs6TMRTApQ==
X-Received: by 2002:a19:6703:0:b0:4f9:cd02:4af1 with SMTP id b3-20020a196703000000b004f9cd024af1mr211263lfc.34.1693930776810;
        Tue, 05 Sep 2023 09:19:36 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906489a00b0099cc36c4681sm7743165ejq.157.2023.09.05.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:19:36 -0700 (PDT)
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
Subject: [PATCH 08/12] arm64: dts: qcom: msm8998-pro1: correct UFS pad supply
Date:   Tue,  5 Sep 2023 18:19:16 +0200
Message-Id: <20230905161920.252013-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
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

The Qualcomm UFS phy switched from dedicated driver to QMP phy driver.
Eventually the old driver was removed in commit 02dca8c981b5 ("phy:
qcom: remove ufs qmp phy driver").  The original driver and its binding
used vddp-ref-clk regulator supply, but the new one did not and left the
supply unused.

The Qualcomm UFS phy bindings were also migrated to newer ones and
dropped support for vddp-ref-clk regulator in commit dc5cb63592bd
("dt-bindings: phy: migrate QMP UFS PHY bindings to
qcom,sc8280xp-qmp-ufs-phy.yaml").

It turns out that this regulator, although with inaccurate name
vddp-ref-clk, is actually needed to provide supply for VDD_PX10 (or
similar, depending on the SoC) used by UFS controller.

Bring back handling of this supply by using more appropriate regulator -
UFS controller host supply.  This also fixes dtbs_check warning:

  msm8998-fxtec-pro1.dtb: phy@1da7000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index b6a214bea70f..f1ceaedd9520 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -671,6 +671,7 @@ &ufshc {
 	vcc-supply = <&vreg_l20a_2p95>;
 	vccq-supply = <&vreg_l26a_1p2>;
 	vccq2-supply = <&vreg_s4a_1p8>;
+	vdd-hba-supply = <&vreg_l26a_1p2>;
 	vcc-max-microamp = <750000>;
 	vccq-max-microamp = <560000>;
 	vccq2-max-microamp = <750000>;
@@ -680,7 +681,6 @@ &ufsphy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l2a_1p2>;
-	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
 };
 
 &usb3 {
-- 
2.34.1

