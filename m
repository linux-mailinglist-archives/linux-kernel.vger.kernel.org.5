Return-Path: <linux-kernel+bounces-155455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967FD8AEACD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C8D28BE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729D13D63B;
	Tue, 23 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mnIXeA6+"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858813D29E;
	Tue, 23 Apr 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885473; cv=none; b=j0tWlx4NxFHnQQn6Kv9SE3nhQjOixQK5yal17asX4NGXu4Bcog+GFSTknVKQMgVBKLf9OizmP544OhnyiaZ05NHn9hUp7EOQhIjyfajV60ncy6JX1+2wJ0wtezc1YGvabBaqXfSxz68AphovlmzBUcStTOlP/Inr5Hza+oSLEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885473; c=relaxed/simple;
	bh=7D0Jqm4Hi3yv4xX/pXec3TN115HNJWKeLrGRpUFarvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1wtzXd//mWBEh5gCBg2yp0XzNSKkEb6u8XcPpLVVP2pY1xnNPS56e0YXuA3Jba9jrm9cuV4YSEenNiUqL0TTnqebpf71wNS3L/Oha/Au81HVin0Kf+mcYyKfv8ool6Pp2rkr5l93yl+JlUjZS/qCXi7aIvTowhBaq05oHA8PKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mnIXeA6+; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWdj071457;
	Tue, 23 Apr 2024 10:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713885452;
	bh=epMXkrMLZOUJTL2bqi9MWHEie1OnttqIhqXQ33qIXAg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mnIXeA6+yfsw9t8Ikb1/HVqaMp6TuXUkh6rntI2iWwOL1Z1E75SXPb+A9uN6y+/ss
	 JnZD6+ZOs/1KIL6nOmIyJx0yggUj8/zOpD7NFU/QLoToaL+2QgxyDJXhbLL8Fxrac1
	 6XIw0cpEDPzoOqRLpk52m/rqXxDtAHGy9PCCWHDo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NFHW1k013055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 10:17:32 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 10:17:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 10:17:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NFHWYI080176;
	Tue, 23 Apr 2024 10:17:32 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 2/5] arm64: dts: ti: k3-am65-main: Remove unused properties in sdhci nodes
Date: Tue, 23 Apr 2024 10:17:29 -0500
Message-ID: <20240423151732.3541894-3-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423151732.3541894-1-jm@ti.com>
References: <20240423151732.3541894-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On AM65x platform, sdhci0 is for eMMC and sdhci1 is for SD.
Remove the properties that are not applicable for each device.

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Fixes: d7600d070fb0 ("arm64: dts: ti: k3-am65-main: Add support for sdhci1")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- no change
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 0803a8b9bfe84..127f581a56bc6 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -439,12 +439,6 @@ sdhci0: mmc@4f80000 {
 		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
 		ti,otap-del-sel-mmc-hs = <0x0>;
-		ti,otap-del-sel-sd-hs = <0x0>;
-		ti,otap-del-sel-sdr12 = <0x0>;
-		ti,otap-del-sel-sdr25 = <0x0>;
-		ti,otap-del-sel-sdr50 = <0x8>;
-		ti,otap-del-sel-sdr104 = <0x7>;
-		ti,otap-del-sel-ddr50 = <0x5>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
 		ti,itap-del-sel-ddr52 = <0x0>;
@@ -462,15 +456,12 @@ sdhci1: mmc@4fa0000 {
 		ti,clkbuf-sel = <0x7>;
 		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x0>;
-		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-sd-hs = <0x0>;
 		ti,otap-del-sel-sdr12 = <0xf>;
 		ti,otap-del-sel-sdr25 = <0xf>;
 		ti,otap-del-sel-sdr50 = <0x8>;
 		ti,otap-del-sel-sdr104 = <0x7>;
 		ti,otap-del-sel-ddr50 = <0x4>;
-		ti,otap-del-sel-ddr52 = <0x4>;
-		ti,otap-del-sel-hs200 = <0x7>;
 		ti,itap-del-sel-legacy = <0xa>;
 		ti,itap-del-sel-sd-hs = <0x1>;
 		ti,itap-del-sel-sdr12 = <0xa>;
-- 
2.43.2


