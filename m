Return-Path: <linux-kernel+bounces-126606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7047893A4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1665DB20B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358C1DFF7;
	Mon,  1 Apr 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="I3iY7BLH"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB861854;
	Mon,  1 Apr 2024 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968489; cv=fail; b=p4TSFaRmBu+tYqpWTwcg1Ue0n5+25o56ZAsl+ws+PGvvNzH7Mq69AZAUNBGFt/Brs4vwbNvZDCdNBTUijOz9nWhDrfdXWbrKlFwLt/0PW101g2i0mO4+ceoRgEmE9zkKvLy5wIgTYvTpA6Nv31ezsqvqByU4sJH7632CZmukB2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968489; c=relaxed/simple;
	bh=3YZMrhtwYYI/rnGzWlll5OdU/HM972Jq8AAD782CmWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HLKXtLA1fJcSLOgTvV+S8dpI8tEyDktLnHJiZ7eDvfejYIfGvXfRb4rrRqcO2sxMpM+wuBJe7KOp8vGzLY+x3PDiwgyQhPfcUFxdpooJzUkdREtZYxHcruKXlDmWcR8FaaVVkiCItANRW/8oiOKfqaeIP87Xq6McIrShfC85M9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=I3iY7BLH; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eix/u6Pxit3R4msU7vhVSpWXX3cej0Xbbn/tmwTutmjsdUtbr5y0iUDLgyO+/pbxUHwBjtzxkSAOv1GoTijrqjREhXw86uJh8BerSbkW0mSFCQUYSnHF6tZrkEj8nveJeU8V/One/8mfRcZwQHrOY100VrEVh4zgrqzMBsINi5GQHPaUjBJhStBzaydjMbwTCpTcguX136pRAAkYaVQC1rG9dtzYP2mkeFmEb1OGXu7e43JfEIAibKH1QY0PkEJKNMmOqaFNEDNm8hrObpDVMSGUw4mtc6zs1bJ84CEwz0qszrVf0QEkbHdNJDjQH/JxRaQ3qLRLm8Yoeg+4vAQOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lorP0dzn7NGTO03moKq8Jv7MQ0XHkrxoTwW6S63kbug=;
 b=XxXsQ9GXz7epWDlK51MIm9ZkQ4/bZ2lLW9aUXAmYPbkQixysJNP7Cgeyfogqp4VqQZOcUFu+Fr1BB8qaWZZXZf862jsMWcBcd6162qVLRA58wYYudERQ+P7HdZWUbBps6wQ9RUoCT16oe+Zd+P6p36U8UUK0y0q38I35AD2RWol8GxDCMwqRZsCmdUp+nUTaegqeay87iCTq1SDzNv33B5MIIbh9QUk1WHBiSIxJ8iimkzOWCG1rPu4cR9VuHuIotrgWZZs5G7Jey59hd0HpC0W5tB83C/tr2y5OphWuFWIcRUBLwd0bH+3t1nTcYpF/vVCbrbgH3GX9UlORLedWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lorP0dzn7NGTO03moKq8Jv7MQ0XHkrxoTwW6S63kbug=;
 b=I3iY7BLHeOgUQrYnme/W3mpLrKR9miuLSL/13s+ZxVFXlu/0cLv7GwUDvJ8s5kE5Yj2IGN0ai6ZH7w8LDMr4o8U/15xn9ZVUWiAtzLTmDOwmAwXkJuyZI26FYTyuMKjKw7/NEM1ir9qfHtePlkiGABxomuHO82FatObwjvU6hGk=
Received: from SG2PR06CA0228.apcprd06.prod.outlook.com (2603:1096:4:68::36) by
 SEYPR03MB8454.apcprd03.prod.outlook.com (2603:1096:101:203::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 1 Apr 2024 10:47:59 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:68:cafe::1e) by SG2PR06CA0228.outlook.office365.com
 (2603:1096:4:68::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 10:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 10:47:58 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 1 Apr
 2024 18:47:57 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 1 Apr 2024 18:47:57 +0800
From: Seven Lee <wtli@nuvoton.com>
To: <lgirdwood@gmail.com>
CC: <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
	<SJLIN0@nuvoton.com>, <wtli@nuvoton.com>, <scott6986@gmail.com>,
	<supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH] ASoC: nau8325: Revise soc_enum structure definition.
Date: Mon, 1 Apr 2024 18:47:53 +0800
Message-ID: <20240401104753.3432507-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SEYPR03MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e4ff95-f9cf-4dd6-846a-08dc5239323c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCUfdkkdb9QPyt19Pzvs8xZhL4nEyWY4Mz/P9JwspY4J7qcaLxl5RSz6Bz1nZLEiRDBpRARmVneT2FUCSoJau+fu7kDgDesI39CcH1lGB7c+iTauLZNnf50bmjmjlFv8sk7U5fysxlYMbkA3bA1lHfeWjZVE6SEclyfiPQezm/J37UMFwed932NDgmcgr2yzOpZjCASGj8mp3ZMQw0qn+XAc8dXX4t3b3gOGVQNdrfmKuHdzE7MT4bhlcd3ixXjpKDR4GKGOV4GxQk0mclARMlW/CRYIFijRKMY+WysW5VoMdmGsPGZzhLy7ibbdoSNRwpSOntKECA5OWWzHHbpNj/1f9JUN0d84xJsUla8KcUC8Xli9TI0pO8mI4Bat851phs6pN6J0dDutchFmR6W2V5jbLxz2vGh/6NuYytlrwsks14OompkLSecOFrTtwkkaSxowC1nXueFWeLh0K3g2z2IDNfrbA5K2ISu7tOjDRFP59fR5egqOcmN0F4Dai9tZcAoZmBWx/QeGHna1MiUWm3wlCw3do0CZ//5dA9Be9s+9qPl3+KCebVZuUlEamBNoUhzSlPZ9UAZoKx0uPijkrXurlYECSLVtf7LodZqEHXeNR6me6W60wwH1nmNu2xdFYdydNYyHMbmJdlMTDw/Nk7/Ft5SpZ4rACePlVqa6oDummzP/Uhc3LschhlJnwp2PXOcLPTBd5MrMwWqNyDJHGXfrMefet7LZszYLB9lJ1ZCqsF6WPYpDbfaM87Kb+C9e
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 10:47:58.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e4ff95-f9cf-4dd6-846a-08dc5239323c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8454

This patch is modified nau8325_dac_oversampl_enum enumerated.
Use SOC_VALUE_ENUM instead to hide empty (presumably invalid) options.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 sound/soc/codecs/nau8325.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/nau8325.c b/sound/soc/codecs/nau8325.c
index a00a30364c89..d65f73144597 100644
--- a/sound/soc/codecs/nau8325.c
+++ b/sound/soc/codecs/nau8325.c
@@ -174,13 +174,20 @@ static bool nau8325_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const char * const nau8325_dac_oversampl[] = {
-	"64", "256", "128", "", "32" };
+static const char * const nau8325_dac_oversampl_texts[] = {
+	"64", "256", "128", "32",
+};
+
+static const unsigned int nau8325_dac_oversampl_values[] = {
+	0, 1, 2, 4,
+};
 
 static const struct soc_enum nau8325_dac_oversampl_enum =
-	SOC_ENUM_SINGLE(NAU8325_R29_DAC_CTRL1, NAU8325_DAC_OVERSAMPLE_SFT,
-			ARRAY_SIZE(nau8325_dac_oversampl),
-			nau8325_dac_oversampl);
+	SOC_VALUE_ENUM_SINGLE(NAU8325_R29_DAC_CTRL1,
+			      NAU8325_DAC_OVERSAMPLE_SFT, 0x7,
+			      ARRAY_SIZE(nau8325_dac_oversampl_texts),
+			      nau8325_dac_oversampl_texts,
+			      nau8325_dac_oversampl_values);
 
 static const DECLARE_TLV_DB_MINMAX_MUTE(dac_vol_tlv, -8000, 600);
 
-- 
2.25.1


