Return-Path: <linux-kernel+bounces-42202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F483FDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089BC1C22B15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059554EB2D;
	Mon, 29 Jan 2024 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YxkuRuLV"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9FB4CE13
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507559; cv=fail; b=kDTBKyk9rE646WsZa7vEZXklr0M9XkzxMkLr0Tmr2qCWzNvwwy6mwnljRGWd7XFOuaaUJHRp0uP8sbT5RFp4BimDXrmkA/FMKmgH/cE1PagdJOglkMTHpM+muRcGZ7hk3h0TjCWOu5cBRV/tUfAXxGuDvqNhHiX4r1RvlaPxx1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507559; c=relaxed/simple;
	bh=QvBbLEe8qL8Us0MbjpWFvqtysmg7R2z7BdqBgonX9o0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6Dm/lkqj1w988qk7k3mt+zvtPok6diGxrfTr+EihvBb7qbAERzGIyGXoPZncgKay4TXXukUDqXHeYanqTS8R5DwOuXS6YtHDaNueobzrDEiTxcx0QP/2vPw3jVh16HWx731ISKdkixdN+Z6y+CqadURxrjR9vGpnLnqAlynW9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YxkuRuLV; arc=fail smtp.client-ip=40.107.96.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND52Mmv+KnsA8/JDMffPhPybXpx2t2L3DtGTjT1gTK1X0yY4/8VuaLnRt4UW/uv2HtCpk1kmTEEoHVrHR7BV/DdovJd6nKsyMb9IQbzXqVLXT0gL23wvbnbgHa91tpfp/A0OvwpO67zEGmMfmEUiaP6vOd2pgrhunQBsvhZcQd9BAssVlLjt2NookqMF6N98fdczVttG5xw/Jl7hwd1xNvSUxk36sCPZPhQJTZ0CaiJA3XZ/G6L3/ap49Qhbu/SuxgGia+LJlHtKXdBYTiwR/fWW/5DMqCF1PdZ6Kyv6353UDzNO0FwGz07CcNizh7WK8UvoySAKJJZIhyzc7vPCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xHVSZ/4oY8ZRMjGbI+MfML3vfROY8EZRjbBIW+ACRs=;
 b=TwUxx6tLzsbwZ+mTv7Dt1LyvaLodzpxv+8XY7yLAVG8XnxliFuSs5NgpPLwL9QcjGfuewGi4As2u2uhLDfzq91mTxaiDWWohhopu207zPM9Qfwipvz0L3M9YY0+xYWm4Dy0zEXRRTBtCvD+g6BF/xchzfaqDLlwwMyeatvEC2n4CJ/6xe9mCeSzzDMNSh6VXWxbmZhDt7orscrskzE4IA2xTTSHOVn8BtCIefHNlTHpvwY7lscxBXVJtiVJeHD3pG63tt5Tvoh6UP7E8IWHWr6qOxMSjl8kIUHEirvUZrSCWGQ5llkMqTBDQcDFjbMApUEOoGoJKXR0Lcb3/vJOVWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xHVSZ/4oY8ZRMjGbI+MfML3vfROY8EZRjbBIW+ACRs=;
 b=YxkuRuLVF96nsnU7htuIhIPch5ynoRi+EueLiAM4Ywmer4iU5ZY+p9HuVJDJ7R2/JQckZfQuSKmfXxo9yapb5N1ZHcuXrWfLDRDlutGeyCdrWU7q92tJQFR1bq3GKEM0PbOYUevm0Ch0kMkuZhjZMcbl5+G3jB6c7e44PDmj7Ys=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 05:52:34 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::bd) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 05:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:52:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:52:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 28 Jan
 2024 21:52:33 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:52:30 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 06/13] soundwire: amd: refactor register mask structure
Date: Mon, 29 Jan 2024 11:21:40 +0530
Message-ID: <20240129055147.1493853-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 842cdae3-fc05-4ff5-f173-08dc208e7dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GujoJ7mZ3NrD/TW6V4f4KISoTy0itRksKIhQAtj3LTN8nU+zmnqrQUhZTvJDM5JoSeonjI/4RrcgFNEDyYcs8vW/J7kKa87ygkjH0d4GmVOyPXVYqlZuesjzbcuP+8XNq0x1XBYExZzhEzA1khoRHXG52bGj+fDxuRK1T1iOx8usVWDJGIbX/d5lkBm4mupazuxF8AQfqbf0eaNlfScW6PWpvybDSJ4SuaFzcoWjFuVHOtb1ekwxGbYjIQNVwnTEe+FHNV22JiQIOy1MLyy1zmfisP1RTJA1R/O3CjOAnbI+3fNXZp8A6KZXKEi0BRxaI8osykhwXUZfo8v+I3PTt//BzW8veigmNCv8IE+lbZiUVaVaZWUC+SLyQI24ID4CypuElTapgdEjkuiWZGOTZ5lf4U+PvmPEAVXphA4JPIj4YrLBEv436mFrfYPjl1nZmVRjJ+wODYpLwvtsWhm7NF9TwokPXNrVdCCrDPjBd2qNWKZW5W984jX15bmzZzcQi71v4jTf9ehfGbEJ3+A1w0nRT3kDSJicVJggJpMLBvrbm6X9lIG2eUmB3WhqNC4dboeHPXcQ/zZLR/dqB2Omf/Ixlyx5dDk7/6LClzRmPlcWwNKSfipxkXMUM0hFCp4wzJ8tTXtgysCppOdn2ew6po6VbVWrFJATlBTpnFmkm11mXBGnpvJAcwf2NX+8vNNFg59OjYAKqEGVuLhMYTTo645flX7lKIdDNAKl2gsJZsXDyokFqUlWvBh1Y8TEz6AEG51tlfCsp4ZCcbsYWHrElAneHUW1X4aaQTyiS/BDtEEgYKN8r6lOx4/nKxRd8cn9
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(83380400001)(86362001)(356005)(36756003)(82740400003)(81166007)(36860700001)(47076005)(1076003)(2616005)(26005)(426003)(336012)(7696005)(2906002)(478600001)(6666004)(41300700001)(110136005)(316002)(70586007)(70206006)(54906003)(5660300002)(8936002)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:52:34.5386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842cdae3-fc05-4ff5-f173-08dc208e7dac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

Register mask array structure is no longer needed as except interrupt
control masks, rest of the register masks are not used in code.
Use array for interrupt masks instead of structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   |  7 ++-----
 drivers/soundwire/amd_manager.h   | 14 +++-----------
 include/linux/soundwire/sdw_amd.h |  8 --------
 3 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 44d682a83e23..7cd24bd8e224 100644
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
 
@@ -930,7 +928,6 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	amd_manager->reg_mask = &sdw_manager_reg_mask_array[amd_manager->instance];
 	params = &amd_manager->bus.params;
 
 	params->col = AMD_SDW_DEFAULT_COLUMNS;
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index f57165bbb9d9..418b679e0b1a 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
- * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ * Copyright (C) 2023-24 Advanced Micro Devices, Inc. All rights reserved.
  */
 
 #ifndef __AMD_MANAGER_H
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
index 9103772c2497..28a4eb77717f 100644
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


