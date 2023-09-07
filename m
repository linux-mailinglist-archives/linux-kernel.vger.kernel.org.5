Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D67975A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbjIGPwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjIGPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:48:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6BE4686;
        Thu,  7 Sep 2023 08:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvqsA5f8HgYFyfNYutaIuqy4lRLBQBaSKTeX7Nt8jUsV6owu6dS3a3osS3I+J5iuneiZ35kCd55uWrkNOgUtaZM04ClE217i6t3+Ag6PQmUhQqSu2cWW3gPztgFokN1/qUTGP9HQRymGZD5aeH40lNtuXBBeEE0SwiS4D/h+3wkJ871DPNLcRIsNfsZaG6Iom+6HkQDVL1tTOO0ewtY9CJUJzSdDGJmszV/gZkjDB1SRbxfKCV4tmD0DvpC9YZpl7rfYbUkSR32eiCkQsaUCnDJW223E2SuUlljTGx7MJCMZrSrk9kVaq1Lt99S/SpI6GJ2dRKdrYGGv5rM8rWxzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axdESzzeTc41Elo5Pnv2l4RWQNQI4WWmDV3IaB2H/BY=;
 b=ZMyoWIRBdYB0D6VuB9+EjgJKjY9hiN4shIV4wv8L6+5FUn3alz8EpB8HOpAOPTFA/LMX879TSq2YqK7JhIQh11GtTZ3Jhrz7fBqccjd7FjzBu4yZf3v5RRN57QZzo7z+X7TjeJrba0Y01uNBfi3tT3lX0CPyppCumCYFOrZZ+j0GZboY2iukWTpDb7773bHBOgzbQ6UnakxnDyQI6vc+V8z2k4ELXWLJ5xnDq6MhiOFx89E0Eq6Xdh1wkfv/pValUiWD2OMdXWpMAEjaVMb35hTNGkwnIQwp+bD+YJ6p5txFB7o98e8gXcLSXPtzIOib6piWNyacL3ujRQJktVmtlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axdESzzeTc41Elo5Pnv2l4RWQNQI4WWmDV3IaB2H/BY=;
 b=FJxOMtv7Qda0KomSl6bStJpFVoSXwWkwMwTZiFQHm9gHQlkhslDhHGn466gQAtC2EvS1lbpF003kD31Gft2s6n4nyzmEs1CDsIOK2t0gr7FjRTd9S/0RGSy06+sgWWVu0vKwvmfpNCr5SZfIeGpQAGfJr38DNl7rZPyr6GwxyIbC1ImlytYI+YWm9IBJYH/8M06Gs/6VW8uclwIGSuoft6qgNPv0g+aYFryE3iIpCnFbcbfe6a4etxVVoAp+NdpL+QuLId3R6iN/CRU9vQjo8p0Oi8dPFof89zn7caHFUuaMzsRLOm72slRedZ0/uDhtmdy6+xM1sT7NZsG5KhxGJA==
Received: from SN7PR04CA0205.namprd04.prod.outlook.com (2603:10b6:806:126::30)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 15:03:15 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::cc) by SN7PR04CA0205.outlook.office365.com
 (2603:10b6:806:126::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 15:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.26 via Frontend Transport; Thu, 7 Sep 2023 15:03:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 7 Sep 2023
 08:03:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 7 Sep 2023
 08:02:59 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 7 Sep
 2023 08:02:56 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 2/2] ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
Date:   Thu, 7 Sep 2023 20:32:25 +0530
Message-ID: <1694098945-32760-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
References: <1694098945-32760-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|BL1PR12MB5240:EE_
X-MS-Office365-Filtering-Correlation-Id: 4895460d-4933-4667-75bc-08dbafb38fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nFZYEaBfWc7Ic/iKE42wbvKUuxyCqWwDrJpKE2Ah+zjf7DXqsR6A48mH6MZgOPts7oEOSf8Xbwyyg63Ho+6WeLP7DP2djvdax5dM9x5q2s0S6O0MBm70+bfNEU0RSN3Q2TrQQgAX//Od9zL0279nAg525OCQBzzy4hpjRE7Y5WGADZAX2YY8B7NyZGR8xs4kBBZDPcb02BEzsAIiANo5vuNkkWGTS/NOT3GbPTjo0sKrQp8Q46zFx1zx9nc9UGkwj6xM3gEwBqxrB+iAZ++wG1UdqscDTI0W6CzieDjszpTh2QqKmSzp6BZFTYAeoFWW8diz+tLbeU/UTfpcAzjChl1uvnLFUmgS9yn3BJa2QQngUuwRWwi+Q9Y2kSBVtTCc+xx5BcMukenglvFx+QSFEQ3SN+b6fpYw0oSUl98BuyyYKpbiUn8AVnjBBsSJiGTU0RgWg7O6gWEJ3hWsKCBD8SfFE+ojRVTRstTVmOgtcFuJYSkI/A4X7JgLDofoz29P/JRv42oOVOt6k6e/utQPyQh3oMCFHqpQyFDx8GCo5JlFGslW2PsZhz5XGXBlZogdkRhdl55OQqJHiJ2y6s4tA/PcvAG1ACCAcjJ6vq0LQeaQmfL/fNEAN3K8nGBnRd48uITgcVz4jcjQHfJH7iw4jt0VOfHvlDqIj8wD5CRAK/T6mUlzbkAw4ohNRk44GBX64ywNcUPFFnKUcpr4N+Ujj2YQNIfiVl84/p24cnBfcMnTfNUTeCRNeMRgP/bMlQKH
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(15650500001)(8936002)(8676002)(478600001)(4326008)(110136005)(70206006)(70586007)(5660300002)(40480700001)(83380400001)(2906002)(41300700001)(6666004)(316002)(54906003)(86362001)(7696005)(40460700003)(82740400003)(36860700001)(2616005)(356005)(26005)(7636003)(426003)(336012)(47076005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:03:14.9706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4895460d-4933-4667-75bc-08dbafb38fe3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra audio graph card has many DAI links which connects internal
AHUB modules and external audio codecs. Since these are DPCM links,
hw_params() call in the machine driver happens for each connected
BE link and PLLA is updated every time. This is not really needed
for all links as only I/O link DAIs derive respective clocks from
PLLA_OUT0 and thus from PLLA. Hence add checks to limit the clock
updates to DAIs over I/O links.

This found to be fixing a DMIC clock discrepancy which is suspected
to happen because of back to back quick PLLA and PLLA_OUT0 rate
updates. This was observed on Jetson TX2 platform where DMIC clock
ended up with unexpected value.

Fixes: 202e2f774543 ("ASoC: tegra: Add audio graph based card driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/tegra_audio_graph_card.c | 30 ++++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/tegra/tegra_audio_graph_card.c b/sound/soc/tegra/tegra_audio_graph_card.c
index 1f2c5018bf5a..4737e776d383 100644
--- a/sound/soc/tegra/tegra_audio_graph_card.c
+++ b/sound/soc/tegra/tegra_audio_graph_card.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <sound/graph_card.h>
 #include <sound/pcm_params.h>
+#include <sound/soc-dai.h>
 
 #define MAX_PLLA_OUT0_DIV 128
 
@@ -44,6 +45,21 @@ struct tegra_audio_cdata {
 	unsigned int plla_out0_rates[NUM_RATE_TYPE];
 };
 
+static bool need_clk_update(struct snd_soc_dai *dai)
+{
+	if (snd_soc_dai_is_dummy(dai) ||
+	    !dai->driver->ops ||
+	    !dai->driver->name)
+		return false;
+
+	if (strstr(dai->driver->name, "I2S") ||
+	    strstr(dai->driver->name, "DMIC") ||
+	    strstr(dai->driver->name, "DSPK"))
+		return true;
+
+	return false;
+}
+
 /* Setup PLL clock as per the given sample rate */
 static int tegra_audio_graph_update_pll(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params)
@@ -140,19 +156,7 @@ static int tegra_audio_graph_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int err;
 
-	/*
-	 * This gets called for each DAI link (FE or BE) when DPCM is used.
-	 * We may not want to update PLLA rate for each call. So PLLA update
-	 * must be restricted to external I/O links (I2S, DMIC or DSPK) since
-	 * they actually depend on it. I/O modules update their clocks in
-	 * hw_param() of their respective component driver and PLLA rate
-	 * update here helps them to derive appropriate rates.
-	 *
-	 * TODO: When more HW accelerators get added (like sample rate
-	 * converter, volume gain controller etc., which don't really
-	 * depend on PLLA) we need a better way to filter here.
-	 */
-	if (cpu_dai->driver->ops && rtd->dai_link->no_pcm) {
+	if (need_clk_update(cpu_dai)) {
 		err = tegra_audio_graph_update_pll(substream, params);
 		if (err)
 			return err;
-- 
2.17.1

