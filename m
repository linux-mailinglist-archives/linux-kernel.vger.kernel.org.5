Return-Path: <linux-kernel+bounces-142504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABAB8A2C88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC45281DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756154FA1;
	Fri, 12 Apr 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="O5AHDJDS"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360223A8D8;
	Fri, 12 Apr 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918170; cv=fail; b=QGDnrBwCIy7s/fxEux5mgRSterj+/6w9+O5xHPCx+ERTtYL2CJG2NW5NZxA+UUz0O8qWhbHy+NGcG5+eqYmg2gNapnVV7oxL8yeGy0N+Kd+Hm0YYA0OJsis7AiNT5g130VC6PhsLpUY6qIFe30bGMLYKxtxKQMXmrUkWGKuL7uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918170; c=relaxed/simple;
	bh=0lGJraeOnhn2LSfbE4L9G1q3vyowZF0x4ziiuiJ7DgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Enx9yHvdo4lrZoWml/rgX4FQ90c1S+JkA0flhze+QHZNPiv+Yl4cRMSAHiZ51Fw9pMO3OJpZJIrfmfxicWySndwLJkOH1u1rUfHyJ462dnmHcw2JBjLo/Yd2H7YB6yTHXJFHgsBQsPGnULuNsJSixhGs4kPfgKzxE09+qrilWH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=O5AHDJDS; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXUgfc8WxY16wA02lSCa7Lxgn7cjn2YDhK5khtxPYKt0wOcB76JA7vFfbkZh2WEEDHvm9TeUO88QBV4+M/uxGcPWZVN9fqkdeXZbt3c8gHADZsaPTU/1r6Ae8O4/5pJv39c9OPHUQ3OhHWXw5h1suOFwVxWM7PlqDu6uZ7zpBUAfWhMUjGFcFtPfeU0pFgo+8NLL5IpxYyBgy0ZEXUIH330ruY117mhUGNtPheaSkVPSVayaOqsO+L79xx4KX3eskyQ1LnMkanCDvFvoGzVSHVR+wNSW5HlgvRWPMGAY7YoDZpqJ9qWEi2TmgssEW2ItmVgyY7qXoIkVw6DaVSpolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYxW85wyM+TsJ4FqeTwjSl+YqmMB37izNjJ8yOHYDkA=;
 b=mKbVv4Z3V6zYWznWLaJm3DO4y3XIF0DrxRVJ1CtpzmXdtT0TOKKqDkGNstq1Qrbx7w03qr/ut1zqG5OwYhfen2/AhQ/P5SPe0qTmEj9BhmbRXiivI2XmVsuHXOsutIvF3FNUkTNPNBgVXJozGQ1gUDFD2wafnllTWAqLeR1tAcC4cHoP1QSRGLUgxHuOcpPXAmU3fgyjlMbCUp7nelKtgQJZhdLAedBg28SxotPYSnAIxbwQQoGBqN0I6cte6wPZ+rA79JJSJj9xvfm8omPGlVlhKecLDY6RjxtYOJgtRP39KD9w25F5irNoD4Oa221UXelDXRb0R9HEOW/lIKABQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYxW85wyM+TsJ4FqeTwjSl+YqmMB37izNjJ8yOHYDkA=;
 b=O5AHDJDSI635RgWCThEHRqFRAWjAbaBzW/hjHlP/iirLOyeXoBaRF+hqT9Kdjuh09XfpPdhkS0XxEdSaqcerJv/2hOaZpkX9q46KjRl9tumIFrtlEWDubPDrjEAzFRSkFKztGMcMZJe5J1eK8hXUFlJq/nYLXeA69g5N8SSPhgc=
Received: from SG2PR02CA0032.apcprd02.prod.outlook.com (2603:1096:3:18::20) by
 SEZPR03MB7005.apcprd03.prod.outlook.com (2603:1096:101:ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 12 Apr 2024 10:36:02 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:3:18:cafe::d7) by SG2PR02CA0032.outlook.office365.com
 (2603:1096:3:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 10:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 10:36:02 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 Apr
 2024 18:35:56 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 12 Apr 2024 18:35:56 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
	<devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<robh+dt@kernel.org>, <conor+dt@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>, <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>,
	<CTLIN0@nuvoton.com>, <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>,
	<scott6986@gmail.com>, <supercraig0719@gmail.com>, <dardar923@gmail.com>,
	<edson.drosdeck@gmail.com>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/3] ASoC: nau8821: Add delay control for ADC
Date: Fri, 12 Apr 2024 18:35:53 +0800
Message-ID: <20240412103554.3487290-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412103554.3487290-1-wtli@nuvoton.com>
References: <20240412103554.3487290-1-wtli@nuvoton.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR03MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 010c9392-7797-45fc-2270-08dc5adc59a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yi4kMmjMmJOgoeXzzVH36EpUfX/Z/evJr5Mc4ioBnclM9RNJOex4cwmTZ7A+xttHrKR+78APboby8LVPbDKwxK6bformgzkAVURJl4u89vmw1+CUKUngChKSEMdYZZIU/p22FjgwXIXbuIWE6FVbadlRD51NE9NsjOcrTrTI31KOPYGQQC5Pcb/KJwx382Xx/k1Zz5Rp87zAJQH9emwz0iz4xmmviQbSnMEnHu2ompBOVFDUKhHI6BwPa9WUH2uM308NGZY9F0jsNI5pO8kEI9DLYEYHDCpwP1aV7ib2L3ART7aTlB1npr0Un2d3i7NU22KzTfyawmS9G2ejiX8Kmqg6X+WNccd/QjSYQXTOcy+XiDoXQgVjIAUsgDOWhHQFoLJDZB5HEdx5McXr4HHfQ5FHGrsdFX+fXjPosnifgtupp3DOIpuXlaym3PpjcVl6JyFGq+j6CHvuY1q2CDiXb4bgHU9UGP2Fj2hU6IbFZFAwsWLPiIak/Paso4Mv9J6xt5Gd++e1s7LOyqCu8Eu21mt60te3+pzCTI/CqNCXV4/pk8nDix3Nqf6sQLj2yNg60e2H+trR3/15hkAj8cjOKqQKE2vl/t/ObutQXqnGbIf/ddxzQPzbtGWrxxhPzRZ74qnJQbfV3d3LpMHFhhwqeGPX7ESobeOu0C6oh4R2ZYfuUC5099RB8oRxlspwP2FNA2C6T7PLAfcclfz/PZQzP8a4mON5B7+MvgqUR1QVPO7GFSbJuaObSZA5YB3386Mg
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:36:02.2104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010c9392-7797-45fc-2270-08dc5adc59a7
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7005

Change the original fixed delay to the assignment from the property.
It will make it more flexible to different platforms to avoid pop
noise at the beginning of recording.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8821.c | 11 +++++++++--
 sound/soc/codecs/nau8821.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 012e347e6391..fec669e00a10 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -511,7 +511,7 @@ static int nau8821_left_adc_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		msleep(125);
+		msleep(nau8821->adc_delay);
 		regmap_update_bits(nau8821->regmap, NAU8821_R01_ENA_CTRL,
 			NAU8821_EN_ADCL, NAU8821_EN_ADCL);
 		break;
@@ -535,7 +535,7 @@ static int nau8821_right_adc_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		msleep(125);
+		msleep(nau8821->adc_delay);
 		regmap_update_bits(nau8821->regmap, NAU8821_R01_ENA_CTRL,
 			NAU8821_EN_ADCR, NAU8821_EN_ADCR);
 		break;
@@ -1697,6 +1697,7 @@ static void nau8821_print_device_properties(struct nau8821 *nau8821)
 	dev_dbg(dev, "dmic-clk-threshold:       %d\n",
 		nau8821->dmic_clk_threshold);
 	dev_dbg(dev, "key_enable:       %d\n", nau8821->key_enable);
+	dev_dbg(dev, "adc-delay-ms:		%d\n", nau8821->adc_delay);
 }
 
 static int nau8821_read_device_properties(struct device *dev,
@@ -1742,6 +1743,12 @@ static int nau8821_read_device_properties(struct device *dev,
 		&nau8821->dmic_slew_rate);
 	if (ret)
 		nau8821->dmic_slew_rate = 0;
+	ret = device_property_read_u32(dev, "nuvoton,adc-delay-ms",
+		&nau8821->adc_delay);
+	if (ret)
+		nau8821->adc_delay = 125;
+	if (nau8821->adc_delay < 125 || nau8821->adc_delay > 500)
+		dev_warn(dev, "Please set the suitable delay time!\n");
 
 	return 0;
 }
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index 62eaad130b2e..f0935ffafcbe 100644
--- a/sound/soc/codecs/nau8821.h
+++ b/sound/soc/codecs/nau8821.h
@@ -577,6 +577,7 @@ struct nau8821 {
 	int dmic_clk_threshold;
 	int dmic_slew_rate;
 	int key_enable;
+	int adc_delay;
 };
 
 int nau8821_enable_jack_detect(struct snd_soc_component *component,
-- 
2.25.1


