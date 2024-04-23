Return-Path: <linux-kernel+bounces-154841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150E8AE1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D91F21A62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42C60B9C;
	Tue, 23 Apr 2024 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Inv1zjM9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3C5FDDC;
	Tue, 23 Apr 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866935; cv=none; b=qxBMGNy6scYgViM3OXo/nj+veywYPjeVSkMXVfFqPMaQcK9B7sZzn5EDuCbmw9OMLFiLM2aTS6afMxO9nbkfR530Q9mYFjRdlY2LL+1wL7GHL44y6YORMiLtPHUQBsFZf7OwEvaLntBCWkXfL5fvVgc1COaFIG0iOYSSgr5DTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866935; c=relaxed/simple;
	bh=LTIkfxbTKo7OgvVgzrIZOdTlAWFguPY+VqJvdS0HN1g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q6AjCECyZBj26FaBXdv8CtvXUlyJo4Fc9mTM1fjFETzhysssLElPunEh3lpEx7CW0Ej44d8jpfa+7s4kCwv/3N96HPVLQjCeJw/VCYBn4ESewplfywbuLUMQEoEVxkUoaa4CrS08wtgfjbdrrxN0bUo1hr1VyAdwAeVrXg3vCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Inv1zjM9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NA8fqD120870;
	Tue, 23 Apr 2024 05:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713866921;
	bh=3JXmrBeiXZGoZKDdFn4LlZ7IlW8HBZiV1xctWrrEyBg=;
	h=From:To:CC:Subject:Date;
	b=Inv1zjM9gXijhbZdpoEgAWSk+1oFDVVPeNJ2IvyjUL5Uhk85s46yhuYySl4jcLbNY
	 3cnmujvaC8ExvEXWqCCAd1rziAbFIScFhYB8YA6oyIebEFEMUhQQDwo/XvfoLEQInb
	 PUHTylPLzFLMMG/eJ+MusE2cKmZOMnQBR5XhJ2ik=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NA8fSv031271
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 05:08:41 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 05:08:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 05:08:41 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NA8fQ5104100;
	Tue, 23 Apr 2024 05:08:41 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43NA8dGr017727;
	Tue, 23 Apr 2024 05:08:40 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am65-main: Add PRU system events for virtio
Date: Tue, 23 Apr 2024 15:38:38 +0530
Message-ID: <20240423100838.1421845-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

A PRU system event "vring" has been added to each PRU and RTU
node in each of the ICSSG0, ICSSG1 and ICSSG2 remote processor
subsystems to enable the virtio/rpmsg communication between MPU
and that PRU/RTU core. The additions are done in the base
k3-am65-main.dtsi, and so are inherited by all the K3 AM65x
boards.

The PRU system events is the preferred approach over using TI
mailboxes, as it eliminates an external peripheral access from
the PRU/RTU-side, and keeps the interrupt generation internal to
the ICSSG. The difference from MPU would be minimal in using one
versus the other.

Mailboxes can still be used if desired, but currently there is
no support on firmware-side for K3 SoCs to use mailboxes. Either
approach would require that an appropriate firmware image is
loaded/booted on the PRU.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
This patch is based on linux-next tag next-20240423

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 0d68aa8e946f..72aa3b9aacce 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1059,6 +1059,9 @@ pru0_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_0: rtu@4000 {
@@ -1068,6 +1071,9 @@ rtu0_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_0: txpru@a000 {
@@ -1086,6 +1092,9 @@ pru0_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_1: rtu@6000 {
@@ -1095,6 +1104,9 @@ rtu0_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_1: txpru@c000 {
@@ -1213,6 +1225,9 @@ pru1_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_0: rtu@4000 {
@@ -1222,6 +1237,9 @@ rtu1_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_0: txpru@a000 {
@@ -1240,6 +1258,9 @@ pru1_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_1: rtu@6000 {
@@ -1249,6 +1270,9 @@ rtu1_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_1: txpru@c000 {
@@ -1367,6 +1391,9 @@ pru2_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_0: rtu@4000 {
@@ -1376,6 +1403,9 @@ rtu2_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_0-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_0: txpru@a000 {
@@ -1394,6 +1424,9 @@ pru2_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-pru2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu2_1: rtu@6000 {
@@ -1403,6 +1436,9 @@ rtu2_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am65x-rtu2_1-fw";
+			interrupt-parent = <&icssg2_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru2_1: txpru@c000 {
-- 
2.34.1


