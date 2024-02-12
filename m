Return-Path: <linux-kernel+bounces-61269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0E851028
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8EC1B20AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540FA17BDF;
	Mon, 12 Feb 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MBMKAFXh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24417BBF;
	Mon, 12 Feb 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731957; cv=none; b=QUU6gH5U5EEmin+1G94nOxtBEuaV0i1o1qlaToIIFqCJln0bctAB/1qKdDXqMvJ/TTdDGPQtmts3hYj1ov1qTGtWIrifh+OKtoSg4j17MwQlG7pcRTvwCqVR2QU7CemG3fu6sjpqmnXsUR96lfma55MCtz8Za5djUvKgE9FFlFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731957; c=relaxed/simple;
	bh=jVZfSgcZhIqL1nLDp0MdTautr2ahGpG5qta5AfAN+ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfidyH+Glh7nXKVATVMw0QSJ+1wP5e22rEsmFJCdWuLhWK6Rednoo9ZAlDermlkMwrhcPKBXA1uKSjjE490qLLtIPrVydtRpGtEL0PtYPwdVaVtISerBYyp9bFGUvKPylJ/SkND1ghwJTPQfSV3paVNUoALQiplr8hYA/D2LphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MBMKAFXh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C9x8qn086469;
	Mon, 12 Feb 2024 03:59:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707731948;
	bh=tIf/vX9WByfUoBDIkM6k7+c1XDGlaZlWSQfMHewEncE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MBMKAFXh1AV78UEnZQEv6Utzll/KOeGlhHPi82Fhdwla8LnrlHyDjvi8NMbiXDAh2
	 TqvhAEqo0G2EDRoaVy/sftTNbL9vRC6car/qJnrO1qPU75jSJ5BrpSUz0xXoymhMFb
	 PmL7aOo1z8778CpUoeY2xnlNasgCCW+cSTABOue4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C9x8ma017784
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 03:59:08 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 03:59:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 03:59:08 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C9x77B056500;
	Mon, 12 Feb 2024 03:59:08 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for wkup_uart0 and mcu_uart0
Date: Mon, 12 Feb 2024 15:29:02 +0530
Message-ID: <20240212095905.1057298-2-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212095905.1057298-1-b-kapoor@ti.com>
References: <20240212095905.1057298-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies
under wkup_pmx2 for J7200. Thus, modify pinmux for both
of them.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 .../boot/dts/ti/k3-j7200-common-proc-board.dts  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 1d8bddcae90e..160580a0584a 100644
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
-- 
2.34.1


