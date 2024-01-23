Return-Path: <linux-kernel+bounces-36138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69793839C26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF681C2259D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8C54BE5;
	Tue, 23 Jan 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SlrEkD4w"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70C4F5EB;
	Tue, 23 Jan 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048751; cv=none; b=iVM0w6tAZH70RhOlZFoKcfs0VFi/7zSmy4V3iZ+WppgNyDXMZsmoAcYM1g3N2cTkVObWrDI9wC5h+CK4BS1vguy7QdSKz3v+q3LOUX7UxbAHICb73OQD8QmGgFWyH/bEHsaUbCUbWD27/bhzJPoS/MK/wJ+fDVmhP9cXkPIXhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048751; c=relaxed/simple;
	bh=oc66i+J8FIXzfMZDlhelYK65BALtI71W6bMVaYn9q+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoPqTfoQKhSAvs6AkPepqI+y2kyfGrYRS9srbIM4iBUWhaFatEi9s8U38KNDX0ILZp0WGVPr72sabzjuZ8alOkiXWc3ozzNNfY3opqOY+dNgty23Z7hOFF7baAjz8fDkYIsJ6+zbt+WbM8ZfIIavKwpacMmCdB9wh5Lnobm6fhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SlrEkD4w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPdtW058359;
	Tue, 23 Jan 2024 16:25:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048739;
	bh=kpIGEacaVC9vMA9m+5S7UgPA+pF/XEz4DGyuNNYIfno=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SlrEkD4wjcZ2rlSzhBWXS9f1jSn1dz0iCLC2MsDmhmJqgh25MEGa19rh6CaCIdWuT
	 T8Ijw/EZ1gc/MYnHSUAmepwb2axGr9vu7Rpd+ngyFzgERGyTnu6J5g/RYUrHeDOJah
	 oJCIrmcGQAjqOSDyVcfDrbq5TDRIXbYk2GtSKYpU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPdYe122098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:39 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:39 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPabZ064564;
	Tue, 23 Jan 2024 16:25:38 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 06/11] arm64: dts: ti: k3-am69-sk: Do not split single items
Date: Tue, 23 Jan 2024 16:25:31 -0600
Message-ID: <20240123222536.875797-6-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123222536.875797-1-afd@ti.com>
References: <20240123222536.875797-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Each "mboxes" item is composed of two cells. It seems these got split
as they appeared to be two items in an array, but are actually a single
two-cell item. Rejoin these cells.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 8da5915798688..62b87c34c442d 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -822,77 +822,77 @@ &mcu_cpsw_port1 {
 };
 
 &mcu_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
 };
 
 &mcu_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core1>;
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss0_core0 {
-	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
 			<&main_r5fss0_core0_memory_region>;
 };
 
 &main_r5fss0_core1 {
-	mboxes = <&mailbox0_cluster1>, <&mbox_main_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1 &mbox_main_r5fss0_core1>;
 	memory-region = <&main_r5fss0_core1_dma_memory_region>,
 			<&main_r5fss0_core1_memory_region>;
 };
 
 &main_r5fss1_core0 {
-	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core0>;
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core0>;
 	memory-region = <&main_r5fss1_core0_dma_memory_region>,
 			<&main_r5fss1_core0_memory_region>;
 };
 
 &main_r5fss1_core1 {
-	mboxes = <&mailbox0_cluster2>, <&mbox_main_r5fss1_core1>;
+	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss1_core1>;
 	memory-region = <&main_r5fss1_core1_dma_memory_region>,
 			<&main_r5fss1_core1_memory_region>;
 };
 
 &main_r5fss2_core0 {
-	mboxes = <&mailbox0_cluster3>, <&mbox_main_r5fss2_core0>;
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core0>;
 	memory-region = <&main_r5fss2_core0_dma_memory_region>,
 			<&main_r5fss2_core0_memory_region>;
 };
 
 &main_r5fss2_core1 {
-	mboxes = <&mailbox0_cluster3>, <&mbox_main_r5fss2_core1>;
+	mboxes = <&mailbox0_cluster3 &mbox_main_r5fss2_core1>;
 	memory-region = <&main_r5fss2_core1_dma_memory_region>,
 			<&main_r5fss2_core1_memory_region>;
 };
 
 &c71_0 {
 	status = "okay";
-	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
+	mboxes = <&mailbox0_cluster4 &mbox_c71_0>;
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
 
 &c71_1 {
 	status = "okay";
-	mboxes = <&mailbox0_cluster4>, <&mbox_c71_1>;
+	mboxes = <&mailbox0_cluster4 &mbox_c71_1>;
 	memory-region = <&c71_1_dma_memory_region>,
 			<&c71_1_memory_region>;
 };
 
 &c71_2 {
 	status = "okay";
-	mboxes = <&mailbox0_cluster5>, <&mbox_c71_2>;
+	mboxes = <&mailbox0_cluster5 &mbox_c71_2>;
 	memory-region = <&c71_2_dma_memory_region>,
 			<&c71_2_memory_region>;
 };
 
 &c71_3 {
 	status = "okay";
-	mboxes = <&mailbox0_cluster5>, <&mbox_c71_3>;
+	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
 	memory-region = <&c71_3_dma_memory_region>,
 			<&c71_3_memory_region>;
 };
-- 
2.39.2


