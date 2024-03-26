Return-Path: <linux-kernel+bounces-119720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C488CC66
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8088BB21DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B0513C8E8;
	Tue, 26 Mar 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L2KsZyKR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E93DABF5;
	Tue, 26 Mar 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479300; cv=none; b=Uehzc01l8XdsJbobYsbnCcp+WFYdmiF61yffxLu+GE91r/MCuGYOYa1B+MQUj3lmiKStjulWD5rut65Kvt7NZrmtcU6rlW6h9/MsEFA6Jb9pTETme+2qQDK9k4j3jpyndlG2VVUW6wMHJ4rsCAb7pA83R5m4nLvnHffmMou8ikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479300; c=relaxed/simple;
	bh=9djSkKnmuC7i4pPzsNPWHP/5d7XeUO60ZfAE7+auKsQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SqqH5TlatTt7r1YAI6jP9HWOXXSrBaWcItQ16vbBI3k5qtkqXJQ3AfefU/7nf9WcrR8hBbIa5Pn4/yO5url/qRzP/ZHzY41vxbeHbVJpgAQFKsMO2frdD0C/4EG2jar/S4TT+wvkY+02cdCEDB6evs/cD77Puy0jvJpjC+Q+2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L2KsZyKR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsgiY066709;
	Tue, 26 Mar 2024 13:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479282;
	bh=8cJ9129Ob8CCElav7kn38Mvyr3xFZdbL8GeEi/r+r6A=;
	h=From:To:CC:Subject:Date;
	b=L2KsZyKR6HktEPNjnKnI3zodcPAnSBAUnxww+Imw80H+bLIC8vO3hKdwjFwy7LC/a
	 drAah5RszVEhYnfPgzvTuZwv3uJ21mfMG6IBc9PUm1IQ928UZCV1azXFA7qqknhMat
	 EbaMiQ6OtY8vBAXyKpNUJUtuq5Z9Cboy9+Z3T8wI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIsgdx027796
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:54:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:54:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:54:42 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIsfIj091446;
	Tue, 26 Mar 2024 13:54:41 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/6] arm64: dts: ti: k3-am65: Remove UART baud rate selection
Date: Tue, 26 Mar 2024 13:54:36 -0500
Message-ID: <20240326185441.29656-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

As described in the binding document for the "current-speed" property:

"This should only be present in case a driver has no chance to know the
baud rate of the slave device."

This is not the case for the UART used in K3 devices, the current
baud-rate can be calculated from the registers. Having this property
has the effect of actually skipping the baud-rate setup in some drivers
as it assumes it will already be set to this rate, which may not always
be the case.

It seems this property's purpose was mistaken as selecting the desired
baud-rate, which it does not. It would have been wrong to select that
here anyway as DT is not the place for configuration, especially when
there are already more standard ways to set serial baud-rates.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 1 -
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi    | 1 -
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ff857117d7193..670557c89f756 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -89,7 +89,6 @@ main_uart0: serial@2800000 {
 		reg = <0x00 0x02800000 0x00 0x100>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 6ff3ccc39fb44..4f808e5089755 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -43,7 +43,6 @@ mcu_uart0: serial@40a00000 {
 		reg = <0x00 0x40a00000 0x00 0x100>;
 		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <96000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 37527890ddeaf..eee072e44a42f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -59,7 +59,6 @@ wkup_uart0: serial@42300000 {
 		reg = <0x42300000 0x100>;
 		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
-		current-speed = <115200>;
 		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
-- 
2.39.2


