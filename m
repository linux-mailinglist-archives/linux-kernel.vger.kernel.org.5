Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5163F806D63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377968AbjLFLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377937AbjLFLHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:07:44 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE97DE;
        Wed,  6 Dec 2023 03:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbxxFAREue76lM3mP8/oMyvFKiVI0mFn8jN9MR6JSQMbRIiAvfwfg1SYLV8Ey5RwZGC9PLi+17H1G9DfpKXJA7vqh+WToZS86kXua3B8QrPq+F4TuAc90vH3UPt1B0x4op6QiJTbcP547b6Bb2wZg9bQS5PzC5ejUw6A7AcEeDvFFgsOwpASa/2mX9+XlQXTKCnd1JhaP/JGqXYFRV88KhW8tHoTtuuuikatH0Fsn7ioekpsOWoxOWWgdYSxgJZfVBlHSxFPZUoSlWtNS3+hSgaFtKEEM6OiZR0ft8IuWiDhUGY+cmpTJAEs2+n7NLj7Apix/4r7Rs+8s4JTeAadxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhwFWLv7JfCGRvb0WPD0pnr3Q3jEArGyuG8DCk0BwH4=;
 b=lQt7l8YKG58i+8L5qpN6vlSI+G+sZtbPducMKftKg3utjS3Mml4R9xlWvkro89KmZ/xIFDt7uJto+aLAdgEzkjIFquQ9aOGO2R3J7WcsW9BCXb6l9Zzijl6MRPUfx12bOFeTkViJwXbnUY3i4Vm4ABFufUUjMA9ZgUqFqvapv2KgtRds5+23o/8gEBm41j0VKk1a1w+Q++W8m/38KSy+7zv/1DRTTwoEJdZeRfrR1a913fhcZXphymaoOQTVJiSDNqdfmoBeDekUsRynBTK1sFdw68BHuh6RZ826emBEomJ7RmDBDyQ8iIMg6oI7asl+YZw5Wx6a7OHNWjFYEP15OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhwFWLv7JfCGRvb0WPD0pnr3Q3jEArGyuG8DCk0BwH4=;
 b=UfrjWdD/0xy4tyEkcDxqOzKSO4yzOP1vxC/L45iY7gpDKdN7Hh5Jv0wyFln1lMRWOohe9tgxmGoYRGvrn+bRsu70/WXHdPaQOz8Dljh/D4l8+0eHJh/8KQ5QKr8Hj0H3lSTtRO5M3E6t9k4ROcARwy7UUC3XchFQIKwpCcQWtOg=
Received: from MW4PR04CA0087.namprd04.prod.outlook.com (2603:10b6:303:6b::32)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.26; Wed, 6 Dec
 2023 11:07:43 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::ba) by MW4PR04CA0087.outlook.office365.com
 (2603:10b6:303:6b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 11:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.2 via Frontend Transport; Wed, 6 Dec 2023 11:07:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 05:07:42 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:07:33 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Alper Nebi Yasak" <alpernebiyasak@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <linux-sound@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] ASoC: amd: acp: Set bclk as source to set pll for rt5682s codec
Date:   Wed, 6 Dec 2023 16:36:18 +0530
Message-ID: <20231206110620.1695591-7-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
References: <20231206110620.1695591-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 113081ba-3f16-45fb-3437-08dbf64b91de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G88pdZ5HEcsxdXUjgGVf2TW8XCnV4LV2AaWFQKVPF/SrnqSw9097J8ml1cmc8SR5tPblHXbHjEPS0MzjZ3srbuYz1h4dPG65kHFR9EOlK1Knd1vtQ6FTNgbhx8p+Mvy+kTUZD2Py/0WwDbLUZqtDfVGxCosTV6frHfAOyHCjf+tHNNG2fxmWI3kLE3Sf3hnlnATO5hQWnButsvJS+wffC6ksGasH47prbUkJATzjoiYm9Bx57uPFo/zlJxFpwH7jGW57QMkkh+AVtlcutieKQBGokJX/X2gLFygtZqb2/IGi2NZndaTFP1AlFetX+GVSDAJ2Pt7RJPSsAyoHip2NxwOZluJ5j72IIrBClWf+PAeDUtBEqlJJTcyO0WSuw3eT8lBL5bjwOu15lVckhCsBa3FV+V+JX99l28KzDRkOi1y5vYgQv+0KJR6Zt5hThyqDCo5iiNA79brLFvDCZ1V53yllD++iX3pfKeHOoSGSZY+e4MhHRAndc2+5vc+6LANDGsHnRR7DgbvMXtg2jx2WimdXTS41dyNpPR6xKVdi/W3oD11ijkALJN4wwsLQwv7bBo+NFDdWQsXEeamzTw2c7YzOOMYJ3E8x72IHGHPON6gTmp8ON97BhEiTHAmwhOIArq1z3hICpHU1ldlsOkFdeCXyQBxXAyDejBFU/qrISVPve+WKpIksBLAP6MRt+2Jc4GBQRMWRBottFH83A2YNPUV0izHMwzzDUJKoTY/tTg2z88lv0mf63OTVTklgSn9lSdZR3Q9mxb1IzIZuXcrj/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(1076003)(2616005)(41300700001)(8936002)(8676002)(4326008)(336012)(426003)(83380400001)(82740400003)(40460700003)(26005)(86362001)(478600001)(110136005)(70586007)(70206006)(316002)(54906003)(6666004)(36756003)(7696005)(36860700001)(356005)(2906002)(40480700001)(5660300002)(7416002)(81166007)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:07:43.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113081ba-3f16-45fb-3437-08dbf64b91de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms doesn't have reference mclk pin to codec,
so set bclk as a clk source for rt5682s codec pll in tdm mode.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index b72beb8e9b13..74e83c2dae53 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -464,6 +464,22 @@ static int acp_card_rt5682s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	if (drvdata->tdm_mode) {
+		ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL1, RT5682S_PLL_S_BCLK1,
+					  6144000, 49152000);
+		if (ret < 0) {
+			dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL1,
+					     49152000, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* Set tdm/i2s1 master bclk ratio */
 	ret = snd_soc_dai_set_bclk_ratio(codec_dai, ch * format);
 	if (ret < 0) {
-- 
2.25.1

