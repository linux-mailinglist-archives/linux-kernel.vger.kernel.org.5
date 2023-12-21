Return-Path: <linux-kernel+bounces-7944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C481AF88
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB661C223C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0715AFB;
	Thu, 21 Dec 2023 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uQWdPyTQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4187718038
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2lD03/uqhzsJSnGwW7F0zyXpBpHUzDXnAQ+sHQw7ikVQzk2almW9f1syp6fLSicML6q+l3d0itD43zUt7ksLErAbSrnJ5FoYjZd3mRrlJawXEqkM3p6VMRodmlXzEQCdVz5/BnUguGOBzrmgkkBGeYBw3ALNfFpRRMOnQV5+nEsYvamlnx/IydhFD3TOOr7XtPR5RQ0ftbkiDYv5LGZmpok4oA9/rYbOvE3ISPGRB/L9GoReo+pw4tqlMeAM4c7nze0fUVeLOKjHVnbyHR8UNvgdvHQxmQt+2DqkbebcZ0CW51SOjjybmYc7ULi4/CeRgbnjGNVUZfwiUIq6Er3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQUoh6Ydpzpbpil2mIC9G9IQW2pvBd6dLFDc4nbKJIo=;
 b=fc798MUCyw+sThWmeLZ6qixQ8FG0CYGEbDvPlx0j0VFSRHRxC99QHjP0jLYPuEBi9TGr0y/WKsnXTk7f57Vt0C81BNVnUzuE4SFDLUASNKsPm0f8DzaVHwgpimTjVnz92EttAHeIwN6InPfXtAojCE8DuaZAPD0qLtFHsdiL+Il2sDFnjnHXtcW40wAEjQxBHja5mALNa+tZK6fDYfOLSv6xZkrnknckrQD+IpdanWW3oWdvzO+KSLBRFYglHOAEh0gp9bNH3DBp2su2XsZdVAIuUrBsKKRC55/OqaADUB4ciBQxdt7HvFJwuhhQN8Z0neRb8TRYOX7enVcndzId0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQUoh6Ydpzpbpil2mIC9G9IQW2pvBd6dLFDc4nbKJIo=;
 b=uQWdPyTQzHKSNXsYyrab+fQ5qqchSsLsBKQv8wec9KwKuoWjMwuOYYyMWewBmUkZ91CtoXwzwqOYJXbIV/pTrjFstZbnrOC54ao8IJL2s9FGIyQPa+8N59Urh6TTkmHa1MZjbOQI7u5YK1S2Tn9pLxjFq69ZNilUuIoWD1duDvg=
Received: from MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::22)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 07:37:08 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::43) by MW4P221CA0017.outlook.office365.com
 (2603:10b6:303:8b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 07:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:37:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:01 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:36:50 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:36:36 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 05/12] drivers: soundwire: refactor register mask structure
Date: Thu, 21 Dec 2023 13:05:51 +0530
Message-ID: <20231221073558.3181911-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 049a6f55-036b-4dc4-2539-08dc01f7a277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5q+VxYnVHQz4ZNw+WmuIoDcAqHHr6kG/cZwBN/z7+60OfrpzB8eugalKW794ynk5lSvA20WD0AXaQowzWT9ZJFMnvYHlAXp6LkmuaWStVEjmIeb/l+A/4siSEWlf34ICUl5bFcay2RBTOy0riFHBLDEPC4tpUXB+c64imPCr5ItHczKPeUinK+32GfNtFdvWnsugEklzhQm1tePvT9HO9IGtotJCNBs/6TIiUXmLP16SdOXUnPR1VXiOVwSoeAAVJVhAiDer9DTHHvECdlVDsZ2ENlEYSmwQg2tzxUjtlzNZzJRdsRDxn4u4gE1Y1cU69G9CsbtPkDpwkGpubejS+cNQU0nxC8bldRiCw4pxWp7u21UIQ3bYYPxK+WxvB8eCkXNywaLnBzrUFE7t/jjgAyyfk4SWdyjFNfO+Ts4zqc77EsaU3sFq3ZmZ+iBtHXTMnRkCDIEN9UjWFg3OLzigaz9nJG42L6zGzTjhcIsCDQNoZhYK1J19dgxy+IPJMVIzQEcnk+CT1mlDmNU1+o0yL/gPCThQ9ji+Tpg2FOtK4Sg+nyg1ywwSv06fJY/u2FBXygUZ99b8K8zq5qOAjgcYy81OszL7g46V4KnFShVvGQbbGL9aaNJxxnCdPWvmMdEirqMf/ptAB6rvm0tpHRkBd+MYVVCcSm3lxzc1EQ0+9gi4lhluwbbQh9Pn/kZnDfOVQzAv5v0DepIM8eiSJ6GoH+FdImWqJ4J/BihhsaqPRdUhIhbYl5LuCPGPbTKkpU7kRYmRdwsAcOS4bFmVfC0VtSQzvglHNw5shzqYQQxMYScxV7QkAHmXSsLQ5dNd4N5H
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(6666004)(478600001)(54906003)(110136005)(316002)(8676002)(8936002)(70586007)(70206006)(83380400001)(36860700001)(47076005)(7696005)(1076003)(26005)(336012)(426003)(2616005)(41300700001)(2906002)(4326008)(5660300002)(40480700001)(86362001)(36756003)(82740400003)(81166007)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:37:07.2472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049a6f55-036b-4dc4-2539-08dc01f7a277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

register mask array structure is no longer needed as except
interrupt control masks, rest of the register masks are not
used in code.

use array for interrupt masks instead of structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   |  7 ++-----
 drivers/soundwire/amd_manager.h   | 12 ++----------
 include/linux/soundwire/sdw_amd.h |  8 --------
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 1427cccfc309..36dab5099989 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -86,12 +86,11 @@ static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
 
 static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
-	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
 	u32 val;
 
 	mutex_lock(amd_manager->acp_sdw_lock);
 	val = readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
-	val |= reg_mask->acp_sdw_intr_mask;
+	val |= sdw_manager_reg_mask_array[amd_manager->instance];
 	writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
 	mutex_unlock(amd_manager->acp_sdw_lock);
 
@@ -104,12 +103,11 @@ static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 
 static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
-	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
 	u32 val;
 
 	mutex_lock(amd_manager->acp_sdw_lock);
 	val = readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
-	val &= ~reg_mask->acp_sdw_intr_mask;
+	val &= ~sdw_manager_reg_mask_array[amd_manager->instance];
 	writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
 	mutex_unlock(amd_manager->acp_sdw_lock);
 
@@ -922,7 +920,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	amd_manager->reg_mask = &sdw_manager_reg_mask_array[amd_manager->instance];
 	params = &amd_manager->bus.params;
 	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
 	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 5f040151a259..82c3183ab215 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -243,16 +243,8 @@ static struct sdw_manager_dp_reg sdw1_manager_dp_reg[AMD_SDW1_MAX_DAI] =  {
 	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0}
 };
 
-static struct sdw_manager_reg_mask sdw_manager_reg_mask_array[2] =  {
-	{
-		AMD_SDW0_PAD_KEEPER_EN_MASK,
-		AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK,
-		AMD_SDW0_EXT_INTR_MASK
-	},
-	{
-		AMD_SDW1_PAD_KEEPER_EN_MASK,
-		AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK,
+static u32 sdw_manager_reg_mask_array[AMD_SDW_MAX_MANAGER_COUNT] =  {
+		AMD_SDW0_EXT_INTR_MASK,
 		AMD_SDW1_EXT_INTR_MASK
-	}
 };
 #endif
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index 47b6cea356ff..56dab6fc9d3a 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -34,12 +34,6 @@ struct acp_sdw_pdata {
 	struct mutex *acp_sdw_lock;
 };
 
-struct sdw_manager_reg_mask {
-	u32 sw_pad_enable_mask;
-	u32 sw_pad_pulldown_mask;
-	u32 acp_sdw_intr_mask;
-};
-
 /**
  * struct sdw_amd_dai_runtime: AMD sdw dai runtime  data
  *
@@ -61,7 +55,6 @@ struct sdw_amd_dai_runtime {
  * @dev: linux device
  * @mmio: SoundWire registers mmio base
  * @acp_mmio: acp registers mmio base
- * @reg_mask: register mask structure per manager instance
  * @amd_sdw_irq_thread: SoundWire manager irq workqueue
  * @amd_sdw_work: peripheral status work queue
  * @acp_sdw_lock: mutex to protect acp share register access
@@ -84,7 +77,6 @@ struct amd_sdw_manager {
 	void __iomem *mmio;
 	void __iomem *acp_mmio;
 
-	struct sdw_manager_reg_mask *reg_mask;
 	struct work_struct amd_sdw_irq_thread;
 	struct work_struct amd_sdw_work;
 	/* mutex to protect acp common register access */
-- 
2.34.1


