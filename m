Return-Path: <linux-kernel+bounces-144874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683048A4C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982F51C22A95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D8481D8;
	Mon, 15 Apr 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eBSJofE6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39846424;
	Mon, 15 Apr 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174997; cv=none; b=vFIXw98Yv4+eoaGhyyXU/WTeAYHDuI3/tHhUQ+LUDk58aFhgjdLjMuZyB+0IWpFUOE9eSurV757POTgYFU+GeZV/Kn8zEk6JMtVNrRZ1AB1WCiaVIKCQPvlI4IXFXYlhNkjm6p1Fe44xpTJ5zta60cHBmViEOXDjxUwDXQzAWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174997; c=relaxed/simple;
	bh=WeLWYUe7bg8deib3zQlN88bewVzUCY56ObqFiGe1e3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glW/ieno70Z1FL3m5B1XmDKtQTz51/iyPmUABd8meuV3lkBFLQVtZ4Rwfnj3ndT4HjLRqlvOQBMTrvrSNlXUswSqIPeYXdsfJaj7C+WB32Dc/5q16CeC6K+t3U0QvpuDEKppXAtUSQsRpM1vtgR3xk+jXDSGYKjWj4re//J5XTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eBSJofE6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uRaJ009892;
	Mon, 15 Apr 2024 04:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713174987;
	bh=xrejzCDDLxRPs5CNBboER/vkuk0itQTLkLLvMlzfquY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eBSJofE6OcD2Cr8e2ZpYT5T/VGKDylz9ZV0zQGXlPn2x6EQgVfsGNFTiwmzHdjToy
	 lQitJWZvcp7IFsHaw3kM2x0vsz66yR27KqgTV/Ph+7d/0S3z1L137ZC98csSkrtU1H
	 4LqKwJGoN33C9cj02n+T5N2uKhKcJfxoam2JnZeQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F9uRdu120057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 04:56:27 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 04:56:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 04:56:26 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uCqx074231;
	Mon, 15 Apr 2024 04:56:24 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro type
Date: Mon, 15 Apr 2024 15:26:05 +0530
Message-ID: <20240415095605.3547933-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415095605.3547933-1-u-kumar1@ti.com>
References: <20240415095605.3547933-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Along fixing wkup UART RTS and TX pins as OUTPUT instead of INPUT
updating J784S4 macro for pin mux instead of J721S2.

Fixes: 45299dd1991b ("arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts")
Fixes: 08ae12b63750 ("arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 50de2a448a3a..d88651c297a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -517,18 +517,18 @@ J784S4_WKUP_IOPAD(0x0fc, PIN_INPUT, 7)
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
-			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
+			J784S4_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_UART0_CTSn */
+			J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (L36) WKUP_UART0_RTSn */
+			J784S4_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
+			J784S4_WKUP_IOPAD(0x04c, PIN_OUTPUT, 0) /* (K34) WKUP_UART0_TXD */
 		>;
 	};
 
 	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
-			J721S2_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
+			J784S4_WKUP_IOPAD(0x98, PIN_INPUT, 0) /* (N33) WKUP_I2C0_SCL */
+			J784S4_WKUP_IOPAD(0x9c, PIN_INPUT, 0) /* (N35) WKUP_I2C0_SDA */
 		>;
 	};
 
-- 
2.34.1


