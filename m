Return-Path: <linux-kernel+bounces-65091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD088547A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05C31F24264
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44380199BE;
	Wed, 14 Feb 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ktSsKJBG"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079D19475;
	Wed, 14 Feb 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707908337; cv=none; b=dxh9/tVqAIpRiV2R+4vR60POct+5alVhTdoZpgxhobfn4zheNI8jCV6nMEcQivE87+dFGqtZVTQ2p46j7adLFk6/A3UQSGN+mg25Kz1tYdI6DUE91kp4SjSPum1sFdoXmqgMAf1Q8HnTfv44W7pTkvlC3lkKdtdoMxtaCQ/1cCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707908337; c=relaxed/simple;
	bh=8YT+UmPlNooHEb2SyxZHHkyWJQEtU1aFI9hno7k3Kv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O47idGzWKjnYqncjV4R3I9mpJaZU1yZDEePj1Fk8dcTBH+GSf1mWZiM7qZVSYx6eA9EDturpl/yqIYfLPdbS+iNh8TF7ca0stFqTvE/U9yVqLYKO0aKlDAKLUVk+vX20L1m54FErdj/OnARTlbO9emYmaksInaDOVyc7jU8pOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ktSsKJBG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwoNs027677;
	Wed, 14 Feb 2024 04:58:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707908330;
	bh=WX1PzMzhnTAOgfRLSeG5Jh0SL0/h0/LD2+yShP8fMLs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ktSsKJBGAv39mV1CXECUkQ0FBrc3YH9ex/NWpDu8gS4t/YQu/gHHU8mfmCLeqaFI4
	 teism1/wD6+hwAp23YpDVqxSASGcFkMAidlgzDBI7xo9fkUVVkzfed5Nxm0EOtBhkA
	 UmwnpPs10jGpcjYAvzmAkeQe1w3U3ENb4GArNoyk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EAwoXv122145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:58:50 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:58:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:58:50 -0600
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EAwnAq070805;
	Wed, 14 Feb 2024 04:58:50 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <b-kapoor@ti.com>
Subject: [PATCH v3 2/4] arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency from mcu_uart0
Date: Wed, 14 Feb 2024 16:28:44 +0530
Message-ID: <20240214105846.1096733-3-b-kapoor@ti.com>
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

Clock-frequency property is already present in mcu_uart0 node of the
k3-j7200-mcu-wakeup.dtsi file. Thus, remove redundant clock-frequency
property from mcu_uart0 node.

Fixes: 3709ea7f960e ("arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 160580a0584a..6593c5da82c0 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -273,7 +273,6 @@ &mcu_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_uart0_pins_default>;
-	clock-frequency = <96000000>;
 };
 
 &main_uart0 {
-- 
2.34.1


