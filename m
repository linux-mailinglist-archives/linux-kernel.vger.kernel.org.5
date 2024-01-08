Return-Path: <linux-kernel+bounces-19962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBB82779B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7791F23BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE5554FA5;
	Mon,  8 Jan 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cgq1sizL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAA208A0;
	Mon,  8 Jan 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408IXDkP041791;
	Mon, 8 Jan 2024 12:33:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704738793;
	bh=L0ZN/p9i33lJE43x/uNLzJJqV9lS8X7UChbk/Kn2v8E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cgq1sizLi9L9xNPqysc/V6wRjFq2Ehu0MQXUtGhthmuKMshRYvMvMy1XbPwLACBSF
	 qL4+UxLfnTTHBiYE7W8guRr+kZJeNhg9JWSVSEo66xGuwUfLIcYaT6ZQ78F91cBGtd
	 pubW+dut6Ug1hZSGqdH9g/lnv9kGlPVuJARFYDFA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408IXDqp123990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 12:33:13 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 12:33:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 12:33:12 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408IX3hI051691;
	Mon, 8 Jan 2024 12:33:11 -0600
From: Andrew Davis <afd@ti.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Donald Robson
	<donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H .
 Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Paul Cercueil
	<paul@crapouillou.net>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH RFC v2 09/11] arm64: dts: ti: k3-am654-main: Add device tree entry for SGX GPU
Date: Mon, 8 Jan 2024 12:33:00 -0600
Message-ID: <20240108183302.255055-10-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108183302.255055-1-afd@ti.com>
References: <20240108183302.255055-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add SGX GPU device entry to base AM654 dtsi file.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fcea544656360..64b52c8dafc6c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1050,6 +1050,13 @@ dss_ports: ports {
 		};
 	};
 
+	gpu: gpu@7000000 {
+		compatible = "ti,am6548-gpu", "img,powervr-sgx544";
+		reg = <0x0 0x7000000 0x0 0x10000>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	ehrpwm0: pwm@3000000 {
 		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
 		#pwm-cells = <3>;
-- 
2.39.2


