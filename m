Return-Path: <linux-kernel+bounces-46187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8BC843BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9ED1C26ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009A69D37;
	Wed, 31 Jan 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dpmwqO1O"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE367E90;
	Wed, 31 Jan 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696099; cv=none; b=aUmENbfMSETEmRzbo8cmTjYrk6pFN6IbXe2uCM5YeUeJxowsGkm3B1T+RjnHUmCwuM5o/lU0KbCNVOxS0Rp905swA2luB4shT07TK1WOXjkAOuYFi9aDDo/XqSYE9EZATKE8s1OSOHxp9wz7XjRp9aqirXvRVTbx8WzQeuUmxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696099; c=relaxed/simple;
	bh=WeRVg60IMUQS7c/ad0OjXGSTUAHc5fi/+QfVMEkorhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBF5+EQBN2GeP9FZNsqgiCIpugUQnBAdo6y56OG7DVVl/NfnKyHdhTdAvde9kEZCZ3vB6Ht6sth1aAV5z0RBBbCaZKYqa+lMC98M/HulwCj12qa98eTEds/bnCcpcpDiIF26SKU1C0CmM6/dGxYb4XDlXcOruKowA6typZ6qW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dpmwqO1O; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEkIA055748;
	Wed, 31 Jan 2024 04:14:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706696086;
	bh=w+PIjhIV7OQQWzAXBpa1FrRhyUnWkVOnMetFY1LkX8k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dpmwqO1OWq+nv4TWZH6ZbH6DOzfEY2gt2wxspDn7oFcadTc3TdfC0soRDmc9HCMSo
	 YtNIV1hkaTLSLc1NmZ0HSV1taHrgThFJrFFoRuLN3M70PgZ6DZJ2fLnYpfHGbtTe44
	 XhubRHcxDqH2KSVaaMqRIwRyQGGnJSz9vdsC52w0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VAEkvN025156
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 04:14:46 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 04:14:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 04:14:46 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VAEjp5110215;
	Wed, 31 Jan 2024 04:14:46 -0600
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
Subject: [PATCH v4 1/6] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in serdes_ln_ctrl
Date: Wed, 31 Jan 2024 15:44:36 +0530
Message-ID: <20240131101441.1362409-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101441.1362409-1-c-vankar@ti.com>
References: <20240131101441.1362409-1-c-vankar@ti.com>
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
Acked-by: Andrew Davis <afd@ti.com>
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


