Return-Path: <linux-kernel+bounces-155454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC9E8AEACC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1F71F22620
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831E313D61D;
	Tue, 23 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ChPSXrCm"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95CD13C67E;
	Tue, 23 Apr 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885472; cv=none; b=TZ8xcwiVdVaBsBYwjMLx3TaUaLmKpJHs3fuPmKhGyMV1syjEJWM4Yclwe++uNUf4qYydbwLIQE0YjMvPIjE5en6VG5TPRRWsTjt2G4LgA14GT0VfJo/HjNmzf3f9mzpatYH6b/bbzdcMGBG3UtFm09YE2EvyjIFgbPNw1vhNDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885472; c=relaxed/simple;
	bh=bvgv9aLUJ3EMk1jeY5CIgMbaDSjxNRI7pgf5rK8d4Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckox7BwONBOLv8HXVyAMS37MGigWQ0aLNg/PuglRcqpn8jtldrtSm9jNIIUHDje1oPMBdHDs4sL4kl316qkGpsrLsjuhLX+jhz4RgHTnX4F6zI3B/+qx0tBH96qqMC/RncPACuQuAm6mjzDeYcCimqKrWAdAZfI3q1xdZJ3os5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ChPSXrCm; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHXIV078995;
	Tue, 23 Apr 2024 10:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885453;
	bh=lvfJKgIkkEKUauOE6w6qO3n0tQqMfPCnxJ2Toh2ImOo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ChPSXrCmw4Uan0ilpxHCww+JQG7wUpj/H1+Gy/oFr1y0/n3TtXwZyJkcgyIo0ldj2
	 klj2eDeumoVT1e6ahMjGdyHWGY3GKgbpzGfQVylHXSWpcwHrp3EM3U1r0/iHUR6tSh
	 ybKgeC5RcI8qzjiDtTEMgA4bvbGylszd6/+LUs40=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHWZm130282
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYL080176;
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
Subject: [PATCH v3 5/5] arm64: dts: ti: k3-j784s4-main: Enable support for UHS mode
Date: Tue, 23 Apr 2024 10:17:32 -0500
Message-ID: <20240423151732.3541894-6-jm@ti.com>
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
Changes since v2:
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


