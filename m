Return-Path: <linux-kernel+bounces-123942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8B89100D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987581F23710
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6522081;
	Fri, 29 Mar 2024 01:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6m1hwHP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FBE200C3;
	Fri, 29 Mar 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674466; cv=fail; b=EclfR6RBKRADbLsST6vNV2eCxWMmYd1+IvgisVeLXQFc6IG9fdz5wz7QGZ8Hh0uuiFaPjo3HzcMHJp6cxLiyEsr7//8JExpgU5nsKDDXsR13dqMiKTyStxY0+SI1ottlDqL5/CuU/GMt7KhO/enHrNCKIam6EB+4gAFrOJNfTHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674466; c=relaxed/simple;
	bh=PJnQoB+0EwtPtcF6Znu4w5VFg9ebC6GK5TOhX4LqZ4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEJ+7XFZkvJ/7YIdkgNk1NUrDRUqZSGY6fxt84DzU5l5S9vqUtJCGzmUplw8D/0KFSCct88tXrPgntQ3maToJGHYj/8ef3cMxyKxCIjdjDe+ORXqNhK1aJpPCb//S7XL1ZyeDPwTrZ947eop00EwsZ8bm9EwJAdyoeBi7KjYuIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6m1hwHP; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgaPpCXeuLwNYeYntizS2q5tqRV7+/555B+TQ06BMzO8cbeotR2+4E8AP4DYwKByM2XzHilAlizMRw1XiRVE7CSf5VqQQBEmyLisJDW/D/O+HpTGmVA2HmNARDQioZa9kk2NpUIgBodUNL+PLmjtFR3WtPckQDNwJmd45HBkAbe7/OfTW3IJmD+BaL6hmDrFaOLZvyn6dxhPhgAW3CObVYjg2I6pLg8tBo8djdfzF0SnvuPLtAn48BpVN8w3/GkClE5gHHJwNPiIuFNQtBwXx/Nx6wfmO79wHwYkqvUAwSDASGQYQ+uqruVKjT3rLtJidAqYbSWER/9N8IxSZi+Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE7Q/RoxBICUCnjeHeZKwglzapPNF1MQqYqZWDR33dA=;
 b=l5QioQO0Jm5Zk7qLPEkJh5gTlXb4kYLVc3gc4XMsa9GqCls64YIaAkLROnzNYL9obVc1D1RMg47vT2SZEzpT5IuMaiY8OqI3qK2gO4/GvMex6O9GrfrE1nGLxOFpEn9TTFncKVANfT4/D+WqEf6OH5ClJDRoPlFufeIbezH8Nokrckd5CvbOg65Otnxyvwazvj1dsalxfmk1VAvHQgQc7PpkCpzmsrbbonVbswy3GQrg4KpNxWdvbDz2WboSIUB3YE9blIOOenKio4FbFZDKwvMwgQr/7V2WDoYa/nfyUl4jvyu8jMnK1/j65whcYY30bp30AxhntchvzDwC1hHXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE7Q/RoxBICUCnjeHeZKwglzapPNF1MQqYqZWDR33dA=;
 b=w6m1hwHPtiZobcv3XTgZ5Cv7r349jQk3nbh8bD8gh22TlwdUSX2avWUbkxb/sSU10VanxA9S/HQHkJDduj/qCO6MgciETVCj/IA3ow8vxgeqMoYlndiSsPyEFREQ272H3fTsc/8xX/FEcFe8Un524n9SyvFfSzcST80PEyqBoF8=
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:07:40 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::58) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:38 -0500
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
Subject: [RFC PATCH v3 05/17] x86/resctrl: Introduce the interface to display the assignment state
Date: Thu, 28 Mar 2024 20:06:38 -0500
Message-ID: <e50e1e55c2ef4f5e1609960e573b30a125a59e5c.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9a7593-9e2c-4678-af58-08dc4f8ca19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W8x9jkMMfwgCrFkyRDZzepLYvLt2QkU1odjcUCkMKKyivvdpZccLH4NmiVvjayiee3OUuQH7rd8/Y1C/Sv4OgqyaOmJZio2vKyHOqLl2akr4ImoeTAOZBsZeTZGqCrOJqc20pH7aqeoJNIzYnXjJWi1bdPJtrixr8SeK8yI9ZJNXumiE5JuzqNvGyySp1+iqgrllnl3q2c8DPLfVR/8Ltdhut17qtzsgsaKymnDpU9QuKMOIzkgO/a9sms//wEe+PcTsEu2VkHVaDK7MKqiVzyrzFgX1t86yvsIK8f88YzrH2o85CO2nM9IY8NmRgLY2YfCgIPYgtwqEWdgB+RSemrgtpwSxJP45M+yicqOlQJNhkqlSqp26AeSEuMuOv8TZg6pOa87MA9Srg5CRf6EjCEOGiePUXYuJIn+gG2RJ7BEKhzUBPJhmp22e96+C1GpGt5aDw3OKFwW/uSmbdakEkO+le53x1L6x2/HaWF9A0aEFCRZ17wTbN3/XLfmrc4p/+IDSrvHLBvjhT3dFk3zhML+s6QpbwQNZy10IAyD8GbuS0fpTVCwV3gEEExWkj0f/mLQNPQgHxWc19GTruYvOAsutUjbYsXBPrXDiWS9VwTV3Op1rkSpaPVo0On7sZHtFygjo0gmonynUFTIvIB/koKZTW7IbYLFHOTHKwGvIPmcwNX5r+YKh1P5PvcY/SnMPWTtGyhLkZnqlSRZ2AUnGdZIrsrydF0+Flu1heSAjP7nPeHIUOgNFRbZkmGIdFCIk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:40.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9a7593-9e2c-4678-af58-08dc4f8ca19b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841

The ABMC feature provides an option to the user to assign an RMID
to the hardware counter and monitor the bandwidth for a longer duration.
System can be in only one mode at a time (Legacy Monitor mode or ABMC
mode). By default, ABMC mode is disabled.

Provide an interface to display the monitor mode on the system.
    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
    abmc

When the feature is enabled
    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
    [abmc]

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: New patch to display ABMC capability.
---
 Documentation/arch/x86/resctrl.rst     |  5 +++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 68df7751d1f5..cd973a013525 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -257,6 +257,11 @@ with the following files:
 	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
 	    0=0x30;1=0x30;3=0x15;4=0x15
 
+"mbm_assign":
+	Available when assignable monitoring features are supported.
+	Reports the list of assignable features supported and the enclosed brackets
+	indicate the feature is enabled.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 735b449039c1..48d1957ea5a3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1058,8 +1058,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 
-		if (resctrl_arch_has_abmc(r))
+		if (resctrl_arch_has_abmc(r)) {
 			r->mbm_assign_capable = ABMC_ASSIGN;
+			resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index dda71fb6c10e..5ec807e8dd38 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -846,6 +846,17 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
+				    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	if (r->mbm_assign_capable)
+		seq_puts(s, "abmc\n");
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1903,6 +1914,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_local_bytes_config_show,
 		.write		= mbm_local_bytes_config_write,
 	},
+	{
+		.name		= "mbm_assign",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


