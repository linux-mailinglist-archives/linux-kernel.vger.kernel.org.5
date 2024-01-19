Return-Path: <linux-kernel+bounces-31472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768E832ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E2287643
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DEF57320;
	Fri, 19 Jan 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zUmjOF7o"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A156B94;
	Fri, 19 Jan 2024 18:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688567; cv=fail; b=BYZntow+dLU+EzS5bmgn2DWWPgxQVPU8HRCVMl0cXLNEKy3i8phfnYGHbuoYRWwQqwbbxURswFXJn+D4TX8AbBUFCC9gGs7lbRUOL5rklyZ2jljLYGTCP+5dSvLAaPxEsQaLITui9PZjGa75k3+62BwbBlBcBtEsVTw3Z1NIV3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688567; c=relaxed/simple;
	bh=onuMoe7uHLh4sYvQtM9nyC+6hR2F2Iq/QNizEHxtyqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0RxXIYFUJD0wEqQlUXDy2Jh1aNTvBuY5cRbM0ykMnnS7GOvQPQL4GmdSJyHJCFRSh2fU2GUEKHPPuITKtr8RYEmc8PxmDeeexQM5H/5+fTM1HFRs7+NWXrhDgv3F7yWtAf2PdtIj2vMbWuHP0/+QhyFQiOovdQDfLVJ4NNsxkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zUmjOF7o; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRUjhNyNxV4/CBk28erRFLVWp2ASstNrcoKh0PctdWkqh1ji9Da+Zx4wimDqC+GbTCjMfBx9hy+7mN+2LM9JuQwRrAMuudjpGHbmBsDZrhGA03ya6FOgnn2EH3wcgDjALEAPVQxNhxCS/XETeAwzCgZuadkB0c+Tx71qg+tj3st231eB6eed7OAMzenJ0sqFCsN33NSta8dGu+HD1lEUOK7sSslhBwtgbUFsKL7W35wP2lnPxqlPE8WKiL+xuUkR+NlxinQ0kbISluPhbYGBjPconT7NcpwI652qMr/4S+obeqTomFbVA7R6HXM1kDCeDa03MDMysNJrMiHlkKBWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uEL4v2zAdn/bBaStMw+uDlMi/TmkHKQKoIyV26lRR8=;
 b=bXJZJqElG5yjUxNx+PNYhX3dgAdO7k6qwRbu3hKEQk4iUbDoodJz7aBWX+jE+X99JuK+MdGpfgHokOYtzDHuJl+S6hicuQzkHqRpUr78oHiWJ4SWylpV4vzCZpJMlSY7LvqsVOH10dst9nWG2pr0PlQz6UGN3K2SE8HAWnUNm6lKCUEmD8zt5R7eskHzmMh1ivp8IaBBgpfHt020LsNlC4OtZt4qpJUco8l1NziDwk9sDOoAemjI+diUa15+ZwdE19J8BOY/ASPmuUsCpz/84TeN+582HTa+GltJO6vOz8mZqu45qC2F7tZYdzp31S1NJaAFV21BknKNG4oM6F0/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uEL4v2zAdn/bBaStMw+uDlMi/TmkHKQKoIyV26lRR8=;
 b=zUmjOF7oEId42s2u85W1IQbZQDigHjTjJ0LIWeYW4ip51ewxd/tYJtU4/K6sieFxr7SvIilPqCqEWCmquNR/nSAvVYAcNxjjSIPVtmVUbBEE2aU04wf5mhkr07hwYm83mWO3nY+4tkSpHFxVR3SIM39kLIfd6Geko5kFAqYjllo=
Received: from SJ0PR05CA0117.namprd05.prod.outlook.com (2603:10b6:a03:334::32)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 18:22:42 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::3d) by SJ0PR05CA0117.outlook.office365.com
 (2603:10b6:a03:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:22:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:22:40 -0600
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
Subject: [PATCH v2 02/17] x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 19 Jan 2024 12:22:04 -0600
Message-ID: <27f05da7ecf98cc11d1ff00e9e770f5ae27f770c.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: 773abc58-ca1c-4f1e-d0a8-08dc191ba029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hiyh+sGVgybN53SiopRnyp2mSgQWDXA2rlwW+GYtVplJkbTrBWx6hhHaqgliQtRT5/x6Wv66f1GyY3og448Q13LCVzWxWM1xq5kkpa1AaQBqJVS+Ov8RXFPvqOjxwZg8gYvePTOBNU/DraPu5f+VOEHvIwkH1IpC1hPABk8QQhO26NKDqs4Nv5O3lxzYSX8ZnbKAbZxs3wSmZjEks3X9wLXMIaipmrhbdeqFCMnyRpydF1l88JJf31uWPMBoJRbwEprmaXHDS9jxUUSiEYUBHTDt9/zxsl+aW4cf0VwWlAhTDLPi/wRasfxiy/p6opOsREBL4llKpBYduuxLI1sA54wXXjF/QrHxiWvlpyCY6Q9yKKAzu1yFLzJZTZxksqA4oD0TeUJ6VLSMXATI0o9jYq1ey5ii3OPtGApT5h/BgLAvaNRCC9yn1NfGITE4fb8tj0mTZyO2rB7+hYi3ZDGDIdi1g1b8hVs0mlwFvW7+cdbZpfDk1qKDpUzaxaIrK3UyyC7fMrFaKp1tnokqqSbwYcmicGI9cYV+/RjMya9O1ENOkuBOImpkb0Kw9zfBHRBn0bU7Xv1x8+x4EL6ZQXhhbJCVketXOm5wTjmsON45x69CzzzpyacKLysMZUgOT0RNstG0vr8OvuXRKHRelaKACd1mFVml1j5njyZMQr16QiIS4SBZ1AuFBaJaz2N7In0gK1uvcFEWamESBL4DJi5KASfiIR1Ff3aruXDiRcwbDQzlggA6A3DzgDdJoUt39OLF9skx4rqCNOnJBxJ/wZNs/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(8676002)(8936002)(86362001)(6666004)(2906002)(7696005)(426003)(83380400001)(26005)(70586007)(16526019)(70206006)(316002)(54906003)(4326008)(110136005)(966005)(5660300002)(336012)(2616005)(7416002)(478600001)(44832011)(7406005)(82740400003)(41300700001)(81166007)(47076005)(356005)(36860700001)(40460700003)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:22:42.0424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773abc58-ca1c-4f1e-d0a8-08dc191ba029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no longer
being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.

Users can create 256 or more monitor groups. But there can be only limited
number of groups that can be give guaranteed monitoring numbers.  With ever
changing configurations there is no way to definitely know which of these
groups will be active for certain point of time. Users do not have the
option to monitor a group or set of groups for certain period of time
without worrying about RMID being reset in between.

The ABMC feature provides an option to the user to assign an RMID to the
hardware counter and monitor the bandwidth for a longer duration.
The assigned RMID will be active until the user unassigns it manually.
There is no need to worry about counters being reset during this period.
Additionally, the user can specify a bitmask identifying the specific
bandwidth types from the given source to track with the counter.

Linux resctrl subsystem provides the interface to count maximum of two
memory bandwidth events per group, from a combination of available total
and local events. Keeping the current interface, users can assign a maximum
of 2 ABMC counters per group. User will also have the option to assign only
one counter to the group. If the system runs out of assignable ABMC
counters, kernel will display an error. Users need to unassign an already
assigned counter to make space for new assignments.

AMD hardware provides total of 32 ABMC counters when supported.

The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
Bits Description
5    ABMC (Assignable Bandwidth Monitoring Counters)

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

---
v2: Added dependency on X86_FEATURE_BMEC.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 26bd99a35eae..ea57e4515da6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -461,6 +461,7 @@
 /*
  * Extended auxiliary flags: For features scattered in various CPUID levels, word 21
  */
+#define X86_FEATURE_ABMC		(21*32+ 0) /* "" Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index e462c1d3800a..44e8423628b7 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -70,6 +70,9 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_TOTAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_ABMC,			X86_FEATURE_BMEC      },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..698f2ccb9ac1 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,6 +47,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,		CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
-- 
2.34.1


