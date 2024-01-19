Return-Path: <linux-kernel+bounces-31486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE9832EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE191F24C24
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06545C601;
	Fri, 19 Jan 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1hD72a/"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA75C5EE;
	Fri, 19 Jan 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688675; cv=fail; b=hOtKu7CC35xRFGkbflQmTgOheChC4+Q2zUUNslEmNDotu7totVhdSRW6H862eWlrbxWXFgZ+0i+4U8P9a/1nYoL0Ul4ppkTMVrd0Dgh/O+JnpK7/Bay7ATVpeKFmVDHI9//+TLF7gQcHRbeAZL5Y4UCHPUF5T8voAswAJ/KRyGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688675; c=relaxed/simple;
	bh=O2//EvY3v0OrrEnBdG7H1iOgiJ0olIw+lS+HmiDoEAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExH3tuYcH1i/7miKuSejACp9u1n/5BMQWuWllHyKngmcDgjJqay6W4joSBe+QKqaiBsJlnvrnEHYmetHd5qu/YIpqjU5qNjGkavpPOEKUKHa7d2BdYm2EuljbEoZ2ZY2qkRs12bmP51AMs5Ah0sSrHeIrXxaVl3ZSbbFqiUzyPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1hD72a/; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsPWnlj1MBaNVagfVAg9/7TEkoqf4oUe5wiM2W5ZQND8Jn5eDmzMzBEcTuNeYffQ4s0XuLypMn6dZkcieauL9rHA/iIo+ai4qPITi2xrpLlRnpIJGe400CjQekTP5cYg3vRUZ8WGrEcNVMAXj7ztBM/DzKTlfWEmlHOJ+O6sD8hdYplFpKQCS+zayLHTiJBGYxSnRiuLifXL8d7H7U4Zrgb9iTHzs7nkAwGHAjlUkPrTATXhE91kN++yNKKP9lG8hHBYTpw05Jshx0i3SDUgm3/O05FgIV05RqpB0rl8Am3gzM1cnHV6uwVOC7hcMhcJ0pegZoK4UrNJp22tJGIyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy3GjzK359pitjD1GeqKXz2emhIuuX3+oD/ZUDEaCks=;
 b=Q01sxAp48s0GHrPyuhZerYTTfwfqaeJk9A+pCF2eP1BiKMJp35ELEXmNww2cHdqc7OC1qTXokMdd6PwEAPEZnEPr3c2a0rUCW+TWBwpAkS++cUyPBfHbH3t5NhnucxFzCbDL7ZH9mQvhcYZcV/WfAYfEU+Ji7x6B7kmWgooFIaknKS+N1Lv2hZN/pa5WZ9seFg6HharGbeN5EfSbzfel+/F/dHcFYaV56rGOoi5bQQDiwdVyDUI+T+ctlxhgMnWSzXRLU6Vg5fJfvZXmMJ/22vXqn6dk7bvylJAmWp8QozaWofZfH7xbO5n43F5lUymfjJ7WvqxsBD5LRIuhcOT7tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy3GjzK359pitjD1GeqKXz2emhIuuX3+oD/ZUDEaCks=;
 b=s1hD72a/kd0S8v4FzFA4ij0/MaL+2mKCeXDDbB9umqLcPhTub8j/tJhcGcn3IIoPh+IxZXNhx1BA80vfuuYCDPwh77DUduzXQeCVqehx00Wcqxyryh17wPHWCH6ag6ZRhLUuuRFvE7CnJYcNXRcEig+90u2mh7YsFRxMwfQprzE=
Received: from BYAPR04CA0033.namprd04.prod.outlook.com (2603:10b6:a03:40::46)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:24:30 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::1f) by BYAPR04CA0033.outlook.office365.com
 (2603:10b6:a03:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:24:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:24:27 -0600
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
Subject: [PATCH v2 16/17] x86/resctrl: Add the interface unassign the RMID
Date: Fri, 19 Jan 2024 12:22:18 -0600
Message-ID: <1014d6620a263cf4b606ed453a3ba48b581d2fee.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4659b8d1-7829-4802-1701-08dc191be015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8pW9G2uwKqR2IET9px/iuBivbQufzoY5xoY/fBZtGB9HZBTb4QV9sNsDfNWTd8whpiZO2X8jHdGkBb6eMFtwIacz03xDRE2s7D9z/LmQ6MEeDzQdyAHTIE13w0HFgJpPR7JhHwwmLS6IQsORjbCHbTzDPgt2ZkaeO3GVgk8fowbDfNAO5Yrj2RQ1cBBkmrvikBIjntimnHnvgHUqHN1JkjaKbWvEV8xs2rTs0fnEzJYwovKujKuuLi9uXYFIEeg4ltpFMTFRWMUobZRkXk21w013wBa4cHDTIAXLeBN46YpxDGOwL2KkjDIqiaVauwjKiLDqIf+rnqOQunJ8ERinLUSFssoVFyn9T9M5QgdNKOu5NJpglukHYk7goxIQGYnvU2Y/KchIWp+gvQMoivjh5tmfFrjH8IKgmyiV8GakbEjlEeoLtEnoGgSOVyGtkAa/Zd2K4y8PHHfeIqeUVl9UDG6Bo/7xLcPFdAjc+XSKPaLb+GRLD74QpIFvnag8MM9GkIJtASyxVKlpgx0woXMKpkKe75iOvr+ULjiav69rvlbL/MDpzluSsb9yQwCSMvWgC6FA/1pnp3SCVGzzCRXf8/m82BlgYfxvg1rqz1FHSnEItzxa6wwYUdKIzFY9WljA+pVpGrrF7U7F7SAA6eGpfhxFL9KnlFiH8RmgXhzZkfJc0JgREfJzDXJMMW4Iu//Mt+J53u8Xc5dXpuQCSsQYIWpAQ20Ow8QhebbvaAUi1z0p3nRYvom9NJ1Rsc0YDLSAgyzbRP/ANci0rRfiukT6Kw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(8676002)(8936002)(2616005)(4326008)(5660300002)(16526019)(426003)(7696005)(70206006)(316002)(6666004)(54906003)(110136005)(478600001)(70586007)(336012)(44832011)(26005)(2906002)(7416002)(81166007)(356005)(7406005)(82740400003)(86362001)(41300700001)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:24:29.1557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4659b8d1-7829-4802-1701-08dc191be015
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

With the support of ABMC (Assignable Bandwidth Monitoring Counters)
feature, the user has the option to assign or unassign a RMID to
hardware counter and monitor the bandwidth for the longer duration.

Provide the interface to unassign the RMID.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: No changes.
---
 Documentation/arch/x86/resctrl.rst     | 11 ++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 36 ++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 2729c6fe6127..4ba9b1275a2b 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -427,6 +427,17 @@ When monitoring is enabled all MON groups will also contain:
 		# echo total=assign > /sys/fs/resctrl/monitor_state
 		# echo total=assign;local=assign > /sys/fs/resctrl/monitor_state
 
+	The user needs to unassign counter to release it.
+	Example::
+
+		# echo total=unassign > /sys/fs/resctrl/monitor_state
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=assign
+
+		# echo total=unassign;local=unassign > /sys/fs/resctrl/monitor_state
+		# cat /sys/fs/resctrl/monitor_state
+		total=unassign;local=unassign
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index e109c0388762..ca3193986b4f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -614,5 +614,6 @@ void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
 void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
+void assignable_counters_free(int counterid);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 3447fc4ff2e9..869fab878087 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -192,6 +192,11 @@ static int assignable_counters_alloc(void)
 	return counterid;
 }
 
+void assignable_counters_free(int counterid)
+{
+	assignable_counter_free_map |= 1 << counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1723,6 +1728,31 @@ static ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp,
 	return 0;
 }
 
+static ssize_t rdtgroup_unassign_abmc(struct rdtgroup *rdtgrp,
+				      struct rdt_resource *r,
+				      u32 evtid, int mon_state)
+{
+	struct rdt_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	if (rdtgrp->mon.monitor_state & mon_state) {
+		list_for_each_entry(d, &r->domains, list)
+			rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 0);
+
+		assignable_counters_free(rdtgrp->mon.abmc_ctr_id[index]);
+	}
+
+	rdtgrp->mon.monitor_state &= ~mon_state;
+
+	return 0;
+}
+
 /**
  * rdtgroup_monitor_state_write - Interface to assign/unassign an RMID.
  *
@@ -1776,6 +1806,12 @@ static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
 					rdt_last_cmd_puts("ABMC assign failed\n");
 					break;
 				}
+			} else if (!strcmp(abmc_str, "unassign")) {
+				ret = rdtgroup_unassign_abmc(rdtgrp, r, evtid, mon_state);
+				if (ret) {
+					rdt_last_cmd_puts("ABMC unassign failed\n");
+					break;
+				}
 			} else {
 				rdt_last_cmd_puts("Invalid ABMC event\n");
 				ret = -EINVAL;
-- 
2.34.1


