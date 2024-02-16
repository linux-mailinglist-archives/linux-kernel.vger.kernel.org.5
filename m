Return-Path: <linux-kernel+bounces-68096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C44C8575F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EA21F23642
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486631401F;
	Fri, 16 Feb 2024 06:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DE6cs8R6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243B14A81;
	Fri, 16 Feb 2024 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064693; cv=none; b=J5FiEOrzUN6rb3oFExi/+EUo6lzzjoN9qr4Xw+dUJwD/acbJrUsUp3gOL/5NQlM0LBnQvBZBlD/eFXnSlVRc9ZaL7WE5NiMLPQ/qOnaqmjkQPq5IoIF4m3HZpwz5Pqy+FBC+fnwuj+OCVBO7uSvFwntJCDm6jTWQ0F32pBlFIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064693; c=relaxed/simple;
	bh=58jsamH6fpBXvb3zVcY4VXG6i2XIuZ4ke/SCLFjUqa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PoherUSgZoVXBDeF+TBzbLn+Sd2Dw/IwheSJztoHRSXkIw8wVCLAn38MLIDO4oSUT1LP7BT8EhGrO7X+jski1Vtw+l1gQgyIPOxnOhMIvLBHFSWKo19KzL6r1i2EIu6wpnJhrM8EgLr1wiYclwZfLKbXNejIpzlSAh4UHVLb7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DE6cs8R6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OXTK111902;
	Fri, 16 Feb 2024 00:24:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708064673;
	bh=12nw2Brj6XluV4ZS8ekE7bWjOTcayhqSm+k5+LH/OD4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DE6cs8R6udxGVdqT78h/6UhnYiK3OXJg0upv4Ggl5yiGLdaH63Y13ylf1k0/kBSHE
	 ajXDHsVSNeWRi/5cF/ll5CSd5Gm3uOzl37RU/+ZtvErpr/1/Q95MwwqX16mTPDpd2j
	 1115VONNuvl5lGzeeRu2Q/5Xp9xha4C814TYT3KM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6OXD3076377
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:24:33 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:24:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:24:33 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OWM1097196;
	Fri, 16 Feb 2024 00:24:33 -0600
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
Subject: [PATCH v5 4/4] arm64: dts: ti: Add common1 register space for AM62A SoC
Date: Fri, 16 Feb 2024 11:54:26 +0530
Message-ID: <20240216062426.4170528-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216062426.4170528-1-devarsht@ti.com>
References: <20240216062426.4170528-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This adds common1 register space for AM62A SoC which is using TI's Keystone
display hardware and supporting it as described in
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml

Fixes: 3618811657b3 ("arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V4 :
- No change (this was part of "arm64: dts: ti: Add common1 register
  space for AM62x, AM62A & AM65x SoCs )

V5 :
- Split this as a separate patch from "arm64: dts: ti: Add common1
  register space for AM62x, AM62A & AM65x SoCs"
- Remove Reviewed-By tag as this is split from older revision
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 2749533cf4fd..dbdd6bec4667 100644
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
-- 
2.34.1


