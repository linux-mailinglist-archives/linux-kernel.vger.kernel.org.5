Return-Path: <linux-kernel+bounces-158384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBDE8B1F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7F2B2B5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDDE127B6A;
	Thu, 25 Apr 2024 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n3g76SjW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9D126F03;
	Thu, 25 Apr 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040453; cv=none; b=lTtPSyvpYL7BdVvdQtEWr7YNmvilIy3EkmB+LIFvwF3JborUSAWyVajE5P+B/JEzv3djhLm1g5vmD7SxjdpH/iC0qlAmjKX9hLfYoItWjWeU62SYOcs33llwjw8VGhVsPQFv+QA8kNpqKd0f2n1cjeYwXN8wpOCJ0/pCV3t1cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040453; c=relaxed/simple;
	bh=8g2CnGZyb7xwCbqbVwALmmM3qVngD949Tq5krzFrwo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rulzP5q83vSLw+uxxRxuxDcO2SdpuT3FHel/N21tQEOcfgyLbTev2vJDCpWHkKOf1Y0RiZm/YCkQg5Sp751uRWccHKKcyF71zW+A0HvUbmKd1zQB6o9AX026jH3aTsSTJfxeb+hituStg0esV3O7A3cIsPuANfY5DQk6t0uCPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n3g76SjW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKg0s021777;
	Thu, 25 Apr 2024 05:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714040442;
	bh=VGSwaQD/OezQ5bUYrulb0rLuXOZdsEO8Ir+zmvrw0Rw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=n3g76SjWjWG6zk2CozLamRmbmzdoMdrLf6ylva8be5uXyVZuILvk33sJZEV7uEEqx
	 NXo6jkz2GsofBZjc+Vs9VJA1Al6aQOIi3MBXZuarFiQgo5hsducDLteRCQ3YIvG08C
	 qMIqklRoJ3+VdFB3DbbhFqUeANAhXvxQGeJ59noY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PAKgob090550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 05:20:42 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 05:20:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 05:20:42 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PAKfH6002387;
	Thu, 25 Apr 2024 05:20:42 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chintan Vankar <c-vankar@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G MAC port 1
Date: Thu, 25 Apr 2024 15:50:37 +0530
Message-ID: <20240425102038.1995252-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425102038.1995252-1-c-vankar@ti.com>
References: <20240425102038.1995252-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Siddharth Vadapalli <s-vadapalli@ti.com>

Add alias for CPSW3G MAC port 1 to enable kernel to fetch MAC Address
directly from U-Boot.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20230424111945.3865240-2-s-vadapalli@ti.com/

Changes from v1 to v2:
- No changes.

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index f241637a5642..7ac3049302ae 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -22,6 +22,7 @@ aliases {
 		serial3 = &main_uart1;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
+		ethernet0 = &cpsw_port1;
 	};
 
 	chosen {
-- 
2.34.1


