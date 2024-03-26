Return-Path: <linux-kernel+bounces-118976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8C88C222
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047581C3B1B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441F7442E;
	Tue, 26 Mar 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pam9+/Z6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36547F7E6;
	Tue, 26 Mar 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456076; cv=none; b=TpO21mBw1kT0ZPLJMb1KavqbtuLPqQ5t89Sg8Q1+mLv1SmQ6R2I43pA5s4HRPU1V/bDg/jjQ5FAbZ2a0QV6jRXX9jJunFT7dup9JPV+w57JSd1/36xrcmQdQtmttP1HW+r2JIb6ZJ7mzCeaBZjHSoPbgwqioyoaNkFgEZaYqB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456076; c=relaxed/simple;
	bh=WipEGw9/6sXRhSUjr25HJ2FZPmEromleQAPMG6tk9sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0r2n2AvtG3iSXX3UQ0S28qsqjwVFhHtCoet2cS6a62fvhnbio+9WSlarziAa+73QkM14GvNJ9slwQDQwLsegWAR/rKTrqR/QEY6WAexUHFf3D0FbYlsniwbBj9b2KwJjFwlbSblTMdDcalrpQmtKsBOGp5knBvDsjblrMiimAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Pam9+/Z6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRYOl081417;
	Tue, 26 Mar 2024 07:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456054;
	bh=SI+HU37Nn6YoT5yQL/rjlCRJM6US/YLloi1oqcft1a8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Pam9+/Z6Gqf4bLlHznWx4cCDgfLXyHv658Gdn7XyJ+qgig0rBpWToHrIh9uWT1cnL
	 sHZbseb+8Fp/3ENcU9LuWM/+cRvMv8vWgUmVREkmTubxkwV5Suz22QVUcVyTjUEj9O
	 KLuC65NcibUBk6AEBV4qk4zAFSgMWwrC+x1jIKiM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRYUa035211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:27:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:34 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRN2d129435;
	Tue, 26 Mar 2024 07:27:31 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
Date: Tue, 26 Mar 2024 17:57:21 +0530
Message-ID: <20240326122723.2329402-3-n-francis@ti.com>
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

There are 2 watchdog instances in the MCU domain. These instances are
coupled with the MCU domain R55 instances. Reserve them as they are not
used by A72.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index b0f41e9829cc..867f307909be 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -694,4 +694,30 @@ wkup_esm: esm@42080000 {
 		compatible = "ti,j721e-esm";
 		reg = <0x00 0x42080000 0x00 0x1000>;
 	};
+
+	/*
+	 * The 2 RTI instances are couple with MCU R5Fs so keeping them
+	 * reserved as these will be used by their respective firmware
+	 */
+	mcu_watchdog0: watchdog@40600000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40600000 0x00 0x100>;
+		clocks = <&k3_clks 262 1>;
+		power-domains = <&k3_pds 262 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 262 1>;
+		assigned-clock-parents = <&k3_clks 262 5>;
+		/* reserved for MCU_R5F0_0 */
+		status = "reserved";
+	};
+
+	mcu_watchdog1: watchdog@40610000 {
+		compatible = "ti,j7-rti-wdt";
+		reg = <0x00 0x40610000 0x00 0x100>;
+		clocks = <&k3_clks 263 1>;
+		power-domains = <&k3_pds 263 TI_SCI_PD_EXCLUSIVE>;
+		assigned-clocks = <&k3_clks 263 1>;
+		assigned-clock-parents = <&k3_clks 263 5>;
+		/* reserved for MCU_R5F0_1 */
+		status = "reserved";
+	};
 };
-- 
2.34.1


