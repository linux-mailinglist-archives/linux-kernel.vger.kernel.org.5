Return-Path: <linux-kernel+bounces-123951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F189101F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D86B23449
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A7F374C3;
	Fri, 29 Mar 2024 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVbAGolf"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF4836AF9;
	Fri, 29 Mar 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674584; cv=fail; b=S5Dn2EXqphlxSdf6uZTP5z6aeydLpcaNT5b38e2dPcSINHFwAIuuoKLZhTSRf0ewwRSo2iq+hg3eBYxN3K1zrVLPXpQiaQVRzadL2ijeV16PNDiLX3ZV/vVyp1V0y4NNxj9NVtvk/Ncs1qY+4Y40ULoNR9NPvbbJkpQZmixFoio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674584; c=relaxed/simple;
	bh=RPRh2DYBCWjDaXi50CKZj3toLzpcNRA7guCHIH9Af5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuzWkHJ9szp0azMtsbw2QVM4GgcuwrKnbhWxhkb5BKTrE28Qau9b6AJMUj4ttKgID/9ykMvoqs5xB5SrIbs6iM0Jb5dLgl3CIxUoOZAdAC9yEm4xiKyOjavSNCcnZgrN+sS+GeUO0mHlcLlKCcjY8p3nPfRl7XTHtLNqrezFsqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVbAGolf; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5MkSHN5jNSJBWEVodC8lmHg7m+Kh0lgQLx0EY9OHUtK3kjr3DppcrigWOYruxgh9UJQ9M0MJbgCL82sbr108Hb1Fl8LPESYdC9frzbYBdxMzJJgIZmmt2wlbeg+rx1JU+KDgFu/28LDykekROM1y82+Ux8dpOiHLmUe9DFaawkt9hZCOk9m7FfY4woFdbNCQXfRNTSynNziIGluiIpUypXSGONPtYrlYTER8nuOmI12t4gs8X3a2DzLbpAyUHJyXdPdEhrsuK/YduPQMS/mwo1yspj3Wt/vtca+rgrfbZAs7h4eYiz74ZNWimzPxjuUiD4Grn6mvQ9xvTx4ocNSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErO//mPTA+Mz8Khf+hPgtdfm8T95ys82/ahAcF/kbKQ=;
 b=ObhFnHp2UTx8ZH8+Fhv2v2w2oFK4rbyzhItcroiVt3IpFe2KQgEqrrZk2fFcI/m9Y32Ikmn8pombSJ78BbGpvpC9/b3v+h7HN0hJK8awZI5VO6XoAuXpTFcUdnmbkIX1e7M/2y/FdZ5HNaeZXpNE10myrIjEe6A85k2IWjyUWo7dhfqkBshKxndtiNcfnlNh0Ms2eD3xsNnyetN9w+64Pbiup2RCYgE6silYStiLjA3A28mfYNJmwK2IRer/14Wp8XGznE84Q7/bV8P4/PHKU7AyM30CqiBsBoQMuiUfmAqrxfxnwG7YRxyJhaGnI5Yppk3Nqqcmw3edQX3g601A0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErO//mPTA+Mz8Khf+hPgtdfm8T95ys82/ahAcF/kbKQ=;
 b=XVbAGolfhlBLRAksaDWP0cs4SVcWTUbv8YS89USEV8sLzE+zXoBeHWfUu8bvGzisbpzy4+/RMJiyJGZsD/khIOQYlqY77eNSwpgX6eJ1iQ/L/V6LGfdTR3NxpMPtCilNNA9YI/z6xAo5UBn3c9BpFFa9D8v0ByoI3X7PxFJrp+0=
Received: from SA1PR04CA0024.namprd04.prod.outlook.com (2603:10b6:806:2ce::28)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:09:39 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::c9) by SA1PR04CA0024.outlook.office365.com
 (2603:10b6:806:2ce::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33 via Frontend
 Transport; Fri, 29 Mar 2024 01:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:09:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:09:37 -0500
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
Subject: [RFC PATCH v3 14/17] x86/resctrl: Enable ABMC by default on resctrl mount
Date: Thu, 28 Mar 2024 20:06:47 -0500
Message-ID: <e898059f3c182886b1c16353be7db76d9b852b02.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 153c0264-0f73-47c1-a8ef-08dc4f8ce895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEDX4qIYVa5BVR7fAjFZ1EMgsR4Mj1nDSXu7Hbpe5z+QvPpi/SV//ydrHGOQ9KXxn+47TaRkcixtuG2Qocw8ikkpLK+qd4mVBHHhJykKSCH3U5lATGnfGiRq2r9Uhu77hFrq4UUtE6JpjGsogDbJvJJoBreEHyP9EkuSy4Wp6xjSrZAfXP74cqx5FiurDOfDV00um0Kit0Qyqkumf54No3Oyov66UyQ6Sf/N7H6d71CPta720Du6DtcjliwsGZXYewk4DRxGqs6i2MVNGd0fAcXYtFbn5xzOawYwVXoxKbPbgRqwyr1b9Wut34QypcphWe1XS9GyUdB7VJTWaKkpV39loBLFRyNqatqS0ip/DI1dUPw0acP1CeHeJX9ERJ26zXj1TF8qFnsHZ0/aeocHVob67W5aCHl5iLyDMCASqkTz0dCqBbYrSqi8ELq3ia9zMaG5rVc2T2FIsTlegWXw5N1X/fCtTjgmkGXoiqxCozM3s4l/xE/ziLFBgS1RHvv4L4cvGQXO/SeBw7Sv4h+60t4KVevbFIVkiU6jXHaJo9bceCah8O9NtDzI/2jRSwSMYUf58t8zYs7fY8+qdmQKZpB6bwE2GvQ1z7NxKk4/Riq1ilMNNJ3u3O7VtHA6gzAu6KzqXT82dkgePcfIp14nII4KK4AHpCIOsiDSPyNXDlsGF3n4u2ibAe0lQy7NGLSwr/WHlwqy3bBTXI8sGx8lYRBbH2Xm8hFHRWuCnKHvFf4376ROf7cDvvwkrOiV3IXJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:09:39.5124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153c0264-0f73-47c1-a8ef-08dc4f8ce895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

Enable ABMC by default if assignment feature is available. Also assign
the monitor counters for CTRL_MON and MON groups as they are created.

If for any reason the assignment fails, report the warnings and continue.
It is not required to fail the group creation for assignment failures.
Users will have the option to modify the assignments later.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v3: This is a new patch. Patch addresses the upstream comment to enable
    ABMC feature by default if the feature is available.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 76 ++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b430ffa554a9..2e58024e95e2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2750,6 +2750,7 @@ static void rdt_disable_ctx(void)
 {
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
 	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+	resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, false);
 	set_mba_sc(false);
 
 	resctrl_debug = false;
@@ -2780,6 +2781,8 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
 	if (ctx->enable_debug)
 		resctrl_debug = true;
 
+	resctrl_arch_set_abmc_enabled(RDT_RESOURCE_L3, true);
+
 	return 0;
 
 out_cdpl3:
@@ -2876,6 +2879,48 @@ static void schemata_list_destroy(void)
 	}
 }
 
+static int resctrl_mbm_assign(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled)
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_assign_abmc(rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID,
+					   ASSIGN_TOTAL);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_assign_abmc(rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID,
+					   ASSIGN_LOCAL);
+
+	return ret;
+}
+
+static int resctrl_mbm_unassign(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	int ret = 0;
+
+	if (!hw_res->abmc_enabled)
+		return 0;
+
+	if (is_mbm_total_enabled())
+		ret = rdtgroup_unassign_abmc(rdtgrp,
+					     QOS_L3_MBM_TOTAL_EVENT_ID,
+					     ASSIGN_TOTAL);
+
+	if (!ret && is_mbm_local_enabled())
+		ret = rdtgroup_unassign_abmc(rdtgrp,
+					     QOS_L3_MBM_LOCAL_EVENT_ID,
+					     ASSIGN_LOCAL);
+
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2935,6 +2980,14 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_mongrp;
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
+
+		/*
+		 * Assign the monitor counters if it is available. If it fails,
+		 * report the warnings and continue. It is not nessaccery to
+		 * fail here.
+		 */
+		if (resctrl_mbm_assign(&rdtgroup_default) < 0)
+			rdt_last_cmd_puts("Monitor assignment failed\n");
 	}
 
 	ret = rdt_pseudo_lock_init();
@@ -3216,6 +3269,8 @@ static void rdt_kill_sb(struct super_block *sb)
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
 
+	resctrl_mbm_unassign(&rdtgroup_default);
+
 	rdt_disable_ctx();
 
 	/*Put everything back to default values. */
@@ -3754,6 +3809,14 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 		goto out_unlock;
 	}
 
+	/*
+	 * Assign the monitor counters if it is available. If it fails,
+	 * report the warnings and continue. It is not nessaccery to
+	 * fail here.
+	 */
+	if (resctrl_mbm_assign(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	/*
@@ -3798,6 +3861,14 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	if (ret)
 		goto out_closid_free;
 
+	/*
+	 * Assign the monitor counters if it is available. If it fails,
+	 * report the warnings and continue. It is not nessaccery to
+	 * fail here.
+	 */
+	if (resctrl_mbm_assign(rdtgrp) < 0)
+		rdt_last_cmd_puts("Monitor assignment failed\n");
+
 	kernfs_activate(rdtgrp->kn);
 
 	ret = rdtgroup_init_alloc(rdtgrp);
@@ -3893,6 +3964,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	resctrl_mbm_unassign(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3939,6 +4013,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	resctrl_mbm_unassign(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


