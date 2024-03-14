Return-Path: <linux-kernel+bounces-102923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128487B87A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA7285A64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD15C8E4;
	Thu, 14 Mar 2024 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bRyq7DCD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B95C617;
	Thu, 14 Mar 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400904; cv=none; b=HZT4ldDMfcynJRrWkchJ3m+ROt3f801T15/pqeRfiIvxgfqOTfJACd5np6O5BaxZoLkAxIgDh53M2dlSjLrfODx9WEM8QWDm9WzhaO/9tEKhOrkkTHqbgYXWSwPdNhZkjjregtIbiTicutxqPfu0Rojt6lf01AvvZ2kUD9QvWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400904; c=relaxed/simple;
	bh=iU0P/pPN0hf8+78Gl8OOHKQuX55sbJAVM462l+Xpo/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKQC8CVEoEFuRUc5YrrTjOzo2A2aS/PGvrXpyntgyZ6kbnks3FKxrUcq1bx2vr+Q/bATD4WYxca61p425MI4Agzm32c2obkI/B7BIkKPXJdn6EvfV6NhD0e6t3o8Vd5lX69OQVP70FQE7XN52enMQITYhG1OpYmgXDmlQ4Bxi8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bRyq7DCD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LYf0024881;
	Thu, 14 Mar 2024 02:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710400894;
	bh=N/r4yeeJCniqbNU4n+Oorp8eaNGK16nfzVidvodlDqk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bRyq7DCDn0g9KARh85f4Q2tuRmfoJC+59UP5Pnm641jgkvef3ZYCS64G+RHmN6NNU
	 kY7QzbpgkbTlfp6K2/9z7DIO7Am4uBCGhVPZ8CemRaBKlteVLjTrxGpWjEgwXBic3P
	 SkxQmEeFTph2L21iYCNIhY/Rla7IIuV9n9dRimjE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42E7LY3h021688
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Mar 2024 02:21:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 02:21:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 02:21:33 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42E7LWc3120529;
	Thu, 14 Mar 2024 02:21:33 -0500
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
        <srk@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v5 1/5] arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
Date: Thu, 14 Mar 2024 12:51:25 +0530
Message-ID: <20240314072129.1520475-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314072129.1520475-1-c-vankar@ti.com>
References: <20240314072129.1520475-1-c-vankar@ti.com>
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


