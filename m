Return-Path: <linux-kernel+bounces-160384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895508B3CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC9B1C2287A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E514882D;
	Fri, 26 Apr 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dTfWu4vR"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103D8248D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149219; cv=fail; b=bmGzA5kmQEzYcf+wXibWVZ1wdEhqLm5tTeQUUWqxk+7FF6sqeV6Sub+6qNDAo8WJAIcIMxMNPCpeC2o4ySPTrWszZwA1xf2E8gY+diKVHHuQim5W8oFqGKj4PIkAIUuA9MqGq/3XCKYkctFmBZtbWqXvMc5rvssjdvz9j6VDCGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149219; c=relaxed/simple;
	bh=Niw/jHooIqbsJDJFwROPAO78org09TEd85LMOPPvbLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtxYgz1lbevqnuHiCeAnILfH+iQbyeH7Aed1BtcX6QhknBemcSUxwODYNAeggxPGmJ7BwtuPziFhDrMD7FumnlIcnZRpTCQM4sDma8LpjDSXMINvaSyRdFKhPYlezDJ4xjBKby9N5+dX5H8d/jk7jdoY/6i0o0tVehi5X6dtkvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dTfWu4vR; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEcuiPSP2kBNYu8YUWPR9LqnjrFeSBtG9SAaYqCbXlystrFQps1JuFGkyFUMXZ/se7wmq/tqrO7FlcxTKvOqe/kK+XSV7NfoIealVGLdrUiG9/WkEn6rI7wMK/8Ca9F7+U2u5Wrg74WaafP8TklZ5KzTx45xvmQ52lZr/iHXDTWFLPQun5ajiPqylhdzOx2pTHrvKFgr0mVz91QJdKunjwuT9vlTcWeqIxJK4W7jWe5RxX34+YYFYZsnuamMatlO5CPXRhIzI8jRTsRJOFCF9SPgSYdqKz8sDeFaZyBSU12ytOfALfE5ywi4EUApPLtxyuPSGEMNfSWaCyBxqIbJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol7pGgliA8ta2AbBYmeUvfqc9+XKPto8ki+sNU9vfUM=;
 b=IywTlRlVKOsL/2ggtlMVBma4Wg1l5x52/GHmBclfhYGXJHGG1UmUtYoM1BApjRwj4nqiZhgpth6xBghKcmNja/6/Jkw+CMWmZsadCSJIfqp24L8SD6waDRbyUVLMxtAknirhzsCGLVn3QT8C17ebX/l84Y2fwTaaR0sf+hmmWeoOhC0GjnGzKX0HotYwctqaqBTvhBmMC8LXRBbeQkEMS21hS5r1qH++Xa+06FdhE/eezDWsMHH8IfIB9dY7gvQyLuZuC5j9V44/PDUt72YEA56vtkgfI3hTjetIsvPz8syEnD/ZE5/Dx54Kb2p+zaB0OXVcQsnhNeMpoQqZuRStzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol7pGgliA8ta2AbBYmeUvfqc9+XKPto8ki+sNU9vfUM=;
 b=dTfWu4vRMK5ejSBCb3ta+U1GdyRPBOsOxPzzPJmxG9Wm9AzWlMuGTD99JQXp8Va3/Pj1fOn9fWe4QMyeVt8x4nbKyYl+6L1jHxyY1ZLWLPJkicw1MPfmu+iVJWpJ2aOCmFj/CeybxLGrNvXRjKLwAnTio3tmeOiyyi1xxn/h2T0=
Received: from BL0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:2d::24)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 16:33:26 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2d:cafe::15) by BL0PR03CA0011.outlook.office365.com
 (2603:10b6:208:2d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 16:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 16:33:26 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 11:33:22 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/3] x86/snp: Add kexec support
Date: Fri, 26 Apr 2024 16:33:11 +0000
Message-ID: <cover.1714148366.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f085a0-3b69-4a88-f294-08dc660e990e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|36860700004|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEuw7jweDg41Q8fdOPufZa7iaspb55YZZbSY9PzQWUqz6v61o1OxKHDRHWuv?=
 =?us-ascii?Q?6VOKGXeQE+3FW17vl2gZCn7e5Xk2DiBJ2xLYomMy50vaLJ377RrfrIn8Pzm9?=
 =?us-ascii?Q?Ss47mxAnehUHzIang/mv2sjlPSMduZ5MzPA1yxdRWTFyLs5co+LpBB6SlQgA?=
 =?us-ascii?Q?6nOv5kBDDLrx2uwIKU41lpdVdQY/dETVmxcbByFXPRjaADTt9IKYNKFvtqxQ?=
 =?us-ascii?Q?TOHPstIhGoQaQ6++8/vFiCewKVzKIqH3gKzUqI1kUyUO4qUozisPpr1lyxxg?=
 =?us-ascii?Q?Utqx2o2UBKZpGE+jC1ruICCZYhFm5e01M4zNdDk3/JGcnvdj4XzFixrGByBF?=
 =?us-ascii?Q?epx0o8+m7ZN5TcPdPaXgkIz5qCgF3i0U+squ52t0o9bk1HIrwuFs/oc1BvLg?=
 =?us-ascii?Q?A+3rCgjwvincWl6jQk+TV0EvLqehD3YjdW2yKHgEeLGY5vK+qFqo1R2CaTnf?=
 =?us-ascii?Q?B3xwIG0E2HQBYUlEsZRLM1+WQZNoJ0er1p7rUvzQa7px7GEObvtIHmfk18ry?=
 =?us-ascii?Q?BYJ5aSkrfSklTGZxDfr0Fo5fezVeYtHjjmYp2TrYcL1ZPg+/06XM+tj8U372?=
 =?us-ascii?Q?Nd/OfPKo3pnXKrHQ+L0kDZetjAsQGCCLVdXzsZp+UNCRkGt5NNPXguy988zp?=
 =?us-ascii?Q?CriBYe3yK6cM5AiIue7OadTmKjfY76UPuAUM+cI+l5n9HCg+97ckA6Hm+QID?=
 =?us-ascii?Q?GHo8lszfvViPS8YNO4MhCs0IK3m3ps9TbssIQzhxBud0vkkBxDDtsK2/qOIr?=
 =?us-ascii?Q?lsB46oP1oSs1zWH0/+8L80/oIpHQR5TBAVa3WJC8JbsOTCtoVGOMXYovsYG8?=
 =?us-ascii?Q?N6/sfrrRPwbm0OZabVz4t6bl8P7S+UzGA0ZVV6dS8Yp/Y+I9MWgz0wMO0RqB?=
 =?us-ascii?Q?ZjuK5nC2uJu7cpJD//B0bIZPy5qZdiD1OleIABZ0jUVLgJoufJonnmiJ4ApU?=
 =?us-ascii?Q?2UHFKiBwKocnF8OrkjmT3TCd81YMWsAx2XjEgKxvue1hIsAhktSW2SYFMMNh?=
 =?us-ascii?Q?tnmaSEzqwIPpd1JT2LsuJURVMWJ0Ie6FIwMpaNNQDuaUxkdtQWozlzDMMTy3?=
 =?us-ascii?Q?f12pHZ9aM4JaVbnKaHoTY76rGFzTCT+7afhus+DAb7Ks0zzPNj60YGwgllGF?=
 =?us-ascii?Q?BxMltmhxjlcPTx4JHyY61oUpjHx01nDjilVaDj7+E0Ea0TUgFdZQW3vPCcdU?=
 =?us-ascii?Q?gjTwC63KTOM+qOlA4Tqjh5txG58ajvALFjCLkUM0QyekpYz0l6xGU2137FFY?=
 =?us-ascii?Q?qZaQWWLT77Ialg/yQqCwgKhkPBUF2KBSXM60lNebMX9F/P9PRDLw1Oa/ZDm2?=
 =?us-ascii?Q?0LFJ5iKO8Wr0oSabPWKIya34F+gODeZpfc6HWEKt+PVUOeIbhR8ZQbZoLv42?=
 =?us-ascii?Q?+PISA6iyBKckCNb68E8+ek1bx9xy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:33:26.1986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f085a0-3b69-4a88-f294-08dc660e990e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-kexec

----

v6:
- Updated and restructured the commit message for patch 1/3 to
  explain the issue in detail.
- Updated inline comments in patch 1/3 to explain the issue in 
  detail.
- Moved back to checking efi_setup for detecting if running
  under kexec kernel.

v5:
- Removed sev_es_enabled() function and using sev_status directly to
  check for SEV-ES/SEV-SNP guest.
- used --base option to generate patches to specify Kirill's TDX guest
  kexec patches as prerequisite patches to fix kernel test robot
  build errors.

v4:
- Rebased to current tip/master.
- Reviewed-bys from Sathya.
- Remove snp_kexec_unprep_rom_memory() as it is not needed any more as 
  SEV-SNP code is not validating the ROM range in probe_roms() anymore.
- Fix kernel test robot build error/warnings.

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


Ashish Kalra (3):
  efi/x86: Fix EFI memory map corruption with kexec
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |   6 +-
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/kernel/sev.c           | 161 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c   |   3 +
 arch/x86/platform/efi/quirks.c  |  20 ++++
 5 files changed, 192 insertions(+), 2 deletions(-)


base-commit: 7fcd76de8a7bc12e930ef383a157ce99d711715d
prerequisite-patch-id: a911f230c2524bd791c47f62f17f0a93cbf726b6
prerequisite-patch-id: bfe2fa046349978ac1825275eb205acecfbc22f3
prerequisite-patch-id: 5e60d292457c7cd98fd3e45c23127e9463b56a69
prerequisite-patch-id: 1f97d0a2edb7509dd58276f628d1a4bda62c154c
prerequisite-patch-id: cbc2507b5c2810c3015aaf836d774d32f969c19a
prerequisite-patch-id: cbdfea1e50ecb3b4cee3a25a27df4d35bd95d532
prerequisite-patch-id: 99382c42348b9a076ba930eca0dfc9d000ec951d
prerequisite-patch-id: 469a0a3c78b0eca82527cd85e2205fb8fb89d645
prerequisite-patch-id: 2974ef211db5253d9782018e352d2a6ff0b0ef54
prerequisite-patch-id: 2cfffd80947941892421dae99b7fa0f9f9715884
prerequisite-patch-id: 466c2cb9f0a107bbd1dbd8526f4eff2bdb55f1ce
prerequisite-patch-id: d4966ae63e86d24b0bf578da4dae871cd9002b12
prerequisite-patch-id: fccde6f1fa385b5af0195f81fcb95acd71822428
prerequisite-patch-id: 16048ee15e392b0b9217b8923939b0059311abd2
prerequisite-patch-id: 5c9ae9aa294f72f63ae2c3551507dfbd92525803
prerequisite-patch-id: 758bdb686290c018cbd5b7d005354019f9d15248
prerequisite-patch-id: c85fd0bb6d183a40da73720eaa607481b1d51daf
prerequisite-patch-id: 60760e0c98ab7ccd2ca22ae3e9f20ff5a94c6e91
-- 
2.34.1


