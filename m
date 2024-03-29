Return-Path: <linux-kernel+bounces-124160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8541E891338
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361DF1F221CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F33CF7D;
	Fri, 29 Mar 2024 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sN143pYo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB73FB02;
	Fri, 29 Mar 2024 05:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690340; cv=none; b=bGqxChZhokPY45vKz6UiTcPLoHRClAbAzCuWg2BLW+2+b2ZHA6XxSxWVbMi9t79xzOZLbSIpo4XM9REthF59Ohy8r56sJaIZJEtYdmNFWv053Cf/fFDJTuaF7jyVudwnbv2x2qYy5/r3RfUAwKx52uJr9QRPwPRGJON3hDiR/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690340; c=relaxed/simple;
	bh=kHVCR94YnT2vDJ2TUSJK74zI4YHnn6o9DAImkqwDOJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctdRu1CbHKDVl3CuTNp86KD7RZZWPC6FSb6/aGPSayT8vNzNgFbtLXfatqwYVoFLgiQNrjyCrjlvSh2mkp6fMOkVRCIOgC+jHdHfEblz+v2SWJJi/sZno2dAtPt8LNEODZGYGkma52fID8d3Enem3kWNluq5EtudchOZg+eiE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sN143pYo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42T5VvZc045035;
	Fri, 29 Mar 2024 00:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711690317;
	bh=oJgLPo3SYSDGizlVpUg2BKTiPy9veBQrqI/cwek3AF0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sN143pYo38MSbTQpw7wwkfb87TSUVJ8+zqzUGjfwi7bWpGsuogiNGqvSSFZFKklgO
	 UJk4xu/btok4M0uBFrmrPbn2iMOFfRSaAqlG8+LDPldgTeFr2l9b7PodCqIfzS6hxG
	 6Z7xC1n8ovFVSGglla5S871Gb9mfNspXJsQWbvm8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42T5Vvja082217
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Mar 2024 00:31:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Mar 2024 00:31:57 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Mar 2024 00:31:57 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42T5VurF061600;
	Fri, 29 Mar 2024 00:31:57 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v6 1/5] arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
Date: Fri, 29 Mar 2024 11:01:26 +0530
Message-ID: <20240329053130.2822129-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329053130.2822129-1-c-vankar@ti.com>
References: <20240329053130.2822129-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add alias for the MCU CPSW2G port to enable Linux to fetch MAC Address
for the port directly from U-Boot.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240314072129.1520475-2-c-vankar@ti.com/

Changes from v5 to v6:
- No changes in v6.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 81fd7afac8c5..1f390c22844e 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -27,6 +27,7 @@ aliases {
 		mmc1 = &main_sdhci1;
 		i2c0 = &wkup_i2c0;
 		i2c3 = &main_i2c0;
+		ethernet0 = &mcu_cpsw_port1;
 	};
 
 	memory@80000000 {
-- 
2.34.1


