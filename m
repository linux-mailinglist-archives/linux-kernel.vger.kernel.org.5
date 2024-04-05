Return-Path: <linux-kernel+bounces-132683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F1489988C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C93CB22AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14882160783;
	Fri,  5 Apr 2024 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="caR5pVRU"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8715FCF1;
	Fri,  5 Apr 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307150; cv=none; b=Ead+4+3UVHnoLcUlzlQG4kpkrLR0Sbp3jFPfWyZ6RRqslCiGrh/DG4SKqbABnnfoJ/69O9qIxb0NuYb9kZoo/95JOHeeGpd/BzU3xasSo/dTZSjVpc3Do4nueFvTKDbEHr/rcdeAfBIAExfnkCzaXG6Hk/DInmAfwXOLaJbQ52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307150; c=relaxed/simple;
	bh=aQkltj1P8xhIjFm5GPr2ARa9v/hJuwym/eVlFOxnZjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FEoVFFm0jWkFTz3FheFTAiC0JhpNDdRiiTEVpzRgZJHSTRKgjTL4gFpw/aBuXUBiWwF14amZUeHZsyH+KZNHwQVqcYTP+BKURF2ih+LHVauFevp/lM0J4px27MLA4GrWKP9mQ2PRMFP1XrtYdXHRjGaa3dKWigHRulS0DnPX470=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=caR5pVRU; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358qFX4028729;
	Fri, 5 Apr 2024 03:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712307135;
	bh=vEbouFWGbc4A14TH9HK+KQsmQbC7/2UlOUwHmqgy4mU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=caR5pVRUXu0YBfZukvfMS4inTjEzIKFRmCyLcfrI0Zrjdge81buLTOjQhED+dsNYA
	 fG+PUFAbO72rwwgIvo/6b/JgNB1bcozYaE0b4bZKMsyxXN3/6ENM/wfZZWiBM640bO
	 3FpNteJ/zRkdaGHoU4kznnx1xY1nkzozL1frpPHc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358qEpn012764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 03:52:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:52:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:52:14 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358qDaM088455;
	Fri, 5 Apr 2024 03:52:14 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <devicetree@vger.kernel.org>,
        <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] arm64: dts: ti: k3-am62p-main: Fix the reg-range for dma-controller
Date: Fri, 5 Apr 2024 14:22:08 +0530
Message-ID: <20240405085208.32227-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405085208.32227-1-j-choudhary@ti.com>
References: <20240405085208.32227-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The TX Channel Realtime Registers region 'tchanrt' is 128KB and Ring
Realtime Registers region 'ringrt' is 2MB as shown in memory map in
the TRM[0]. So fix ranges for those reg-regions.

[0]: <https://www.ti.com/lit/pdf/spruj83>

Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..514c201bd5c9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -123,8 +123,8 @@ main_pktdma: dma-controller@485c0000 {
 			compatible = "ti,am64-dmss-pktdma";
 			reg = <0x00 0x485c0000 0x00 0x100>,
 			      <0x00 0x4a800000 0x00 0x20000>,
-			      <0x00 0x4aa00000 0x00 0x40000>,
-			      <0x00 0x4b800000 0x00 0x400000>,
+			      <0x00 0x4aa00000 0x00 0x20000>,
+			      <0x00 0x4b800000 0x00 0x200000>,
 			      <0x00 0x485e0000 0x00 0x10000>,
 			      <0x00 0x484a0000 0x00 0x2000>,
 			      <0x00 0x484c0000 0x00 0x2000>,
-- 
2.25.1


