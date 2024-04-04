Return-Path: <linux-kernel+bounces-131699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3692898ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F351F2C106
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E413280F;
	Thu,  4 Apr 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3O/4XKR6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439954905;
	Thu,  4 Apr 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243675; cv=fail; b=pM5qjUILqa4p+GC2S5SZ3XD8Fy5j8uCLEvIx/4cACmIjWVfqDeSe/yK4lgEUOadvVajMsDh12EwoDC8XRVfOH7QhgcS32EgMUMiW6oMTP7jr99159y36+Zp48vACTtdQBzUGrDe2cnu2yv7dKJAVCyF0zr2N1o7rLGkbP1bG8CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243675; c=relaxed/simple;
	bh=1s1qR5lee3AZGAmY4DApwVzPv7Mwacf7ttyEu7wsbQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFLEXTRhmnP++ymSSRvgI9j0gvZgiD3COEVMYm8lE28kSWmtkLCHNR3tUOZGqrZ6TqxdFN12zXnTFok8Ui+0aC34WDrzETRVxGkbhTV68AxZajhSsv4AH0X84WM4D6fDL0RZWdIsPHIGUYSvgZurRWt8f9LC5+9g5BqbAFLx+hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3O/4XKR6; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6nlQ9QI/XnfcJoyDRBOpuQmOVHwTfKCnJcKliu5hERauqPOMQFpfbvHH0FWZ63ODMhbDvd8Do+UrEhIb+AoWBGu335l6LmcjURbL0MgjXTu304MhvKBEw6a0yFf5AnDHktftg0dk4HD8C9SdFs9H6y86nKFE0HhO9PmA2i+Ib4fFcNYJW4yd7yL7l6x/X6Zpov/AEKkZAcWmqjg8kWw7EPVJyyhUkHJ1zSw/Y9tN/Ik6uJLipwEd4lTlq8RzmwGyXKJI0VwoBlaMzNG51xxuMormWXmIwN9vkYzaihfTZ8voXGFmLq6nvTP3lJ/Z/ZMEH2cAA2TGSDCseblr391iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxe/NhfsbD2mL8GS5ALgW28w1/nrp5YBVuFG2w6+WLc=;
 b=Wu+suGWEEC5UosNYUmYuJbVLzgu2WQaDiWBM30MZWjwOciV4tMoZITPIQfgGjP6sbw0+VckV2zRC+c74wkP+WHeni9d8UPGUAhJxsD7h4+oQUR4a46ZI6NOggFE8VpPC2V6ZSYoxegA6fl38CGEEBXANIEpBb3BZCOZzVNgWCqp6t9RA8DZNj0gP3QK5e255uvv4I6Ctm4XgkNrK30AmtMkjBGoPZtAHeqEPOzuFVyJ5X8EuZ3lls5NfiQoSMOVaa0/oaYwRxRDg1oHdoXBFnDHlLuIAb3CfsUdGX62qYhFz2Q0TFjGm3Qh21lY+2mH3Ct89zl9LQHY57Nyx+gqLAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxe/NhfsbD2mL8GS5ALgW28w1/nrp5YBVuFG2w6+WLc=;
 b=3O/4XKR6/ugm3jYkaq4hiZZOqXJr3BjJAqBMA+YLUuRyrcZNOL0JM/5mEuKfrH7KH15sxB5qQZPgZtldKVmJGdDmcGothCcNj7ZwRsWHtjxtB56dx/pi2QzHimkiaz3Rn+ts6LelFl240SBVLWfPrAcsPi/HvGk974A6VjtxzLM=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:29 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::1c) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:28 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:15 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 15/16] x86/mce/apei: Handle variable register array size
Date: Thu, 4 Apr 2024 10:13:58 -0500
Message-ID: <20240404151359.47970-16-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b8f784-ef11-41b9-4fe4-08dc54b9ec5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zszzOYLdwCT3jkz980JQi45a+CKwPf8TQh7Dix/WtRCytAd3R9zJNywKduJIKO6T78kK+BOz56nxOUX/lHd6nnVOx6yOULdZNisSC4NZCAyJvPnh0FFB9NH1ubnckDg8Z6lEzuN4S01wJ5jpukEy5YdMBGn5UrBlWgPJM15/LuBEtfkT2pwj7THkIOZJe4PWUqs0qOfcIS25HNwne2ASx/RO8itTH6QkrTpB1ljC8aPZHnALZHrm+dryBLUzNMU1VMmUKZDOJPomIrNDXgIXtKUDrjfDJGb5Dil2nzuJUIwp4Mtc4sAI0iAxG6H60C7mkk8crQ/RywghXbuw3ynqJQ7ciMARSdo3mXfmAz7ToRo3YEXLX6sny5rwlEKjdcK9nKt1nfmVF6tys4QMlorOYYAtQLlygESAAoL7PbdXt5G1qXBfsmMRRveqkzh/R3ZImtCXPvcSU0qF2wsjXQcW2KAd26a+mqCOS9T3+4cmSZl9BrEJKk4b2PDS2Pro3P1Y/DF1d3pP7OSfghjXMdxnv7LO/V35GRtzUYQmkta3aVdCVAE6VHy6J54rL8opy/oVLXvqtFYqKoYKNllCI+lweAW4YYLsceKu4sL5BTFHbnUkMy5G/C737vNPermGtWNQMLfal/XGHvZed6VNRuEGa8lb7zc9GIoR29FsUJHk3xkB51wwZv3yxB/4BFYC6MoAAh3ZyP4NM7HC23lg7EcJOg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:28.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b8f784-ef11-41b9-4fe4-08dc54b9ec5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

ACPI Boot Error Record Table (BERT) is being used by the kernel to
report errors that occurred in a previous boot. On some modern AMD
systems, these very errors within the BERT are reported through the
x86 Common Platform Error Record (CPER) format which consists of one
or more Processor Context Information Structures. These context
structures provide a starting address and represent an x86 MSR range
in which the data constitutes a contiguous set of MSRs starting from,
and including the starting address.

It's common, for AMD systems that implement this behavior, that the
MSR range represents the MCAX register space used for the Scalable MCA
feature. The apei_smca_report_x86_error() function decodes and passes
this information through the MCE notifier chain. However, this function
assumes a fixed register size based on the original HW/FW implementation.

This assumption breaks with the addition of two new MCAX registers viz.
MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
MCAX register space, so they won't be included when decoding the CPER
data.

Rework apei_smca_report_x86_error() to support a variable register array
size. This covers any case where the MSR context information starts at
the MCAX address for MCA_STATUS and ends at any other register within
the MCAX register space.

Add code comments indicating the MCAX register at each offset.

Co-developed-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Avadhut Naik <Avadhut.Naik@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-20-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/apei.c | 73 +++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 89a8ebac53ea..43622241c379 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -69,9 +69,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_registers;
 	struct mce_hw_err err;
 	struct mce *m = &err.m;
-	unsigned int cpu;
 
 	memset(&err, 0, sizeof(struct mce_hw_err));
 
@@ -91,16 +91,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	/*
-	 * The register array size must be large enough to include all the
-	 * SMCA registers which need to be extracted.
-	 *
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * The register layout is fixed and currently the raw data in the
-	 * register array includes 6 SMCA registers which the kernel can
-	 * extract.
+	 * Ensure that the array size includes at least 1 register.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_registers = ctx_info->reg_arr_size >> 3;
+	if (!num_registers)
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu) {
@@ -115,12 +111,61 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	mce_setup_for_cpu(cpu, m);
 
 	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m->status = *i_mce;
-	m->addr = *(i_mce + 1);
-	m->misc = *(i_mce + 2);
-	/* Skipping MCA_CONFIG */
-	m->ipid = *(i_mce + 4);
-	m->synd = *(i_mce + 5);
+
+	/*
+	 * The SMCA register layout is fixed and includes 16 registers.
+	 * The end of the array may be variable, but the beginning is known.
+	 * Switch on the number of registers. Cap the number of registers to
+	 * expected max (15).
+	 */
+	if (num_registers > 15)
+		num_registers = 15;
+
+	switch (num_registers) {
+	/* MCA_SYND2 */
+	case 15:
+		err.vi.amd.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		err.vi.amd.synd1 = *(i_mce + 13);
+		fallthrough;
+	/* MCA_MISC4 */
+	case 13:
+	/* MCA_MISC3 */
+	case 12:
+	/* MCA_MISC2 */
+	case 11:
+	/* MCA_MISC1 */
+	case 10:
+	/* MCA_DEADDR */
+	case 9:
+	/* MCA_DESTAT */
+	case 8:
+	/* reserved */
+	case 7:
+	/* MCA_SYND */
+	case 6:
+		m->synd = *(i_mce + 5);
+		fallthrough;
+	/* MCA_IPID */
+	case 5:
+		m->ipid = *(i_mce + 4);
+		fallthrough;
+	/* MCA_CONFIG */
+	case 4:
+	/* MCA_MISC0 */
+	case 3:
+		m->misc = *(i_mce + 2);
+		fallthrough;
+	/* MCA_ADDR */
+	case 2:
+		m->addr = *(i_mce + 1);
+		fallthrough;
+	/* MCA_STATUS */
+	case 1:
+		m->status = *i_mce;
+	}
 
 	mce_log(&err);
 
-- 
2.34.1


