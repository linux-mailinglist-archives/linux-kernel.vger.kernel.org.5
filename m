Return-Path: <linux-kernel+bounces-164791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B538B82E6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAB3B23345
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F751C0DEA;
	Tue, 30 Apr 2024 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aNaDSg5R"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A91129E72;
	Tue, 30 Apr 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518446; cv=none; b=XRGjC46DWGowErjPeqaIHxP6trawEIXaFWGkw1qywlJlCDVvP15IlyVB80pgmgv4AdtQQLCqyAhogLHbsNa8P8RLvOqGOslzQrKmv89f9sg80EI1OfDNDaafZXTWfbfsxW+PCTpVa3suzvOAO6EkyrMjAGDREyJx4pIpbhX59EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518446; c=relaxed/simple;
	bh=4Fp3Qi48gxR++eU3dRna/L7sh73jrL5Mucb8Si43TsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+7gci46s/n/wrVK43MIDTmPu+nGwrPhSY0EXYBhplhwUFFIsX9Grr5bzpAo4iw9n23CBWFAR2HhfOh8SK/l+8VXlFQBSvK6chuWKeZVtk74e2z4teHYbAEds6G5KccMf6VAbWvfrxZ/CkUMtqhRuCqVEauscKs+2xz7A2diryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aNaDSg5R; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3F0D2C0000E8;
	Tue, 30 Apr 2024 16:07:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3F0D2C0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1714518437;
	bh=4Fp3Qi48gxR++eU3dRna/L7sh73jrL5Mucb8Si43TsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNaDSg5RHdblYgSBb7us6jjlyD/NNQyiUjsQikhJ2I47vv4PkLpLmZYsd+FqmFWn4
	 lCMWGOkjwVVGL3z9IGvInxQCkWYooCZLiX0KaBjrMtm/OpsHEUVCJ7GHxy0eDvQmxl
	 EWa7ehRRBqRam2t/WiZrI9oYPG3w7JwciHguDIME=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5C83F18041CAC7;
	Tue, 30 Apr 2024 16:07:15 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ARM: dts: BCM5301X: Describe PCIe controllers fully
Date: Tue, 30 Apr 2024 16:07:14 -0700
Message-Id: <20240430230714.3923578-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430230714.3923578-1-florian.fainelli@broadcom.com>
References: <20240430230714.3923578-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This fixes:
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18012000:
'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18012000:
'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18013000:
'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18013000:
'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18014000:
'device_type' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#
arch/arm/boot/dts/broadcom/bcm4708-asus-rt-ac56u.dtb: pcie@18014000:
'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/pci/pci-bus.yaml#

Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
[florian: Make it apply to the relocated PCIe node(s)]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
index 8f69da8d18c2..b6fc4e4bba8d 100644
--- a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
@@ -474,22 +474,40 @@ usb3_dmp: syscon@18105000 {
 	};
 
 	pcie0: pcie@18012000 {
+		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
-
+		ranges = <0x82000000 0 0x08000000 0x08000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		#interrupt-cells = <1>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 	};
 
 	pcie1: pcie@18013000 {
+		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
-
+		ranges = <0x82000000 0 0x20000000 0x20000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		#interrupt-cells = <1>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 	};
 
 	pcie2: pcie@18014000 {
+		compatible = "brcm,iproc-pcie";
 		reg = <0x18014000 0x1000>;
-
+		ranges = <0x82000000 0 0x28000000 0x28000000 0 0x08000000>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		#interrupt-cells = <1>;
 		#address-cells = <3>;
 		#size-cells = <2>;
 	};
-- 
2.34.1


