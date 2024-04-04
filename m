Return-Path: <linux-kernel+bounces-132239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E38991E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4661C218AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455413C3CA;
	Thu,  4 Apr 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXHRPt+a"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FA0548FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272263; cv=fail; b=gkIs2GY6jtITtw0vmEVLzjeJIAfdvK27tYkWTbYhBGkGAlk1v/tWBUgU0KNjmJZ1K1v7VsrR7QAjBPlcc7oNQY0qtCCIiopDaSV0otlq3DNROCxNUbznMrlVBi9yEaxZST7yX5bcjDGn10fp0/Hr5Z/dVNborwak9pM5hztnXNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272263; c=relaxed/simple;
	bh=rGI6suv1zb3pghnNnhgwDeVGs1uApVMNK7SEi4zhazw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qM5zfnN6fvmm4wStL2Ixv2eE2Icr5Ze3oMslOHpOLViq1sktqte8YMwQoEMqy3bEG0ykGJn4U2IJYtQKzA6bL5MHOXOBiUGdTNkNzN4Ub7rY8Kmj0g+plEHsWA4y4T4iWPYApoaaQY3b0S5pZM9+RdGVUUrI37GnW449uh4BsS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXHRPt+a; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Afk71wvaCFR/u9BAYhtZ5DnoS+I4gYMiR14qVcU2DeLjObn7SHLxKJ2WZ6vlA+SyPRZAh7F/PGZxjBaA1I6LwkuoaRY5ANVblqNCVw9ncrk0lAGldBPpYuaK2yjV51hcoqFWaObMXf0eYaFU287Mn6HF3n/C55U0gM+nmGwx7dN6/7C5qKrEwwSXZL1OBlJKGq1RBzJ2GnDUSdC9dila2xFFHhZYoBMxHb8JKH21MKaYKmvsdKWf2ch0iMtlNAUG6bqAStmAOkp95kGpsgof1JUrPkQ+JEK+ASsJMJs5VD7hb1/ziAJ5Ee3iG7Mj0OFcHOkANN4A2v4JTN7/HTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVq+BbTvSa9uQfUgAEa9Xcp3cLWYcOfNUqEKQXfN6Og=;
 b=H7W8CiDDswrFkHrV0HoO3a2WyWkyQg+H3+HvH1W+zO0k9Q6LuHqyy/H6SiqdPWmI18uDpnTOM1GUpR2IXTvaQfimFjDZtrnCXoc4sw7WOfUdfzIEQiDuqJLS1pwBXH5CrxomaiB8H0dmkLWu1uYlLgiLmgow2SZ9N2Mknhu9r6XdytSgEdZexzK41YHo+XAQW2haOPzRrrC6FmdBPncV10hnxinJEoRX7y6NmrhnpYmt4VUhUekhylQOG9jzyUlJ6jL8CEcJUmq8TKIASyAogjiPtvZLrcIlP3vQld5k3mLSgxuFhJ7Zy6YNjKQAXpMa7jVfqlEeSxgs2Zq4VbnLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVq+BbTvSa9uQfUgAEa9Xcp3cLWYcOfNUqEKQXfN6Og=;
 b=wXHRPt+a6Kq9aMQnfX1UutdPFbJ9+PDdv+6GJwopcVC6SCkcgip6a66PMhooFBkZ2axUzvhZgBPHKLUOzmf4EBA7aPEziQ9cy6b5aDFwtdfNSoEngEME2G2PsJzk2txgM9AaURXw2LOXo6F3bGpkcs3S/pQjLPetm4SAWn1+bZA=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 23:10:58 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::f2) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 23:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:10:57 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:10:56 -0500
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
Subject: [PATCH v3 0/4] x86/snp: Add kexec support
Date: Thu, 4 Apr 2024 23:10:46 +0000
Message-ID: <cover.1712270975.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 10252303-d06b-4a28-bcdd-08dc54fc7ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4yrmlkBXjs5tFp010L1DHXgEBbDrbt8SflCuQzY3YTgnAtM1r76mBgbtl/DY8XEF/+U7T7C1weYJ8HV2pBIQMK9NoVbBx2Dr8f4DhoH0NaE2LuN8kqyrjhXWabvsBQhjzU3xSRrxW8tP3cam1g5ILhQ+lpKujHYAusTRIUi1Ic4fRG0+qQTjVnMvcEEMZ88dAS3FippuAIEBFvDV8WPZK7WBR6AKaXf5SFOVwck4T5eDKD3J26V4HAklW6g54AFgc2372gvL5vYEjvTj6iKMQJE1ccro9JInOJV8vlR8ekdbsGXmjO/GebiHcCtbC41Sxj9fxt7ezmXg+3/83Gx/5SiI44bj3LRP057MWwuzmCU/aDL0QEptCcHDc3dXQAgzDJsZgaCsRwVYKhGtphigFt1gP/PNNJIxRUBEB5iG2rSQ/tK+jKWfdpisluW9rUQvmVNt0zg9s++7+qNXWJpR2/mpqfD493FboGAbn/XAatqkhS6OJorvsOjv7GCXPUv6FDqTfspH/4KaWeGHFqLjKbkiUwI/O0/lcd9NDbGxoMELazsIw/Y57WXcaNdP83c6L5ERHi7VKum0kYdaDVvdBgY3xZ3JkxKRBC2FvmpDCFksrvj7opQmEVKvhhcVF5yjrWSiTaiRsciNl1smZo5EPPzF1dKASMkRGkeOpFyMqAT1lJD0aM7yIDQAKogM3hqG6GkEBsPKUx9VHjAwgC83sauNlebvDIIAg40BKa4vzvDbNxFbw72aKEk3FyTeU5Qg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:10:57.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10252303-d06b-4a28-bcdd-08dc54fc7ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

v3:
- Rebased;
- moved Keep page tables that maps E820_TYPE_ACPI patch to Kirill's tdx
  guest kexec patch series.
- checking the md attribute instead of checking the efi_setup for
  detecting if running under kexec kernel.
- added new sev_es_enabled() function.
- skip video memory access in decompressor for SEV-ES/SNP systems to 
  prevent guest termination as boot stage2 #VC handler does not handle
  MMIO.

v2:
- address zeroing of unaccepted memory table mappings at all page table levels
  adding phys_pte_init(), phys_pud_init() and phys_p4d_init().
- include skip efi_arch_mem_reserve() in case of kexec as part of this 
  patch set.
- rename last_address_shd_kexec to a more appropriate 
  kexec_last_address_to_make_private.
- remove duplicate code shared with TDX and use common interfaces
  defined for SNP and TDX for kexec/kdump.
- remove set_pte_enc() dependency on pg_level_to_pfn() and make the 
  function simpler.
- rename unshare_pte() to make_pte_private().
- clarify and make the comment for using kexec_last_address_to_make_private  
  more understandable.
- general cleanup. 

Ashish Kalra (4):
  efi/x86: skip efi_arch_mem_reserve() in case of kexec.
  x86/sev: add sev_es_enabled() function.
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c   |   6 +-
 arch/x86/boot/compressed/misc.h   |   1 +
 arch/x86/boot/compressed/sev.c    |   5 +
 arch/x86/boot/compressed/sev.h    |   2 +
 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 169 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c     |   3 +
 arch/x86/platform/efi/quirks.c    |  23 +++-
 10 files changed, 225 insertions(+), 5 deletions(-)

-- 
2.34.1


