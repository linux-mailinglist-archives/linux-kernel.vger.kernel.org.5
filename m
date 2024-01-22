Return-Path: <linux-kernel+bounces-34130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86383740E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE789290902
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29547F70;
	Mon, 22 Jan 2024 20:40:46 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD147A40;
	Mon, 22 Jan 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956046; cv=none; b=Kn9sSa0m/V2qG6xZCh32hzV7agcovPr9x8i+49tP1b/A57Qp397e/b0O9SjA5kvCqjj0Mwz9/UXYMcIluhEzPGc1gKvWTOn4QF95hKd20ug8XJxe+J+ap91xZLUdVT28ad9Ks233YOZBHcCKY9yZUS54Q0irUv3siAjy7/ICZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956046; c=relaxed/simple;
	bh=95e9LKMr1i7TcQv/j6xkAELrGzQGpKGG89U02mGQQO4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nT+3KMD75mP6+bjidCA3lsYvr5eQ4BQR1erCG+JNJPx6ALu2q+Bb4oSMAdbkAOhoLJkuA8kNBp0F7GXddSasndH2DhTQrUaEJcWiynYPRgYZVet1hkIKBB11hHgPyLx2Xxh0oXMrVuzCNHaod4TpLsP1ODwUwn+w9SssSecx76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 371E5DDADC3; Mon, 22 Jan 2024 21:35:15 +0100 (CET)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <szucst@iit.uni-miskolc.hu>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	John Clark <inindev@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Andy Yan <andy.yan@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: Add the rk3588 thermal zones
Date: Mon, 22 Jan 2024 21:34:57 +0100
Message-ID: <20240122203502.3311520-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122203502.3311520-1-linkmauve@linkmauve.fr>
References: <20240122203502.3311520-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver got added back in 45d7b3867a5cabb97fc31f16122cda8540c3a30c,
but the dts never got updated, so here it is!

I’ve added it to the rk3588s because that’s where most of the
definitions are, but I’ve only tested on a rk3588 so maybe there are
subtle changes.

The rk3588 TRM also documents slightly different values (in part 1
section 14.5.3) than the driver, but I’ve left the values alone since I
have no way to determine which one is (more) correct.

Only the CPU is properly mapped, as neither the GPU nor the NPU have
been added to the dts for now, I’ve left some TODOs there.

All of the thermal zones report almost the same value on my rock-5b
board, I’m not sure if this is due to a programming error or if this is
to be expected.  For instance, after running for a while, all of the
zones report 44384 m℃, despite having used neither the GPU nor the NPU.

Additionally, the alert and crit temperatures have been arbitrarily
chosen based on other dts files, not based on any knowledge of the
thermal behaviours of this specific SoC.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 181 ++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 36b1b7acfe6a..c7a2078960b7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/reset/rockchip,rk3588-cru.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/ata/ahci.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3588";
@@ -436,6 +437,186 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	thermal_zones: thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				soc_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				soc_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&soc_alert>;
+					cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				cluster1_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cluster1_alert>;
+					cooling-device = <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster2-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				cluster2_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster2_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cluster2_alert>;
+					cooling-device = <&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				cluster0_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cluster0_alert>;
+					cooling-device = <&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+					                 <&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		center-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				center_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				center_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				/* TODO: what exactly is "center"? */
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				gpu_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				/* TODO: Add the GPU here once it is supported. */
+			};
+		};
+
+		npu-thermal {
+			polling-delay-passive = <250>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+			thermal-sensors = <&tsadc 6>;
+
+			trips {
+				npu_alert: trip-alert {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				npu_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				/* TODO: Add the NPU here once it is supported. */
+			};
+		};
+	};
+
 	usb_host0_ehci: usb@fc800000 {
 		compatible = "rockchip,rk3588-ehci", "generic-ehci";
 		reg = <0x0 0xfc800000 0x0 0x40000>;
-- 
2.43.0


