Return-Path: <linux-kernel+bounces-123949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0EF89101C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548261F258F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EF22D603;
	Fri, 29 Mar 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GRvp7Huo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A02C697;
	Fri, 29 Mar 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674577; cv=fail; b=s5BrI8/tumhtqxKD+dnq2FnZ7GG0EI5M1aKQoOil1OYNoG4S3PorAHalvBL8V9NBzgIz4WfmIumauGoFFgv5K6S2sHkFv20mbXvpkBqGKmB4o+bXtHOe/fx/6T6288zce4IyDGBGQe25fd+QDtdcl1z1y126ZL0A701YOWRjf9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674577; c=relaxed/simple;
	bh=YO3fZ/XPsUoH2qqk/4hYWmQA9IO4UPm/SwjmXL0Z7MQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzNvg3xhwNzrYjtmxwKjeZ9Enfj4EtoGElnFHt0eakN7qqaimgItJ4uDXRH8ZueMubo6GaPwud8dhBK23P4jaauaC1neU8ZfV4PznUpGWjjzdPEMaT5X+VKlpwdEueO4xzfnTVo4OrGYVY2hx+cvaILWGmcMOI3eP9kFSVxeekE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GRvp7Huo; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnKKV7vbUQct7QO0fsogi1yOh4Puu9MCTp9Svm/Xz/IZ1ki9ghWVRGtXrKJGZsJR2IpRV2+SIElOdCN3QS8GKV8GZoXdyQXJ6AnVounqrzNIvNkenfODeGn4UDYaT0G64reMljngvj3nMOCQqtY2NRzqg1wk4h/OQAWpPW3G5Eoy+2lAdeMzuH4Z+TPa7/Ikhi1RKQxsx41ZK+OGXLat7lQ1fFBQw4DmDe7/uKmB4dhTgXnxB7pM6sEldbetMc3ToqLmOx++yeXxEN8uu9fvpvlrNGv1RWTySvVCVDCMmIpEMvp0gKYAWtpiqeqfsuiabMHvHbgdUSHklcJT+DLgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2p7nJ1A8WSMuQezaXRs3deecbNNBczuoD6/RYU08Qtk=;
 b=Xr5vDL5sZAFfvcpL/EpOCfhlGSut32eyZblOElWuTPBqGUNw1mSHdv7K7xvboqHbrW/d7UpttnH+IJl4YL6rS7ZiAjSjUphC0Jvyf075H83J7aIt2KPfxYNMZCPXb5n92KA5AR1gojHZnR9dtmoJtnRFOPw+3hveEPgLptnXNy1AUx9t+KTkFXeGg76/szdBnfPqbjyiofnxz2XqTfJcvdjhshZ2Y9r46o81zLkKJ3P7nwetk9ogJxe0VUVlipiRJhH4vpUPbsigHExm5VvzUcx2SnUssIBIJi6ODoxzFlR+DykvVxQVbwJgdjzirL6YtbSbe5pehzhZixIEn/2yUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2p7nJ1A8WSMuQezaXRs3deecbNNBczuoD6/RYU08Qtk=;
 b=GRvp7HuolXt1LR8EUO0xvuBOdOOT2tXpX5GRq2Crd0txDAv0IU4ft7SqmzAqGNyvjjCqiP4x5NdVFZVljre7qfz+VrL8K5vLlxNacHiCIgMDPXko4ueiGMBDRrh/tvlcxbrmIpfZXgl9T6rN/e0WC1X/4TrlrJvO6lx9qp21v/w=
Received: from PH7PR17CA0028.namprd17.prod.outlook.com (2603:10b6:510:323::8)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:09:30 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::e3) by PH7PR17CA0028.outlook.office365.com
 (2603:10b6:510:323::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 01:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:09:30 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:08:55 -0500
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
Subject: [RFC PATCH v3 12/17] x86/resctrl: Add the functionality to assign the RMID
Date: Thu, 28 Mar 2024 20:06:45 -0500
Message-ID: <a6cb26639976873b1b85ec1606c2168493120ba3.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: e72e4850-109e-4774-b6f4-08dc4f8ce32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NjaDkZnLyRNkfs2xF6j1b6LMPRPl+qrfMHeuIGx16ft8V0NarWqigWWLFdwcOTW8ZZtExSAbaT/9ptc7FirbxbjKmhprpYjsfd8KKhw9VSEqGkbchkLl05MOG3deGZ5VFuipj175cbWBrjr+PXHGJCsZ4ikIiMKCqR0w5nmXLfs9hVrcWx1C6lu+nMDsnfPm8QpUA05J9QDjjIJlnKfj5OqA8t1EswV3OOAN8sarFm5chkhs5C1/+ItkSGSd/VseWd2bxLcuk83EKfxI0BG6jAt+g5WgkAuTl3VsRxfPuqf4K/1tUAWqC+h0DyCZT3GlN+Zz8wgu3A+RXXRc1Fods1izG2sngdPvaA2Eq9wwSDCQSlOK/kYT5NDEsReXVxwFtOoSOqvdzTcKQ8D3U61Uqm6B3sWCz+x1unV2+kndk/b/MaJIM9CSWD5PMbxAX2QBtQcgq1y7/dIh+3qkFhFH14V7bg/Wavzs51qGE5WxLHKfqfXbKlUcrWgfAicbmlpVqY/iak1FZtmGvqavnvaeR2y1vmLw65yhcvf024RvN5krzI/1NO5qcOe2By1T48Efi92XA3cSALG/XXxV3+A76Y4dsSHIW02EEE1fKVfcgessxSfQjAP6JfESYAlhBl5nU3kUUHIs4SPtm5pY0vXwNLMmeoezxecrrI/X2+qiJqWK4VgPMXjd4WPmHvSSFtnXt7E2MvhTLwWi7uq/Df5IVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:09:30.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72e4850-109e-4774-b6f4-08dc4f8ce32a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

With the support of ABMC (Assignable Bandwidth Monitoring Counters)
feature, the user has the option to assign or unassign the RMID to
hardware counter and monitor the bandwidth for the longer duration.

Provide the interface to assign the counter to the group.

The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (MSR
C000_03FDh) and L3_QOS_ABMC_DSC (MSR C000_3FEh). Each logical processor
implements a separate copy of these registers. Attempts to read or write
these MSRs when ABMC is not enabled will result in a #GP(0) exception.

Individual assignable bandwidth counters are configured by writing to
L3_QOS_ABMC_CFG MSR and specifying the Counter ID, Bandwidth Source, and
Bandwidth Types. Reading L3_QOS_ABMC_DSC returns the configuration of the
counter specified by L3_QOS_ABMC_CFG [CtrID].

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v3: Removed the static from the prototype of rdtgroup_assign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 88453c86474b..9d84c80104f9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -651,6 +651,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
+ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7f54788a58de..cfbdaf8b5f83 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -202,6 +202,18 @@ static void assign_cntrs_init(void)
 	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
 }
 
+static int assign_cntrs_alloc(void)
+{
+	u32 counterid = ffs(assign_cntrs_free_map);
+
+	if (counterid == 0)
+		return -ENOSPC;
+	counterid--;
+	assign_cntrs_free_map &= ~(1 << counterid);
+
+	return counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1848,6 +1860,80 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static void rdtgroup_abmc_msrwrite(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+static void rdtgroup_abmc_domain(struct rdt_domain *d, struct rdtgroup *rdtgrp,
+				 u32 evtid, int index, bool assign)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *arch_mbm;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.ctr_en = assign ? 1 : 0;
+	abmc_cfg.split.ctr_id = rdtgrp->mon.abmc_ctr_id[index];
+	abmc_cfg.split.bw_src = rdtgrp->mon.rmid;
+
+	/*
+	 * Read the event configuration from the domain and pass it as
+	 * bw_type.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
+		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
+		arch_mbm = &hw_dom->arch_mbm_total[rdtgrp->mon.rmid];
+	} else {
+		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
+		arch_mbm = &hw_dom->arch_mbm_local[rdtgrp->mon.rmid];
+	}
+
+	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_msrwrite, &abmc_cfg, 1);
+
+	/* Reset the internal counters */
+	if (arch_mbm)
+		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
+}
+
+ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int counterid = 0, index;
+	struct rdt_domain *d;
+
+	if (rdtgrp->mon.mon_state & mon_state) {
+		rdt_last_cmd_puts("ABMC counter is assigned already\n");
+		return 0;
+	}
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate a new counter and update domains
+	 */
+	counterid = assign_cntrs_alloc();
+	if (counterid < 0) {
+		rdt_last_cmd_puts("Out of ABMC counters\n");
+		return -ENOSPC;
+	}
+
+	rdtgrp->mon.abmc_ctr_id[index] = counterid;
+
+	list_for_each_entry(d, &r->domains, list)
+		rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 1);
+
+	rdtgrp->mon.mon_state |= mon_state;
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


