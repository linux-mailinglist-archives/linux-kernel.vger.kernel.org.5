Return-Path: <linux-kernel+bounces-21308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0242828D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11B31C247BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59343D3A6;
	Tue,  9 Jan 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW9EE9tK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C03D386;
	Tue,  9 Jan 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e54f233abso1346965e9.0;
        Tue, 09 Jan 2024 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828397; x=1705433197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umKNw6oY7W/GC+6PKYH46lfy8g9nHWoaPdVcGAt9mEE=;
        b=IW9EE9tK7dJ5sgOwOYNn/PY4cTYpwgiVpD/GzOHyygXm58gMRrCE96yPz0tg5iH58r
         0U61UbetVkhMvhFnxoAi6zZg7RxLzyrZFfnAjCXl5tcDkfHkMCYIkkrWzdLt4D1kdDP/
         odBYzivK89nDCW+ufshIKTMxeRYe2U/MKZZEQ3x5SflUj1BqSHnTBD51neeHEu+CAQD2
         mckk81MWK8ZjwzDigdpciPBLMSd4yKc2VtCxUWd27mSuKUDOW4QZqX8j0BF9gu4K+sIE
         GuDyGGWORqm7ddzFnBWXnjccapM94d0B9hUo7kGfLf/97gNbyBqdRS26ShK4oEnhStH5
         qGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828397; x=1705433197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umKNw6oY7W/GC+6PKYH46lfy8g9nHWoaPdVcGAt9mEE=;
        b=ITMAFj3UhWMC0WM/hzA7eOkIM3Zdcz/LtjYxV6NEGE4PkeQzmx3Zeuwo92BtSoyBIy
         2Zg1rNZX4tOV9sfy66VZgmdCxC6afg0hU3RijEeGnNjkn/9rTv2dDAts2Xmi6hC72mv2
         U37mt/gVvyPeFMz0CXjrNmo9EUmf3Njk7CxdfnI9C/cxWd7hy+3v4a7H8h/Ale4Nadka
         yBDmZ/FS7G6NgHONeG1pjC8ym3Uo/PMvX6lmhQfdHhhsESFTYHZ+FDJZCjtrkdBUi/hW
         d49KeDrvpL0z0E/dLWmMPiuy0XzeRn8oMoR5uTy0z6rGMDltO6t/5rTG/tFZ8ngU4unw
         2qJQ==
X-Gm-Message-State: AOJu0YwRjYHLZDiZ+obJ5ckDD30b14WP160uAxUzr1Be6y9jcGRbii8P
	72TsF5QkiddGH+YnOGA9fog=
X-Google-Smtp-Source: AGHT+IH0KeqbQuZiWB45O+iblu+q55Y/2sxdc4eSxm5+N49hgpfamlc2UgeXUeBY/5CoXA6u0w7Z5w==
X-Received: by 2002:a7b:c4d1:0:b0:40e:4aed:ad27 with SMTP id g17-20020a7bc4d1000000b0040e4aedad27mr1281983wmk.144.1704828397241;
        Tue, 09 Jan 2024 11:26:37 -0800 (PST)
Received: from latitude-fedora.lan ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c138700b0040d62f97e3csm15672468wmf.10.2024.01.09.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:26:36 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Christopher Obbard <chris.obbard@collabora.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Chris Morgan <macromorgan@hotmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: enable built-in thermal monitoring on rk3588
Date: Tue,  9 Jan 2024 23:19:47 +0400
Message-ID: <20240109192608.5981-1-alchark@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106222357.23835-1-alchark@gmail.com>
References: <20240106222357.23835-1-alchark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include thermal zones information in device tree for rk3588 variants
and enable the built-in thermal sensing ADC on RADXA Rock 5B

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v2:
 - Dropped redundant comments
 - Included all CPU cores in cooling maps
 - Split cooling maps into more granular ones utilizing TSADC
   channels 1-3 which measure temperature by separate CPU clusters
   instead of channel 0 which measures the center of the SoC die
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 151 ++++++++++++++++++
 2 files changed, 155 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index a5a104131403..f9d540000de3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -772,3 +772,7 @@ &usb_host1_ehci {
 &usb_host1_ohci {
 	status = "okay";
 };
+
+&tsadc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 8aa0499f9b03..8d54998d0ecc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -2112,6 +2113,156 @@ tsadc: tsadc@fec00000 {
 		status = "disabled";
 	};
 
+	thermal_zones: thermal-zones {
+		/* sensor near the center of the whole chip */
+		soc_thermal: soc-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			sustainable-power = <2100>;
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				soc_crit: soc-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		/* sensor between A76 cores 0 and 1 */
+		bigcore0_thermal: bigcore0-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				bigcore0_alert: bigcore0-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore0_crit: bigcore0-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&bigcore0_alert>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* sensor between A76 cores 2 and 3 */
+		bigcore2_thermal: bigcore2-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				bigcore2_alert: bigcore2-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				bigcore2_crit: bigcore2-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map1 {
+					trip = <&bigcore2_alert>;
+					cooling-device =
+						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* sensor between the four A55 cores */
+		little_core_thermal: littlecore-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				littlecore_alert: littlecore-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				littlecore_crit: littlecore-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map2 {
+					trip = <&littlecore_alert>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* sensor near the PD_CENTER power domain */
+		center_thermal: center-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				center_crit: center-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				gpu_crit: gpu-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		npu_thermal: npu-thermal {
+			polling-delay-passive = <20>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsadc 6>;
+
+			trips {
+				npu_crit: npu-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	saradc: adc@fec10000 {
 		compatible = "rockchip,rk3588-saradc";
 		reg = <0x0 0xfec10000 0x0 0x10000>;
-- 
2.43.0


