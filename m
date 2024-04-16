Return-Path: <linux-kernel+bounces-146563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCDB8A6747
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06F21C2166B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3988627E;
	Tue, 16 Apr 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Py+J3tBt"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081498595C;
	Tue, 16 Apr 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260236; cv=none; b=OtjE3W0WG1H12hR76XkzCqngmqPb4l9Kf16yS3Q9jAfTRenQGl5rsGZA/wP3We/MaAEBfdYXuP5cA54s/DOcgdki5M6yQ4qP375njyftOWbA+sw/TUQeQghbTVFos3TFzJ/wSOdjzP6Hg/Z/GfNB2OXd/V8hdHclUEpfj+zRqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260236; c=relaxed/simple;
	bh=f9XkjnH89zXY3LmS3xR4VLcpu9vmNtgVXPAVkmkaQAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ll2UIf7CCqcSt7SVf4GAAqkYZ/l1gB9RLPKVTJDE3Arl+dlb4nMVRQ4L4dEFRF+5f6vBYCInFvw8whPDVRiR2YZtDRgT6wUdUGOio2nQM3VNE+esR46iI6lm1VUoAmgCGBGurRPlU4DWR7dYz/XIx3GJf37X0ObW3WS3NeLKm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Py+J3tBt; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G9axuD067677;
	Tue, 16 Apr 2024 04:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713260219;
	bh=3+4yCUe856YSCywDQIBGfdnlq8U1G2XXbSOviL1uR8U=;
	h=From:To:CC:Subject:Date;
	b=Py+J3tBtJAqOYyIAh11cfHG6ijuWg9u8Os+tG5P/Kw8VmK7J0PMXPlSC56fApD7Ga
	 iaG1OEwo4IsEgmXZKJEM/dYHY+zezFYXx2e5Er88Aqh4l8WN2BjtKacdASWyNlxKwo
	 2leJYNktqsmVrwvCJfKKj5chlkxUWD/vy4rtM/Lw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G9axH9117964
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 04:36:59 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 04:36:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 04:36:59 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G9atpJ057522;
	Tue, 16 Apr 2024 04:36:56 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <francesco@dolcini.it>
CC: <kristo@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Udit Kumar <u-kumar1@ti.com>
Subject: [RFC PATCH] arm64: dts: ti: k3-j721s2: Add reserved status in msmc node
Date: Tue, 16 Apr 2024 15:06:48 +0530
Message-ID: <20240416093648.3620423-1-u-kumar1@ti.com>
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

TI K3 SOCs have msmc sram, part of it can be configured as L3 cache
depending upon system firmware configuration file.

MSMC memory typically host four tenants atf, system firmware (tifs),
l3 cache and as sram.

Allocation done for atf, tifs and l3-cache is not accessible in address
space of OS.
Therefore u-boot deletes sysfw and l3cache node before passing DT to OS[0].
But keeping tifs (system firmware) subnode as is.

Since TIFS node is not also accessible to OS, I need suggestion for
selection of right option.

In my view we can handle in two ways

1) delete tifs node as well
In this case, only accessible sram will be visible to OS[1]

2) make these nodes (tifs, atf and l3cache) as reserved,
so that OS has complete view of memory.

This is patch for option 2 to mark atf, l3-cache and tifs as
reserved.

Also other options are welcome.

[0]: https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-k3/common_fdt.c#L67
[1]: https://lore.kernel.org/all/20230420081128.3617214-1-u-kumar1@ti.com/

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 3cb06a7e4117..f64c8b0780d8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -25,14 +25,17 @@ msmc_ram: sram@70000000 {
 		ranges = <0x0 0x0 0x70000000 0x400000>;
 
 		atf-sram@0 {
+			status = "reserved";
 			reg = <0x0 0x20000>;
 		};
 
 		tifs-sram@1f0000 {
+			status = "reserved";
 			reg = <0x1f0000 0x10000>;
 		};
 
 		l3cache-sram@200000 {
+			status = "reserved";
 			reg = <0x200000 0x200000>;
 		};
 	};
-- 
2.34.1


