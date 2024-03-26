Return-Path: <linux-kernel+bounces-119967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B5288CF84
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804511F66FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2313D8AA;
	Tue, 26 Mar 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FNGCuJoi"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D313D62C;
	Tue, 26 Mar 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486773; cv=none; b=UrrTxNolvyZNCVXH634MXPFmq0yy8Y9QPYdgEfbkMhMZuOnyFtqFUOSc+ZAxuvDOvddnlaRywrEQK+LsSA3KDH0bNOSDP+IjQix3teB/4+ibV8wwdCLubGYSyfDNxZ2H1/UZR1CrdH+a/rKZG4NumOd3VeZNfmnKldzd8OMQCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486773; c=relaxed/simple;
	bh=q4GCDKY5N+OW2uvf5wr76NPuRj1gRjbgdNuGjh3zY40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOLgsWrKuMiBRIA1WUN7aY9M995Mpy+Bgehx9KI9ObgQZRHvyRYkJGqyCtziebg+vAtZ/lTAYnxMJCvsMPqAfh3EctYo2fLb+68/k4YLAXItG5xi7KV4/fJ0LZKl/X4jG6T1d9A+VGFMzNx+f3/D6kVchq9rxdvSUSzsEpUv9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FNGCuJoi; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxNxD096407;
	Tue, 26 Mar 2024 15:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711486763;
	bh=gYEUWhMliu0+MuuBW1hFgPK8ldjbwaH6UZceXte5Nho=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FNGCuJoi8bgi7I5zTu5htKqenBtbOJpjuojswT6tDJyp0RUjxxyah4lS6SSx4DrbD
	 /DXQoFTOLl+LrwhuIyiQG81+ibvnDlbl9b2JJwMsVI0pILmJgaULiF5czrm/eCQl7D
	 yweJg0kl3HShG8Y4CtxwnLH72ixXSrnpEBStYxSc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKxNoX087933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:59:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:59:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:59:23 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxLBK082903;
	Tue, 26 Mar 2024 15:59:22 -0500
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
Subject: [PATCH 3/4] arm64: dts: ti: k3-j721e: Use exact ranges for FSS node
Date: Tue, 26 Mar 2024 15:59:19 -0500
Message-ID: <20240326205920.40147-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326205920.40147-1-afd@ti.com>
References: <20240326205920.40147-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The FSS bus contains several register ranges. Using an empty
ranges property works but causes a DT warning when we give
this node an address. Fix this by explicitly defining the
memory ranges in use.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 4618b697fbc47..b33a1ca2236ff 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -346,10 +346,14 @@ wkup_i2c0: i2c@42120000 {
 
 	fss: bus@47000000 {
 		compatible = "simple-bus";
-		reg = <0x0 0x47000000 0x0 0x100>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
+			 <0x0 0x47034000 0x0 0x47034000 0x0 0x100>, /* HBMC Control */
+			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
+			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
+			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* HBMC/OSPI0 Memory */
+			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
-- 
2.39.2


