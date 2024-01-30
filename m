Return-Path: <linux-kernel+bounces-44377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C284211B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042E51C25BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFC60DC9;
	Tue, 30 Jan 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s2GxSyS5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C960DCD;
	Tue, 30 Jan 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610066; cv=none; b=K0zRZF1R28sPZja8ywr5INfQhj0KSw6kX4aWYW6Gj2/K2h90W5PetBtEWaYC2+fOhP5dlerYRTCg/tQhoYWX3Mhn/O2KgTGXaE+zc2ue60Xp0Iq3ssmQsm8KjchGOBjckboaqZGydYzg8DMt/qpf7Wcc6BCocuuVmVCMTo3tDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610066; c=relaxed/simple;
	bh=Ln5qtZbq4GXL1pkD6vt5CVkCif/cs0b9QjnMmkxlkco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+x5fsTWAV9E+F3Smsqor+LV1Q2yaKT199kCqPih5yo2FB/xF6k2a+gz2g7uoYVADPdaUruko9USOcuA5imjcUYEDK3VY8YW+ixiT0fnuoxa2R0wUM/nRYhAWXJBNi4xJ/zrMLTNnzEfhlIJiUOeDhc2b6Be0hZCbMsGtvIKNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s2GxSyS5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKm60037220;
	Tue, 30 Jan 2024 04:20:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706610048;
	bh=pcQtRcrtFveeIY8xzn2syKr87JyPBybxp9LnMqt5Iy0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=s2GxSyS53SDfzjUWl817nIL/XjscGbOxkJH70zRHVAs9IvqcgDYXlfNUPRh36OSkt
	 fh1E1+vVv/V/OtVIK7yYgr6C0LxXOl6r78JJTNqmK0bcBwv0W94NffI0Ef6TvT6PU9
	 gLw+D5x+jOcLHX6stGKJGoL6qrf/qE41QD5rmobU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UAKmMi129943
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 04:20:48 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 04:20:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 04:20:48 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UAKln4027139;
	Tue, 30 Jan 2024 04:20:48 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j7200-som-p0: Add support for CAN instance 0 in main domain
Date: Tue, 30 Jan 2024 15:50:43 +0530
Message-ID: <20240130102044.120483-3-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130102044.120483-1-b-kapoor@ti.com>
References: <20240130102044.120483-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CAN instance 0 in the main domain is brought on the J7200 SoM through
header J1. Thus, Add transceiver dt node to add support for this CAN
instance.

Also, add the mux dt nodes to route CAN High and Low lines coming
from the SoC to the Common Processor Board.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
index ea47f10d393a..0010600b8176 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
@@ -5,6 +5,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "k3-j7200.dtsi"
 
 / {
@@ -80,6 +82,25 @@ rtos_ipc_memory_region: ipc-memories@a4000000 {
 			no-map;
 		};
 	};
+
+	mux0: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	mux1: mux-controller {
+		compatible = "gpio-mux";
+		#mux-state-cells = <1>;
+		mux-gpios = <&exp_som 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	transceiver0: can-phy0 {
+		/* standby pin has been grounded by default */
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <5000000>;
+	};
 };
 
 &wkup_pmx0 {
@@ -142,6 +163,13 @@ J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
 			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
 		>;
 	};
+
+	main_mcan0_pins_default: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x24, PIN_INPUT, 0) /* (V20) MCAN0_RX */
+			J721E_IOPAD(0x20, PIN_OUTPUT, 0) /* (V18) MCAN0_TX */
+		>;
+	};
 };
 
 &hbmc {
@@ -478,3 +506,10 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&main_mcan0 {
+	status = "okay";
+	pinctrl-0 = <&main_mcan0_pins_default>;
+	pinctrl-names = "default";
+	phys = <&transceiver0>;
+};
-- 
2.34.1


