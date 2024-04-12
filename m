Return-Path: <linux-kernel+bounces-141989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078248A25CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB191C22B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D23611D;
	Fri, 12 Apr 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J6jIC9QL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB21B974;
	Fri, 12 Apr 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900235; cv=none; b=tk377yGC4Bz85V7fGfgGrk2DCfojUfpHVfRBbHbbuxk8Svz3VF/HwCeXFux5rlccojifmN0WQtlGY5LaONBkne6X/dsWbu5jRJDcAeG7Fyhb41faDQ1SCuqbVTqyuKpEt7xiuAw5kakn/x0g9pj7CK+GiBpKBjPLFCxKnO9DzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900235; c=relaxed/simple;
	bh=qMvlCDQbuSOhzu2TCiLq2O+vNb7KAMael1taBtLUPlA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQvHiQDA4tZ0Eyv08baf/3B4jLnavxI1kXxOlVyhgiWIsrwGfCR6LLzPQIwTlNCDI5CG3Qzt+mH0qaXYLzdbawnkDLwTR2cXSoT7nEQZrTmmEbCUNQAB0u5ZRkALERuZaB05uubhNvZHYqI3qMDbH8sPO1QJE1DF3Euos5kmeL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J6jIC9QL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5b5sr080377;
	Fri, 12 Apr 2024 00:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900225;
	bh=krzuIm4HdbO9vTolPgQZarG+X32VSLpgqIn5uyq5zSA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J6jIC9QLbqBZRDtQGqV2fPl3X00iOVI/QvR+PIky+TZdUxqvs1Lhj8e0ay55zlw3p
	 BGbzF+uUVi6vkQUdzSyBmWUCJtVhP7i2aZV9P7cpa+61S9lmQClfmUSjUfKVC/Gk2P
	 ZFX1yyWOIDDScO03BqMPMrbB6vrHKw/aVfAXzgHI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5b5QG054887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:37:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:37:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:37:04 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofa085656;
	Fri, 12 Apr 2024 00:37:02 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 3/5] arm64: dts: ti: k3-j721e-main: Add the MAIN domain watchdog instances
Date: Fri, 12 Apr 2024 11:06:48 +0530
Message-ID: <20240412053650.703667-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412053650.703667-1-n-francis@ti.com>
References: <20240412053650.703667-1-n-francis@ti.com>
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


