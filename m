Return-Path: <linux-kernel+bounces-36141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49883839C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1D13B28AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6559154;
	Tue, 23 Jan 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lNjNQVCw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65544F8A6;
	Tue, 23 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048752; cv=none; b=I9xHMNxjXSr1kbOX5H7Oc2H7/TNa9gIXkYXB0ug5HEqIbBvropsprXjg4j7ghlu0hbT8cSWXOjOI+H2Bu+MUqE3spsv/x4JAAuZWSosWL2mX/kx1QGHYg7o0m2vt7/rGfFuEetvz5Vz1OWom0+rD/uAlENV0ZQST1U5XG6DI+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048752; c=relaxed/simple;
	bh=TTIzUYgsYdYaE23OTf1e6h1lOh6T+Z/Z8jdCEFoNWZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oh7mC5FzkHJfEDfW5iGaodwy9F1x06f4EMvpI3aUJWZgEYYge9pg2U1jqkY9cD0Qm+G+Bo3YFFqocBCuGFxdejB7SCndz5yl/K8X+z+VL9o7Kr1w70VZXWeYUE9diOu0dYkjdP7LLYVQLRdYhRg9mK9XWuen5W9yWAkhdflHa2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lNjNQVCw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPfqm035844;
	Tue, 23 Jan 2024 16:25:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048741;
	bh=1CardhUWIEsRehUR6yMCG86G1767ogncfcpAjM8tOsc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lNjNQVCw/sSU/7ZNCusx2+tGYSyFChCQhBn+EPxh1EbIyi8kdI/Yu9idmrKWRbR8p
	 T4SMTa2e9V1Atk52+qA5Odfq84Qqf2w73De4bclV+Wr/PkfVv4vhiOaDcf/E48txDr
	 HdiukPc5KqZzp+pZ7NhEA3rMOb64fkkw37VdElsQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPfvS089491
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:41 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPabe064564;
	Tue, 23 Jan 2024 16:25:41 -0600
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
Subject: [PATCH 11/11] arm64: dts: ti: k3-j721s2-som-p0: Do not split single items
Date: Tue, 23 Jan 2024 16:25:36 -0600
Message-ID: <20240123222536.875797-11-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index da3237b23b63a..6eca93893f8c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -504,51 +504,51 @@ mbox_c71_1: mbox-c71-1 {
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


