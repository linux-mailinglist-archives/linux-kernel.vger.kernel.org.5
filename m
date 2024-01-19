Return-Path: <linux-kernel+bounces-31477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B9832ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B628B242C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7059169;
	Fri, 19 Jan 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ge61bG4K"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5959157;
	Fri, 19 Jan 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688607; cv=fail; b=a4mV8/DHSSQ0Ecf/1vo6U8tWC/iKtoimY+LN2KIkOeFVQoqc74yf8INgTYisSRX+9k8+785EWTVw4P5ZbPSNpbF+2QrTRn37ks1HfwlUQqV9g4m2VL539kAHYor/cBi9DLi9p+7dTweDtcal4tuUEFyw4OC3HQstCt7/NYtM/P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688607; c=relaxed/simple;
	bh=j24LXBydA4TOZppOTBvX6Rni4cI1tHphkxaqIR9T7tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjVTv1kLWcchflgTPFNJZU+6KpIfPVRLH1MHcRAruB6tdv0qJHVHxieXcciFKD+47yHuL1tIIB1Si0cyvW5yzbD+mmaJCdBIRSOCe484YkCuvzjjOmga0TXNs44nNmlo6vWoaByh8YMHjYRHQ9NSxetwF5Kndr5V+7HB97cQWc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ge61bG4K; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br8s2txixW7ELdg/yW/Igx20UXFSEMwo/aaGsdc3aayivIJ5f5BCJvopml4NdKg6E/UkB3e0Z2al5tEdAf7LuJLPI3ppS4+gl+tHXHbA3uMqMKynQ3XQ+MnBG6s7k05ub53URLxDXyvll5+nfST5DN0sELqa7CIxavjbZMeUmwJC1vU4BOEdZS/XAxrHyEWu4XwPXDMeT8mMH1NrvXpc2JN6MITxRnA8LXB/voDoiTFwhp4dpipoIakKdTM/ckGNC+jnf6y1+tzaD3nkmec47FDQpjK3ybXSn79sbzreauCdWcw6yaby+agj/73v2kx1ulzg9mTQCGg+xyb5bKjsMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avoqIIrRpwGbV4ZinJYe7JbK4EM+a4EBSZvFVOvNbgA=;
 b=Z8jZuXwY3F3URnCEEC3oNG2G/2988laQPEipLV94B7qgCyBCIBGHaDiRDafD+G5UZXUwDYR5xzkMPRUiUwY6qXAIppuAwi7H6p7TqmTWG+20+MtjGlq2BZMmFiYMYw1qpadOfZnPfWNzTQru3lpbTjF0nGEI+3z/iS4ko6OtqFgz5suT54e5G4shc979xkGHiEFuQcqwQktk68phu+LJCEGyS5QhluKOvy8Mx74ShAZBSvBbhWnZI9o4SsTmBmzabJD5IgC88HY0TSc90FnjeYTawKqbOenU4N/F+eMjWqaq5bJ65BRvWer1BXPRP5xT9uqHSMoAVp1gXw4c8N1dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avoqIIrRpwGbV4ZinJYe7JbK4EM+a4EBSZvFVOvNbgA=;
 b=ge61bG4K4ZtYzK06jBuJe5mGasYKlGeaQ76sW+Cmif5GyWdk5pCDde9FagmH2NnDG0xZbgCtdOJnUBUGyvkbWD8+3AXvdxsYKYXHVw39b1xTtj06nzOMosf+HUYBkFHPsB6dM+u20jC25UKU9qGKOEvkfnnLUkyftALbLJz3n1A=
Received: from BYAPR07CA0079.namprd07.prod.outlook.com (2603:10b6:a03:12b::20)
 by DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:23:21 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::45) by BYAPR07CA0079.outlook.office365.com
 (2603:10b6:a03:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:18 -0600
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
Subject: [PATCH v2 07/17] x86/resctrl: Add support to enable/disable ABMC feature
Date: Fri, 19 Jan 2024 12:22:09 -0600
Message-ID: <c20090b12d87159fc89efd619cf5399c10459408.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0909e2ca-d408-45eb-2a6d-08dc191bb75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O8UF5xPq08+UzKYoYK8HmaxqzDm56Eo6tPgcW3we+8SkWMPHJyCiJqh4bxCdXGW1XW9mmq8yV4qTCKQvkK1kgtd2xttbWCtj9TQds4m0L56lawc48MawDabobWuQaoQVBRNpVdrCxCQKZlB5BEzTeKCE9r5aGDMSpNgV+wqC1pONo1wqEmSN9EA0tfKRze7VzuyMeiSVlUW3EBafK56y8RHut3PBPRGX8mbLmUDKEpUwL/0WiAZHRhB+ufDfEic9bO/NYrp2atcNCobiaU4eJERugPSaINCuhdfFBimxeZDjkcjNtFXk8fl6pot9Lsj+jaHVNfCpZ+aCVyhynpTMOZXiURrG8PA78tMlTEj6uje77ts3OwNZhlaJb3OLR21RZYnbDO2xIvTiyoA82oGSBTf3JEfO1mXF3BxzGukFfUsP3+KTSTlF/PfyJbyPrK1HXubRlYGan5c/991LQybS+LFA6Lw/eUhxlJZ844XYkKrEc4+h9lPF5SkYoODu890i2r9MwWtsZBooQDBHLAqPyrqzS93LkA3xDyVxj8wK5ZJL+xsZL+Vj0M3OrL82F+OX99t3JfbJyY1leSLh9PFUObs6iSvZY3081nbnUHLMsAtCgPbvMBJ8nhVbyc/WvrUdwlCOiu+mILSylptwmq/0lCtoKSd93Xss8HTqCnMwz/C1RnxRUoKJSWrRJrBWfAxr7avkALSCYJ06LbaYU5vC+dpPpURVk3vE9qRE2Bmt3k1yxnIT69AYClMuwEBnw4vg1imFyD6xbwXysitsiHzhdw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7696005)(336012)(26005)(2616005)(426003)(16526019)(83380400001)(5660300002)(7416002)(47076005)(7406005)(2906002)(41300700001)(4326008)(8676002)(966005)(54906003)(316002)(70206006)(110136005)(8936002)(478600001)(36860700001)(70586007)(44832011)(356005)(36756003)(86362001)(82740400003)(81166007)(6666004)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:20.9796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0909e2ca-d408-45eb-2a6d-08dc191bb75f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5181

Add the functionality to enable/disable ABMC feature. By default,
the ABMC is disabled.

ABMC is enabled by setting enabled bit(0) in MSR L3_QOS_EXT_CFG. When the
state of ABMC is changed, it must be changed to the updated value on all
logical processors in the QOS Domain.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 12 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 70 +++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b91b3c6..ac0ce88a5978 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1126,6 +1126,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 52ba2fc5c6c4..3467221f2af5 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -54,6 +54,9 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
+/* ABMC ENABLE */
+#define ABMC_ENABLE			BIT(0)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -398,6 +401,7 @@ struct rdt_parse_data {
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
+ * @abmc_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -413,6 +417,7 @@ struct rdt_hw_resource {
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
+	bool			abmc_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -458,6 +463,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+static inline bool resctrl_arch_get_abmc_enabled(enum resctrl_res_level l)
+{
+	return rdt_resources_all[l].abmc_enabled;
+}
+
+int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable);
+
 /*
  * To return the common struct rdt_resource, which is contained in struct
  * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 53be5cd1c28e..2fb26227cbec 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2372,6 +2372,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 	return 0;
 }
 
+static void resctrl_abmc_msrwrite(void *arg)
+{
+	bool *enable = arg;
+	u64 msrval;
+
+	rdmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+
+	if (*enable)
+		msrval |= ABMC_ENABLE;
+	else
+		msrval &= ~ABMC_ENABLE;
+
+	wrmsrl(MSR_IA32_L3_QOS_EXT_CFG, msrval);
+}
+
+static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdt_domain *d;
+
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
+	list_for_each_entry(d, &r->domains, list) {
+		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
+		resctrl_arch_reset_rmid_all(r, d);
+	}
+
+	return 0;
+}
+
+static int resctrl_abmc_enable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled) {
+		ret = resctrl_abmc_setup(l, true);
+		if (!ret)
+			hw_res->abmc_enabled = true;
+	}
+
+	return ret;
+}
+
+static void resctrl_abmc_disable(enum resctrl_res_level l)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (hw_res->abmc_enabled) {
+		resctrl_abmc_setup(l, false);
+		hw_res->abmc_enabled = false;
+	}
+}
+
+int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[l];
+
+	if (!hw_res->r_resctrl.mbm_assign_capable)
+		return -EINVAL;
+
+	if (enable)
+		return resctrl_abmc_enable(l);
+
+	resctrl_abmc_disable(l);
+
+	return 0;
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
@@ -2456,7 +2524,7 @@ static void rdt_disable_ctx(void)
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
 	set_mba_sc(false);
-
+	resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, false);
 	resctrl_debug = false;
 }
 
-- 
2.34.1


