Return-Path: <linux-kernel+bounces-131094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788A898308
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB7DEB246B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAE67C53;
	Thu,  4 Apr 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fQtDUe9h"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4636BB30;
	Thu,  4 Apr 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218741; cv=none; b=m3432AGqLJA+kv4RDl4PfAWSK1ZXyuFZIspUTUR6z9jfz1VbM/1PK5dp2Pukd+1lST44ybCsfiA9YteBem6GtUv6MqjcvcnilQcCm0CC/CDOiYMa13322x1RX9prCBWz6Wk/wdX3baK8e9QujnqkxL36Yjud/kHqb8/j2wxOpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218741; c=relaxed/simple;
	bh=N7ewqZhBqQkO15NwCpEWNIRWEPWgoPN+ZDkzw8ksoB8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZO9xfiLM7Ir+aAvT2PpjxOvsD5KIFV8bKzZmJdNT1DSFS7rSUITURNEn4GIC7qhmOW+ELjLpSTA/k08l/4vCyp2K3gepAIQ8cPddaKw1djcBaW8b0/7KORPMV7Os4VjaDpu/GtVp1V2VzeSz53/Kc0KhobZIePY32h9n3iVRbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fQtDUe9h; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4348InAS112112;
	Thu, 4 Apr 2024 03:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712218729;
	bh=Eoxu7O7Eh1P0shb/ON+em0LKUOZSFLCOVZfXDOQN4ic=;
	h=From:To:CC:Subject:Date;
	b=fQtDUe9hCKMEb+9JgeRSe+MLOQYYjyykQqQ5wztSk7x17UKRpI9p6mYi/yJQo9pIk
	 GRhEaZdT1TDdBmeBIZryLcQ5eRgzxOlB+l8LmdFbZ3Wztd/LGO7SMKPFVKWv/pe0ar
	 B8d422zmfH89b/UL9ZQzjKF9fbS3tIpFGjJYne/w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4348Ind3115471
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 03:18:49 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 03:18:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 03:18:49 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4348IjHU101663;
	Thu, 4 Apr 2024 03:18:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
Date: Thu, 4 Apr 2024 13:48:45 +0530
Message-ID: <20240404081845.622707-1-s-vadapalli@ti.com>
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

Add the "cpsw-mac-efuse" node within "wkup_conf" node corresponding to the
CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the compatible
"ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations on these
registers. The MAC Address programmed in the eFuse is accessible through
the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree property
points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver to fetch
the MAC Address and assign it to the network interface associated with
CPSW3G MAC Port 1.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch is based on linux-next tagged next-20240404.
Patch depends on:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240402105708.4114146-1-s-vadapalli@ti.com/
for the newly added "ti,am62p-cpsw-mac-efuse" compatible.

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
https://gist.github.com/Siddharth-Vadapalli-at-TI/9982c6f13bf9b8cfaf97e8517e7dea13

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 1 +
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..848ca454a411 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -696,6 +696,7 @@ cpsw_port1: port@1 {
 				label = "port1";
 				phys = <&phy_gmii_sel 1>;
 				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&cpsw_mac_efuse 0x0>;
 			};
 
 			cpsw_port2: port@2 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index a84756c336d0..df9d40f64e3b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -18,6 +18,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 			bootph-all;
 		};
+
+		cpsw_mac_efuse: cpsw-mac-efuse@200 {
+			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+			reg = <0x200 0x8>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
-- 
2.40.1


