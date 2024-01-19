Return-Path: <linux-kernel+bounces-31476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1785D832ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E07B2445C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312E58AD7;
	Fri, 19 Jan 2024 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLVSyB56"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628658ACA;
	Fri, 19 Jan 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688596; cv=fail; b=edCXMaHdXpQCvWG9+7Y09P/ijbMiJRqR23ltJO1zbvorfCBA6iNob0jmF20Zr7gSqpAvhdIf9/FvD7JdmZsHu0/vrmW+rxM8q7BFbGbO4DZpc9ouf3osMavktVADDzZTsGczocPrE7vRFyxZWHO45gRWblvRa2OeBcc52pd216k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688596; c=relaxed/simple;
	bh=sGwuEdnxU8wCjfkZC7v0pLAfCq0hw2HPdIexf2m5Kgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dU/vsyS9s1xQDnINs80zx4NQ4sJTa/mPO/djjhDV2YLr2rGb04vjN5IKYWAUqBoAT1/TjBGnclRPjR2U4ytsca5k0DTlW1Ud0dhXAQ5qsC7OIT5ReVtWjCFxYYh0sxGz9Q3iVSG1e59/vCvnvhr4kEUsRc2yRNKtpJ5uQXjD9EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KLVSyB56; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5oqNLqs0x/O73dtINJzVOO+DxOZhgs4z/1cXCeecckibel/WBH+wT+tLyD8pgqVmR7TQ16Y5J4aAPDVsV0jE4eWAFIt/I4qdykMfZLJFLKWIHIUhIALk/p7AFQL/f+J5306r91M7Ijrc7zjplPkbv5GczZx/Mvfxe9U6gFG8WB7NlDHlQsA1ZMYX58ljKOABCx9+UDDkJ89Ii1o+2e9Gz14Mdi3qg3qotncMe4sErQhF0ave6MGd9JwuCP6W43dnBkCWcuvJTB8N2ief3S1aWcwTW3FB45pfccY6vmq0E4QZ7FQf6XRipFSUuC4XmrzF/Gp9SIKWGWlMIEynbJixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd7gO6Hmmqr6fGFU0iM7fzzGSCvJQlwfRqCid5s+Sbk=;
 b=gBIisG51RApCxMqBvItOdV3KE7FLcCmeeJx7O1if+DOX2uRvX6S+0e8jt65vVkIwWEN+aPdU0DFQYATA8r1x6mCwNSXnIDnXzuQu9RbhvNy3aaTDMN8ngeIoZKXMChbPsnQ+idJ9iAy5+7KqbEztnwkto2ZqrPEAe6EE5q69fJdHFi9tCC2r3OqSYt5JM0WHopqSCX2mEBFRBVAtM9DmhS0T0OD6GMe2fzfMJLuhiFsyQQr+++AfQIrIrde5tHsRoiUfIryZuzGs3MohMCGPhJgpCXnXpE/sVgjD/iP6rp7LvTwacgECN/Ui3keD1Rbz9LB+NWZK2DckT2hYF8efvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd7gO6Hmmqr6fGFU0iM7fzzGSCvJQlwfRqCid5s+Sbk=;
 b=KLVSyB56yIB3sm+uBBrLqO+oL0cu8R/mcSvmdPaA7hptPLIQ5tKdqHQs8M6ZNcgDD2Zo9IIHPBmGq2QLY37ZktLk0zMJKrf4UAosnI8A/v9aFKfeNj1R/Xbm21NNsYdd2s0x06fyHCRiZgdOCN9Bx5S2BCmODnIEo1XSVfdLsnA=
Received: from BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Fri, 19 Jan
 2024 18:23:13 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::eb) by BYAPR11CA0047.outlook.office365.com
 (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:12 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:10 -0600
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
	<eranian@google.com>
Subject: [PATCH v2 06/17] x86/resctrl: Introduce interface to display number of ABMC counters
Date: Fri, 19 Jan 2024 12:22:08 -0600
Message-ID: <c16cac16c813a203390229d77d5ab37ebc923d95.1705688539.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c366eb-7e96-4b50-1c96-08dc191bb273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y5DkqxqurEV7hZ3EFxtgkXBr1TZV54ckQWTPTtdHR12jDgfx4tesMt+ZJUjy7vnGn7zlSzqTp24IwWwHoCZiQwpUCjwykjOClY+NLVL/HReoppSbuw8I9p+vuQBghJY2zJnMrYpCT5aos69JwhkQJW/MGrR4Q78RAzfWz8W7x82Gb3ALZpr28fAi+umfnpXpqo10fDJ3z6ywqXvbT9YLK4l6KsDKQMYgTaCq+gcPpskE6qgyMhLCQ+UCe18yFZUUjQtKilqXs6qza00f0laxFSCnALwVH5raoTUimlY+wEwY/y6D0N9Eff+ex4Z13L8Rf9XHw+QTULfzpVrLJ8ivx2UG6YF9RNVa1wUqD7Dk8EXGMcz8fWOWmCUEXAdV7YGYDp1w3LXEIE2pVoUd2k6tUhk7WRZ7eUhgLkxIIXeW0iScKjo5UR6pHK08gwobWacir1ZBIrzvFnVSg5JZMRisL9NGgkTrKd24Gu/gjM/gfwDvskMpS7DexAqynFdU8mRlxeIFkeGSv5gCFKSpJXFF5uDID5b1EaZvxj7hAl/JUzuJwxIT1JUtqxi7461uXSgqTNmYhwd6Ai6WaTaY2M1IGr+swmKyWg5b/hbSXcgojLC8BEEREqTdMxsAtqrVxyqxVIY2G/Ub2UylxQehTmBFEC0osS+XM9SEZCIn6CWlM0FB3guW4gX/WNe2e52lod8VdYJ9ecxP2fHgTwshAJKWx2e0XRwxxmnznbCL5tuM+Cb3REDd2ehTOgcMqk2sBNATEuW1VDGPWaDswqZ9HWJ7Hw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(4326008)(8676002)(316002)(8936002)(44832011)(36756003)(86362001)(82740400003)(40480700001)(81166007)(70586007)(356005)(70206006)(26005)(47076005)(336012)(426003)(16526019)(36860700001)(7696005)(478600001)(110136005)(54906003)(7416002)(5660300002)(7406005)(83380400001)(2906002)(2616005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:12.7373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c366eb-7e96-4b50-1c96-08dc191bb273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882

The ABMC feature provides an option to the user to pin (or assign) the
RMID to the hardware counter and monitor the bandwidth for a longer
duration. There are only a limited number of hardware counters.

Provide the interface to display the number of ABMC counters supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v2: Changed the field name to mbm_assignable_counters from abmc_counters.
---
 Documentation/arch/x86/resctrl.rst     |  4 ++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index ecc6c65bdaca..73eeb50fd0b5 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -264,6 +264,10 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assignable_counters":
+	Available when ABMC feature is supported. The number of assignable bandwidth
+	monitoring counters available.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a6c336b6de61..fa492ea820f0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -823,6 +823,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			resctrl_file_fflags_init("mbm_local_bytes_config",
 						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC))
+			resctrl_file_fflags_init("mbm_assignable_counters",
+						 RFTYPE_MON_INFO);
 	}
 
 	l3_mon_evt_init(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3e233251e7ed..53be5cd1c28e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -811,6 +811,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_mbm_assignable_counters_show(struct kernfs_open_file *of,
+						 struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	seq_printf(s, "%d\n", hw_res->mbm_assignable_counters);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1861,6 +1872,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assignable_counters",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assignable_counters_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


