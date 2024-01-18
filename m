Return-Path: <linux-kernel+bounces-29974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AB283161A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE551F24B77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62C200A7;
	Thu, 18 Jan 2024 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dLFZMpog"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830911D55B;
	Thu, 18 Jan 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571131; cv=none; b=h/ieeiNkLvx2zpuemOln/5iLFFhA6tpwyIZfPuejT511yekMv9Dma5+rcLBfZtTHMz7AE16lvHPqv1Ud+H14lBSCrN67IVpJuQx5YjGFktQGKJEdAawGkigi0oe8gR23cCWJlgZvnvaBI5Z+J+hGVS89sGfAZ39BuYvQJPbVgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571131; c=relaxed/simple;
	bh=x83dtgvZG+AZpax6l0RWiqomRJic3VFL6HGGV0xAZ1s=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EXCLAIMER-MD-CONFIG; b=W+gYwlWEg4Qp9yRKc/0XeyPrjxCwiTkmqOwlaQ4opsL9D68K7BkyX7nF1YLiGZ5X6zBn2lnd1lmC3cGEBqFmkz58kkwcodMNEHlJZsYSxrb59t2MmTuza3yPzeNDBMMAACKp1IpgAcdrmct8PwE5gS8H62rkoaibKeZzEkucQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dLFZMpog; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jFOt083045;
	Thu, 18 Jan 2024 03:45:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705571115;
	bh=WBVyMpU18ftuov8XLeiZM0h0lQ/KvUIRfi36S4Cx1kM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dLFZMpogUs/6fS4NUy2cHDrFT4SoqXydDaF2BRaPgN2LikeMLGePPgqAMFPnB6b9I
	 fm4roS46agaiI0QIcEOD4nw/czE9rk9dqxBfBZ1RJKtuCxPJKpeWQQlj8N/VxoPCbP
	 USg2+GonB8Rc/jDnPRMpl6MVwNYHouzZqQGX6GmU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I9jFGe018518
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 03:45:15 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 03:45:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 03:45:15 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I9jEph113580;
	Thu, 18 Jan 2024 03:45:15 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <c-vankar@ti.com>,
        <danishanwar@ti.com>, <tony@atomide.com>
Subject: [PATCH v2 1/5] arm64: dts: ti: k3-j784s4-main: Convert serdes_ln_ctrl node into reg-mux
Date: Thu, 18 Jan 2024 15:14:50 +0530
Message-ID: <20240118094454.2656734-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118094454.2656734-1-c-vankar@ti.com>
References: <20240118094454.2656734-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This removes a dependency on the parent node being a syscon node.
Convert from mmio-mux to reg-mux adjusting node name and properties
as needed.

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


