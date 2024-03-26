Return-Path: <linux-kernel+bounces-119965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEAB88CF81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3EF1C6763D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C613D532;
	Tue, 26 Mar 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sfJKbZpK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507812B143;
	Tue, 26 Mar 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486770; cv=none; b=NhVmRXDXPFf/Lkgy1X3MAQ13UmuxxB8hwc96eNiwVnGYh5e3mX93eDotDBQHTCwwpy+pjbEn2BTGuUvpPKOlivZkwzOzSQ8t84g3JM1/5V69/dyaB1Lnik4kLLSsFeug/FP3Y6Ff19nX0+krPvsFdtaAM49Ma5r1OWHZbBzGAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486770; c=relaxed/simple;
	bh=SltorJNZxAnw9p9ns+rgGKLV5fgCGYDhYyBpLxzzHqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7Yy0FnJ0uM4KeCz1ErxaRP/knST+Yess+RC+r0zKybF6OP4xAGBGOZNy1cuzeQWcvbECuaG4eOFHSbdFmvrOpcbE6Qc/Ue4f6SgSl3TYrkSfvZwSy3r099rUhJlA8EBr8EXCroc3Liisx8dK7WHxpUfSJ2sroZMmAFm6cEMS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sfJKbZpK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxNPD096183;
	Tue, 26 Mar 2024 15:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711486763;
	bh=i/rsTRUXDp9owtORKAcISXknrBW6lV/I1h0x/1FUjcI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sfJKbZpKP4pCWebIYO1IPkv0GZvb8jsOe2AAbOSp9I651qoxfxYd+4kqdttfheJmI
	 u5Fm8w94Lqq9JU2aBLClgEKOLrKEjInsdUQyc4tP/bbZBKMk29GmZn2/NvUbEljYaj
	 HJKC9gjRQgcmF7+H2R1AYd7hyOsMf5GRDx7qgpUI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKxMst004062
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:59:22 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:59:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:59:22 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxLBJ082903;
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
Subject: [PATCH 2/4] arm64: dts: ti: k3-j7200: Use exact ranges for FSS node
Date: Tue, 26 Mar 2024 15:59:18 -0500
Message-ID: <20240326205920.40147-2-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 7cf21c99956e0..4fe39764ded40 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -520,10 +520,12 @@ mcu_spi2: spi@40320000 {
 
 	fss: bus@47000000 {
 		compatible = "simple-bus";
-		reg = <0x00 0x47000000 0x00 0x100>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
+			 <0x0 0x47034000 0x0 0x47040000 0x0 0x100>, /* HBMC Control */
+			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
+			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>; /* HBMC/OSPI0 Memory */
 
 		hbmc_mux: mux-controller@47000004 {
 			compatible = "reg-mux";
-- 
2.39.2


