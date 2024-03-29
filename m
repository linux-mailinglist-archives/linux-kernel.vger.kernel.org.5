Return-Path: <linux-kernel+bounces-123939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8BC891007
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920B11F21495
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D921100;
	Fri, 29 Mar 2024 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yirZDoNq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4871CFB6;
	Fri, 29 Mar 2024 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674438; cv=fail; b=UeXUDCASuq0Gqu97DtAi6Hw4NYsfBE4cc/Ze72x00ijyP/Zf+ps1c1yUuFRo5GrfGGb1zF4XDyZc2HHTFIUyqnNqwoDZBYq8e7So2WzcRJRRrVwSMCTBrqhM0M7cTLkWC6Dvqo9e2g9OBOCoJUeB+v9zGIzewNkA9hibt/qqheE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674438; c=relaxed/simple;
	bh=+6KMIvVWD1aJ03MiQ7BmHsqbEAz3jg1goaQPZfV2gIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0RBuEHjaNvaAWxEwYDVMTedDlt07YfUKoVaqT6n7nNp8niOIuuzZyGR6ywej9PlxhyWNARGjAVFIw/r57w3n+L5gvXkL5k/4X49OsoT/PKcvgp0wK9+NBsuw+ZTIOyEdhDcPB/t1O1z7/oGTgMO5rFcQDbESqszGuBpwudypoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yirZDoNq; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeVZiOIqr8Hfw39C7jpHqxoBRqqajICEZB5hqcc2lbeF/EH7ixNjwz7iY9mIKIeHC8hUfL28dvY4JQSpm29FRDEEzhYCIsE9pDWY9nZ+Pmo/FxU2CYYR0g+hTEWCvyp9g1xCXH8gbBUPR8jAMN1asiKAZPUSbW7rdxbbvHTB1Zh/xmUaN6ONS8zJtPnvjMQ6Qjup15WFzZnV4Ye9vCbZoE25VI8hJICiIlC4C3av38qvxnfR3gwxh0gaPnmq5jPt2yY6KwxsQN3gEkK3aNY0p/v5CBpy21AsVdq6CdccyyczjZL8dTE/peiWg1cY7/0CHA27HEXDXli0jyat+gKFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZaXSbimx93/0ZOwTxMfynatv5yYygcvqYfPxXt5aKw=;
 b=HoMMCma6KKGIvrEcSN67shXOTvegwRPYV1Y/j2PesIACvhsD5v3xjSzUjKSF7P0x4115b3h36qbByMilw3RUzfCzPIxG2t+2ramOKy0ir13/aO97ysqb+k4RvKyMIlxge0BK15vEG8m0UpelIfWl+lg5NVWHgb0scFGXw7DdS2XRERz5517u9bXLTf7cDG50IUjsR1P1H5aUD774+sQrRGVr236HlvKwKrizFiD0cPQR/j2O55HZMV32SVrU6QpV8V8Q+nLMWMerHoGvUy+8hNoLc1VS/CKNrJvf113/slnyUHu8XwCX4fM8i9vxUzPX+n2gtQ1kWH8GG/6hXK5O+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZaXSbimx93/0ZOwTxMfynatv5yYygcvqYfPxXt5aKw=;
 b=yirZDoNq7bnvVhtScnxLXF4/UZOMTrhLojsK+949JTHJ+1rsXTqdvmauYiHH7GjTssnef1c0G629oPbmAHVJ61GYCUDmM5eSdZHAjur5cGYy6gv52wWtM2isgx2SgAEjwUvUc/s97REy5o8f/MiG6gZqx4dwD9GKm1xX2H0yaOc=
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:07:13 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::2f) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:13 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:11 -0500
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
Subject: [RFC PATCH v3 02/17] x86/resctrl: Add ABMC feature in the command line options
Date: Thu, 28 Mar 2024 20:06:35 -0500
Message-ID: <eecacbc657f39c863fe831da3166e08753085d1a.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: c91e74f2-41d8-4376-906e-08dc4f8c9169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vH9/SOXPdzU3AFWkukP+TZ5kTQqEp88PdgEQweNGCSa3vuAOHibquTaekuZXJwV9DOn5tvItbqr/tJWOrFcco2iy1xNJjN5eQXGpuKc/tn7dezpYi7eO2vubYlMOKiAxYwZ+YcfpK8L0V361zIxe1lXU11WWToj247H0KDztS8CgdbEeRq3u1YnRHGtNmmxJAjT5a6cT0Vj6s/dr8pawaxFH6vd0P8UeIaiD5aUL8DIZ8qYQWpxy45EdtUNg7kQclumvVBb2VEcrCYzNNDlig1As9RpR+UANnQXE0Eygebtn6hsq+wxQWzDuPZd4DQ0EGuBFwBl5cOV2uB8ud9xmz7k7Yy6B4+e7KjpUwgHMO63b2JTTzq+uEdunr7+XEnKPaDUkza31EhIf/jrrM0teJtwx3eOLWUCby4ndR9iR3UOYj9Qz7XytfamwOwtZYVrj7hQOFe7/JzzxJQAWHxsSGINQe8+Kl0OqLwvX4zXgPVj9QSJIAGokQBWmx7DK/vGR5i2Wr+uNs4Zwfn98hCEby++sVCYG9bGZNsPzhBt7d178l6S56tjpo1ajbtujOwzYAj9jl+v5dO4bwuzqOQ2bMVW0BagQXLE+nfsdyim0+YrzGNpGcKCMszU+vvzJGbLOO6jYybFwhjlLnHWtd7ij7Vkl2KdwqJ9YYxVl7oFz+rcl5FBuW4r3FP3FzcHBxrkMvR7V8LYvMuQouAdBjVWUKXFuWaydPZYpXznL9SM8+I0+LhsvAa2kKZeATuWJW8hC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:13.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e74f2-41d8-4376-906e-08dc4f8c9169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350

Add the command line options to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c14b2f6..b3a2e7f72462 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5551,7 +5551,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 6c245582d8fb..68df7751d1f5 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 83e40341583e..57a8c6f30dd6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -664,6 +664,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -689,6 +690,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


