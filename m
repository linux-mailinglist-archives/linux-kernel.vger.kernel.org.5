Return-Path: <linux-kernel+bounces-147681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE18A8A77A8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C86EB21CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50C13A88D;
	Tue, 16 Apr 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RPy0OMlZ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A584FB3;
	Tue, 16 Apr 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305830; cv=none; b=YoPeSOpA5X+I/6ErTY5m+rHstYP+ydijq14ueSZEZhxRQdz707HTeA5xrOuEIh2ccqCuuqhAsV7nfKI4Fnrf4LSdC4VNMUn7tnhC5aVMGCfrC3WJKkr4cWgdV77dZnEuQFekUajhrSQiLcHRBrESDVQcmftp0ntcy/2P0VeLGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305830; c=relaxed/simple;
	bh=vJeynXzSbObzCiZEczv8O9LSOAFBCuXF6mq/gv9fvns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXowvxRy3IN1GwywGsCh+e1z+a1GJ1B3IkEyHYZWNaRv9bo2GjCSwsRhuTaY0cPE66iQy9JBQbpCStCt+iWV4L5ZNutIn0rdWnxSsSN/9Xe4EdXCdKSTeOl3R4J5tBVye+tiR6srRXi9NbEvpI0hJo3SWhcrVllvlN0Cy0W0fJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RPy0OMlZ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGn4P005872;
	Tue, 16 Apr 2024 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713305809;
	bh=5fFjsE7qYg1xQka+npjG1RwNxaaDeLUVU3EWXAPxP0w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RPy0OMlZJBEmq9XW4ba1WPDWXxDI2eHEQt1bkMGNbX/4xmHahsYHp9IeQMwWGwKD0
	 Fjq2OTHKDNm+F54qky1V+YVGKazS/9LICnaOGo1th8YX093J9nJoBOn4A5SZMFOQvW
	 pbdb3OlhbmFlfVYEKuGl4vEPaXUIdx5D1gpC/7ZU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GMGnZS051571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 17:16:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 17:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 17:16:48 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGmSo102285;
	Tue, 16 Apr 2024 17:16:48 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
Subject: [PATCH v2 4/6] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
Date: Tue, 16 Apr 2024 17:16:46 -0500
Message-ID: <20240416221648.3522201-5-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240416221648.3522201-1-jm@ti.com>
References: <20240416221648.3522201-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Bhavya Kapoor <b-kapoor@ti.com>

According to TRM for J721S2, SDR104 speed mode is supported by the SoC
but its capabilities were masked in device tree. Remove sdhci-caps-mask
to enable support for SDR104 speed mode for SD card in J721S2 SoC.

[+] Refer to : section 12.3.6.1.1 MMCSD Features, in J721S2 TRM
- https://www.ti.com/lit/zip/spruj28

Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
Changes since v1:
- no change
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 3cb06a7e4117f..9ed6949b40e9d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -768,8 +768,6 @@ main_sdhci1: mmc@4fb0000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		/* Masking support for SDR104 capability */
-		sdhci-caps-mask = <0x00000003 0x00000000>;
 		status = "disabled";
 	};
 
-- 
2.43.2


