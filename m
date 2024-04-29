Return-Path: <linux-kernel+bounces-161832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7F8B51EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E051F2158E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC3134A0;
	Mon, 29 Apr 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HNK+TBHr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A827EAC2;
	Mon, 29 Apr 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374241; cv=fail; b=oNFLLAwox4SauQQoea8BdUXfrMm6NviYWmR/0ETvXVGL0HWv4u91c3gFBA7199fihgfoqBmpXeEn5x0rAYF1dSupvNOn320l9j+PMrxcuBzzs5VdBJNFxqQBS9E/Da2zLVErAulHXhQ1S+n2PUro1T5Bmimi8ZuNgWqGZI+B6RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374241; c=relaxed/simple;
	bh=lKOjHB47YJQ0aC5CQ1DH8BB3XhUSavRBhKJd9bjmFyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ORW7/gq6Madramf7rh9qWPorFyH0DHEM6aNZFVdTk3vmyN6SGLDbni9hEC1gDGwszWnx92UEc74lGXCrL6bjaAOX9PhsciE6VxBoFSrLIwzFO4OpH9RgroXh0XCnXxdVj3b8pb8CJ1kYsGxWYyJbiawH5UohUb+LOuUivIqGrVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HNK+TBHr; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwp6vG7dvNwgsz6D7+tPrTvpYAqnGfgHzWWYffKLX5ZLXEPpIziqQRmRvVHme3EBUTvoWGOsfO93G56vRkwCHZuNUoa2dDS2leRE2ZLWVeMEUX9rWlqEFjvnNA4dNl9VfTlHCyVTg/HzHCKUIX5++I+aC8e4eIbxWJ+N5ZZjagsuufHfzI63iQ3KAqBkKhmVeV9TWqX2vcdyEBNByt5pUHOrTtYYxkv0QkuS823LDWJtRH37ahqKGRq5mzI+oovGHaXi4V6ccirgEkiw9Tmkj2Jw7+wKZPd84H7x258qU2BdagB+2vJTzWJsg8XUmFKaWKW4Uz7Lv1G8ZpenkPDeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=HktjarP6WzXJ0EGW7iVcw9qEVVf7xZegl6p81lypow/bEVdxMdhS/nateV+vIKy9E/gJatVZUOU3ybMvFo2q5rDqfkzBE0nALB2VuNyY3nsjotkJUE0nUJJQjz4IGNTxj0KapJ77vtLJSMNYewjS7+QN0mD64sts6GIjrZOVA8UF69Bsn92uCOP2pFtsPmzg/5SezNI1j2+WPX/5ozqTyqG0/NCrO/SuyV4rp2jUzsmbHJi5wU8JuXbOuPMZqRTZav4BEp9pzUvS05mZfRfZLo+QlW2RVz7PdTHlqE3k3RrXuIx0nqoXKlsFStXVkI4b+eXQsYSbKxGQ6/kqEbndRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y+uP4bKKvDJlWbg1vzjkpAC2r/ZZ4/3mqfjx2hJCOw=;
 b=HNK+TBHr1bMqDGHA4JD2ge1SznXr/BMJQuItVWDOTVGTCoRLHp9uAr1S+a4A2hXYxb6Xg/expG4OZcSVtF3QsVw6ij641WKYL2U38NKogM27qecfr6bXmaUgWpSFD1TSdn3Z4L56fOn1px+cx0wLCdsU4VWqwcwsvOjPPBPSr9c=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 07:03:57 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::8a) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 07:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 07:03:57 +0000
Received: from jenkins-amdgpu-2666v3.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 02:03:52 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<daniel.sneddon@linux.intel.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <sandipan.das@amd.com>,
	<kai.huang@intel.com>, <perry.yuan@amd.com>, <x86@kernel.org>,
	<ray.huang@amd.com>, <rafael@kernel.org>, Xiaojian Du <Xiaojian.Du@amd.com>
Subject: [PATCH 1/2] x86/cpufeatures: Add AMD FAST CPPC feature flag
Date: Mon, 29 Apr 2024 15:03:21 +0800
Message-ID: <20240429070322.999500-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a2f13d-0f75-43d0-c5d7-08dc681a89e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5kMZBCGsNTh8zjJV4jvXerNptNKSDfvAF2eX9dd2vZ3au5eKnoo+Tt62Fku?=
 =?us-ascii?Q?GdZp5kNEjDbIO9MG5cR3quxpti9Uv27cE+d+8/bzp4A6CieDWKkK9r+Wr3Hj?=
 =?us-ascii?Q?4/ROqv9DbKmgo87I69TjTq0O0Kkt4FkJ9/LFe28jTjA4+BuOSXDmJhdgPEy3?=
 =?us-ascii?Q?3cyDlUV2k96bUdGMq43wOsrsKo+pnlSuw+IuEcpUKdRG2TfPkJ3CHHxBpI11?=
 =?us-ascii?Q?leEw0PNG5XkobtM8yD/KojhGPrzY73Q2rZ2UBNKro65mo6vY+YY7vVN62RO6?=
 =?us-ascii?Q?xWBY8B7iVZ30RPoUiRhrjJrWIgstPl+BPWdsa/sH/35k+gi7G6aqFsbFUFo/?=
 =?us-ascii?Q?RJh0bvGtZZ1QU6j72pd2huwuZS05YjwBcdFn5YbaJMFsJ03lG3+lmkMbQVsv?=
 =?us-ascii?Q?ceLG19yI+1C8X92ESoIzt5G29oTc7x0xMzVhcx1yf8GVyU8hNx2rQdeq0CcJ?=
 =?us-ascii?Q?rcoJPtzP+fm/JqImY0EjaclTbI0YXQndhxGk6gRdf+yTeOINcm1RuNu0zAqN?=
 =?us-ascii?Q?bzlylEy1Bra3BSKTGRa/tidsCUzwhkSXHrfW0Pxzkv71GSZ3W7k33xreLeWg?=
 =?us-ascii?Q?GRiWCmAoOOXHQg24HikLELWxuF9qC/Ne97vgqIOdQs67E5E28nbOZfkpKvOj?=
 =?us-ascii?Q?LbmlLF92xyUeV4dAs3j2AwZuCLZXy3KgAIl0ImNMk3XGTJEEzXHG8iRcmx3F?=
 =?us-ascii?Q?VebygjqW6n2YO+ZCCwtSbp/L7AM70fQSkxPQh257v6BZV0Kq9OMcS4PBDNCp?=
 =?us-ascii?Q?l1UfO24FwEqrND4E7lA0MfaQejdwfcS/ejz5xhXaanrbS/DdRrzzVKPG6RvW?=
 =?us-ascii?Q?yscbacG8okfTE9rzJmGTYfOZhT+/6Bc+ygybysC0epqQdJHP9YkUII10NyFe?=
 =?us-ascii?Q?JjOEM7oHoganSvb1w2vcuTltnF/4CdtewR1sAs8Aorx7X3z+W9zA82wM2tuH?=
 =?us-ascii?Q?03/fbOo1W2nwT/01KYUhSBNGVtBtQSsy+WbyAmCuM+l3TI/mTy2VJMedhuGQ?=
 =?us-ascii?Q?4p0NWVCTQ6K2dbT6AdiM1XNlIGFSTjCKn/65r8K37TOOcZnV3uHTL4ElbToR?=
 =?us-ascii?Q?nzqY91KUkYZ0Y0J23UmXUTh0AjeRYCoh4dU0KWxsRqi2ddMrtgwAlFUmTg3G?=
 =?us-ascii?Q?ojO8ZA5/e/eUXhC/F0tcIPEiasJTMT9YrVrfCjIhkt1FsqEOEZ+Glp7Tu11C?=
 =?us-ascii?Q?JznK58pXRqgAdqmcQAik0mRzHj7rG0UcaxIGP44xV1NensETmBzUA08YJ7nN?=
 =?us-ascii?Q?5vi902j2R/WEpZ9+m+tgQFfcF6PMXZRZBbSfEZlk1OzKS/oEU8p6Qp/U1fcS?=
 =?us-ascii?Q?VuMvUvNkeIaNwenrU8omVWQtiweNmmfA9guGZpCZycRo1itmjdCuCynbfeFS?=
 =?us-ascii?Q?bOYyr7nUfFXdDtavSZAiDdTinZKa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 07:03:57.0442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a2f13d-0f75-43d0-c5d7-08dc681a89e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

From: Perry Yuan <perry.yuan@amd.com>

Some AMD Zen 4 processors support a new feature FAST CPPC which
allows for a faster CPPC loop due to internal architectual
enhancements. The goal of this faster loop is higher performance
at the same power consumption.

Reference:
See the page 99 of PPR for AMD Family 19h Model 61h rev.B1, docID 56713

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c7434329661..6c128d463a14 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* "" AMD Fast CPPC */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index af5aa2c754c2..9c273c231f56 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
+	{ X86_FEATURE_FAST_CPPC,	CPUID_EDX,  15, 0x80000007, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


