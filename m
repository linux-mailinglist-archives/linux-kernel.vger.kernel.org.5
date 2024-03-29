Return-Path: <linux-kernel+bounces-123950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E689101D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B101C24CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716F2D627;
	Fri, 29 Mar 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kwMlBBUZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250412C68A;
	Fri, 29 Mar 2024 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674577; cv=fail; b=YRx6JOVnv/dWYWvSSbeEsMSK6lZLBdtEG80cQvWmHFKa7kkuX2YrVx/2/xmsgkmmtSIWexhY7PMrWqJWAjcnkUkRzF9bbi/pibtG2ERi7I3cOTnsjybpIKN4QtCrZC4ygzaO9bXMjowB0XINIVChFP/JoFn05t0VK3HdAY0wCG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674577; c=relaxed/simple;
	bh=y4QDXkHJhRGjM+YvzQ41rIavxV0mtpp94E4khHp+HI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqsDraa3j/4Hm5ljs+sawqB1X2DlII+jzqYf5eOzeGSlEYVBWTfg5I3R7OtdNEzucH447Xr1/NKnfaPrUxxwP6EK/IAhnn/l2JfNr23n3Et7+5e+WaW30ZYHmU3DzLOR5TR81EqxLkYjsNbPWRXx9NI9RTL3nU5xUkGUAz7n4b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kwMlBBUZ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIw0hnISBg2JCSI64CG/sIDXTD3F8IPShJRQYwiu3qvkR69WZSSgLhQj1E/HD1d7keiJ4cp9P1IEj2N1R/L+rH4gsRYEgROwIW/NPCu1527cpTGESLG4VfvTjgjwgZEiP79aHdXojTMnGo3roNUr0lCEP5agzMLWCcS7oCCbL1ds0iBrfVdGPERhtnAJweaFnYBmBD+lvlsh24t8P+KAyn2lD/qu7d3+vBY1i52nkFxiKoqH0uFfizfIul5Mh6CCUxVcqE/vq9h6XLK+QXQq9X6MSsVr3YDM0YNzD6FW72fMTPVS8vOveaQyGFFQYQBSXj3jjAtZv5RZHVsPVNjC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FXLEQAvAnFAHMdbLIiH1kYdncgz2SmEshExXXzbJAU=;
 b=X07L+Z0/w1BsM557GZ1ED6cEyR/c6qil6H1JNpTU2nPQ4CDXgLHdNqp0zPXZlubOTiDuk9UcuxxxmXA29U3W7KeeaP8RZgXI/VeupNz4SXJd3J5jeiid1WgHtJ4wwccwKzGZRlp2Kgl3gh574yLJti31Z1ITgs6eerVXHk3UswGlRQc3gyS/sBtaZm/lj7EIZwy5/p/L7Xr0c5oM1rOgdTJAf6B1cgG8JWg0E03vHb3um+nCqF66Wa+tpPGyME6w1OXCAXhWiUASM0MFVIcDx7qpvXgEh16uI/WcW2sxVPw11jneQ0DeTsSEuMN7pO00cNJN2b/umEi4SuqHD+DgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FXLEQAvAnFAHMdbLIiH1kYdncgz2SmEshExXXzbJAU=;
 b=kwMlBBUZQHwcYA3uQKMHmjuhZukR9ouHtYx+Wyk9Sj8C5KiawIndxWkDep4MOftxhaAk4hTBBegN5HQaPwX6BKLIKSvvHApNMXe72ADYmGLaNjpgOAPjc0zsWbjSX3t9/aINf2lu1B8+g+oG23COxLG1k3c+ROY/klPZ39gsjb4=
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by SA3PR12MB8811.namprd12.prod.outlook.com (2603:10b6:806:312::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 01:09:33 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::ca) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:09:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:09:30 -0500
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
Subject: [RFC PATCH v3 13/17] x86/resctrl: Add the functionality to unassign the RMID
Date: Thu, 28 Mar 2024 20:06:46 -0500
Message-ID: <6099db160a7dd72eb97c5e50bf347414d57263a1.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA3PR12MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ca1968-553c-4ee2-19f8-08dc4f8ce4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dnhne00c9R6h8pPq1eEzrT1dZdk9hy9f/X2TYYKkWmP5IBettujmGA75Gg8T7b5nl9TblxxlBYA4zksh+HZMiXUAG+QHqlV0WUWrOvXzYJZDdfBFoyArPTEfcO3p3PlXNl4CtjZ10DhfIqB+DiHvaYkk9H5+C7i2a3IfdBW/lPcty4NxcEkaRH1fyzfBxQEx/6akPAQotZsBqsW9GJ+uzzGF5xdRzphzbo3aa6rS3k5vACVNZ/iyVFJ9LNR5Iy4a4ZhqoYdor47Y0yzm7dTARYv/ulOWOMC6jLORLS0IFwyZ4rJYinuesK2kGC7gAhMEznM1KwImMfb5B5nDdeSxwk60DTWEjjSuRjIwKtK2E6G2SQjnPi097FSB5s7nuFTyJgFjJPjqDUPyyeEBF0Txp9CEUjCTWiKyeS8soRyL67fsoj5B5lfzoyJTADL3+MCamVCF3/qMmtwpXTNfKigaD4P1/ia+f0Ej4A4DjcaoP0w33sf7KN4w7O88a9+8JkUqVFZ08gAkc9A/cT2Aia97N6l0ss2pfYBNxFrQvDW60PnFddjk0yIyoAnfgmmUwJUVzrJrqTQTwPWcQIzu0BGuBsPzvyFFaxAKEpe7cHP6UrjwvzbzRQlAOf/aYCR/vqdTxR/Lj+HbiYCwP3fgFpjR0/yNVbTylT6VDLAyey3FuINbmX1gUL6FJQK2Cyd0A2w1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:09:33.2198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ca1968-553c-4ee2-19f8-08dc4f8ce4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8811

With the support of ABMC (Assignable Bandwidth Monitoring Counters)
feature, the user has the option to assign or unassign the RMID to
hardware counter and monitor the bandwidth for the longer duration.

Provide the functionality to unassign the counter to the group.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

---
v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 30 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 9d84c80104f9..90f0bac3ef3a 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -652,6 +652,9 @@ void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
 ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state);
+ssize_t rdtgroup_unassign_abmc(struct rdtgroup *rdtgrp, u32 evtid,
+			       int mon_state);
+void assign_cntrs_free(int counterid);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cfbdaf8b5f83..b430ffa554a9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -214,6 +214,11 @@ static int assign_cntrs_alloc(void)
 	return counterid;
 }
 
+void assign_cntrs_free(int counterid)
+{
+	assign_cntrs_free_map |= 1 << counterid;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -1934,6 +1939,31 @@ ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state)
 	return 0;
 }
 
+ssize_t rdtgroup_unassign_abmc(struct rdtgroup *rdtgrp, u32 evtid,
+			       int mon_state)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_domain *d;
+	int index;
+
+	index = mon_event_config_index_get(evtid);
+	if (index == INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", evtid);
+		return -EINVAL;
+	}
+
+	if (rdtgrp->mon.mon_state & mon_state) {
+		list_for_each_entry(d, &r->domains, list)
+			rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 0);
+
+		assign_cntrs_free(rdtgrp->mon.abmc_ctr_id[index]);
+	}
+
+	rdtgrp->mon.mon_state &= ~mon_state;
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
-- 
2.34.1


