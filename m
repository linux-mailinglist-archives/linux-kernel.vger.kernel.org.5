Return-Path: <linux-kernel+bounces-166178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A165E8B973C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CAEB23206
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F1535D2;
	Thu,  2 May 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UOhwBADb"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6E17591;
	Thu,  2 May 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641048; cv=none; b=qp9DsqZVCwgpj+vqrP6fjlAKD7DSolv3Vb8Pm2fjcBDp4LU3mB46SIcsP2xvpo8fGLO+57LU3Zz0Fqu5NVeGYHxG1YiiDXQnawaOf86pDpPU5BplJb1Adwf4SJtd/60cKdylHyB2VxcysnMGjVl6ItE9uMohJ99YvDshbXEvO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641048; c=relaxed/simple;
	bh=BJjWmqBtz2nrGy/IEYG0/61FoWC9Bc8V0Li73Nnyozo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAZAhYykNQqwYeQetnHDS9e8LMZGSoj5XQAx2NvGMhdwfNc0ISVNX3fN2H0oxyYIyPq62D4vY8Vy2/mlmwLGUR7uZoyeSmeYNgjqsnwQjj5NSUX6wP6EZd2+f/IiChP61oSYWMG+70OeZVm/1FJ9umjiJqU2PWK3XB/2sWh2M10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UOhwBADb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4429AbZN094425;
	Thu, 2 May 2024 04:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714641037;
	bh=8hWXzyZ8IiLa8mP6H5IQHfANGIWJJj3Hu8MK3EE5O4U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UOhwBADbpwyBGYTX+WRGUbq9cTiKwdloqUOjkqsVH9PvATUZ14t1FfM7VgHT8SN0i
	 nv3OWWgZNdJsCNcL8GrXdYiccwHClsuM3YJEPtpPYBguDiNnFEKBx3m1hav1PoZ/SL
	 X4pgF2uTmcHE7nGoxqUVV7b3flzgkBx3JGkfMCv0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4429Ablk048461
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 04:10:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 04:10:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 04:10:36 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4429AZva007478;
	Thu, 2 May 2024 04:10:36 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <r-gunasekaran@ti.com>,
        <srk@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v7 1/5] arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
Date: Thu, 2 May 2024 14:39:58 +0530
Message-ID: <20240502091002.3659435-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502091002.3659435-1-c-vankar@ti.com>
References: <20240502091002.3659435-1-c-vankar@ti.com>
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

Link to v6:
https://lore.kernel.org/r/20240329053130.2822129-2-c-vankar@ti.com/

Changes from v6 to v7:
- No changes.

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index d511b25d62e3..2fe6a582ceab 100644
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


