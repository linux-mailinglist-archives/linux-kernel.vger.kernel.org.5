Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181997DCE90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbjJaOAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbjJaOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:00:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202AFE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBTtngCI4mFbbvqfmR3shGP4MlYOxAU1LYv0qf2gUL74BmaIXPeQ7epxkl1VpsGK6Rr27PiJ9xnrLimlROl/mR5jzQQQlQlGyOBH/ATW5Nj+GMWl77ue1WXc94sod79eUuCdgQ4D+NFO175M15oDxVUyv1LWwo/pLv1niRbYAIYo29B3mVnyi4SEv2Vdh6y7ZkEImnUPQhPJ0Ru34RmR4wq1GAkDW60dqMZcjF+CVC/Lsggf+aB9BXzLNqFqh4InykqkdPd585DazwVhFUmAXDew7lVKPv6SEap4c6eA9EpiwpUKiT6U9ovEGcH0wrsyFtGpiI+2SQ8T0OebtuuO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eFHeEmlja6s76hfAStc7WtN+wV59pQynXlQMMP3eXs=;
 b=WAh3q7mKaA8jbegUtNBDBelrEKnK7SGFkFVqzf/XVkaAbDfh9L3VSbszudbvn9XEamuoO3JlARAQzl1OOJAmqNEhed2gIH6tv2iG8I474pq/vBRRpA/XYSQ6LEapGspDLqmFF8MzIEOVbv1vk3/LFb4mJ3leem5HXv7x0h1Tze3t2xmh74UKaxBdnibupLWADatsShABi6P9s5rQyTuQQxiDWAsvLF0irNv8RTFQIZwhp0Aj3poEz5cu4jcat8pFbpBQQE5503RnaUAkyGv84StbmWVPlYE4aEsByQwcbQuJ5v9cYReKTzrF74unBqLFD4Yt6+YpADkud3MAVC90fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eFHeEmlja6s76hfAStc7WtN+wV59pQynXlQMMP3eXs=;
 b=FFqjZi91SZPK2UT4jep9CfLYlb+v+sTKCj3/QMPiH4uWwXE9ySw/VNhaBRrDVlZWXF97Dkkdm0VCYCJYVnQvNgeHVeN7ANBkN8HqTSps87DJ3U3XvIh+AoiQE5JxNLU+hnb/2fv/CRyHR4orRCKHdx7Krlwgt0Yck/mWQ2nrwpw=
Received: from MW4PR04CA0303.namprd04.prod.outlook.com (2603:10b6:303:82::8)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Tue, 31 Oct
 2023 14:00:32 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:82:cafe::c4) by MW4PR04CA0303.outlook.office365.com
 (2603:10b6:303:82::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Tue, 31 Oct 2023 14:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.3 via Frontend Transport; Tue, 31 Oct 2023 14:00:25 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 09:00:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 31 Oct
 2023 07:00:14 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Tue, 31 Oct 2023 09:00:09 -0500
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
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: amd: acp: fix for i2s mode register field update
Date:   Tue, 31 Oct 2023 19:29:34 +0530
Message-ID: <20231031135949.1064581-3-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
References: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: a610077f-511a-4d67-ab61-08dbda19be89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P14yXyWnDWMUl3P50hfv2+2xJ2mRNz7cb6oTklj4M4LwrM29QD+AzesKnGdidDcNXj50nR8gnvbqnWRo4xohCW3iLOGje7c7yw6D863D5VaD7Me3BYFAvE04VSYwKBjLSTpHoDTkmZ6G6OxsejxNTBQYpfIng8dlLPPQFj+KvKRPt4rqRvuqQDY4GdX7WraZcKKftE50O++mSt6ctwW9ywgdyk9DOE2GBWi14DR/hE5GgXutoMDLw2tQVIZjo01Psm+TW6oq2lXrU72CCkO1+rQoynvf/xjSXsos5PTQ4BHiWhKCsWutQV1NpeGtC0SWUwo73aFRMgS8VVlVU7sIvvi9iY/vf4ZynBw9Ck+Jr9Zi1HzZjb7ag0PmsOwD+1TMadJXtsgPuv73YTYxRY29JhDgBSF+oX6aB5mfiPWBG4vayUd2V9g493v+NaRVeoU9rRSn6Ib3NCiRHo1xKCip+4jr13f9eAb3WHldfmsU+rO9IDzWEGchmQnSuv1utu3jGfQobE2gkUCAl06HR5rzOrbMHGgVku39OydNrrpdljljANT16nm2dl/h1Hx+BEC5Kn64EmZajYZVFCrE41edlJHm2Wf3Q03Unsw4vSEzqm3RaXyMtbvcyTaS+c2jPuuAOXt4lExFA0CBLVlHZhzwpGjNGe19sPjEN8lwRBzIRKNRZi13yZEE4EOaEiDt1SxU5+D/2aDlTSBYn7+oAhIGYDb92jZTlzQovi+VXeLbgvirs89bPOVSlG7r3aftaO9INWf9xFtaa5bPoTmJP7Nkt97uXfRdwRshf9tXiU7/P80fGEZsytij6lecE4tPlhbg
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(15650500001)(40480700001)(2616005)(1076003)(26005)(2906002)(40460700003)(86362001)(36756003)(81166007)(82740400003)(356005)(47076005)(426003)(41300700001)(5660300002)(83380400001)(478600001)(336012)(36860700001)(7696005)(6666004)(8676002)(4326008)(8936002)(316002)(54906003)(70206006)(110136005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 14:00:25.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a610077f-511a-4d67-ab61-08dbda19be89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2S mode register field will be set to 1 when tdm mode is enabled.
Update the I2S mode field based on tdm_mode flag check.

This will fix below smatch checker warning.

sound/soc/amd/acp/acp-i2s.c:59 acp_set_i2s_clk()
	warn: odd binop '0x0 & 0x2'

Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock
	generation code")

Reported-By: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 1185e5aac523..60cbc881be6e 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -26,7 +26,6 @@
 
 #define DRV_NAME "acp_i2s_playcap"
 #define	I2S_MASTER_MODE_ENABLE		1
-#define	I2S_MODE_ENABLE			0
 #define	LRCLK_DIV_FIELD			GENMASK(10, 2)
 #define	BCLK_DIV_FIELD			GENMASK(23, 11)
 #define	ACP63_LRCLK_DIV_FIELD		GENMASK(12, 2)
@@ -56,7 +55,8 @@ static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
 	}
 
 	val  = I2S_MASTER_MODE_ENABLE;
-	val |= I2S_MODE_ENABLE & BIT(1);
+	if (adata->tdm_mode)
+		val |= BIT(1);
 
 	switch (chip->acp_rev) {
 	case ACP63_DEV:
-- 
2.25.1

