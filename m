Return-Path: <linux-kernel+bounces-123938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EE891005
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962641C2369A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C48D1C691;
	Fri, 29 Mar 2024 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TClgPuvW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7A182A1;
	Fri, 29 Mar 2024 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674435; cv=fail; b=pXNK8GOSl1tQEt6TEbVq+RysHbbB4GbV0kPAcwg9WTrZ3CAuBZoonkSnu95STOd4/wLPMved5dinFEOFY3jR6MW4a4iXWy+oQfugcfbxlAyr4jA7WC+PUgf3M3W4qUw5BJ9Nl+1+TUiRYZawpILwKJRiz2KCOCqrxdWIQh2L/9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674435; c=relaxed/simple;
	bh=jlj96uO/OIu4Uj+sbkbdPRQ1lGw0U4HvzThBdv0hplg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq7iM9DgZGmqAkH9M9MyZGq1dwi+iUrVQtA/RLQd/Gwxqj2TxI7vzAtYyTjbnMWmIs5g46XpYBCKo7PCVTheeDLF0vqGZQAcTC2ONgZR2r0KwQKkij7Ki0PUAWQ6c71MC3CbsuTE9Z020VvcEosfqDNNBZ4GUOMgf6SB8TY3Iwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TClgPuvW; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPyUZyWBqJJgoZVog9tk+CKLJqc7uwUcsxJevDIhU0MgMpNRN73N1tVRxsZFyPTt2N9/uBJ9p8LpI4fyK9bcL2V4Gk8IEkUIqTeR6vhOOh9ixHScqLAkAJKJT0Thw9EdMqT12Qe7mt4QJYxwC3mmQw5lMBz+3lAHRR5Dpu9rqXqjBroXzhP6P8hpj1gbowkhsCVU5GTkc9fRMQkBtJSCXXavt/bLp8g4Cn7opqmVxcc9J886GtsHDD8pBh+BSy0I99fcWnoaHXGEIFOz160rTXCS6HmexEpgTh1h2YS1+W5oUEYg7D7fx6ZYyGOAMVpYWCt6bY0qiiCcTJgk5XDCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwk6MuCbdiKwHmuX/4xXDME5vFCxcNg8BTN1fb8qh+o=;
 b=fu1rUaE0Z9Sgr6SG0OOz/mTxNRyRMnySv02DbF9LQTM5MWRwcjXy9kRgVwE9FAuqNYYLh6/ZVqK1w60ueZPUX3DijccD7B57MLb+SwjuLdthLz+XbiMM/R3jQ7K3Wq/jo67UoorRUZfnEfqbq36Qd36tlsJCceQMnUBpl8lbmx78hy25/P2DpEVXQRVt8xIWh1DycKSv09/GWCCq/H7Z31Lk+0Ea739K9dLI/Jhn/cwNN8uOKdHJy7iLZL/VBuk5ajSz7dnpD/3i+s0qwEIzCvCWS7Yoy4CdJ1yek0p1eLO9DaCgHS7G73JCz+oJHoSmPYDRbFjlDUB7vIcpFBOmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwk6MuCbdiKwHmuX/4xXDME5vFCxcNg8BTN1fb8qh+o=;
 b=TClgPuvWrpnJa6wT96o5pHmu3IAqDQvbdT3Z2T5iRxeAq/YNNP2iPSlwi4wu/mctQPn1uE1byEaWcfCaTRimHXgWy0jg4ARTTZfGZ0wSra5iJuTwy1if4ataEkX/BneZwPd93w5qhhYL3tH6RxrNHSmFTvHDGKOz4pNuUZP/vKE=
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Fri, 29 Mar 2024 01:07:05 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::ba) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:05 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:04 -0500
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
Subject: [RFC PATCH v3 01/17] x86/resctrl: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Thu, 28 Mar 2024 20:06:34 -0500
Message-ID: <1194d7c66607648368fe34460709649b76ab85e3.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c9e5aa-0b6e-45df-41ce-08dc4f8c8cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M0/AYWClcKVO/ET7dN9a9b6BS8qVok0QN12qFvc3e/R/KFTeRx8YpdeBMrcHrHZG4yUCnciaz7fno9+RLiHHuQJwFmzSvhGK3gyRQRVLHLOtTMZR7wLFNbPZXpOU3Z5LOXpVRLY7MCmDBUWiksPWozWXhNbDseFaeF7JPRlmliVeT3XZEVOuDBLYjGJwRNNjdBO6nPQ5MuQj3l4Ylqx62Im+suwmC2CaTgeMIdl4Ik7UvrxRfKKuUeD45/GoMpa18VD3brcrwE5H/n53IHW7h+1kP9o76nCulWwt6n535Lf9klCoXK/8j8P8fHhXmd2vSCrxkdHkyFarg55cG9zSHFOYf0Vu50WordIwMvyJck6bw3vx2hiJzGAZjqaZm2MfcF8kztT0wLpBWbdNXDWc8cI7MiAqssbV12uTK0VS29XMg3R5kbd+Ad9xNvDEdsYHGqDiOnXXpxZhbgM4bNt4fG3XtAan7Tytzc4S8scP9Yk7n7shQ8aWFQZaMk86Nk8ztZ5RdnFBv5uDZuImg6ASTo2eUhNUTfKZUMlHFkcqXYvCXUt0ICOg/9mgdQg5crqXw82OfZpaDLyCTXLTaT6eNpSpVwitHzTVXn4zLZ1l2rYYMGV+QvMSWcU35WSXSh5P+h+/E03oGbc1tG/e2ejrPEgwuqZwneeAjdMkcBwQtiWyDOu6BYEkUrrv2xQR4Z47jiE74GNjVoKfQ1LND3v7xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:05.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c9e5aa-0b6e-45df-41ce-08dc4f8c8cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446

AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
feature only guarantees that RMIDs currently assigned to a processor will
be tracked by hardware. The counters of any other RMIDs which are no longer
being tracked will be reset to zero. The MBM event counters return
"Unavailable" for the RMIDs that are not active.

Users can create 256 or more monitor groups. But there can be only limited
number of groups that can give guaranteed monitoring numbers.  With ever
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
v3: Change because of rebase. Actual patch did not change.

v2: Added dependency on X86_FEATURE_BMEC.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 3 +++
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index a38f8f9ba657..342b82ec15be 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -466,6 +466,7 @@
  * Reuse free bits when adding new feature flags!
  */
 #define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+#define X86_FEATURE_ABMC		(21*32+ 1) /* "" Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b7174209d855..c1f2abb209b4 100644
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
index a515328d9d7d..930655f22f75 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,6 +47,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,		CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-- 
2.34.1


