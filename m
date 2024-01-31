Return-Path: <linux-kernel+bounces-45522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E548431FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF00F1F25579
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41701366;
	Wed, 31 Jan 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t6VENNGx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96A363;
	Wed, 31 Jan 2024 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661442; cv=none; b=aHrZotXivh9ktC2uKO27t6pnPbnf4iDnkley/+GntWl5Z149cwScBhwjB1NBx82tpDNrgsVl9XdqAqCTzKU18f/P4QTmuutpZI7pAf07bR/6ZVEruF3SFe+35qJHeG2f0zUmlJJpy3mmPg4t8+4d75m2BxhHqdgXF2h6ASBL0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661442; c=relaxed/simple;
	bh=TRI76dxKaAg21+XKMTz2eTHyC73X3AcSx+5xJSrO0Q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVnlLLBFSoWvXhpAQS7fASmNyj/APv0EXff6SXjPWDDNQfJq65Ipr3wsxy6PM8NY/JzGCw8WvYYRl3s+xAOuc8bcHLyKo9HnTo79zUYzd1lVZ8rHOtqRbMC62yY7TRZ9OYWPT/mFrZdCb3xBJYoUc8HU7/uHkmH04Rk69ZggH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t6VENNGx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bFKP038166;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=KX5ixSYuqhTJGTqFFZNAXHuik1i9Vu58r7YXwjkwNqk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t6VENNGxZ+4kVYI48GV/LXaMQVqkGjNUXHqffkGA4nMUzMf+Pu7hJI1++OyJjKTOG
	 AiNhNCHJ7k2zyPs6kTgZVRxHzzqbUyUj9jCJaqIy4oM16tuH0JN0l1/Vn0T4yeRKlw
	 +9Ej71sxLvOc8yxAM0gBRhZqCX3X5SJ4hcMFFo3w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFio045574
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:15 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEwG026520;
	Tue, 30 Jan 2024 18:37:15 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 09/13] arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
Date: Tue, 30 Jan 2024 18:37:10 -0600
Message-ID: <20240131003714.2779593-10-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
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

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e348114f42e0..b355d0a715a9 100644
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
 
@@ -645,13 +648,17 @@ sdhci1: mmc@fa00000 {
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
 		ti,clkbuf-sel = <0x7>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
 		status = "disabled";
 	};
 
-- 
2.34.1


