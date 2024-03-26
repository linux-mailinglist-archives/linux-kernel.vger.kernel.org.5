Return-Path: <linux-kernel+bounces-119966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA088CF83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6301C67712
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249F12B143;
	Tue, 26 Mar 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LJ/u1NwY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380D13D60A;
	Tue, 26 Mar 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486773; cv=none; b=FTaHeCaB0Ysfgqf0DB57lO2LbfiwoTH0RICl5aCi/fMgowjsbZ0/Fedk5CoMykXf4bb1CX4NrpWFDD1dJvdLCGa0oSxT91InZ4+NhZ/KzdSdSSNLPclibF1Tk4Hzf0/1kA6QHeY+/NJ7Bofr8zqFaMvpKXZNfSKql8TSc+6P+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486773; c=relaxed/simple;
	bh=rm0diwxtkKQlY7HowpSouWdszBEO0uMALA/k1UG0t9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDe1YWyjv7RaI75J4ca5xXsnxnxWsFi1ByT/WLv3YA6VkCTtad1/FaQlVQVdW4fx2KP0zb4nfdRD2i88S3NroKdEqts9DC5feq8p3VR2o+D7VsOq4tV18IOOIWI72yHNuBfhs0vSEDy/S651wTEDlNMyqj9G68xVkmG96UONM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LJ/u1NwY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxNxd092347;
	Tue, 26 Mar 2024 15:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711486763;
	bh=k9Sjjyp+k2aV6ICJHn6H9MpwV0iUTCWyH+EmCL04Ha8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LJ/u1NwYzEdLRzxKXIlsy8tL4cDjuB2/ZGbbKHiGfHlx5ZK8cXxOYrjN05CJ7P4jB
	 Ag9NNqVWH/Pw4iqPVN19g5Px8NLBJYbZWAZm5avhxMJNG9mNNgsIitt2iZ0z+TiFM6
	 P6h/41tEMCXz4yuh+thBpv/R6FH99B/PZ0Mep6gU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QKxNYH087942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 15:59:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 15:59:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 15:59:23 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QKxLBL082903;
	Tue, 26 Mar 2024 15:59:23 -0500
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
Subject: [PATCH 4/4] arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node
Date: Tue, 26 Mar 2024 15:59:20 -0500
Message-ID: <20240326205920.40147-4-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 77a8d99139ec1..c6d4bf79c1423 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -674,10 +674,13 @@ adc {
 
 	fss: bus@47000000 {
 		compatible = "simple-bus";
-		reg = <0x00 0x47000000 0x00 0x100>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
+		ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x100>, /* FSS Control */
+			 <0x0 0x47040000 0x0 0x47040000 0x0 0x100>, /* OSPI0 Control */
+			 <0x0 0x47050000 0x0 0x47050000 0x0 0x100>, /* OSPI1 Control */
+			 <0x5 0x00000000 0x5 0x00000000 0x1 0x0000000>, /* OSPI0 Memory */
+			 <0x7 0x00000000 0x7 0x00000000 0x1 0x0000000>; /* OSPI1 Memory */
 
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
-- 
2.39.2


