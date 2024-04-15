Return-Path: <linux-kernel+bounces-144873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC128A4C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFD91C220C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC944D5AC;
	Mon, 15 Apr 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kwo/KzHR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324942047;
	Mon, 15 Apr 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174994; cv=none; b=eZ7+d5uHmfYMtqVPwkK3nBtgaJJ9jEnBdxUptx2xJQTzYCxx4HhDUtyRNANeZuYG1XHe42H3GXyFOWGO6tT7WAcXfqDMlLAjRhFDaiDYkLzqnDLTC8TGMFEOpFXUX0arIChjbkEAOWDrBZdsvsv9rbzj2Dl2wRxKrbczgRGClek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174994; c=relaxed/simple;
	bh=wl2AApRDolDq+zb6IvXmw4o39VmMfL+lUfwV0aO1t9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uqi+gOG8Q//rhSDRDpzIU70kMOptS/mROhx3L+uIb/36cPHRNHPPsYp5QEj7HAWgKGKE3Wo7eqgaQBc0nRQDUGqb90lbDkhLpoN1stW5oswsRTlCddCuZTlO95IDNq123jCcmnTZmJ4Q/7uddumqXn/e0cXkfDvgFbbUzIORRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kwo/KzHR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uN1L009885;
	Mon, 15 Apr 2024 04:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713174983;
	bh=ksP9hkpCMNq5GRiFSMJGM3IGcRjcf+oH2Jg/Qr56QAU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Kwo/KzHRqyBy77zj0iQ/64npinZEV5HFSow9yNiSJbL+KPYamP+zWF3qNXhclG1oi
	 h6R7VfgRbLu29gCgoVPqtSdqMIFWnuSTg89R+kl6O5SwIpwDsZr0GroqWn1OK/+JpL
	 zQlv+eHQxCgI6Eq+7zXPbf92fAiBAoeUxjRmATqs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F9uNhk120033
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 04:56:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 04:56:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 04:56:23 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F9uCqw074231;
	Mon, 15 Apr 2024 04:56:20 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <francesco@dolcini.it>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j784s4-evm: Fix UART pin type and macro type
Date: Mon, 15 Apr 2024 15:26:04 +0530
Message-ID: <20240415095605.3547933-2-u-kumar1@ti.com>
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

Along fixing wkup UART TX pin as OUTPUT instead of INPUT,
updating J784S4 macro for pin mux instead of J721S2.

Fixes: 5dfbd1debc8c ("arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom")
Fixes: 6fa5d37a2f34 ("arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..d511b25d62e3 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -343,16 +343,16 @@ &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
-			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
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


