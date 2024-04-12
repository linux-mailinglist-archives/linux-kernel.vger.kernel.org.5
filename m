Return-Path: <linux-kernel+bounces-141991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDE8A25D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C848B24565
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE4040BE3;
	Fri, 12 Apr 2024 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uXLuRLla"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57C3F8D1;
	Fri, 12 Apr 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900238; cv=none; b=uqffRwfPpB8Ov0tndyVEGthNheXZa6Nb8Ub8zzOkJMBSbQLhtOcHflrBWe50jCconGHRFldNL5e5nrdsLVMCqsmZeIfAFXZ9YO0fgz1pyD5d6idigMQrl9inMDzTMFdOz575Vbbxk6fKPfKIegyr7twgZ7+tAgL/EF/E0Y2LL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900238; c=relaxed/simple;
	bh=kGVOndCO8cgsyKnzy19ZlUBtYsio3STgdICqpM8MoqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoAbmKnwz94P7uJlky1BOpFTvvC956FQSNmKc/FODggy/JAYikP4iOUwqmW0e8AIrU6L6GjEbd/UPGhSWgsJZovDHRp01qqSKBGAP2MDrgR9ZYzLT7anEUYVeeyiLYk3gyfq1PpObgLtOHcz/m1pKZp8oraGhZquTjgvBWfemLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uXLuRLla; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C5bCsn082712;
	Fri, 12 Apr 2024 00:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712900232;
	bh=qRGL+3UoqinLQLWI/4Jm7PGqlRKDQDmW75F9UldqsGk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uXLuRLlaMfULXOhN3DalFkbBsuEapiyjOQNZS3ZD7OCIE6Mott4NYvpcjYAKNhFau
	 gy9OQgfLPDUNwq0nBm+lBXppR4+9hMt1XVLkN/Lgzj3pjEApqFd6mLm//T4NiX+DKx
	 1h1mjtCFA7qHe7oaDYaqQbR2qShdrcQ6IjaHUmIA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C5bCkg054940
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 00:37:12 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 00:37:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 00:37:11 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C5aofc085656;
	Fri, 12 Apr 2024 00:37:08 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>,
        <n-francis@ti.com>
Subject: [PATCH v3 5/5] arm64: dts: ti: k3-j7200-mcu: Add the MCU domain watchdog instances
Date: Fri, 12 Apr 2024 11:06:50 +0530
Message-ID: <20240412053650.703667-6-n-francis@ti.com>
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
- corrected register size from 0xbd to 0x100 as per TRM

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 7cf21c99956e..f6ca4ffb5ee1 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -686,4 +686,30 @@ mcu_mcan1: can@40568000 {
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
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


