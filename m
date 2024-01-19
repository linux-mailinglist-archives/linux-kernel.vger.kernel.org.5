Return-Path: <linux-kernel+bounces-31478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DE832ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A79D2B249B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6959B78;
	Fri, 19 Jan 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="us1xuaTi"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0C59B4A;
	Fri, 19 Jan 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688614; cv=fail; b=nI4tp2DZGNeMcyDEShTotoBVdmZN409sFgMpF0RbmMkCHUfW3HsrvWq9T83yzfYsA2t4Z5Cu3yxm9DaO0iSXGoH8HzvUqh6IFIVM0bstDkKCf1ewroSRuqlRzbTkQwUeAswCQtWn8HLsfNex6g/KIi9T+OY7P0y9twvKF1A2xBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688614; c=relaxed/simple;
	bh=djacoyFgLqHHfA+IN/9qkalyDDigy7KC7ENvOlq7X60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfdFf6ePkIB5T+S0RQIsVIhDoG+3uuXmmYEBOj3Zf4nP2LvISowX2XShvjs1wZeENJNvjIT/Kzms7q5mlsD9LHcpbQK++CXnS9g4qF4FaveOE2kTwrI5rSFn+ooAGHOo9/6UmuItvQAjMZba0A2cmyfkxyuET1viS0uvinR4Cpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=us1xuaTi; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGr0STH86cbOa5ejgbDH+oP8uQSzF70vA+BLPG4CsBTsV0rvlOhhQYZsHhLsxVMCE0YB7NaA3VYO83rTALoIo/BYTsAoUW2q3aleI/BK5ehfLPg+NM3hk0+nhobG2akDLIM4n2fYKdXfJVcS8kiOo4gS+oQdqJgPfSUB7cWR+inzEQLhfkoAaqUPbNJdUw7FeucD6ox0Jj82o1JZrw9+NehsAFqHQW38L58UAHFOcTT9pcAMEXMSARXIBTcTIdnNRfZ3l2SzqKuqmSqVQksW7txAEmgEK1Y+0pkusrz9l2HDL6g3sEdwIQAqKcbfs/YQ3S3RzWl9cFbmRyAYiFc44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++RP8sHw7KoLJsrEXsjoU1tsUlZUfJ6P73bXzWemLew=;
 b=k0UORn1NQq8KV+fNcJrXWtXRKA+oVuC81XGsC8a2dZOrASAVk9mI4aU2qKAZdeXivrsQbc9zjjCS7M5H8tg33yjMKCqRl7zKbDcwGGGcDTiqghI6ucRGsWj42IoD7RGabLgaV7OgajFllomSJv1pPQwJN2ftQFTntlVcsY0B0spYrmV8xC+TRSbpbfHDLVDY/2ZyEIc2fp8xjbu8ZmhlRiKJfMzXyGZmpwgh3Aea5VWMR9eYRdHKXoYkUM9lcs6GjliuGBH19LqIK+QJNZvmCvW+JmHsUNuF5qfPhNeTl9gMKO4OoA5mHRMQNyTgL7KAxjqMnFj8ufidHi7sJcKgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++RP8sHw7KoLJsrEXsjoU1tsUlZUfJ6P73bXzWemLew=;
 b=us1xuaTiQv0SEsG1c0XJQV/A7UpM3rdYfalTXJPgD+7lnO/ikk3J6fp6VeahJrpW7IgITgyARlo8Mp55RW6IwETRrlC3GJbY8Ul90iyy/Cp9s6HCNx3i7/7RRcd3GMOByw2ArMzuFkKEcseR/GecvaiNJEuJ9JdHoo04nqGMUHA=
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:23:28 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::7a) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:26 -0600
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
Subject: [PATCH v2 08/17] x86/resctrl: Introduce the interface to display ABMC state
Date: Fri, 19 Jan 2024 12:22:10 -0600
Message-ID: <dede48871d69ec1122de15906b1f2f5987faffd2.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8d81d7-4fc2-45bf-3f51-08dc191bbb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9OJRe0HGbb67FLz+/sw5IRvjcNWDx0v1h1ETT10uS1YRNv19/7560f7nvfLdbsEuSQw0iKhmReAd3v4By37SB47FRVTrYP1MCxpKen3U4REqHuMj60MgPmwz+Yhcetvne9L2U+QncdjLAeBN9A3hnNmwgVMc0nQY7J513QwC2PKX3rjoVu9g5u6umxTjrIf7xi5Wsg7ghdVRDIKmgP5s7OqNrI3qAZmSd3t1vURZ53Ztcb/4i/r1A2t9/TKkyXR9PJfTD4Y4bSPI3qXoJko0CfW97iIhrFyHHawUBHO/Mmdi152WFFcf3ndXiCaIJV/FcNIjDWNy3Od1l+E3JQmiiRLSENei1rpHRWgaGxiMHh4KSoGBN76Aa8MKAJGJwk7fORf5ng8BfjzSfMIjDGqSEHet08psMihrWf/Y0684YgW1WbkCx7FSeYJEdM+98HZTqH3mEWTfasU8bPum7KmD+a26lL9SbGBE0k2IcVakZEE4glhBxkxGjVnDJslaREWaK0N4oDZ2W70OuAKWd1zqTWt8lYQCKeV5oO/8ym/rKTnSlzoB3vNTfqw3djeMPUMK9S+qcMJQVSBqZ2jhx4qA898LyJSd72yieKLxltW1cfKDLdiUUMJEzeEWj1Ma2OfPHdKg7IINHbo7sk5z5/JnrilUOHjIBkvj71zN0NKbqYQh3jB64V6Zc/xKxnwgZm8Y3kO5JDV0tD+Jw2o4/VieWhEYhvFiw/o9qm7tNuPo9EJZqSsXszFc5G1nsp6ucSaYGeZ9Jl0oNAONjFlW6CGy/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6666004)(336012)(426003)(16526019)(2616005)(26005)(7696005)(86362001)(81166007)(82740400003)(36756003)(356005)(41300700001)(44832011)(110136005)(5660300002)(83380400001)(2906002)(36860700001)(7416002)(7406005)(47076005)(478600001)(8936002)(4326008)(8676002)(70206006)(70586007)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:28.0343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8d81d7-4fc2-45bf-3f51-08dc191bbb91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238

The ABMC feature provides an option to the user to assign an RMID
to the hardware counter and monitor the bandwidth for a longer duration.
System can be in only one mode at a time (Legacy Monitor mode or ABMC
mode). By default, ABMC mode is disabled.

Provide an interface to display the monitor mode on the system.
    $cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
    0

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: This is new patch to display ABMC mode.
---
 Documentation/arch/x86/resctrl.rst     |  6 ++++++
 arch/x86/kernel/cpu/resctrl/monitor.c  |  5 ++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 73eeb50fd0b5..f94a4d314690 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -268,6 +268,12 @@ with the following files:
 	Available when ABMC feature is supported. The number of assignable bandwidth
 	monitoring counters available.
 
+"mbm_assign_enable":
+	Available when ABMC feature is supported. System supports RMID counter
+	assignment for monitoring. Feature provides an option to assign the RMID
+	to the hardware counter and monitor the bandwidth for a longer duration.
+	The assigned RMID will be active until the user unassigns it.
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index fa492ea820f0..a45084e30738 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -824,9 +824,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 
-		if (rdt_cpu_has(X86_FEATURE_ABMC))
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
 			resctrl_file_fflags_init("mbm_assignable_counters",
 						 RFTYPE_MON_INFO);
+			resctrl_file_fflags_init("mbm_assign_enable",
+						 RFTYPE_MON_INFO);
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2fb26227cbec..4f160dbf6376 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -822,6 +822,17 @@ static int rdtgroup_mbm_assignable_counters_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int rdtgroup_mbm_assign_enable_show(struct kernfs_open_file *of,
+					   struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	seq_printf(s, "%d\n", hw_res->abmc_enabled);
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1878,6 +1889,12 @@ static struct rftype res_common_files[] = {
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assignable_counters_show,
 	},
+	{
+		.name		= "mbm_assign_enable",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= rdtgroup_mbm_assign_enable_show,
+	},
 	{
 		.name		= "cpus",
 		.mode		= 0644,
-- 
2.34.1


