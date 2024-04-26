Return-Path: <linux-kernel+bounces-160607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C435F8B4003
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB632870EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F1C18C36;
	Fri, 26 Apr 2024 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Pl28dfna"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E02032A;
	Fri, 26 Apr 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159119; cv=none; b=OxBi/D2MULNfLTuKr+1fxO4DYgItbJ71WJN/caMhn9pYjRMRI1c9mO2qahkdE7X4DaOxOrwUcTocxPU8cCcGZwj3QJJR3qd0Jd5cxw7wIfY9c5FBwp2qkh8S5BIZB9TVx+hj8rmM3gzyTj5bETTY4XKZnVoF6fgjoZTv4TfdpGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159119; c=relaxed/simple;
	bh=nsZCppXmh8lxPmCUagHvnCSHS+UbJBgIFsgwfI9awYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ5Bwt5zHXjVWEyBgv3lt6repFCDUl23CigZYwnouw3tO3I2DvF1suu95DBbccmiiYeFk3QpKuD5LpGJ9H6TvzabUYJhum/2i+S0DmI4/o4tJ+aWvzxBVVVx7safyGHLsDxNL762sqP4XXc4Hn0PsS9FcqZvY5ilrUHp/HdFq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Pl28dfna; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QJICN6116104;
	Fri, 26 Apr 2024 14:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714159092;
	bh=IUAoumEhy+wq6Tu6vsgEuKclmExrdXZar+JrMRHsA5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Pl28dfnaRKqoau+A+nDvWZM6lkRvR75DV5kO2Hcl8YHk57ydFfDn/+JbIU2wvhfOp
	 +Tww68PBw/G/teKRmbDiA+B1CZhqWIKgqgtcd1wYy1nKmvJhLQdeCK1VKlvhgaMrfX
	 IyCBEnLHGPcKQ9wWlIDaHKpaGaxuzLVq86TrEcfE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QJICTk001742
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 14:18:12 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 14:18:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 14:18:12 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QJIB7N028593;
	Fri, 26 Apr 2024 14:18:12 -0500
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hari Nagalla
	<hnagalla@ti.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v9 4/5] arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
Date: Fri, 26 Apr 2024 14:18:10 -0500
Message-ID: <20240426191811.32414-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426191811.32414-1-afd@ti.com>
References: <20240426191811.32414-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Hari Nagalla <hnagalla@ti.com>

The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
domain. This core can be used by non safety applications as a remote
processor. When used as a remote processor with virtio/rpmessage IPC,
two carveout reserved memory nodes are needed. The first region is used
as a DMA pool for the rproc device, and the second region will furnish
the static carveout regions for the firmware memory.

The current carveout addresses and sizes are defined statically for
each rproc device. The M4F processor does not have an MMU, and as such
requires the exact memory used by the firmware to be set-aside.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 3c45782ab2b78..167bec5c80006 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -48,6 +48,18 @@ ramoops@9ca00000 {
 			pmsg-size = <0x8000>;
 		};
 
+		mcu_m4fss_dma_memory_region: m4f-dma-memory@9cb00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cb00000 0x00 0x100000>;
+			no-map;
+		};
+
+		mcu_m4fss_memory_region: m4f-memory@9cc00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9cc00000 0x00 0xe00000>;
+			no-map;
+		};
+
 		secure_tfa_ddr: tfa@9e780000 {
 			reg = <0x00 0x9e780000 0x00 0x80000>;
 			alignment = <0x1000>;
@@ -457,6 +469,13 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+&mcu_m4fss {
+	mboxes = <&mailbox0_cluster0 &mbox_m4_0>;
+	memory-region = <&mcu_m4fss_dma_memory_region>,
+			<&mcu_m4fss_memory_region>;
+	status = "okay";
+};
+
 &usbss0 {
 	bootph-all;
 	status = "okay";
-- 
2.39.2


