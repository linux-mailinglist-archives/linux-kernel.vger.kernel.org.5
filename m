Return-Path: <linux-kernel+bounces-31485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C2C832EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F5F1F25053
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32555C5ED;
	Fri, 19 Jan 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G23n8kBo"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656235C5E3;
	Fri, 19 Jan 2024 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688671; cv=fail; b=ezSBj5a1cXIES97avCUwpfWzurKvTSs5hzS/8LFfAQTxJQTwCM4TUCm8sQmmN6lzFNXXBP8/1eId7p9qVk62gPSDyup+bZU7QJ31N80nvcbnhfJTDMaxe91/i12zz1aFiv8UZ02rpBpAA8bX3+/yE2rRRYQdTMwGgBH8uW9UA1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688671; c=relaxed/simple;
	bh=KpVeBeN0j1m6iDs5hPAdUlS5aiE+dRVb3lOEBiI/COw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JM1+MMsfwZIHuFrV/f6b8jyTE+rpLsY1ZN7sfo05N/jDnrePJIj9x6v8dnb95P0ztnXMbW5zR6EnBSUKBmAFonvqcucAewHmM1FIyQ8pP/QoQcszGBaw59nzxxhaKfO3q92w0rIp5lB0caOiaIRZqsTg63WnXdbwCk9iJ1a1MBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G23n8kBo; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI61uP7JNngb5s+NyU2o+Euo8w3DMXY0loksEaNoPC5saTrzIh0w7i4qz/hNgJkvqkLSWv/lL8dTo46zRw+iK/JvAHO2Q3/wHZSnzkAYe1Zg5S2p5RHY1AdED5wBcsyIbVQmkugmJbHJD1khNh0htfamDLM0u4pHVfGMPTC+9rtALL061HtKLIVcY4MkDtfp0PTWg2gbGeVdf5KIJySyJiH9eyR10ellE+KErLPh3kK4wGhx4uahlrl39/abILfx0zOOyfy0CWN5FqIhKgMyt0EwBuQouhgmn12LN43r5dyZiXRBBumvCSGqRn3+jwMHK7I26MMFwpWOg409KHRGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g663v5rSEdwDDqkt0k9uLH2rJH4RPpH1sdZqQ4LTkC8=;
 b=gkp2qcCVVu+OFayFhTF/9TWsj7/V/vyCDHuQ/q9euDVYxYs1jFnBTaQku0LsBNr8EhL2De7UY0/OmHY82PqfZcju3qDBvNFGjiWXbZwDHBy/H/FOKebmQzd9h6VMKPA11iKAJG9JYQeKoowo0Lgqe//NiY9scCvLPkXhmcsvkY+cAAcxei5AGxBi6PviklV+62L9b2Khw9YdR2kJ84L4G84noaXf+dCxcot7tMaOcGLuEphYtEEOPdyvuSOmAsjFg2ebQg5R0s1/oEMb52jEnrY7Wp8tcIprgYaNORDzjmPNZThLtA5Y6l4r8rf63XVqfLletzFbDJl6NcpJu5aPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g663v5rSEdwDDqkt0k9uLH2rJH4RPpH1sdZqQ4LTkC8=;
 b=G23n8kBoZcHOvlsRtt1EekHKjQkIlLU8D/JzMJkAcJs+6SZ7WJ+zV5DD9H46j68cx/FVG5vKWRoxUAXuVRYB7nz3MeUa7XbtEXDwueT0hxANF4hrMWwMAiPJRC/1Cxbu1bFXBTjewbHcPXNb6XZL6lnhjzjTUkG5HPx0fe0KAyA=
Received: from SJ0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:a03:39c::18)
 by DM4PR12MB9069.namprd12.prod.outlook.com (2603:10b6:8:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:24:25 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::11) by SJ0PR03CA0343.outlook.office365.com
 (2603:10b6:a03:39c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:24:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:24:19 -0600
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
Subject: [PATCH v2 15/17] x86/resctrl: Add the interface to assign the RMID
Date: Fri, 19 Jan 2024 12:22:17 -0600
Message-ID: <1f6b7f11ace54add1d907b539a473ba9c274364f.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DM4PR12MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: acf74f6c-f524-4d53-348a-08dc191bdd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xZYRi8AXzIEBxRpFEIZwX70CzC/yI8ClkTxjcZwo6Zl8G8NEQlvDnPSibysiCnQMx+evJ+LIwOyaz4a032Qsexuruw5mSITS3ldFfnvtdp4dHSuQPkEJ8HVA6yCYG/vrgLtKO7ToKQs3WNSAbt9XeHseDEvXT3ugIv7w1UyjhnzSyVho/cj1THTfr+nbNJm5oTo2+s+PBWebKNyf4LevdqaiVdYeFGqJHQ3suhQjE5ikzgTKoHOVgtb7kEAp8UIM/So02Jx6sGq4PnOcItQgBfQLbX10H4hz6/qFbkSApncqMCGnyeeisAyoIdUSVe21UL+GBWXeBf7tuTPO/m8T0Gs1vvRjggb7elWzsi2bWcBl5Xp8UbXKibYheWM9EtzkbSLtEx+0WUTsOTFgss6stbLM3XFBO4LdLIHkWGJ0MNb+x9ZvjXAP08Iw8mJ+R9LYHV8iz40zBJfvjO+MqfkJwskqNifuVZqgKnmcVaRtl1g5tDKz1acDzqW0+FlQYzzRp3wF5WViwiE21Pxhr/n/oiavYuuPetW70JQlWeF4P0EhSj5ohoOwsvWXqCZaHJ5ql2fBMddX2To6tdYGYJ37RSwafccFOm+iGN+CV6BKHon0MCH+E4K3nYPkfFQPa2CbK5Ll7wZs1kzAw4cswvWg9/xNu+UauxTdeLzRQDeVfYv8WA2ZzLJizun+Y5/PLdkE2jRmpVPmTEQ9CL83oBDO6jG4dqu6hPQYrTvc003r132kpTwIo+Wg5f5CP2xUbmj7XWAJPZiU4dJUcCSpHKLNrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(966005)(41300700001)(478600001)(36860700001)(40460700003)(40480700001)(81166007)(82740400003)(356005)(47076005)(426003)(16526019)(26005)(7696005)(316002)(54906003)(44832011)(7416002)(7406005)(2906002)(86362001)(8676002)(4326008)(8936002)(36756003)(336012)(70586007)(70206006)(110136005)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:24:22.9001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf74f6c-f524-4d53-348a-08dc191bdd82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9069

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
v2: Minor text changes in commit message.
---
 Documentation/arch/x86/resctrl.rst     |   7 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 160 ++++++++++++++++++++++++-
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 4f89d5d1b61f..2729c6fe6127 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -420,6 +420,13 @@ When monitoring is enabled all MON groups will also contain:
 		# cat /sys/fs/resctrl/monitor_state
 		total=assign;local=assign
 
+	The user needs to pin (or assign) RMID to read the MBM event in
+	ABMC mode. Each event can be assigned or unassigned separately.
+	Example::
+
+		# echo total=assign > /sys/fs/resctrl/monitor_state
+		# echo total=assign;local=assign > /sys/fs/resctrl/monitor_state
+
 "mon_hw_id":
 	Available only with debug option. The identifier used by hardware
 	for the monitor group. On x86 this is the RMID.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index df8d2390fc69..3447fc4ff2e9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -180,6 +180,18 @@ static void assignable_counters_init(void)
 	assignable_counter_free_map_len = hw_res->mbm_assignable_counters;
 }
 
+static int assignable_counters_alloc(void)
+{
+	u32 counterid = ffs(assignable_counter_free_map);
+
+	if (counterid == 0)
+		return -ENOSPC;
+	counterid--;
+	assignable_counter_free_map &= ~(1 << counterid);
+
+	return counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1635,6 +1647,151 @@ static inline unsigned int mon_event_config_index_get(u32 evtid)
 	}
 }
 
+static void rdtgroup_abmc_msrwrite(void *info)
+{
+	u64 *msrval = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
+}
+
+static void rdtgroup_abmc_domain(struct rdt_domain *d,
+				 struct rdtgroup *rdtgrp,
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
+static ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp,
+				    struct rdt_resource *r,
+				    u32 evtid, int mon_state)
+{
+	int counterid = 0, index;
+	struct rdt_domain *d;
+
+	if (rdtgrp->mon.monitor_state & mon_state) {
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
+	counterid = assignable_counters_alloc();
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
+	rdtgrp->mon.monitor_state |= mon_state;
+
+	return 0;
+}
+
+/**
+ * rdtgroup_monitor_state_write - Interface to assign/unassign an RMID.
+ *
+ * Return: 0 for success
+ */
+static ssize_t rdtgroup_monitor_state_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	char *abmc_str, *event_str;
+	struct rdtgroup *rdtgrp;
+	int ret = 0, mon_state;
+	u32 evtid;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -EINVAL;
+	}
+
+	if (!hw_res->abmc_enabled) {
+		rdt_last_cmd_puts("ABMC is not enabled\n");
+		rdtgroup_kn_unlock(of->kn);
+		return -EINVAL;
+	}
+
+	rdt_last_cmd_clear();
+
+	while (buf && buf[0] != '\0') {
+		/* Start processing the strings for each domain */
+		abmc_str = strim(strsep(&buf, ";"));
+		event_str = strsep(&abmc_str, "=");
+
+		if (event_str && abmc_str) {
+			if (!strcmp(event_str, "total")) {
+				mon_state = TOTAL_ASSIGN;
+				evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
+			} else if (!strcmp(event_str, "local")) {
+				mon_state = LOCAL_ASSIGN;
+				evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+			} else {
+				rdt_last_cmd_puts("Invalid ABMC event\n");
+				ret = -EINVAL;
+				break;
+			}
+
+			if (!strcmp(abmc_str, "assign")) {
+				ret = rdtgroup_assign_abmc(rdtgrp, r, evtid, mon_state);
+				if (ret) {
+					rdt_last_cmd_puts("ABMC assign failed\n");
+					break;
+				}
+			} else {
+				rdt_last_cmd_puts("Invalid ABMC event\n");
+				ret = -EINVAL;
+				break;
+			}
+		} else {
+			rdt_last_cmd_puts("Invalid ABMC input\n");
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
 static void mon_event_config_read(void *info)
 {
 	struct mon_config_info *mon_info = info;
@@ -2003,9 +2160,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "monitor_state",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_monitor_state_show,
+		.write		= rdtgroup_monitor_state_write,
 	},
 	{
 		.name		= "tasks",
-- 
2.34.1


