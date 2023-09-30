Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4527B3FEB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjI3KWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjI3KWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:22:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93F1AB;
        Sat, 30 Sep 2023 03:22:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so18277736a12.2;
        Sat, 30 Sep 2023 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696069345; x=1696674145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upvkOshm+Utk6b+l4TjTOIuE/7SOxFRjndlDlP7Geug=;
        b=BteT6fkt8qOUyo3MKGDOkg3c1DJnlHouFWbZo2Gefy1lAn4M+HjOVGxMOnyaS+CHaJ
         eVf3bo+k6APFjoE01n3zfIDmA3C2eufCBHq0eXH83fxf5iPwp0U/lsE8NV6sI0OpRbNn
         gksWQ16QAYKwtgsiSORC0JfpnJ2gI/22ax2FMJYN8pA5EkynaGpgBrreBJoxLGiK1W+3
         YixP0iChf2jIKp9q6EEzdPC2YOENmPeV9RYvJCmJV1OYx/Lft1mFuO7SeiLiY6/qNWLF
         2oNW//piN1W+vQLlP7o1MKk/73nhSyE97AntPTIgmbMpRU2RpdGJYSlPCMQV9gBwGIZt
         /EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696069345; x=1696674145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upvkOshm+Utk6b+l4TjTOIuE/7SOxFRjndlDlP7Geug=;
        b=j9ULVqHQsoC/cyRI/1bcvN0tKfB5yEjsh2yi0micyjLBnUZhycNda6dhwtLPvXbBHH
         tk/5wY/+wrmxtLfg3HpzbNn0yqsELHQ+WxN0kfmqbQHFdhpaqsLYrL/BMvlwubqgdeBg
         UPDmHbtxM6/m0FrsLp7LKk7qgRwOfe1p2knURRRi7WfGHlO+J1ymdDb/BolNKWjpZgTX
         eWDbiT6a2vhfdTV3KrC68sEZcEwL4tVBBkFp/brvrXvzwLubMTAzX6F/viFmBHi0r6dz
         G5T/9pxXkzIyFkAkQYt/1D31TVMq3d6PhHyQaaKcZd2gXwGZqBEWpFzylzdFoFAwOwdz
         K87A==
X-Gm-Message-State: AOJu0YxRMimygFgMntGNIWBYLUs7//Q3UR35rGQOPxWB6LsWP0FoSA8I
        a1nlzV3P8sZNmCAGukhgLNE=
X-Google-Smtp-Source: AGHT+IGcDhCz//73gt6W6Dq+CQ+r80HKhSBIex7xtCKsHl3/kCHELm/j6qln6fyfhwhGnqQw8lC3aw==
X-Received: by 2002:a17:907:77cf:b0:9b2:c2a9:356e with SMTP id kz15-20020a17090777cf00b009b2c2a9356emr6062679ejc.49.1696069345482;
        Sat, 30 Sep 2023 03:22:25 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id j25-20020a170906255900b0099bcf1c07c6sm13716547ejb.138.2023.09.30.03.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:22:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Date:   Sat, 30 Sep 2023 12:21:19 +0200
Message-ID: <20230930102218.229613-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930102218.229613-1-robimarko@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
Use opp-supported-hw binding to correctly enable and disable the
frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes v4:
* Add OPP DTS patch for IPQ8064

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
index 6198f42f6a9c..cbbd28b43dc4 100644
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
+		compatible = "operating-points-v2-kryo-cpu";
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
2.41.0

