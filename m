Return-Path: <linux-kernel+bounces-123955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2780891027
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8321F27F27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82983210FF;
	Fri, 29 Mar 2024 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YRr0Li9m"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DD1DFEA;
	Fri, 29 Mar 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674658; cv=fail; b=uS/eVyFkTJ2escWU7ZbNElZ91BFqBu8+cBvsNMaXrbFLrWHeSVDFYvpjSTfoeZxnnW9RfTgFREq/x54ynkwcHPkuAUL9dhn0Tmztk1djaAlh9xmZwG5U/RIii5ba7a5oy2umtNF68zT8CyrxRVK9K7FBbPcH2Bi2r3FGHOwIKv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674658; c=relaxed/simple;
	bh=FGWfsiiy7V1WKzRzqo8vZad/aoLHvbhS9Xl/OUhDhC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwdNiSLSMQjr4vuP1igeNizoJaEGldnWaJvET2BQ7jUkGF0aJUUx0We1cMcoWNFhhCdlv0G6fm4pu0rwh4VRHbwbzyx9yOov4BzldzOOj1eb9taiAUG4v3Zn4NteINNlBoZhgE5FPZfa9dI4Q2XgffErRCEpS/M1pvFJlOHqa84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YRr0Li9m; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN48StyNMFMxZzzknLHzB6JPFpvRI74MRbklLezFXjced6KPNXPuIIjBsVpaQThkVeWGeZ67cYzUR7THglLebGH4uTMpQQ6p3ZGEyGi7autKba9NWLe4BHeB6wic/u9zhI8Ulkwf9laMpY7gXocVI9f15DYhWt/yn8V27BrJ8BL/AGNHLq+C+aooJtGe/c9AfvCLeg60YTJU6+ua6k7KbYhfjnM0b8tWnJZY25M65JTPSnWG9p1bWFyaXnG12TYvD/ILl1b8Klv8fbhq+cPfHYyo+Ls7SHz0y+IuPx6bdcvYA6Fu9WG5Lzqa4meC9j/m0prOUUzV8yBVG9TuYePK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrfYPitn0CCm09cuqxXJQ/9fT+ii8ETw5F8/sXsPKQY=;
 b=cfLxvrM8MgIKbt/xeTDg5hnseh3k9YcjbOrhSK1D9mKWYu1AwI6252SmacXFbzAxs3fe6/lgrSwl8NF9p9KEvsWpaDUrd5E5EIGtEZbRHq2PNfcX6Ep3pYqtuDEHUWPT1RhOPneEKbhyKp/CFaAq3CIslWt0sf0DurM+kfxH+1CkfY0DSofdOXlIIDwd3meg6MR2mdYKl8AbJ3k5zEu4UcMv78Ds+AMbyiattp4HOGLAxVWIwsCyv1rclELmtSTZV7KUt8dVD9Supx4dxusFY+Fp+FysRmcWw47CdW2GcSBbnHEfsDuk2KamLiy1ba5zxeym7Zo5rWDasJc6uWTGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrfYPitn0CCm09cuqxXJQ/9fT+ii8ETw5F8/sXsPKQY=;
 b=YRr0Li9myTgWuzewLkzPmyn4CjJWHFgAxtH+JlG3j6FbR2A5STYS/lgg5+cTtJCVFOHQM18BS2w15of6uRYg7lEvxf7b/dJ3yeaQJsxuXTkJhzScvKtz9LKHqWXKBNLR/KbKuVyRoSc6dd73pUo2ootkZd65okliYiZNHnBJ6fY=
Received: from SA1PR05CA0015.namprd05.prod.outlook.com (2603:10b6:806:2d2::24)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:10:52 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2d2:cafe::c1) by SA1PR05CA0015.outlook.office365.com
 (2603:10b6:806:2d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.37 via Frontend
 Transport; Fri, 29 Mar 2024 01:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:10:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:10:50 -0500
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
Subject: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify assignment states of the groups
Date: Thu, 28 Mar 2024 20:06:50 -0500
Message-ID: <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: bce07112-2d7b-407b-c0ae-08dc4f8d1411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u4ka+AY2SdjrfUn4SMH/VPLQMFfrbCMf8FIf8nQLyaalgvYsQP11l43A/qk6Tth8nCTbZaHYrQyKKw4SUuidK46MO8NmltTHSx0aJy7Gt6fTT1S8DiUfj6uBuX0N1Eg4AlfYUXTTm0IRpPmdLRbUmbBdN9uipfigVeyN3oMH1h1bgVc5TO1Te5M2L5JqlrnvS4wUXzD+/dPsaW2e/pe7ScGLfSYNjhgAaWwCD093NsgKsgm1S8ZQHdncBChIhVog4DNUNKiGuYWNh8Dz9zcKOQvjqNDanscUm2S+g3X6jZXCn+BYl9Z/1aldcRO4lbtWtz8G+VdFWcQAyvVHz3qMjL+2oz2p+HsnnYzT2QsNGhYGzc2eWHG0ctfPCYhynFzGYxzuTf2TOy8qtuokmxbDBb5uNDJdOmUjQYlKWSj+f9VJAfVvj7bxSgQVHoChP3fu3drNelOZsqCPkR69MiRkZAxPqwY7Qh1DTWaoWEHrM2nTFkPH2XXtYLcQE4v4blkn9RMgoT62f8HkTpzzRlb6NcWIidLmY7HLZA78z+rR1EZi75QDBPhg18HRZOktmaYrkqhc1QXgwZhnLSugSWbhk8NMHMLwmuqgO01C2RVj2B+0AKCUpINTnPTqkWTL+Wx3QJn8xMe694K+JhIDNfHk4QB7Nx2XRFEaJ6bZtsBHVpibPP44BUjKruPAVN1zN1krkY9y8hmnY99CDPbHE9ZfKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:10:52.4677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce07112-2d7b-407b-c0ae-08dc4f8d1411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

Introduce rdtgroup_mbm_assign_control_write to assign mbm events.
Assignment state can be updated by writing to this interface.
Assignment states are applied on all the domains. Assignment on one
domain applied on all the domains. User can pass one valid domain and
assignment will be updated on all the available domains.

Format is similar to the list format with addition of op-code for the
assignment operation.

 * Default CTRL_MON group:
         "//<domain_id><op-code><assignment_flags>"

 * Non-default CTRL_MON group:
         "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"

 * Child MON group of default CTRL_MON group:
         "/<MON group>/<domain_id><op-code><assignment_flags>"

 * Child MON group of non-default CTRL_MON group:
         "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"

Op-code can be one of the following:

 = Update the assignment to match the flags
 + Assign a new state
 - Unassign a new state
 _ Unassign all the states

Signed-off-by: Babu Moger <babu.moger@amd.com>
---

v3: New patch.
    Addresses the feedback to provide the global assignment interface.
    https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
---
 Documentation/arch/x86/resctrl.rst     |  71 ++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 236 ++++++++++++++++++++++++-
 2 files changed, 306 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 2d96565501ab..64ec70637c66 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -328,6 +328,77 @@ with the following files:
 	 None of events are assigned on this mon group. This is a child
 	 monitor group of the non default control mon group.
 
+	Assignment state can be updated by writing to this interface.
+
+	NOTE: Assignment on one domain applied on all the domains. User can
+	pass one valid domain and assignment will be updated on all the
+	available domains.
+
+	Format is similar to the list format with addition of op-code for the
+	assignment operation.
+
+        * Default CTRL_MON group:
+                "//<domain_id><op-code><assignment_flags>"
+
+        * Non-default CTRL_MON group:
+                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
+
+        * Child MON group of default CTRL_MON group:
+                "/<MON group>/<domain_id><op-code><assignment_flags>"
+
+        * Child MON group of non-default CTRL_MON group:
+                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
+
+	Op-code can be one of the following:
+	::
+
+	 = Update the assignment to match the flags
+	 + Assign a new state
+	 - Unassign a new state
+	 _ Unassign all the states
+
+	Examples:
+	::
+
+	  Initial group status:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  //0=tl;1=tl;
+	  /child_default_mon_grp/0=tl;1=tl;
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+
+	  To update the default group to assign only total event.
+	  # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  //0=t;1=t;
+	  /child_default_mon_grp/0=tl;1=tl;
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group child_default_mon_grp to remove local event:
+	  # echo "/child_default_mon_grp/0-l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  //0=t;1=t;
+	  /child_default_mon_grp/0=t;1=t;
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
+
+	  To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
+	  remove both local and total events:
+	  # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0_" >
+			/sys/fs/resctrl/info/L3_MON/mbm_assign_control
+
+	  Assignment status after the update:
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
+	  //0=t;1=t;
+	  /child_default_mon_grp/0=t;1=t;
+	  non_default_ctrl_mon_grp//0=tl;1=tl;
+	  non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;
+
 
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9fd37b6c3b24..7f8b1386287a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -958,6 +958,30 @@ static char *mon_state_to_str(int mon_state, char *str)
 	return str;
 }
 
+static int str_to_mon_state(char *flag)
+{
+	int i, mon_state = 0;
+
+	for (i = 0; i < strlen(flag); i++) {
+		switch (*(flag + i)) {
+		case 't':
+			mon_state |= ASSIGN_TOTAL;
+			break;
+		case 'l':
+			mon_state |= ASSIGN_LOCAL;
+			break;
+		case '_':
+			mon_state = ASSIGN_NONE;
+			break;
+		default:
+			mon_state = ASSIGN_NONE;
+			break;
+		}
+	}
+
+	return mon_state;
+}
+
 static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 					    struct seq_file *s, void *v)
 {
@@ -1011,6 +1035,215 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static struct rdtgroup *resctrl_get_rdtgroup(enum rdt_group_type rtype, char *p_grp, char *c_grp)
+{
+	struct rdtgroup *rdtg, *crg;
+
+	if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
+		return &rdtgroup_default;
+	} else if (rtype == RDTCTRL_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
+			if (!strcmp(p_grp, rdtg->kn->name))
+				return rdtg;
+	} else if (rtype == RDTMON_GROUP) {
+		list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+			if (!strcmp(p_grp, rdtg->kn->name)) {
+				list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+						    mon.crdtgrp_list) {
+					if (!strcmp(c_grp, crg->kn->name))
+						return crg;
+				}
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int resctrl_process_flags(enum rdt_group_type rtype, char *p_grp, char *c_grp, char *tok)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	int op, mon_state, assign_state, unassign_state;
+	char *dom_str, *id_str, *op_str;
+	struct rdtgroup *rdt_grp;
+	struct rdt_domain *d;
+	unsigned long dom_id;
+	int ret, found = 0;
+
+	rdt_grp = resctrl_get_rdtgroup(rtype, p_grp, c_grp);
+
+	if (!rdt_grp) {
+		rdt_last_cmd_puts("Not a valid resctrl group\n");
+		return -EINVAL;
+	}
+
+next:
+	if (!tok || tok[0] == '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str = strim(strsep(&tok, ";"));
+
+	op_str = strpbrk(dom_str, "=+-_");
+
+	if (op_str) {
+		op = *op_str;
+	} else {
+		rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
+		return -EINVAL;
+	}
+
+	id_str = strsep(&dom_str, "=+-_");
+
+	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing domain id\n");
+		return -EINVAL;
+	}
+
+	/* Verify if the dom_id is valid */
+	list_for_each_entry(d, &r->domains, list) {
+		if (d->id == dom_id) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
+		return -EINVAL;
+	}
+
+	if (op != '_')
+		mon_state = str_to_mon_state(dom_str);
+
+	assign_state = 0;
+	unassign_state = 0;
+
+	switch (op) {
+	case '+':
+		assign_state = mon_state;
+		break;
+	case '-':
+		unassign_state = mon_state;
+		break;
+	case '=':
+		assign_state = mon_state;
+		unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
+		break;
+	case '_':
+		unassign_state = ASSIGN_TOTAL | ASSIGN_LOCAL;
+		break;
+	default:
+		break;
+	}
+
+	if (assign_state & ASSIGN_TOTAL)
+		ret = rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_EVENT_ID,
+					   ASSIGN_TOTAL);
+	if (ret)
+		goto out_fail;
+
+	if (assign_state & ASSIGN_LOCAL)
+		ret = rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_EVENT_ID,
+					   ASSIGN_LOCAL);
+
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_TOTAL)
+		ret = rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_EVENT_ID,
+					     ASSIGN_TOTAL);
+	if (ret)
+		goto out_fail;
+
+	if (unassign_state & ASSIGN_LOCAL)
+		ret = rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_EVENT_ID,
+					     ASSIGN_LOCAL);
+	if (ret)
+		goto out_fail;
+
+	goto next;
+
+out_fail:
+
+	return -EINVAL;
+}
+
+static ssize_t rdtgroup_mbm_assign_control_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	char *token, *cmon_grp, *mon_grp;
+	struct rdt_hw_resource *hw_res;
+	int ret;
+
+	hw_res = resctrl_to_arch_res(r);
+	if (!hw_res->abmc_enabled)
+		return -EINVAL;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+	rdt_last_cmd_clear();
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	while ((token = strsep(&buf, "\n")) != NULL) {
+		if (strstr(token, "//")) {
+			/*
+			 * The control mon group processing:
+			 * default CTRL_MON group: "//<flags>"
+			 * non-default CTRL_MON group: "<CTRL_MON group>//flags"
+			 * The CTRL_MON group will be empty string if it is a
+			 * default group.
+			 */
+			cmon_grp = strsep(&token, "//");
+
+			/*
+			 * strsep returns empty string for contiguous delimiters.
+			 * Make sure check for two consicutive delimiters and
+			 * advance the token.
+			 */
+			mon_grp = strsep(&token, "//");
+			if (*mon_grp != '\0') {
+				rdt_last_cmd_printf("Invalid CTRL_MON group format %s\n", token);
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = resctrl_process_flags(RDTCTRL_GROUP, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		} else if (strstr(token, "/")) {
+			/*
+			 * Mon group processing:
+			 * MON_GROUP inside default CTRL_MON group: "/<MON group>/<flags>"
+			 * MON_GROUP within CTRL_MON group: "<CTRL_MON group>/<MON group>/<flags>"
+			 */
+			cmon_grp = strsep(&token, "/");
+
+			/* Extract the MON_GROUP. It cannot be empty string */
+			mon_grp = strsep(&token, "/");
+			if (*mon_grp == '\0') {
+				rdt_last_cmd_printf("Invalid MON_GROUP format %s\n", token);
+				ret = -EINVAL;
+				break;
+			}
+
+			ret = resctrl_process_flags(RDTMON_GROUP, cmon_grp, mon_grp, token);
+			if (ret)
+				break;
+		}
+	}
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
@@ -2200,9 +2433,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_control",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_control_show,
+		.write		= rdtgroup_mbm_assign_control_write,
 	},
 	{
 		.name		= "mbm_assign_cntrs",
-- 
2.34.1


