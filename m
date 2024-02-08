Return-Path: <linux-kernel+bounces-58056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44784E0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4C71C240DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900D762EC;
	Thu,  8 Feb 2024 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GLWJM4Tw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3A763E2;
	Thu,  8 Feb 2024 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395580; cv=none; b=ANVggIVUVCwzz3j5I3VKhW+/+HrqWjRJu25jG066nKiu03C/klgi8sCSyMci9zrID6ZCxTjX8v/UahYujSfMVpfUZM5b/xrtX2QcOtCthoEdBpVjus91QBJNXjb6QMNpHGOJ9Ay0jTk/1mCBIF/eThMAs3rM8165XL7i2asgLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395580; c=relaxed/simple;
	bh=Kowbehpe60bwqJMFI01pcXvPeoegiLcQe/sW0o7Z8sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBHNrRexKLU6pvhgpsor4+QRHXUcwo48a49k7pwZMUZyl3I4nx9Qri0fjr9O9KOz+r+G4i0jlgVRzYtz3tOtl2ox9Ex/FiWz0fFDQ4wOR9kD42zkasSqH6E6aoG3SY9iLtGS0WWudqP3G2+ipiiujmY5hqDEnh13mj6lbl1pHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GLWJM4Tw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418CWl4s031076;
	Thu, 8 Feb 2024 06:32:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707395567;
	bh=vFJTReo+YvdgCPMOvXasBur05DlcLCv9EjXrvlB3Fhc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GLWJM4TwhA75ft9s4ADaaelX1dGrEbmD/xoF9En3N+LF7cyl4em/OzBv1BrrFEiXu
	 XWVr2UsSdI1xJjo4XQGaZYLBW0MAkq01qm3caBa/TNELX7/jHKKcS75/fDfjCcGiy6
	 XcENbfEGr2rFAfoowELEgBiU2oDnkgFD1Yvbhkkg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418CWlu4006017
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 06:32:47 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 06:32:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 06:32:47 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418CWY1J074789;
	Thu, 8 Feb 2024 06:32:43 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <j-luthra@ti.com>, <afd@ti.com>
Subject: [PATCH v3 2/9] arm64: dts: ti: k3-j784s4-evm: Enable camera peripherals
Date: Thu, 8 Feb 2024 18:02:26 +0530
Message-ID: <20240208123233.391115-3-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208123233.391115-1-vaishnav.a@ti.com>
References: <20240208123233.391115-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

CSI cameras are controlled using I2C. On J784S4 EVM, this is routed
to I2C-5, so enable the instance and the TCA6408 GPIO expander
on the bus.

J784S4 EVM schematics: https://www.ti.com/lit/zip/sprr458

Reviewed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2: Update commit message with schematics.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 57e7cb8ea2b8..bb2558b68381 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -297,6 +297,13 @@ J784S4_IOPAD(0x0e4, PIN_INPUT_PULLUP, 0) /* (AP37) I2C0_SDA */
 		>;
 	};
 
+	main_i2c5_pins_default: main-i2c5-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x01c, PIN_INPUT, 8) /* (AG34) MCAN15_TX.I2C5_SCL */
+			J784S4_IOPAD(0x018, PIN_INPUT, 8) /* (AK36) MCAN14_RX.I2C5_SDA */
+		>;
+	};
+
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -761,6 +768,24 @@ exp2: gpio@22 {
 	};
 };
 
+&main_i2c5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c5_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp5: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CSI2_EXP_RSTZ", "CSI2_EXP_A_GPIO0",
+				  "CSI2_EXP_A_GPIO1", "CSI2_EXP_A_GPIO3",
+				  "CSI2_EXP_B_GPIO1", "CSI2_EXP_B_GPIO2",
+				  "CSI2_EXP_B_GPIO3", "CSI2_EXP_B_GPIO4";
+	};
+};
+
 &main_sdhci0 {
 	bootph-all;
 	/* eMMC */
-- 
2.34.1


