Return-Path: <linux-kernel+bounces-37542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7138183B171
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CB928A25F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8699133993;
	Wed, 24 Jan 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tNj3Leej"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8ED13174C;
	Wed, 24 Jan 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122056; cv=none; b=KPbTF4Y601o2QIcAMcwWwJZNlwXyMjzfVaNuRB5yf6nKlpJYpwMYPueV+vHqcprXwu43I88iKok7kAm6Zyo4MhDIu6wMoqjoDyIQ9E0qgrUjr5sEFlHbmaSK8eBTlAsyockcSGIoVj8vZZ/KJELSR8LhaWW7uNxnFX+NaOClD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122056; c=relaxed/simple;
	bh=hakNAIAU+DrOpTPC3jsYNn2gPlMo6dOzyhMnzdGnhK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pn4ja4tQ2qcavlexCrJ5SCoJrbQYnkC1bl/EW1prEaPdT6280jdnmdUhWoTfRg0OwLECj0knG7rNaqkVAgj5gQMcAbEXsswl7aRH/3xVM7rlv46vDcGGZ2I8xXhSO10tbTPjngHTehh+ZBr+OekuI0TX+u9H0HMlfh4R+IeoA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tNj3Leej; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlQok074462;
	Wed, 24 Jan 2024 12:47:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122046;
	bh=sh+9IxQ6qVTD+dB2JnGEkxN9m9Clipf7e2S1slRAIG4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tNj3Leejf2TQrcVXQycdsjDKYEdtKG0OaquHQ8PHlSLoMkePhbQ8PfbyzQb+ra1mI
	 n8Pc/05NkUIrhd0y18eW0FQq1z1BNUSuRyHijAXyOuT4T3Ng7Naubycpxulamt02UQ
	 kmgaEwoyFMG5rR8PbjsnK+q6cfsHX4TTOSbFjdNI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIlPrJ025287
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:47:25 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:47:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:47:25 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIlNaR119099;
	Wed, 24 Jan 2024 12:47:25 -0600
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
Subject: [PATCH 05/11] arm64: dts: ti: k3-j721e: Convert serdes_ln_ctrl node into reg-mux
Date: Wed, 24 Jan 2024 12:47:16 -0600
Message-ID: <20240124184722.150615-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124184722.150615-1-afd@ti.com>
References: <20240124184722.150615-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This removes a dependency on the parent node being a syscon node.
Convert from mmio-mux to reg-mux adjusting node name and properties
as needed.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 2569b4c08ffb8..c168bfbd303da 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -45,15 +45,15 @@ scm_conf: scm-conf@100000 {
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
 		serdes_ln_ctrl: mux-controller@4080 {
-			compatible = "mmio-mux";
-			reg = <0x00004080 0x50>;
+			compatible = "reg-mux";
+			reg = <0x4080 0x50>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
-					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
-					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
-					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
-					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
-					/* SERDES4 lane0/1/2/3 select */
+			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
+					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
+					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
+					<0x30 0x3>, <0x34 0x3>, /* SERDES3 lane0/1 select */
+					<0x40 0x3>, <0x44 0x3>, /* SERDES4 lane0/1 select */
+					<0x48 0x3>, <0x4c 0x3>; /* SERDES4 lane2/3 select */
 			idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
 				      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
 				      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
-- 
2.39.2


