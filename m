Return-Path: <linux-kernel+bounces-144588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F4C8A4826
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF341F22077
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D001EB48;
	Mon, 15 Apr 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qyIfrKKy"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36646208A1;
	Mon, 15 Apr 2024 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162857; cv=none; b=krGJ+FL/vMRU7k7C/gTWugDLPRnUU4FTZ0UhQ3INVAswOJVzjLZ68QN/cRKWqFrWxiXF1nVQcD3ShwkCRXAv2+zdCXlHg2DyP7h3qNxKKgRQIMk59GYbOMqXLLa0RELWEcJT8gkdywTX+So0XzUXXDZXALFkE3YHWdACfB2A5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162857; c=relaxed/simple;
	bh=RK3pNIt84iuDFjMOOzcEc7SJt6GfpegSc3o8M6qkGfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD90VZ7Yt/8wuHsH4MvQgb9C28CbIiSHkr2J0RJYUHCP19a0jC9Dz6mQRS/+TEgU+fVnpjbn3vVOY3DWKal6Tb2k1cAp2YTeq12Y4tO9ST/Zk3eaa+zKzcHHbEBVP9IjME+NH729kDrT1tq65U1gK1NkFWrmGgvt1FRN3VCcNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qyIfrKKy; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xs49126555;
	Mon, 15 Apr 2024 01:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713162834;
	bh=ttvAv6g/HtJ8czfO7HvpG09yEh3CoaZUPRVXN2SfOjc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qyIfrKKy0FOYVxKbspFOgwt4hr5MjODxupa+jkAKTtk20bwjXWkVR6PJuhKSmyaO+
	 kWbGXfEq0WOlPYCXZtzJvyGwThkdRCthpYKLgwMvWSgyE/6d2qzVROjHny+mFOyaRR
	 P14I+x2vYU4sW2U4SM8dg0IBjX4vVTwPgUtCvUbE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6XsTr021466
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:33:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:33:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:33:54 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6Xidd065992;
	Mon, 15 Apr 2024 01:33:51 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar
	<u-kumar1@ti.com>
Subject: [PATCH 2/4] arm64: dts: ti: k3-am69-sk: Fix UART pin type and macro update
Date: Mon, 15 Apr 2024 12:03:27 +0530
Message-ID: <20240415063329.3286600-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415063329.3286600-1-u-kumar1@ti.com>
References: <20240415063329.3286600-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Along with updating J784S4 macro for pin mux instead of J721S2
fixing wkup UART RTS and TX pins as OUTPUT instead of INPUT.

Fixes: 45299dd1991b ("arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 50de2a448a3a..8d40a0351020 100644
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
+			J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (L37) WKUP_UART0_CTSn */
+			J784S4_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_UART0_RTSn */
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


