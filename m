Return-Path: <linux-kernel+bounces-158339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ECA8B1E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196A9B290D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B185C7B;
	Thu, 25 Apr 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vm4yrkwm"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77A84FD8;
	Thu, 25 Apr 2024 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714038910; cv=none; b=ES7vN5y2+43EtLopW565R1IvOefZtXPaF6N2s53xneLeGlCvGTZGs4p2ZrQYkm1SHO/dixBH57Omo9U5tGWUud6VSCIhbXLRJm9vyZrSH24KJoJYr6PfbkPxmdc56nXcmFzPLLs00kvygH4ziuEF4U8FRgEHWZ0hcgMfWttbm7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714038910; c=relaxed/simple;
	bh=mhOkXnvrTd9m6bVk8OVaKio+gIm5KOT79yVBQ+kv0As=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NXOtdLqRW6lbjdk9f+ETXaz2nhKPJdcEb4Juq3T4urltFW7xnT4KIY/GX86lDp/+3FwwpGaJ1CpXTPGw+r/KaUsq7bEkjciCDrAwL3Fyv3ogGuxrTZdmtKDpxzKvnWFlmB5K/S71RwmHzLKS3iA6KZszWYiRHzgC67WctAsHJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Vm4yrkwm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43P9svdP118051;
	Thu, 25 Apr 2024 04:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714038897;
	bh=Oqd8Va/9Fi8Jy6gIQECgrEIS3w2R/1uHYRB1svh8mvY=;
	h=From:To:CC:Subject:Date;
	b=Vm4yrkwmfaJyMYI9zG81IC+low9cTk4OL1RNzCg+Ywx47odxn/hZrVcSYaU84teCh
	 imYafNAilsAJjfTjgw+HjCS8jbWB1YDsO0cuzGRK0BR+c6aMXufr025ch9/1ByG7h9
	 YrezXsiY0VQlfgXfgIp0zpROUJNmiPeQsMaW2ykM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43P9svGU070263
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 04:54:57 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 04:54:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 04:54:57 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43P9suIP083249;
	Thu, 25 Apr 2024 04:54:56 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Add bootph-all property in phy_gmii_sel node
Date: Thu, 25 Apr 2024 15:24:48 +0530
Message-ID: <20240425095448.1946293-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add missing bootph-all property for CPSW MAC's PHY node
phy_gmii_sel.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on linux-next tagged next-20240424.

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e9cffca073ef..7a6f7cdc4cbe 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -52,6 +52,7 @@ phy_gmii_sel: phy@4044 {
 			compatible = "ti,am654-phy-gmii-sel";
 			reg = <0x4044 0x8>;
 			#phy-cells = <1>;
+			bootph-all;
 		};
 
 		epwm_tbclk: clock-controller@4130 {
-- 
2.34.1


