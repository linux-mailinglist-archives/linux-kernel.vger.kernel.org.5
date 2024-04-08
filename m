Return-Path: <linux-kernel+bounces-135248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA489BDBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E69C7B20EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9764CCC;
	Mon,  8 Apr 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnJqrUVM"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B245FB8F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574385; cv=fail; b=sMRkzGDIxvyBB+ziugT8xtecNKhAC46eodJOiqwdTIDOU6OJjfsnLS5sTj1Vaqa1MX+bEhBU7LbyDSg0p7OODxYFABqN2+Kk9lFuLQ50lMu5Dfad6e5iADGPrORoOkN2HSZ319IXd8HaXwYs5YBtfC+xFz4FicNpSjq7zZ4ceE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574385; c=relaxed/simple;
	bh=4giIsb9r+dfxboJFitbfuWqZoE118UhGpBzfdy5dCOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lhdkcgtrPwvoJJxBNdV/dk1MankuDwNDL9DGoPlk8AaioRaj+yBYNpLJr0Pj66PzDp87amva1yfyUrZ5mCmU/CxalQznKuaYG7oBYY+rIrgQAcf4IAK+e35+J+ugSTI9rVFumHaWJatF1wP2K9IoduubB7v4elkv67d1K1yzYLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnJqrUVM; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PA6udrud+7FAFGkKeM9ACnt1nm0oCjKcz9NeQe99Y5mGv3wprik3zKIlFBOrwoCQBeU7ax3qg4ioRzzeOEs9lC/tffAu9bSOVcj4oLDn6ZOH+UEeMa7GFH5k9P7WMn5L6vBbuaCposuRzDXXoyjyPJLnumeo2I98mrE8m64LqXn7JnfbwivlgdLpNfVHkqV3PlB0G5UbGu9DVwjlvbTJQ/INcF6X9YcPMeV5YxP/HZhU052YCe2oerB0XqQ2SDJABfFwH97IZtAgPLhTTMsutisEa/6vky8FAfU7wYBH0sMTb6Dn5DhwNg+xJFxN9DKl2/eMOuhsdGD15XWiKUF8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAj4Hl4Ej3ikJtQd+WA0hhpE8n5LNgIJcXfYekN7Jx8=;
 b=mt8i5vSi5Xq1MkGjpTbcb7vg4qT3IaWZzYslbMWMK9+xNAdY3+M3Kh+FiFa5Uo9iwRZZ4bLcfSKP3QNmYxy+etnXecwXOAT4HYMiJmbgOvJOaEelYane5kZCZvPdAtIx67o0D1Y37YLS0457d/Pe1yRc13rxzO5M8lmJkwWlON0zELkoG82JWt3W+0amPz9FTENWoH4GhtoimLEGa8bVZ3YrsiiWW4Dd7hgF5bS6Fc3+Y5WFFhZGLf1dxxQewcOYZdTL9x9szOl57/xGIRlql9OrJqd49sqcRkR5vZjCgiB7r3MmFJi4Wat0ap759207sFW6jWUJpuGk9sEbXSh1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAj4Hl4Ej3ikJtQd+WA0hhpE8n5LNgIJcXfYekN7Jx8=;
 b=YnJqrUVM2Ovglvjn7ekkXH4dIlr37HYu5E9NfTzM+z3STGjmvss5zOG9sYaxKF8oFByUhjbv8aiw9Mgy5cL5NUDI90lYYPhjrSszGqX7EER5PlQaY9vfKSsZN7W9NrTOT71vZ5KEYbjfzxjMlOCpzFXyu5CEK24SBwbxGEKo5fQ=
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:06:21 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3b4:cafe::c0) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 11:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 11:06:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 06:06:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 06:06:19 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 8 Apr 2024 06:06:19 -0500
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH] soc: xilinx: rename cpu_number1 to dummy_cpu_number
Date: Mon, 8 Apr 2024 04:06:10 -0700
Message-ID: <20240408110610.15676-1-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jay.buddhabhatti@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad92258-5f86-447f-d26a-08dc57bbebe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HD7RJdwkG/2mnvujyQCQjlOKyoTzYytJUxqdBoC/vabAlK6OSF/Kxh+M1MMcJbCBaQjVuHFV7Pw7fuEKwdBFUi1lWEP9lYs1h+rXg1AthpOHhv4YI0AVG893vj8uA0jn++qQe69ez/ZxNwoDPd2in3InMoET9rd2StQNIoD/bodE4pPQKz1iSs36xM8Dy2qttjF86Mcg5Cv5mhDOEiyCxgRKjNAjNaB0VsbTlC9d6fIw7TTIMsemU2VOyvnzS6f/z+zkR3BPkgHV+8Bw/rXFH2TpI+vkZxO3DWRTkePUOqQZxGSpYe6Ao1t09d3kT1feGe+SIoKkN6zAcKc6FeKFdlCsMcN4+vb5Eak1t15WxihVGCrOJ7+iuULaqipIUa6tLZab8LpXaTNWuA+Y3jE58oVGsDa0c9OaaRTuvyY2J0Iql623m/zbyO82/RbedL6xDOwZOrB9ZAiHYtCsn6Kn5TodyzNJt6OzuS/EbQKnpXeC/3cHtCD7O46rCKrK26kgajfXBKSLb+wxUu9cmbMZgaeo/n+AU7oQhVEgTcjaeiVG/JhavKCI881uHkgWzArOG96dVlAYlViD+aKXELS7jmlSzMCegGqgApVk8v+ptxKjUwgdSARaP/X9RYpJScsOg+nryitbmwnX6uZkSVRo2uzsXuTCK6Ul8Sr+MEcSMbj5mKdvTCYnnHNWigxeSRLqiUbpv7jC7r7BmkX/u9kRTIjq34sM2To9iLxhfFaM4XHKpV5I/QDmqYCZzFPrSRhi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 11:06:20.7260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad92258-5f86-447f-d26a-08dc57bbebe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833

The per cpu variable cpu_number1 is passed to xlnx_event_handler as
argument "dev_id", but it is not used in this function. So drop the
initialization of this variable and rename it to dummy_cpu_number.
This patch is to fix the following call trace when the kernel option
CONFIG_DEBUG_ATOMIC_SLEEP is enabled:

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
    preempt_count: 1, expected: 0
    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0 #53
    Hardware name: Xilinx Versal vmk180 Eval board rev1.1 (QSPI) (DT)
    Call trace:
     dump_backtrace+0xd0/0xe0
     show_stack+0x18/0x40
     dump_stack_lvl+0x7c/0xa0
     dump_stack+0x18/0x34
     __might_resched+0x10c/0x140
     __might_sleep+0x4c/0xa0
     __kmem_cache_alloc_node+0xf4/0x168
     kmalloc_trace+0x28/0x38
     __request_percpu_irq+0x74/0x138
     xlnx_event_manager_probe+0xf8/0x298
     platform_probe+0x68/0xd8

Fixes: daed80ed0758 ("soc: xilinx: Fix for call trace due to the usage of smp_processor_id()")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 253299e4214d..366018f6a0ee 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -3,6 +3,7 @@
  * Xilinx Event Management Driver
  *
  *  Copyright (C) 2021 Xilinx, Inc.
+ *  Copyright (C) 2024 Advanced Micro Devices, Inc.
  *
  *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
  */
@@ -19,7 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
+static DEFINE_PER_CPU_READ_MOSTLY(int, dummy_cpu_number);
 
 static int virq_sgi;
 static int event_manager_availability = -EACCES;
@@ -570,7 +571,6 @@ static void xlnx_disable_percpu_irq(void *data)
 static int xlnx_event_init_sgi(struct platform_device *pdev)
 {
 	int ret = 0;
-	int cpu;
 	/*
 	 * IRQ related structures are used for the following:
 	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
@@ -607,11 +607,8 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 	sgi_fwspec.param[0] = sgi_num;
 	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
 
-	cpu = get_cpu();
-	per_cpu(cpu_number1, cpu) = cpu;
 	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
-				 &cpu_number1);
-	put_cpu();
+				 &dummy_cpu_number);
 
 	WARN_ON(ret);
 	if (ret) {
@@ -627,16 +624,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
 
 static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 {
-	int cpu = smp_processor_id();
-
-	per_cpu(cpu_number1, cpu) = cpu;
-
 	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
 
 	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
 
 	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
-	free_percpu_irq(virq_sgi, &cpu_number1);
+	free_percpu_irq(virq_sgi, &dummy_cpu_number);
 	irq_dispose_mapping(virq_sgi);
 }
 
-- 
2.17.1


