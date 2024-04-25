Return-Path: <linux-kernel+bounces-159195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE618B2A84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20EB1C20C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D7B156249;
	Thu, 25 Apr 2024 21:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tqTtWCYm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D23155A55;
	Thu, 25 Apr 2024 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079589; cv=none; b=u7t4DHK7w8Q7s99HuQxK2FdShpzPtRX3+aQplXxBj/VCXsQSyTOFr1prJoespBpfoRbpvtY9qX4taRaEaFOrYf4SjHyqDO6ib3hus+yGBZn2HLVJp5jzQilPnz9/ZZ6FQ6hN10NVe1lSBNwHTC90t6LwF6UT/9gN9t6mgL+CHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079589; c=relaxed/simple;
	bh=PJorbk8UfHx9OHUowPLKp3FPT/F3igaJ9JiDvkFhAoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLlMdmWnNSJB4dW0XbxBSleu8IgdqFj197LSI8XtyK7vbAG4a6q7I/KhT6RrpAfOQCLeysMbC4G+7WzkNVSAz0euY6nwzaoFfr3820PNhtc2qjVbIQd3/0Z2vj2tpvp+Vj0WuqtGFkxLhmxfR8VoE0NiHUgg9IhJLtYQvLdIHoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tqTtWCYm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCjxk026544;
	Thu, 25 Apr 2024 16:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714079565;
	bh=B+ze190XEhuBE/aOUcoRakFhFQeYQvRXXay8abf33sg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tqTtWCYmIv/z0MySVzsGzAWIujdkYENAh6+o9fpY46UjeORNUWjaUt0/pUavyiwJi
	 peONxY0uq7Ev6QsyMEhJ/szZ0gQzSkt48xFhlXB3wWzPBnKw/sPgALCJE/b6pH/KC/
	 XAmKxrEEuqcB2ijALhSWzxi1WDZ4UF4uhtz+Gjrk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PLCjhe031195
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 16:12:45 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 16:12:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 16:12:44 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PLCYHE038718;
	Thu, 25 Apr 2024 16:12:41 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v4 2/6] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
Date: Fri, 26 Apr 2024 02:42:29 +0530
Message-ID: <20240425211233.2006233-3-n-francis@ti.com>
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


