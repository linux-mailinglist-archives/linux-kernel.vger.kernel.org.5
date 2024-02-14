Return-Path: <linux-kernel+bounces-65224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F358549B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182451F235AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B35E54BEF;
	Wed, 14 Feb 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CwertjnW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE705466D;
	Wed, 14 Feb 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915142; cv=none; b=NJyiaZ1/QMhj6lliXsTjKwYPJjjXoScs3JezLNuuuZrM9aG5MPlMRvQxcMG1M5hQ/GbfaywN5IwHkiE0MjmtgNvA2/Pv80SMEQO3UD5nShxwxNoHGV6jV0EVBoBxRd4JVVlL1qUUIuicYyw/6uiiThjGb1cl6lW5juPGItn1p4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915142; c=relaxed/simple;
	bh=sJkoOqDE1OojDBngEzOhOKC5OyFtGpe8Wxft0K0Mrbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbEMl7e829YbJ3yxtIxe012pcKBmaI5GA/dA4WCaxlw1emHEIe1NNPNvzUjeOUgakVzz1vP19x7MR6jbaYshZcuFGndd/k+BB805kYZZ+dtcGOcOjHTG4KNq53o822ooxlLpSUwAwYt7Yilx5kHI46k+6UVLf7V1cyo2XfC/u3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CwertjnW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41ECptst008400;
	Wed, 14 Feb 2024 06:51:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707915116;
	bh=kuoeBUR4o4+sd1G1Nxv5Un7Uktabr5/pM9BWB3fx2HY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=CwertjnW7LcohMDThCNa/jRApyrXKYeO5YOGIvmNxLFDfPVeZRhmc7D2mWe7Et5Sw
	 c3X7MaXVfTF37+3FJC7LzJXKnsFDgavmNFZvaWv52LQQzzgbfSXKQbEjDY4NmeB8qS
	 x2gFSOfksnTRuJRKrdbosxRCSmLrzFxQJReyMBrA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41ECpthd100144
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 06:51:55 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 06:51:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 06:51:55 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41ECpsTq092363;
	Wed, 14 Feb 2024 06:51:55 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: Add common1 register space for AM62x, AM62A & AM65x SoCs
Date: Wed, 14 Feb 2024 18:21:51 +0530
Message-ID: <20240214125151.1965137-3-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214125151.1965137-1-devarsht@ti.com>
References: <20240214125151.1965137-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This adds common1 register space for AM62x, AM62A and AM65x SoC's which are
using TI's Keystone display hardware and supporting it as described in
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Add common1 region for AM62A SoC too
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 5 +++--
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 5 +++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index fe0cc4a9a501..8cee4d94cdd3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -779,9 +779,10 @@ dss: dss@30200000 {
 		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
 		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
 		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
-		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			    "ovr1", "ovr2", "vp1", "vp2";
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
 		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 186 6>,
 			 <&dss_vp1_clk>,
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 972971159a62..f475daea548e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -994,9 +994,10 @@ dss: dss@30200000 {
 		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
 		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
 		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Tied OFF in the SoC */
-		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			    "ovr1", "ovr2", "vp1", "vp2";
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
 		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 186 6>,
 			 <&k3_clks 186 0>,
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 07010d31350e..ff857117d719 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -991,9 +991,10 @@ dss: dss@4a00000 {
 		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
 		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
 		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
-		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
+		      <0x0 0x04a0b000 0x0 0x1000>, /* vp2 */
+		      <0x0 0x04a01000 0x0 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			"ovr1", "ovr2", "vp1", "vp2";
+			"ovr1", "ovr2", "vp1", "vp2", "common1";
 
 		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
 
-- 
2.34.1


