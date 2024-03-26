Return-Path: <linux-kernel+bounces-119729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ED388CC86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75562B2ACA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706613CF8A;
	Tue, 26 Mar 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PWEj2UI0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6E113C692;
	Tue, 26 Mar 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479399; cv=none; b=u/sZKvMEiFWcj0N1c8hBxedcSxnSZYcal+TjN5VNpX323siC5Y3pq9ZVycC8cT1g9+u6EDDcToGRbm3cmeNluURoRd6/q4ubsqfHppZPTjFgeEuqnanP2NeYJk7vrKXpp8uUvuHRNUSfT0KN/MDS/IVpMAO2ZNs+HtplV43fWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479399; c=relaxed/simple;
	bh=7Va/H//knxqA5vZT7GucMpNDFoxPPijCw+FRhX+07Ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNNybER4MBVKVpA5iF6BhBkUCa0feD4YboafXEpHMeJ4q6///mYfnpt1MUbZI1YgDhcbZGRotgykAakm+vlSjNKsCZJJlzeHa+yQTyLPviVopMoG1Id6DUACHBvi3blHEvDzrrAKcBL2u8KoFbAGhfxx3HAtZtD9KVfVzQvmKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PWEj2UI0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QIuTmh067232;
	Tue, 26 Mar 2024 13:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711479389;
	bh=RvTJoAdQJRcsJUHcid3LYBEkWah8FmWhj1yGeJXhd/o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PWEj2UI07MnEvRpTzfT8B4VcL3QHA07JQXtQSnpe4DazWiZ/E5NAkNBsBZJVTTqWt
	 Ul61ZZ5c+BhILWmlO9H+yhTJoHqOknnSMQBcGRqhp6avrum4CA69Lx9q8E3X0tqUWR
	 hrWBCC6g5wihDwUa3slwZNWMNprJPZ53KwVde9z8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QIuTvn028930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 13:56:29 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 13:56:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 13:56:29 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QIuSZ6093125;
	Tue, 26 Mar 2024 13:56:28 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am65: Move SerDes mux nodes under the control node
Date: Tue, 26 Mar 2024 13:56:27 -0500
Message-ID: <20240326185627.29852-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326185627.29852-1-afd@ti.com>
References: <20240326185627.29852-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

These SerDes lane select muxes use bits from the same register as
the SerDes clock select mux. Make the lane select mux a child
of the SerDes control node.

This removes one more requirement on scm-conf being a syscon node
which will later be converted to fix a couple DTS check warnings.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 738c5c4acbcd2..5ce67e6a33600 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -66,7 +66,7 @@ serdes0: serdes@900000 {
 		assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
 		ti,serdes-clk = <&serdes0_clk>;
 		#clock-cells = <1>;
-		mux-controls = <&serdes_mux 0>;
+		mux-controls = <&serdes0_mux 0>;
 	};
 
 	serdes1: serdes@910000 {
@@ -81,7 +81,7 @@ serdes1: serdes@910000 {
 		assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
 		ti,serdes-clk = <&serdes1_clk>;
 		#clock-cells = <1>;
-		mux-controls = <&serdes_mux 1>;
+		mux-controls = <&serdes1_mux 0>;
 	};
 
 	main_uart0: serial@2800000 {
@@ -485,18 +485,23 @@ scm_conf: scm-conf@100000 {
 		serdes0_clk: clock@4080 {
 			compatible = "ti,am654-serdes-ctrl", "syscon";
 			reg = <0x4080 0x4>;
+
+			serdes0_mux: mux-controller {
+				compatible = "mmio-mux";
+				#mux-control-cells = <1>;
+				mux-reg-masks = <0x0 0x3>; /* lane select */
+			};
 		};
 
 		serdes1_clk: clock@4090 {
 			compatible = "ti,am654-serdes-ctrl", "syscon";
 			reg = <0x4090 0x4>;
-		};
 
-		serdes_mux: mux-controller {
-			compatible = "mmio-mux";
-			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
-					<0x4090 0x3>; /* SERDES1 lane select */
+			serdes1_mux: mux-controller {
+				compatible = "mmio-mux";
+				#mux-control-cells = <1>;
+				mux-reg-masks = <0x0 0x3>; /* lane select */
+			};
 		};
 
 		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
-- 
2.39.2


