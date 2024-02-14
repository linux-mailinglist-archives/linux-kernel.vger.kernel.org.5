Return-Path: <linux-kernel+bounces-65093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDF8547A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9B1C21263
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D781BC2F;
	Wed, 14 Feb 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a5bkmsk9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447631BC4C;
	Wed, 14 Feb 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908342; cv=none; b=jUXK0sHjYDj+l8qO9vvVJtKvvfsmLowoiuerkUZqtEIE401PdXsPbxkgMdiDPJE0zkU55gb+Z+66vWY0OUmm+bA9QLYvrM+oq4OrCg7nSOVWl+wG2CXXIPwh4bPAfBabP7WiMIpuHRuGIB6hfe69ijMo+OIyFiFRfpUNGNlegH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908342; c=relaxed/simple;
	bh=j4Z9rzY1BKyBWWZDz2XvawSoHF5Jokyat8EyY3cqrVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW1OCEQygs3BlflBcKeaIseucdwOzwuPAxGJ1KK6M6KijXA7fiWRfGP5+IC+mlKoAmrXC4I3OQ4zRctZi19EH8NZvbU12WyZXufcSC/UBRDPQWQLKr4pfQtIvBRY2yCqBZ8rOO5dOt7YUVjYcDFrQlYtmwamV4VBMh0k3GfiuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a5bkmsk9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwrD5013593;
	Wed, 14 Feb 2024 04:58:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707908333;
	bh=A0kazG81Inh3br7Zj8X0X/nfnmKF8OMUlY9Er0J3CHc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=a5bkmsk9Z02VNn989de240QDDNiBT0Hn6IKAQVIfFR2NzFA5UwoXxagtSjjxKnNt5
	 PKxJEybAGH6x3eZYVHua5T7qGgS480bS7cK3uag+e/mGH1DbFy66UOtofFdlKwtozr
	 JhC/n1pQEYAboDTNrjQIBCsJAP/yhGA+53lOE0Vo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EAwrco122185
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:58:53 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:58:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:58:53 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwqdT036580;
	Wed, 14 Feb 2024 04:58:53 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH v3 4/4] arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in wkup_uart0
Date: Wed, 14 Feb 2024 16:28:46 +0530
Message-ID: <20240214105846.1096733-5-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214105846.1096733-1-b-kapoor@ti.com>
References: <20240214105846.1096733-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Only Tx and Rx Signal lines for wkup_uart0 are brought out on
the J784S4 EVM from SoC, but CTS and RTS signal lines are not
brought on the EVM. Thus, remove pinmux for CTS and RTS signal
lines for wkup_uart0 in J784S4.

Fixes: 6fa5d37a2f34 ("arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts")
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


