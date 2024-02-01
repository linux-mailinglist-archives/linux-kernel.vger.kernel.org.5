Return-Path: <linux-kernel+bounces-48192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D03845873
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391F81F21E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CFB5B671;
	Thu,  1 Feb 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nhnkWPG8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F64D9E9;
	Thu,  1 Feb 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792839; cv=none; b=ETHRRlw9kbNdaBBVXz1VqVDX0zXkscpfLJYqnkSreePs4PpNl2H90rlvKSNyPyCt+298+mUjeDVBzViO2+uoyZukaLDVieqJVhSvlAhwHQujtsd6Y0n1cf6yE+a556S5LMuxB+zqngP3+Y/E4pQTz2Bdt27PWRWHI14sS+gIyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792839; c=relaxed/simple;
	bh=wga3no5yHB1i1ri478UBzBLBeyiLJJjEqq1Q06COIl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TFUFOJQUYYZxlP8JvLnucx7yg04673rdVUydIPmyypKSpAzTPML928P5Fq3u6hv1lmPgekW2P/jQxcBxjNyIo+3rwW8YehOtEmrDXBcBrw5ll+P2ntc2rAAbkpmiNUb+bUQFC7jxb0RN+DxHLjs0gjV3uMMJ+/FmaSw4QEEzzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nhnkWPG8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411D7B7T111379;
	Thu, 1 Feb 2024 07:07:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706792831;
	bh=oQoiwHa2AlMZkLmNMt3eKpIEsv47bV+WnPV6WBux3Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=nhnkWPG8sezM44+vAKv2/Hhk0puVQ0NbbxGjjtNsdQTcgz+hl325jPSlNuGimjGy/
	 biKf0cKdMaHEmlx91lKIBlBM1jefXv5WNxZA41JgapiCIFZctgr9rzinBj0VY/mYQ8
	 Fx0bEiKDN4+C0+xCu6VQpbo8KPUDKgDZcVuFGp9A=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411D7BaK107452
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 07:07:11 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 07:07:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 07:07:10 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411D7A5L012842;
	Thu, 1 Feb 2024 07:07:10 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Thu, 1 Feb 2024 18:37:01 +0530
Subject: [PATCH 2/4] arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240201-am62p_csi-v1-2-c83bb9eaeb49@ti.com>
References: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
In-Reply-To: <20240201-am62p_csi-v1-0-c83bb9eaeb49@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Devarsh
 Thakkar <devarsht@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=wga3no5yHB1i1ri478UBzBLBeyiLJJjEqq1Q06COIl8=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBlu5d3UzGZI6YxZ0RpP34ApAG9iZABT3QHe4loq
 xrLB5vXE6WJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZbuXdwAKCRBD3pH5JJpx
 RQmWD/4zC0k6WPHx8BWC0BSGOGXECIOmBvgFNWKRwwineHuFevumwYrcrajNZm9MXQNELnxmHIP
 Ee7p99LtuxyQ5BaWQG4U6Q+OtRy/8wPmqS6Oxe7gwCV+7UNbXltCBftFtlaDn9xLte/EcgVsn01
 W+eIq7vD4xHdiywXkWv9YKYKPMMeDoL96S3wI0On1hQ2Aix3B6CJiHVipxnkMZTpeb9VMJGZdgo
 /6Y9p8KCSlwfgR9SRIsP21SJ1Ms5BAuUQWZaAW0J3VZNnwNwBczYnq8hHKQA0EpF7P8ncbE+p4k
 GpEiuYab2lTRCvBeXkivCaZGEUiuaRGZD+DuZK0LOflcuUy2tB/5ImdUefaMo+uHIrQvWVaSPFO
 j6Z880nxEqcAC6GoOr0wy9K8MLmq/gHH82yhdG1czC66k7S5MpAfkXXi7F2SJuK+mMzkkpAMJvJ
 ZAOXt2y+kxFHTGI0cXOMv3E1JPtF0RHTxsHCiF9uqXUsl8U6o6bpQNzh6Hw3AgJkBDs3AU+Bx9G
 V170r+4IrQSLNtnF3C3NfcJ/LdPxuY9xm4WE8+j8Qs0L9VQyzfksNwn4QP2uk5l1z95vLGPtSEU
 /61EvcbWtwvpi9iYmvTa3SuMEMJeRRwgWs1nMaXlqg3U3jiY2yEPLAtllfV7UoYO7HvQIepwEE4
 sPro7hCuIGEXu4Q==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On AM62P, CSI-RX uses a dedicated BCDMA instance (DMASS1) for
transferring captured camera frames to DDR, so enable it.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 4c51bae06b57..57ec4ef334e4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -158,6 +158,43 @@ main_pktdma: dma-controller@485c0000 {
 		};
 	};
 
+	dmss_csi: bus@4e000000 {
+		compatible = "simple-bus";
+		ranges = <0x00 0x4e000000 0x00 0x4e000000 0x00 0x408000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ti,sci-dev-id = <198>;
+
+		inta_main_dmss_csi: interrupt-controller@4e400000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x4e400000 0x00 0x8000>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			msi-controller;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <200>;
+			ti,interrupt-ranges = <0 237 8>;
+			ti,unmapped-event-sources = <&main_bcdma_csi>;
+		};
+
+		main_bcdma_csi: dma-controller@4e230000 {
+			compatible = "ti,am62a-dmss-bcdma-csirx";
+			reg = <0x00 0x4e230000 0x00 0x100>,
+			      <0x00 0x4e180000 0x00 0x8000>,
+			      <0x00 0x4e100000 0x00 0x10000>;
+			reg-names = "gcfg", "rchanrt", "ringrt";
+			#dma-cells = <3>;
+			msi-parent = <&inta_main_dmss_csi>;
+			power-domains = <&k3_pds 182 TI_SCI_PD_EXCLUSIVE>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <199>;
+			ti,sci-rm-range-rchan = <0x21>;
+		};
+	};
+
 	dmsc: system-controller@44043000 {
 		compatible = "ti,k2g-sci";
 		ti,host-id = <12>;

-- 
2.43.0


