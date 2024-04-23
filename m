Return-Path: <linux-kernel+bounces-154839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4F8AE1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8A7280F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40860B95;
	Tue, 23 Apr 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kkd7DBgy"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795A5FDB3;
	Tue, 23 Apr 2024 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866793; cv=none; b=CRJBKrqtTYw1C3XaKWg5imJoJs3YmeAjmJBDapVtbd7wFKh444N7xyot+yeaO75O+9d8oUwWya7X0kxDMnVnREeKh/BqPoyxc7zv0YO04STLuOcFeOjvJSs2t++El40BNL+hJNIoFA6ioGPeGG/v5CViZ1S2+ARUbLKjOKmw+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866793; c=relaxed/simple;
	bh=yrr4gsn171SjhlcmAbOeqEzq/BCZDNfEl5okhkv1n0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DmtOcYfRGxCL3C2FFhoR4kmpG05vOSSOSloIqNKZgRw2FgiyBKY4/of6OQ5Qe+OQ5Gc+LgH7FbVzvlcySPxvFflHEc7vJdgEPp2K9o/gNC5qkAycjTbNC1VTwM1FT/SntmIh4eTUY6BXDgnjbzbrsPWho0VvdWcUg1h4iplgGDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kkd7DBgy; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NA6AcQ126963;
	Tue, 23 Apr 2024 05:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713866770;
	bh=uVTPeL69Wr7PxFyW13waEJ2yfkc25M5addJiWs5CC9M=;
	h=From:To:CC:Subject:Date;
	b=Kkd7DBgyAEVjKQrBjvbz4z/55VTDzRqUnfH/kMiCBTg1MvutKcD4r6FBbBELvO5y9
	 9fMRFcxy30r9st5pPnKqkvm0CV84aD0t7BSxo4bGoBPpWexX/Kscb75zFMC+Id5ZL3
	 suPA9I4Wj1UJooEqSiknt2MInEOmPMu0Fzmx+oYY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NA6Aax013513
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 05:06:10 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 05:06:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 05:06:10 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NA6AYQ099678;
	Tue, 23 Apr 2024 05:06:10 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43NA69PD017417;
	Tue, 23 Apr 2024 05:06:09 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
Date: Tue, 23 Apr 2024 15:36:08 +0530
Message-ID: <20240423100608.1421652-1-danishanwar@ti.com>
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

PRU system events "vring" have been added to each PRU and RTU node
in each of the ICSSG0 and ICSSG1 remote processor subsystems to
enable the virtio/rpmsg communication between MPU and that PRU/RTU core.
No events have been added to the Tx_PRU cores at present. The
additions are done in the base k3-am64main.dtsi, and so are inherited
by all the K3 AM64x boards.

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
 
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 6f9aa5e02138..f8370dd03350 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1283,6 +1283,9 @@ pru0_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_0: rtu@4000 {
@@ -1292,6 +1295,9 @@ rtu0_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu0_0-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_0: txpru@a000 {
@@ -1310,6 +1316,9 @@ pru0_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu0_1: rtu@6000 {
@@ -1319,6 +1328,9 @@ rtu0_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu0_1-fw";
+			interrupt-parent = <&icssg0_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru0_1: txpru@c000 {
@@ -1436,6 +1448,9 @@ pru1_0: pru@34000 {
 			      <0x22400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <16 2 2>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_0: rtu@4000 {
@@ -1445,6 +1460,9 @@ rtu1_0: rtu@4000 {
 			      <0x23400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu1_0-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <20 4 4>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_0: txpru@a000 {
@@ -1463,6 +1481,9 @@ pru1_1: pru@38000 {
 			      <0x24400 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-pru1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <18 3 3>;
+			interrupt-names = "vring";
 		};
 
 		rtu1_1: rtu@6000 {
@@ -1472,6 +1493,9 @@ rtu1_1: rtu@6000 {
 			      <0x23c00 0x100>;
 			reg-names = "iram", "control", "debug";
 			firmware-name = "am64x-rtu1_1-fw";
+			interrupt-parent = <&icssg1_intc>;
+			interrupts = <22 5 5>;
+			interrupt-names = "vring";
 		};
 
 		tx_pru1_1: txpru@c000 {
-- 
2.34.1


