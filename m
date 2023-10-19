Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6007CF5CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbjJSKur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbjJSKue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A61213A;
        Thu, 19 Oct 2023 03:50:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083740f92dso18896325e9.3;
        Thu, 19 Oct 2023 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712624; x=1698317424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j92zsh9SBwqH2Fdc6L1hiUwgh6lWWdZdBcoBjn6jH8s=;
        b=DORA9expx/Zw4bHP8PCcABjlzmObgeJA1cXeud+lwjr4FHM0h73okLzt37syfBja6j
         oaIYLL8fym+gK00GqxOnBmOgjviVHIo5lAN6HZO7rRGegIJefju+zq79SJfpSYv78fii
         KOG9rriyBQObIRQ4LZD8wEpcRS7Uup2ewfQyOP3pE9zBTJH1/g1RFhFOlDvDk0UylaBL
         uBaRMlq4AkfS5+wK1u6jvjdW74/NpgvHjymdjtw6Co2UoPmTCViSGOywBNayOZ5sZWS8
         tKFeDxtLT8UWirviE+RJiMTvNhNN8a011wK4DwMSPEzvSNknFeESSz1j2MTVDOMWVbBi
         8aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712624; x=1698317424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j92zsh9SBwqH2Fdc6L1hiUwgh6lWWdZdBcoBjn6jH8s=;
        b=cE5Eixs5ETGZC0p3Ofjr7r4R8+wg67uxXdShmyAijXXrdJELqNm91xA1/l5ZFgMBlF
         RItx5VbJmysEE2EWva0uJtWrzpjZfWyzK/OiISsXSq2xde/wRWCcNMjb0DNy7uLBXhwI
         HIy18beQOJgAXsTAKqeSYQDO5TLu6LkfwoQ97yj2xpPGAtlRBHmhY02aZNQ68MLgrFwV
         TYxrZaA4cNkfjSHKdY1+5REv+9vnMXWfAayYktitHIQ4rZ6qoXXlchJOeNeFwqt+znIf
         sQXuPteiGjQ0kGSdCdI/gC6VXX8bAzSx0KKeTsJv1WsBMixKUk9c1hpH2dHcDym7Roif
         yKCQ==
X-Gm-Message-State: AOJu0YwzQByoZYfo1pBlG10C2dqP6d/Rkj1ehIj9WlohEIgLlx0IGTkr
        Ar/vPksPGkmPlrZXT2fIgyWAgyfngHE=
X-Google-Smtp-Source: AGHT+IG5islK/0X+0hKrDtr0qWdqpXREtFjwMovXmmwAI5kDb1fDMhjchhdF7LlWWt064NIViwXD3Q==
X-Received: by 2002:a05:600c:4f15:b0:402:e68f:8896 with SMTP id l21-20020a05600c4f1500b00402e68f8896mr1602732wmq.0.1697712624244;
        Thu, 19 Oct 2023 03:50:24 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm4129511wmb.35.2023.10.19.03.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:50:23 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v7 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Date:   Thu, 19 Oct 2023 12:50:11 +0200
Message-Id: <20231019105011.7289-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019105011.7289-1-ansuelsmth@gmail.com>
References: <20231019105011.7289-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
Use opp-supported-hw binding to correctly enable and disable the
frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
* Use new krait compatible

Changes v4:
* Readd OPP patch for IPQ8064
---
 arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi | 30 +++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 67 ++++++++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi | 65 +++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
index 5d3ebd3e2e51..72d9782c3d6f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi
@@ -6,3 +6,33 @@ / {
 	model = "Qualcomm Technologies, Inc. IPQ8062";
 	compatible = "qcom,ipq8062", "qcom,ipq8064";
 };
+
+&opp_table_cpu {
+	opp-384000000 {
+		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+		opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+	};
+
+	opp-600000000 {
+		opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs3 = <850000 807500 892500>;
+	};
+
+	opp-800000000 {
+		opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs2 = <995000 945250 1044750>;
+		opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+	};
+
+	opp-1000000000 {
+		opp-microvolt-speed0-pvs0 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs2 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs3 = <950000 902500 997500>;
+	};
+};
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 6198f42f6a9c..54699472f187 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -30,6 +30,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			operating-points-v2 = <&opp_table_cpu>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,6 +41,7 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			operating-points-v2 = <&opp_table_cpu>;
 		};
 
 		L2: l2-cache {
@@ -49,6 +51,71 @@ L2: l2-cache {
 		};
 	};
 
+	opp_table_cpu: opp-table-cpu {
+		compatible = "operating-points-v2-krait-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+			opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+			opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+			opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+			opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs3 = <850000 807500 892500>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+			opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs2 = <995000 945250 1044750>;
+			opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-speed0-pvs0 = <1150000 1092500 1207500>;
+			opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs2 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs3 = <950000 902500 997500>;
+			opp-supported-hw = <0x7>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0-pvs0 = <1200000 1140000 1260000>;
+			opp-microvolt-speed0-pvs1 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs2 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs3 = <1000000 950000 1050000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <100000>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt-speed0-pvs0 = <1250000 1187500 1312500>;
+			opp-microvolt-speed0-pvs1 = <1175000 1116250 1233750>;
+			opp-microvolt-speed0-pvs2 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs3 = <1050000 997500 1102500>;
+			opp-supported-hw = <0x6>;
+			clock-latency-ns = <100000>;
+		};
+	};
+
 	thermal-zones {
 		sensor0-thermal {
 			polling-delay-passive = <0>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
index ea49f6cc416d..d9ead31b897b 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi
@@ -6,3 +6,68 @@ / {
 	model = "Qualcomm Technologies, Inc. IPQ8065";
 	compatible = "qcom,ipq8065", "qcom,ipq8064";
 };
+
+&opp_table_cpu {
+	opp-384000000 {
+		opp-microvolt-speed0-pvs0 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs1 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs2 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs3 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs4 = <875000 831250 918750>;
+		opp-microvolt-speed0-pvs5 = <825000 783750 866250>;
+		opp-microvolt-speed0-pvs6 = <775000 736250 813750>;
+	};
+
+	opp-600000000 {
+		opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs1 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs2 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs3 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs4 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs5 = <850000 807500 892500>;
+		opp-microvolt-speed0-pvs6 = <800000 760000 840000>;
+	};
+
+	opp-800000000 {
+		opp-microvolt-speed0-pvs0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs1 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs2 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs3 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs4 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs5 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs6 = <850000 807500 892500>;
+	};
+
+	opp-1000000000 {
+		opp-microvolt-speed0-pvs0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs1 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs2 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs3 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs4 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs5 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs6 = <900000 855000 945000>;
+	};
+
+	opp-1400000000 {
+		opp-microvolt-speed4-pvs0 = <1175000 1116250 1233750>;
+		opp-microvolt-speed4-pvs1 = <1150000 1092500 1207500>;
+		opp-microvolt-speed4-pvs2 = <1125000 1068750 1181250>;
+		opp-microvolt-speed4-pvs3 = <1100000 1045000 1155000>;
+		opp-microvolt-speed4-pvs4 = <1075000 1021250 1128750>;
+		opp-microvolt-speed4-pvs5 = <1025000 973750 1076250>;
+		opp-microvolt-speed4-pvs6 = <975000 926250 1023750>;
+	};
+
+	opp-1725000000 {
+		opp-hz = /bits/ 64 <1725000000>;
+		opp-microvolt-speed0-pvs0 = <1262500 1199375 1325625>;
+		opp-microvolt-speed0-pvs1 = <1225000 1163750 1286250>;
+		opp-microvolt-speed0-pvs2 = <1200000 1140000 1260000>;
+		opp-microvolt-speed0-pvs3 = <1175000 1116250 1233750>;
+		opp-microvolt-speed0-pvs4 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs5 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs6 = <1050000 997500 1102500>;
+		opp-supported-hw = <0x4>;
+		clock-latency-ns = <100000>;
+	};
+};
-- 
2.40.1

