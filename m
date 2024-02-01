Return-Path: <linux-kernel+bounces-47756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AE0845266
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89B42914AF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC85158D9D;
	Thu,  1 Feb 2024 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n5eHxbE8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4215AABB;
	Thu,  1 Feb 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774869; cv=none; b=d7a990Pqfm0E71lwZ0C/SKV7QD3wFbUA4xTkS+4w+Xfkd9VAFX+f2UuxUUtpIvDPWVkQUU5eba8KgjRoGSirGXdmOCYDtGL+tgWCem9hbZv6PVullba7NaIU3bNRD9KHWqNOcKEAhP41eIBa4aSpvM0+tyCH1Cd9nGUKQVK2XJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774869; c=relaxed/simple;
	bh=qBOLrlBKdqF3V5rMSeFlHkmEIMc03HnzCH7N02FsGXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UXQLlPqxS7TDX45wB3F/Tvpm3PDNRO7inSdGVjIcNFoeLNVDy4PBUf0CNEgiBRtWWh7zCaLyd7BWF8BGamduptoS7OMnsoFwh93i0VUjO4FMKW+JqRUCqphacxzbhcvMHZgasFp6IXxS+gDs5SZsUI3iYQZ4CAQBaSxg4DywIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n5eHxbE8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41187cAE027177;
	Thu, 1 Feb 2024 02:07:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706774859;
	bh=FhmsYXLywkyvkyPF5PhLDc++LK21ZldZCNjEHwXHhfU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=n5eHxbE8ryWAQf8IizORLks5AO1itKK4FkZScLwFB7kG+V78ew4+qySepRUFEOGOn
	 vwadjfIL8nNeO61iriK584CUFX6GogxsXHWr4RsSgENNpDiC/6TKl8Iul58i4p70ni
	 AzjgsWb6ikzgkU1G4ahZc7F7Gja4W3K8JFkr31Pw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41187c5K019984
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 02:07:38 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 02:07:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 02:07:38 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41187Qbx125056;
	Thu, 1 Feb 2024 02:07:35 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 1 Feb 2024 13:37:27 +0530
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4: Fix power domain for VTM
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-2-85fd568b77e3@ti.com>
References: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
In-Reply-To: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Keerthy <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Manorit
 Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706774846; l=966;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=qBOLrlBKdqF3V5rMSeFlHkmEIMc03HnzCH7N02FsGXQ=;
 b=+gslCFWz0rLaQG4oPPuVLEqrJTUgV4yKkJwpFH45cSRCaoYR4SJUdAH+X6SIwrG+5dUqzqjVF
 dxu2mgUsgbuBir5yeBS+GiT20KQLkV3nFvl4YeNSiItnT2SeoEdyXFr
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Fix the power domain device ID for wkup_vtm0 node.

Link: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/devices.html
Fixes: 64821fbf6738 ("arm64: dts: ti: j784s4: Add VTM node")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 3902a921d7e5..337122c3f402 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -628,7 +628,7 @@ wkup_vtm0: temperature-sensor@42040000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0x42040000 0x00 0x350>,
 		      <0x00 0x42050000 0x00 0x350>;
-		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
+		power-domains = <&k3_pds 243 TI_SCI_PD_SHARED>;
 		#thermal-sensor-cells = <1>;
 	};
 

-- 
2.43.0


