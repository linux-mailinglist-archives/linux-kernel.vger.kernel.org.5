Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CDD80B56D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjLIRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:16:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318FC10DF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:16:16 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e7971db2aso351539366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702142174; x=1702746974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N//LFsMjuZq4iKtlyMYGCirrn61f3kbX/lE5kaAb5qM=;
        b=ujyn2XY0s+DUNmoPYucuSF5vT+dDO00Pbd6eWcNLxGEhfLYQWPd3v28noHNgixDjF2
         noxlZuqRJEt/1yzFr/9AK/Abrty8SCQz6sn2jdFL5gvwMrh1XR1HhrW3IHiVqVQp3D5Q
         8Rezqht58jXYsHR0XGjNGya/AkWbRQU0L786YsyfMTQ8Rdy9t2Tyi5lGtv70BFlaQz2O
         ldsKqR/68ErVEwWOEjW7ims0s2lF9uoW89KAUxMhvNIJmAjSnyG4qu1wK8Hczx4I21lN
         qU0sg965U07p3sw7K7MIy9FrR8wEs4juv68t0jc/kQzZ2BVqtmlAB1O7fyBAsKy/GEJV
         NO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142174; x=1702746974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N//LFsMjuZq4iKtlyMYGCirrn61f3kbX/lE5kaAb5qM=;
        b=nt2zcfcDOy5/PAlOIytSuD/mUw9woBwVvLth0kjWDx5Hw02xLqA+BJ6JYhuBDLza+8
         vRYeE8MR8ARbb6AIczQadA2uBEmDaHLRzhP1BY6L+4DXXcT5aaRd/Z0F+gP4fpBcCJo1
         fh1G7Lwl3lsdNMqzi1WsAbw8Tz94OQXLIzD0hrcsoH7vw1pRwIJMp3MU8ZdH4yFqvLNz
         5vfZQZmhyyZ4ebZdkvUxyW+nP4whgm+abL/MU9K5ATxS1aYPYHIpDr7A3n3q+IcJ6Vi0
         eHjrI0Sbp+2IzK849i1aHVZQV/Q4J28irQn3l6T0IETyn/vw3UzuCdNABKW/nTTx9Loh
         uWKQ==
X-Gm-Message-State: AOJu0Yyd10M584zmuNfsIBYZXtHuLnNe6NWAg0/Fy2v4J9OhfS1CzkhJ
        201bEpHbZtL1rk3TOjRvv7Z02A==
X-Google-Smtp-Source: AGHT+IF7lfeoMKj7lrnzHIL0I+1nREKlOADXkHe8mxEUwxT5JLX2SJIZdtAO9m5+CN97p4RIJGzMMg==
X-Received: by 2002:a17:907:948f:b0:a01:e916:3590 with SMTP id dm15-20020a170907948f00b00a01e9163590mr1054629ejc.75.1702142174592;
        Sat, 09 Dec 2023 09:16:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id sf21-20020a1709078a9500b00a1f7cbf28a5sm1179782ejc.106.2023.12.09.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:16:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: juno: align thermal zone names with bindings
Date:   Sat,  9 Dec 2023 18:16:12 +0100
Message-Id: <20231209171612.250868-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Thermal bindings require thermal zone node names to match
certain patterns:

  juno.dtb: thermal-zones: 'big-cluster', 'gpu0', 'gpu1', 'little-cluster', 'pmic', 'soc'
    do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 12 ++++++------
 arch/arm64/boot/dts/arm/juno-scmi.dtsi | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 8b4d280b1e7e..b897f5542c0a 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -747,7 +747,7 @@ scpi_sensors0: sensors {
 	};
 
 	thermal-zones {
-		pmic {
+		pmic-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 0>;
@@ -760,7 +760,7 @@ pmic_crit0: trip0 {
 			};
 		};
 
-		soc {
+		soc-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 3>;
@@ -773,28 +773,28 @@ soc_crit0: trip0 {
 			};
 		};
 
-		big_cluster_thermal_zone: big-cluster {
+		big_cluster_thermal_zone: big-cluster-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 21>;
 			status = "disabled";
 		};
 
-		little_cluster_thermal_zone: little-cluster {
+		little_cluster_thermal_zone: little-cluster-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 22>;
 			status = "disabled";
 		};
 
-		gpu0_thermal_zone: gpu0 {
+		gpu0_thermal_zone: gpu0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 23>;
 			status = "disabled";
 		};
 
-		gpu1_thermal_zone: gpu1 {
+		gpu1_thermal_zone: gpu1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 24>;
diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
index ec85cd2c733c..31929e2377d8 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
@@ -76,27 +76,27 @@ scmi_sensors0: protocol@15 {
 	};
 
 	thermal-zones {
-		pmic {
+		pmic-thermal {
 			thermal-sensors = <&scmi_sensors0 0>;
 		};
 
-		soc {
+		soc-thermal {
 			thermal-sensors = <&scmi_sensors0 3>;
 		};
 
-		big-cluster {
+		big-cluster-thermal {
 			thermal-sensors = <&scmi_sensors0 21>;
 		};
 
-		little-cluster {
+		little-cluster-thermal {
 			thermal-sensors = <&scmi_sensors0 22>;
 		};
 
-		gpu0 {
+		gpu0-thermal {
 			thermal-sensors = <&scmi_sensors0 23>;
 		};
 
-		gpu1 {
+		gpu1-thermal {
 			thermal-sensors = <&scmi_sensors0 24>;
 		};
 	};
-- 
2.34.1

