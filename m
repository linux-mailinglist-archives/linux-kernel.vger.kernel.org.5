Return-Path: <linux-kernel+bounces-141987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728E8A25CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9AD8B2182C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA771C6A6;
	Fri, 12 Apr 2024 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eesRr0Du"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B201799F;
	Fri, 12 Apr 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900233; cv=none; b=KtWK4cFY6NKpLqAwLyxKwBHIFkCCw/24O0chzo0SfO8f87oH+PSFeqcANhCIoaINbp0egsw2J3OOLsGhLSgUwEnMhDLkg3c6d0Z2EXS8lQlaV58ZeqyGRUmORNMPuGTo1MMV4l9GHB1cNyzAQN14Qz2m6FArHD09PSLlTL0HnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900233; c=relaxed/simple;
	bh=PJorbk8UfHx9OHUowPLKp3FPT/F3igaJ9JiDvkFhAoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PudRMKQ2a+Hbl97rZIB9h10XYFzyx7NHhWnsiZX8EZBTRfkBScD/F7/H0FuYaBYwkqCPCFZgNJesYCQatZkEibVt+EFbrz/Ad1uI70tohX72ROClakPdTUglVfd/C9yPbajjRGMOWckRw3MrBuSEZDy7ecXUGOTpcousLDp1ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eesRr0Du; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5b3AR127411;
	Fri, 12 Apr 2024 00:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900223;
	bh=B+ze190XEhuBE/aOUcoRakFhFQeYQvRXXay8abf33sg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eesRr0DuYx0qEjn4MZ6+wFRlEslcFjq1CEQTkgHedWsAereJ15P7H4mqokNa4hREj
	 tm6enCzIMkf6FZQhQHr30zBdlU+Tv0eJyxqLUj7YecSlusLwaDbnC2qXxL3WOXjdWe
	 3E1la+Y8PUcoE8bNHD5hfen5c+dbxOFTKbtmmHBU=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5b2oZ030035
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:37:03 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:37:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:37:01 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofZ085656;
	Fri, 12 Apr 2024 00:36:58 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
Date: Fri, 12 Apr 2024 11:06:47 +0530
Message-ID: <20240412053650.703667-3-n-francis@ti.com>
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

There are 2 watchdog instances in the MCU domain. These instances are
coupled with the MCU domain R55 instances. Reserve them as they are not
used by A72.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
Changes since v2:
- no changes

 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 3044e08f6858..0dc84c9f8c4a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -695,4 +695,30 @@ wkup_esm: esm@42080000 {
 		reg = <0x00 0x42080000 0x00 0x1000>;
 		status = "disabled";
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


