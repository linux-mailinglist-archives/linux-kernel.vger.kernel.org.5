Return-Path: <linux-kernel+bounces-64578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74D85407E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4C91C237B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192F651B1;
	Tue, 13 Feb 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D0Wgk4HC"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EDF64CD0;
	Tue, 13 Feb 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868642; cv=none; b=npBE3/E8FdMSXy2y1Znjdbrmq+Gu+7vZVVHuoJkcnQgmbHr1i4hGSliMgG3XOGATWy9WfVJ0ycO/NtSK/IqgnvRuyxRJH3vrvJJPFgjd19GRQ7vJ0yskyYXYw9Yz79+n3b8B/opPDoIghK3ejzfUD/mM0ZVi03/dGuAFD2X+4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868642; c=relaxed/simple;
	bh=KJ9zI4wUFQtjKDqctB54qtZgK+wf7cWMgHyQlyC3+e8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJ4ZEvLdVmNNMH7kYlpfMYOClfbu+RU/jG39dQl6Kpa6sy8OtUTIW9YJFxy9yDa6qN4yCxIcdvkUyWcxwWlSR2XR+WRxBVTcoDp5QN/ZoUQORZbigoU3ApextCAVIDJ7NfXo9awsN/ntEgfitBgLMi0fjEmuwIQgcl9kJfixbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D0Wgk4HC; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv2C4082894;
	Tue, 13 Feb 2024 17:57:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707868622;
	bh=59Msm0WMCOHTkR/+pdoTs8LcSxxAYPouV4fK6fNApEg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D0Wgk4HCiMPwy+B6F0I+5mXOkTscFupJbpcr0d3VLSv5CDGEKVYSw/IOd3rtCVhPn
	 FSeM5SbuOf8xa6AGDMudGauQynIK5OpZllF5k/ImfFaYytV3DUU0vsF2xAa/20BONf
	 rLFnnZ53B4xvXRGSzrqzQKZJ1aJ+cuKw3yfLIda8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41DNv2MC075716
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 17:57:02 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 17:57:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 17:57:01 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41DNv1R8091761;
	Tue, 13 Feb 2024 17:57:01 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wadim Egorov
	<w.egorov@phytec.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 4/9] arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC
Date: Tue, 13 Feb 2024 17:56:56 -0600
Message-ID: <20240213235701.2438513-5-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213235701.2438513-1-jm@ti.com>
References: <20240213235701.2438513-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update MMC0/MMC1 OTAP/ITAP values according to the datasheet
[0], refer to Table 7-68 for MMC0 and Table 7-77 for MMC1.

[0] https://www.ti.com/lit/ds/symlink/am6442.pdf

Fixes: 8abae9389bdb ("arm64: dts: ti: Add support for AM642 SoC")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since V3:
- No change
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index ddd382a0d735..9bfa0a969bfc 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -633,6 +633,9 @@ sdhci0: mmc@fa10000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x7>;
+		ti,itap-del-sel-legacy = <0x10>;
+		ti,itap-del-sel-mmc-hs = <0xa>;
+		ti,itap-del-sel-ddr52 = <0x3>;
 		status = "disabled";
 	};
 
@@ -645,12 +648,16 @@ sdhci1: mmc@fa00000 {
 		clock-names = "clk_ahb", "clk_xin";
 		ti,trm-icp = <0x2>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-sd-hs = <0xf>;
+		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0xc>;
 		ti,otap-del-sel-sdr104 = <0x6>;
 		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		ti,clkbuf-sel = <0x7>;
 		status = "disabled";
 	};
-- 
2.43.0


