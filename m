Return-Path: <linux-kernel+bounces-123946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51161891015
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F6E1C24D78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AB1CD38;
	Fri, 29 Mar 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V9FioGmE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0002F182A1;
	Fri, 29 Mar 2024 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674523; cv=fail; b=oqd+INDKbdvGO+jN7yFD6a4NUsP2VTLuIupOcX9b4ZFuyoH/+tyIACrEXEHCluBebU+kDc85oMMtipkKo2vxpZwNAmaLpQfHB/fUJXSXrjsiSgL7xrtJOV14YMuMWZVyxYiPXqTdMGTbpAEtUSBHChjtarRjYloYBocLhAjvUqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674523; c=relaxed/simple;
	bh=vtNjCwUQ+CKibs3qpKRGOeaWIXIMMiv2OK6L/0OzHD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R408Sq7oCpGIvIH9NkTjBryQ7TWFXx3feVxQWqEVyf4LuvnD+b5jMGd/ZbbukdddqLizjpAKABNWMNohr3Fkq1+0b6Ds3k8/NW90prvxWF2aSo5VjhPMJxX6KmTLu0+GbLFyELxPebUfuHAx+yFgUjM0sBH+FvDySyjWWr//W6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V9FioGmE; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyvNqyXiVeyQSfHgPX472Wop36zfyjKvybADIPC4mI7p+LEM5GGTwyhkjXz1ZjoQC+LvPADwkoRFrR1tiFfKWLPG9hcrFD5sNAPJHF+tfj/5ENmyP+kdpDUE882jZtEKyR0lJJeQ5c88OphZzQ40fHh5l1ddK3YBXMj2urqeSGewL066RKhiIjJUI3s+uwQIBERQPJnz8HXMPiiCfIcuqc2nMP2DYQg9fEgxcmphhwa1UorlsBDT9cLIrjmit43ZB5gY+HWlRibA1ahJ5puMg2ljwBrhIB1nIpyw4E/V5J9+WJ9sVb6px7VuXH27xgK9TeZa7YzI8jz2GEvPdKoiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gtukF0LjERY6OcBlY64lGm6Au6dEWQWogg/RsMkLas=;
 b=EbzMX7eWpCtN0onRVUDlr+eygqvImtvu3qD3qfJt+ZsxDQfTd72gl8CS6tUFF8++7z56OHmURg6D4N79f02b15u+8Ym8g1iEw4t/O2GvkmPS/W4H0GU6Wt0FNRsGcv1dfESk2Tz4/+4kfgnI2UjG8SYnipTYFb2Z7u64kny4p+tlKaym5aoZhILNCBUBTxnkru//Gt3IBW5NoY8YhXG/UxYsPWS1X2kzXoupXH0qdYWSLssS2oXE3LLAlE9vdGfDn0BhX8wCzfUaqnkQWWjb+VYiH4n0MC9lXV8xGIbsBjcmlASmqDajr9Gln6Ka7OQ3/EgFEr6tATcTn9J7cdgIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gtukF0LjERY6OcBlY64lGm6Au6dEWQWogg/RsMkLas=;
 b=V9FioGmEjBUo4rrviY4dbkRIKYgDdw8vdlOwncMIhgi/b96PHgltFdsmU1LsAFoUCGjfX3vioIuswTtIZFUaimQV0dAx3p37loPTg0EUw4MWytmVr32FgL1uh5oYNRpCszluMbWa4ht7DQlYDdp4b0D7mFKQFEI5vzFH0cR3ns8=
Received: from PH0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:5::13)
 by PH7PR12MB9125.namprd12.prod.outlook.com (2603:10b6:510:2f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Fri, 29 Mar
 2024 01:08:39 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::c4) by PH0PR07CA0008.outlook.office365.com
 (2603:10b6:510:5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:08:39 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:08:32 -0500
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
Subject: [RFC PATCH v3 09/17] x86/resctrl: Introduce assign state for the mon group
Date: Thu, 28 Mar 2024 20:06:42 -0500
Message-ID: <1a6bc747da259e8b3a85de339bc1d6bf94995c53.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH7PR12MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 9866e5cd-a8bd-4260-a872-08dc4f8cc482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BTBpFpEOvOqViopWa+7wF3pS+lNPEAPUxMr6c8SB8SVvwMNmC4rwMjMED1BBPs/d156SeH/MlsAG9fPJi2GpiH1Z3zAYqzEt0wAHVG7gpGey7bQHBjMPwBKnd0tbNF9oQdRX3VwfYfFA1uPISa3iRb44GZckiKxNkjyvrh3xWBu76TsS3pfJ3olfgP8taKVTq0ImBYQ6pBEhUmc72/Qf4c2oVVxDPzPv498Q1UNGo9WNhvy4aSezimjm+4Vyn5hYsrN+8q7ydNfO0FzIbP3DslG2izt+7NqJcNcZ5MfwBPR+2gt8AF6oijAWXuXLvkw/b+F0kA/VlE5E0dpfGcgfYtOzS5G8TDV3PGM2PmLHgDOAEEN0BaaV5XEAzPEdOX9amxMxjcdvW8TQFuyJwSv2nSBJJWAPiRKydv6TF6Ogt1GmmbLNJuyREmzJoSkJiPu68WIP668R8j6a0Xdf7zjTfbdYgrw7b4XPeszWFvFkv5eH52ycl9redZ5RcYk3BCVzfoY6Xbki6Ge7ib2g929JlZvmWNWmwjwBehz/hvl/CmOn5uAKNY1xepZKPEP88iFV7JWqrfOUdjeYTDFYTBk/Fq87j1ZOZIEXaDT1Di1LB4qHcKTSKNx75QP4J/Za3CXqak08xzT2W1XXtRYn7zr8SlWiXlhdpOwkN6cwigiGqRFUqmaBLhdn7oFUv8qrE3pQemg6vcH3inPEq63bfcbqcegd/q0ldDWlGNmAYEvy6N2n1b7rJvNousH31EW/VXRx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:08:39.0055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9866e5cd-a8bd-4260-a872-08dc4f8cc482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9125

The ABMC feature provides an option to the user to assign an RMID to
the hardware counter and monitor the bandwidth for the longer duration.
The assigned RMID will be active until user unassigns the RMID.

Add a new field assign_state in mongroup data structure to represent the
assignment state of the group. This will be when ABMC feature is enabled.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: Changed the field name to mon_state. Also thie state is not visible to
    users directly as part of out global assign approach.

v2: Added check to display "Unsupported" when user tries to access
    monitor state when ABMC is not enabled.
---
 arch/x86/kernel/cpu/resctrl/internal.h | 9 +++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8238ee437369..b559b3a4555e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -99,6 +99,13 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 /* ABMC ENABLE */
 #define ABMC_ENABLE			BIT(0)
 
+/*
+ * monitor group's state when ABMC is supported
+ */
+#define ASSIGN_NONE			0
+#define ASSIGN_TOTAL			BIT(0)
+#define ASSIGN_LOCAL			BIT(1)
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -202,12 +209,14 @@ enum rdtgrp_mode {
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
+ * @mon_state:			Assignment state of the group
  */
 struct mongroup {
 	struct kernfs_node	*mon_data_kn;
 	struct rdtgroup		*parent;
 	struct list_head	crdtgrp_list;
 	u32			rmid;
+	u32			mon_state;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2c7583e7b541..54ae2e6bf612 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2473,6 +2473,7 @@ static void resctrl_abmc_msrwrite(void *arg)
 static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
 {
 	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
+	struct rdtgroup *prgrp, *crgrp;
 	struct rdt_domain *d;
 
 	/* Reset the counters bitmap */
@@ -2484,6 +2485,13 @@ static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
 		resctrl_arch_reset_rmid_all(r, d);
 	}
 
+	/* Reset assign state for all the monitor groups */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		prgrp->mon.mon_state = ASSIGN_NONE;
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			crgrp->mon.mon_state = ASSIGN_NONE;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


