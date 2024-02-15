Return-Path: <linux-kernel+bounces-66718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7BE85609B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5036A1F267FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450C12FF83;
	Thu, 15 Feb 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yug2Ruys"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148284FC2;
	Thu, 15 Feb 2024 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994460; cv=none; b=asLfMeNJNpjOl5VyW7XvNv2HCeH6R13ti8gkxRaPfPFNOYYkfnWCVifVsbptsIxdX12kjo2RNEaoqiLcGQdso8XQd+B78Nw0f/BRBhEaEDxQTYg8iH18fqqDprquCpUB1r2/Kfi9zecIIH2OK05lk58EI/9TW6e3/DPUxNLCY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994460; c=relaxed/simple;
	bh=cC3P+3YPJZ8DEQuyMwtvREG1h4T/0uy60ycQvGZgIOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvjjbY/ujjRExf1lqZSBtzF6Sp6/1zh5SpAB4m7POlMy/oisoRzAxAzjQmm9v389sHCXZDmIKep32fSHV1PLmN7r/LhiA3ZWScNpbrjtnKmaa/VYWjBmR5TPlpPKUgK9BojATqR/BCu4Jluf+cXKUY9wwt1EoALcpmVwEliQSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yug2Ruys; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FAsArR079124;
	Thu, 15 Feb 2024 04:54:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707994450;
	bh=RoF4JGo7T+l/qiSRUHs0bG2icW5UtJRDcR9gW/2M1xs=;
	h=From:To:CC:Subject:Date;
	b=yug2RuyssKJoI+tWVV4Ypg7kcuLnSaKvT8LbVeAva9P70YaSQ/CourxfeOEHI3gcq
	 Av+oyo3bXyAa5Y9xwWuVuod9QIt1i4j8jXaL/IHOYiFo1tt2ZXBJ6Z8RH2iX+DmVP4
	 Ctz3RRRDer5jMr4Y+k+kmjGOQWKEZUJKonkcJKG4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FAsATZ072313
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 04:54:10 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 04:54:10 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 04:54:10 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FAsAEr026545;
	Thu, 15 Feb 2024 04:54:10 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41FAs95d003642;
	Thu, 15 Feb 2024 04:54:09 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay from ICSSG nodes
Date: Thu, 15 Feb 2024 16:24:07 +0530
Message-ID: <20240215105407.2868266-1-danishanwar@ti.com>
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

Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
property is no longer used by ICSSG driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
index 0a6e75265ba9..bb0e29873df7 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso
@@ -68,7 +68,6 @@ icssg2_emac0: port@0 {
 				reg = <0>;
 				phy-handle = <&icssg2_phy0>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4120>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
@@ -76,7 +75,6 @@ icssg2_emac1: port@1 {
 				reg = <1>;
 				phy-handle = <&icssg2_phy1>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4124>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
diff --git a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
index 8bdb87fcbde0..d4bc80032587 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am654-idk.dtso
@@ -72,7 +72,6 @@ icssg0_emac0: port@0 {
 				reg = <0>;
 				phy-handle = <&icssg0_phy0>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4100>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
@@ -80,7 +79,6 @@ icssg0_emac1: port@1 {
 				reg = <1>;
 				phy-handle = <&icssg0_phy1>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4104>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
@@ -140,7 +138,6 @@ icssg1_emac0: port@0 {
 				reg = <0>;
 				phy-handle = <&icssg1_phy0>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4110>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
@@ -148,7 +145,6 @@ icssg1_emac1: port@1 {
 				reg = <1>;
 				phy-handle = <&icssg1_phy1>;
 				phy-mode = "rgmii-id";
-				ti,syscon-rgmii-delay = <&scm_conf 0x4114>;
 				/* Filled in by bootloader */
 				local-mac-address = [00 00 00 00 00 00];
 			};
-- 
2.34.1


