Return-Path: <linux-kernel+bounces-47754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3C845262
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE2D2903C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5C15A4B6;
	Thu,  1 Feb 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C+1ZIyx0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17715959F;
	Thu,  1 Feb 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774864; cv=none; b=MUhlL9QcnH8kBYUGrUjbM4b5TBa//k6+qq8tRAtPjJ2HPBDyuwLm/23+M0l0G0T0z7VLo2aJ9Ak16tl3milJ2hhzTaVLFfLoUALokjXQkUsISpXqqLLoubi4XfbvsLaKr+nTjC45YqtaAs8dx7+ouOeRDXdkk+hMIQK5kW0HzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774864; c=relaxed/simple;
	bh=Hwrr0kmuVsEHIUtalUATyUz+Tce2M5g7wwCLg2n5S+I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=a6LsWFyUistj+pp8ZTezN6aqcLGUjZqgaD2IRPeFsC1+bn9pVOdvUqgqnNj2Qh8wWCjStJiFgSrb7T9e5BtYUf1oUPPYbqqnklQccT3bZlij4rnc91w3gn2/7faZ+MrT944KENNi+x4HUBKGEh+jJV6mZS4O+V+rBHYgXEQn4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C+1ZIyx0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41187VO8021686;
	Thu, 1 Feb 2024 02:07:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706774851;
	bh=2rwS6SiFYbqR/LtHxb09XF7asVFx/ueha5+v0460no8=;
	h=From:Subject:Date:To:CC;
	b=C+1ZIyx046h2n+Ue3lDxqfSGXmohk0f4HDBq/ht8/eav5vg4IMbUNvm8vPWIXtEO4
	 kutRWKa0rBOrDg0Zs2/WTul16IWL01LoJ2gYjp+kj0k/sKH3Kc9kBSRkdlUTT2OgNV
	 xoIRCw5WFuYAUiDRC1JnZ3L+C27D8vWIYwkzCTYI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41187VPO019835
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 02:07:31 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 02:07:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 02:07:30 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41187Qbv125056;
	Thu, 1 Feb 2024 02:07:27 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/2] TI: K3: Fix the device IDs for VTM node.
Date: Thu, 1 Feb 2024 13:37:25 +0530
Message-ID: <20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1Ru2UC/4WNwQ6CMBBEf4Xs2TW0UKGe/A/DoZRV1gRK2tpoC
 P9uJd49vsnMmxUCeaYA52IFT4kDuzmDPBRgRzPfCXnIDLKUdSlkhX2NzyVET2bCRyNFkHjjF6Y
 44ZD3A7YnUsq2RmlrIGsWT7mwX1y7zCOH6Px7f0zim/7klfgvTwIF6tpq2fS9VlpdIh+tm6Dbt
 u0D4t6ais0AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706774846; l=739;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Hwrr0kmuVsEHIUtalUATyUz+Tce2M5g7wwCLg2n5S+I=;
 b=iUL4FZxJVLwILx+/jkZ6iQixTS5eOuk/gRqFsLxTh26wFxmmanFIILqpV4KlH//QchcZV4c9y
 CKba2H+I1PDBxnTegyjs0RADh8XGJSkYNcjELxw6bpLp4WhrJ/WxygD
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Fix the device ID for J784s4 ( Andrew )
- Link to v1: https://lore.kernel.org/r/20240131-b4-upstream-j721s2-fix-vtm-devid-v1-1-94c927bb9595@ti.com

---
Manorit Chawdhry (2):
      arm64: dts: ti: k3-j721s2: Fix power domain for VTM node
      arm64: dts: ti: k3-j784s4: Fix power domain for VTM node

 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 774551425799cb5bbac94e1768fd69eec4f78dd4
change-id: 20240123-b4-upstream-j721s2-fix-vtm-devid-86e55c8a59ca

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


