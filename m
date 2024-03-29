Return-Path: <linux-kernel+bounces-123944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF3891011
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24035283757
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0741F33CCF;
	Fri, 29 Mar 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zu/Pt+Em"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025431A94;
	Fri, 29 Mar 2024 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674480; cv=fail; b=k8GGma4PRyUfDPrc6ft44fjH7DjGJwG8NduIq+xx2/WJ52ywrpQKJSV5oETF4Ru6Vu4G9u91NdS1rjR+d2hk1sp0y+x7DnVNy/s9FfS2cxL90YiDdcv3GH3fOBmM71LcJ3PLtOGXGPr8RNt72Bf/Hv29VLb72hVUzYO4Kh+SOSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674480; c=relaxed/simple;
	bh=orTPKa/rxOGUD0zgLlNhxB/OGnhL//AL7AeKvxiwBAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSxN8tzc5t+Z/E46rkRJzl4s0Zhx3HNKTn/cqRUckQw/5ijIp1QzYWNL2JCPpBuj+pgwSw3WFUSdr5rwLUSdvPa9/PM0pnOO1nw0Kidt+jpTw34dWVEePKjzq+HnJgPAG3lpXxfGZYWVk4LiCmQ8md3foptz0dZcktt/F19Ev4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zu/Pt+Em; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkTEscBjp1vWIIwNhUvvck1/mT9oUTwxHPEgtiMHJ8h2zDhGYlyLMdu4nuGRUFM0z0fAYgG8bFIhMPv0p8Hk6XCW7FcT7Y/E4EmjujpsBVsTW47f9Yjey4VvqBghk9qS/cdSytsNJoO0owrKRZWRH7B0JuTBmklo0t5Lm3ZQ6GMwJppjp42E1S+dDpBLzufVoDDTmgTkLrkmwPZJA0Ai+sNHzuNRrReE6WHoJNDIi3AhHnwFpaNTgrrjSp8EpSncXg4ordqjjIhlXPiNs3nFXUGl2o9Kp0CMx3uam5FtT63GZLe0pmOA88nm2NCrX/ojCTMK1COOg5R4KUO5o+dw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOqeAm+AJamlf/q9XoaWWxNBK0JLDLGWa9K02fLDo44=;
 b=GAqX1uewKQm8rxry1/Z/kn3l4/WzQrXZU6K+j6IyCvB9EXF95C/g/UJc1YVs3+uCehPSHLrkwEN7yp4oinymAB5DKNbMnr/Lv85s0H1cDjTonkkW0wtQZI0hUG15PTbd5wlv+NzHr4UxBoXwaGYlWxScmIOCphZFAXPHDIiIENVD7/0YxtT61EAMuZj7ZzCq3aHvVnBMygQhjoLRMMHzBzMR5re9H9CPHFnWmYaOpq8RTURUKtlB12IDiNlbuphLTWTVItS/BoicXbdpw3FHak09HISOBFlZkwQI0le7jhr0L2/r95MU39UWClxmgIRjFf4lcOdUq2Dqv90WoKqc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOqeAm+AJamlf/q9XoaWWxNBK0JLDLGWa9K02fLDo44=;
 b=zu/Pt+EmuGXtvIBKBHKa/1bodTgzbXS+5ZALouhYoUvucBdUFt/JHAaG0gFCEo9j4ugCqyWQb47xrhw5ZfiQrjCYcgOwzhSy37wCdIsdhFMfVLumbMj/6lCTH7it279KebWuDJkp3R7eqV8Bz8xr+KSosuY2vyKLfWkjGF4iCnw=
Received: from SA1PR05CA0010.namprd05.prod.outlook.com (2603:10b6:806:2d2::12)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:07:56 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::4) by SA1PR05CA0010.outlook.office365.com
 (2603:10b6:806:2d2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:54 -0500
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
Subject: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable ABMC feature
Date: Thu, 28 Mar 2024 20:06:40 -0500
Message-ID: <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbbad6e-61d9-494b-5d0a-08dc4f8caaa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w9yX+p86N/lShnRsERWPNmFOFI/q+LegSRUfmA3dcwh6qkuetas4z8by6MiOjR9FBnOX20xrBT0/qjdBzcx/PiLdHpvpnHHsLO6lI8fPoNuHCjun13bDHN0wf8lEbBAbdKFv4hCFR6q7YezplQLUddPCyzLL+bCZycyxW9LfKpFLdIr10vnf/9ooONMsDDQlng9+T4/BwzlM9Jzk9yvEIkmq7MnKOGU3KF6sDeZwg/+z5nPMUWwOnBOavO5Vtwalgh6cnFS6mJ7m/u/QtZCUJZTGFOqE1JrJDiePpQWyDtS0nQPtloWji/65k4dHMMq00/8QVvqogPCA3eEh7/jJrkqi4b9qogEbEjZdY/7S/4IuuJKbkejG6v8IzGqOCc6p5Zj/rPw2a65OQv5UWG2dPeZnJ7NCQPt5vUDTaSTACq3c1etlKlTj3S0hgOj48kIY4kWsexrk7O+oQhRh73XiQ4JL76DY7TRFEjAky3WicBGp3rdUCqkWcAtTbMweDnTqEJD7alCQaC++VOAVDrXXB6TByxjzf//9P/05HT3xPeff7EbTJ5tc9z5bdyaLpfS3yf5SSVFGo/cixlD03dgPTu2r2+Azu/IrN79d7fi3REgWG4lr7f6O9DB4kVirmCLkJ1BFdRPG4Q4lUQXNSL7htnZo7WbaN7hgqGj47Huk9lPHN3C/K6uEM1GFCMdISnqpBkbg0xwVXFt65lNPdK/b4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:55.6384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbbad6e-61d9-494b-5d0a-08dc4f8caaa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

Add the functionality to enable/disable ABMC feature.

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
v3: No changes.

v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 12 ++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 +++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 05956bd8bacf..f16ee50b1a23 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1165,6 +1165,7 @@
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 722388621403..8238ee437369 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -96,6 +96,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	return cpu;
 }
 
+/* ABMC ENABLE */
+#define ABMC_ENABLE			BIT(0)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -433,6 +436,7 @@ struct rdt_parse_data {
  * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
  *			Monitoring Event Configuration (BMEC) is supported.
  * @cdp_enabled:	CDP state of this resource
+ * @abmc_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -448,6 +452,7 @@ struct rdt_hw_resource {
 	unsigned int		mbm_width;
 	unsigned int		mbm_cfg_mask;
 	bool			cdp_enabled;
+	bool			abmc_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
@@ -491,6 +496,13 @@ static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 
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
index 05f551bc316e..f49073c86884 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -850,9 +850,15 @@ static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
 				    struct seq_file *s, void *v)
 {
 	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	if (r->mbm_assign_capable)
+	if (r->mbm_assign_capable && hw_res->abmc_enabled) {
+		seq_puts(s, "[abmc]\n");
+		seq_puts(s, "legacy_mbm\n");
+	} else if (r->mbm_assign_capable) {
 		seq_puts(s, "abmc\n");
+		seq_puts(s, "[legacy_mbm]\n");
+	}
 
 	return 0;
 }
@@ -2433,6 +2439,74 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
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
-- 
2.34.1


