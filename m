Return-Path: <linux-kernel+bounces-131458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A44898841
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2377B2DF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CD8061C;
	Thu,  4 Apr 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="INwBympi"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3E7492;
	Thu,  4 Apr 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234790; cv=none; b=Nu5MMDqMsH0WQcOj3I3+OhsytcquqgwtHH8pHUolX3WmSqa0Tk0EbPe5Zy5i5+xQUAey1gkRTcpXBFHxJ8wgWwMFj3fCQqR/kxerUkplb+gWPcgC4lowrWNb+PCWyCQ9j5kyR//Pq7R47unptad1B3p2EFYjSlfCyGOou6nLDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234790; c=relaxed/simple;
	bh=vSfmQlOnTjFhj0V1lM1jgKnxEb4/A8CPTuffchOy/y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Re0/+TT5DkdRPqQio5Wnpz8wMokz7VhXSSdqLHASKtAMuytTynXercI+0GA/DT42f9Z9qEwZxl6yQ1TIyJU0rNJP3UAlCeCSZfvwuFaY3UMWGdw1XeLtVZnw2kHdlIl7w198GMkl/tqLKZlaGvqUUmrD3yt/6XocOWehb7QPf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=INwBympi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434CkJtG031225;
	Thu, 4 Apr 2024 07:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712234779;
	bh=qJg1mXxEBeSMHwRCIuB9hLceXhAMTVZyXHOqCCpB/kQ=;
	h=From:To:CC:Subject:Date;
	b=INwBympiz9+H+p/rPLx76IjQMfYsO/3ee8Tdgq2rZ6cihVSpKNxClCFjo6vQzHf0Z
	 ZirSByzB+OKq7vqWy4DehAgkZj04M4v5iPTNbighs48m53yaeQRf0oXjA17XWe7xH3
	 15brUwoJlVCBZf85ecWPkejaFTWte8UCQGk2lcTQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434CkJwv119773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 07:46:19 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 07:46:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 07:46:18 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434CkFK0077955;
	Thu, 4 Apr 2024 07:46:16 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3] arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
Date: Thu, 4 Apr 2024 18:16:14 +0530
Message-ID: <20240404124614.891416-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add the "ethernet-mac-syscon" node within "wkup_conf" node corresponding to
the CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the
compatible "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations
on these registers. The MAC Address programmed in the eFuse is accessible
through the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree
property points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver
to fetch the MAC Address and assign it to the network interface associated
with CPSW3G MAC Port 1.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on linux-next tagged next-20240404.
Patch depends on:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
for the newly added "ti,am62p-cpsw-mac-efuse" compatible.

v2:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240404081845.622707-1-s-vadapalli@ti.com/
Changes since v2:
- Renamed "cpsw-mac-efuse" node as "ethernet-mac-syscon" based on
  Krzysztof's suggestion.
- Renamed "cpsw_mac_efuse" label as "cpsw_mac_syscon" to match
  node naming convention.
- Updated node-name in commit message to "ethernet-mac-syscon".

v1:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402094200.4036076-1-s-vadapalli@ti.com/
Changes since v1:
- Since "wkup_conf" is modelled as a "simple-bus" rather than being
  modelled as a System Controller node with the "syscon" compatible,
  directly passing the reference to the "wkup_conf" node using the
  "ti,syscon-efuse" device-tree property will not work.
  Therefore, I posted the patch at:
  https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
  in order to add a new compatible to be used for modelling the
  CTRLMMR_MAC_IDx registers as System Controller nodes, thereby
  allowing the existing "ti,syscon-efuse" property to be used.
  Now, "ti,syscon-efuse" points to the "cpsw_mac_efuse" node within
  "wkup_conf" node, with "cpsw_mac_efuse" being a "syscon" node.

Logs verifying that the CPSW driver assigns the MAC Address from the
eFuse based on the CTRLMMR_MAC_IDx registers at 0x43000200 and 0x43000204
to the interface eth0 corresponding to CPSW3G MAC Port 1:
https://gist.github.com/Siddharth-Vadapalli-at-TI/63473d68e7a34860566c1339ce3da9f0

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..21020b7d3034 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -696,6 +696,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
 			};
 
 			cpsw_port2: port@2 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index a84756c336d0..7469b3d3a8c9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -18,6 +18,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 			bootph-all;
 		};
+
+		cpsw_mac_syscon: ethernet-mac-syscon@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
-- 
2.40.1


