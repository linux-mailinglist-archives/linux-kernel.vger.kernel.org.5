Return-Path: <linux-kernel+bounces-166535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9698B9BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC611F223CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7313C692;
	Thu,  2 May 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bs08X5GR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942813C67F;
	Thu,  2 May 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658633; cv=fail; b=A0zsw4J+q6AewKAAsTapgn6IlzRj/1uGZ8H58PnVFRTQkCiCJorzpHFeAg4jS0cm+ir6kZDbZUawqgK75Y627uTZKLlpglb5e05/Mv23K5m63WLmJWlgUU82xyhd+q3CvQYuLEnzXt+gT2zYlQLds5XZUN2NM1O7gAis4JtqUGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658633; c=relaxed/simple;
	bh=ZTxu7uZxc6ISaRj+4/BeB2+EuLKdRJdsEnYNeyCuAYg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rp1s5wquMcuMoo8f/xof+clOuJt+6S/P5KfpnDJeU/FoCZbo+soQeQvPomUduvsumWIuapsMQ+It8/bHXthN5GbQP2BBgVY/BgStyjAR+rorZzMZG9u8TOQtukuZc9+w+ZlIvHLbZCgdR2fJP+ZJdGdvmNk7CZSxc16ObjEw3TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bs08X5GR; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/L/y15mXmnJfsuhH2sPfJ2vJWldZyRFni8d5owbXUofwmiqI2nr68bFQ9VwL9ih9vhFgrHj2bEy/+J0wp/sTu1C0+JoXuSQF86vtU9fjbyZ10oXKKru/F6EmI6OQ+cEc8xSqCiWt0B3JEpXJDALf3cUCkqHNbVsSYlgQfF9aaHDXk7+2OmMd3RnwErulkcjrvqoPkwfaIJFofA+3A7J5oZVz8OkdpjBcDRYOLJZDkw+Z8cmdRTUOlP6Lev6BdsWMf+HcvgpuDTOH87aRCxcYkr56NLDhrA8ZQpOcZQI0LsyG1MLNSkyVW+I2kOHjYUPUtLtKV8qAMq5PCnT+GmX6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1JnR2jPJSbQHLR0tQigxPxW+xDBTYKUcH0LUpiCJxE=;
 b=ehJK4q2rDm1kQd4jIxWDeRIg9a6WC3FF7rbb+sdBJF6B4DAslYvqhLQqeM0M2Dju2QUuTTWHaf90iLyLaD0V0W0aiSUnAthJ4QwuzOR3N/bb06UwWW+W3d1TBkF5QBLxX1ocL2tj/90BFJ22soKZ5nxp3jqWSQPSVvYRYfs7Wnf7vmuADHXtQkAWyQ/6vpY2hVqTpRWs3Toxk/ADHV4ynVbbgEoN+kJzxGQetvAmXOYmHd6qPN5AfRlQ14tB2gf4sw9nYI5w7tdBTOn+Di/dGB8dydIfleKld935U2UqNogoLD/ANkWNjDJ2/h1/oEu8D976vnumRexbJnNkMn3z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1JnR2jPJSbQHLR0tQigxPxW+xDBTYKUcH0LUpiCJxE=;
 b=bs08X5GRATfTCYi1yn03G8jxfCNZRiPB8UwO1OV4ZSX4OjYJH/dZ9/JkXrUs9FKVBcpCnRI5b7jIZbQl7uaRmsxY8vxPeDWa7rBXmqWMh28jMJN1AqKf9vGYdTayrEtvFYwoDrV+0/WLcFKktIPHu0WLyPZcL3PFQo1CtbhL6mc=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 14:03:46 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::aa) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 14:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 14:03:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 09:03:45 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Thu, 2 May 2024 09:03:41 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, V Sujith Kumar Reddy
	<vsujithkumar.reddy@amd.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Jarkko Nikula <jarkko.nikula@bitmer.com>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: acp: fix for acp platform device creation failure
Date: Thu, 2 May 2024 19:33:25 +0530
Message-ID: <20240502140340.4049021-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c82d85-a9b4-4241-e42a-08dc6ab0aee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WPCA2G/Z1ijDmU9JMuu44zZHvtqb85rWZ9WqE2PMbw4jtqvHXtWRL3IGoeRf?=
 =?us-ascii?Q?E+EgDbYk+/yUY+XULvuUXQlLdBbFnZEQC5W/mYWhBrT6TnQVAWx8i5aYqhpE?=
 =?us-ascii?Q?1nQd8+YkLGDz9TzC36GgA/zcxR4lRP/m3WW74MotT0fx7pxTskp5OBDyc9XT?=
 =?us-ascii?Q?OIEi73tt/L6h7CKAntHI50tySWTNQFx3k1T56tHYREGrIT65ZrFT3XRKCpnt?=
 =?us-ascii?Q?zb5JmX728kXhZ0hDM0rJCMmFLFZfoE//v+Ld+6tVC37BKSTauhfcygPseewU?=
 =?us-ascii?Q?oSo/TAINrH1nxwCVjwihbQYMNjoXAAvBy9ZZG1wP2e2C56hkcIF+uHdFypPJ?=
 =?us-ascii?Q?K393BRDToyUkP/Okv+vAq6XNEXR+1MAUuFd34nzA5ShGIB2pCUw00R3CGwuE?=
 =?us-ascii?Q?fUvcaM3yAz6gcBoOt5qfxNBh7wG4lYzEiM9Cc+R+qyOkIkIKK7cNbvIB9+WH?=
 =?us-ascii?Q?dbcW1BriSo3d03muaWGMpzuqZ3lgz7NkwI5Pw66/c3XNWyZAXt/Znu43/4j9?=
 =?us-ascii?Q?85xxEROy35TABHRMBH1+SVJ2qEIgVTr098x4zMpvdTDz2WyZdmRFQiFXMCsr?=
 =?us-ascii?Q?WA8zkPtmOE7JigSyavz7DxsqR0SqtqqWDaHsYxYydFXmbaVhjH0qQe1EJmtM?=
 =?us-ascii?Q?ZO7utKjqt1rB6mPvogv+kSh1Vmt16tdgWmaRyd90pi5639JxA7pg+euRVtye?=
 =?us-ascii?Q?m3or0rutlL++fM6UQveVltJuIlOtee4V1/q/1+0Ncv+MVBnD4wDMDpL2J0mt?=
 =?us-ascii?Q?SZWkU6QInNbqN9imgAFf6b6drvdmBYrrXCI+xomaOC1aVHpmR/uaQ+kgeHHz?=
 =?us-ascii?Q?E0hGY7RUhBR1M48dNJKVJ2CmA0bUzguqREXUKABFC9BKJoeMIHQO4sINH6Po?=
 =?us-ascii?Q?kHDfYnUyjPYStFOqc4q96ihG8wkDWA7yDXh+l6GTvC9ncZUgAM8T/gVl8Bpd?=
 =?us-ascii?Q?1FyV9RfVFGoKJHsf6Je+111dmUFSVhHr1g6cfSWdMlAtvu1Vzz7MaNgM2OsL?=
 =?us-ascii?Q?1RIl3Hl6B8sTpplmlaSDyP7eB5/LeN+r/+DC/IgEeaZlWzIoAg9u25mLkAwU?=
 =?us-ascii?Q?bQR5/7nkmLcWYd4t1FeSneWWGgh5rakxzWS3yJcTWPmX33b2cR1LSsG3FAhO?=
 =?us-ascii?Q?1Oy9f9cBFISCCdSXaU78WMcwRKHXAoKLWIzoPwnsMed98UO3UlLc6cZejMfF?=
 =?us-ascii?Q?b28o7Bkrmw2gvE8mY0saIfrmExF0z5IL1n8BPynaDYvHOUxZFCOAqG8i3YqT?=
 =?us-ascii?Q?EzknxDWr3QFo4n7EuVpBoEDoKGY+Qop3BhVBGQHLTywpaBxjfR4L0IRSV1vd?=
 =?us-ascii?Q?QFZwkUAeMcYQJb8x9vgVbw0m?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:03:46.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c82d85-a9b4-4241-e42a-08dc6ab0aee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

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
 sound/soc/amd/acp/acp-legacy-common.c | 96 ++++++++++++++++++++++-----
 sound/soc/amd/acp/acp-pci.c           |  9 ++-
 sound/soc/amd/acp/amd.h               | 10 ++-
 sound/soc/amd/acp/chip_offset_byte.h  |  1 +
 4 files changed, 95 insertions(+), 21 deletions(-)

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
index 5f35b90eab8d..ad320b29e87d 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -100,7 +100,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = -EINVAL;
 		goto release_regions;
 	}
-
 	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(dmic_dev)) {
 		dev_err(dev, "failed to create DMIC device\n");
@@ -119,6 +118,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	if (ret)
 		goto unregister_dmic_dev;
 
+	check_acp_config(pci, chip);
+	if (!chip->is_pdm_dev && !chip->is_i2s_config)
+		goto skip_pdev_creation;
+
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
@@ -136,10 +139,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
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


