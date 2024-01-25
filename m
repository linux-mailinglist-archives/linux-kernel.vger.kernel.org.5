Return-Path: <linux-kernel+bounces-38362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8807983BE50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D4A1C232E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED51D53D;
	Thu, 25 Jan 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xl9t/3rc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AB1CD27;
	Thu, 25 Jan 2024 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177159; cv=none; b=e6guST804MrInKjWwr4al1hPEra1bd/E9umB3KduyhA4+7y5eGxJOycNvfHtYMLCG1246jVnbTbMVL969SQVGN5uyTRGR8KtURCVKL9VXRBt0K0635o/ZocjRQIlBDjQOtBo2UJYHQJTrs83fYngRSLL0YW/YQe3Mda+DKLHl3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177159; c=relaxed/simple;
	bh=Bq9b/P2luDiSgUsP1d3rlxlmGymEHYkNFxSwABBXjjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RR0EM2it+GcoN6c4dOrUSqh53Y4bcx71migaUf7xAN1Eagg9Hg7NegGwUD72YoioBAKKb5g5ScH3uaV+spCmq8X+J92SeedFFkelQaGqJr82vIrGehutPFe0sOX3OsKOdRK0wLT+yBhGqfYoByLtBatJatjOXnf1rTZMJU4aFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Xl9t/3rc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5TtL069428;
	Thu, 25 Jan 2024 04:05:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706177129;
	bh=fS4/HlXCpVTUdnTk9aVSmh6qwcCOXQQ3h664y3ufGqY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Xl9t/3rcPKo59vd9Fsi4Q1ZcP1XrW4LmkSLWBUdg6ICxMi+1kVusRow+aFYIAN9Bw
	 CEFq9nTobFAEWKf12+Las+IlizGuNRt9Pl1t5pD0SS2YR3uRM4tyieCSczzwTnd9eh
	 VD6Darzze59QydmlhSoSZkuC2pXB8bmnDiHX+WUs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PA5TKq007256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 04:05:29 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 04:05:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 04:05:15 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PA5E0p005058;
	Thu, 25 Jan 2024 04:05:14 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
Date: Thu, 25 Jan 2024 15:34:57 +0530
Message-ID: <20240125100501.4137977-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125100501.4137977-1-c-vankar@ti.com>
References: <20240125100501.4137977-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Change offset in mux-reg-masks property for serdes_ln_ctrl node
since reg-mux property is used in compatible.

Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f2b720ed1e4f..56c8eaad6324 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
 			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
-					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
-					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
-					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
-					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
-					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
+			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
+					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
+					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
+					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
+					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
+					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
 			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
 				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
-- 
2.34.1


