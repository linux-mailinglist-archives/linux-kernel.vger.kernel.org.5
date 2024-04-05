Return-Path: <linux-kernel+bounces-132680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F93899884
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419D7283A75
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DD15FA7F;
	Fri,  5 Apr 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qbaHx9LP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C29156F41;
	Fri,  5 Apr 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307145; cv=none; b=Hl4ObttZmbPsfIXYutvW9HEevMIbJ/a2TTJPFkCUWr/xVxRBqW/PSfjPDvnyOtu790gbMdr8bgdjTfwh62pucXPg22cFZA+PdZ/ob7BlopenMyS34VUR6KkBHo/jEbKBrF0b24534u2c6jxvYobJhHJIqZal8hGVtpO4o7hMNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307145; c=relaxed/simple;
	bh=niZlYtfCLrMne534ec6WJFCIF+3DuPyJEDqF52S2PiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txgdO6iMTFFno/JNda0l8Yk8oJ0qDPEO++tGPVU8Fm9LYNvGoKr7mNOiHDs2hIgIYlW6MKhhviIB5Z+55JxIKeBTTf6KwGt5aQ6nvxi/GyKGTxHTSpx6I1tIITt2Akvs0fk6lzEJLG9Mb00VZFLu2KK8se8Rm4QXWjAK/sMwl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qbaHx9LP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358qDll086828;
	Fri, 5 Apr 2024 03:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712307133;
	bh=0+pgL5sYXWQrEyQ8WRbOdfuKAJusw9KWVyr0gb2oMUc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qbaHx9LPr//gl4y7EIoCfJB9QKOag/wBsRaWMGIECYqBJfYAMG4p7YCdYUziIde71
	 dfASFZMY/+dQ7WChUJ0gqRXCtzqIbHQDAlFbbSHtWk0VT1PNPbZihojUoUuHwxI46F
	 2M4P1BxALOIEu79nbpPOryfrw0LEmBswMxKGQlfE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358qD1K117252
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 03:52:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:52:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:52:13 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358qCvp052204;
	Fri, 5 Apr 2024 03:52:12 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <devicetree@vger.kernel.org>,
        <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62a-main: Fix the reg-range for dma-controller
Date: Fri, 5 Apr 2024 14:22:07 +0530
Message-ID: <20240405085208.32227-3-j-choudhary@ti.com>
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

[0]: <https://www.ti.com/lit/pdf/spruj16>

Fixes: 3dad70def7ff ("arm64: dts: ti: k3-am62a-main: Add more peripheral nodes")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index aa1e057082f0..5a4cb0536c6f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -120,8 +120,8 @@ main_pktdma: dma-controller@485c0000 {
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


