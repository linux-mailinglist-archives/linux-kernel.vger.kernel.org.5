Return-Path: <linux-kernel+bounces-5076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CB818648
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50F01C23A89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149B917758;
	Tue, 19 Dec 2023 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eAb7MjKy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF617752;
	Tue, 19 Dec 2023 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdvAQ2s2hvRlc9CDc/VX1pCCQVE7il+cIruEdUNyphq/ZeGVHgDdeBBzSfWzN6elCyt1v/0s57iqKre9UsAIc8qicURI/7YdTuGWAcicuvwUu2qWHmqWR1VookQOnGdtHGEmp8ndGAfaZSZJ0wGiTnKASouJPLLAJuOK8xdjWMsltDG70ndV4pXayzWGjLjF2p+qgTZIqZS5qCm3VbbDhL9HqD+nXmMYk4eV3DXfPe7ztjz1TMmkzO/Mqrj3L8pbhhDx5BfG+38CPE+okMQ0/Jwn3OXAtVHJd+TocLsQTErQZvaK6wtrhA4mujF4K/KzoW4gtHyBUwqNUgQ4r2nt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2FbWCdmt5+iDcoEXvI56ETEQOMnzw8gw1R8//Oy1Ik=;
 b=kWZQbzXKIbtpScvhyIdZaxds0skUWa/n621ZyIV4NpDKlrXI+MSdc5i5ZthU0RAXzUEZw/KpMxk82noZtO60WE0o09hAfwErgbWu5RUQqSiynh28xOFlCeldkvyQ2BH6HRSC0hx26s38Nw4b4kfwerSYrO1ycOGWDMdWIQ+HGat9oGj5n0mVd4FWFMkFewD0imOIWKTnNhbuubBdZdLrHj7kR8how8F9MfMwcG8pxOmRvNjQxt16Ldjunu1n3QLfPUn92S266z1XjapDEprVGK3kjrN83r4FV9kB6303ri/bP3YZTqIjHcW+EMx7Em4/DqPYrSJM4/fZ9c7GtpF+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2FbWCdmt5+iDcoEXvI56ETEQOMnzw8gw1R8//Oy1Ik=;
 b=eAb7MjKyNBu0tEd6w9HoSteak863DpoJisjuVEGVOUI+Z99kzuA1+aTtsZR+Vk0w3KOd+UL+eyNUA7w9a09qiKAqAZau3v49Jb6x7xE5ceu3NxBD8YQ1xE0vxjAU7EqcFRO+jz+bQHz2BkM8svRYHYv7IN7wi7Nho41UUK7/usw=
Received: from DM6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:5:1f4::16)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Tue, 19 Dec
 2023 11:24:41 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::cb) by DM6PR02CA0075.outlook.office365.com
 (2603:10b6:5:1f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 11:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 11:24:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 05:24:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 05:24:40 -0600
Received: from prasad-lnx-mach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 19 Dec 2023 05:24:35 -0600
From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <syed.sabakareem@amd.com>,
	<cristian.ciocaltea@collabora.com>, <emil.velikov@collabora.com>, "Venkata
 Prasad Potturu" <venkataprasad.potturu@amd.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND -
 SOUND OPEN FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ASoC: SOF: Rename amd_bt sof_dai_type
Date: Tue, 19 Dec 2023 16:54:12 +0530
Message-ID: <20231219112416.3334928-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
References: <20231219112416.3334928-1-venkataprasad.potturu@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MN2PR12MB4503:EE_
X-MS-Office365-Filtering-Correlation-Id: 553ed143-afb6-4def-ff2f-08dc0085180e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y9jOzOqI+CxfscJG7Qa0E4r9QlZhxi9yidSKx4Lrzs6YQH7RQiIoIFdmdUHH8efmG4Qmh+dtEYyOnQ8V3qV16qdcrOI0WnGb5wwb2i2mZ9sNruL3qIffIaW3fWbo8lNhoTT+eA75YHiKYLJMOCJU4lEhUGL7uV/AMyxtQGBeiD2VGUqAwsVbWNeLjiKcZBhqG4kUSK8vVcooAyMOh9NU9vvTKgnDefNUREwTmYMeq2mhnv9N7Wfg8snNFrosOyLbSE8k1yp+S3MoULV9UitdanbMUv054ViNkVjt79d5PR2r9fSbnXAitfphvonyPuHFgCPO6cxUco9Mh6d/yoQ/PvpQuZKfnREu2N9lkfXEXOOO0A51Dh2FVYvvuQIpqwNZ3zD+s8GjclGUwvktT3i8s7QjamchQvvCptiyNeeAPNEVx3fm8XcdAR1kDEbPIeYnZe4dR5A6c30lZH1a5tlHY5B/mFKw8+vQnmITL/mwtInENATKz3i3iCtBQqh9GHFPWnwvHPmw9bn/3RBf7bWdfeTh4ts+j7xhyOxERdmH+pCVHkAxo7xN6AFnkyubTLGqEzYPTb2dPdrBxLFhbmfANeKgtddVzC0lXbOkXXqCwlqivYLyWmNxKYWSanIwdJ5yc2deH1JDpZIfLW4sxkJfyFLIl3dCWGhAgeczD9Un8Po39UdbCTwTf+l+ISkVwM3tkR2gzSUaMx0P1c1nFHE2pjRkyL3haKFMDPusdjPgRUQvIj46+CSw+8r411yHyKs22/nVfUd28HX1Fiqsoijitg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(4326008)(8936002)(8676002)(5660300002)(4744005)(2906002)(7416002)(6666004)(7696005)(478600001)(110136005)(70586007)(70206006)(54906003)(316002)(41300700001)(356005)(36860700001)(40480700001)(47076005)(86362001)(36756003)(81166007)(82740400003)(40460700003)(426003)(336012)(26005)(1076003)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:24:41.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553ed143-afb6-4def-ff2f-08dc0085180e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503

Rename amd_bt sof_dai_type from ACP to ACP_BT.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 66b271ca6910..617a225fff24 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -289,7 +289,7 @@ static const struct sof_dai_types sof_dais[] = {
 	{"ALH", SOF_DAI_INTEL_ALH},
 	{"SAI", SOF_DAI_IMX_SAI},
 	{"ESAI", SOF_DAI_IMX_ESAI},
-	{"ACP", SOF_DAI_AMD_BT},
+	{"ACPBT", SOF_DAI_AMD_BT},
 	{"ACPSP", SOF_DAI_AMD_SP},
 	{"ACPDMIC", SOF_DAI_AMD_DMIC},
 	{"ACPHS", SOF_DAI_AMD_HS},
-- 
2.25.1


