Return-Path: <linux-kernel+bounces-118973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C118988C21B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24901C3169A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009597580D;
	Tue, 26 Mar 2024 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xc5O0FCR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C95757F9;
	Tue, 26 Mar 2024 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456069; cv=none; b=JwkqNm/ljggFH9plhuiuvGH9dPDbsWN+kirHGh4m0eE0KBYnBIAxs5bWgq2lK0q6oJA/2Ej+1pAS2n86eJdudlAVNfLeExedS7rgMFWQ5fQym+FI0XwnlhKT6fQYre6ATcR5ppPF2l9yILpXqHqHSZdhsJHr++9Z2d+KnceZpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456069; c=relaxed/simple;
	bh=lyPM2d+K+K3uLghFjtmc9eUb/cK+sBiA8vRv4gHgE+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrTIONxJdsYFbXaOV/lTnvfmfTvsd4Um3iX9xU4JF8YUk/Kl1lPOKMpo22aEmtYY15bp3gqL1cDzul3DmvzUCMLeacJUdKdDBgpcV8F2nAxZyUXdVPpoN2L9Psaq8ilTvt0cjjBquHIY/EKtHVezF2Z3LryiJrCjdV+AJlz5vZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xc5O0FCR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRfVS046400;
	Tue, 26 Mar 2024 07:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711456061;
	bh=UR0R4Mu1rXt3Fm5JdEySPVTyQK9wbqYUueqfy94fY4Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Xc5O0FCRZWwhfYyCOkSBYo/gmFFBMJv0/F8jnADCRImrGQLmbjRFVDZgRbpxVlXcF
	 xyV/NZIR11uTiJcURqvMgkfUnLTUTR8RvRs4h5cOn/6l2XYKhgHdLC0nRuCO9ck+QZ
	 WUxKBfIvhqAxD5zukKfvB5XFlEvb9RzAZJxT6vtc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QCRfKe035283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 07:27:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 07:27:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 07:27:40 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QCRN2f129435;
	Tue, 26 Mar 2024 07:27:38 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-j7200-main: Add the MAIN domain watchdog instances
Date: Tue, 26 Mar 2024 17:57:23 +0530
Message-ID: <20240326122723.2329402-5-n-francis@ti.com>
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

There are 4 watchdog instances in the MAIN domain:
	* one each for the 2 A72 cores
	* one each for the 2 R5F cores

Currently, the devicetree only describes watchdog instances for the A72
cores and enables them. Describe the remaining but reserve them as they
will be used by their respective firmware.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 657f9cc9f4ea..c448c2218e23 100644
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
+	watchdog2: watchdog@23c0000 {
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
+	watchdog3: watchdog@23d0000 {
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


