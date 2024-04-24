Return-Path: <linux-kernel+bounces-157276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122408B0F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951E21F25A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C915FD15;
	Wed, 24 Apr 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HSK7HZJ/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F191635DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974349; cv=fail; b=IUF6dxoe10/NWkQBgnYwrigWTFeNrK6HCRlLOx3hxJuDBDdTAN7B/byxGTGY7Dzd62G6h01+3IAtKzq6728kGGSRfSPHqG59peTSqdIgNTLulQ5qmpfr+wrrgx9fWLdLWTEaXYpcviLMCnAqFZVSBrvgb8p4RwxLMrUAqv0QfC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974349; c=relaxed/simple;
	bh=3YDaHiutIgYlNhCcDi1GSw7qspv9UJtm6SG6Fqae198=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRKiyKVr7pGURkWCkSVGG4br0u12rKEx6rcXAI81iyTuYARPRLTAayBsuFHbEnuLu2CjAbofw7d9JzyITXTtZ7Ruv+5DzXjmyb0+AfHLgG8WuP6l8Lc2LLuALRgKxHmcrq+Qyzd3r8IG9wKjcGNi1F2hwxDGhJDUKqG/nV5s1B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HSK7HZJ/; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5uW2qek0rTxI5FBvx+MYItgyVz0fgQiqA0uBZQhmWGUBrXyFkFytHc8RSN4JtjutXAXTM2xksY9/1jMnPZHc3eGFiY5yGdGq2D4xlE2AojvxCB93WHMu+vKwSui0tNI5OXKUHN16equDgeXUeZPkqSxpCKq07tV7YDbhLfdGH16J9mWvLqmDJWhzGsBx09s2WAR4AJFAzOrW+xFGdCFqrz3eJWLMPj5ZJPf6Zz1OT9vi2GG9/28rfo20We101MJOSw+y1qWXSkCzQiUlMvv3QimMeL0mMUfk/2eYJr7QMUzdX64ZPhi0RY3wM/Q4wrfiwvVpospfyZOh6yiPhU0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF5LZWyAiNqLqtvx7E6KrWBu6pECVjNrZrovtybdqYg=;
 b=GjfVV5OMAwiBuJ1XqIYR4vLZyVYEemIs+8nR1+f1ZF/YP55bNioypa0CkPikhpg+/No8/mnHBMAsrzx3DficgijhdAA5NKsnM82kGrBxwMt5XmynBeM9TsAOiBgFxSObIomF6mb/R5pQwUu8TUOPuasz6HeEcyHq7rOTSdZCuHwPKjNbJVPRRZN4iVbWgr3V9xYfPMeqIXgSdIvuRnYfdMqwdAbajK6iy5rDlhwHSN6TBjwkkrKVRrpN6rb3/vQKka0R/qSBGfjewOgQaOQxATW7EOIO+AWTXZML+xvgOOim9r5oXFXc61jf8mO65+FYosdeoudTblX8HYLrmx/KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF5LZWyAiNqLqtvx7E6KrWBu6pECVjNrZrovtybdqYg=;
 b=HSK7HZJ/nHElEewBALuDtHDsLjfs/4RkC7b9PcRenUl3tkbpYFTJ24MHoP6s23HznW5yfSVuGL8ETtHcCnFnz5NyJKLyi6GZjGmfFNXQukqBXy5OFmZ5Sogy50kYAr121Z4BQLryJN2TpR2VIxfUJGFAQyQlJ9zKHHjkNsgHwl4=
Received: from MN2PR22CA0021.namprd22.prod.outlook.com (2603:10b6:208:238::26)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 15:59:03 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::55) by MN2PR22CA0021.outlook.office365.com
 (2603:10b6:208:238::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:02 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:00 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 05/15] x86/sev: Use kernel provided SVSM Calling Areas
Date: Wed, 24 Apr 2024 10:58:01 -0500
Message-ID: <07266b47e749267ef9a9ccbc9e8e9df78ed54857.1713974291.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713974291.git.thomas.lendacky@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f98f65f-f5b0-40e6-8e2e-08dc64777640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400014|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9PrZQq4VJQ2LyKvfb9OyjJrK8/VDvb0vdnB4K52Lkn6xwG9gj1tmh8VDVwji?=
 =?us-ascii?Q?TKKD/qm95u7L3LrmmexK9dYiS3Stot8qSEEgIV5PjgNJc0z9HOMpdjQi6y1Z?=
 =?us-ascii?Q?4x6k3NSIsopiyVNjTI41NkrD7oN/7rzn0F77Go7z9RNinjR4Dt/A6cuhFstY?=
 =?us-ascii?Q?7vHYx7VhQG8RM5HZvT8zoD3TEUBkfAEOHDZP+LptceVRPyflcNTRAav9caDC?=
 =?us-ascii?Q?pkTnHB9X5RSSi5kzAlfdyeIYp65iakOvzHFJwRyE5iXSK9hQdoDuoBA/kIXh?=
 =?us-ascii?Q?peB3JIb6c+2KBhH8R/IoAzbFbGJVyrbdQSeK6bmA/5KYvQBOYvPNBoJMs+0b?=
 =?us-ascii?Q?t45RfKTNcsSSaFv8XO2JrMIpBvHjzYFhj/xUvVNH/HmqruezXWM0AZFw7fWQ?=
 =?us-ascii?Q?49q//bPmmNWOuP4pbsCUq0oIGgbBGOif5GJmDU8YhPuPbuybIIuSTO3xFXzt?=
 =?us-ascii?Q?sslvXxa61ee4fph+gODezjklQ0sK9wX3iJn3jpQ9jD9ZEPv/c2zJvyCM5AWL?=
 =?us-ascii?Q?o0yf1PxBD+1nNwFOUqFcU3ZU2XQAPfRV+AreoHZdXE+w62v9n6d2duDQgZh3?=
 =?us-ascii?Q?Hcid8Tgp1H2ObgIe7D990TihkHWVQ7oUWM9S2dLMnY7e3BEsQQvlhZzW88fn?=
 =?us-ascii?Q?X/PZOZLUMyfii/kWTWfsu1Y/Aan0G1WzC99DPwrw2T8ijmXU7iFA0h7x/Iq6?=
 =?us-ascii?Q?uK0hdUOioT4JqheunbDKpKofVvab85tOIU/2XTGMBBpF+IYVuPAYoVxsys2a?=
 =?us-ascii?Q?s83+wfZRMtYkdIanr1h43wQUniohswAvp87F/nmFknBn6vh8/mESoWmf6rZ+?=
 =?us-ascii?Q?gaH4KrWHOpz1FZF0KEHEt2lyRjQG2w736ASAZIbU2//Wg/F0hQTpVV3grVrG?=
 =?us-ascii?Q?R+FtMPHUphNBU4vhmxR7dQD/0L01bykPNyzQO6Sez6v62YgI5B3a+dcELjM4?=
 =?us-ascii?Q?CoElxE38/IrF1QUZk7P5ZKYsycPLgBpIbO9YgWG4W9S/YBOWFsfk4RhaneKm?=
 =?us-ascii?Q?8i8EojRewdJi0KDR3NXtVTLgo2KHcbbApHUokkHVXoP2wtgGJZ/x6b6JhSLK?=
 =?us-ascii?Q?XYUM6r+quf2wJfR4lzLQpZvTijlEj3tsMlXCuwiCgyXQnNCIyu/1I7hJVbfc?=
 =?us-ascii?Q?v2AZZyFDGy1ga3QDTlpsAsdcXcHj0uFkaluneo7H396Kq0sh9jniCCQcNa0I?=
 =?us-ascii?Q?e6sk1+6R7OzA7gHKsgQmlEYAE/WqHXmahbPVZcwb/SK6Ti8Vq5UACmMYVzSf?=
 =?us-ascii?Q?V/C7c7qF4NKV4MhuaVrepYwaTPZvaCf+NPIUgYkvBIDJoKrDf4+KRs4ZuJh6?=
 =?us-ascii?Q?N3BdrDwuFP1HYkl7w8OMzOpd0SHIbsN2LNjWrZlLdEkVdXi7JXU5ccgh8kTo?=
 =?us-ascii?Q?/s3QkH6RWwZe53ML9y/p8Cst1Iu5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:02.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f98f65f-f5b0-40e6-8e2e-08dc64777640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

The SVSM Calling Area (CA) is used to communicate between Linux and the
SVSM. Since the firmware supplied CA for the BSP is likely to be in
reserved memory, switch off that CA to a kernel provided CA so that access
and use of the CA is available during boot. The CA switch is done using
the SVSM core protocol SVSM_CORE_REMAP_CA call.

An SVSM call is executed by filling out the SVSM CA and setting the proper
register state as documented by the SVSM protocol. The SVSM is invoked by
by requesting the hypervisor to run VMPL0.

Once it is safe to allocate/reserve memory, allocate a CA for each CPU.
After allocating the new CAs, the BSP will switch from the boot CA to the
per-CPU CA. The CA for an AP is identified to the SVSM when creating the
VMSA in preparation for booting the AP.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev-common.h |  13 ++
 arch/x86/include/asm/sev.h        |  32 +++++
 arch/x86/include/uapi/asm/svm.h   |   1 +
 arch/x86/kernel/sev-shared.c      |  94 +++++++++++++-
 arch/x86/kernel/sev.c             | 207 +++++++++++++++++++++++++-----
 arch/x86/mm/mem_encrypt_amd.c     |   8 +-
 6 files changed, 320 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1225744a069b..4cc716660d4b 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -96,6 +96,19 @@ enum psc_op {
 	/* GHCBData[63:32] */				\
 	(((u64)(val) & GENMASK_ULL(63, 32)) >> 32)
 
+/* GHCB Run at VMPL Request/Response */
+#define GHCB_MSR_VMPL_REQ		0x016
+#define GHCB_MSR_VMPL_REQ_LEVEL(v)			\
+	/* GHCBData[39:32] */				\
+	(((u64)(v) & GENMASK_ULL(7, 0) << 32) |		\
+	/* GHCBDdata[11:0] */				\
+	GHCB_MSR_VMPL_REQ)
+
+#define GHCB_MSR_VMPL_RESP		0x017
+#define GHCB_MSR_VMPL_RESP_VAL(v)			\
+	/* GHCBData[63:32] */				\
+	(((u64)(v) & GENMASK_ULL(63, 32)) >> 32)
+
 /* GHCB Hypervisor Feature Request/Response */
 #define GHCB_MSR_HV_FT_REQ		0x080
 #define GHCB_MSR_HV_FT_RESP		0x081
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 56f7d843f7a4..8f180fd3cbf0 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -178,6 +178,36 @@ struct svsm_ca {
 	u8 svsm_buffer[PAGE_SIZE - 8];
 };
 
+#define SVSM_SUCCESS				0
+#define SVSM_ERR_INCOMPLETE			0x80000000
+#define SVSM_ERR_UNSUPPORTED_PROTOCOL		0x80000001
+#define SVSM_ERR_UNSUPPORTED_CALL		0x80000002
+#define SVSM_ERR_INVALID_ADDRESS		0x80000003
+#define SVSM_ERR_INVALID_FORMAT			0x80000004
+#define SVSM_ERR_INVALID_PARAMETER		0x80000005
+#define SVSM_ERR_INVALID_REQUEST		0x80000006
+#define SVSM_ERR_BUSY				0x80000007
+
+/*
+ * SVSM protocol structure
+ */
+struct svsm_call {
+	struct svsm_ca *caa;
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 r8;
+	u64 r9;
+	u64 rax_out;
+	u64 rcx_out;
+	u64 rdx_out;
+	u64 r8_out;
+	u64 r9_out;
+};
+
+#define SVSM_CORE_CALL(x)		((0ULL << 32) | (x))
+#define SVSM_CORE_REMAP_CA		0
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -252,6 +282,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void snp_remap_svsm_ca(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -281,6 +312,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
+static inline void snp_remap_svsm_ca(void) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
index 80e1df482337..1814b413fd57 100644
--- a/arch/x86/include/uapi/asm/svm.h
+++ b/arch/x86/include/uapi/asm/svm.h
@@ -115,6 +115,7 @@
 #define SVM_VMGEXIT_AP_CREATE_ON_INIT		0
 #define SVM_VMGEXIT_AP_CREATE			1
 #define SVM_VMGEXIT_AP_DESTROY			2
+#define SVM_VMGEXIT_SNP_RUN_VMPL		0x80000018
 #define SVM_VMGEXIT_HV_FEATURES			0x8000fffd
 #define SVM_VMGEXIT_TERM_REQUEST		0x8000fffe
 #define SVM_VMGEXIT_TERM_REASON(reason_set, reason_code)	\
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 46ea4e5e118a..6f57eb804e70 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -18,9 +18,11 @@
 #define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
-#define WARN(condition, format...) (!!(condition))
+#define WARN(condition, format...)	(!!(condition))
 #define sev_printk(fmt, ...)
 #define sev_printk_rtl(fmt, ...)
+#undef vc_forward_exception
+#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
 #endif
 
 /*
@@ -244,6 +246,96 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 	return ES_VMM_ERROR;
 }
 
+static __always_inline void issue_svsm_call(struct svsm_call *call, u8 *pending)
+{
+	/*
+	 * Issue the VMGEXIT to run the SVSM:
+	 *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
+	 *   - Set the CA call pending field to 1
+	 *   - Issue VMGEXIT
+	 *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
+	 *   - Perform atomic exchange of the CA call pending field
+	 */
+	asm volatile("mov %9, %%r8\n\t"
+		     "mov %10, %%r9\n\t"
+		     "movb $1, %11\n\t"
+		     "rep; vmmcall\n\t"
+		     "mov %%r8, %3\n\t"
+		     "mov %%r9, %4\n\t"
+		     "xchgb %5, %11\n\t"
+		     : "=a" (call->rax_out), "=c" (call->rcx_out), "=d" (call->rdx_out),
+		       "=m" (call->r8_out), "=m" (call->r9_out),
+		       "+r" (*pending)
+		     : "a" (call->rax), "c" (call->rcx), "d" (call->rdx),
+		       "r" (call->r8), "r" (call->r9),
+		       "m" (call->caa->call_pending)
+		     : "r8", "r9", "memory");
+}
+
+static int __svsm_msr_protocol(struct svsm_call *call)
+{
+	u64 val, resp;
+	u8 pending;
+
+	val = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
+
+	pending = 0;
+	issue_svsm_call(call, &pending);
+
+	resp = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(val);
+
+	if (pending)
+		return -EINVAL;
+
+	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
+		return -EINVAL;
+
+	if (GHCB_MSR_VMPL_RESP_VAL(resp) != 0)
+		return -EINVAL;
+
+	return call->rax_out;
+}
+
+static int __svsm_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	pending = 0;
+	issue_svsm_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return call->rax_out;
+}
+
 static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 					  struct es_em_ctxt *ctxt,
 					  u64 exit_code, u64 exit_info_1,
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a500df807e79..21f3cc40d662 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -133,8 +133,13 @@ struct ghcb_state {
 	struct ghcb *ghcb;
 };
 
+/* For early boot SVSM communication */
+static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+static DEFINE_PER_CPU(u64, svsm_caa_pa);
 
 struct sev_config {
 	__u64 debug		: 1,
@@ -150,6 +155,15 @@ struct sev_config {
 	       */
 	      ghcbs_initialized	: 1,
 
+	      /*
+	       * A flag used to indicate when the per-CPU SVSM CA is to be
+	       * used instead of the boot SVSM CA.
+	       *
+	       * For APs, the per-CPU SVSM CA is created as part of the AP
+	       * bringup, so this flag can be used globally for the BSP and APs.
+	       */
+	      cas_initialized	: 1,
+
 	      __reserved	: 62;
 };
 
@@ -572,9 +586,42 @@ static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t si
 	return ES_EXCEPTION;
 }
 
+static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		exc_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		exc_invalid_op(ctxt->regs);
+		break;
+	case X86_TRAP_PF:
+		write_cr2(ctxt->fi.cr2);
+		exc_page_fault(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
+static struct svsm_ca *__svsm_get_caa(void)
+{
+	return sev_cfg.cas_initialized ? this_cpu_read(svsm_caa)
+				       : boot_svsm_caa;
+}
+
 static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
@@ -600,6 +647,42 @@ static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 	}
 }
 
+static int svsm_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_save_fl();
+	if (flags & X86_EFLAGS_IF)
+		native_irq_disable();
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else if (boot_ghcb)
+		ghcb = boot_ghcb;
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? __svsm_ghcb_protocol(ghcb, call)
+			   : __svsm_msr_protocol(call);
+	} while (ret == SVSM_ERR_BUSY);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	if (flags & X86_EFLAGS_IF)
+		native_irq_enable();
+
+	return ret;
+}
+
 void noinstr __sev_es_nmi_complete(void)
 {
 	struct ghcb_state state;
@@ -1346,6 +1429,18 @@ static void __init alloc_runtime_data(int cpu)
 		panic("Can't allocate SEV-ES runtime data");
 
 	per_cpu(runtime_data, cpu) = data;
+
+	if (vmpl) {
+		struct svsm_ca *caa;
+
+		/* Allocate the SVSM CA page if an SVSM is present */
+		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
+		if (!caa)
+			panic("Can't allocate SVSM CA page\n");
+
+		per_cpu(svsm_caa, cpu) = caa;
+		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
+	}
 }
 
 static void __init init_ghcb(int cpu)
@@ -1395,6 +1490,31 @@ void __init sev_es_init_vc_handling(void)
 		init_ghcb(cpu);
 	}
 
+	/* If running under an SVSM, switch to the per-cpu CA */
+	if (vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+		int ret;
+
+		local_irq_save(flags);
+
+		/*
+		 * SVSM_CORE_REMAP_CA call:
+		 *   RAX = 0 (Protocol=0, CallID=0)
+		 *   RCX = New CA GPA
+		 */
+		call.caa = __svsm_get_caa();
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+		call.rcx = this_cpu_read(svsm_caa_pa);
+		ret = svsm_protocol(&call);
+		if (ret != SVSM_SUCCESS)
+			panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
+
+		sev_cfg.cas_initialized = true;
+
+		local_irq_restore(flags);
+	}
+
 	sev_es_setup_play_dead();
 
 	/* Secondary CPUs use the runtime #VC handler */
@@ -1819,33 +1939,6 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 	return result;
 }
 
-static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
-{
-	long error_code = ctxt->fi.error_code;
-	int trapnr = ctxt->fi.vector;
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-
-	switch (trapnr) {
-	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_UD:
-		exc_invalid_op(ctxt->regs);
-		break;
-	case X86_TRAP_PF:
-		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
 static __always_inline bool is_vc2_stack(unsigned long sp)
 {
 	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
@@ -2095,6 +2188,50 @@ static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+static __head void setup_svsm(struct cc_blob_sev_info *cc_info)
+{
+	struct svsm_call call = {};
+	int ret;
+	u64 pa;
+
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	setup_svsm_ca(cc_info);
+
+	/* Nothing to do if not running under an SVSM. */
+	if (!vmpl)
+		return;
+
+	/*
+	 * It is very early in the boot and the kernel is running identity
+	 * mapped but without having adjusted the pagetables to where the
+	 * kernel was loaded (physbase), so the get the CA address using
+	 * RIP-relative addressing.
+	 */
+	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
+
+	/*
+	 * Switch over to the boot SVSM CA while the current CA is still
+	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 *
+	 * SVSM_CORE_REMAP_CA call:
+	 *   RAX = 0 (Protocol=0, CallID=0)
+	 *   RCX = New CA GPA
+	 */
+	call.caa = __svsm_get_caa();
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+	call.rcx = pa;
+	ret = svsm_protocol(&call);
+	if (ret != SVSM_SUCCESS)
+		panic("Can't remap the SVSM CA, ret=%#x (%d)\n", ret, ret);
+
+	boot_svsm_caa = (struct svsm_ca *)pa;
+	boot_svsm_caa_pa = pa;
+}
+
 bool __head snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -2108,12 +2245,7 @@ bool __head snp_init(struct boot_params *bp)
 
 	setup_cpuid_table(cc_info);
 
-	/*
-	 * Record the SVSM Calling Area address (CAA) if the guest is not
-	 * running at VMPL0. The CA will be used to communicate with the
-	 * SVSM to perform the SVSM services.
-	 */
-	setup_svsm_ca(cc_info);
+	setup_svsm(cc_info);
 
 	/*
 	 * The CC blob will be used later to access the secrets page. Cache
@@ -2306,3 +2438,12 @@ void sev_show_status(void)
 	}
 	pr_cont("\n");
 }
+
+void __init snp_remap_svsm_ca(void)
+{
+	if (!vmpl)
+		return;
+
+	/* Update the CAA to a proper kernel address */
+	boot_svsm_caa = &boot_svsm_ca_page;
+}
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 422602f6039b..6155020e4d2d 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -2,7 +2,7 @@
 /*
  * AMD Memory Encryption Support
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ * Copyright (C) 2016-2024 Advanced Micro Devices, Inc.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
@@ -510,6 +510,12 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
+
+	/*
+	 * Switch the SVSM CA mapping (if active) from identity mapped to
+	 * kernel mapped.
+	 */
+	snp_remap_svsm_ca();
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.43.2


