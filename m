Return-Path: <linux-kernel+bounces-141990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E28A25D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49565B24508
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2591B974;
	Fri, 12 Apr 2024 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TPqWfa6m"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E403E48E;
	Fri, 12 Apr 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900238; cv=none; b=uf0DTq5kMZjL1fot0z5czoHmOqihIuJvMOHBuUaIzvU4w+AV2tAbKvGv31CTgmnULI5dSaVquXoUcaYzAKjiI4vk8gUXHkJnBx5/oE41WAOLXqtur/7ISsosLBCaiTjIsi0dkBWqV8gCo/S2r+7eNC3bpN5/WNETIv3hsh2/JE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900238; c=relaxed/simple;
	bh=tM5gY3hKJtDCzLYczWVGATv3eWXnAY8KjEiduAGvw2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SB1WdUvDXMx+929ZBsr7o7rdmdbvT4xifvKuLDNWRz4Sb03LYi56LRtUvN/63wJIwbZaEf3onTncw/lyoNKiutADzErATc0KMTZZcx5vnCKFFQkTyTC71iIShJ56M6FDv9KExTOSGsAsfZy/jLD8S0LNWv+/JRnAy8xziyQhLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TPqWfa6m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5b81w028368;
	Fri, 12 Apr 2024 00:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900228;
	bh=3cKgzy6Yi0eMhgIO9iE3bTgnSMO5yEWtriuK2INYypY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TPqWfa6mudsmBV0xJi4ckeYBYE7Y70fUVgsB3JjD5QA8+iBFeavBYzUMAwjwUioSQ
	 +b1waSPz2Rl2b7N3PxqCmoXcrIb/EZuDuOgcx1do5hfpvsS07VYVePCk7TJBa7P5qQ
	 F03iI/rM5+jdxr9TLpXmTq7zNAdVbTKcciLmA0xM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5b8JB054925
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:37:08 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:37:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:37:08 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofb085656;
	Fri, 12 Apr 2024 00:37:05 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances
Date: Fri, 12 Apr 2024 11:06:49 +0530
Message-ID: <20240412053650.703667-5-n-francis@ti.com>
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

There are 4 watchdog instances in the MAIN domain:
	* one each for the 2 A72 cores
	* one each for the 2 R5F cores

Currently, the devicetree only describes watchdog instances for the A72
cores and enables them. Describe the remaining but reserve them as they
will be used by their respective firmware.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
Changes since v2:
- no changes

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 657f9cc9f4ea..b24a6333563a 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1254,6 +1254,33 @@ watchdog1: watchdog@2210000 {
 		assigned-clock-parents = <&k3_clks 253 5>;
 	};
 
+	/*
+	 * The following RTI instances are coupled with MCU R5Fs so
+	 * keeping them reserved as these will be used by their respective
+	 * firmware
+	 */
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
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
-- 
2.34.1


