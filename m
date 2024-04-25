Return-Path: <linux-kernel+bounces-159191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A758B2A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70023282200
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE428155723;
	Thu, 25 Apr 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y5XGr9jK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3215250D;
	Thu, 25 Apr 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079582; cv=none; b=STLRhVcqBJ4h5FY/6zOLTzQLosoe+19Z0qEsQNg4S/Y8QyfhJ2u/yx25lBlEVPrEexbhcZuQmnCijjwdZtP3JYNUaWTU2ehODqnx+htKLaC0SqUYTVmyJ/LLkEOzrgX2IbgUHpl5LI6x2VrwIYrfC1D9EcpGThlrmvrWfeIkQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079582; c=relaxed/simple;
	bh=qMvlCDQbuSOhzu2TCiLq2O+vNb7KAMael1taBtLUPlA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCZ7dr1UcvFg3XwEntTz2LioDwj5+PRfHcR2kr4ti1Qp/qZGzqwUspcs3vM/B4t924+pvVjm0TFdTDXAzQaA7b1vVV5BIjEZ81kgn3wOpubdpefCjKA2ojRtF5iw0W/nwvEeCZ3RTEDpdlg5eHyCm3kTms/ripG5wadHIOMHFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y5XGr9jK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCmgL036992;
	Thu, 25 Apr 2024 16:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714079568;
	bh=krzuIm4HdbO9vTolPgQZarG+X32VSLpgqIn5uyq5zSA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y5XGr9jKcaVHwRBoKdjwguaKjT4ihnwcIPzT+54yKMyq4zgera7Js6Y3L8rM1GjIx
	 O4fxMINv2VYPIHr7lRhp+YNH/3tfRHye931DeX0IiIemZAiMI6EdbO+g2mBpsRClFa
	 jNBfaG8k10USGKv2VZbeRyJ9o9PronVHasMrV+a8=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLCmWJ027322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 16:12:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:12:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:12:48 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCYHF038718;
	Thu, 25 Apr 2024 16:12:45 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v4 3/6] arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
Date: Fri, 26 Apr 2024 02:42:30 +0530
Message-ID: <20240425211233.2006233-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425211233.2006233-1-n-francis@ti.com>
References: <20240425211233.2006233-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

There are 10 watchdog instances in the MAIN domain:
	* one each for the 2 A72 cores
	* one for the GPU core
	* one for the C7x core
	* one each for the 2 C66x cores
	* one each for the 4 R5F cores

Currently, the devicetree only describes watchdog instances for the A72
cores and enables them. Describe the remaining but reserve them as they
will be used by their respective firmware.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
Changes since v2:
- no changes

 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 93 +++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c7eafbc862f9..0dd5005b34aa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2157,6 +2157,99 @@ watchdog1: watchdog@2210000 {
 		assigned-clock-parents = <&k3_clks 253 5>;
 	};
 
+	/*
+	 * The following RTI instances are coupled with MCU R5Fs, c7x and
+	 * GPU so keeping them reserved as these will be used by their
+	 * respective firmware
+	 */
+	watchdog15: watchdog@22f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x22f0000 0x00 0x100>;
+		clocks = <&k3_clks 257 1>;
+		power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 257 1>;
+		assigned-clock-parents = <&k3_clks 257 5>;
+		/* reserved for GPU */
+		status = "reserved";
+	};
+
+	watchdog16: watchdog@2300000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2300000 0x00 0x100>;
+		clocks = <&k3_clks 256 1>;
+		power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 256 1>;
+		assigned-clock-parents = <&k3_clks 256 5>;
+		/* reserved for C7X */
+		status = "reserved";
+	};
+
+	watchdog24: watchdog@2380000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2380000 0x00 0x100>;
+		clocks = <&k3_clks 254 1>;
+		power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 254 1>;
+		assigned-clock-parents = <&k3_clks 254 5>;
+		/* reserved for C66X_0 */
+		status = "reserved";
+	};
+
+	watchdog25: watchdog@2390000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x2390000 0x00 0x100>;
+		clocks = <&k3_clks 255 1>;
+		power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 255 1>;
+		assigned-clock-parents = <&k3_clks 255 5>;
+		/* reserved for C66X_1 */
+		status = "reserved";
+	};
+
+	watchdog28: watchdog@23c0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23c0000 0x00 0x100>;
+		clocks = <&k3_clks 258 1>;
+		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 258 1>;
+		assigned-clock-parents = <&k3_clks 258 5>;
+		/* reserved for MAIN_R5F0_0 */
+		status = "reserved";
+	};
+
+	watchdog29: watchdog@23d0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23d0000 0x00 0x100>;
+		clocks = <&k3_clks 259 1>;
+		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 259 1>;
+		assigned-clock-parents = <&k3_clks 259 5>;
+		/* reserved for MAIN_R5F0_1 */
+		status = "reserved";
+	};
+
+	watchdog30: watchdog@23e0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23e0000 0x00 0x100>;
+		clocks = <&k3_clks 260 1>;
+		power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 260 1>;
+		assigned-clock-parents = <&k3_clks 260 5>;
+		/* reserved for MAIN_R5F1_0 */
+		status = "reserved";
+	};
+
+	watchdog31: watchdog@23f0000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x23f0000 0x00 0x100>;
+		clocks = <&k3_clks 261 1>;
+		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 261 1>;
+		assigned-clock-parents = <&k3_clks 261 5>;
+		/* reserved for MAIN_R5F1_1 */
+		status = "reserved";
+	};
+
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j721e-r5fss";
 		ti,cluster-mode = <1>;
-- 
2.34.1


