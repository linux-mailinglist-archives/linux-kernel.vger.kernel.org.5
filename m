Return-Path: <linux-kernel+bounces-155453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A128AEAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A54B1C21981
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F37913D51F;
	Tue, 23 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h7aWr+v/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27513D283;
	Tue, 23 Apr 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885472; cv=none; b=NKQnkz0SglcSI01IMrkmZ5r102xD7w7zlZxmUfbfUusjkFAup4Et69GQmWFRYuIHzQxSPB2XTxMai5Oc1N+sd0mjlr5WdlKjb50DNdkdQS1Fl+2QAoGcHaU+BMCxYzfB9x61lOCG5+5xipsZrdJ0ohNMdgx46S1SzP929TZABBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885472; c=relaxed/simple;
	bh=BgYwzp3IVSxmJsWJ+uvEnGTajLYROdz++/P1GyIcLnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIGBAdOt7mS+jV50j5qTxvwZXcWYSBXeBUiyBbsRyEJ5YliUiuvPwcWV4v7L/Inc47aScO9FtWKkOzNnNevqCkJy9KG0Wby0gF23vE924n9bAhZuXLTh5cG3RQ/E4sWPB8EH/Ev8/gfLBu67DaFcRKDK+JSHryr4gmsPpyBzYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h7aWr+v/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWHR078991;
	Tue, 23 Apr 2024 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885452;
	bh=Uqap8NTtetZjcVQFHCxp/DtkI7bBziVrJJW13NztFOE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h7aWr+v/tN04S3vptUryjD2CG/9lpeQpT2hwdRMualOuGLHaqRBRCWlVt2qkiMvTk
	 0mvP3NLpq8FAERfZclhOLFisvpyhk1JP5nLsdSVzxjuDppSknIXUA9SZJNydzCXn2A
	 SeLh5s5DMMKeggLG9d2Pkczaq65dvOV2Ykq6smEQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHWIF098211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYK080176;
	Tue, 23 Apr 2024 10:17:32 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 4/5] arm64: dts: ti: k3-j721s2-main: Enable support for SDR104 speed mode
Date: Tue, 23 Apr 2024 10:17:31 -0500
Message-ID: <20240423151732.3541894-5-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
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
Changes since v2:
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


