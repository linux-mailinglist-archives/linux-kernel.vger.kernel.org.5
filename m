Return-Path: <linux-kernel+bounces-123954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56849891025
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E9286F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9151C691;
	Fri, 29 Mar 2024 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eRLnAt2m"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EC14295;
	Fri, 29 Mar 2024 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674652; cv=fail; b=RlT3j+hclP1Cy9hK8fgK8lpUe3GAV/Hoq0ip3TYzYMNzChXKNFrvnkoxqbn8GyeiVuiWI0WfzcHEmGWbLwyTaLpnTrDDd6cN67+mRArw0kkyWHAAwRj3/gZI1D3O3D21tb/V4tDbVRh9yUk9WivqECtbbclkIG99+tj5+EXoCdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674652; c=relaxed/simple;
	bh=j/L/8Fd2ZDtatE8Tf9X0+9t98XB31LL/TEEV817eMnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECWLY0a+AwLkeHdi+hotA4Wl22ywu3niqVlkuNMnAS+biAhV7o/54JFN0wSjEB8T1AdjZaUDPpDrXSG0abeBRTGQqavBmBeHAfdNCc7QNSzXxCeVIYCB/E5x1pm6JypfdRKWr8Xt+5xaQNLGj7N/z6uVQbRhe09gg8tX3tHiH7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eRLnAt2m; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjOwqWtS2CQVfv8XwKds121pkEtmX9z22aJTItsKW5PAe0itN6Dnq2NnegdTpJrIO1EHWleaJYHMhClfftNwSM8TbV/2dbMjAlhvipus1Cbgg6flFzSL2mkaqCvC6qBBmzoEmUoyzvfpfAV+hqIBnXmaBD8gJ4NHsuAZNupZALMADkl/oMR2Fc3ThORg20FoSHq99u4n4V+h2caYL/zlhAf74VUnWgSPa/D5xaP9gHeytKDewkWAcbe5C/1340yiEGMzWO7kIbHIp4krESMuj8ZETHPmtkLONTMc3pkMAPMlMcM0ej0anFgajc5gO+3BDvcUHot1Vb1++OuA0jbPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRMZ12XDUFWCwF6B9BdCEs/RhTenTJMLE1euyylpN40=;
 b=RGLDTJJE4BRRbhU+6KGqT6iGrLEuwWB/lqKxvqlZXDLgX++g53N7JIdMhl2pgrhH9yIAogPN16l4WxE8lFgjxNzpciHn3+VvNezh2hgt6RO0oPke90aTGLAPX0FCRzDu+1JZRFVAT1uLoPeXfrXOBsgSrZ6u19wf2akCUFBu6ts81fKLkqE1lDJqtMLOovAl8bNsXzNuc7R0wYmVpgJF6SwcrC12dWlhCEpkvZpknReXsS9JcQwGyPzhwbe02fwovrqrp4L0vvhN1tjj5Q6vRlvg9OPDACqIbeQOoApHpIJLE5/L4bk/TKXMbzPr4s3QBt6GkKr4eILQ8LMxmOXLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRMZ12XDUFWCwF6B9BdCEs/RhTenTJMLE1euyylpN40=;
 b=eRLnAt2m89DK9XyM5+r7m6bSw9SUyhFLS0s1XAPRL+OvvYlq9iE97SV5TjTPiKrVoq65Y8zQq8VbqVpGQiYQReaxVpWuRMvBjQbSdqUEayy6Eo1kzljtExIES7SCX8yZuxwghsXQN39YmCSvNLF7Qc8wOziaFhfLJG1wxIh4ehs=
Received: from PH7PR17CA0036.namprd17.prod.outlook.com (2603:10b6:510:323::20)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 01:10:48 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::50) by PH7PR17CA0036.outlook.office365.com
 (2603:10b6:510:323::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Fri, 29 Mar 2024 01:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:10:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:09:53 -0500
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
Subject: [RFC PATCH v3 16/17] x86/resctrl: Introduce interface to list assignment states of all the groups
Date: Thu, 28 Mar 2024 20:06:49 -0500
Message-ID: <d3eeb5340294bf9d4dea134d1856afadcecf5a1d.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 718afdde-e307-4419-8f80-08dc4f8d1157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qf/DZXHlPxpYovOOIl3gsjrC7g/DQUEi+T4grzZzBCf8AaZ1Ap0banCJ1NzVkh0Z9gekKU9Ydqz+Qb7tLnSfgffROqYhO3iyTbpxWlwIwFubPKzy6wMyeOkzlU9V7mxNo+md4TLsHVB7jUSiI3I6SYAXdNHQ2729FxpyJndbk1v37aAX0sx+I7NHF6yzN4+97ieK67yEs1AwoWKw6F8qgGyAu1zujvUzoSEpqL8xkfo4F8R4LsEirHzQyKWalXZpoqb3j0qMoaKIKfVZ/gUbH5+pnbqDEeQj2qh651giUUOkxjEE/iho/d8p/Ajvvfgh6Wz0Ae1OAo8iOvaNlEBAMJVsAMeSAAVik0IPCl/i9JkJ//IsBhLwTy80MfpuCv3ttbJEq3IDCE4ADQErNlx4/fNSpuR6SDfnl7CeecTd+OFnts8epbdzPnvcGoKH/W36tF09JSyCpMxqzYw+7jw+V47220Ej3YPWGnHps37hmI8pHpWLZgrKn/3wz8OJnpSgOnWi4Vp0GVB5iNSl62/E4XFloT1/9frNc7kZExb+6t4UosMDJhWL87B+ezSohcsKw3NPfQ1301ysnclzluBWG+Ac0LOC4aF3j43aK0XVlzhUguEMU8EYCxs1ks9CLCuFtdYuIe0muoFRBizKXgdksnSu8C4O4OX3LBwJTDcO+m1lotc/CeD6fzppvfycWwhP2hcDD24pD35/V2UtDVkiuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:10:47.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718afdde-e307-4419-8f80-08dc4f8d1157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

Introduce rdtgroup_mbm_assign_control_show list assignment states of all the
resctrl groups.

List follows the following format:

- Default CTRL_MON group:
  "//<domain_id>=<assignment_flags>"

- Non-default CTRL_MON group:
  "<CTRL_MON group>//<domain_id>=<assignment_flags>"

- Child MON group of default CTRL_MON group:
  "/<MON group>/<domain_id>=<assignment_flags>"

- Child MON group of non-default CTRL_MON group:
  "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     | 51 ++++++++++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 85 ++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 3e441b828765..2d96565501ab 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -278,6 +278,57 @@ with the following files:
 	The number of assignable counters available when the assignable monitoring
 	feature is supported.
 
+"mbm_assign_control":
+	Available when assignable monitoring features are supported.
+	Reports the resctrl group and assignment status of each group.
+
+	List follows the following format:
+
+	* Default CTRL_MON group:
+		"//<domain_id>=<assignment_flags>"
+
+	* Non-default CTRL_MON group:
+		"<CTRL_MON group>//<domain_id>=<assignment_flags>"
+
+	* Child MON group of default CTRL_MON group:
+		"/<MON group>/<domain_id>=<assignment_flags>"
+
+	* Child MON group of non-default CTRL_MON group:
+		"<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
+
+	Assignment flags can be one of the following:
+	::
+
+	 t  MBM total event is assigned
+	 l  MBM local event is assigned
+	 tl Both total and local MBM events are assigned
+	 _  None of the MBM events are assigned
+
+	Examples:
+	::
+
+	 # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	 //0=tl;1=tl;
+	 /child_default_mon_grp/0=t;1=t;
+	 non_default_ctrl_mon_grp//0=l;1=l;
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;
+
+	 //0=tl;1=tl;
+	 Both the events on the default group are assigned.
+
+	 /child_default_mon_grp/0=t;1=t;
+	 Only total event on this mon group is assigned. This is a child
+	 monitor group of the default control mon group.
+
+	 non_default_ctrl_mon_grp//0=l;1=l;
+	 Only local event on this control mon group is assigned. This is a
+	 non default control mon group.
+
+	 non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;
+	 None of events are assigned on this mon group. This is a child
+	 monitor group of the non default control mon group.
+
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8677dbf6de43..8a2e2afc85e8 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1062,6 +1062,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			r->mbm_assign_capable = ABMC_ASSIGN;
 			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("mbm_assign_cntrs", RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_control", RFTYPE_MON_INFO);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a6e0ef2631ae..9fd37b6c3b24 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -932,6 +932,85 @@ static ssize_t rdtgroup_mbm_assign_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+static char *mon_state_to_str(int mon_state, char *str)
+{
+	char *tmp = str;
+
+	switch (mon_state) {
+	case ASSIGN_NONE:
+		*tmp++ = '_';
+		break;
+	case (ASSIGN_TOTAL | ASSIGN_LOCAL):
+		*tmp++ = 't';
+		*tmp++ = 'l';
+		break;
+	case ASSIGN_TOTAL:
+		*tmp++ = 't';
+		break;
+	case ASSIGN_LOCAL:
+		*tmp++ = 'l';
+		break;
+	default:
+		break;
+	}
+
+	*tmp = '\0';
+	return str;
+}
+
+static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdt_domain *dom;
+	struct rdtgroup *rdtg;
+	int grp_default = 0;
+	char str[10];
+
+	if (!hw_res->abmc_enabled) {
+		rdt_last_cmd_puts("ABMC feature is not enabled\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		if (rdtg == &rdtgroup_default) {
+			grp_default = 1;
+			seq_puts(s, "//");
+		} else {
+			grp_default = 0;
+			seq_printf(s, "%s//", rdtg->kn->name);
+		}
+
+		list_for_each_entry(dom, &r->domains, list)
+			seq_printf(s, "%d=%s;", dom->id,
+				   mon_state_to_str(rdtg->mon.mon_state, str));
+		seq_putc(s, '\n');
+
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (grp_default)
+				seq_printf(s, "/%s/", crg->kn->name);
+			else
+				seq_printf(s, "%s/%s/", rdtg->kn->name,
+					   crg->kn->name);
+
+			list_for_each_entry(dom, &r->domains, list)
+				seq_printf(s, "%d=%s;", dom->id,
+					   mon_state_to_str(crg->mon.mon_state, str));
+			seq_putc(s, '\n');
+		}
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 static int rdtgroup_mbm_assign_cntrs_show(struct kernfs_open_file *of,
 					  struct seq_file *s, void *v)
 {
@@ -2119,6 +2198,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_mbm_assign_show,
 		.write		= rdtgroup_mbm_assign_write,
 	},
+	{
+		.name		= "mbm_assign_control",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_control_show,
+	},
 	{
 		.name		= "mbm_assign_cntrs",
 		.mode		= 0444,
-- 
2.34.1


