Return-Path: <linux-kernel+bounces-123948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B718891019
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F371F25296
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD71755B;
	Fri, 29 Mar 2024 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CEhoM5Mv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01D11712;
	Fri, 29 Mar 2024 01:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674534; cv=fail; b=oPNqdikW3C+4Dgp6Kr5g8JBfv6PhGQX1QvVi8P6/0vqmK2WR9m8z3Oc8y4GAs4COt3RPvck3laXt+p7ePygDopQc2M8xul3FAT/1A9iigWGvIlQB4e0/ZugZgSLBHtWhPeV35kbQM/Sf1O1UpvAIEnAUiSBUwocli/wBvRxPaps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674534; c=relaxed/simple;
	bh=ubP0nTDrPzrHJHEhpYf1hfdVM6r5YYhTeiSgdn5jAO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mT5fkVNXwoLORQoCoJxpfOASB1h5Q73M/73vLAbbD/zMCrltVA9Q4xcHat8LZJcP/HT8J4J69WZR2TQ6814geqKkxM3KLX2QBNYEG5vO/e3vDzNVRZRWLyWvSQKCQGsjOpg9cezELbeIwnEvZyn3RcWx0YbY98YGDTk1MgWVRLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CEhoM5Mv; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDR3NofOy0JSEJgx4/YuNcSHjOZ9u6HvlRRW1gCrE4PyC6w5GwPyspERyB4SvSwj5w3TZrWg1ZCJ1hk7+IN+sRzRUj3YqSPOdoGa34w3PuAGbdduUewHn0ULrbkdjSq9CVBd9HDudTB52vJKFpwvx1DrSWdt9Qkvil22mwu0CpF3ANWZnmK0S/ywkl8ZX19c+isJEzjIS4nJjAgSZIbwEezY4v6Od4GdK98FrjbV4+qdGDJZh8JmrPyILIDhe0IBlcvBwpAWC80APR97FMOmFAJkgBWRVvtsfWLQJMxm1598Kk/bCHTS4+/6fMi5lgsoNLdEuDs8yCHeg9VBUmuB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMUE7WKNB25IcAVkCab36p61eA0n41xcYWqv09iYdjY=;
 b=XjnYOHQa2CoNXrY6VuBGU6RqrX0vIR8WR3aHFzqP+r9nDqkHlzKhyvQHo8p0qgQ/wLPJKapy/XVFzNGhw8b0I4zoTUbobOaNlmhPXJPXji8g5esnar8IGTcMTLwa87YOTQ0f+Hlgy06BaKB1XlhhFKxJPWQt47zdYHrY7HPmAY6Va57LAHjQ90zkNwQudT5K2tBn532jGBiXOPqya2rUocHDt7zLGTbbtGuCOd6M3vIxKk8EDUutYdGNqkr73KB0pLQIOVrZel0HGHJa53qAHJfWIVP1PMdwBoeQJF/ODL4cPBYZ54MBWJ98BuKWnpxSL1WLuatjkkogRFQwT7wUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMUE7WKNB25IcAVkCab36p61eA0n41xcYWqv09iYdjY=;
 b=CEhoM5MvMhtDNT1ybSayOarEqHy438ly9SEHDq61gdx5SsHEfhNZzAKOp6D9enKJ7Wp+Hq7y+Q0fchIjyyR+CEl7DxmXwM8Ifyy5aZN2sDGHCTUqG37+t7EUSJf45oT8WBQrGuCWwvb/1kfpham+e/lJstbImVkXeaKN1xuWuLU=
Received: from SA1PR04CA0015.namprd04.prod.outlook.com (2603:10b6:806:2ce::11)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:08:49 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::b1) by SA1PR04CA0015.outlook.office365.com
 (2603:10b6:806:2ce::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:08:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:08:47 -0500
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
Subject: [RFC PATCH v3 11/17] x86/resctrl: Introduce mbm_total_cfg and mbm_local_cfg
Date: Thu, 28 Mar 2024 20:06:44 -0500
Message-ID: <46f83accddba3c25a428d1a30f6091913a4f7c73.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6efb6c-c78b-4228-9c33-08dc4f8ccaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	soaBef+t1Ioneu7/PvNFmJsgTgLmemdyPHn3a6zreJkviSnj9ip+wXOzRoO3qx0YdqRETLIbw/C2y9Lbw6YCMJrhfDlQv4vUEmiunEUvajDp/XMEPtDj33V+tlbyBf9zu3xvaY84imIkkuEMUfhuaVMiCLB2ww9wGbRz/HUZ7b9ce8UjzC/jD+vUv9siwekmaU6k10Gb6r5nzhjE95IGcK5/qfUVIC5BikIZ3N5qfQujbIAFGKNPsdjv9TrwMjbpl9CPL8Uy+bg5MW2cXkX+EIOnAgYIDIks/pnI5VcIDmFM3RaGQBT0zt3ZsQEUa67P10HWCvamJmXS8NT+zsaZ542GKGum8BkJQTIIzi760xB1xpXN+JbjMXg8UPvg4xqPCIMoQiVY4MgJvXc0Qs9iqTfReZtsRALEDe/a1reTkrTWgjZYa/zv0coEv7kk5qzlRF4ZtrJ3bw3PvE265dha+diiOLCJwjfR4BUIMxmP83kH1q3KCTExByv9VnEf6/nno3v3YawLpDxmbfpuANCoB4PiOJmGdD6VDP0DhYPwHDYxeHZnRTSzl9vdJlqQHLrPAVD2Sq4mRXn8m9fqh9UwiRVBgH91Dm3Offq0QzMf5RyDs8dlk45wZmKXlYlC30x1paZsiAg3BIVO0VhOz3g5R0RlCdYb5OC9Zu2ZHJf98XrcrAVWnCN1mHG9D9F0heSwLVC0x+k58hcFfRaYwRyQUC5Pg52vlRBLf6VHA1vgviWmPmjbGvxI3F5ljG6NBjz4
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:08:49.5434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6efb6c-c78b-4228-9c33-08dc4f8ccaca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

If the BMEC (Bandwidth Monitoring Event Configuration) feature is
supported, the bandwidth events can be configured to track specific events.
The event configuration is domain specific. ABMC (Assignable Bandwidth
Monitoring Counters) feature needs event configuration information to
assign RMID to the hardware counter. Currently, this information is not
available.

Save the event configuration information in the rdt_hw_domain, so it can
be used while for RMID assignment.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v3: Minor changes related to rebase in mbm_config_write_domain.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 11 +++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 50e9ec5e547b..ed4f6d49d737 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -555,6 +555,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 		return;
 	}
 
+	arch_domain_mbm_evt_config(hw_dom);
+
 	list_add_tail_rcu(&d->list, add_pos);
 
 	err = resctrl_online_domain(r, d);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 41b06d46ea74..88453c86474b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -385,6 +385,8 @@ struct rdt_hw_domain {
 	u32				*ctrl_val;
 	struct arch_mbm_state		*arch_mbm_total;
 	struct arch_mbm_state		*arch_mbm_local;
+	u32				mbm_total_cfg;
+	u32                             mbm_local_cfg;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -648,6 +650,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 56dc49021540..8677dbf6de43 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1090,3 +1090,14 @@ void __init intel_rdt_mbm_apply_quirk(void)
 	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
 	mbm_cf = mbm_cf_table[cf_index].cf;
 }
+
+void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
+{
+	if (mbm_total_event.configurable)
+		hw_dom->mbm_total_cfg = MAX_EVT_CONFIG_BITS;
+
+	if (mbm_local_event.configurable)
+		hw_dom->mbm_local_cfg = READS_TO_LOCAL_MEM |
+					NON_TEMP_WRITE_TO_LOCAL_MEM |
+					READS_TO_LOCAL_S_MEM;
+}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 54ae2e6bf612..7f54788a58de 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1703,6 +1703,7 @@ static void mon_event_config_write(void *info)
 static void mbm_config_write_domain(struct rdt_resource *r,
 				    struct rdt_domain *d, u32 evtid, u32 val)
 {
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct mon_config_info mon_info = {0};
 
 	/*
@@ -1712,7 +1713,7 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	mon_info.evtid = evtid;
 	mondata_config_read(d, &mon_info);
 	if (mon_info.mon_config == val)
-		return;
+		goto out;
 
 	mon_info.mon_config = val;
 
@@ -1725,6 +1726,16 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	smp_call_function_any(&d->cpu_mask, mon_event_config_write,
 			      &mon_info, 1);
 
+	/*
+	 * Update event config value in the domain when user changes it.
+	 */
+	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
+		hw_dom->mbm_total_cfg = val;
+	else if (evtid == QOS_L3_MBM_LOCAL_EVENT_ID)
+		hw_dom->mbm_local_cfg = val;
+	else
+		goto out;
+
 	/*
 	 * When an Event Configuration is changed, the bandwidth counters
 	 * for all RMIDs and Events will be cleared by the hardware. The
@@ -1735,6 +1746,9 @@ static void mbm_config_write_domain(struct rdt_resource *r,
 	 * mbm_local and mbm_total counts for all the RMIDs.
 	 */
 	resctrl_arch_reset_rmid_all(r, d);
+
+out:
+	return;
 }
 
 static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
-- 
2.34.1


