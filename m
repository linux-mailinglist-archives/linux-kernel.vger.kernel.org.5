Return-Path: <linux-kernel+bounces-131687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFC0898ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D41C2271C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE312AAD1;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nao5wDHe"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEA128362;
	Thu,  4 Apr 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243668; cv=fail; b=aEUmQBVI8Hm3D1HwKF5fo62oyLqAgBpnpiltBeBE6qZyDCW3zQcmWCo3VYZ/zqS6wtfS9qxDEQjPbX6XcN1VpahgswLAmGz7wUznROxW8TkNjzqc3C8sZVsHPn+NjJJklB6F5Rcc126IlbWA5VJjXEDGf0GViPYfF6ugkludC4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243668; c=relaxed/simple;
	bh=vPFWkUy8IIHa/WUQHXkrjG1ox0a2n+Dx91X2EksZ93E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNZqNBSi5ocZity0B1pquQAcbCj1viPAlcSrwrHTAp+xM5NXt3fk/bXCdVsZDh6jLp518wb666KJHYSWBasIYu4nKu77JKw7ua7Kw0QvYgOckEAC0S+UTpIGsI9X/SpA7pwWHMYm8nNKIuWYPLJUZtnz/MwprWkj3w7EUOfrLlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nao5wDHe; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp2UUCs7kujo2QeCYNEP1Fme/n+sJfyJi4xHJh2ntfOffZ/uucdf+nFaIxR+vRumoVvQY+YhvBjR3xBLIHLUpTq2+CDAm7NnpgL9OZOnr0FREFh++/RChPCCL6wjhXLdLiUxxzt+9Fn7yNAjJ3PkRsrW500mj05JpuKwswSN4+FZ8bNJIVh1zPzCcJAoOYDoUco/TRHPSJnLLIaKweghvLKzCHnU7S2ycplqcsSGbd/xc1bg1tHk/n0+mmkDvkm4T531otXsjNMcGVrBBpyK8unFiPcW3pPoE5EVf3yNFBx414L7rN5K1ouQm4ULNyukt584+PZwQDFglCP4FqfHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii7nrqaeeFK7Rd2T3wSvKEYfBVw/yhmnSw1wcsBU4Uk=;
 b=jSCYsjn5assO1QJPefInj12c99UXOVr/DmhkXyWVLsMzCZwrODVtKrUkv04bsMXzUcW3vesVBuk4JPe7pe0RcVbizxa82EAEedqtNIevH0v8rOqei5IB1Fv7q4xL0LIJ0r0zeqJyIUGCDTeSXf/Ybv81kpPJX8A/x5xSWt2sldsYQSFz74pg4lG8CPA2x0iBAC/r61VYLFyIW2OBQ2MmTpj2h3ehb1caK6EEaBbMuMcfnwEUuVrlfNwvQ0eb4QoBaU9QVEnE93oXFiOXMUjp/0Q01+mxybB/mcX6hvHOdLm2EXmz+jPkLRRrMgNvN873HrrhzPC1CUAS7sAAJX21XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii7nrqaeeFK7Rd2T3wSvKEYfBVw/yhmnSw1wcsBU4Uk=;
 b=Nao5wDHeOUr/LdPHrwubD7tRIA75FhScfT8k/LfD3jNjpY1dq1thD/7tUtIXHZIEq7UigDioQ1Ryc6Cp1RmtMAvrBP0GpWvjL8tEjUzcWf4HEFK6gZXm13w9O3N+7dr9CcRooPBJOQndYThiONxHKoZQe07fQLTThcPHPhR4Ods=
Received: from DM6PR05CA0043.namprd05.prod.outlook.com (2603:10b6:5:335::12)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:24 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::37) by DM6PR05CA0043.outlook.office365.com
 (2603:10b6:5:335::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:23 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 06/16] x86/mce/amd: Prep DFR handler before enabling banks
Date: Thu, 4 Apr 2024 10:13:49 -0500
Message-ID: <20240404151359.47970-7-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cbd44e-b3bc-4a8a-741b-08dc54b9e936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BWNNZW9HZXoJ3yqi5lpGdM0bTcRvuxNrOI78p7ubIq5nwRcOsme+l314h/xGm7F+/FPP023NnSlwo/+sNTsM9tkW4QoKrJ5mn4lJG0TU2bYE8n8j+iNQyUQ/dWFob3oC6LIbNERarq0uEhpNMH5kEV552W8Jm8JR1aw47mHNDUWwfPoItLQrzEqvo3MblMTimqpIW1GYad9MUq7SNELKL+haBL1axaRLLrTCyrObhEHcUYgz/LLxTcb/wXEH+nmV+YgHN3NBun6sG7/jNulrjQwjpnexAcQNC1BFpOCYjI2Dj0f6y0+wHgxoVk4b5C8D7v73suycZlzY/ZOXGSqDnWlcNZazbvoaXRltqZ7cX1neWyB4+KGgstkB919+4IZOOiYh9CHR7jR02t/3D7BMzgPRs1zPI/Pi8mlBVoO2jj2n5IJONYJE/SXQkunKXp4GBpVZjaWrd0yklWLvlErWP3gZSMbXJ0w41cRDqbs3rgSjDjfjMlDLMIjOlqnMozT72cUdWjJ1fqf/xmM567G/o8P7L/5WstnLoPOSgUdOdfDGK8dtzUN5Afozkez8IGTbEI/7kkWaexhofqaNYR1oIza+wvMsGw62jaJEEcH9tvHvhsTsriQkLHwkOtxg92aFO0xIlNtI5CU5uO4JYTami5h7h1XKZEWyxkwNVCzbi1qhau+Oyjuz1zySVNGfsDuN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:23.5610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cbd44e-b3bc-4a8a-741b-08dc54b9e936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623

Scalable MCA systems use the per-bank MCA_CONFIG register to enable
deferred error interrupts. This is done as part of SMCA configuration.

Currently, the deferred error interrupt handler is set up after SMCA
configuration.

Move the deferred error interrupt handler set up before SMCA
configuration. This ensures the kernel is ready to receive the
interrupts before the hardware is configured to send them.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-11-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3093fed06194..e8e78d91082b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -589,6 +589,9 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0;
 	int def_offset = -1, def_new;
 
+	if (!mce_flags.succor)
+		return;
+
 	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
 		return;
 
@@ -768,6 +771,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	deferred_error_interrupt_enable(c);
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
@@ -794,9 +798,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset = prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
 
 /*
-- 
2.34.1


