Return-Path: <linux-kernel+bounces-52254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14578495FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40F11C23F80
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512D12B8B;
	Mon,  5 Feb 2024 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iIjV8ofK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE4125AF;
	Mon,  5 Feb 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123963; cv=none; b=SjENR0S6ZAR31fOnGQlreboA9XgHCMFjHB5DR1bJ7zv9A7SVRtYaCk+65Uj2qExtUJmRFumcL+G6wOoZ+JULB5Ugn/8nX+JvQd6jsWZfWNXk51d5wVQN+J5MME8d47wJEGHAy3VI+I6yG+emMw3VUxxXPVy4BLmaNJZ0awLoXPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123963; c=relaxed/simple;
	bh=cLno8nXsijZnWS2UJtaH5N5P2B6t8PmHRwjGLZQJMmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMu4/05lAMXf9FLLXxVQYJcjWGqp16qXJRAG1YZFPaCj3mtFMAjbWBxWs4IaFjjuJpfOJPY3E0qle/jUuhNKuJ4RMBOSMoeBu9FxNvkxQLt80EL2dFkfHrQ11+NA/2zWPlKjfcu+Wze19PHggRXDjwhimPjdClbpxDxb/pU1GPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iIjV8ofK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41595pUQ098580;
	Mon, 5 Feb 2024 03:05:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707123952;
	bh=2cuwx8uQWWFYnfHdRsH5mjSDyuNRfi/7cJl2DykRGQA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iIjV8ofKrIryt3Hq2CRQNuVR/NmVua4KNr8cv7NinklymGqRfbk3ntTiQhN+bhvh2
	 lk/31rxm99iXD5O2vW+saSAJohqLgafmNZEcjF6dXStYUZ4GTIV/ac3SkEcHX5fbpk
	 dM2+cm3jBguKbgmTiqAk4QhcwiGgkCbvPc6fU6T8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41595p4b029240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 03:05:51 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 03:05:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 03:05:51 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41595pZq009492;
	Mon, 5 Feb 2024 03:05:51 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 41595oi0032281;
	Mon, 5 Feb 2024 03:05:51 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Tero
 Kristo" <kristo@kernel.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, "Roger
 Quadros" <rogerq@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v4 1/3] arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
Date: Mon, 5 Feb 2024 14:35:44 +0530
Message-ID: <20240205090546.4000446-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205090546.4000446-1-danishanwar@ti.com>
References: <20240205090546.4000446-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Suman Anna <s-anna@ti.com>

The ICSSG IP on AM64x SoCs have two Industrial Ethernet Peripherals (IEPs)
to manage/generate Industrial Ethernet functions such as time stamping.
Each IEP sub-module is sourced from an internal clock mux that can be
derived from either of the IP instance's ICSSG_IEP_GCLK or from another
internal ICSSG CORE_CLK mux. Add both the IEP nodes for both the ICSSG
instances. The IEP clock is currently configured to be derived
indirectly from the ICSSG_ICLK running at 250 MHz.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e0..9d2dad8ae8df 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1244,6 +1244,18 @@ icssg0_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg0_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
+		icssg0_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg0_iepclk_mux>;
+		};
+
 		icssg0_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
@@ -1385,6 +1397,18 @@ icssg1_iepclk_mux: iepclk-mux@30 {
 			};
 		};
 
+		icssg1_iep0: iep@2e000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2e000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
+		icssg1_iep1: iep@2f000 {
+			compatible = "ti,am654-icss-iep";
+			reg = <0x2f000 0x1000>;
+			clocks = <&icssg1_iepclk_mux>;
+		};
+
 		icssg1_mii_rt: mii-rt@32000 {
 			compatible = "ti,pruss-mii", "syscon";
 			reg = <0x32000 0x100>;
-- 
2.34.1


