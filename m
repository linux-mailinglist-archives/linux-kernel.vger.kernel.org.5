Return-Path: <linux-kernel+bounces-145890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E328A5C66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D771C214C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47AB156969;
	Mon, 15 Apr 2024 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hJNbcQwY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A311DFEB;
	Mon, 15 Apr 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214052; cv=none; b=Eq+KT/4Wwq39VPLjbH/bBQWjGdNhELCt9qNj8pzcIqZpll5W4SxM6s7GJ5d1fbJ/ouluLnee26oWzSPTDRbIW8XZGTo10ti/xT8JCFH7MCrDPMW3S0zaRky/LuTSMm6LE/qUNWaGThp5umrQXoNw2kgdEpDFjVKojepz6WmtXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214052; c=relaxed/simple;
	bh=CAQtI64uH/sbIVduOXIKnP5onNr/BcGBYu7l+TM3aEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3HeOLUTGvyYuh6POL3dBKbE1OqxlfUPW8ULqcFTNTuZOYP4B0Xxm89hMr+9DdNmmI3IaFRpYejBDMhbVZG03nvSlTgycVSwVUnxa6XkVIecGBK3XTl+tnHR6VeVX8EqxQ44+qPmcO7aCGFNT2Ppt+VDpiqL19yTTR6UFc6dLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hJNbcQwY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FKlFpJ046204;
	Mon, 15 Apr 2024 15:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713214035;
	bh=Qj8zTV4HH1XlReKQ2AMA1jIdAru9TMvcpQIgyp/xxwY=;
	h=From:To:CC:Subject:Date;
	b=hJNbcQwY71tOY86yq2HmB1H7rrLB8FqRgxqKvvW5gp5GUgPcHT903aLmCDExKC+VG
	 IOxwCMANRJAZhhlcsbHb3oq4lju/mF25ZWaJ87nDe+uYrLtixAW8Kk7m0Mu1smMKPu
	 sKyYIPqzVeygRCGh94udb8XxzvjqLH/Oku6t/+FU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FKlFjK109575
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 15:47:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 15:47:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 15:47:15 -0500
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FKlEC4130724;
	Mon, 15 Apr 2024 15:47:14 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Devarsh Thakkar <devarsht@ti.com>, Darren Etheridge <detheridge@ti.com>,
        Vijay Pothukuchi <vijayp@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        Brandon
 Brnich <b-brnich@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62a-main: Add Wave5 Video Encoder/Decoder Node
Date: Mon, 15 Apr 2024 15:46:59 -0500
Message-ID: <20240415204659.798548-1-b-brnich@ti.com>
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

This patch adds support for the Wave521cl on the AM62A-SK.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---

With HR timer polling[0] now in -next[1], lets add support on am62a to
probe wave521c.

[0]: https://patchwork.linuxtv.org/project/linux-media/patch/20240310104827.665456-1-devarsht@ti.com/
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/media/platform/chips-media/wave5?id=ed7276ed2fd02208bfca9f222ef1e7b2743d710d

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index aa1e057082f0..73dbdcce68ff 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -1051,4 +1051,11 @@ dss_ports: ports {
 			#size-cells = <0>;
 		};
 	};
+
+	vpu: video-codec@30210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x30210000 0x00 0x10000>;
+		clocks = <&k3_clks 204 2>;
+		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.34.1


