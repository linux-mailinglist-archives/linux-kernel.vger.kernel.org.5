Return-Path: <linux-kernel+bounces-57284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626184D621
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24CA1C2185E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BDB6BFAC;
	Wed,  7 Feb 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YdZIZ5fo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2B535C9;
	Wed,  7 Feb 2024 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346541; cv=none; b=gf3J3G38DrXWEPvYafLCnmnDQC/4nAIyWwVWcHL9vfnT59uS69T7i1pexllG9sZ1dIDfIjjImOUnKI2y+PzktK35bCnF7j17ifYWUimKOl1q0ByxP0F2KeSvDKzgEDWGVt/gDIKt0yPIZtcqHBQ9DGYTd+h+yMZqWO3UYqNShiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346541; c=relaxed/simple;
	bh=29XZqy1NlZDMBMBkd7T5PXbt3EShVGgRRTqmbSoHc6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez4b58Euz16hTyORFl0YQG8DjDLnNMjKJVCiTIrFVkMQRajAd3HtyXu/I8kokgrNfXr+/cNGL6XwUuFFY8fjF99ydJxvXqJLtnf1PywKi4FIE9UOZndvW+X8lF/a7DWA6J01IhdFYgoguMPYgXNcjUntslMqTuc0eqSWskhLr/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YdZIZ5fo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417MtRTn018446;
	Wed, 7 Feb 2024 16:55:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707346527;
	bh=8rK1EAYOGmZZt4ey3Uf0NIzUrFDmMn1ZXnmz0I2UYHg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YdZIZ5fo1Ynf84GYYCCBSNBiUhNZ27GU70FV/ucrwiUnmu73UhR8xycs6HKrfOevQ
	 CSVxVlJKvuzIxsR7aUYQF/4C5LWMFVFtXTZ8dkPuGc2YCbSotI7fIwwT3OZnMKXwOH
	 V1sBMmZaPH3OUiUDNflTfHtPWPlwQtbwR2eArAfQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417MtR3p071889
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 16:55:27 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 16:55:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 16:55:26 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417MtQmc014027;
	Wed, 7 Feb 2024 16:55:27 -0600
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 9/9] arm64: dts: ti: k3-am6*: Fix bootph-all property in MMC node
Date: Wed, 7 Feb 2024 16:55:26 -0600
Message-ID: <20240207225526.3953230-10-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207225526.3953230-1-jm@ti.com>
References: <20240207225526.3953230-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add missing bootph-all property for AM62p MMC0 and AM64x
MMC0 nodes.

Move the location of bootph-all property in MMC1 for
k3-am62p5-sk to match Sitara board files.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 3 ++-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 5c9b73726ebd..17c6c2fc0e09 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -410,6 +410,7 @@ &main_i2c2 {
 };
 
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
@@ -417,13 +418,13 @@ &sdhci0 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	status = "okay";
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vddshv_sdio>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc1_pins_default>;
 	disable-wp;
-	bootph-all;
 };
 
 &cpsw3g {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 83f2b00726b5..84619782e52d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -493,6 +493,7 @@ eeprom@0 {
 
 /* eMMC */
 &sdhci0 {
+	bootph-all;
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-- 
2.43.0


