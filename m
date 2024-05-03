Return-Path: <linux-kernel+bounces-167618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD188BAC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DCB1F22D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC16152DFF;
	Fri,  3 May 2024 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOeLmQSK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7058152DF0;
	Fri,  3 May 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737799; cv=fail; b=mvPGmh81C/ElRiDxQCMBH4khS+gYt0WY2LH/pyaActvfdAz5g+jkcnLhFwtXLnoc4bTHvc57mnCRNgXMhd2hwssF9JBNM0g0LqL6PN5tJymCMv/e82ccQnZlpXonNs+Lf2XWmgZigx4Nc0iXa4kmYj37KWf/lJ88uYFXutuhQms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737799; c=relaxed/simple;
	bh=7Mrxn0c2Of15FvtOLnDftYna3fbVbc+E96tx5ROV0oA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EOAxVW6Wpw1NlPFB7xU8zCqk7Cx10nPr2McduK/+fAwbRh4wv3VZ6yD3k0t1Nb3pnYbpwjQfRqQkfGfU7ZC9p1+d5o9c3OmrJd5X8y0mdACL5Gj2bUXxgdHWbpFvNYM9f+d3IglGP3knyFZzuUejdvMb7aEfMVjJOnXO86oQ74s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nOeLmQSK; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dx6gnYOC+x+EPu5szRjXxadDqmMbl3bZ2yecR+pHr+YaM5vscZ/KhMC5QurA97Qd+hiszB3dWoSuY18nIU/VzTouIIpXNZPa0S/w+Gvntoc58GEFNd1qVoSwmjrPJIybVcY58okpPuhv/vc83qxnCPqLETjlGyAfLlxTloN2E/4B2bLBOZRXQhVy1/lVNkCa9Yh6wYZKpdAJRddQDdWK9zIZADA6VAf5IrSkXCohvFHpJ/CdP9+VswZOgxUIb9FBqWFcY6az1ryvR4H1g3HmjzwUGwicb92XHOQcqbDGtz6K01cU+HLcCITopoGuGl2ronGLXr2xKQBf2hCGozAuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6lu8rsZi0fmvOJfipimJkSPCmlepObwC5L47W85CmQ=;
 b=n5tm2eeweI3+QcsZPQomy5WlsuKfWHIx4HC/INAGLYiGVsBmUrX3ScmXO+DJZkWzFf9JR2lcV5XJvhrpFl52p7PBwJK2Tpg2t91FYWftSHe7UsZeFEwv36YEe7taBi7EgqrbrxtRGbiRPCfofM5pUC4efheU/xc7TPZ8J9SeWZzQylM1tWExV5BPUmjinHtDe+nO6RB1cTplnCQ5lWVBemrGK+KeAwNevGm2MlaXp8CJDzj9HuWvA8ZzeTwkAMCxUVsiDG+x7xMxuighhzeNG4tTjZNDjES8d7ZpYACXdDIaikTtXhTxxnGe68TYIJ4xLEeyZB2LkrKx6/Et69Ygzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6lu8rsZi0fmvOJfipimJkSPCmlepObwC5L47W85CmQ=;
 b=nOeLmQSKyVXIZM5NAOTUuogZ/gXQTSsi8ExRz5YeZ6qZk5wJ9de/CIvHS0yuLWz2N1S6k7xDuhSXqSk3IgEb1WSQMjmENcbHO5CjNcM4eK2QGIbsOwbF/RzjurOCKwSF7x0eWEIKsMpxj6fuur7qqpsk+KaZh3K8+ogz6pfSiJY=
Received: from BY5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:a03:1a0::49)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 12:03:12 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::67) by BY5PR16CA0036.outlook.office365.com
 (2603:10b6:a03:1a0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32 via Frontend
 Transport; Fri, 3 May 2024 12:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 12:03:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 07:03:11 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Fri, 3 May 2024 07:03:07 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, V Sujith Kumar Reddy
	<vsujithkumar.reddy@amd.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/2] ASoC: amd: acp: fix for acp platform device creation failure
Date: Fri, 3 May 2024 17:32:52 +0530
Message-ID: <20240503120306.4300-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 736498e9-5aab-4196-32ac-08dc6b6901a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GtzSIRFZWs+TT1GnVz+cf/KZT1WBvDWztUopJiCrJzMzQ8E522rdWWPqcOF1?=
 =?us-ascii?Q?ouHN4ZcEYQKwh9IRf7LtWKaeWQxt49S0N3g4Rw6dRozH8xQ4mKuqXeTR/1x+?=
 =?us-ascii?Q?fUk2qiwsGZD3t4SEfN3QxoRs5UdmIjm71pHcvNhVEur1BfQ8VzHVPi1bScaW?=
 =?us-ascii?Q?9AQ1IilODeQpkcKQKS3nFQGIJDPrTa/TnCjP6GmE4uzsrcLxpQ4wTWweSEGA?=
 =?us-ascii?Q?58LMqKlzSCw3J5z9HpzeRkmfwn4vQxkVjX85z7a7bA9rTFJGqeGlaldrDoh/?=
 =?us-ascii?Q?UjX5dfNdDhrXlCULnx+Mw661hiezAf1/X9u/+WdFu5qXhqcFYhzdGSukc0lq?=
 =?us-ascii?Q?ffe7xQ+hvQiUJAKF0aJqGvZxF5DIFBgBuONgKsD1frXIv8G5BiafOC56t4Cy?=
 =?us-ascii?Q?XpyKOlVBSDuUXjBGj9bCR1sTeqm0og/uKk8Vem3qpk5IvihJub7Nu7wFP/Wh?=
 =?us-ascii?Q?87u3xQU1p3kjNAN8J+Yi/lWxpys/yCM+/M+s82AWuiaXzY7u7NlI7rdvmu1/?=
 =?us-ascii?Q?V/Mq0u5EETVswmqzXcQLgnBlWDyqwnI3AMNc7IatSZOHj1VnVoFsgmHtCJ+y?=
 =?us-ascii?Q?XKD0QP4FZgc26mPXvkhcTx6Zr7kl2qSzRS0H1PTO11Ix9A/damtrbQKtOX+9?=
 =?us-ascii?Q?rTW/kTPyMsBGGd3be+GbCpuOlkeYN1XEc8DzuEheuCw0gVUWcveUWYgOTacX?=
 =?us-ascii?Q?TQOYpx+kuwD8pN0BOrw5I36paJCCOZ0MU4r99qacQrIThKoWV/wuVxVeTQ+0?=
 =?us-ascii?Q?+6W9Jr0J9PtiDGod/siP1SADAXjmv7wzmfs7NwQK9WdEZ6Kn3dDyjvO43fG9?=
 =?us-ascii?Q?9BbTauX5h4gx2p0Hb3so03JDaMjhUA1VDsbgUGt+E8IJ9679TbNgbUuVZFyv?=
 =?us-ascii?Q?yljOMVJYe5uAIkvyUVr6tXLSgLUPtc6BEwmmWtNSoU6WhpGvDzbMnARkUIth?=
 =?us-ascii?Q?eQnw9KZuZquCuCjt70vRvmGeKVxjEsgGRRmYxuFAmj+Sk9zSMRh+q1dBkpQI?=
 =?us-ascii?Q?Nmai+f+0ViBDqfFSGItrbKGZsMGc7TRfinLpVZ/AhD72soFEaJOl+fqeOLQb?=
 =?us-ascii?Q?voCdlI3PC1pwBSXPyMQsatRvmTjNyUg7rB37VW0yrbeI9L6RtcjP+G2oFKyg?=
 =?us-ascii?Q?98fgTYdMvzV4syW3d5E53ScR0fIAFpaC24aNSYg92SDaKT8yS41OXVLTsgLJ?=
 =?us-ascii?Q?m8DWxXUlvVXWneYf/CpvGl2ip0HTNFuqInGLq/Mgduv2RkSC5yX5eoQCYWrb?=
 =?us-ascii?Q?ko5DDrHwB4V7H3nYONRq5HOmpEQDMgMjYZdh6/PEOZcjCl7afa2D45oVdqlP?=
 =?us-ascii?Q?KWHjl4CbfMhqMyi0s7DBcNk9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:03:12.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736498e9-5aab-4196-32ac-08dc6b6901a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

ACP pin configuration varies based on acp version.
ACP PCI driver should read the ACP PIN config value and based on config
value, it has to create a platform device in below two conditions.
1) If ACP PDM configuration is selected from BIOS and ACP PDM controller
exists.
2) If ACP I2S configuration is selected from BIOS.

Other than above scenarios, ACP PCI driver should skip the platform
device creation logic, i.e. ACP PCI driver probe sequence should never
fail if other acp pin configuration is selected. It should skip platform
device creation logic.

check_acp_pdm() function was implemented for ACP6.x platforms to check
ACP PDM configuration. Previously, this code was safe guarded by
FLAG_AMD_LEGACY_ONLY_DMIC flag check.

This implementation breaks audio use cases for Huawei Matebooks which are
based on ACP3.x varaint uses I2S configuration.
In current scenario, check_acp_pdm() function returns -ENODEV value
which results in ACP PCI driver probe failure without creating a platform
device even in case of valid ACP pin configuration.

Implement check_acp_config() as a common function which invokes platform
specific acp pin configuration check functions for ACP3.x, ACP6.0 & ACP6.3
& ACP7.0 variants and checks for ACP PDM controller.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218780
Fixes: 4af565de9f8c ("ASoC: amd: acp: fix for acp pdm configuration check")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
changes since v1:
	- drop white line change which is not relevant to this patch.
 
 sound/soc/amd/acp/acp-legacy-common.c | 96 ++++++++++++++++++++++-----
 sound/soc/amd/acp/acp-pci.c           |  8 +--
 sound/soc/amd/acp/amd.h               | 10 ++-
 sound/soc/amd/acp/chip_offset_byte.h  |  1 +
 4 files changed, 95 insertions(+), 20 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index b5aff3f230be..3be7c6d55a6f 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -358,11 +358,25 @@ int smn_read(struct pci_dev *dev, u32 smn_addr)
 }
 EXPORT_SYMBOL_NS_GPL(smn_read, SND_SOC_ACP_COMMON);
 
-int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
+static void check_acp3x_config(struct acp_chip_info *chip)
 {
-	struct acpi_device *pdm_dev;
-	const union acpi_object *obj;
-	u32 pdm_addr, val;
+	u32 val;
+
+	val = readl(chip->base + ACP3X_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_4:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
+		break;
+	default:
+		chip->is_pdm_config = true;
+		break;
+	}
+}
+
+static void check_acp6x_config(struct acp_chip_info *chip)
+{
+	u32 val;
 
 	val = readl(chip->base + ACP_PIN_CONFIG);
 	switch (val) {
@@ -371,42 +385,94 @@ int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
 	case ACP_CONFIG_6:
 	case ACP_CONFIG_7:
 	case ACP_CONFIG_8:
-	case ACP_CONFIG_10:
 	case ACP_CONFIG_11:
+	case ACP_CONFIG_14:
+		chip->is_pdm_config = true;
+		break;
+	case ACP_CONFIG_9:
+		chip->is_i2s_config = true;
+		break;
+	case ACP_CONFIG_10:
 	case ACP_CONFIG_12:
 	case ACP_CONFIG_13:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
+		break;
+	default:
+		break;
+	}
+}
+
+static void check_acp70_config(struct acp_chip_info *chip)
+{
+	u32 val;
+
+	val = readl(chip->base + ACP_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_4:
+	case ACP_CONFIG_5:
+	case ACP_CONFIG_6:
+	case ACP_CONFIG_7:
+	case ACP_CONFIG_8:
+	case ACP_CONFIG_11:
 	case ACP_CONFIG_14:
+	case ACP_CONFIG_17:
+	case ACP_CONFIG_18:
+		chip->is_pdm_config = true;
+		break;
+	case ACP_CONFIG_9:
+		chip->is_i2s_config = true;
+		break;
+	case ACP_CONFIG_10:
+	case ACP_CONFIG_12:
+	case ACP_CONFIG_13:
+	case ACP_CONFIG_19:
+	case ACP_CONFIG_20:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
+}
+
+void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
+{
+	struct acpi_device *pdm_dev;
+	const union acpi_object *obj;
+	u32 pdm_addr;
 
 	switch (chip->acp_rev) {
 	case ACP3X_DEV:
 		pdm_addr = ACP_RENOIR_PDM_ADDR;
+		check_acp3x_config(chip);
 		break;
 	case ACP6X_DEV:
 		pdm_addr = ACP_REMBRANDT_PDM_ADDR;
+		check_acp6x_config(chip);
 		break;
 	case ACP63_DEV:
 		pdm_addr = ACP63_PDM_ADDR;
+		check_acp6x_config(chip);
 		break;
 	case ACP70_DEV:
 		pdm_addr = ACP70_PDM_ADDR;
+		check_acp70_config(chip);
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
-	if (pdm_dev) {
-		if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
-					   ACPI_TYPE_INTEGER, &obj) &&
-					   obj->integer.value == pdm_addr)
-			return 0;
+	if (chip->is_pdm_config) {
+		pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
+		if (pdm_dev) {
+			if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
+						   ACPI_TYPE_INTEGER, &obj) &&
+						   obj->integer.value == pdm_addr)
+				chip->is_pdm_dev = true;
+		}
 	}
-	return -ENODEV;
 }
-EXPORT_SYMBOL_NS_GPL(check_acp_pdm, SND_SOC_ACP_COMMON);
+EXPORT_SYMBOL_NS_GPL(check_acp_config, SND_SOC_ACP_COMMON);
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 5f35b90eab8d..d8314d2b331b 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -119,6 +119,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	if (ret)
 		goto unregister_dmic_dev;
 
+	check_acp_config(pci, chip);
+	if (!chip->is_pdm_dev && !chip->is_i2s_config)
+		goto skip_pdev_creation;
+
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
@@ -136,10 +140,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
-	ret = check_acp_pdm(pci, chip);
-	if (ret < 0)
-		goto skip_pdev_creation;
-
 	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5017e868f39b..d75b4eb34de8 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -138,6 +138,9 @@ struct acp_chip_info {
 	void __iomem *base;	/* ACP memory PCI base */
 	struct platform_device *chip_pdev;
 	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
+	bool is_pdm_dev;	/* flag set to true when ACP PDM controller exists */
+	bool is_pdm_config;	/* flag set to true when PDM configuration is selected from BIOS */
+	bool is_i2s_config;	/* flag set to true when I2S configuration is selected from BIOS */
 };
 
 struct acp_stream {
@@ -212,6 +215,11 @@ enum acp_config {
 	ACP_CONFIG_13,
 	ACP_CONFIG_14,
 	ACP_CONFIG_15,
+	ACP_CONFIG_16,
+	ACP_CONFIG_17,
+	ACP_CONFIG_18,
+	ACP_CONFIG_19,
+	ACP_CONFIG_20,
 };
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
@@ -240,7 +248,7 @@ void restore_acp_pdm_params(struct snd_pcm_substream *substream,
 int restore_acp_i2s_params(struct snd_pcm_substream *substream,
 			   struct acp_dev_data *adata, struct acp_stream *stream);
 
-int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip);
+void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip);
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index cfd6c4d07594..18da734c0e9e 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -20,6 +20,7 @@
 #define ACP_SOFT_RESET                          0x1000
 #define ACP_CONTROL                             0x1004
 #define ACP_PIN_CONFIG				0x1440
+#define ACP3X_PIN_CONFIG			0x1400
 
 #define ACP_EXTERNAL_INTR_REG_ADDR(adata, offset, ctrl) \
 	(adata->acp_base + adata->rsrc->irq_reg_offset + offset + (ctrl * 0x04))
-- 
2.34.1


