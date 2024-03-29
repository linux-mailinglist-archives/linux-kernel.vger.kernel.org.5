Return-Path: <linux-kernel+bounces-123947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D65891017
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF091C23FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB92030A;
	Fri, 29 Mar 2024 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xqvIfUwL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD51CFB6;
	Fri, 29 Mar 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674526; cv=fail; b=VbEn1xYJaVa8Ja2ytGCAMuBfy4eBs78rvz4S+eXP4+vehhLWN9B6URsHzo4YXWaT5JXBHZYq3ZbTYtGGtmXaYkvitwFZ+sSe2kuLf6UHKhOzDwXfGGzn1uMHOsxdQ8a2ANUqSBthReoXMFu2FG+KynyWtCjQ6FQFxqM891zF3Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674526; c=relaxed/simple;
	bh=r/5rjSZuCzCAO8cxdWccWOAHDeEiJkg6jHhIs01gKEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAfMNG3qVCZTd6UF1Tm3W7wfHESWZdRBtO8k6hHWO+WzFqfRY6uT5b9Ue5JEr+Sx8mQtOrD/et1L1Fk3sRBfoAvICg+7u1a0kwiSAAnrCx+3MQ7vVH+mZzOfiVtghOMqxqPt9heXufUhRHvOrM2PshheVPuY8yaeTkOllhSXVxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xqvIfUwL; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaRItgFQc0PqvqQubB0/Q5R0KyqhBf2Zsu01FNqxKHrDbIhJYdXrnQQymbf+QbsHwAZ6AI1cWQcsih6F+YWxaDFT36OgMd6PY9TkwEZH2YyLUoGcEnoYFUUDKUfrkKrAbLXXWRM+fRYzE8kYvOeJthY4/tLrvn5cD9xeFbxueCpmxXQyRtdJ29ChVpYZrri8CC4MxooYf2ZdHqDLPt1UBNKGPIS+y3MIJg2qumDCYR7ZmfwMao7zDhk2ikK1fFFH7p90+Hi7svcsYpRa/TD1l3zhMjI6xZ6KgzMfl5D6oU8l/wCwS5WNNhe1+refqOxmKz4iPra7V5MR/mDMpW9pXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HedFJVVqnbUCjKdSohmg8x0ZB+9/aVwwEqQjp1bQ9PU=;
 b=jnGmp8VC1XhoBKJXQXMi442Z3S5QnSzTYSa66yEGzPqBBOER2V5Pev1QPD6YdQ/BMsTxxkIX5hhg37w17ar7coNuYGt4+tvutbyJSzWS8BFKBHH668lSiWaaXNj6E5b4seOMj5ASXzxa6KxFSOxHZaumUII6x8ys7FAyOuVfmddFPP4cfqH4TMzJWjotNESLesjCn/+QwBfmCSw3Oo6Dq9KpaztzdJtkywJQ8Mv/h1dqwBIcAQ2t9Lao8pHKBOEgWcOl8qw1cfEfKwjWWU1UCqiTblh9EjFdMBOhuQtQiYL48GPuanyurXOhh6wsCo22WCL0tY2lZTYL2iwf+xdNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HedFJVVqnbUCjKdSohmg8x0ZB+9/aVwwEqQjp1bQ9PU=;
 b=xqvIfUwL/EVJy2OtVo204xCQxm8ecRamk2RsWD0eOHegysbfG3F6VowFi9PNDNirZ4AVGZntENWi6EfLYJUNoApyzB0sY198/u4gyBa8P4ERF3USWaIdYlzxdOMeKz3sXlM56m6xn1oEZ1O3tjZfOlNSBPgptqyczclWSfUrlnY=
Received: from PH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:5::22)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 01:08:42 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::9e) by PH0PR07CA0017.outlook.office365.com
 (2603:10b6:510:5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 01:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:08:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:08:40 -0500
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
Subject: [RFC PATCH v3 10/17] x86/resctrl: Add data structures for ABMC assignment
Date: Thu, 28 Mar 2024 20:06:43 -0500
Message-ID: <c3103dd30bc07070380a01922f66208759afe837.1711674410.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
References: <cover.1711674410.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: f4348a0c-586c-4c2f-20de-08dc4f8cc61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QyR55vAxHk8bBiGHITkYJtbiZ3Z7cGNfIGTmYPshe2Fl21uS6MrXfWKAQVPRe7KHJPtw9QFOj7l/iGWF0tF8gr0N8RrP2Mt+Uvqvhi+0r+cjLYBvK8PxysEj6/ER3CIJ+CavDJRSK/NjfKQdnvK9UB3eDClfY1UyGgtXw0itvEqrowSwNGeP5651bK67kFdjO/M+XUqY0/OWWFO0UC98Kw+FkhXDSYCF5zGQqS2S1dzPJyTfobSWObAHm/FLUrtVAqD44FnIzeBSOINbx+ViZZR45sddfqRzs6gaHeEVJkM6LLawGY0rQWLDbLCBX4SwCbblF4+ALN5F/iuk27WBta4TNaEA+b1NjYUG1+qweWof/KRwfeVhAagBoFQLa2wYq+H4K6knuG1TXRfXKEcf+aXtkR3mSWZMhbdUnCNtgwMa7mVn0uRGJI5AwphismTSqsY3jbFSTELkGstffYdwOUUVb49ai+MrWP+Cp5y5DnK13QjGJr/ee82fyVkqVLeSgUGsrpjBH8A03onnbhrfqWpWhrYS8O6kspLl7WC01pFsg5I0iFFkik70ZwtPlqPsGYjMV6LvfPbma7duGxEkRlqRClwB3zP1r1oO/YR/TIu04RNYJofIveEwkoCRAsPwZl3nd5ZAC/NihdYDk6zxiSd/zMpo45GHdM5AKjhcDjPOJzntB7hubSvXwHFuoHSBO7fC+tBpOixrRZdrg7K5yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:08:41.7087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4348a0c-586c-4c2f-20de-08dc4f8cc61f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

ABMC (Bandwidth Monitoring Event Configuration) counters can be configured
by writing to L3_QOS_ABMC_CFG MSR. When ABMC is enabled, the user can
configure a counter by writing to L3_QOS_ABMC_CFG setting the CfgEn field
while specifying the Bandwidth Source, Bandwidth Types, and Counter
Identifier. Add the MSR definition and individual field definitions.

MSR L3_QOS_ABMC_CFG (C000_03FDh) definitions.

==========================================================================
Bits 	Mnemonic	Description		Access Type   Reset Value
==========================================================================
63 	CfgEn 		Configuration Enable 	R/W 		0

62 	CtrEn 		Counter Enable 		R/W 		0

61:53 	– 		Reserved 		MBZ 		0

52:48 	CtrID 		Counter Identifier	R/W		0

47 	IsCOS		BwSrc field is a COS	R/W		0
			(not an RMID)

46:44 	–		Reserved		MBZ		0

43:32	BwSrc		Bandwidth Source	R/W		0
			(RMID or COS)

31:0	BwType		Bandwidth types to	R/W		0
			track for this counter
==========================================================================

The feature details are documentd in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

---
v3: No changes.
v2: No changes.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f16ee50b1a23..ab01abfab089 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1166,6 +1166,7 @@
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 #define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
+#define MSR_IA32_L3_QOS_ABMC_CFG	0xc00003fd
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index b559b3a4555e..41b06d46ea74 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -106,6 +106,9 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 #define ASSIGN_TOTAL			BIT(0)
 #define ASSIGN_LOCAL			BIT(1)
 
+/* Maximum assignable counters per resctrl group */
+#define MAX_ASSIGN_CNTRS		2
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -210,6 +213,7 @@ enum rdtgrp_mode {
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
  * @mon_state:			Assignment state of the group
+ * @abmc_ctr_id:		ABMC counterids assigned to this group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
@@ -217,6 +221,7 @@ struct mongroup {
 	struct list_head	crdtgrp_list;
 	u32			rmid;
 	u32			mon_state;
+	u32			abmc_ctr_id[MAX_ASSIGN_CNTRS];
 };
 
 /**
@@ -566,6 +571,24 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
 
+/*
+ * L3_QOS_ABMC_CFG MSR details. ABMC counters can be configured
+ * by writing to L3_QOS_ABMC_CFG.
+ */
+union l3_qos_abmc_cfg {
+	struct {
+		unsigned long  bw_type	:32,
+			       bw_src	:12,
+			       rsvrd1	: 3,
+			       is_cos	: 1,
+			       ctr_id	: 5,
+			       rsvrd	: 9,
+			       ctr_en	: 1,
+			       cfg_en	: 1;
+	} split;
+	unsigned long full;
+};
+
 void rdt_last_cmd_clear(void);
 void rdt_last_cmd_puts(const char *s);
 __printf(1, 2)
-- 
2.34.1


