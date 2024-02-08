Return-Path: <linux-kernel+bounces-57948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32084DF63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BF11C290E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1176024;
	Thu,  8 Feb 2024 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HpxhSsBK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164676035;
	Thu,  8 Feb 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390376; cv=none; b=Ql1lX1pVvuYgghiWP0R7h26Cp8a6UAUAxTdU0KRojXkTI5WNZQx9f2Dhx8NricKB3U2V3dfvwwY+siIJaA2JONLyditw6ZrBD1OwmD3xs++Oy+X/lFIaNSglhNnQp89FGoKdwXFzjcxRjiNGwP+hL/alMV0xoAY3QqhkCIE12Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390376; c=relaxed/simple;
	bh=0pB4Ekwu+0UDHA35cCTvoVLHPhC9XZsg80ESLzwvw2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES0TlZFSmIOPHxIbC3Aj4CC8uVpgQxPLsj4Pd9HBn/COaEX6nhE4nTRkL5HXnHcQmaQJCCHNI4z4LjVjHh/uGyYHTdSfxFGb0RWmW7qeoyNfDjl8XtJXIt1ArWRass6n41drtoqEqktKdBakY6HN9aMI6O+sJe2GXPZlB/RJkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HpxhSsBK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418B68jX048991;
	Thu, 8 Feb 2024 05:06:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707390368;
	bh=Mh7MVdrxQwx/6DvPwnSFJ3c4Xc1Buijp91cp7auyAjo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HpxhSsBKs4JNEm/CE0PtfL1aQake1i3m2W8hgDlUsHrejjm5TC/ySoIa+pSpa1Fh3
	 bvQkQxAfMn7WK+D0p+5J+4lViYFik6FSM9C3oaPQrDqPdfr1+vbTiFH+ShPcM3HjQz
	 YBTaMIsrllbIS8CyNMMi7CNKVK0K2jUlt8Yl3PEQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418B68ol022960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 05:06:08 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 05:06:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 05:06:08 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418B67vc038144;
	Thu, 8 Feb 2024 05:06:08 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in Wakeup Uart
Date: Thu, 8 Feb 2024 16:36:02 +0530
Message-ID: <20240208110602.931573-4-b-kapoor@ti.com>
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

Only Tx and Rx Signal lines for wake up uart are brought out on
the J784S4 EVM from SoC, but CTS and RTS signal lines are not
brought on the EVM. Thus, remove pinmux for CTS and RTS signal
lines for wake up uart in J784S4.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 57e7cb8ea2b8..9f16642ccd5f 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -336,8 +336,6 @@ &wkup_pmx2 {
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
-			J721S2_WKUP_IOPAD(0x070, PIN_INPUT, 0) /* (L37) WKUP_GPIO0_6.WKUP_UART0_CTSn */
-			J721S2_WKUP_IOPAD(0x074, PIN_INPUT, 0) /* (L36) WKUP_GPIO0_7.WKUP_UART0_RTSn */
 			J721S2_WKUP_IOPAD(0x048, PIN_INPUT, 0) /* (K35) WKUP_UART0_RXD */
 			J721S2_WKUP_IOPAD(0x04c, PIN_INPUT, 0) /* (K34) WKUP_UART0_TXD */
 		>;
-- 
2.34.1


