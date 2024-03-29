Return-Path: <linux-kernel+bounces-123943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73689100F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86996B22E20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912382C6B5;
	Fri, 29 Mar 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F3PYjf62"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CA24A12;
	Fri, 29 Mar 2024 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674472; cv=fail; b=tKjc6NPjTl4SG7dXeBg7uCqyODEgKukzrE2cMQjhC4g90dKHDtbhKO5ABZt4sELA3ZcwiH/391H9OziCTuo+4knrpfia9kEHyHvKLoHi9BFTQsdipEiTFqgROCrHmY2ZmrOwLV3yEbuvzn3skWmnkwotqk4JSSQMbwH95Y9jhuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674472; c=relaxed/simple;
	bh=C4LyNBFmchTqWXR/XFGHRJRH4Yo1dQidF8A5D7/2OgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ2NeWv8UV4qcT4wuBKvUPRuKdXjKV4c8gDsRrhgfYJZkRiq8CJbfgsZ9KZDfqfZGBMVTU1/BSOIznbAoShonTRByNnRqHPk/240J9HToPu2r/CBGtk2GaZgK5ltnVLg+iISP+Zc+QhmCP6+PsMpE80qXH7jLNgIF8ZzlG1f9io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F3PYjf62; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFvgX2wVelfn5O52FRjuloTQ57f/IPAOQ0eI9kfvl4/OBbmhwHkNP2hvMODNWgKeb07Sr0CIK3CCpuWuRRffF7QqRJn/zc9GPwEkwDyLb3KbjUwDE7I34ZgjMbiOp7Uo7PRnG+0Kw7Qgba0w2nU1MH6/2Y/q6DoInSjVl+3J0TYRLH6XxBUcXh8W8cJU506WQPmfxCg9uUkbRBNAros+PACJ605Pyf3axa1ZaME5rlzB1xsxxyZvIF8R++n1hKBt715m4pPZLL81NNEkddy5S1OHneixf9+tP4wCVgENdtQgDTfeWtbCleDMEOr80dA2MV3dTvMD+TJT2+NOnNuFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y7VzAJLf9MvKpFI92d69MmkXi82yAtuTJT50MWtGqQ=;
 b=be9VqUsI/i3arqinpE5JTPylu/3tE7JcG+upNv9b+jjDK2JyS354f3JnULzQ3KDrcsjO5BJAiMT1acIiXjnK28kvMcTvxFQiuumnxMzFajD6OG1MPm6k/e1PhaVXoIxIFsA2aQsvyzOCk62nniFRrp88zGDmctuiMgtARa00Ijzt/rB7p134F01dpjwyRc+U/zjjSd/kO9XekIQlHhdZXTFA2Vcqi8UJCATHWD7GTX7L8zvzeEiyFmKOz76JE2q49v7p2D3EZpS2MVHwhpkSDVwBjWt3kFzjONHE62xmtGgEu90vGmjvtroiH91FxhvQpMPernOwhfhvCuOSseYgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y7VzAJLf9MvKpFI92d69MmkXi82yAtuTJT50MWtGqQ=;
 b=F3PYjf62ku5+l5PYb3eqaE7oAqtrugFUTIbeGUWJ5mdbeNVq2CU3G8QYApSH3EBdjtZ/rjRPm8+m0mbb7GqTk2Yd5JrMEWiq4UASxf+QrHwN/WSqtjZZ5bYid2a+4Uukyq7N523qccAtcxwT6TuLPkpZV2u9YGPxtuSbYfFWJaA=
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 01:07:48 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::c2) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:46 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [RFC PATCH v3 06/17] x86/resctrl: Introduce interface to display number of ABMC counters
Date: Thu, 28 Mar 2024 20:06:39 -0500
Message-ID: <8d3e07ecaf178ca0a42894d6d07a4f047bb3e689.1711674410.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
References: <cover.1711674410.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 6130b658-f891-45de-5172-08dc4f8ca621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lHwHZz3t/hXWP27ZSRzm2OSx3kva1dllVa/xMdjFN54JswJrsfVA+xybLTJS5BejPZXZNSsfswaRgO+PyiIWgtJllO4eQtzyjEdwAEisAsAPAUo4m09Rqj9FpEx/WFgOWNKoxa0jUDq2Givw5iHHN3cnSO88Edtedlb9DI1byBYmb5mgbrsjr4Hhw1wZTzwgcugWTfN8wJm7Qg4jOj62LHM7ksuVH1Oqg2CI5Wnyir+uunz6VUGCsr+tJwOUx2UScJAxD9/2ndTU6NnWsiUbsPAHMnc7ELqg+CRLyPUMWRBTV9g8isb+cnVsfqk4kjLG0D1WPXfrdXnu1Qqfzbd6GxI97UHGuC2zx6CCBjOuvRJRl2fBXDhgQuG3+S3yWI1a/O8fxS566whjwBoYI0jUK1cNyWU0BSE5WZqjFAIY/629ulDdm7bL7QFiVVxvXfwHyOjOHhWFIQzGApuztWJ1mAhk3azby0M3dGILu1Bnd3qXi7flZDCni0+OKMXl2SNR6kLRRC96qvRW/Zi6AUJI9yCC/I7BCAa5hunmSyT8VmUsbTqGpV5Sjb7/8G+LkuXZuZOaNGqI+RfVKYsNUky6YRSQTmlG4YRbJEQBjGQ/WNMCdI2OjDh6vdZS44jMRIN0O68Kr8J9VFyDfHPk/BgXGMVfcX7w16IPwtYxbWz4wG4XWfKkxaC2VtU3LM2zfPyrF6A3ZJREPWIbHNt+8ckNj+5f7EWNBU5jRVX+zxIZryL3Xgpa9d4fSOu6yMy36O6+
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:48.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6130b658-f891-45de-5172-08dc4f8ca621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

The ABMC feature provides an option to the user to pin (or assign) the
RMID to the hardware counter and monitor the bandwidth for a longer
duration. There are only a limited number of hardware counters.

Provide the interface to display the number of ABMC counters supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Changed the field name to mbm_assign_cntrs.

v2: Changed the field name to mbm_assignable_counters from abmc_counters.
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cd973a013525..e06ffddb64f6 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -262,6 +262,10 @@ with the following files:
 	Reports the list of assignable features supported and the enclosed brackets
 	indicate the feature is enabled.
 
+"mbm_assign_cntrs":
+	The number of assignable counters available when the assignable monitoring
+	feature is supported.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 48d1957ea5a3..56dc49021540 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1061,6 +1061,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		if (resctrl_arch_has_abmc(r)) {
 			r->mbm_assign_capable = ABMC_ASSIGN;
 			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_cntrs", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5ec807e8dd38..05f551bc316e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -857,6 +857,16 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_mbm_assign_cntrs_show(struct kernfs_open_file *of,
+					  struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	seq_printf(s, "%d\n", r->mbm_assign_cntrs);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1920,6 +1930,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_show,
 	},
+	{
+		.name		= "mbm_assign_cntrs",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_cntrs_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


