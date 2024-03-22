Return-Path: <linux-kernel+bounces-111713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C5F886FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C981C21410
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5259163;
	Fri, 22 Mar 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WLEeZmBY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC9D51C4F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122098; cv=fail; b=StMU3S8bQl3TSjfeipUd5+WaoXzZesdm9OGiHSGd/6fgM4Q+oi86jAPH2EA3QDWDjjkNQD2jkDP3ISmD/y9jgKQWRgnDTsv6hLnsWwYH6X0t4l4bNUp3rK42ljKR+NhCCmJlwsFKS3/l6lqB8J0zj4enxZoTF9dl18CR9KngeA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122098; c=relaxed/simple;
	bh=XRXfYIXbwXzmrxNfXceyQu7U+ciRafNDDH+LQveK7+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0ty8NHeM1ybrOQ0BaHvzPXCa5XIvUlgDieKsse/mCTCRtuqbVPfOhNv8VZG6bvzCf0tnP3oqczrZjnGgWfTqikjExe13Nevwj/bSOTPA2vWIUXGQlpuPNEtZQ3Sc/K1/LI0mZixAnObf6Jhvm45be4HV9TVgO42YfYi8MRgAe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WLEeZmBY; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdUvML0wFX8Cj5Q2wD2IThTYEmDzg+IEPqi+hO0IBZ2UcUVTKUgtMvzHmgbQXO955RgFbEO6HlRmPOezfb60/oTBtIBJTmadr4YfUDFfyx5QWBBdXSekGCtckcgYrO6kYqZdF5A1VwYCm/XC4TBX5BN0wUuH7dRtLtyEccTJhDlL3Ivj50nVxUTNeatVWjdL6LFhFnWd8t0FWP9PJaOHSoFum7yvIGFwwC4jYkvDxIDli6SqterzlgZyMUEItdC3RRYfEqe9yMO4xooraR6wkLjLY5UZFiNwXHPyryU3QnujVn4ncEXk9fnZ47BNt04bqTglM3wXGGrqndsfoIUouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtcjS1VQtiJxrk4l4KSRlA2mRCeadkUHFf4lhpDtMIw=;
 b=mRHh/O02vOn3Qisy81N0yCfgciegTv869NJ9LBHDXrC35fv01dR9h9EKeO+DziRaIsx1//I3CoFivaRPOxwpxKjNy8/dwT8EMhHfDtjLi2DkWnIbIWr4QLyEl2aj83UgreRn3cPq2gvconrZpVvt/UrliGuU9l0zu4NqW/rYoAEwacRjrPPYRc7J+aDZ/CJpQSLYLGymnan4Z9IOis+pisPbyRHEMAtbxFrXLTIAsFrmQN9hGYgDNRU11aVqahX5bWqksnXoSxtr5JWk1yRIi1r/VRtEX/s2T14NyRyKp6dnPmBzNUK6j+epqWwc1YRFlu9Y1o6KP4mCgpbjGyRMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtcjS1VQtiJxrk4l4KSRlA2mRCeadkUHFf4lhpDtMIw=;
 b=WLEeZmBYd8TQh/6ar0SQwlywk7BvX9Caa0d8nC53SAXcL9X8bT5Pt1eART0fd4HtPEBT3kHWSbNSQWo4aXfUYSWKusMqvolYMJU/ccA8y6MtUSYwSzOeEhwM3vAXVzazC+N6mACam27yZwfwIH1PrZqCmGgEm33sJkoSwRgEuZE=
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.36; Fri, 22 Mar
 2024 15:41:33 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::15) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 15:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 15:41:33 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:41:31 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] x86/boot/64: Move 5-level paging global variable assignments back
Date: Fri, 22 Mar 2024 10:41:07 -0500
Message-ID: <2ca419f4d0de719926fd82353f6751f717590a86.1711122067.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711122067.git.thomas.lendacky@amd.com>
References: <cover.1711122067.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a0c210-021c-4c02-a997-08dc4a868d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7VGiCtCtz0ldwGALbaQ9l6DU8llYTFUeeXNBej6V4ZF9JM2Rj8OvGFj0fbD/mbsVfJ6nlyl446Thm3/daL+PchpBTP12D2DFsl5hfs5/tIQsK5LSdvwMLu8mARw9+7f5Gvsb0ep6IbB4P6alnk18mcw6CsOiUvcjuNEXQ07CA3IGyVVKOfV8aYbwCl2vI3R9ZZeF7fO6I6W6tOHlHVA9Z55rbruUnsE7ph+sQk/8pDymKVwJoSG1nGM9hm17e4cy08aeFI7Rp0qu4V+FCpyk/Q8HPHD/5Oy0yaJyDI9Jlk4ifIcIGsGhPWRrjIliWAmG5JBAMaxXSHuD669zqZ08Yx0JWL4kKAg28TIx+btYbEuq+wtOPi6Mvd134VlXyZpZTq3v/6xGiYGJ5OuIZ+8O/Ii52XZ77P1dv14i6mDxK70KgybRlvm/ZA2lwFHbF68y+Kd+iIZPo12qKktJ8kP+QW6/kHJhh0hxUVhje+wrvBSS1NBa1RFX0VWiYd/q5UJvGnAdKltJbfinczd+EKif17r73ehtWge3lE321tu/7VibCTrIx8fck1tGfCZtzHWD40tWxDKPOZ+s3XNiU0MTfhTcXqFhrddW007FkK62y1rUnG1EUfDUnW3cfoxjpMlSm2cYVUk2jLLXfR2pzspEBPHNLHRIA/3p4NR02o/wtMHw+Ry/gQQKwQqHy4nUrxZHW/fuJBh6QKHnUAzBOAPE3L00hp8zctH5+HWZo3HI+vC1wiPqUB3s/ad2NoM624Vf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 15:41:33.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a0c210-021c-4c02-a997-08dc4a868d1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426

Commit 63bed9660420 ("x86/startup_64: Defer assignment of 5-level paging
global variables") moved assignment of 5-level global variables to later
in the boot in order to avoid having to use RIP relative addressing in
order to set them. However, when running with 5-level paging and SME
active (mem_encrypt=on), the variables are needed as part of the page
table setup needed to encrypt the kernel (using pgd_none(), p4d_offset(),
etc.). Since the variables haven't been set, the page table manipulation
is done as if 4-level paging is active, causing the system to crash on
boot.

While only a subset of the assignments that were moved need to be set
early, move all of the assignments back into check_la57_support() so that
these assignments aren't spread between two locations. Instead of just
reverting the fix, this uses the new RIP_REL_REF() macro when assigning
the variables.

Fixes: 63bed9660420 ("x86/startup_64: Defer assignment of 5-level paging global variables")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/head64.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7d2eb035b6a3..a817ed0724d1 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -81,6 +81,13 @@ static inline bool check_la57_support(void)
 	if (!(native_read_cr4() & X86_CR4_LA57))
 		return false;
 
+	RIP_REL_REF(__pgtable_l5_enabled)	= 1;
+	RIP_REL_REF(pgdir_shift)		= 48;
+	RIP_REL_REF(ptrs_per_p4d)		= 512;
+	RIP_REL_REF(page_offset_base)		= __PAGE_OFFSET_BASE_L5;
+	RIP_REL_REF(vmalloc_base)		= __VMALLOC_BASE_L5;
+	RIP_REL_REF(vmemmap_base)		= __VMEMMAP_BASE_L5;
+
 	return true;
 }
 
@@ -431,15 +438,6 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 				(__START_KERNEL & PGDIR_MASK)));
 	BUILD_BUG_ON(__fix_to_virt(__end_of_fixed_addresses) <= MODULES_END);
 
-	if (check_la57_support()) {
-		__pgtable_l5_enabled	= 1;
-		pgdir_shift		= 48;
-		ptrs_per_p4d		= 512;
-		page_offset_base	= __PAGE_OFFSET_BASE_L5;
-		vmalloc_base		= __VMALLOC_BASE_L5;
-		vmemmap_base		= __VMEMMAP_BASE_L5;
-	}
-
 	cr4_init_shadow();
 
 	/* Kill off the identity-map trampoline */
-- 
2.43.2


