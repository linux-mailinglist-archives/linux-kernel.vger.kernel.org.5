Return-Path: <linux-kernel+bounces-132681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EFB899888
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB08B227E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03AA15FCF5;
	Fri,  5 Apr 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OGU5/DyI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950615FCE5;
	Fri,  5 Apr 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712307149; cv=none; b=RHjgfH+BkxNQO8R17ZvmIIW7txfWezqPLUVjBHbYzYYQaLqtBZzY6i6ZPbpOX9138fFg2wb13fifHmsFw79iP8wx0p7Av///5VpPakP4POHS1pLDYktcgkMUtWmVCj17ee0ZKzbPD+9YOK0M+fBalD8Pnv+xiwBu4gwG0T1iVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712307149; c=relaxed/simple;
	bh=j7DeTARfPhVA/K6fz4+W71IKrGDY/LPVV1nfF8fqE1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpSpJeLbVzYsLHVNlM7SwcRYOfSg2LwCcvF2kWrwAZmZEMV3VaMRraS1kDAp8NJ6QDkPENTZL3D8cZ6y6+tDB/lJgzCln7JrTz8EhPv2FV0QPGsw5Wddcf8jveDfrQ4GFYurFW66QkdOqRGX/9g4eG0wU8nMskqNNI9rO0ooQTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OGU5/DyI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4358qCtk040709;
	Fri, 5 Apr 2024 03:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712307132;
	bh=v0VTa/H/JYRAZFZRrz5MO/IA0PGHiaKixUHemOt8XT4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OGU5/DyIyOUIrUZZVMsfJFpRq5ltVm6qapPSoc5W3tMhtkxPp6ha3bigmyQ4T00XJ
	 oquss9Crld2MhuJqNSw9LSshwc8o17zFPGio5zz24FIFnZ4Bn9DMakYbxwbAPl8het
	 vFDWkV6tf5aObj5tKsQ/tr8ZkiGE+4ja7HGevzb4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4358qCeT117240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 03:52:12 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Apr 2024 03:52:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Apr 2024 03:52:11 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4358qA1f052181;
	Fri, 5 Apr 2024 03:52:11 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <devicetree@vger.kernel.org>,
        <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Fix the reg-range for dma-controller
Date: Fri, 5 Apr 2024 14:22:06 +0530
Message-ID: <20240405085208.32227-2-j-choudhary@ti.com>
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

[0]: <https://www.ti.com/lit/pdf/spruiv7>

Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index e9cffca073ef..e10cc9fc0b10 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -141,8 +141,8 @@ main_pktdma: dma-controller@485c0000 {
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


