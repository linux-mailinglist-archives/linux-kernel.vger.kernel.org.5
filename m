Return-Path: <linux-kernel+bounces-164790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898068B82E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0E22854D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8B18412D;
	Tue, 30 Apr 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WkjpQ+ul"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085C181305;
	Tue, 30 Apr 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518445; cv=none; b=CBQen3iiDVsfQIadc8k5fBA4Druo6CKfJSOX9kDXeOXQg27FIoB9m8m6++Q9PsYHZqG1FGsjXrAFjhJ1LiZs41UAXhUls/9FMb+skV5dS2QHnfZZ5ra6X69FoqtWgbbCsBVP/GVMLu7jS2e+8u4V/3Lu308RdRFuoRXv9r4AaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518445; c=relaxed/simple;
	bh=n5mrFpEOG6+388ecZ+jUamregsPoeRxyhtNFnQWUUx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNwfIsKMoe2/3pfBHaUbBfZUys7H5lBdcIbveuJ+K3J98bUj3s+ZV8DRTA7Q8fOWcyFRlSrmZlhVdaaoXuNQxq9hRa3RBXMwOl9fLyRWZOTyu7oTmVore2OS2lFf9kGx9DIyVcxp8LylR6lLAnJl9aRwfrZHnYyPeIOpq1fcQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WkjpQ+ul; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1EB38C0000E4;
	Tue, 30 Apr 2024 16:07:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1EB38C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714518437;
	bh=n5mrFpEOG6+388ecZ+jUamregsPoeRxyhtNFnQWUUx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkjpQ+ul0UIMwiMN8yGEizy9acg0TfAxXpDaIGi0e5TOGXCiFodAq2c/Ksf54dCGy
	 7zJdOFvuB5eP3WbgsxK6qVLRAbkGanqvs4VAO3f4wrhbAcc1mNe5A0VhRxMerd1YDG
	 jtWijPqBkQDLyOQzLHpSP2epzX0DCDIQQACWEQkY=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 3C0F018041CAC6;
	Tue, 30 Apr 2024 16:07:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Relocate PCIe nodes to top-level
Date: Tue, 30 Apr 2024 16:07:13 -0700
Message-Id: <20240430230714.3923578-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430230714.3923578-1-florian.fainelli@broadcom.com>
References: <20240430230714.3923578-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to have the PCIe node(s) gain a "ranges" property which is
meaningful, move them out of the axi@18000000 bus node towards the
top-level.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi | 79 +++++++++++++-------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
index d0d5f7e52a91..8f69da8d18c2 100644
--- a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
@@ -121,28 +121,28 @@ axi@18000000 {
 			<0x00007000 12 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
 
 			/* PCIe Controller 0 */
-			<0x00012000 0 &gic GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00012000 1 &gic GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00012000 2 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00012000 3 &gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00012000 4 &gic GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00012000 5 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 0 &gic GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 1 &gic GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 2 &gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 3 &gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 4 &gic GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18012000 5 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 
 			/* PCIe Controller 1 */
-			<0x00013000 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00013000 1 &gic GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00013000 2 &gic GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00013000 3 &gic GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00013000 4 &gic GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00013000 5 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 1 &gic GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 2 &gic GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 3 &gic GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 4 &gic GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18013000 5 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
 
 			/* PCIe Controller 2 */
-			<0x00014000 0 &gic GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00014000 1 &gic GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00014000 2 &gic GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00014000 3 &gic GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00014000 4 &gic GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-			<0x00014000 5 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 0 &gic GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 1 &gic GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 2 &gic GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 3 &gic GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 4 &gic GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			<0x18014000 5 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
 
 			/* USB 2.0 Controller */
 			<0x00021000 0 &gic GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
@@ -181,27 +181,6 @@ chipcommon: chipcommon@0 {
 			#interrupt-cells = <2>;
 		};
 
-		pcie0: pcie@12000 {
-			reg = <0x00012000 0x1000>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-		};
-
-		pcie1: pcie@13000 {
-			reg = <0x00013000 0x1000>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-		};
-
-		pcie2: pcie@14000 {
-			reg = <0x00014000 0x1000>;
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-		};
-
 		usb2: usb2@21000 {
 			reg = <0x00021000 0x1000>;
 
@@ -494,6 +473,28 @@ usb3_dmp: syscon@18105000 {
 		reg = <0x18105000 0x1000>;
 	};
 
+	pcie0: pcie@18012000 {
+		reg = <0x18012000 0x1000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pcie1: pcie@18013000 {
+		reg = <0x18013000 0x1000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pcie2: pcie@18014000 {
+		reg = <0x18014000 0x1000>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+
 	thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <0>;
-- 
2.34.1


