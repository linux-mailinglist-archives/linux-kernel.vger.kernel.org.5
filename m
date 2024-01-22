Return-Path: <linux-kernel+bounces-32624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5424835E12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5081F22DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F939FC4;
	Mon, 22 Jan 2024 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QgtIotrs"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A739ACE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915535; cv=fail; b=hIAN37JSALx/yOoxc0y18wjhmuNImJvdyxg8qBZ2fTar0HROgIEpbnep882bceWAguQ4J/z6h9S+bqdGWl1tEwCGqKdU2vveIRpNS2oKstjLKIowf/J0BqPzVep8AWNa4jvTPgLmaCczTg8v79+Qf/s+GiDHEZzGXR3bhQ0rlks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915535; c=relaxed/simple;
	bh=xtnWNxMlZ/kFUbpB1SCxK9crj+rv9OD5nBPgbH1ApHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7zt6TvGQuW4orDJkFCFM/Iu9QlVse4zsAQoBXcI7AH3WfjiGjEzL6bqZ5FYXkOP0ahWTLqdaRdIuv8zrA/1E36UDAIqzs1xInCaryqUpiExRPaCATQhQg6ZIzzgSJXm2zaXDqXdvXYLa2BrtlsjUzH/o6r/8hjfJwO6vquDo28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QgtIotrs; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0+pn2F6YJde49U/c+tcyN8O18V5JwHA0jMLuowvhUvHtbodhENrSPS1i2f9foqf0dDNNgXomIJ3bR3lOj+ZUaQMEjumOPfBAfoohLGgNcIEbYuYnBjGMh66htcXYwIXyq9YooRXU7cs1b/Wa+BEq9vpwy1vGfdPrXMqk8nn36A5ROK5YcVILibzBJNFsBEWXlbcjMgAFuE/1iuLSBF3QpLjM7NR8PUASt+Bd5O2eCcF7GnFXGVysAYw2bQCzcIQlNQZfHroeMx1+wtwC+jMqO9tV9DIWO3wpM6/1R8yjiebIj4WLmB7RXx/T2WRyeE5CLVS/NhpzxmkwsOwth61+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj1JFc79FiePafhI2kF+P2W/uJVnyNwBTnBQWQ8j/Vk=;
 b=bjNelNBJc1l1ZqjWhVFkgjVl/PWAovq4qnse+ROnidbaC3eqC6yPU2xVEtQkY/lQfjR7A6rBSQADoRxFa0NGJk1HblMryfilzSFEFAl9NfciP12RB8PFVgoBUyl4uTPK54plnCz7z/BgFFiF76EqCaVr3IV2rqxJsEuTXckBOoiwaS53hfUB8JR8zQWYoK8iBqe7Astl3TNIFVG2/9x1s74Ka1hLWMq5xH/+oQhd3ejVXncUL3RNF5PnNDp9uref5OIelA8P+GKSRil5rLDyAl65sAuwsxA8fVKBQ8dRniQ/6U81C0uR6mrDWKk1+dLXfF9XzjRLNNO0X/zJN03pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj1JFc79FiePafhI2kF+P2W/uJVnyNwBTnBQWQ8j/Vk=;
 b=QgtIotrsuN8ObRpf0zi0tcTARMec6w6MPHpNMgwhb3JgQW9i4yerL+yCBhBMF/r6nsYF6WQk27OH4Lvx9f1RW+JfcIWcN+vGeshe580d6E/WR9VYcrtFXx/uPAq+zVuqCVPVOkr1F6TTrf2nPA3pcbB99qTYfA2bypvLZIPT63U=
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 09:25:29 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::46) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 09:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Mon, 22 Jan 2024 09:25:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 03:25:22 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Mon, 22 Jan 2024 03:25:19 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 06/13] soundwire: amd: refactor register mask structure
Date: Mon, 22 Jan 2024 14:54:28 +0530
Message-ID: <20240122092435.3791175-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
References: <20240122092435.3791175-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eac99eb-76ca-48cb-6adb-08dc1b2c1332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BhAeI2xMG+d+Zs7eL52S2ytPkCVAZa0mSNzL16mcx1z7/mqn7tWtRw/onbZps7lRgf7RKFJpCBz8FZMFTUzhxEIal4Sm9R+/2WXGb6pyOZ0OWvd9sLuxEyEz/X3+m3gNxiKb5HK282D6T068npbGWuCs1AgoEkTJj4Vtyf3yc8cALBw49mgNQ7GcoOpDMqItXP8CMyXKjEeTj+pzsTkPGyu03w+LE8c10AINLv/tPzYMSmPZ44IQh9rNsiOagziIhvLa2gGjXB11eI6j+NKQ3vtI8twqTGBkUx/63pwDBK6N9Nf6xVFF38G7X1Vzqo9Z6m8QrQ1qpIpPVWUoiKXkazJPZk27A+0S9bO3CYU5++01VmHPZsH8xN+88ItoAtA/vfDzzIxlaA3F0jOWuxuGkXTf7ia+7j3ZTf64mKXMq4ALwZVBbTq4ZyszQUBFogoG/WrWWNwpVBKRvCZKpuEgcvNr08eB+RJsj2sxBeaYMaH240xeSpAONGf3GNVQLJagMe/1zf+Qj7EZjL157+detUjjn+v1kgLEsM840ANOmm4XxDYPYETVoZmf5bafMbVdGJC6dBydbIIFVdv39kcolI5F34yMXr672tHZCZtfI1LAawywC2ldBp66z3BYH2nkA0YqhH2Jl1ncmlUUyx84g5qR9coq4TOAoWtLAGWTVTjI11BiC29aNbJM3cKe4QUmq99mPB8mN1eED8p95MgD7pUNEB0e093O37n2b05OOdH+iOoykKUZb4Z5Sw7k87Bi2NoZvED9llkUZOTcxTyW/VCx5gHFXrkxaVVJygPLLp36sOXdNJpSrbrYuawmIBP0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(356005)(82740400003)(36756003)(40480700001)(40460700003)(86362001)(83380400001)(336012)(426003)(26005)(1076003)(2616005)(316002)(110136005)(70586007)(8936002)(8676002)(54906003)(7696005)(70206006)(478600001)(6666004)(36860700001)(47076005)(2906002)(41300700001)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:25:29.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eac99eb-76ca-48cb-6adb-08dc1b2c1332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822

Register mask array structure is no longer needed as except interrupt
control masks, rest of the register masks are not used in code.
Use array for interrupt masks instead of structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   |  7 ++-----
 drivers/soundwire/amd_manager.h   | 12 ++----------
 include/linux/soundwire/sdw_amd.h |  8 --------
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 7ccafd8eab7d..111891cb601d 100644
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
index f57165bbb9d9..f877492a8c55 100644
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
index ae53664f87cb..c5bc44cd150a 100644
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


