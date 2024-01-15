Return-Path: <linux-kernel+bounces-26019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F2E82DA04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A490F1C20A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E611755B;
	Mon, 15 Jan 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TLdh6YWm"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23108171BB;
	Mon, 15 Jan 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FCY0x1010889;
	Mon, 15 Jan 2024 14:21:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=xZu5Y1KF2qfLRVwfS+3QyJGle5Zh1Cud7ijy5NKaUqM=; b=TL
	dh6YWm3j3dbM+L32PyLKFEvAI2cVo5eafqYJK8khSgWCxB7qOqCQ6tMFYVPgRVO8
	H6Z/1tljDR16UkNTH5q+XyQWy2xxFrq829k0d2JV1pZwiFpGgLNhhU93AyyfuL/U
	o/mGvBtvkVTPawb0MeNi+ygVaF36cLNiiczNiEqJp1y8mi3AuYsCCNVPZBoSwoKd
	HwXrvlsgbsI+AZA2hDh9WHGzHtFQSsgDwIrGPVE8ch8cY12okejQqtSef0FAHIwa
	SNcStJHSbKYPuTwatpBXTJWzdIVEIPQUxX88M4eHw0hFHd0v7qMQ6Z4B6s6G4+I7
	lTYZBr474n7sZJH5UulQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbh0n0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:21:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 471AC100057;
	Mon, 15 Jan 2024 14:21:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3DC722831A8;
	Mon, 15 Jan 2024 14:21:34 +0100 (CET)
Received: from localhost (10.129.178.37) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 14:21:33 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] arm64: dts: st: add lvds support on stm32mp255
Date: Mon, 15 Jan 2024 14:20:08 +0100
Message-ID: <20240115132009.101718-6-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115132009.101718-1-raphael.gallais-pou@foss.st.com>
References: <20240115132009.101718-1-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

This patch adds LVDS support on stm32mp255.  The LVDS is used on
STM32MP2 as a display interface.  LVDS PLL clock is binded to the LTDC
input clock.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Changes in v3:
	- Change the compatible to show SoC specificity

Changes in v2:
	- Move patch to stm32mp255.dtsi after internal discussions
---
 arch/arm64/boot/dts/st/stm32mp255.dtsi | 17 +++++++++++++++++
 drivers/gpu/drm/stm/lvds.c             |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
index e6fa596211f5..68f60da32126 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -7,3 +7,20 @@
 
 / {
 };
+
+&ltdc {
+	clocks = <&rcc CK_BUS_LTDC>, <&rcc CK_KER_LTDC>, <&lvds 0>;
+	clock-names = "bus", "lcd", "lvds";
+};
+
+&rifsc {
+	lvds: lvds@48060000 {
+		#clock-cells = <0>;
+		compatible = "st,stm32mp25-lvds";
+		reg = <0x48060000 0x2000>;
+		clocks = <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
+		clock-names = "pclk", "ref";
+		resets = <&rcc LVDS_R>;
+		status = "disabled";
+	};
+};
diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index beb8b7e437a0..5808db1a5cdf 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -1198,7 +1198,7 @@ static int lvds_remove(struct platform_device *pdev)
 
 static const struct of_device_id lvds_dt_ids[] = {
 	{
-		.compatible = "st,stm32-lvds",
+		.compatible = "st,stm32mp25-lvds",
 		.data = NULL
 	},
 	{ /* sentinel */ }
-- 
2.25.1


