Return-Path: <linux-kernel+bounces-120489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB1A88D846
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF421F2AF08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4584EB36;
	Wed, 27 Mar 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="Xdsd+7LD"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C025B383AB;
	Wed, 27 Mar 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526288; cv=fail; b=PHVKnaZ3E18YF2HM5Jm4EUTY/QHCO0C8eMahdk/+HPy+A2/DRCB1FKvF6JKUgptlOYO9Ck5EJ8uWBlLaxLMPAyuSgdb888c3gnsuK2sJ27+j8d1Ndg2EDYcEAEtyp/zDuBf4KJX1oXR0dhrF9Uzu98pcFgn8foHZvpTaKlZ+v9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526288; c=relaxed/simple;
	bh=PjwHqFRuj8aPyb4++sZtWaJzIk7SbqgR7UiFXIoi2H8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZYnIFu1Qof2tF37F9yszoeFGs8zIpeaT5vk2Z/qjcSuDVMPh60W7DLHkz4t6oW3DBfaQJpraSuIvIR+R27aB1dTZ/Gz+ZM9SXCy6LRqIMpSvRSGwi1ULMC9WB3BkROALLKPcxXjInnayOI514yilUHhulSMYCCK0Y34mrU06Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=Xdsd+7LD; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCEBxd5SFwZRB0QsNexfYzbyOAmKIGaVLrB3ATfB+ESsnh07q0umNfLSRBzkYytOQY4iE/byuWxHNvgdyoUSyN8GeI1fuqMV/KKVmkcyS5tSMl28koYSMcXAoSUZa9GoLu9AxNN5RBJzG7JNlG9+UNxtPdw+/+Q8oU3dV3lml8rY8lLQ7R8o5VOd+SRELCUzIBkuAPQxbMbqPgZPSKt1qx1rVOHYG+mlrkLc++9oU5pQRqkQpzYsoVZa/+Iwxd+p5L5C9l1QPzlIexGY8VavrqV3iHfQqrXEUTawpUPj76kNqnCOYJqXAj95qEYwuzJ54XP8hYqzoJomQjCZ1FEYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrnbJNKVlfyIeW83M2EuGIEuP7JCFQkIKLttLLbVir8=;
 b=hfEZk9MHntDCSTTPc82vFKemaP03Toh5OP1DwkZTdEXz8OIZrVNzVHW7ankEGSYJQVcshkQXO02tCTxg99UKcdn4Ma/6vebXpAtseMaERUhPj05srSqD8oN1Y7YVp9G5kWDvfegjxQUBJ7Zxu/F7CTMql/Ny+lgkgWh/L8IlHFwgx0OOais5cPwQw2xO99V9sXCi4ayVbdvu0O2/0Ik29afh4NABdlgQGqOnyVt+KrBMM2J1pDGBILEr4ZD0rame0jgPpM3rAqlGNx3nWrylJIVD58XiCjR4Gj8phRyqUaneBjkhrG+Vw+knRJ2RRSa8hQo9rA8cSJNs+oMSNjOMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrnbJNKVlfyIeW83M2EuGIEuP7JCFQkIKLttLLbVir8=;
 b=Xdsd+7LDd/ljB+w3oBAUxPgIcCxM30y8a4ev8CFVPNzXJOm0nIPh2vmbfVCtg02B6C8D8ExFzq2L1K3h6HTGPXLD+3YT0qSDuffmG8FVavY78LuB8T9DjCjNAam36w+cEszMyBGoi9RIkin4cD+BYqnFa8uH82OjxODhwLzLuqQ=
Received: from PSBPR02CA0008.apcprd02.prod.outlook.com (2603:1096:301::18) by
 SEYPR03MB7760.apcprd03.prod.outlook.com (2603:1096:101:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 07:58:01 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::8f) by PSBPR02CA0008.outlook.office365.com
 (2603:1096:301::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 07:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 07:58:01 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 27 Mar
 2024 15:57:59 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 27 Mar
 2024 15:57:59 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Mar 2024 15:57:59 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>,
	<CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>,
	<scott6986@gmail.com>, <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v5 2/2] ASoC: nau8325: new driver
Date: Wed, 27 Mar 2024 15:57:55 +0800
Message-ID: <20240327075755.3410381-3-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327075755.3410381-1-wtli@nuvoton.com>
References: <20240327075755.3410381-1-wtli@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|SEYPR03MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 439925a6-5375-498b-c2ec-08dc4e339fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeyRk7bqZHduNab5Q+eMQW72fTdrwc4/Z3cH9vRatXFs4zNxWI65q78Agf7Hr3tr4mx/dDNHOknTfd/7k0dHKVzBCqmtwPwcYwEMpEtu0hcQsLRZ9i9FNdu3Mm9qaUUE7m5mtcPR71uG70+OgdXCW4mjNIdbikw+vVXY4OLSm2lTTkYtS/T1NYSb9hgSVWFbqu+JPt23xk3TFp5/0wv6VaGQ9HKbz9CPKugAfq2f1G3oxDOy2tbuKlQ4wzvz6d7+iWnOmuHSSHu14W5ab2FzHvIYJe6zPPulk+aN0jGXU1dkD5m/VOnvcGbEZ4WOBp+sOetY7W1oS7zvCoX5aUZrtjwWpnuuENp9XlQ0F2j01QmJGK3XwOZXQl+3x7cUy/EqoPwHaOuHRUsijZnwj/4cqJfkHNGUMTxcRMtEw7NLYw+GEQ0IGh9gsUGc0hZcqfI2WZEFvbKQZmo2UFc0Mu6Ugrxzdc3lR2jOEUVkJUC42WpRqKZr2mXCrygIT4PLtnc5HrHxQV60XYe5Gd6MI3k7ccpxm4IYI/p9JaKkUIiRpdjLPghWXkZIZApQyQa/tRH0EiXuJmF5aNB2+tKp8jEpKPDcL0jri1ALFQbS055s/nkP5OR/RrYGCRfXubIDpfPSsGI+zuUrV/ZmYFJr8fpng73PMcUHIC+AdgOThYRgt6nfBKwWxGZR6toPZ6BNdLiL/qcq1WwtlC0OvhHZy5YItWzTEzD0s2wxAAy2fOFUI8ohRD6XRdRnhSS0CypM/pPO
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:58:01.0029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439925a6-5375-498b-c2ec-08dc4e339fc1
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7760

The driver is for amplifiers NAU8325 of Nuvoton Technology Corporation.
The NAU8325 is a stereo high efficiency filter-free Class-D audio
amplifier, which is capable of driving a 4ohm load with up to 3W output
power.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8325.c | 893 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8325.h | 391 ++++++++++++++++
 2 files changed, 1284 insertions(+)
 create mode 100644 sound/soc/codecs/nau8325.c
 create mode 100644 sound/soc/codecs/nau8325.h

diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
new file mode 100644
index 000000000000..a00a30364c89
--- /dev/null
+++ b/sound/soc/codecs/nau8325.c
@@ -0,0 +1,893 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// nau8325.c -- Nuvoton NAU8325 audio codec driver
+//
+// Copyright 2023 Nuvoton Technology Crop.
+// Author: Seven Lee <WTLI@nuvoton.com>
+//	   David Lin <CTLIN0@nuvoton.com>
+//
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+#include "nau8325.h"
+
+/* Range of Master Clock MCLK (Hz) */
+#define MASTER_CLK_MAX 49152000
+#define MASTER_CLK_MIN 2048000
+
+/* scaling for MCLK source */
+#define CLK_PROC_BYPASS (-1)
+
+/* the maximum CLK_DAC */
+#define CLK_DA_AD_MAX 6144000
+
+/* from MCLK input */
+#define MCLK_SRC 4
+
+static const struct nau8325_src_attr mclk_n1_div[] = {
+	{ 1, 0x0 },
+	{ 2, 0x1 },
+	{ 3, 0x2 },
+};
+
+/* over sampling rate */
+static const struct nau8325_osr_attr osr_dac_sel[] = {
+	{ 64, 2 },	/* OSR 64, SRC 1/4 */
+	{ 256, 0 },	/* OSR 256, SRC 1 */
+	{ 128, 1 },	/* OSR 128, SRC 1/2 */
+	{ 0, 0 },
+	{ 32, 3 },	/* OSR 32, SRC 1/8 */
+};
+
+static const struct nau8325_src_attr mclk_n2_div[] = {
+	{ 0, 0x0 },
+	{ 1, 0x1 },
+	{ 2, 0x2 },
+	{ 3, 0x3 },
+	{ 4, 0x4 },
+};
+
+static const struct nau8325_src_attr mclk_n3_mult[] = {
+	{ 0, 0x1 },
+	{ 1, 0x2 },
+	{ 2, 0x3 },
+	{ 3, 0x4 },
+};
+
+/* Sample Rate and MCLK_SRC selections */
+static const struct nau8325_srate_attr target_srate_table[] = {
+	/* { FS, range, max, { MCLK source }} */
+	{ 48000, 2, true, { 12288000, 19200000, 24000000 } },
+	{ 16000, 1, false, { 4096000, 6400000, 8000000 } },
+	{ 8000, 0, false, { 2048000, 3200000, 4000000 }},
+	{ 44100, 2, true, { 11289600, 17640000, 22050000 }},
+	{ 64000, 3, false, { 16384000, 25600000, 32000000 } },
+	{ 96000, 3, true, { 24576000, 38400000, 48000000 } },
+	{ 12000, 0, true, { 3072000, 4800000, 6000000 } },
+	{ 24000, 1, true, { 6144000, 9600000, 12000000 } },
+	{ 32000, 2, false, { 8192000, 12800000, 16000000 } },
+};
+
+static const struct reg_default nau8325_reg_defaults[] = {
+	{ NAU8325_R00_HARDWARE_RST, 0x0000 },
+	{ NAU8325_R01_SOFTWARE_RST, 0x0000 },
+	{ NAU8325_R03_CLK_CTRL, 0x0000 },
+	{ NAU8325_R04_ENA_CTRL, 0x0000 },
+	{ NAU8325_R05_INTERRUPT_CTRL, 0x007f },
+	{ NAU8325_R09_IRQOUT, 0x0000 },
+	{ NAU8325_R0A_IO_CTRL, 0x0000 },
+	{ NAU8325_R0B_PDM_CTRL, 0x0000 },
+	{ NAU8325_R0C_TDM_CTRL, 0x0000 },
+	{ NAU8325_R0D_I2S_PCM_CTRL1, 0x000a },
+	{ NAU8325_R0E_I2S_PCM_CTRL2, 0x0000 },
+	{ NAU8325_R0F_L_TIME_SLOT, 0x0000 },
+	{ NAU8325_R10_R_TIME_SLOT, 0x0000 },
+	{ NAU8325_R11_HPF_CTRL, 0x0000 },
+	{ NAU8325_R12_MUTE_CTRL, 0x0000 },
+	{ NAU8325_R13_DAC_VOLUME, 0xf3f3 },
+	{ NAU8325_R29_DAC_CTRL1, 0x0081 },
+	{ NAU8325_R2A_DAC_CTRL2, 0x0000 },
+	{ NAU8325_R2C_ALC_CTRL1, 0x000e },
+	{ NAU8325_R2D_ALC_CTRL2, 0x8400 },
+	{ NAU8325_R2E_ALC_CTRL3, 0x0000 },
+	{ NAU8325_R2F_ALC_CTRL4, 0x003f },
+	{ NAU8325_R40_CLK_DET_CTRL, 0xa801 },
+	{ NAU8325_R50_MIXER_CTRL, 0x0000 },
+	{ NAU8325_R55_MISC_CTRL, 0x0000 },
+	{ NAU8325_R60_BIAS_ADJ, 0x0000 },
+	{ NAU8325_R61_ANALOG_CONTROL_1, 0x0000 },
+	{ NAU8325_R62_ANALOG_CONTROL_2, 0x0000 },
+	{ NAU8325_R63_ANALOG_CONTROL_3, 0x0000 },
+	{ NAU8325_R64_ANALOG_CONTROL_4, 0x0000 },
+	{ NAU8325_R65_ANALOG_CONTROL_5, 0x0000 },
+	{ NAU8325_R66_ANALOG_CONTROL_6, 0x0000 },
+	{ NAU8325_R69_CLIP_CTRL, 0x0000 },
+	{ NAU8325_R73_RDAC, 0x0008 },
+};
+
+static bool nau8325_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8325_R02_DEVICE_ID ... NAU8325_R06_INT_CLR_STATUS:
+	case NAU8325_R09_IRQOUT ... NAU8325_R13_DAC_VOLUME:
+	case NAU8325_R1D_DEBUG_READ1:
+	case NAU8325_R1F_DEBUG_READ2:
+	case NAU8325_R22_DEBUG_READ3:
+	case NAU8325_R29_DAC_CTRL1 ... NAU8325_R2A_DAC_CTRL2:
+	case NAU8325_R2C_ALC_CTRL1 ... NAU8325_R2F_ALC_CTRL4:
+	case NAU8325_R40_CLK_DET_CTRL:
+	case NAU8325_R49_TEST_STATUS ... NAU8325_R4A_ANALOG_READ:
+	case NAU8325_R50_MIXER_CTRL:
+	case NAU8325_R55_MISC_CTRL:
+	case NAU8325_R60_BIAS_ADJ ... NAU8325_R66_ANALOG_CONTROL_6:
+	case NAU8325_R69_CLIP_CTRL:
+	case NAU8325_R73_RDAC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8325_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8325_R00_HARDWARE_RST:
+	case NAU8325_R03_CLK_CTRL ... NAU8325_R06_INT_CLR_STATUS:
+	case NAU8325_R09_IRQOUT ... NAU8325_R13_DAC_VOLUME:
+	case NAU8325_R29_DAC_CTRL1 ... NAU8325_R2A_DAC_CTRL2:
+	case NAU8325_R2C_ALC_CTRL1 ... NAU8325_R2F_ALC_CTRL4:
+	case NAU8325_R40_CLK_DET_CTRL:
+	case NAU8325_R50_MIXER_CTRL:
+	case NAU8325_R55_MISC_CTRL:
+	case NAU8325_R60_BIAS_ADJ ... NAU8325_R66_ANALOG_CONTROL_6:
+	case NAU8325_R69_CLIP_CTRL:
+	case NAU8325_R73_RDAC:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8325_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8325_R00_HARDWARE_RST ... NAU8325_R02_DEVICE_ID:
+	case NAU8325_R06_INT_CLR_STATUS:
+	case NAU8325_R1D_DEBUG_READ1:
+	case NAU8325_R1F_DEBUG_READ2:
+	case NAU8325_R22_DEBUG_READ3:
+	case NAU8325_R4A_ANALOG_READ:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const char * const nau8325_dac_oversampl[] = {
+	"64", "256", "128", "", "32" };
+
+static const struct soc_enum nau8325_dac_oversampl_enum =
+	SOC_ENUM_SINGLE(NAU8325_R29_DAC_CTRL1, NAU8325_DAC_OVERSAMPLE_SFT,
+			ARRAY_SIZE(nau8325_dac_oversampl),
+			nau8325_dac_oversampl);
+
+static const DECLARE_TLV_DB_MINMAX_MUTE(dac_vol_tlv, -8000, 600);
+
+static const struct snd_kcontrol_new nau8325_snd_controls[] = {
+	SOC_ENUM("DAC Oversampling Rate", nau8325_dac_oversampl_enum),
+	SOC_DOUBLE_TLV("Speaker Volume", NAU8325_R13_DAC_VOLUME,
+		       NAU8325_DAC_VOLUME_L_SFT, NAU8325_DAC_VOLUME_R_SFT,
+		       NAU8325_DAC_VOLUME_R_EN, 0, dac_vol_tlv),
+	SOC_SINGLE("ALC Max Gain", NAU8325_R2C_ALC_CTRL1,
+		   NAU8325_ALC_MAXGAIN_SFT, NAU8325_ALC_MAXGAIN_MAX, 0),
+	SOC_SINGLE("ALC Min Gain", NAU8325_R2C_ALC_CTRL1,
+		   NAU8325_ALC_MINGAIN_SFT, NAU8325_ALC_MINGAIN_MAX, 0),
+	SOC_SINGLE("ALC Decay Timer", NAU8325_R2D_ALC_CTRL2,
+		   NAU8325_ALC_DCY_SFT, NAU8325_ALC_DCY_MAX, 0),
+	SOC_SINGLE("ALC Attack Timer", NAU8325_R2D_ALC_CTRL2,
+		   NAU8325_ALC_ATK_SFT, NAU8325_ALC_ATK_MAX, 0),
+	SOC_SINGLE("ALC Hold Time", NAU8325_R2D_ALC_CTRL2,
+		   NAU8325_ALC_HLD_SFT, NAU8325_ALC_HLD_MAX, 0),
+	SOC_SINGLE("ALC Target Level", NAU8325_R2D_ALC_CTRL2,
+		   NAU8325_ALC_LVL_SFT, NAU8325_ALC_LVL_MAX, 0),
+	SOC_SINGLE("ALC Enable Switch", NAU8325_R2E_ALC_CTRL3,
+		   NAU8325_ALC_EN_SFT, 1, 0),
+};
+
+static int nau8325_dac_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8325->regmap, NAU8325_R12_MUTE_CTRL,
+				   NAU8325_SOFT_MUTE, 0);
+		msleep(30);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		/* Soft mute the output to prevent the pop noise. */
+		regmap_update_bits(nau8325->regmap, NAU8325_R12_MUTE_CTRL,
+				   NAU8325_SOFT_MUTE, NAU8325_SOFT_MUTE);
+		msleep(30);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8325_powerup_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+
+	if (nau8325->clock_detection)
+		return 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(nau8325->regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_PWRUP_DFT, NAU8325_PWRUP_DFT);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(nau8325->regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_PWRUP_DFT, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget nau8325_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("Power Up", SND_SOC_NOPM, 0, 0,
+			    nau8325_powerup_event, SND_SOC_DAPM_POST_PMU |
+			    SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DACL", NULL, NAU8325_R04_ENA_CTRL,
+			   NAU8325_DAC_LEFT_CH_EN_SFT, 0, nau8325_dac_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC_E("DACR", NULL, NAU8325_R04_ENA_CTRL,
+			   NAU8325_DAC_RIGHT_CH_EN_SFT, 0, nau8325_dac_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_AIF_IN("AIFRX", "Playback", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("SPKL"),
+	SND_SOC_DAPM_OUTPUT("SPKR"),
+};
+
+static const struct snd_soc_dapm_route nau8325_dapm_routes[] = {
+	{ "DACL", NULL, "Power Up" },
+	{ "DACR", NULL, "Power Up" },
+
+	{ "DACL", NULL, "AIFRX" },
+	{ "DACR", NULL, "AIFRX" },
+	{ "SPKL", NULL, "DACL" },
+	{ "SPKR", NULL, "DACR" },
+};
+
+static int nau8325_srate_clk_apply(struct nau8325 *nau8325,
+				   const struct nau8325_srate_attr *srate_table,
+				   int n1_sel, int mclk_mult_sel, int n2_sel)
+{
+	if (!srate_table || n2_sel < 0 || n2_sel >= ARRAY_SIZE(mclk_n2_div) ||
+	    n1_sel < 0 || n1_sel >= ARRAY_SIZE(mclk_n1_div)) {
+		dev_dbg(nau8325->dev, "The CLK isn't supported.");
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8325->regmap, NAU8325_R40_CLK_DET_CTRL,
+			   NAU8325_REG_SRATE_MASK | NAU8325_REG_DIV_MAX,
+			   (srate_table->range << NAU8325_REG_SRATE_SFT) |
+			   (srate_table->max ? NAU8325_REG_DIV_MAX : 0));
+	regmap_update_bits(nau8325->regmap, NAU8325_R03_CLK_CTRL,
+			   NAU8325_MCLK_SRC_MASK, mclk_n2_div[n2_sel].val);
+	regmap_update_bits(nau8325->regmap, NAU8325_R03_CLK_CTRL,
+			   NAU8325_CLK_MUL_SRC_MASK,
+			   mclk_n1_div[n1_sel].val << NAU8325_CLK_MUL_SRC_SFT);
+
+	if (mclk_mult_sel != CLK_PROC_BYPASS) {
+		regmap_update_bits(nau8325->regmap, NAU8325_R03_CLK_CTRL,
+				   NAU8325_MCLK_SEL_MASK,
+				   mclk_n3_mult[mclk_mult_sel].val <<
+				   NAU8325_MCLK_SEL_SFT);
+	} else {
+		regmap_update_bits(nau8325->regmap, NAU8325_R03_CLK_CTRL,
+				   NAU8325_MCLK_SEL_MASK, 0);
+	}
+
+	switch (mclk_mult_sel) {
+	case 2:
+		regmap_update_bits(nau8325->regmap, NAU8325_R65_ANALOG_CONTROL_5,
+				   NAU8325_MCLK4XEN_EN, NAU8325_MCLK4XEN_EN);
+		break;
+	case 3:
+		regmap_update_bits(nau8325->regmap, NAU8325_R65_ANALOG_CONTROL_5,
+				   NAU8325_MCLK4XEN_EN | NAU8325_MCLK8XEN_EN,
+				   NAU8325_MCLK4XEN_EN | NAU8325_MCLK8XEN_EN);
+		break;
+	default:
+		regmap_update_bits(nau8325->regmap, NAU8325_R65_ANALOG_CONTROL_5,
+				   NAU8325_MCLK4XEN_EN | NAU8325_MCLK8XEN_EN, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static int nau8325_clksrc_n2(struct nau8325 *nau8325,
+			     const struct nau8325_srate_attr *srate_table,
+			     int mclk, int *n2_sel)
+{
+	int i, mclk_src, ratio;
+
+	ratio = NAU8325_MCLK_FS_RATIO_NUM;
+	for (i = 0; i < ARRAY_SIZE(mclk_n2_div); i++) {
+		mclk_src = mclk >> mclk_n2_div[i].param;
+		if (srate_table->mclk_src[NAU8325_MCLK_FS_RATIO_256] == mclk_src) {
+			ratio = NAU8325_MCLK_FS_RATIO_256;
+			break;
+		} else if (srate_table->mclk_src[NAU8325_MCLK_FS_RATIO_400] == mclk_src) {
+			ratio = NAU8325_MCLK_FS_RATIO_400;
+			break;
+		} else if (srate_table->mclk_src[NAU8325_MCLK_FS_RATIO_500] == mclk_src) {
+			ratio = NAU8325_MCLK_FS_RATIO_500;
+			break;
+		}
+	}
+	if (ratio != NAU8325_MCLK_FS_RATIO_NUM)
+		*n2_sel = i;
+
+	return ratio;
+}
+
+static const struct nau8325_srate_attr *target_srate_attribute(int srate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(target_srate_table); i++)
+		if (target_srate_table[i].fs == srate)
+			break;
+
+	if (i == ARRAY_SIZE(target_srate_table))
+		goto proc_err;
+
+	return &target_srate_table[i];
+
+proc_err:
+	return NULL;
+}
+
+static int nau8325_clksrc_choose(struct nau8325 *nau8325,
+				 const struct nau8325_srate_attr **srate_table,
+				 int *n1_sel, int *mult_sel, int *n2_sel)
+{
+	int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max;
+
+	if (!nau8325->mclk || !nau8325->fs)
+		goto proc_err;
+
+	/* select sampling rate and MCLK_SRC */
+	*srate_table = target_srate_attribute(nau8325->fs);
+	if (!*srate_table)
+		goto proc_err;
+
+	/* First check clock from MCLK directly, decide N2 for MCLK_SRC.
+	 * If not good, consider 1/N1 and Multiplier.
+	 */
+	ratio = nau8325_clksrc_n2(nau8325, *srate_table, nau8325->mclk, n2_sel);
+	if (ratio != NAU8325_MCLK_FS_RATIO_NUM) {
+		*n1_sel = 0;
+		*mult_sel = CLK_PROC_BYPASS;
+		*n2_sel = MCLK_SRC;
+		goto proc_done;
+	}
+
+	/* Get MCLK_SRC through 1/N, Multiplier, and then 1/N2. */
+	mclk_max = 0;
+	for (i = 0; i < ARRAY_SIZE(mclk_n1_div); i++) {
+		for (j = 0; j < ARRAY_SIZE(mclk_n3_mult); j++) {
+			mclk = nau8325->mclk << mclk_n3_mult[j].param;
+			mclk = mclk / mclk_n1_div[i].param;
+			ratio = nau8325_clksrc_n2(nau8325,
+						  *srate_table, mclk, n2_sel);
+			if (ratio != NAU8325_MCLK_FS_RATIO_NUM &&
+			    (mclk_max < mclk || i > *n1_sel)) {
+				mclk_max = mclk;
+				n2_max = *n2_sel;
+				*n1_sel = i;
+				*mult_sel = j;
+				ratio_sel = ratio;
+					goto proc_done;
+			}
+		}
+	}
+	if (mclk_max) {
+		*n2_sel = n2_max;
+		ratio = ratio_sel;
+		goto proc_done;
+	}
+
+proc_err:
+	dev_dbg(nau8325->dev, "The MCLK %d is invalid. It can't get MCLK_SRC of 256/400/500 FS (%d)",
+		nau8325->mclk, nau8325->fs);
+	return -EINVAL;
+proc_done:
+	dev_dbg(nau8325->dev, "nau8325->fs=%d,range=0x%x, %s, (n1,mu,n2,dmu):(%d,%d,%d), MCLK_SRC=%uHz (%d)",
+		nau8325->fs, (*srate_table)->range,
+		(*srate_table)->max ? "MAX" : "MIN",
+		*n1_sel == CLK_PROC_BYPASS ?
+		CLK_PROC_BYPASS : mclk_n1_div[*n1_sel].param,
+		*mult_sel == CLK_PROC_BYPASS ?
+		CLK_PROC_BYPASS : 1 << mclk_n3_mult[*mult_sel].param,
+		1 << mclk_n2_div[*n2_sel].param,
+		(*srate_table)->mclk_src[ratio],
+		(*srate_table)->mclk_src[ratio] / nau8325->fs);
+
+	return 0;
+}
+
+static int nau8325_clock_config(struct nau8325 *nau8325)
+{
+	const struct nau8325_srate_attr *srate_table;
+	int ret, n1_sel, mult_sel, n2_sel;
+
+	ret = nau8325_clksrc_choose(nau8325, &srate_table,
+				    &n1_sel, &mult_sel, &n2_sel);
+	if (ret)
+		goto err;
+
+	ret = nau8325_srate_clk_apply(nau8325, srate_table,
+				      n1_sel, mult_sel, n2_sel);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+
+static const struct nau8325_osr_attr *nau8325_get_osr(struct nau8325 *nau8325)
+{
+	unsigned int osr;
+
+	regmap_read(nau8325->regmap, NAU8325_R29_DAC_CTRL1, &osr);
+	osr &= NAU8325_DAC_OVERSAMPLE_MASK;
+	if (osr >= ARRAY_SIZE(osr_dac_sel))
+		return NULL;
+
+	return &osr_dac_sel[osr];
+}
+
+static int nau8325_dai_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+	const struct nau8325_osr_attr *osr;
+
+	osr = nau8325_get_osr(nau8325);
+	if (!osr || !osr->osr)
+		return -EINVAL;
+
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_RATE,
+					    0, CLK_DA_AD_MAX / osr->osr);
+}
+
+static int nau8325_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+	unsigned int val_len = 0;
+	const struct nau8325_osr_attr *osr;
+	int ret;
+
+	nau8325->fs = params_rate(params);
+	osr = nau8325_get_osr(nau8325);
+	if (!osr || !osr->osr || nau8325->fs * osr->osr > CLK_DA_AD_MAX) {
+		ret = -EINVAL;
+		goto err;
+	}
+	regmap_update_bits(nau8325->regmap, NAU8325_R03_CLK_CTRL,
+			   NAU8325_CLK_DAC_SRC_MASK,
+			   osr->clk_src << NAU8325_CLK_DAC_SRC_SFT);
+
+	ret = nau8325_clock_config(nau8325);
+	if (ret)
+		goto err;
+
+	switch (params_width(params)) {
+	case 16:
+		val_len |= NAU8325_I2S_DL_16;
+		break;
+	case 20:
+		val_len |= NAU8325_I2S_DL_20;
+		break;
+	case 24:
+		val_len |= NAU8325_I2S_DL_24;
+		break;
+	case 32:
+		val_len |= NAU8325_I2S_DL_32;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+	regmap_update_bits(nau8325->regmap, NAU8325_R0D_I2S_PCM_CTRL1,
+			   NAU8325_I2S_DL_MASK, val_len);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static int nau8325_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+	unsigned int ctrl1_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1_val |= NAU8325_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl1_val |= NAU8325_I2S_DF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1_val |= NAU8325_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ctrl1_val |= NAU8325_I2S_DF_RIGTH;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1_val |= NAU8325_I2S_DF_PCM_AB;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl1_val |= NAU8325_I2S_DF_PCM_AB;
+		ctrl1_val |= NAU8325_I2S_PCMB_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8325->regmap, NAU8325_R0D_I2S_PCM_CTRL1,
+			   NAU8325_I2S_DF_MASK | NAU8325_I2S_BP_MASK |
+			   NAU8325_I2S_PCMB_EN, ctrl1_val);
+
+	return 0;
+}
+
+static int nau8325_set_sysclk(struct snd_soc_component *component, int clk_id,
+			      int source, unsigned int freq, int dir)
+{
+	struct nau8325 *nau8325 = snd_soc_component_get_drvdata(component);
+
+	if (freq < MASTER_CLK_MIN || freq > MASTER_CLK_MAX) {
+		dev_dbg(nau8325->dev, "MCLK exceeds the range, MCLK:%d", freq);
+		return -EINVAL;
+	}
+
+	nau8325->mclk = freq;
+	dev_dbg(nau8325->dev, "MCLK %dHz", nau8325->mclk);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver nau8325_component_driver = {
+	.set_sysclk = nau8325_set_sysclk,
+	.suspend_bias_off = true,
+	.controls = nau8325_snd_controls,
+	.num_controls = ARRAY_SIZE(nau8325_snd_controls),
+	.dapm_widgets = nau8325_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(nau8325_dapm_widgets),
+	.dapm_routes = nau8325_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(nau8325_dapm_routes),
+};
+
+static const struct snd_soc_dai_ops nau8325_dai_ops = {
+	.startup = nau8325_dai_startup,
+	.hw_params = nau8325_hw_params,
+	.set_fmt = nau8325_set_fmt,
+};
+
+#define NAU8325_RATES SNDRV_PCM_RATE_8000_96000
+#define NAU8325_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+	 | SNDRV_PCM_FMTBIT_S24_3LE)
+
+static struct snd_soc_dai_driver nau8325_dai = {
+	.name = NAU8325_CODEC_DAI,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = NAU8325_RATES,
+		.formats = NAU8325_FORMATS,
+	},
+	.ops = &nau8325_dai_ops,
+};
+
+static const struct regmap_config nau8325_regmap_config = {
+	.reg_bits = NAU8325_REG_ADDR_LEN,
+	.val_bits = NAU8325_REG_DATA_LEN,
+
+	.max_register = NAU8325_REG_MAX,
+	.readable_reg = nau8325_readable_reg,
+	.writeable_reg = nau8325_writeable_reg,
+	.volatile_reg = nau8325_volatile_reg,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = nau8325_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8325_reg_defaults),
+};
+
+static void nau8325_reset_chip(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8325_R00_HARDWARE_RST, 0x0001);
+	regmap_write(regmap, NAU8325_R00_HARDWARE_RST, 0x0000);
+}
+
+static void nau8325_init_regs(struct nau8325 *nau8325)
+{
+	struct regmap *regmap = nau8325->regmap;
+	struct device *dev = nau8325->dev;
+
+	/* set ALC parameters */
+	regmap_update_bits(regmap, NAU8325_R2C_ALC_CTRL1,
+			   NAU8325_ALC_MAXGAIN_MASK,
+			   0x7 << NAU8325_ALC_MAXGAIN_SFT);
+	regmap_update_bits(regmap, NAU8325_R2D_ALC_CTRL2,
+			   NAU8325_ALC_DCY_MASK | NAU8325_ALC_ATK_MASK |
+			   NAU8325_ALC_HLD_MASK, (0x5 << NAU8325_ALC_DCY_SFT) |
+			   (0x3 << NAU8325_ALC_ATK_SFT) |
+			   (0x5 << NAU8325_ALC_HLD_SFT));
+	/* Enable ALC to avoid signal distortion when battery low. */
+	if (nau8325->alc_enable)
+		regmap_update_bits(regmap, NAU8325_R2E_ALC_CTRL3,
+				   NAU8325_ALC_EN, NAU8325_ALC_EN);
+	if (nau8325->clock_detection)
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_CLKPWRUP_DIS |
+				   NAU8325_PWRUP_DFT, 0);
+	else
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_CLKPWRUP_DIS | NAU8325_PWRUP_DFT,
+				   NAU8325_CLKPWRUP_DIS);
+	if (nau8325->clock_det_data)
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_APWRUP_EN, NAU8325_APWRUP_EN);
+	else
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				   NAU8325_APWRUP_EN, 0);
+
+	/* DAC Reference Voltage Setting */
+	switch (nau8325->dac_vref_microvolt) {
+	case 1800000:
+		regmap_update_bits(regmap, NAU8325_R73_RDAC,
+			NAU8325_DACVREFSEL_MASK, 0 << NAU8325_DACVREFSEL_SFT);
+		break;
+	case 2700000:
+		regmap_update_bits(regmap, NAU8325_R73_RDAC,
+			NAU8325_DACVREFSEL_MASK, 1 << NAU8325_DACVREFSEL_SFT);
+		break;
+	case 2880000:
+		regmap_update_bits(regmap, NAU8325_R73_RDAC,
+			NAU8325_DACVREFSEL_MASK, 2 << NAU8325_DACVREFSEL_SFT);
+		break;
+	case 3060000:
+		regmap_update_bits(regmap, NAU8325_R73_RDAC,
+			NAU8325_DACVREFSEL_MASK, 3 << NAU8325_DACVREFSEL_SFT);
+		break;
+	default:
+		dev_dbg(dev, "Invalid dac-vref-microvolt %d", nau8325->dac_vref_microvolt);
+
+	}
+
+	/* DAC Reference Voltage Decoupling Capacitors. */
+	regmap_update_bits(regmap, NAU8325_R63_ANALOG_CONTROL_3,
+			   NAU8325_CLASSD_COARSE_GAIN_MASK, 0x4);
+	/* Auto-Att Min Gain 0dB, Class-D N Driver Slew Rate -25%. */
+	regmap_update_bits(regmap, NAU8325_R64_ANALOG_CONTROL_4,
+			   NAU8325_CLASSD_SLEWN_MASK, 0x7);
+
+	/* VMID Tieoff (VMID Resistor Selection) */
+	switch (nau8325->vref_impedance_ohms) {
+	case 0:
+		regmap_update_bits(regmap, NAU8325_R60_BIAS_ADJ,
+			NAU8325_BIAS_VMID_SEL_MASK, 0 << NAU8325_BIAS_VMID_SEL_SFT);
+		break;
+	case 25000:
+		regmap_update_bits(regmap, NAU8325_R60_BIAS_ADJ,
+			NAU8325_BIAS_VMID_SEL_MASK, 1 << NAU8325_BIAS_VMID_SEL_SFT);
+		break;
+	case 125000:
+		regmap_update_bits(regmap, NAU8325_R60_BIAS_ADJ,
+			NAU8325_BIAS_VMID_SEL_MASK, 2 << NAU8325_BIAS_VMID_SEL_SFT);
+		break;
+	case 2500:
+		regmap_update_bits(regmap, NAU8325_R60_BIAS_ADJ,
+			NAU8325_BIAS_VMID_SEL_MASK, 3 << NAU8325_BIAS_VMID_SEL_SFT);
+		break;
+	default:
+		dev_dbg(dev, "Invalid vref-impedance-ohms %d", nau8325->vref_impedance_ohms);
+	}
+
+
+	/* enable VMID, BIAS, DAC, DCA CLOCK, Voltage/Current Amps
+	 */
+	regmap_update_bits(regmap, NAU8325_R61_ANALOG_CONTROL_1,
+		NAU8325_DACEN_MASK | NAU8325_DACCLKEN_MASK |
+		NAU8325_DACEN_R_MASK | NAU8325_DACCLKEN_R_MASK |
+		NAU8325_CLASSDEN_MASK | NAU8325_VMDFSTENB_MASK |
+		NAU8325_BIASEN_MASK | NAU8325_VMIDEN_MASK,
+		(0x1 << NAU8325_DACEN_SFT) |
+		(0x1 << NAU8325_DACCLKEN_SFT) |
+		(0x1 << NAU8325_DACEN_R_SFT) |
+		(0x1 << NAU8325_DACCLKEN_R_SFT) |
+		(0x1 << NAU8325_CLASSDEN_SFT) |
+		(0x1 << NAU8325_VMDFSTENB_SFT) |
+		(0x1 << NAU8325_BIASEN_SFT) | 0x3);
+
+	/* Enable ALC to avoid signal distortion when battery low. */
+	if (nau8325->alc_enable)
+		regmap_update_bits(regmap, NAU8325_R2E_ALC_CTRL3,
+				NAU8325_ALC_EN, NAU8325_ALC_EN);
+	if (nau8325->clock_det_data)
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				NAU8325_APWRUP_EN, NAU8325_APWRUP_EN);
+	else
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				NAU8325_APWRUP_EN, 0);
+	if (nau8325->clock_detection)
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				NAU8325_CLKPWRUP_DIS |
+				NAU8325_PWRUP_DFT, 0);
+	else
+		regmap_update_bits(regmap, NAU8325_R40_CLK_DET_CTRL,
+				NAU8325_CLKPWRUP_DIS | NAU8325_PWRUP_DFT,
+				NAU8325_CLKPWRUP_DIS);
+	regmap_update_bits(regmap, NAU8325_R29_DAC_CTRL1,
+		NAU8325_DAC_OVERSAMPLE_MASK,
+		NAU8325_DAC_OVERSAMPLE_128);
+}
+
+static void nau8325_print_device_properties(struct nau8325 *nau8325)
+{
+	struct device *dev = nau8325->dev;
+
+	dev_dbg(dev, "vref-impedance-ohms:     %d", nau8325->vref_impedance_ohms);
+	dev_dbg(dev, "dac-vref-microvolt:      %d", nau8325->dac_vref_microvolt);
+	dev_dbg(dev, "alc-enable:              %d", nau8325->alc_enable);
+	dev_dbg(dev, "clock-det-data:          %d", nau8325->clock_det_data);
+	dev_dbg(dev, "clock-detection-disable: %d", nau8325->clock_detection);
+}
+
+static int nau8325_read_device_properties(struct device *dev,
+					  struct nau8325 *nau8325)
+{
+	int ret;
+
+	nau8325->alc_enable =
+		device_property_read_bool(dev, "nuvoton,alc-enable");
+	nau8325->clock_det_data =
+		device_property_read_bool(dev, "nuvoton,clock-det-data");
+	nau8325->clock_detection =
+		!device_property_read_bool(dev,	"nuvoton,clock-detection-disable");
+
+	ret = device_property_read_u32(dev, "nuvoton,vref-impedance-ohms",
+				       &nau8325->vref_impedance_ohms);
+	if (ret)
+		nau8325->vref_impedance_ohms = 125000;
+	ret = device_property_read_u32(dev, "nuvoton,dac-vref-microvolt",
+				       &nau8325->dac_vref_microvolt);
+	if (ret)
+		nau8325->dac_vref_microvolt = 2880000;
+
+	return 0;
+}
+
+static int nau8325_i2c_probe(struct i2c_client *i2c,
+			     const struct i2c_device_id *id)
+{
+	struct device *dev = &i2c->dev;
+	struct nau8325 *nau8325 = dev_get_platdata(dev);
+	int ret, value;
+
+	if (!nau8325) {
+		nau8325 = devm_kzalloc(dev, sizeof(*nau8325), GFP_KERNEL);
+		if (!nau8325) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		ret = nau8325_read_device_properties(dev, nau8325);
+		if (ret)
+			goto err;
+	}
+	i2c_set_clientdata(i2c, nau8325);
+
+	nau8325->regmap = devm_regmap_init_i2c(i2c, &nau8325_regmap_config);
+	if (IS_ERR(nau8325->regmap)) {
+		ret = PTR_ERR(nau8325->regmap);
+		goto err;
+	}
+	nau8325->dev = dev;
+	nau8325_print_device_properties(nau8325);
+
+	nau8325_reset_chip(nau8325->regmap);
+	ret = regmap_read(nau8325->regmap, NAU8325_R02_DEVICE_ID, &value);
+	if (ret) {
+		dev_dbg(dev, "Failed to read device id (%d)", ret);
+		goto err;
+	}
+	nau8325_init_regs(nau8325);
+
+	ret = devm_snd_soc_register_component(dev, &nau8325_component_driver,
+					      &nau8325_dai, 1);
+err:
+	return ret;
+}
+
+static const struct i2c_device_id nau8325_i2c_ids[] = {
+	{ "nau8325", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nau8325_i2c_ids);
+
+#ifdef CONFIG_OF
+static const struct of_device_id nau8325_of_ids[] = {
+	{ .compatible = "nuvoton,nau8325", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nau8325_of_ids);
+#endif
+
+static struct i2c_driver nau8325_i2c_driver = {
+	.driver = {
+		.name = "nau8325",
+		.of_match_table = of_match_ptr(nau8325_of_ids),
+	},
+	.probe = nau8325_i2c_probe,
+	.id_table = nau8325_i2c_ids,
+};
+module_i2c_driver(nau8325_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU8325 driver");
+MODULE_AUTHOR("Seven Lee <WTLI@nuvoton.com>");
+MODULE_AUTHOR("David Lin <CTLIN0@nuvoton.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/nau8325.h b/sound/soc/codecs/nau8325.h
new file mode 100644
index 000000000000..0d173b66a4d4
--- /dev/null
+++ b/sound/soc/codecs/nau8325.h
@@ -0,0 +1,391 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * nau8325.h -- Nuvoton NAU8325 audio codec driver
+ *
+ * Copyright 2023 Nuvoton Technology Crop.
+ * Author: Seven Lee <WTLI@nuvoton.com>
+ *	   David Lin <CTLIN0@nuvoton.com>
+ */
+
+#ifndef __NAU8325_H__
+#define __NAU8325_H__
+
+#define NAU8325_R00_HARDWARE_RST		0x00
+#define NAU8325_R01_SOFTWARE_RST		0x01
+#define NAU8325_R02_DEVICE_ID			0x02
+#define NAU8325_R03_CLK_CTRL			0x03
+#define NAU8325_R04_ENA_CTRL			0x04
+#define NAU8325_R05_INTERRUPT_CTRL		0x05
+#define NAU8325_R06_INT_CLR_STATUS		0x06
+#define NAU8325_R09_IRQOUT			0x09
+#define NAU8325_R0A_IO_CTRL			0x0a
+#define NAU8325_R0B_PDM_CTRL			0x0b
+#define NAU8325_R0C_TDM_CTRL			0x0c
+#define NAU8325_R0D_I2S_PCM_CTRL1		0x0d
+#define NAU8325_R0E_I2S_PCM_CTRL2		0x0e
+#define NAU8325_R0F_L_TIME_SLOT			0x0f
+#define NAU8325_R10_R_TIME_SLOT			0x10
+#define NAU8325_R11_HPF_CTRL			0x11
+#define NAU8325_R12_MUTE_CTRL			0x12
+#define NAU8325_R13_DAC_VOLUME			0x13
+#define NAU8325_R1D_DEBUG_READ1			0x1d
+#define NAU8325_R1F_DEBUG_READ2			0x1f
+#define NAU8325_R22_DEBUG_READ3			0x22
+#define NAU8325_R29_DAC_CTRL1			0x29
+#define NAU8325_R2A_DAC_CTRL2			0x2a
+#define NAU8325_R2C_ALC_CTRL1			0x2c
+#define NAU8325_R2D_ALC_CTRL2			0x2d
+#define NAU8325_R2E_ALC_CTRL3			0x2e
+#define NAU8325_R2F_ALC_CTRL4			0x2f
+#define NAU8325_R40_CLK_DET_CTRL		0x40
+#define NAU8325_R49_TEST_STATUS			0x49
+#define NAU8325_R4A_ANALOG_READ			0x4a
+#define NAU8325_R50_MIXER_CTRL			0x50
+#define NAU8325_R55_MISC_CTRL			0x55
+#define NAU8325_R60_BIAS_ADJ			0x60
+#define NAU8325_R61_ANALOG_CONTROL_1		0x61
+#define NAU8325_R62_ANALOG_CONTROL_2		0x62
+#define NAU8325_R63_ANALOG_CONTROL_3		0x63
+#define NAU8325_R64_ANALOG_CONTROL_4		0x64
+#define NAU8325_R65_ANALOG_CONTROL_5		0x65
+#define NAU8325_R66_ANALOG_CONTROL_6		0x66
+#define NAU8325_R69_CLIP_CTRL			0x69
+#define NAU8325_R73_RDAC			0x73
+#define NAU8325_REG_MAX				NAU8325_R73_RDAC
+
+/* 16-bit control register address, and 16-bits control register data */
+#define NAU8325_REG_ADDR_LEN		16
+#define NAU8325_REG_DATA_LEN		16
+
+/* CLK_CTRL (0x03) */
+#define NAU8325_CLK_DAC_SRC_SFT		12
+#define NAU8325_CLK_DAC_SRC_MASK	(0x3 << NAU8325_CLK_DAC_SRC_SFT)
+#define NAU8325_CLK_MUL_SRC_SFT		6
+#define NAU8325_CLK_MUL_SRC_MASK	(0x3 << NAU8325_CLK_MUL_SRC_SFT)
+#define NAU8325_MCLK_SEL_SFT		3
+#define NAU8325_MCLK_SEL_MASK		(0x7 << NAU8325_MCLK_SEL_SFT)
+#define NAU8325_MCLK_SRC_MASK		0x7
+
+/* ENA_CTRL (0x04) */
+#define NAU8325_DAC_LEFT_CH_EN_SFT	3
+#define NAU8325_DAC_LEFT_CH_EN		(0x1 << NAU8325_DAC_LEFT_CH_EN_SFT)
+#define NAU8325_DAC_RIGHT_CH_EN_SFT	2
+#define NAU8325_DAC_RIGHT_CH_EN		(0x1 << NAU8325_DAC_RIGHT_CH_EN_SFT)
+
+/* INTERRUPT_CTRL (0x05) */
+#define NAU8325_ARP_DWN_INT_SFT		12
+#define NAU8325_ARP_DWN_INT_MASK	(0x1 << NAU8325_ARP_DWN_INT_SFT)
+#define NAU8325_CLIP_INT_SFT		11
+#define NAU8325_CLIP_INT_MASK		(0x1 << NAU8325_CLIP_INT_SFT)
+#define NAU8325_LVD_INT_SFT		10
+#define NAU8325_LVD_INT_MASK		(0x1 << NAU8325_LVD_INT_SFT)
+#define NAU8325_PWR_INT_DIS_SFT		8
+#define NAU8325_PWR_INT_DIS		(0x1 << NAU8325_PWR_INT_DIS_SFT)
+#define NAU8325_OCP_OTP_SHTDWN_INT_SFT	4
+#define NAU8325_OCP_OTP_SHTDWN_INT_MASK (0x1 << NAU8325_OCP_OTP_SHTDWN_INT_SFT)
+#define NAU8325_CLIP_INT_DIS_SFT	3
+#define NAU8325_CLIP_INT_DIS		(0x1 << NAU8325_CLIP_INT_DIS_SFT)
+#define NAU8325_LVD_INT_DIS_SFT		2
+#define NAU8325_LVD_INT_DIS		(0x1 << NAU8325_LVD_INT_DIS_SFT)
+#define NAU8325_PWR_INT_MASK		0x1
+
+/* INT_CLR_STATUS (0x06) */
+#define NAU8325_INT_STATUS_MASK		0x7f
+
+/* IRQOUT (0x9) */
+#define NAU8325_IRQOUT_SEL_SEF		12
+#define NAU8325_IRQOUT_SEL_MASK		(0xf << NAU8325_IRQOUT_SEL_SEF)
+#define NAU8325_DEM_DITH_SFT		7
+#define NAU8325_DEM_DITH_EN		(0x1 << NAU8325_DEM_DITH_SFT)
+#define NAU8325_GAINZI3_SFT		5
+#define NAU8325_GAINZI3_MASK		(0x1 << NAU8325_GAINZI3_SFT)
+#define NAU8325_GAINZI2_MASK		0x1f
+
+/* IO_CTRL (0x0a) */
+#define NAU8325_IRQ_PL_SFT		15
+#define NAU8325_IRQ_PL_ACT_HIGH		(0x1 << NAU8325_IRQ_PL_SFT)
+#define NAU8325_IRQ_PS_SFT		14
+#define NAU8325_IRQ_PS_UP		(0x1 << NAU8325_IRQ_PS_SFT)
+#define NAU8325_IRQ_PE_SFT		13
+#define NAU8325_IRQ_PE_EN		(0x1 << NAU8325_IRQ_PE_SFT)
+#define NAU8325_IRQ_DS_SFT		12
+#define NAU8325_IRQ_DS_HIGH		(0x1 << NAU8325_IRQ_DS_SFT)
+#define NAU8325_IRQ_OUTPUT_SFT		11
+#define NAU8325_IRQ_OUTPUT_EN		(0x1 << NAU8325_IRQ_OUTPUT_SFT)
+#define NAU8325_IRQ_PIN_DEBUG_SFT	10
+#define NAU8325_IRQ_PIN_DEBUG_EN	(0x1 << NAU8325_IRQ_PIN_DEBUG_SFT)
+
+/* PDM_CTRL (0x0b) */
+#define NAU8325_PDM_LCH_EDGE_SFT	1
+#define NAU8325_PDM_LCH_EDGE__MASK	(0x1 << NAU8325_PDM_LCH_EDGE_SFT)
+#define NAU8325_PDM_MODE_EN		0x1
+
+/* TDM_CTRL (0x0c) */
+#define NAU8325_TDM_SFT			15
+#define NAU8325_TDM_EN			(0x1 << NAU8325_TDM_SFT)
+#define NAU8325_PCM_OFFSET_CTRL_SFT	14
+#define NAU8325_PCM_OFFSET_CTRL_EN	(0x1 << NAU8325_PCM_OFFSET_CTRL_SFT)
+#define NAU8325_DAC_LEFT_SFT		6
+#define NAU8325_NAU8325_DAC_LEFT_MASK	(0x7 << NAU8325_DAC_LEFT_SFT)
+#define NAU8325_DAC_RIGHT_SFT		3
+#define NAU8325_DAC_RIGHT_MASK		(0x7 << NAU8325_DAC_RIGHT_SFT)
+
+/* I2S_PCM_CTRL1 (0x0d) */
+#define NAU8325_DACCM_CTL_SFT		14
+#define NAU8325_DACCM_CTL_MASK		(0x3 << NAU8325_DACCM_CTL_SFT)
+#define NAU8325_CMB8_0_SFT		10
+#define NAU8325_CMB8_0_MASK		(0x1 << NAU8325_CMB8_0_SFT)
+#define NAU8325_UA_OFFSET_SFT		9
+#define NAU8325_UA_OFFSET_MASK		(0x1 << NAU8325_UA_OFFSET_SFT)
+#define NAU8325_I2S_BP_SFT		7
+#define NAU8325_I2S_BP_MASK		(0x1 << NAU8325_I2S_BP_SFT)
+#define NAU8325_I2S_BP_INV		(0x1 << NAU8325_I2S_BP_SFT)
+#define NAU8325_I2S_PCMB_SFT		6
+#define NAU8325_I2S_PCMB_EN		(0x1 << NAU8325_I2S_PCMB_SFT)
+#define NAU8325_I2S_DACPSHS0_SFT	5
+#define NAU8325_I2S_DACPSHS0_MASK	(0x1 << NAU8325_I2S_DACPSHS0_SFT)
+#define NAU8325_I2S_DL_SFT		2
+#define NAU8325_I2S_DL_MASK		(0x3 << NAU8325_I2S_DL_SFT)
+#define NAU8325_I2S_DL_32		(0x3 << NAU8325_I2S_DL_SFT)
+#define NAU8325_I2S_DL_24		(0x2 << NAU8325_I2S_DL_SFT)
+#define NAU8325_I2S_DL_20		(0x1 << NAU8325_I2S_DL_SFT)
+#define NAU8325_I2S_DL_16		(0x0 << NAU8325_I2S_DL_SFT)
+#define NAU8325_I2S_DF_MASK		0x3
+#define NAU8325_I2S_DF_RIGTH		0x0
+#define NAU8325_I2S_DF_LEFT		0x1
+#define NAU8325_I2S_DF_I2S		0x2
+#define NAU8325_I2S_DF_PCM_AB		0x3
+
+/* I2S_PCM_CTRL2 (0x0e) */
+#define NAU8325_PCM_TS_SFT		10
+#define NAU8325_PCM_TS_EN		(0x1 << NAU8325_PCM_TS_SFT)
+#define NAU8325_PCM8BIT0_SFT		8
+#define NAU8325_PCM8BIT0_MASK		(0x1 << NAU8325_PCM8BIT0_SFT)
+
+/* L_TIME_SLOT (0x0f)*/
+#define NAU8325_SHORT_FS_DET_SFT	13
+#define NAU8325_SHORT_FS_DET_DIS	(0x1 << NAU8325_SHORT_FS_DET_SFT)
+#define NAU8325_TSLOT_L0_MASK		0x3ff
+
+/* R_TIME_SLOT (0x10)*/
+#define NAU8325_TSLOT_R0_MASK		0x3ff
+
+/* HPF_CTRL (0x11)*/
+#define NAU8325_DAC_HPF_SFT		15
+#define NAU8325_DAC_HPF_EN		(0x1 << NAU8325_DAC_HPF_SFT)
+#define NAU8325_DAC_HPF_APP_SFT		14
+#define NAU8325_DAC_HPF_APP_MASK	(0x1 << NAU8325_DAC_HPF_APP_SFT)
+#define NAU8325_DAC_HPF_FCUT_SFT	11
+#define NAU8325_DAC_HPF_FCUT_MASK	(0x7 << NAU8325_DAC_HPF_FCUT_SFT)
+
+/* MUTE_CTRL (0x12)*/
+#define NAU8325_SOFT_MUTE_SFT		15
+#define NAU8325_SOFT_MUTE		(0x1 << NAU8325_SOFT_MUTE_SFT)
+#define NAU8325_DAC_ZC_SFT		8
+#define NAU8325_DAC_ZC_EN		(0x1 << NAU8325_DAC_ZC_SFT)
+#define NAU8325_UNMUTE_CTL_SFT		6
+#define NAU8325_UNMUTE_CTL_MASK		(0x3 << NAU8325_UNMUTE_CTL_SFT)
+#define NAU8325_ANA_MUTE_SFT		4
+#define NAU8325_ANA_MUTE_MASK		(0x3 << NAU8325_ANA_MUTE_SFT)
+#define NAU8325_AUTO_MUTE_SFT		3
+#define NAU8325_AUTO_MUTE_DIS		(0x1 << NAU8325_AUTO_MUTE_SFT)
+
+/* DAC_VOLUME (0x13) */
+#define NAU8325_DAC_VOLUME_L_SFT	8
+#define NAU8325_DAC_VOLUME_L_EN		(0xff << NAU8325_DAC_VOLUME_L_SFT)
+#define NAU8325_DAC_VOLUME_R_SFT	0
+#define NAU8325_DAC_VOLUME_R_EN		(0xff << NAU8325_DAC_VOLUME_R_SFT)
+#define NAU8325_DAC_VOL_MAX		0xff
+
+/* DEBUG_READ1 (0x1d)*/
+#define NAU8325_OSR100_MASK		(0x1 << 6)
+#define NAU8325_MIPS500_MASK		(0x1 << 5)
+#define NAU8325_SHUTDWNDRVR_R_MASK	(0x1 << 4)
+#define NAU8325_SHUTDWNDRVR_L_MASK	(0x1 << 3)
+#define NAU8325_MUTEB_MASK		(0x1 << 2)
+#define NAU8325_PDOSCB_MASK		(0x1 << 1)
+#define NAU8325_POWERDOWN1B_D_MASK	0x1
+
+/* DEBUG_READ2 (0x1f)*/
+#define NAU8325_R_CHANNEL_Vol_SFT	8
+#define NAU8325_R_CHANNEL_Vol_MASK	(0xff << NAU8325_R_CHANNEL_Vol_SFT)
+#define NAU8325_L_CHANNEL_Vol_MASK	0xff
+
+/* DEBUG_READ3(0x22)*/
+#define NAU8325_PGAL_GAIN_MASK		(0x3f << 7)
+#define NAU8325_CLIP_MASK		(0x1 << 6)
+#define NAU8325_SCAN_MODE_MASK		(0x1 << 5)
+#define NAU8325_SDB_MASK		(0x1 << 4)
+#define NAU8325_TALARM_MASK		(0x1 << 3)
+#define NAU8325_SHORTR_MASK		(0x1 << 2)
+#define NAU8325_SHORTL_MASK		(0x1 << 1)
+#define NAU8325_TMDET_MASK		0x1
+
+/* DAC_CTRL1 (0x29) */
+#define NAU8325_DAC_OVERSAMPLE_SFT	0
+#define NAU8325_DAC_OVERSAMPLE_MASK	0x7
+#define NAU8325_DAC_OVERSAMPLE_256	1
+#define NAU8325_DAC_OVERSAMPLE_128	2
+#define NAU8325_DAC_OVERSAMPLE_64	0
+#define NAU8325_DAC_OVERSAMPLE_32	4
+
+/* ALC_CTRL1 (0x2c) */
+#define NAU8325_ALC_MAXGAIN_SFT		5
+#define NAU8325_ALC_MAXGAIN_MAX		0x7
+#define NAU8325_ALC_MAXGAIN_MASK	(0x7 << NAU8325_ALC_MAXGAIN_SFT)
+#define NAU8325_ALC_MINGAIN_MAX		4
+#define NAU8325_ALC_MINGAIN_SFT		1
+#define NAU8325_ALC_MINGAIN_MASK	(0x7 << NAU8325_ALC_MINGAIN_SFT)
+
+/* ALC_CTRL2 (0x2d) */
+#define NAU8325_ALC_DCY_SFT		12
+#define NAU8325_ALC_DCY_MAX		0xb
+#define NAU8325_ALC_DCY_MASK		(0xf << NAU8325_ALC_DCY_SFT)
+#define NAU8325_ALC_ATK_SFT		8
+#define NAU8325_ALC_ATK_MAX		0xb
+#define NAU8325_ALC_ATK_MASK		(0xf << NAU8325_ALC_ATK_SFT)
+#define NAU8325_ALC_HLD_SFT		4
+#define NAU8325_ALC_HLD_MAX		0xa
+#define NAU8325_ALC_HLD_MASK		(0xf << NAU8325_ALC_HLD_SFT)
+#define NAU8325_ALC_LVL_SFT		0
+#define NAU8325_ALC_LVL_MAX		0xf
+#define NAU8325_ALC_LVL_MASK		0xf
+
+/* ALC_CTRL3 (0x2e) */
+#define NAU8325_ALC_EN_SFT		15
+#define NAU8325_ALC_EN			(0x1 << NAU8325_ALC_EN_SFT)
+
+/* TEMP_COMP_CTRL (0x30) */
+#define NAU8325_TEMP_COMP_ACT2_MASK	0xff
+
+/* LPF_CTRL (0x33) */
+#define NAU8325_LPF_IN1_EN_SFT		15
+#define NAU8325_LPF_IN1_EN		(0x1 << NAU8325_LPF_IN1_EN_SFT)
+#define NAU8325_LPF_IN1_TC_SFT		11
+#define NAU8325_LPF_IN1_TC_MASK		(0xf << NAU8325_LPF_IN1_TC_SFT)
+#define NAU8325_LPF_IN2_EN_SFT		10
+#define NAU8325_LPF_IN2_EN		(0x1 << NAU8325_LPF_IN2_EN_SFT)
+#define NAU8325_LPF_IN2_TC_SFT		6
+#define NAU8325_LPF_IN2_TC_MASK		(0xf << NAU8325_LPF_IN2_TC_SFT)
+
+/* CLK_DET_CTRL (0x40) */
+#define NAU8325_APWRUP_SFT		15
+#define NAU8325_APWRUP_EN		(0x1 << NAU8325_APWRUP_SFT)
+#define NAU8325_CLKPWRUP_SFT		14
+#define NAU8325_CLKPWRUP_DIS		(0x1 << NAU8325_CLKPWRUP_SFT)
+#define NAU8325_PWRUP_DFT_SFT		13
+#define NAU8325_PWRUP_DFT		(0x1 << NAU8325_PWRUP_DFT_SFT)
+#define NAU8325_REG_SRATE_SFT		10
+#define NAU8325_REG_SRATE_MASK		(0x7 << NAU8325_REG_SRATE_SFT)
+#define NAU8325_REG_ALT_SRATE_SFT	9
+#define NAU8325_REG_ALT_SRATE_EN	(0x1 << NAU8325_REG_ALT_SRATE_SFT)
+#define NAU8325_REG_DIV_MAX		0x1
+
+/* BIAS_ADJ (0x60) */
+#define NAU8325_BIAS_VMID_SEL_SFT	4
+#define NAU8325_BIAS_VMID_SEL_MASK	(0x3 << NAU8325_BIAS_VMID_SEL_SFT)
+
+/* ANALOG_CONTROL_1 (0x61) */
+#define NAU8325_VMDFSTENB_SFT		14
+#define NAU8325_VMDFSTENB_MASK		(0x3 << NAU8325_VMDFSTENB_SFT)
+#define NAU8325_CLASSDEN_SFT		12
+#define NAU8325_CLASSDEN_MASK		(0x3 << NAU8325_CLASSDEN_SFT)
+#define NAU8325_DACCLKEN_R_SFT		10
+#define NAU8325_DACCLKEN_R_MASK		(0x3 << NAU8325_DACCLKEN_R_SFT)
+#define NAU8325_DACEN_R_SFT		8
+#define NAU8325_DACEN_R_MASK		(0x3 << NAU8325_DACEN_R_SFT)
+#define NAU8325_DACCLKEN_SFT		6
+#define NAU8325_DACCLKEN_MASK		(0x3 << NAU8325_DACCLKEN_SFT)
+#define NAU8325_DACEN_SFT		4
+#define NAU8325_DACEN_MASK		(0x3 << NAU8325_DACEN_SFT)
+#define NAU8325_BIASEN_SFT		2
+#define NAU8325_BIASEN_MASK		(0x3 << NAU8325_BIASEN_SFT)
+#define NAU8325_VMIDEN_MASK		0x3
+
+/* ANALOG_CONTROL_2 (0x62) */
+#define NAU8325_PWMMOD_SFT		14
+#define NAU8325_PWMMOD_MASK		(0x1 << NAU8325_PWMMOD_SFT)
+#define NAU8325_DACTEST_SFT		6
+#define NAU8325_DACTEST_MASK		(0x3 << NAU8325_DACTEST_SFT)
+#define NAU8325_DACREFCAP_SFT		4
+#define NAU8325_DACREFCAP_MASK		(0x3 << NAU8325_DACREFCAP_SFT)
+
+/* ANALOG_CONTROL_3 (0x63) */
+#define NAU8325_POWER_DOWN_L_SFT	12
+#define NAU8325_POWER_DOWN_L_MASK	(0x3 << NAU8325_POWER_DOWN_L_SFT)
+#define NAU8325_POWER_DOWN_R_SFT	11
+#define NAU8325_POWER_DOWN_R_MASK	(0x3 << NAU8325_DACREFCAP_SFT)
+#define NAU8325_CLASSD_FINE_SFT		5
+#define NAU8325_CLASSD_FINE_MASK	(0x3 << NAU8325_CLASSD_FINE_SFT)
+#define NAU8325_CLASSD_COARSE_GAIN_MASK	0xf
+
+/* ANALOG_CONTROL_4 (0x64) */
+#define NAU8325_CLASSD_OCPN_SFT		12
+#define NAU8325_CLASSD_OCPN_MASK	(0xf << NAU8325_CLASSD_OCPN_SFT)
+#define NAU8325_CLASSD_OCPP_SFT		8
+#define NAU8325_CLASSD_OCPP_MASK	(0xf << NAU8325_CLASSD_OCPP_SFT)
+#define NAU8325_CLASSD_SLEWN_MASK	0xff
+
+/* ANALOG_CONTROL_5 (0x65) */
+#define NAU8325_MCLK_RANGE_SFT		2
+#define NAU8325_MCLK_RANGE_EN		(0x1 << NAU8325_MCLK_RANGE_SFT)
+#define NAU8325_MCLK8XEN_SFT		1
+#define NAU8325_MCLK8XEN_EN		(0x1 << NAU8325_MCLK8XEN_SFT)
+#define NAU8325_MCLK4XEN_EN		0x1
+
+/* ANALOG_CONTROL_6 (0x66) */
+#define NAU8325_VBATLOW_SFT		4
+#define NAU8325_VBATLOW_MASK		(0x1 << NAU8325_VBATLOW_SFT)
+#define NAU8325_VDDSPK_LIM_SFT		3
+#define NAU8325_VDDSPK_LIM_EN		(0x1 << NAU8325_VDDSPK_LIM_SFT)
+#define NAU8325_VDDSPK_LIM_MASK		0x7
+
+/* CLIP_CTRL (0x69)*/
+#define NAU8325_ANTI_CLIP_SFT		4
+#define NAU8325_ANTI_CLIP_EN		(0x1 << NAU8325_ANTI_CLIP_SFT)
+
+/* RDAC (0x73) */
+#define NAU8325_CLK_DAC_DELAY_SFT	4
+#define NAU8325_CLK_DAC_DELAY_EN	(0x7 << NAU8325_CLK_DAC_DELAY_SFT)
+#define NAU8325_DACVREFSEL_SFT		2
+#define NAU8325_DACVREFSEL_MASK		(0x3 << NAU8325_DACVREFSEL_SFT)
+
+#define NAU8325_CODEC_DAI "nau8325-hifi"
+
+struct nau8325 {
+	struct device *dev;
+	struct regmap *regmap;
+	int mclk;
+	int fs;
+	int vref_impedance_ohms;
+	int dac_vref_microvolt;
+	int clock_detection;
+	int clock_det_data;
+	int alc_enable;
+};
+
+struct nau8325_src_attr {
+	int param;
+	unsigned int val;
+};
+
+enum {
+	NAU8325_MCLK_FS_RATIO_256,
+	NAU8325_MCLK_FS_RATIO_400,
+	NAU8325_MCLK_FS_RATIO_500,
+	NAU8325_MCLK_FS_RATIO_NUM,
+};
+
+struct nau8325_srate_attr {
+	int fs;
+	int range;
+	bool max;
+	unsigned int mclk_src[NAU8325_MCLK_FS_RATIO_NUM];
+};
+
+struct nau8325_osr_attr {
+	unsigned int osr;
+	unsigned int clk_src;
+};
+
+#endif /* __NAU8325_H__ */
-- 
2.25.1


