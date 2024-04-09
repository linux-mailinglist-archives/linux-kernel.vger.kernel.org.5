Return-Path: <linux-kernel+bounces-137613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8289E49D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541AFB22975
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7515885E;
	Tue,  9 Apr 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v6hqMewF"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8B158209
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695395; cv=fail; b=d7A52Uq/xRqtt56hvMGzCaBkcyLoKbqY7kRvHOofdihqrYTHwwtqOPah8iVl+FLb7iDjtbbxANfxiQn2I88D5p8HN0O/dbC9JZCRIX2E0aj38aZ6AxT3rfA69oQKU5RKRdLP0nRox6G6Ch+kRA2R9mUdeF0LTqmxgKHJjNNe3Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695395; c=relaxed/simple;
	bh=gmEjNqnBZ+m031/5e1nPfs0DGk2kdd+4KO5faRtrh/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjAf1IuSeBnVj1USHg3/WA2rHpW4U0niw6VdNVxLDyKOY7I0EBuwd3qJ6+lmSIr0zMRIUHVYk62DHCvPoiREaEHUPyPyZxrEU0crcSjQdFFxRAtTBkdK4oxAyU5IJ6E4Ehl1hNZn1z62gtGaQuwbaIZQab29u2YOj2D70wZBW0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v6hqMewF; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVcm6RzzgXiV+lGFsfVr1he6JxMxCMAFqheXPukAYOzdF+1sEk6NRlOyY++Ub9tZ0XKCK/436rrseZjArH5m7O4rIgGH6F2mSklsRQmUsT4YzAnYmATO6ypzD09gxGz4jujzTOT+eLY4KqOCE5XpAV+l+y1b2kdXBFWtFoK2wLAHJRqEJKlHwg8KSvL1BseoVCigUuRb87inoKeTnn0MDTrUp5xLM9jQeWhwmyl8a++jb411CVd7AdKU5uS22Kj1igXLFKdd6pNcJIHYOgREykgyZJPy1NCK6KGxQeIu7ByTR+98uNHBh0LoieorsNziB9jRn5Yc2FLYPWuCZVuZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=cMjFjvt7C+HQH1lBQRjzEe4EYkeqKS7mdB8mFnUYluxbVzT08Oo6BAcogThnXH5vDyjPi+J3b9hynVP7iBB05MCqTiqXawnQVZ+BR4+f4dkMMwQ9yNLJyMjPqNllUF4pdO/LGKoew3dyT1SUrt3N541bOoVsfF7muIRLIvc3Dq2KEUIU7EVdXwaDKxbMEM6xGY984UCXj/RJAW0/bbQTslKC2dtkUnRvHmMSLuX62VdhB8CukYZ0r2vGjNqF229RfIYSJ1CdOAGrnzcjfzY+yTNRSZTDerzovgjAvgbVyTtLOuI4A+DH/DlbvshGEt9kOuzbylhX+uNun4p4W6Hxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PELSJenkUMgeqWvNCdjkpMx5JK7Rlf/5sCsFjgBJcM4=;
 b=v6hqMewF4eC+ivP/XQpmSE8MlQGz6rIi6V+5WLoPMqTz8PB2nS/PoZjdL5g42IWP0kx18vu7a//J1XiuNSkTerq9EeOu+4SNqsLkjo9TdgQgHah3ZrQcgZ11s0xbRkIa1bTdgEhWLkpdZUzWbI9KSi56YOikmFRPzFeKbfbzEjk=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 20:43:09 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::14) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 20:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:42:34 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:42:32 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/4] efi/x86: skip efi_arch_mem_reserve() in case of kexec.
Date: Tue, 9 Apr 2024 20:42:23 +0000
Message-ID: <e399107dbe1b13db3af7ab702400a5dfe0a1e9a3.1712694667.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com> <cover.1712694667.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 964e84c9-ceed-4950-14de-08dc58d595ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9lqH2+4EuCAEa4DORRaHa026UEHf+f4V3Y0BC2wEY/Iw7WOLRck9/H2qhgT7291FStdMER0UyFSdXEd1UrsWoVwlIHUcfgRb/z4t43g2HRJ/Pe1PMFOxukjL4RBxkZ82TdxDW08mNQtXNnAxp41O/xRAC3GzJZCpDC+PUMeXXC8xyiqee7SNehjJ/IdWMXfNf6D0JUDJTy203SJ+8iBvyUN+PpV9fRYwC45hkFB8siKZt1XL+V+pyvdY4wMaRwH2n5VGJDM+btBcY0qF/ieKQz8WWm3Ui/xhdW/fQ26CJMYqLONmiS5cmjusfb3/JmhPCFHGHx6AYw/KcumjjgI8H5Cc8BidsPjHyTWF0S8ofGM5nXCinb9hC1klxZKDilknA0bwtPphkv6Nv9YsGHcor6dEEztlErEiOAwy3DUixOAe6uTPwQP3TpjzwXMa0qdfT4Se49jy6A662GLyLL+uvUnYAd+pksGEhUfydmVVV5eEIhzkF/6BG6WyxNH+xZAWDX0qCNkUecNbNYrLMsreeAQtodJHXIy4VTHiIPXmbX+88gwb6SFeIrB1pdHy4rLpYCTLGcm5mT3WJS2s5WiIZJYJ2lS3MFtRrkl4Uy8BwfJGzR+vg578N3RkCdT1cIQBCP+BF63QcVkR4oNAuLUTMyFSeOPxNd0iInRka1LYzGppMj7ZN7nnpv0r8ywT9MXx+VBfgb1CHAOxyRACgLL0iTxUQ+gLRntZPJa1neS0qFTxqL7iIEa6Lr8gK8s7FyDS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:42:34.2325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e84c9-ceed-4950-14de-08dc58d595ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

From: Ashish Kalra <ashish.kalra@amd.com>

For kexec use case, need to use and stick to the EFI memmap passed
from the first kernel via boot-params/setup data, hence,
skip efi_arch_mem_reserve() during kexec.

Additionally during SNP guest kexec testing discovered that EFI memmap
is corrupted during chained kexec. kexec_enter_virtual_mode() during
late init will remap the efi_memmap physical pages allocated in
efi_arch_mem_reserve() via memblock & then subsequently cause random
EFI memmap corruption once memblock is freed/teared-down.

Suggested-by: Dave Young <dyoung@redhat.com>
[Dave Young: checking the md attribute instead of checking the efi_setup]
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..982f5e50a4b3 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -258,12 +258,28 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	int num_entries;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	/*
+	 * For kexec use case, we need to use the EFI memmap passed from the first
+	 * kernel via setup data, so we need to skip this.
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memboot & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 */
+
+	if (efi_mem_desc_lookup(addr, &md)) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;
-- 
2.34.1


