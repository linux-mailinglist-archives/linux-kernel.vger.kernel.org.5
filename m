Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB407DCE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbjJaOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbjJaOAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:00:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F6FF1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur+LH5mWVGPV1JG5MM4K4SLXzvfADlL7vyKbcLLR/yzDbvR1UyEiUFVjHt/3ndgMBFjIdDtYsdJGeIWb+YpB+GsjK8tDBDYqn4svlX+0Bwft57Wb3CbWth075yN4L7wJN6+wAQ0w3yXrY8x3RoSiQoUlL0zrACuPhk1y5+978Y2wxUVI5fd4avnGftoccOZ3Mr1Pi0/V0QUWmP+AANfiRt8/H7O/Tcy+eN+LvaCyDmay5t4sAzcEaLx1aSrUtN0KDqimoBKdcI8dhv0RKxtioBlU+35ns6vfRvSppTGzYUpRCY4wG3Ody0Iqywl7Wt2gtzFwv5plD0G/4svS7W+1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0WP9MYgxXPuvC+LrBt4lBsoTRIVGjH9C3ZhcX0D0es=;
 b=R2YefImHj2h1o2+h41eIsKPsJAm4/9tNsaIDdeD1w8hScEa0ZqWCiiLst47zGQgctz6KBzEDHttVXd20cl0xv5OoaB1PHKi+Jw3Neu+3yWoPkpE0EsGUk0SN09WR4M0nkSc+o/ve5tgFL9aedYBfJtgA2CcuuNaN2AGi8yJcmjXlcEnsZAMQDU3EH468YuEzg1z9ZyJRNfPteMeBQjt5KEiWoCah3x/NmuYbl4+2JC5Rxr3PZwG4419QDUgcM44IjfmFYR2BLVzif0O2W765pZls/P9Ia50kaM/4r7d3EDTalww1dsrrJb93s3yFr2CukiKwkV7xo+tlicnSlzqCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0WP9MYgxXPuvC+LrBt4lBsoTRIVGjH9C3ZhcX0D0es=;
 b=Ci7EA5Bnqc6V2LJEdqCkF+dhe42dNs6cUH+xYXqAuRP0TEFysW8IYttPg+Maghceqc0m65xAMEF+OgtClbC68hBePVIPsJCN0NLHrdXZ3wWbqLbTq3EH/88RmEyjPF937SLYyD2n6j6eCICyDuc5BWtkycGpHeSDLR36ND9gbfg=
Received: from DS7PR03CA0050.namprd03.prod.outlook.com (2603:10b6:5:3b5::25)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 14:00:09 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::fb) by DS7PR03CA0050.outlook.office365.com
 (2603:10b6:5:3b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 14:00:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 14:00:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 09:00:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 09:00:07 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 09:00:02 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        <amadeuszx.slawinski@linux.intel.com>, <dan.carpenter@linaro.org>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: amd: acp: correct the format order
Date:   Tue, 31 Oct 2023 19:29:33 +0530
Message-ID: <20231031135949.1064581-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
References: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: fb15636f-49a4-4db3-62e9-08dbda19b1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lr40BLkpKnF1FE9yQIToM77dsM7z13JrUSS5OHXwXbI3FdnpRpQqySXqTF8qdcSTQCxNWH3rQ5upT9p4oqH2Q00xaUqAYVfxhss7jlO85pU5yNisNDYELMl+pHxYgfIAY9PxzSr8EcD0ahl7+a/nqdTOuav/F0+OXrHjjKxW97xTofGq+BRMQMmvFqRcFNMrZHeHDejjWfm7xs5GQiZChTB/iAwW73JkAmwX1fZPYc91fxrhOvODQJSrxcl1/WtSrl3YB9TEryylbRmNAFC57UeyClet/iMr5SbYQn2+8wmk7sKTfxF9Cam4cGZqvVqfLA2emvduyGWse6v5OqF7fe/+rE/qNhVqDJMPjNuj1ifvF5TzKsg0+P7GztJqopR3nEonydnvJioCvLnzEZR3Da8XuAlHlw8jK6htGA2Q63b2uEYBnFeqN8F/BYHhpqSeZ8zyqYSpDDU6bQ32t3Gi5QiNDCm4a0BfADOCbnKn9XPtAK+T+ulI7tyJIyVU45wF2ucIyvSHT6dmx/HpTrT3kc36xJPbgmCVz/W+EGjhhwrjZEyuOVt8te+IdD0eIrsK0EJZ8TimKisiaGjAbYdzWoFuX0R0ygJfCeYU0Y2AG9a9+rYIsIfoze6ijD/aGXXa+piGlsQ65I6XVkhse8NHDcBhjuDHB9vcA8/3vDb4M1RhA8OByhDOlo3wzczswzJ80lTo1Cnhappz30Ggw4SNB43M5CsETeKElOGSZoAt4utZ/vdPxgYWsYaLIYCHxfilNc/LiJ2682h90HLQk8e88g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(5660300002)(7416002)(41300700001)(8936002)(4326008)(8676002)(86362001)(40480700001)(36756003)(82740400003)(316002)(6666004)(54906003)(36860700001)(356005)(47076005)(81166007)(70586007)(70206006)(110136005)(2616005)(426003)(1076003)(336012)(26005)(83380400001)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:00:09.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb15636f-49a4-4db3-62e9-08dbda19b1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the formats order for dai driver structures.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp70.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 1d699c96f619..0d7cdd4017e5 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -52,8 +52,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.playback = {
 		.stream_name = "I2S SP Playback",
 		.rates = SNDRV_PCM_RATE_8000_96000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 8,
 		.rate_min = 8000,
@@ -62,8 +62,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.capture = {
 		.stream_name = "I2S SP Capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 2,
 		.rate_min = 8000,
@@ -77,8 +77,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.playback = {
 		.stream_name = "I2S BT Playback",
 		.rates = SNDRV_PCM_RATE_8000_96000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 8,
 		.rate_min = 8000,
@@ -87,8 +87,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.capture = {
 		.stream_name = "I2S BT Capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 2,
 		.rate_min = 8000,
@@ -102,8 +102,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.playback = {
 		.stream_name = "I2S HS Playback",
 		.rates = SNDRV_PCM_RATE_8000_96000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 8,
 		.rate_min = 8000,
@@ -112,8 +112,8 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 	.capture = {
 		.stream_name = "I2S HS Capture",
 		.rates = SNDRV_PCM_RATE_8000_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
-			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 		.channels_min = 2,
 		.channels_max = 8,
 		.rate_min = 8000,
-- 
2.25.1

