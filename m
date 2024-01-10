Return-Path: <linux-kernel+bounces-21916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54282968B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCEFB25609
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A323F8CA;
	Wed, 10 Jan 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHpGxhto"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0E23EA8E;
	Wed, 10 Jan 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4zQLTnDe27Fs8l2uCwtyraOsR4Ch0hh1mNDa6+i/jCb3cF7XSP0Z0DeG6p/S+pNM3ihphrJuxsn87Xpxrhs7ICBJik+dXo38d8dzXfQ/R1fYcun5HX/HLAP8HnvJwAymT073bfnELOde+dnYfouO6DxvOXKn4zIJxBiWZRxLZqYoaEDeGBeRwFbDmDQNaMsLXDZbnX+xoqEQwCxN07toyHQdCD7238LEZ+BJ3vmT2P2PobBeuuh/Wh1avBG7TVu2XhxQPiQTHnT2W7Kg2jsqyCyXK7NEG16QaxLByYCkMK5l5VzdJhyg7t5DKWLSJBlkyRaDGoPN717flLl8FldXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=JehLK8/ICNbx5BwLb2Hn33gUrBp7zn+z7QhTp/tvbDwj1ugVwy+ySPmq7XWQDNVrdsCpPFvVP8iTzZBx6JA/IByBxwVdGB8a5bYEktWfIipNp9EZyn3gNH5p7+pVkBAx3OzjuzaTCmDkCid/pDq7E9s/qY/PVPcv8GVfCDmtMXUjlD/a/G+OMTyhduH3yJmgXnvtnXEN5uFlvVhLGCU/prtMS7KbeviJl6ZVC62h8JGUe28cdz7esw7KRVmrklJen9JPL0zjFVl8gjC0PFW876jwMTms+8pO7R3qmIOtwB2hpuNRVfiCdIDyNFoVZ/u+no27HC5GSP2Tk4CLXhgISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtvoCZz8VSf1VRSZDCxvonKGlPrjlVR/2Z+SSopunkg=;
 b=NHpGxhtoKo5GHAVD1d/ubVFw/ly6N2JkZkgxuMp0n2LKpk/8PpIgPOPlm2sNicOsOXYghpwkluA5WPCCyI7fi6Ajq4jJFqY0gk/3173bn0Q/LaxWZJHInW4Qsgn9CMgrxYvKRHKOvILP5pu0lgqnq7t6oJYDKoH/GBrZTubrk9I=
Received: from SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::15)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 09:46:56 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::d6) by SA9P223CA0010.outlook.office365.com
 (2603:10b6:806:26::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 09:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:46:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:46:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:46:49 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:46:44 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 11/13] ASoC: SOF: amd: update descriptor fields for acp6.3 based platform
Date: Wed, 10 Jan 2024 15:14:14 +0530
Message-ID: <20240110094416.853610-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: f58dc5a6-566f-4b7b-ce00-08dc11c11552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AdlMhybT+lJsQ7VedMlpOXRppStFPQ+9k336XeQ6UIswPSFaftaHnksJh9cXfjgrPhWg/N/lz7a3QvU+KzkaBwqrB3H1rULzIpSPNbyv6HXDxxFZaAo2qqYXEI5q/MdBZTg+R/bqcmgq9EW74DXMM0DQGV2+yENByfN0/Eu7I88pyE8WSQxrDKX9Vm9xaG9mmulSanmnFBF9LvhXU9T7pPzFxyFiMQVKa+oyjCd0hw/e1Jtytok4lnl0bd2HAl/0Oh1wmKAoT8geVAtwKynLnKxjdYWKJydQUTpvjvYSfH6jV5qrt4pfVxRmoaH4/4wuT8mLUYAdSEl3c0+UQ28YXxZFuTKVTIn6uQ/HIkJw6K+IfPF6GT7iM1b0TXJeCqaLxa/B/KS6/G34UltAsUplhr+YYAvWV7c8iOZ9i3oao8k7aONovE00jicIOr1+C0mkiGhZeEtBsyYFbL+Exk6OMbzJkFCuo9JySchOQ5IfIGocYMuITgJ2O6EVt070opwetYEveLdXWrSsZc2+QaespeKhty6mp3nfCd1hVLduoCD6cKEAY0nFYVChTySbKxD+9olYHf1UOtA2DQNdE6Vd+FoGswniryjli2ODRNYqRNuaaz/wVL/CGmde9KwKdeVIWTFHLjodMjCQsafqiBofnXrOO8L1gDxuZnBUsY8SyfpCFFCXQSV3yfVx11esJ2iyMrLnTZTfQzH3mo1IUZ2tKjSUZ1rUB9532SFTo9W3gDetBYWiOZ2I2R8XIek6VLUHi6E44NYJOdK+hNiLcjbdNwe/ECMwdv2NDAtGREA6kcafk7um7Gx9i9h/15+l6nlo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(15650500001)(2906002)(5660300002)(7416002)(8676002)(478600001)(6666004)(2616005)(426003)(336012)(26005)(1076003)(7696005)(86362001)(70206006)(41300700001)(8936002)(316002)(70586007)(110136005)(54906003)(36756003)(36860700001)(82740400003)(81166007)(83380400001)(47076005)(4326008)(356005)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:46:56.2470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58dc5a6-566f-4b7b-ce00-08dc11c11552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

Update acp descriptor fields for acp6.3 version based platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h | 3 +++
 sound/soc/sof/amd/acp.h            | 2 ++
 sound/soc/sof/amd/pci-acp63.c      | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 7ba6492b8e99..c1bdc028a61a 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -65,7 +65,10 @@
 /* Registers from ACP_INTR block */
 #define ACP3X_EXT_INTR_STAT			0x1808
 #define ACP5X_EXT_INTR_STAT			0x1808
+#define ACP6X_EXTERNAL_INTR_ENB			0x1A00
+#define ACP6X_EXTERNAL_INTR_CNTL		0x1A04
 #define ACP6X_EXT_INTR_STAT                     0x1A0C
+#define ACP6X_EXT_INTR_STAT1			0x1A10
 
 #define ACP3X_DSP_SW_INTR_BASE			0x1814
 #define ACP5X_DSP_SW_INTR_BASE			0x1814
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2058dae32659..e94713d7ff1d 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -96,8 +96,10 @@
 #define ACP_ERROR_IRQ_MASK			BIT(29)
 #define ACP_SDW0_IRQ_MASK			BIT(21)
 #define ACP_SDW1_IRQ_MASK			BIT(2)
+#define SDW_ACPI_ADDR_ACP63			5
 #define ACP_DEFAULT_SRAM_LENGTH			0x00080000
 #define ACP_SRAM_PAGE_COUNT			128
+#define ACP6X_SDW_MAX_MANAGER_COUNT		2
 
 enum clock_source {
 	ACP_CLOCK_96M = 0,
diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
index bceb94ac80a9..eeaa12cceb23 100644
--- a/sound/soc/sof/amd/pci-acp63.c
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -31,12 +31,19 @@ static const struct sof_amd_acp_desc acp63_chip_info = {
 	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_ACP63,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
+	.ext_intr_enb = ACP6X_EXTERNAL_INTR_ENB,
+	.ext_intr_cntl = ACP6X_EXTERNAL_INTR_CNTL,
 	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
+	.ext_intr_stat1	= ACP6X_EXT_INTR_STAT1,
 	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
 	.sram_pte_offset = ACP6X_SRAM_PTE_OFFSET,
 	.hw_semaphore_offset = ACP6X_AXI2DAGB_SEM_0,
 	.fusion_dsp_offset = ACP6X_DSP_FUSION_RUNSTALL,
 	.probe_reg_offset = ACP6X_FUTURE_REG_ACLK_0,
+	.sdw_max_link_count = ACP6X_SDW_MAX_MANAGER_COUNT,
+	.sdw_acpi_dev_addr = SDW_ACPI_ADDR_ACP63,
+	.reg_start_addr = ACP6x_REG_START,
+	.reg_end_addr = ACP6x_REG_END,
 };
 
 static const struct sof_dev_desc acp63_desc = {
-- 
2.34.1


