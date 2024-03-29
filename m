Return-Path: <linux-kernel+bounces-123940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546BD891009
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E7128BF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9ED1426A;
	Fri, 29 Mar 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjQMXpWB"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B001171D;
	Fri, 29 Mar 2024 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674450; cv=fail; b=ikSBwNPpDDOSP2ijlMK7r8pn9qUt/DNpLlfEn63XklHuSjrxGf2nqOHKdmeVr6su/WVn7vOBQfWn7Lj+WSauMT5qUia6grtTST0NwtaBaxc3bA2GtZbwlacoCTKSlM/4AXCZJ7FORnMFBrdxT258RNZyqSHkq0ICiRRGFbTua/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674450; c=relaxed/simple;
	bh=4ON5cTFNWv7ZEKdfrDHRnIrO8qrMdP35eEn7gO1RuOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6OaduoGV2eLtvrqjzbcd26DShDMSxVLDQjaHj0xSGUxD/ub0heYXkuPJ8ybCFWpn5Q2kcb2nkxLTUXzz/1kT5DjzDuqopYm87LT2+bwPM0dVJe4tHio9tdeKMrNmxsCw4DJvugzVRV49gh35nMt/GJe/zbBgIIO25g3jFQa6KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjQMXpWB; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+ZN04e2NHTGop/wlRAtSkPtU9mYpQfZ3na6y9MZX+6ZqhvI6PVFte1oTXEVwsIqOCD+9eqQZ7x0f98D7QyFDWQyMuP2mHfMYTwaIjDia6WEXbk7O8nI26/seec2cQEIigbyQUYc2kAp//9xGuPN20AAeAB3WxdDw/s+KVhRKJoHyn0l90F8J+CTdlmVOKHqisayb7b8LqWWIVQpzcjXKs7HUkxiusIxqNJNsdfzYR+dOBPNlO7bgiCkJb904hLD592+a7qMbG3dQFUBx5KjjfPP1RkV4YwrQvJ0cwGKTn8QxrePqUWqJyWlTRXad0e66BiadOaN3sSOyEarJo1FCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wadMJD+pmw/IkeV+n73MjBwEz/qsM4NIngtFC4PBRZM=;
 b=NVg8Q/vkhUotX989cGrCWCqog1KTET7jNkx8WKw4oLfelO1FQ1bwZrRxRzk5vifzxoTNFV7flJmWldJjzOFbuAQsFISWGEmdXB+c9OqeLjzekVLixfmUNmT/mTmRXqRdOS1JshAln47SaSpNlSaqkEJnhN/URPvTAeqHok07KNBEaozvEgpT3NYXSr+cmcEEeEFN2LQu6JnVENaQXPkxETLBJGMw6XWBlNfsiIx4fUETKmHQJp0sbkzFavu8iZ8irzFrOJ7ZTaMpCFYxBWZp4lddUbB5yi+sjvHVT+MZjDYFDB73AQI1PJkV5RATTddjuFrYNS7zj0Mc/NGH5QhGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wadMJD+pmw/IkeV+n73MjBwEz/qsM4NIngtFC4PBRZM=;
 b=yjQMXpWBj33naWrPx8/wRQw/mb19wwW70N0i5zfVauK+0QyB1uY+vOSqoIHTanxz5G5fqgzZltXhkEcwd0JU8RJGapeg4TlHHh9IcoQx5rxuMohq5FGOXBrh4lJDL7soJSyg/enj00xsZMQxo7/WfKhu9LamLSe0VNVuZBqL780=
Received: from PH2PEPF0000385A.namprd17.prod.outlook.com (2603:10b6:518:1::7c)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:07:25 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2a01:111:f403:f90c::) by PH2PEPF0000385A.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:23 -0500
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
Subject: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Thu, 28 Mar 2024 20:06:36 -0500
Message-ID: <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: a6360095-af0d-43af-63ec-08dc4f8c987d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CFvLcUpvuTKDMRwrGIKG5GWfkGYSDI20ho8GvxJmOfZX4fXQjSNOxvNIxuaRrFDTMSXwipMNZvDI9rJuLmB0tbCPb6mQLEjkdU+ZNSb763hjYAKNXBXkd0AumoAMhEroV9o+Ke1WZ+iM1ZfTr7MjrvaEiJHhMhm874vFzNPp+6oHQ3KYjlvhPJDdV6fUwAwqbuBQtaFSJAV609YGYKux07oh4YwMk7iZj/UK3jYzUkr7UKT1MvJoOXO3Y6NCdfsqKXJzHKFGAh+FCgWS6I2+tw/6aJI9DFFgSSFmnkYBJrE+NsY42cy/gdKLzZCnrD9lSrvfVIb3/vLH7PlgeHanCotJQ79HTroHjdCrtbVZkDJPNscTRWpAZvHsnlrJVKY8PBp/m8PWeyvrio0okqvioLfcvbQm6BrcOETyRGOgKPTll1rZ9bfhsWIxGcVzYF5Z3Gp910ao6kk7PDP16kub8CtEw3uKmUYhV+a0icIzhbCz+DP4UMKD4zwQ0biNr+majzQ1AYH/EWd5h0UFD5jHtCkkhu0hnUSYiBIFIMvTGBMsfE7/GoTcNPYWQ2t4orKKzytTEDnRD6UUpTleAOmKP912kMedbEwiBNSISEsXft6Qgf7kfwO1TFPrnwdNLTMIERqy6AN3fU2+kYX5K1Hn6UDd2HyBZrONg4E768cr2OZXJI5A2nVJ1W8GzFpxhUEJFylsnwb+zAe64Tm6TM7yJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:25.1512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6360095-af0d-43af-63ec-08dc4f8c987d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
---
v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 17 +++++++++++++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  |  3 +++
 include/linux/resctrl.h                | 12 ++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 57a8c6f30dd6..bb82b392cf5d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -740,6 +740,23 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
+inline bool __init resctrl_arch_has_abmc(struct rdt_resource *r)
+{
+	bool ret = rdt_cpu_has(X86_FEATURE_ABMC);
+	u32 eax, ebx, ecx, edx;
+
+	if (ret) {
+		/*
+		 * Query CPUID_Fn80000020_EBX_x05 for number of
+		 * ABMC counters
+		 */
+		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+		r->mbm_assign_cntrs = (ebx & 0xFFFF) + 1;
+	}
+
+	return ret;
+}
+
 static __init bool get_mem_config(void)
 {
 	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_MBA];
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26ebe7a6..c4ae6f3993aa 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -584,6 +584,7 @@ void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void __exit rdt_put_mon_l3_config(void);
 bool __init rdt_cpu_has(int flag);
+bool __init resctrl_arch_has_abmc(struct rdt_resource *r);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35ec0f03..e5938bf53d5a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1055,6 +1055,9 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (resctrl_arch_has_abmc(r))
+			r->mbm_assign_capable = ABMC_ASSIGN;
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a365f67131ec..a1ee9afabff3 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -150,6 +150,14 @@ struct resctrl_membw {
 struct rdt_parse_data;
 struct resctrl_schema;
 
+/**
+ * enum mbm_assign_type - The type of assignable monitoring.
+ * @ABMC_ASSIGN: Assignable Bandwidth Monitoring Counters.
+ */
+enum mbm_assign_type {
+	ABMC_ASSIGN	= 0x01,
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
@@ -168,6 +176,8 @@ struct resctrl_schema;
  * @evt_list:		List of monitoring events
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @mbm_assign_capable:	Does system capable of supporting monitor assignment?
+ * @mbm_assign_cntrs:	Maximum number of assignable counters
  */
 struct rdt_resource {
 	int			rid;
@@ -188,6 +198,8 @@ struct rdt_resource {
 	struct list_head	evt_list;
 	unsigned long		fflags;
 	bool			cdp_capable;
+	bool			mbm_assign_capable;
+	u32                     mbm_assign_cntrs;
 };
 
 /**
-- 
2.34.1


