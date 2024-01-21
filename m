Return-Path: <linux-kernel+bounces-32067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F858355F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109D4282F5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD01374C4;
	Sun, 21 Jan 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rktxHPZI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530210785;
	Sun, 21 Jan 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705844449; cv=none; b=uZqBCcUTe+o0ZTklFri1saHwzcj/GCFdN+A0TK9bxmQ9pX5KYiVY8ALEVNdkIEoL7dCfO6ElSpNzxXjdkUUGKXTDXHfGbgd7Kz1fdlKaGqprID4fYvAOOXk+n/TvILfo+4/csTxGHkFcy1xwb3gQv1wBnUIokK7km1Kye0Ajp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705844449; c=relaxed/simple;
	bh=hhJy+LSXnCKdCNHMvrgQXDg8/glnyLfWKNxCWEFH/tQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=up2T/iHMkIMZGDHymETA+O3S42keEH79f737vj4vPupqJB1pCG2lhlKvxxNgwp0+0BXnOMctLPJcZSHXBF1LkHHowdJMb5LL68aeFo1/Au2Bwmf5cFZiTo5jnD+5UAM/5U563Sq6ZbZzhq6fCTD4FO4zdp3boihcqS2ul3Uxids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rktxHPZI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40LDeMsL011351;
	Sun, 21 Jan 2024 07:40:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705844422;
	bh=i6GFj9UMX+JqTYdbgDWSVi0WGO4wE6eK5Pvgbx9HHX4=;
	h=From:To:CC:Subject:Date;
	b=rktxHPZIUdgjzsNDdT6pFvQKvAS5I6U5plZRvuO7UWGATnEr99xAF1beAs3fq5Njq
	 AHsBUIZDmUVkBaOInttGaacjnvQwiOPfXmyX3O0eky6mZwn91pSb9VFAPcBX0hxsf1
	 PcZaz3klUcPqSzw8WQ6xmc/Bk7tUSviXBQPNJ7TM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40LDeMmT086287
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 21 Jan 2024 07:40:22 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 21
 Jan 2024 07:40:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 21 Jan 2024 07:40:21 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40LDeIEb088588;
	Sun, 21 Jan 2024 07:40:18 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and wakeup R5FSS nodes
Date: Sun, 21 Jan 2024 19:10:17 +0530
Message-ID: <20240121134017.374992-1-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

K3 Remoteproc R5 driver requires reserved memory carveouts and
mailbox configuration to instantiate the cores successfully.
Since this is a board level dependency, keep the R5 subsytem
disabled at SoC dtsi, otherwise it results in probe errors like
below during AM62P SK boot:

r5fss@79000000: reserved memory init failed, ret = -22
r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
r5fss@78000000: reserved memory init failed, ret = -22
r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22

Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
index c4b0b91d70cf..14eb9ba836d3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
@@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
 		ranges = <0x79000000 0x00 0x79000000 0x8000>,
 			 <0x79020000 0x00 0x79020000 0x8000>;
 		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
 		mcu_r5fss0_core0: r5f@79000000 {
 			compatible = "ti,am62-r5f";
 			reg = <0x79000000 0x00008000>,
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index 19f42b39394e..10a7059b2d9b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
 		ranges = <0x78000000 0x00 0x78000000 0x8000>,
 			 <0x78100000 0x00 0x78100000 0x8000>;
 		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 
 		wkup_r5fss0_core0: r5f@78000000 {
 			compatible = "ti,am62-r5f";
-- 
2.34.1


