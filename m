Return-Path: <linux-kernel+bounces-12014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A6C81EEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4651C2260A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933445950;
	Wed, 27 Dec 2023 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mio+w+2G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434644C6D;
	Wed, 27 Dec 2023 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQMH2tL021935;
	Wed, 27 Dec 2023 04:33:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=P+CNI8fEbtJTG2nlkv45CYvpbybvL7KVNMn2ypOZHMk=; b=Mio
	+w+2G1P7ggxrZBKCaBv2aJBe601ao+Ly9MoiZGUxYoii3FGt987WwHjzfR98/fAc
	iDGnpLstkztu+C05BnqMeOgFS9nKmTrZ+gsWLWxmvW96Tpo3isamr1XNGS5aZnJo
	d5msX/6mqtRsKMDRxpjtBoKaHydRPet4vZV4TnW2ewoX0F0mpCHqzRoaa1E1HOEp
	DQ12ZD6xd4rSj/dGVgFY4wLreZHXVLG+hBGI6ZJsXubL4bB0UwO79/1ZFfhUCE73
	zU9z3r4vBpXaTCzrhVXHP6kBxUE60+PUeGfKrN9745lg3P7a8fRNwTrIxjmM4xbc
	faWCmvfXmgKb5DEskNQ==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3v5yxp0a5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 04:33:25 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Dec
 2023 04:33:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 27 Dec 2023 04:33:23 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 8D8165B6933;
	Wed, 27 Dec 2023 04:33:17 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <huziji@marvell.com>,
        <ulf.hansson@linaro.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <adrian.hunter@intel.com>, <thunder.leizhen@huawei.com>,
        <bhe@redhat.com>, <akpm@linux-foundation.org>, <yajun.deng@linux.dev>,
        <chris.zjh@huawei.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 3/4] arm64: dts: ac5: add mmc node and clock
Date: Wed, 27 Dec 2023 14:32:56 +0200
Message-ID: <20231227123257.1170590-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227123257.1170590-1-enachman@marvell.com>
References: <20231227123257.1170590-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ewsmlGZgsY4Tm6ZHwAxGaGZEcgmGdzFE
X-Proofpoint-GUID: ewsmlGZgsY4Tm6ZHwAxGaGZEcgmGdzFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add mmc and mmc clock nodes to ac5 and ac5x device tree files

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
index b5e042b8e929..decad14d0db8 100644
--- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -77,7 +77,6 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		dma-ranges;
 
 		internal-regs@7f000000 {
 			#address-cells = <1>;
@@ -204,6 +203,31 @@ gpio1: gpio@18140 {
 			};
 		};
 
+		mmc_dma: mmc-dma-peripherals@80500000 {
+				compatible = "simple-bus";
+				#address-cells = <0x2>;
+				#size-cells = <0x2>;
+				ranges;
+				dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
+				dma-coherent;
+
+				sdhci: mmc@805c0000 {
+					compatible = "marvell,ac5-sdhci",
+						     "marvell,armada-ap806-sdhci";
+					reg = <0x0 0x805c0000 0x0 0x1000>;
+					interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&emmc_clock>, <&cnm_clock>;
+					clock-names = "core", "axi";
+					status = "okay";
+					bus-width = <8>;
+					/*marvell,xenon-phy-slow-mode;*/
+					non-removable;
+					mmc-ddr-1_8v;
+					mmc-hs200-1_8v;
+					mmc-hs400-1_8v;
+				};
+		};
+
 		/*
 		 * Dedicated section for devices behind 32bit controllers so we
 		 * can configure specific DMA mapping for them
@@ -335,5 +359,12 @@ nand_clock: nand-clock {
 			#clock-cells = <0>;
 			clock-frequency = <400000000>;
 		};
+
+		emmc_clock: emmc_clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
+
 	};
 };
-- 
2.25.1


