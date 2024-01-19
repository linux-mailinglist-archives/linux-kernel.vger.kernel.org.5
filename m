Return-Path: <linux-kernel+bounces-31480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B79832EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882DB1F24C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33345A786;
	Fri, 19 Jan 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ccix2NHp"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC465A0F7;
	Fri, 19 Jan 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688629; cv=fail; b=nZSziEMaNDchi0EVz83Bx8HzsPSZvw7vdDhAZvZKldggpi0I0auwvDcN02fsD/7XpKIJNIVuDpKIcY3jKBeDTCMQOPe6zeprYhxhG3tmlXmdb3Xk7Cl3O7ngYCHROWg2lhpkkZ6UECVdNOk+wYg3CTrP4gh5Js+hPUSppn8gkpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688629; c=relaxed/simple;
	bh=d372Ox7UWwB6/KHtVKtZDu4MtD731rOrXFmrJSk1aYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5H9QgO0Oo3RQQz/A+1H2VdKUDB6UkESuHkScsJ49fkMRWdUXetY4kFSqn/bkTx8U8o0TpKbauZrfkvW9uqqbV4QsXhdkb0LamJ7yNPwZZAtbQsMNa097Yv8hJJVgHZbAjItq6bGHTfIMzcV7yr3qJvSFe4l/TBgV3Mb9vRsRwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ccix2NHp; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIe5kyfEgO+QN/VQ08fN1U1BTTt/9wLPHu0p2X0kuicuEZ1k5XAv2nxHMqI1SBVeOyVBFVR4EIDNW4br+YRjQfAkxRYtrMHlMt87PsrMCWA2kIlRpsXGE154XJOP3CdN9rvTS1c7Ab2blS+165oTPkoRZHCNrx4msz5aFIWVr1WdJ64mhH3zeCIQl+zWWJ8kmbEbr9IXOGyFb+GLbXeeF0uScaR2WA0K8LSO446+LD757UIqnYUDPTKtlcYGXMOV31d9olXjdBaBDgkvvd916tFM4MzOD2iLa2OJ1v/ZszQ4otRab+b7aMk4ZW/Gt8Yz8uCfjSspYTAIjqiW0YbB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fdf8f3mWa0BCIj27X3Qsu3jtc8CRV864YM83wMgkNlk=;
 b=iBaM9N+ENryhPfIZ6e891+JmvgT/nhf/HIXsctaaHCe5m23AmRupAixojaiLFjLYtVay0WDqJTO4apYxzeTexQ+ve2PxtccHNmhNuAys4sl2Yt0wZdg6ghAMls4tCekyKfTMvHNMUURI1pzM230uOFTuk54VbFB3A0UF6oxyyY7C+0Sp/aXqOSi31LLXfXcUG+6/e5lKsmRmZBrrq2oiU/OkoE8OVWlDGpl+a5Jsx6udhjQ/J8SGE1fc9RpmC/tqxkk8T3rzebXu825sfVVpQ7MXv8AiGVP8/HZxac8jUmAz/BTJneP4fdXWoJulEXmVTpO9O95mDqiV2k0LAmC2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fdf8f3mWa0BCIj27X3Qsu3jtc8CRV864YM83wMgkNlk=;
 b=Ccix2NHpyChu0Xe8xbTFZ/NQTU757kyK2fV1AJ0ha1GqP/KBgJLtfYVdblIj5GPgIjimmMqTR/Av9kDUUdNY2cTNe65EhiKzeP6auBEIrRXzHaHzzRd5LU3Y/SDIXDlWx4Un1WtvELsDhG8oJ/nUEE0hJQIA8Qf/eoXBt8soneY=
Received: from SJ0PR03CA0335.namprd03.prod.outlook.com (2603:10b6:a03:39c::10)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:23:43 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::b) by SJ0PR03CA0335.outlook.office365.com
 (2603:10b6:a03:39c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:41 -0600
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
Subject: [PATCH v2 10/17] x86/resctrl: Add interface to display monitor state of the group
Date: Fri, 19 Jan 2024 12:22:12 -0600
Message-ID: <a9b55e14539614dd16dd8f1f74f82f01b14a9e3f.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 50250ef5-bdcc-4a0a-cc4e-08dc191bc4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VSrjA/DozIU576qlDMH8MfiF/5kwJGsRNDu6qTVOlA5G/dJAISk8pzI1VRoZMLktmJtIc0GwC1xeCa08F3x06MrGIkONsbQCJQhQivssys+Rztvoj+B4caiFiB7wO/72iFZRIjx23VBQZcbFIOCktbHbkpbVMnawgXNuKF641sPh47NRf8U8BOmsgesK2Nzo9Wzveulik6r9DkyuFqZPek9+kUFLSz2Pdra3IOGMSNWtp82RpPiY0zlulc5r84c8O0E3gPUFGAv/WATe+cs0KtdukJOwspLjY5x5QkNx+w9Ci5fMkkGYMCrAqL0R+8OzKTh1nAxLQ1cvsormV7O+7C9S6zzossAzzEd6Z8lELS13X3OCdbKUT1KfCsC1aK/k30rNSg4nlNAQJV6R/2Z3MyT3QpwerrYzImkIalQq2zr96ddoJB7dpMAOJRC1ubq9wLafedPam7ECe0M1/+iXFt7ducRIKqVz4Wia00VO6z5mzVnrOtBy6HFGZiECx/mghQtGxmbwS2Rfj8pnLWfGC2OZ1Dc5XWc+zLxrSthEKkx4fyXrtI3mKoSlcC2+aX13ucpi3qSwEnaXkT/jNabJE5XKDYev6NZUtVca7WzxgkCfcrLQGvG5B/1cSVFBNE+ajfXMbX2z/wcwVO+nQN3QbUG6egoIckARrET1FrlwRYBK8aZPDb5795RDgt33y+p5rtXgBAgdoM/2r8mALrEtGURF2M3eA/9+42u71qmYXyH89DNeCLotGjvspl0zG8OYcpHkYZqEd9SRlOTjtC6sFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(44832011)(36860700001)(47076005)(4326008)(8936002)(8676002)(36756003)(81166007)(356005)(86362001)(2906002)(82740400003)(41300700001)(7406005)(7416002)(5660300002)(26005)(7696005)(40460700003)(40480700001)(336012)(426003)(16526019)(6666004)(478600001)(110136005)(83380400001)(2616005)(316002)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:43.2594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50250ef5-bdcc-4a0a-cc4e-08dc191bc4a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

The ABMC feature provides an option to the user to assign an RMID to
the hardware counter and monitor the bandwidth for the longer duration.
The assigned RMID will be active until user unassigns the RMID.

Add a new field monitor_state in resctrl group interface to display the
assignment state of the group. This field is available when ABMC feature
is supported on the system.

By default the monitor_state is initialized to unassigned state when
ABMC is enabled.
    $cat /sys/fs/resctrl/monitor_state
    total=unassign;local=unassign

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Added check to display "Unsupported" when user tries to access
    monitor state when ABMC is not enabled.
---
 Documentation/arch/x86/resctrl.rst     | 20 ++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  8 +++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 ++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index f09239cb93e8..4f89d5d1b61f 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -400,6 +400,26 @@ When monitoring is enabled all MON groups will also contain:
 	the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
 
+"monitor_state":
+	Available when ABMC feature is supported. ABMC feature provides an
+	option to the user to assign an RMID to hardware counter and
+	monitor the bandwidth for the longer duration. The RMID will
+	be active until user unassigns it manually. Each group will have
+	two events that are assignable. By default, the events are
+	unassigned. Index 0 holds the monitor_state for MBM total bytes.
+	Index 1 holds the monitor_state for MBM local bytes.
+
+	Example::
+
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=unassign
+
+	When the events are assigned, the output will look like below.
+	Example::
+
+		# cat /sys/fs/resctrl/monitor_state
+		total=assign;local=assign
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3467221f2af5..865101c5e1c2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -57,6 +57,12 @@
 /* ABMC ENABLE */
 #define ABMC_ENABLE			BIT(0)
 
+/*
+ * monitor group's state when ABMC is enabled
+ */
+#define TOTAL_ASSIGN			BIT(0)
+#define LOCAL_ASSIGN			BIT(1)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -163,12 +169,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @monitor_state:		Assignment state of the group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			monitor_state;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a45084e30738..de43be2252cc 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -829,6 +829,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 						 RFTYPE_MON_INFO);
 			resctrl_file_fflags_init("mbm_assign_enable",
 						 RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("monitor_state",
+						 RFTYPE_MON_BASE);
 		}
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9c8db9562c91..7cae6ac13954 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -779,6 +779,36 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_monitor_state_show(struct kernfs_open_file *of,
+				       struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled) {
+		rdt_last_cmd_puts("Assignable Bandwidth Monitoring is not enabled\n");
+		seq_printf(s, "Unsuppoted\n");
+		return ret;
+	}
+
+	rdt_last_cmd_clear();
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "total=%s;local=%s\n",
+			   rdtgrp->mon.monitor_state & TOTAL_ASSIGN ?
+			   "assign" : "unassign",
+			   rdtgrp->mon.monitor_state & LOCAL_ASSIGN ?
+			   "assign" : "unassign");
+	else
+		ret = -EINVAL;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 static int rdtgroup_closid_show(struct kernfs_open_file *of,
 				struct seq_file *s, void *v)
 {
@@ -1944,6 +1974,12 @@ static struct rftype res_common_files[] = {
 		.flags		= RFTYPE_FLAGS_CPUS_LIST,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "monitor_state",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_monitor_state_show,
+	},
 	{
 		.name		= "tasks",
 		.mode		= 0644,
@@ -2439,6 +2475,7 @@ static void resctrl_abmc_msrwrite(void *arg)
 static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_domain *d;
 
 	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
@@ -2447,6 +2484,14 @@ static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
 		resctrl_arch_reset_rmid_all(r, d);
 	}
 
+	/* Reset monitor state for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		memset(&prgrp->mon.monitor_state, 0, sizeof(prgrp->mon.monitor_state));
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			memset(&crgrp->mon.monitor_state, 0, sizeof(crgrp->mon.monitor_state));
+	}
+
 	return 0;
 }
 
-- 
2.34.1


