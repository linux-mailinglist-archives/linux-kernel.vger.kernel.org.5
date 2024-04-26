Return-Path: <linux-kernel+bounces-159889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CAC8B357D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE9D284317
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7341143C6F;
	Fri, 26 Apr 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8cp6vmN"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9F29CEC;
	Fri, 26 Apr 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128320; cv=none; b=gU255tEgVVXTaP5nIrRJwRSBb2twhj1Ls6CQ3cPEt30kMaZ/xcXfMhtfw98BN8u8iM9EJzwbnfZqkEhGzcGFmrCPArbLRvjYu2ZlYF/+983PwhbI3Diehi/zG91wVrL/lowjwwhDvqBaA0x6Kc5t8WJyygz33vUPq5sDHnCkMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128320; c=relaxed/simple;
	bh=1GPTVzQ3RYu+uPM1fHOsgJyMAZBfR2SYv+4tP9n5U+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G99ba6Hn33lSuMzS4sRDdhjuEUvuksOonhMHj2Q/m/QT+vt0NuTfg8rc9228qK3z69BBqybSenmMD1GkdWhVEWEN8t8a4pQrcWbpgWg8NtkeF1Jnn2GX7m4145IvSgJtjfEVOatdrs6IyqTx6Y1vdoSGLzodpNny2C94BUBXQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X8cp6vmN; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QAj8lt022035;
	Fri, 26 Apr 2024 05:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714128308;
	bh=+G7hsmNHlWKp3MAGArQvL4SERCA89ndaYO3wLVxnObY=;
	h=From:To:CC:Subject:Date;
	b=X8cp6vmNJa9NwO2efNpAA82fO+z0oMnNhH3ZecU0SxbHtSFQ/hiQHlmeJMioI28IB
	 Wh2sZTytfzzZW9P2woIjLhvYxK/1VzfOB/9aRevj1g7weAv/DfARGZegNi5zipM0zk
	 HuiBmETAC5nQmWJ3xxaMBAGIS/Bwi8t0Fq3Twi8c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QAj8bf002628
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 05:45:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 05:45:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 05:45:08 -0500
Received: from localhost ([10.249.129.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QAj790098712;
	Fri, 26 Apr 2024 05:45:07 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <b-kapoor@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable main_uart5 node
Date: Fri, 26 Apr 2024 16:15:06 +0530
Message-ID: <20240426104506.29990-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Main_uart5 node defined in the top-level J722S SoC dtsi file is
incomplete and may not be functional unless it is extended
with pinmux information.

As the pinmux is only known at the board integration level, main_uart5
node should only be enabled when provided with this information.

Thus, add pinmux for main_uart5 and enable it in the board dts file.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index cee3a8661d5e..b92d5c385f13 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -18,6 +18,7 @@ / {
 	aliases {
 		serial0 = &wkup_uart0;
 		serial2 = &main_uart0;
+		serial3 = &main_uart5;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 	};
@@ -142,6 +143,14 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
 		bootph-all;
 	};
 
+	main_uart5_pins_default: main-uart5-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0108, PIN_INPUT, 3)	/* (J27) UART5_RXD */
+			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)	/* (H27) UART5_TXD */
+		>;
+		bootph-all;
+	};
+
 	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
@@ -243,6 +252,13 @@ &main_uart0 {
 	bootph-all;
 };
 
+&main_uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart5_pins_default>;
+	status = "okay";
+	bootph-all;
+};
+
 &mcu_pmx0 {
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
-- 
2.40.1


