Return-Path: <linux-kernel+bounces-141922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE88A2524
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA72F1F24EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519F1E535;
	Fri, 12 Apr 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dy59huM5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB851BF34;
	Fri, 12 Apr 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895956; cv=none; b=TCYLolYlN0gnnIx2zEnUfQ8TbNPgyNRed1gGLDIGqkTFagY+4qm3ZHANmqJ6B7H8L4CvYBT4m3RLXCRtAibGpd2WlIFscpz6mQmILUQCSpdF4yFSh9Z0GF9USogma2prlg8gLbvx6B0Gjn6u4BvC/Hk+4R9a4bYYCxSUuVKIb0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895956; c=relaxed/simple;
	bh=BkyUnGGOaQcbK4KNFXT6HX6K+wqUvohQB274FH/OrdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC8wz7mnx5FTUfzxmXysWdJDAjF5caHeJU3XqtI9iJLqQyb/pbmAp82MLWSSq5M4yszHSyRSy2gn8chzMLUGPM5yo3fMw36K6MCzbZKaq72/u8r5HfyzPLjJZzDJ/dVfws4gghH+FCZQb9RYyLluthwEa3XhGVeLcVBizeaQzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dy59huM5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4PngR067115;
	Thu, 11 Apr 2024 23:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712895949;
	bh=imYIw92Ktyb820EOSy1JBIBDzaCGydOh0id5xFJtl44=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dy59huM5T/PrK1NplPX1sZI9js0AjM8FL+7ywKnEshjiJ7xvfgFx6hNx4hRb6KcHu
	 fGbeIh1zjBKcGGgvVfyymIg8kv2Z2eRHspVWqtKhQBYiA0m7BKvO2Q8xwD//jCBuoj
	 gMQgNkB8pyZvK6hinmX0F2uc14Yk1vAF+/I403Zw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4PnSR123045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:25:49 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:25:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:25:48 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4PbNc078207;
	Thu, 11 Apr 2024 23:25:45 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v2 2/5] arm64: dts: ti: k3-j721e-mcu: Add the MCU domain watchdog instances
Date: Fri, 12 Apr 2024 09:55:34 +0530
Message-ID: <20240412042537.666137-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412042537.666137-1-n-francis@ti.com>
References: <20240412042537.666137-1-n-francis@ti.com>
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


