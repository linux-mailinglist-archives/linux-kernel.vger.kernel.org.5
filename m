Return-Path: <linux-kernel+bounces-68672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7A857E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28519B22DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95612C520;
	Fri, 16 Feb 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D0vTeH6i"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94E12BEA5;
	Fri, 16 Feb 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091750; cv=none; b=HipsJNY0xEGQm8FvEyCV0XR3BUrZBwv6KOnqFIrYFTDI+Vjn7tMiFLS+rvQAry06UCxnJqk+Ogcx2ww8QaRVFl4irKuwbR0+1t+W7tPtg/ciKc6/plAzRmYjhkNsadyJAQECc8b0yEzHku/dOivzXA/CYALBI5opBTWD3BY1ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091750; c=relaxed/simple;
	bh=wk1n0oWjh34QbIeqz7ZNkSxon2SKxcvJK+7DW2eQqgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pya6G4fj2vChfGTNOHw+H/eSaLXtBtALgoG8R5DYBe4fr1TZZ/+dvHpDv9IhuyVwqQbIC2rpflSVP5SPM9P1Qn3gb68Wc+14y4NDoOrj+5e2wgGLGLvB+VHb9uR1JlusTiSzIbFNlqIB4OdUHkk1OQlqyon4iZ24ciJMF69DVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D0vTeH6i; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtfk7095614;
	Fri, 16 Feb 2024 07:55:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708091741;
	bh=F9VQ5cICpZyC3r18cZBGn07fwGkoD+GP7y8K4AAm+eI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D0vTeH6iRGxWDLIMUVjHx1yZA+fx/gdkMIEGg4Oc7/0GcccVZag+dRB0KmnzAj5TH
	 8C34jyf+tR208prQcQBZ9S/oTJv2q8PRAjl0TJKbcgSB/I9+THXPtNaS7YsQQutNUp
	 V997ubZuN8vS5k62LKS/9c3YvFuAYBhY59hyrqsE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GDtfnG004093
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 07:55:41 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 07:55:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 07:55:40 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GDtXrT127060;
	Fri, 16 Feb 2024 07:55:37 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1
Date: Fri, 16 Feb 2024 19:25:32 +0530
Message-ID: <20240216135533.904130-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216135533.904130-1-vaishnav.a@ti.com>
References: <20240216135533.904130-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Enable MAC Port 1 of CPSW3G instance of CPSW Ethernet Switch in
RGMII-RXID mode of operation. Port 2 is not connected on the EVM,
thus keep it disabled.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index b4f2fee53a97..9e12a6e9111f 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/net/ti-dp83867.h>
 #include "k3-j722s.dtsi"
 
 / {
@@ -160,6 +161,58 @@ J722S_IOPAD(0x0240, PIN_INPUT, 0) /* (B24) MMC1_SDCD */
 		>;
 		bootph-all;
 	};
+
+	mdio_pins_default: mdio-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
+			J722S_IOPAD(0x015c, PIN_INPUT, 0) /* (AD25) MDIO0_MDIO */
+		>;
+	};
+
+	rgmii1_pins_default: rgmii1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x014c, PIN_INPUT, 0) /* (AC25) RGMII1_RD0 */
+			J722S_IOPAD(0x0150, PIN_INPUT, 0) /* (AD27) RGMII1_RD1 */
+			J722S_IOPAD(0x0154, PIN_INPUT, 0) /* (AE24) RGMII1_RD2 */
+			J722S_IOPAD(0x0158, PIN_INPUT, 0) /* (AE26) RGMII1_RD3 */
+			J722S_IOPAD(0x0148, PIN_INPUT, 0) /* (AE27) RGMII1_RXC */
+			J722S_IOPAD(0x0144, PIN_INPUT, 0) /* (AD23) RGMII1_RX_CTL */
+			J722S_IOPAD(0x0134, PIN_OUTPUT, 0) /* (AF27) RGMII1_TD0 */
+			J722S_IOPAD(0x0138, PIN_OUTPUT, 0) /* (AE23) RGMII1_TD1 */
+			J722S_IOPAD(0x013c, PIN_OUTPUT, 0) /* (AG25) RGMII1_TD2 */
+			J722S_IOPAD(0x0140, PIN_OUTPUT, 0) /* (AF24) RGMII1_TD3 */
+			J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
+			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
+		>;
+	};
+};
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii1_pins_default>;
+};
+
+&cpsw3g_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins_default>;
+
+	cpsw3g_phy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		ti,min-output-impedance;
+	};
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy0>;
+};
+
+&cpsw_port2 {
+	status = "disabled";
 };
 
 &main_gpio1 {
-- 
2.34.1


