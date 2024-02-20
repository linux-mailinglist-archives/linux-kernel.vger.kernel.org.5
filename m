Return-Path: <linux-kernel+bounces-72402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581785B2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F55BB20974
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01D658ACD;
	Tue, 20 Feb 2024 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="do/N78wN"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF5959B75;
	Tue, 20 Feb 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409914; cv=none; b=AWK522mfcl9ASta3ineLXhTLaibvKUZXpszU/L9oHXbAnQJLOyVqPs2Keevwt8/F9V2FvL0lFrxiSmUHFSxlU31YMq6fnq1MDzSDfLr2wbTBAoogF8xu4tk/0XxitwxicsMmW1AKJPdBSN49mjlfTThnvPdVtKqVaKMBd8rkbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409914; c=relaxed/simple;
	bh=k34jv9ed9R/88I+IWEoJv6cf8XHNWFlO40gaCiKu+7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lMmNC5KZbVcDCHD/ye6OiXlspf+HwcYferaFFX9+6DNLqUm5YFfEBeQ3slb3pKsfJ54GNI5gOztip+AgpYtTOR1v64XBkbcHL4bWilAoSnewfy7M6AWVQrqnrF6G2k2T4H2SDAKI3OyAQD1IyV6CcyJ+AWQvQEcl3ylAoWNzE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=do/N78wN; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IFJo009709;
	Tue, 20 Feb 2024 00:18:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708409895;
	bh=YnQFBxtIXwo70GOhJdHlRVrZdi2bqii6xgy4xhWN+O8=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=do/N78wNL32z0bCJbhTzIkAsagYNjz+jsw5fwAPu6UtIi0UoPf82OhcMW4JNtpY/q
	 Jp1COofg8Vt+fkHIAJTS5PGNjBaLHi57muRPINA+RprgN9EFwcqqBBbbILsnDpxD8S
	 9HKo7WCp8lTbw/OASq/hxSOmp0Y1D4/5H3/x8ziY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K6IFeq048034
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 00:18:15 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 00:18:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 00:18:14 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K6IDAQ120909;
	Tue, 20 Feb 2024 00:18:14 -0600
From: Jai Luthra <j-luthra@ti.com>
Date: Tue, 20 Feb 2024 11:48:03 +0530
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am62p: Add DMASS1 for CSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-am62p_csi-v2-2-3e71d9945571@ti.com>
References: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
In-Reply-To: <20240220-am62p_csi-v2-0-3e71d9945571@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=k34jv9ed9R/88I+IWEoJv6cf8XHNWFlO40gaCiKu+7U=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBl1EQfsTB4YxhZ4xsWTyiTc91RK/4HhdmqqqWqG
 3TKkiJKt9OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZdREHwAKCRBD3pH5JJpx
 RWNeD/9q6LcVq2eQQ9Hov38TNs99qtA/JJ0Ko/lXYdPvD9yTsN4wMobGY7LVRiy0AJzzZcLv+0i
 ep33QRmytuf+Z9Jw6l2mn32iBOCJHHp6FAFLR1viL5X0cpVrkrtlj9cnVU3kVFz2x5i1Fbs9Ezp
 GndQqaM6ZEes5fgxMbt8cgxf074o2ICS/wCYq9ocDjDj0DIcFpD66tzaixvvvvZFSzUxiNFg4UY
 oOPNwVlXXbgEEjWG/3vn0TNe549aIUQFE6ee7PirTorvIJoAX8530fJersIE/zWkfrpELyCdIoI
 EATtmA+m0263sZYNHjBf3hK3ztX8XQHdsOsdQIV+rkXOIdsqftpWqpMIFW7mLeFLaYI25v+9WVm
 gxRJFnboj9ikJe6IEYFm9NUW31rGCveGwUIvB8JF5VJgwp1Ax2Wj7M0fUE4/k0GpEMRBVueMAgH
 UQXLh92W9DkPkWxhZjbF10lv34G/APdIZ+9Q7n0Z/+qIAD5snagq/yRFQceLV0cC/CRQRLou91w
 MOJi4yC1y43nbmBeGdWC4CyKCthAKTOcfA761yNd4xlU+wxNA0p2tDS5/lnwnTwCxH5DHdxAhIB
 TQH/5BDqyX29G1O2O4gRAs1QPkq/yOefx5U5RWPJNJOMGFsure0cJHfz/aLwLQH/xtEAYClj69b
 PL2j0FzfP+vBP1g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On AM62P, CSI-RX uses a dedicated BCDMA instance (DMASS1) for
transferring captured camera frames to DDR, so enable it.

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index e43530beb79f..fb328774879c 100644
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


