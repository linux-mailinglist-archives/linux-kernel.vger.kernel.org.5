Return-Path: <linux-kernel+bounces-147679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A68A77A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FFD284150
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657313A24A;
	Tue, 16 Apr 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x++c0dsK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC584D3B;
	Tue, 16 Apr 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305829; cv=none; b=GaER0WwQ9tLSPDyEkh6ycs8Mgpi9clxsUiZXu414IoC0hqu7GYT9R9ZWOYZAhkzdKunw35+hZ7bGOkdz37b5yRu7A1vZQ/eRnJPul+Vjv3JFkwbajydwuLLAY5wSmg87atg8G4smhor4TnGLxKh3ragIdMpw9v/6YMkRIGTPKdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305829; c=relaxed/simple;
	bh=/r2A3U86DrQWK58HmyUtSBfncTMbSG8hZpg5gw3B6c8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rMgmoO12mmNJ0WnVSOkPTjiBjkSMccp9Ayg5ksaz+XjrOYiUPZaPvcKcQOWZn6GJsKVcpb4e6/qWCip+6Y3/TNWM/frttD/LQqMxk5Q3ydJ7bmuHSrRAfqAeD9lRLXeINu7HKpOGPYtprsWntljYM0A2y4rc3M9I8jBQTlGHjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x++c0dsK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGnFN065475;
	Tue, 16 Apr 2024 17:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713305809;
	bh=hC7S8iATRYbpfYUlqNN78DDTwCwaRv8ntPclDXxhb1A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=x++c0dsKiwMKcr2g0urHtzuvZ5XmTvzDj5Gn3khp+TNEnpjLaGvJHY+QPz2dWKSod
	 mU2zJ0sANoB2JMOIcqUwl44RUUUWE9KKi1f8eogFgMAqGlkT9WrMfeATz9cyFivhHN
	 m+YnePQOnUHHvTBzTzRudYGW6cqa1hudMiiWwvOg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43GMGnpv080068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 17:16:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 17:16:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 17:16:49 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43GMGmSp102285;
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
Subject: [PATCH v2 5/6] arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
Date: Tue, 16 Apr 2024 17:16:47 -0500
Message-ID: <20240416221648.3522201-6-jm@ti.com>
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

From: Dasnavis Sabiya <sabiya.d@ti.com>

Remove sdhci-caps-mask to enable support for SDR104 speed mode for
SD card and remove no-1-8-v property so that SD card can work in
any UHS-1 high speed mode it can support.

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[Judith: Add fixes tag]
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- no change
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index d42f25cacf23d..6a4554c6c9c13 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -904,8 +904,6 @@ main_sdhci1: mmc@4fb0000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		dma-coherent;
-		sdhci-caps-mask = <0x00000003 0x00000000>;
-		no-1-8-v;
 		status = "disabled";
 	};
 
-- 
2.43.2


