Return-Path: <linux-kernel+bounces-35091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE86838BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E763A1F26342
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786745C5E0;
	Tue, 23 Jan 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="KVSg1o47"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251805A784
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005782; cv=none; b=ca72zCD3yRnjM0hXaKcWfNTTKlBz7f6s01ptBLbepieqkoH8G4UYnJDohsf0ovU6uD6tD8tQSMJc864Syqf9ORjL/xc0NUdKKlRApupluBDHW23+apXd86QB394RXSUrHt0qtsU7xokhOPJj2WLa8bZbgsyeXnAi+f+U/sxpczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005782; c=relaxed/simple;
	bh=3528Bh1w1ePwVQXdFUJM6DTyJtAszP7ZqPeAoExHN4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0i6bub9LoJQlTRCt7Bwyq67GEPe2b33E19at3mme6EMZicVL11lNPL9fKCIDH9zbUvcdSXVWHEMsHnCMfEnBKUBoxebnIA31ejHz2scQxZheeKJ/JXyeDVnwMughGNjzS/+pUtL8qMzm/TUmK7Il/oxQ6RrVld1tx/FM4DCyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=KVSg1o47; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706005776; x=1708597776;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3528Bh1w1ePwVQXdFUJM6DTyJtAszP7ZqPeAoExHN4A=;
	b=KVSg1o47nZMwLABH1P8l2bJgdO3nZzJtzG0izWjSPacER8bgcaLR6Johmg1GeCVU
	7rnFmiQwwbvq4gabidP3HkRImN69jl1wHGEcyz0FtNc2z8UuCtyDYgbhp6CTiUD6
	qAZ4HB3XcE00hRDO2V4LrBApfQCJpRVSDaqBOOPlElk=;
X-AuditID: ac14000a-fadff7000000290d-4d-65af95104432
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CE.4A.10509.0159FA56; Tue, 23 Jan 2024 11:29:36 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Jan
 2024 11:29:36 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: k3-am642-phyboard-electra: Add TPM support
Date: Tue, 23 Jan 2024 11:29:21 +0100
Message-ID: <20240123102921.1348777-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWyRpKBR1dg6vpUg2VLJC3W7D3HZDH/yDlW
	i+WfZ7Nb9L14yGyx6fE1VovLu+awWbz5cZbJonXvEXaL7nfqFv/PfmB34PLYtKqTzePOtT1s
	HpuX1Hv0d7ewehy/sZ3J4/MmuQC2KC6blNSczLLUIn27BK6M7otf2Ase8FR0/t/A3MB4lquL
	kZNDQsBEYtfX7+xdjFwcQgKLmST2tZxhhXAeM0o8v3iZBaSKTUBd4s6Gb2AJEYFuRomTB5Yx
	gzjMAm2MEk8eHmAGqRIW8JaYtuAOK4jNIqAqcf3xE6C5HBy8ApYSy+YHQqyTl5h5CWQdJ1BY
	UOLkzCdgC5iB4s1bZzND2BISB1+8ALOFgOIvLi1ngemddu41M4QdKnFk02qmCYwCs5CMmoVk
	1CwkoxYwMq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIoDEQauHYx9czwOMTJxMB5ilOBgVhLh
	vSG5LlWINyWxsiq1KD++qDQntfgQozQHi5I47+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDo6eQ
	7b+2P1qHjSuYG9R1Pq0wt7jttzYw4sKd0K1RB9LkLrwueaP/xnXT5s0Zk+30ZEL/HnLTexf2
	8eucqsp7O/TPJ/pK/3tXoLpMKOL/tyDDTUesj8oW2dZcsOQ9VpE25eAen6OLVE/2bUtiufXz
	QOBCPkPRhlvzVG9H9l05mDp5u4cQ778HHkosxRmJhlrMRcWJADj06iRxAgAA

The phyBOARD-Electra populates a TPM module on SPI0 bus.
Add support for the Infineon SLB9670 TPM module.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 53b64e55413f..8a518a86abc2 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -159,6 +159,15 @@ AM64X_IOPAD(0x0298, PIN_INPUT_PULLUP, 0)	/* (D19) MMC1_SDCD */
 		>;
 	};
 
+	main_spi0_pins_default: main-spi0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x020c, PIN_OUTPUT, 7)	/* (C13) SPI0_CS1.GPIO1_43 */
+			AM64X_IOPAD(0x0210, PIN_INPUT, 0)	/* (D13) SPI0_CLK */
+			AM64X_IOPAD(0x0214, PIN_OUTPUT, 0)	/* (A13) SPI0_D0 */
+			AM64X_IOPAD(0x0218, PIN_INPUT, 0)	/* (A14) SPI0_D1 */
+		>;
+	};
+
 	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0230, PIN_INPUT, 0)	/* (D15) UART0_RXD */
@@ -248,6 +257,20 @@ &main_mcan1 {
 	phys = <&can_tc2>;
 };
 
+&main_spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi0_pins_default>;
+	cs-gpios = <0>, <&main_gpio1 43 GPIO_ACTIVE_LOW>;
+	ti,pindir-d0-out-d1-in;
+
+	tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &main_uart0 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


