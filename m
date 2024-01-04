Return-Path: <linux-kernel+bounces-17231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DBB824A35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC61F232B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB4B2C6AD;
	Thu,  4 Jan 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nuyHlc2Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6822C69C;
	Thu,  4 Jan 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkYWPXrBh6ufCeeXRe2A4NABXzIHaEo+rC+IlScRUUa0Wei+J5aVrx2l3OVEszkgDaSFFyzywegGSatfl/+ZQKDnx/GZvDYPxRsPlrZbYPPHOWVfBIyarTH5ehlVVgpKmTSbkmGLehgk9YSaDJqrP5luJ7z4S8Rvx7vLyvCTjcKeNf5jSsxUY0H/l0akGR6BxGNT012cm9Rv6RQiQ6M7+Xo1jfvSHFJ4VJIi8ZKIqdJyK3NkCW8M++oK/EyNH6ZcnfUvVPoBQgswHDnq0uf/qzVIhx4wnGpffxol/0aA7vKEzAdoQZS6wRAj42VKiI3tVZitTYEKKNxK2eBBHq2glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNyW8v8v8Lu5J7Q1dnG2dj5B6L0up65CZEbToqO+dYQ=;
 b=KBPOXesRCTzW6YMH98rIv2/W5a8brzidvuoLUWeyPgLCm4CI+Moxb+KGikARCpm41eAjXjE6MdpBymgF6IuNBan7EfehucAcatE/MocDadrnTuLIgpm04zjlsNdwGAk9ws8PgJH2OCkhvX4RFC3fYPokt9RUM9GB3mVopkKjS06qxE9hjpoz0h7RL6aS3n2ntJNYVG5PkKnH1jmFO5Nytp9vFSSWfkesjedyGY+6CZBX2dGHh3g08kTpEUAYtgEMBYGvqKgiQAF6cqHnBaWj1+4IGg2FbU7No10yqOdrX9OhAvOxjORoCF4vR6nMrb0EApYbF1uCb7JnC08Z//ETfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNyW8v8v8Lu5J7Q1dnG2dj5B6L0up65CZEbToqO+dYQ=;
 b=nuyHlc2QNwaeC8SkJu4+2pf7X+bPBxbt8K+5nD72c9FEmasvhG4MQwkjKi7XifPG/0dW8l/C38MJisBAFPoW6fOJK3GSo2OcX8AN9iaqCk2OE3miG/s3lgJdpFPMfEaqdQDmZtfgS+xAVp2IYcHw1MPfG/pzTIWDgatNmiIpEgU=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 21:22:30 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::d) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 21:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 21:22:28 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 15:21:53 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <tj@kernel.org>,
	<peterz@infradead.org>, <seanjc@google.com>, <kim.phillips@amd.com>,
	<jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<jithu.joseph@intel.com>, <kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
Subject: [PATCH v3 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
Date: Thu, 4 Jan 2024 15:21:29 -0600
Message-ID: <20240104212130.209490-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: f1196c47-cc5a-43ba-0d11-08dc0d6b418f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	epyfQ1DtocKSOaug3Y4V9En72VcjcazNZ+X0p7mRB2wCXu3k03ztP7PjoYAmKbmYgt2jI58x8EppYiCPLFpmjUC7kCorsMYRE2wrX6TF3hrjil5IvY31L/uAbgLy0el3lnDBzy33mifZqFabzajpA2EMViQchz44vOTahDNKxKAOdo9Xnap2jLy/rLmiNZiMQCWwn8cdFE7+Wr26ZQkD5kavZsp/vjdkwSELEmxQQ1gbiKQBIBr0oIfsPvt48gsgdLgv4zT+LwOLS2MI9YimetW4Dh2JQS+trUBSk2kUlfiYpGF72Us2Gxgu7RrEXWXZ2VVY1R7xpE78LuTwycR2s5qlYRIYOKQcuJ9A0cxI5Eq045XXAph8KkTRMC8wivBEZAhCbX1BbpOBGNivQl71UhsZndP/0fxk8V6viGLx5CPK3njWPKpX8Q6TJD70GF+hAFFTSj3eN69ph980lC6pYcc+faCqteywYV0mmXBJMULiUycG3y5bkOrdCpicR0VUPFiWnQbfCf0vtg5G+nP7yH8V9qbeksgUArFwmozdOaig1vR6Wl3a0D6xWB0etpvx2aHee6Y5PKuloBT1jNCfecK3eJnTh0JgZ11T/8iL4knIGyOLegzwl/vNRUGdkVW4PKsh1hyux9M3pdhg2BvAr3PcoZIjQM7zdCgh8Avf01NMuFYAtQhS40JQ11u/+mmmt23AdEcdM3PRemGcT7DLpV0qlICCuoLlczlfPJH/uNQIF5BV/aO+U6ZNoit8FOE/HWcnNvjIAcPyCGOfqtGwKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(426003)(1076003)(26005)(2616005)(336012)(16526019)(36860700001)(81166007)(70206006)(83380400001)(356005)(82740400003)(47076005)(110136005)(70586007)(36756003)(966005)(478600001)(54906003)(86362001)(5660300002)(2906002)(7416002)(8936002)(44832011)(4326008)(8676002)(316002)(40460700003)(40480700001)(6666004)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 21:22:28.9823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1196c47-cc5a-43ba-0d11-08dc0d6b418f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

The QOS Memory Bandwidth Enforcement Limit is reported by
CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
Bits Description
31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.

Newer processors can support higher bandwidth limit than the current
hard-coded value. Remove the hard-coded value and detect using CPUID
command. Also update the register variables eax and edx to match the
AMD CPUID definition.

The CPUID details are documentation in the PPR listed below [1].
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
11h B1 - 55901 Rev 0.25.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v3: No change. Just updated with Reviewed-by

v2: Earlier Sent as a part of ABMC feature.
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
    Sending it separate now. Addressed comments from Reinette about registers
    being used from Intel definition. Also updated commit message.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 ++++------
 arch/x86/kernel/cpu/resctrl/internal.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..d04371e851b4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -231,9 +231,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	union cpuid_0x10_3_eax eax;
-	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx, subleaf;
+	u32 eax, ebx, ecx, edx, subleaf;
 
 	/*
 	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
@@ -241,9 +239,9 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	 */
 	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
 
-	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
-	hw_res->num_closid = edx.split.cos_max + 1;
-	r->default_ctrl = MAX_MBA_BW_AMD;
+	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);
+	hw_res->num_closid = edx + 1;
+	r->default_ctrl = 1 << eax;
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a4f1aa15f0a2..d2979748fae4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -18,7 +18,6 @@
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
-#define MAX_MBA_BW_AMD			0x800
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
-- 
2.34.1


