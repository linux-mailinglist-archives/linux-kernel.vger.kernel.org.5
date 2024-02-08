Return-Path: <linux-kernel+bounces-57949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845A384DF65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C61F2BE14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB646763F8;
	Thu,  8 Feb 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x3JSS1o/"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518BE7602B;
	Thu,  8 Feb 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390378; cv=none; b=ZBHxDVdJ9hcY6g08dEhKmUYP1Hr7Vxk4ydA3/3Ydi6Esg57SrV345tEtV6WI6YQ6sDVAl4BRL/ig3xs8CiRjGyutc3ybc4QS6szPtHRuQ3Mhxmjpor6bxDNIPGgClgF3tKbEAVE8QPPOuyeoSkPvn8Q513e6b3i5kje1aVpjoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390378; c=relaxed/simple;
	bh=8NRSiZVkkl3lh/MRCcP5v3kJHexKIIms0YJTvzaQl4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9n2WdMt14vRHeU5b+UTj5tcIJhHe5A7HC/fHYvZOlWMWx73+JOvnOnplfxwoj1XSTfsuGjcCXoRbyCZ7GhD8mYMTiJO3WAbLJ1fAaCy4virnLOoPqrpompbSBFJMav2gS2bvZnkHKKMMXzofiQBYl6r56okjO+5pr4p6dtNXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x3JSS1o/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418B662x083887;
	Thu, 8 Feb 2024 05:06:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707390366;
	bh=QXuk50433xsIuuLNqWvfYOf5mc2kL1jE9kluYU6GUH8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=x3JSS1o/SlCvYBpQOF/0C2qy2pD+OAtowUTsXITL1QV8ekR8ORWLlLyCTtkSX6uY+
	 gFueDc64b/zF+xWLdhjPN/frMo2Ie8qd5d615qItIdOTnMbW6uw0UWskwiPDg5t9dV
	 GmKx5wBAn/B49hgVHhZGwMYnzZlT63m87+4G/MLA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418B65s5022931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:06:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 05:06:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 05:06:05 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418B64PA038099;
	Thu, 8 Feb 2024 05:06:05 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wakeup and mcu uart
Date: Thu, 8 Feb 2024 16:36:00 +0530
Message-ID: <20240208110602.931573-2-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208110602.931573-1-b-kapoor@ti.com>
References: <20240208110602.931573-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

WKUP_PADCONFIG registers for wakeup and mcu uart lies
under wkup_pmx2 for J7200. Thus, modify pinmux for both
of them.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 1d8bddcae90e..6593c5da82c0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -119,24 +119,25 @@ transceiver3: can-phy3 {
 };
 
 &wkup_pmx0 {
+};
+
+&wkup_pmx2 {
 	mcu_uart0_pins_default: mcu-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xf4, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
-			J721E_WKUP_IOPAD(0xf0, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
-			J721E_WKUP_IOPAD(0xf8, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
-			J721E_WKUP_IOPAD(0xfc, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0x90, PIN_INPUT, 0) /* (E20) MCU_UART0_CTSn */
+			J721E_WKUP_IOPAD(0x94, PIN_OUTPUT, 0) /* (E21) MCU_UART0_RTSn */
+			J721E_WKUP_IOPAD(0x8c, PIN_INPUT, 0) /* (D20) MCU_UART0_RXD */
+			J721E_WKUP_IOPAD(0x88, PIN_OUTPUT, 0) /* (D19) MCU_UART0_TXD */
 		>;
 	};
 
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0xb0, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
-			J721E_WKUP_IOPAD(0xb4, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
+			J721E_WKUP_IOPAD(0x48, PIN_INPUT, 0) /* (B14) WKUP_UART0_RXD */
+			J721E_WKUP_IOPAD(0x4c, PIN_OUTPUT, 0) /* (A14) WKUP_UART0_TXD */
 		>;
 	};
-};
 
-&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
@@ -272,7 +273,6 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
-	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.34.1


