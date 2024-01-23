Return-Path: <linux-kernel+bounces-36137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E1839C25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8CD1F2225F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77A54BD5;
	Tue, 23 Jan 2024 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nryuQxf8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133704F613;
	Tue, 23 Jan 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048751; cv=none; b=kxZXY563mY/PpWnR/5rSm2rpB0Y/FPnhamqoBPFmtGkBngD/Ry5XFbGwVGddhCKnkGAGuxCjhcfgGSROKi3wyGIaD8vjX14ybYICOJnQrdwScPc9/NIZ0M7T4SbFsJII2pynzuBKWZe9Y8SHucW3vsybUSotnt6SR0bCP/tpqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048751; c=relaxed/simple;
	bh=WGe2el4xcb0i2lJOf3mXvkDd1huDnWBcYb48owS8hxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB7+Ic1RUQ8+AjwvdNwtYPdiEUk4BhY3BC6o/X8S3ViOUhTC5IFawMJhpJerbktVaa/RGmjbk2nFLFUkRKTwJjaoh6/SaT/bB4UJh8pFBUiVoOkHgqCslftUdK5fVSCpB8VxBFeNr4igZWR+CzWdfEZ8LaxI2ub3S+bDS82wMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nryuQxf8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPdGH019496;
	Tue, 23 Jan 2024 16:25:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048739;
	bh=n8tLL3Yrw87gmA9q9zSoBaId8teK0A8dUGjjCJOkpXA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nryuQxf81LB92eUgfsayuA9nil8p66OaqcZFdLjqTWp8/1t5Rk3gUGKRyyJ4NTf41
	 bjT6ZpCz6HT7pXYCocZPpfH9KqfERnIuL2EyiaGA2ajM3RAma4GP1fQQcUuejOYzWq
	 thadVgu1T8AM4TW6AHGEPacPtyzKJG9KZvGF/AJk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPd4g089413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:39 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:38 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPabY064564;
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
Subject: [PATCH 05/11] arm64: dts: ti: k3-am68-sk-som: Do not split single items
Date: Tue, 23 Jan 2024 16:25:30 -0600
Message-ID: <20240123222536.875797-5-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
index 20861a0a46b0d..250f80b402d60 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
@@ -209,51 +209,51 @@ mbox_c71_1: mbox-c71-1 {
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
-- 
2.39.2


