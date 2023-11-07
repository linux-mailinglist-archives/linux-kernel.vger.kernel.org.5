Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB787E39ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjKGKf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjKGKfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:35:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420AFF7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:35:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso9424932a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699353349; x=1699958149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RrPqf9g6vZzcW9B3QMf8ZEkIBfqDLbMeI1GDD+TO1g=;
        b=XHPFyqoZj2+I7AXmweLb/Gp8LOQM58Henj8XrzxE45jgXHSVBxeQkPsUuiB11T/O2X
         8qQkOATMlHO0FwO+WNMwsKYZFjXuJNKalPzvPnmYv3Mhry8WFrjMoPwbu6oOewBpjkN9
         IcXJD5+gb8O2bx/JFgaGyx+wG7c4ubS64chE0Q8DOUD/cDXNPOOeZKrFZLZ6qBqf/mF5
         HOd0QTrOKCbvHuVJtg/nD5//nHXX6Faj/yXZPYxwfOHWKLNfCWje9xrDsJ6yfmetmnpa
         4REaSL3kdu6q/vDdJjujlFCNPnRJxp4C5sBCDC4YaLnMLFgPx4ZUNMckIE10V01LwhFn
         57XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699353349; x=1699958149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RrPqf9g6vZzcW9B3QMf8ZEkIBfqDLbMeI1GDD+TO1g=;
        b=gsD7Go44uXTI4yXtVEQHHmjGuXWaMN8mDsyT/YduIppP1SsuHnReuTrMKvrarIz1sX
         nn/nJVXjdUKFsRAx8Eu+wHdiMn/g4bE/W2qZnHegdPS7mAuTqALdmy5neMzunRjkHSX+
         AIGGyrna1T9QYqX9pWT+roT62qefE8A+4r0q5BTYYTlzbJeKhIsgtkBaniuMpZiHydZv
         loe+fvYbjV8gRcrjILpN/F+EI/Z8fzhaWA/qnHCSFunXXwVFUAUqSNBbOWUd+y4ocq0R
         d5ZkzIslfh3BVUsPJwYD/OAmirkOb7PydO9Sn8iac49Gw7OdXApL+MvrWh7OJ/8UfsEl
         ygig==
X-Gm-Message-State: AOJu0YyyICMs/Nxm9IFhT2OAy80JcqXXEbQJRvzKwS8Sxu/FsorvqVbx
        4UdEUPedneXoRVuzMRJ5jQD2UQ==
X-Google-Smtp-Source: AGHT+IHgBuwwDy0kLA8vjtnt2Po255HyzaI87LRZNoYTmqYcCe60gxNsiaYSoPz7l5WzxwxGpI8sew==
X-Received: by 2002:a17:907:7fa9:b0:9bf:d70b:986a with SMTP id qk41-20020a1709077fa900b009bfd70b986amr17238224ejc.13.1699353348764;
        Tue, 07 Nov 2023 02:35:48 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u21-20020a17090626d500b0099bd86f9248sm882998ejc.63.2023.11.07.02.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:35:48 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: qcom: sm8350: move DPU opp-table to its node
Date:   Tue,  7 Nov 2023 11:35:40 +0100
Message-Id: <20231107103540.27353-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
References: <20231107103540.27353-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm MDSS bindings expect that DPU opp-table is defined within
DPU node:

  sm8350-hdk.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('opp-table' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 58 ++++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 6424a3ebdf5b..d1a28cd0ffc5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2438,35 +2438,6 @@ mdss: display-subsystem@ae00000 {
 			#size-cells = <2>;
 			ranges;
 
-			dpu_opp_table: opp-table {
-				compatible = "operating-points-v2";
-
-				/* TODO: opp-200000000 should work with
-				 * &rpmhpd_opp_low_svs, but one some of
-				 * sm8350_hdk boards reboot using this
-				 * opp.
-				 */
-				opp-200000000 {
-					opp-hz = /bits/ 64 <200000000>;
-					required-opps = <&rpmhpd_opp_svs>;
-				};
-
-				opp-300000000 {
-					opp-hz = /bits/ 64 <300000000>;
-					required-opps = <&rpmhpd_opp_svs>;
-				};
-
-				opp-345000000 {
-					opp-hz = /bits/ 64 <345000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
-				};
-
-				opp-460000000 {
-					opp-hz = /bits/ 64 <460000000>;
-					required-opps = <&rpmhpd_opp_nom>;
-				};
-			};
-
 			mdss_mdp: display-controller@ae01000 {
 				compatible = "qcom,sm8350-dpu";
 				reg = <0 0x0ae01000 0 0x8f000>,
@@ -2495,6 +2466,35 @@ mdss_mdp: display-controller@ae01000 {
 				interrupt-parent = <&mdss>;
 				interrupts = <0>;
 
+				dpu_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					/* TODO: opp-200000000 should work with
+					 * &rpmhpd_opp_low_svs, but one some of
+					 * sm8350_hdk boards reboot using this
+					 * opp.
+					 */
+					opp-200000000 {
+						opp-hz = /bits/ 64 <200000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-300000000 {
+						opp-hz = /bits/ 64 <300000000>;
+						required-opps = <&rpmhpd_opp_svs>;
+					};
+
+					opp-345000000 {
+						opp-hz = /bits/ 64 <345000000>;
+						required-opps = <&rpmhpd_opp_svs_l1>;
+					};
+
+					opp-460000000 {
+						opp-hz = /bits/ 64 <460000000>;
+						required-opps = <&rpmhpd_opp_nom>;
+					};
+				};
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.34.1

