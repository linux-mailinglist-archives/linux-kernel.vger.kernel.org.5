Return-Path: <linux-kernel+bounces-36134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCC839C18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA9E2860C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8A4F898;
	Tue, 23 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lNwro9j9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D24F209;
	Tue, 23 Jan 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048750; cv=none; b=q2GpVuQgafKelsAX2/xSEsVBI989kgynhLQVZwE9dlTyRZCJYSEtFO5/uidlm8aw7HyIy2Tfc6lozb/CNYjBek2aM4qyrkyq1DGWu9liCjPjxWEIEpmL4HLUNKKk9XcvehzdUs2I6cTWJE7wkjQomoN71jFrXQIA4trxAeOwRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048750; c=relaxed/simple;
	bh=Z55julfIkAk1xPk/YzvS7Mw/wDap3WFSfN+47RwN9v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQdlykdUnPX0vvm5JUhO6a4xXx1ClK+ZsVJbCLmNWaJTw0Vxf/rCSmWfPMcOb4Uu4hRcAIGnFaOrrfRxXNPSdtbW1QkHdFSjbpLkozFMu+qLqKOAUU55TCWUIlvLaMGpWAttoBzLA90C3Fgbde1UC3/MPHpAPuKwmGuwWwwQ8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lNwro9j9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPcjL019491;
	Tue, 23 Jan 2024 16:25:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706048738;
	bh=ylKDOE0UXQcvGAVfpA58pJz65qmtlBmIgJNE0PcTLQc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lNwro9j912BPD6GQCO6dG3XeSOYwtpSYCQm+nGzFBHVuHK/j7sodLNAD3RtwGBVpi
	 jO5AiB6mwSviwMc+eSk0BYql+2cr6sVJGSx2gIi9ZL40MovD+5hS3YGgJ4jhIvrhRn
	 s+Rmb1PIP8j+JTIR1xjv9G+aZNyx2neBIqm+AsIA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NMPcOC122080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 16:25:38 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 16:25:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 16:25:37 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NMPabW064564;
	Tue, 23 Jan 2024 16:25:37 -0600
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
Subject: [PATCH 03/11] arm64: dts: ti: iot2050: Do not split single items
Date: Tue, 23 Jan 2024 16:25:28 -0600
Message-ID: <20240123222536.875797-3-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 61a634afaa4fe..0368b04700a18 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -1418,13 +1418,13 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 &mcu_r5fss0_core0 {
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 };
 
 &mcu_r5fss0_core1 {
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
 };
 
 &icssg0_mdio {
-- 
2.39.2


