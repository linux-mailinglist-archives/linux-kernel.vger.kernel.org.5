Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204767CCBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344206AbjJQTGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbjJQTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C546102
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so10084542a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697569551; x=1698174351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3PfUtHnhBSSCkO7osbhNe//iLC/B8joXGE1PccdduM=;
        b=YxoA8wovj9DMEnuYdk+62BsobjnX7H/6HDSrV3dLAnCVd/Ko3whh4GZbb1hfktwqls
         Ixf0iB6S2KV8doZCU4irs5V6VRMkE9vEbz98xV6cioL0iLv86eunOeOifFpWSyIOSiAJ
         uot8QgwAPsLnQwUw9A0lphlNvtx48gkIQw/iWYVcN0QOsFpPSyXQxONgMQivhHmI+tB+
         Q99v7lqcxj1c9oktZDvZUVawMBjLJzN6mByLUaqfhmC6DjRZOdI6c4oNLpGm/pKNJ4DB
         YQXOt10Dc4Q3TorfDyY1E/N4HM2ZswaNXejci+DyXlQhNern7sCYXASsTfd5okDeV1No
         eHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569551; x=1698174351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3PfUtHnhBSSCkO7osbhNe//iLC/B8joXGE1PccdduM=;
        b=if0HRJrZoiHkEi+uMV3UcZANo7DPGeGDfIL/x0BaHio6KqgIxzbZniEDplG4BJN3ci
         UkrRYCATdt9XATM3wbsIibc1v2B3fjZQYYau3PWNrbzt55UoRm/FfTFL8f3sxfDWM6+9
         7WMfzTtLqC1XGRJ5+MBTH0TqNmDAyYTpTItGyZRIU2KdmSCueptFBmfSjvH9E/45uWIe
         635P7XphhPbAL+LYjNnjiBO1OHeOzkubAAghH5IS/LtxJ1MwJD9d3PJzaFOwhef1ydHC
         i++zB6nvcgXVMPqlttR1zKQ6z+vRA8zcmFkZz0UEgX0fGbNdv+X+ji4/+OetF+nGLEmM
         aE1w==
X-Gm-Message-State: AOJu0YzoxFA4qBaN482bLpRL8iqQ0obLF6eIk6i41cEmzsDjC1qpFRqb
        I+v/Hfe42QpEWhjnXgu5Yas6Cw==
X-Google-Smtp-Source: AGHT+IEme+oxNBzK6XLtyhQrXq8tPu43IhnnTxWMT8vQzl+Bn4BOhjIsVHMgrkyWgFTWDXYxrrRtXQ==
X-Received: by 2002:a50:f60d:0:b0:53d:d7e5:a9b9 with SMTP id c13-20020a50f60d000000b0053dd7e5a9b9mr2528742edn.0.1697569551503;
        Tue, 17 Oct 2023 12:05:51 -0700 (PDT)
Received: from ryzen9.fritz.box ([2a01:2a8:8f03:b001:fe65:a70:2777:ab31])
        by smtp.gmail.com with ESMTPSA id bq14-20020a056402214e00b00537963f692esm1637990edb.0.2023.10.17.12.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:05:51 -0700 (PDT)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 4/5] arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
Date:   Tue, 17 Oct 2023 21:05:44 +0200
Message-ID: <20231017190545.157282-5-bero@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
References: <20231017190545.157282-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add thermal nodes and thermal zones for the mt8192.

The mt8192 SoC has several hotspots around the CPUs.
Specify the targeted temperature threshold to apply the mitigation
and define the associated cooling devices.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: cosmetic changes, reduce lvts_ap size]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 454 +++++++++++++++++++++++
 1 file changed, 454 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 69f4cded5dbbf..238f6eb258323 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -14,6 +14,8 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt8192-power.h>
 #include <dt-bindings/reset/mt8192-resets.h>
+#include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/thermal/mediatek,lvts-thermal.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -72,6 +74,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&l2_0>;
 			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <427>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -90,6 +93,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&l2_0>;
 			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <427>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -108,6 +112,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&l2_0>;
 			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <427>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -126,6 +131,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_0>;
 			performance-domains = <&performance 0>;
 			capacity-dmips-mhz = <427>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -144,6 +150,7 @@ cpu4: cpu@400 {
 			next-level-cache = <&l2_1>;
 			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -162,6 +169,7 @@ cpu5: cpu@500 {
 			next-level-cache = <&l2_1>;
 			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -180,6 +188,7 @@ cpu6: cpu@600 {
 			next-level-cache = <&l2_1>;
 			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -198,6 +207,7 @@ cpu7: cpu@700 {
 			next-level-cache = <&l2_1>;
 			performance-domains = <&performance 1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu-map {
@@ -788,6 +798,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts_ap: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8192-lvts-ap";
+			reg = <0 0x1100b000 0 0xc00>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST0_THERM_CTRL_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1114,6 +1135,17 @@ nor_flash: spi@11234000 {
 			status = "disabled";
 		};
 
+		lvts_mcu: thermal-sensor@11278000 {
+			compatible = "mediatek,mt8192-lvts-mcu";
+			reg = <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			resets = <&infracfg MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "lvts-calib-data-1";
+			#thermal-sensor-cells = <1>;
+		};
+
 		efuse: efuse@11c10000 {
 			compatible = "mediatek,mt8192-efuse", "mediatek,efuse";
 			reg = <0 0x11c10000 0 0x1000>;
@@ -1899,4 +1931,426 @@ larb2: larb@1f002000 {
 			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
+
+			trips {
+				cpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
+
+			trips {
+				cpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
+
+			trips {
+				cpu2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
+
+			trips {
+				cpu3_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
+
+			trips {
+				cpu4_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
+
+			trips {
+				cpu5_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
+
+			trips {
+				cpu6_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
+
+			trips {
+				cpu7_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		vpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_VPU0>;
+
+			trips {
+				vpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_VPU1>;
+
+			trips {
+				vpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_GPU0>;
+
+			trips {
+				gpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_GPU1>;
+
+			trips {
+				gpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		infra-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_INFRA>;
+
+			trips {
+				infra_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				infra_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_CAM>;
+
+			trips {
+				cam_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cam_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD0>;
+
+			trips {
+				md0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD1>;
+
+			trips {
+				md1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		md2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8192_AP_MD2>;
+
+			trips {
+				md2_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				md2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.42.0

