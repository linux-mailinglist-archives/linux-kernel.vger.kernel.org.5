Return-Path: <linux-kernel+bounces-118974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FC88C21C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6585B218F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E6D75819;
	Tue, 26 Mar 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dY/WXqGb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD9757FD;
	Tue, 26 Mar 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456069; cv=none; b=aGg0ySmxY8O4ZqtjGqoxOaBcuZesB45O6hJVclPRKq3YB2P96rhHAEFd+IZahtWCrvusg9nbQFOo9qDobC0eENk45r9x1EaH8ibJPEqoBTvG7asVtowXCZliaURQmFlH+g/WZP4Gs4aBdWKSKdWmWRrT4yPxC7RpgTy0R5J1tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456069; c=relaxed/simple;
	bh=HgxjDdKKE3xgr/GUmAgsGai4pR3iNJLACr9iwbv1oaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccuzrpRPuf8nHtvrZ5kJ/LU3lQhFUzSBodmYJQ9Y0t4s4SlQoByWoXaE59gmIxRK2J6M3/fVi2M+MTV+6GP8j973QewghQxDlFVfwuytsB9Q8HYcVjgte5CCfDwoibSdKSYKvdv0RCEPhQXux8hzUl18K+psrodSdsLbAKW7jcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dY/WXqGb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRcea046389;
	Tue, 26 Mar 2024 07:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456058;
	bh=fZ+a7lwRcnYKmAMClpBVo++CIHuT6moaDjHA7CT3+n4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dY/WXqGbvbCe6vNPRiJC37iv5LsIzQauTm00iupkaN+hB4qQPWVnOP9ASMGkJwStm
	 X7M/6GRLA/ztnNAXxlejlTm6NoFfH1jSMWlsI+LIZNWBzBcpgP0ZD+US6vwp/wm0Gd
	 VXV90wEKvSOzTSQVX9JRLB2vXVmV1Cg5J+j+SS4k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRcZU017085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:27:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:37 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRN2e129435;
	Tue, 26 Mar 2024 07:27:34 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
Date: Tue, 26 Mar 2024 17:57:22 +0530
Message-ID: <20240326122723.2329402-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326122723.2329402-1-n-francis@ti.com>
References: <20240326122723.2329402-1-n-francis@ti.com>
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
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 93 +++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index c7eafbc862f9..d8930b8ea8ec 100644
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
+	watchdog2: watchdog@22f0000 {
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
+	watchdog3: watchdog@2300000 {
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
+	watchdog4: watchdog@2380000 {
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
+	watchdog5: watchdog@2390000 {
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
+	watchdog6: watchdog@23c0000 {
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
+	watchdog7: watchdog@23d0000 {
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
+	watchdog8: watchdog@23e0000 {
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
+	watchdog9: watchdog@23f0000 {
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


