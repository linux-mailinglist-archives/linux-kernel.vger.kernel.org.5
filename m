Return-Path: <linux-kernel+bounces-123952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46DA891021
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27912B22165
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679D73984A;
	Fri, 29 Mar 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dh43/HP/"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB838F82;
	Fri, 29 Mar 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674591; cv=fail; b=NyRjo9xHmAVIKaOWUcKZG5hPInaIkeOCGVXEU3Hl0D9i5BXQGdyOa4gxzN07vsBYMySxVqSJdVEbipF37/HCOn2Vfs/FA9Z1oAtlyCD2aReqC8akEcDdNGYAENOuszSrn1qGrcHmfEcglYcCIefPX3tO8kYuhDDB+kxAmFRHXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674591; c=relaxed/simple;
	bh=g4Ulnn8jF08JjMi6Lz+HZqUApXlSuWxkwYUOvUbu07k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1mMJBGt395O1lrsm8aR0Qs5VSCS7fpxG/5IjX+YSramVvQEOWfZ9rheJ6hFR25/0c0XxlEF9GSlAHNNDYPYV1ItZC92SfMsH7ExlJ8Faa+oFYCcdccb18oNxN5E5hHCybqc4Jj4ImzA2Nzx/xyCl0G9Ws0l1Ix29wWLPOxdGS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dh43/HP/; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4DbTsB0Nt/iM335dmFTdRJ3Y6wWgiPd81H05xycidSkk0hyEVcom9G1IEdVDsrPCFQCrFKyAwf95fGQ3qFAcHtOM2v2XtkGoA6BeuoxwxXlqR7aY03CMrl0KNkzV1aIoKdsMDV/sBBCul6rIy1cz/gXGy5A1MtTHMxc2WMKCmMmOytAcjZNKSB7tXVDLQ7Jichhj6pnQP22TOw0puoOKjcKU27v3vw9XwUGhGYAUTGKl2iJWoLl5HqVSzeD2zE15oyjATF7oTHGWEVV+93oP8P1rvJqwcp7swfj6kLdlSTgGBtReeTUjuO4E8ppcSjcc2mPuwotxiHEEfxbn/d/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAaNQ5s4VIYc2WpMXEKOfa4NAJy+MC6nPf4guP+lWbg=;
 b=kqpSYvDlv9N/JNEniQ6XRwmJcMlU4MuXlhXR4uiTZA9nPBd0r9v8i3SnlgS7suxRgA21PugWEtqQXk6yxikqdf3y5oMlo8PgdCh4rwuEDplcbpUd0Z3QIDv5coER6CBJtEcbr80bba3Iy0tsQbnME8XxFEyA9CQVL/7oM0fNqjcNO4dw6ZO9HF78TyP7UXBDdTGWiClbE/DpLGVMRJYCjxibgga00LcDgrMA3a0YYHdnMed+VM6Rid1+3SIroE+wPKjqV06ClhtymfXKICBN3U7JhIZoyPw7iUwbHwrZOxvmjFmTzMBWQwWfMVw5cqzwiW1bO1gNO/hW37oz4GlFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAaNQ5s4VIYc2WpMXEKOfa4NAJy+MC6nPf4guP+lWbg=;
 b=dh43/HP/KZzhswuNHAOChsRGprFV32g95Ine+TW3jJ9YWtMzrumSQ51T1v7vVvMC8YkxPrpe6Ke+4d/PW+w37pguuFHaFcGCAm15bKJy2mQqqg1HwMCZMWTBhfe/fhQJ25E8XNpw9ZZeS+zXLNZwQ1Ai7ashC6do3EIqC39j5OY=
Received: from PH0PR07CA0097.namprd07.prod.outlook.com (2603:10b6:510:4::12)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 01:09:47 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::fb) by PH0PR07CA0097.outlook.office365.com
 (2603:10b6:510:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 01:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:09:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:09:45 -0500
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
Subject: [RFC PATCH v3 15/17] x86/resctrl: Introduce the interface switch between ABMC and legacy_mbm
Date: Thu, 28 Mar 2024 20:06:48 -0500
Message-ID: <b7e26bb95fb32572f5f0259ee3f9651b89fd17d8.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: a1578d03-72d8-4b7d-7ace-08dc4f8ced25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FtHMWjssk5hExAfjpF8tB19Q0hl703bV35tSu3ak4DM86QGWSd2CUZnKzaUcq8TienyvYJNiS43G3qIfjvWRvlzCqSfWM1DfoiiR3KjoNnFkx/QsZugXrDoLVM2egzTfYoudykhUopytc7Nvvze0ZwziSEKpHaWN3Hp/9A+OPlZHIALUXV7EcMyFUgcInNTxY5WoG0nZEN8WinnQmDxFkUUk8Uve5tAdNAbeX8jjoKqOr5O17ZI8m8gCPXFwMwx21R/l17nGolwJzDunnjYm93itzgPaejOvyP9TAEVWB+0/p9uZUnjEo1CgAE+8j2jHWZH/nKEtB6KncfmtLmDl9l/3AwzrzyiaoQX65y3ryq/qYUG+Tf8bsP2QVe5NTg6E2sAEZHul73DLJjXr5fs4Gv2GqWh+f7tdno9BvlWbI/Ak2P4sRlQ1szDg1cSOZgpKA5NzzPIx0RHw3YZsj8GqfSDpEbJEi7CMAH9CF0Y3n2ifa0cyGeYURn3Vuz+e/X061Mn5XRhSS/nnlIzZH+x6N/nOghdxDmEUqjFsfW9EE9dqcy71oe1gMxQk88NkLIqq3I76w0XbY9G0BrQxRhhjbv8FQW+PtjFucGFyo7Xg0q0ZfqI6urNVmtvmDVFrE82F1wgx3NyNh0eTmCx3aY14sw1bW+JsSmlG7Oz31W7MMx54cE53SncuJZpQEbzPzOOikGIxYTn2JQtXWn7Oz7Hxrh+vAWbC4H8i7L3h1rRJGQ6WbCF73HCSkiQUZ0k41/DP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:09:47.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1578d03-72d8-4b7d-7ace-08dc4f8ced25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Introduce rdtgroup_mbm_assign_write to switch between ABMC and legacy_mbm.

By default ABMC is enabled on resctrl mount if the feature is available.
However, user will have the option to go back to legacy_mbm if required.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 14 ++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 39 +++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index e06ffddb64f6..3e441b828765 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -260,7 +260,19 @@ with the following files:
 "mbm_assign":
 	Available when assignable monitoring features are supported.
 	Reports the list of assignable features supported and the enclosed brackets
-	indicate the feature is enabled.
+	indicate the feature is enabled. Users will have the option to switch
+	between the monitoring features.
+	Examples:
+
+	* To enable ABMC feature:
+	  ::
+
+	   # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_assign
+
+	* To enable the legacy monitoring feature:
+	  ::
+
+	   # echo  "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
 
 "mbm_assign_cntrs":
 	The number of assignable counters available when the assignable monitoring
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e58024e95e2..a6e0ef2631ae 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -896,6 +896,42 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/*
+ * rdtgroup_mode_write - Modify the resource group's mode
+ */
+static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret;
+
+	if (!r->mbm_assign_capable)
+		return -EINVAL;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "legacy_mbm"))
+		ret = resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, false);
+	else if (!strcmp(buf, "abmc"))
+		ret = resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, true);
+	else
+		ret = -EINVAL;
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 static int rdtgroup_mbm_assign_cntrs_show(struct kernfs_open_file *of,
 					  struct seq_file *s, void *v)
 {
@@ -2078,9 +2114,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_show,
+		.write		= rdtgroup_mbm_assign_write,
 	},
 	{
 		.name		= "mbm_assign_cntrs",
-- 
2.34.1


