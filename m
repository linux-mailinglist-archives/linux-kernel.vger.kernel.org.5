Return-Path: <linux-kernel+bounces-146001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4598A5E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD441F21C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D5158DB0;
	Mon, 15 Apr 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gEpB6B4z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BE158873
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223382; cv=fail; b=YufONM9xD75e1M+lI3NT2t5ur6s+0dLj/bV9IBmkfuYd78qWOHYZrCu5JCMakf0/OLVezXfz1zVbmZ/eQqTicuRZcojMJ+u2D2D/BIs5cShUatgVimQAO2CBsJdr8boitkE0KxAEvyzDYNJYl2+vj5ISDXQbG81t1NBtyB+MF68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223382; c=relaxed/simple;
	bh=3T7UJd/jhdGDg6QAcfu8gPejahaWlotuy2u7LtEFFuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2P/VCIEcB8P/nykv/g+mS3phBNrAuSfBExNiYOpOSlQ2mOdbUu/lm9XwSd/lsA7zkDdzxe9w5it/jfF+ixJ8IRbe0QrjhgGwV4IbF54GCP1KihsQatQEqayobE1VGa0yK9YZ/MSQilGsoK4QB7uNrivPVeV9QTly9LHvgxCw4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gEpB6B4z; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mewVpyIRQtR5v3jb5ky84nPvDhmbAWvJJSzr9UjGpggpGBJQgwpP/0vYS0j7HO4g2rqr018sKEtaiP4YsWoLklJLt5eELxvcadxh2r35p6QSc+f42qtTOtXB+RqcSYAggvU0ro+mtfvypKGwZPq8s7davDLHWkXBooeDbfPXFEnlBYyAxqV3B2vZgSwl0gEkfR7fa6FDLzYyxPBBpBicu74WWxRwMH1wyGM74OFyA4bIURQvhj5Vn4duvFP4CKICznnGBeF/EMTgBCyWErpWkC2zSqSvt8tUSyJYiw5h3qLR3v7gRYrP1qciy34utqFGgvLTuzLKmPk74DIfbhWPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L6huhVwFLq9ESJTyvDjJ3vB606cwa1M0dY0RLKwSnw=;
 b=gMfeWjMOE3PoB89s0F1bwXGC/SLLVqa0hh6ySvA88SaF7cX6fExzLnG+5F0UbMI4N4bSJT2hA5C+T2lsv0F5TFlM7oPdnK2YFZpy8SssGptId1zamNyIqVau9eKMfaGFfPSNn0lYYTQj9EVHE3b46dndW/vrAxByxOpns1f4dWMvbflUtnGNjmIZvGquoeMv7kKVddpP85qEONNYeKZdKLzLNrvneQb0Fkp9lqynKNcmHWyF6BoGeprCDDP8wTxYPusr1fSbKUyPGcAuPCx1/odO3bEGk6gkHKOvhwQHfK8bXeLV1pcKIu/aWS6n+GHTR+uPKBOQwpAfrKGBHWh7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L6huhVwFLq9ESJTyvDjJ3vB606cwa1M0dY0RLKwSnw=;
 b=gEpB6B4z7L+ebrGn6qzjYTUsEuB7Mf3VY0E87Xzh4nrGg8Eetrh1RkdTUniTh2c8tYDFo0KiFqZIkJCJggeb5Pkyh5JkvElc3CzHrm+Knm5lOaqwNQ2AsMOLOKmeeU1LyoMjPX+8MwsHUKPPpRGDZHQjwCxSJEvm0KgzzFnKI4Y=
Received: from BL0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:2d::15)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:22:56 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2d:cafe::1e) by BL0PR03CA0002.outlook.office365.com
 (2603:10b6:208:2d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 23:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 23:22:54 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 18:22:53 -0500
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
Subject: [PATCH v5 0/3] x86/snp: Add kexec support
Date: Mon, 15 Apr 2024 23:22:44 +0000
Message-ID: <cover.1713222642.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8a1853-7f66-4566-e366-08dc5da2fa45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MxgOsBvp2fQwAJf1s59WblqEpUlRNFbF9VSwdn5UY61ARj/opJ+fvx5GsWtJHX0LfHaf2vucQJIS5o6Q2yidEOZAc+0YWVx1AfuaMA+bZcNtJCm7rtBwN8sTprDK2oXwhQ9QeBJ8PP3a6bPzbMUQwjXYZ4odAiA5kcPoOUrOJOYRS9vVs5D5LkqBlzrJjPt+pQXI/l12d6crOZw0XOfOEr6dQVUZtjBHYKGETxXGqFpMtX96/cCVkOJ7d1TnF/beVAbOzkYGTDlYklatsP5bVBDGrpbOe9TLFXtgJIV2YLvW6I1IV4+LzAY0y7Ne+GPlUD/tYXYb006tGvFgeNoRER1vBxYtKZqVQ8UXS+OY4omQ4IC1+T/gQ98xmKjjWZ/judPSLRmPnsqV0wCKQoLHMxvIR7b+G+zzYVZQTdtWICxxCRU8M9PWlRmGuOFG/4QTbeGBteTaT2eMitLnH5pvBUZDXlcvaX2tPq/e6JaAdyE/8rwViuCYFf6Ic78xI93z4AHIwPmdRZLtUlAcJjBTQu9c6Y20/nbfgBtaFT2uKu4smq193ZbFCvf0mpp0Yqs/DjEojk4wsSfYP7qoJY0pwV4KJPvdW2wX1unIU6dHDq8j0swCZzEt6UbmXSFPpTe7uCWPJwBBKIhAk+M8v4rfGzW9Yj+8C3KqSXgNA7sgc1/u+FNbDc8ULenf33H7CPREXQPXZ3ecgBiPj8Vmtxy7URRPCcmW/VJQqW9kTUnbP4pXsijZjr11FrDjFysm4kSx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:22:54.4268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8a1853-7f66-4566-e366-08dc5da2fa45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

The series is based off of and tested against Kirill Shutemov's tree:
  https://github.com/intel/tdx.git guest-kexec

----

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
  efi/x86: skip efi_arch_mem_reserve() in case of kexec.
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |   6 +-
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/kernel/sev.c           | 161 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c   |   3 +
 arch/x86/platform/efi/quirks.c  |  20 +++-
 5 files changed, 190 insertions(+), 4 deletions(-)


base-commit: a18b42d8997abfd77aa1637c0de6850b0c30b1fe
prerequisite-patch-id: bd8e77f0f12223d21cb2f35b77bfcbdd9ad80b0f
prerequisite-patch-id: bfe2fa046349978ac1825275eb205acecfbc22f3
prerequisite-patch-id: 5e60d292457c7cd98fd3e45c23127e9463b56a69
prerequisite-patch-id: 1f97d0a2edb7509dd58276f628d1a4bda62c154c
prerequisite-patch-id: 8db559385c44e8b6670d74196e8d83d2dfad2f40
prerequisite-patch-id: cbdfea1e50ecb3b4cee3a25a27df4d35bd95d532
prerequisite-patch-id: 1cea0996e0dc3bb9f0059c927c405ca31003791e
prerequisite-patch-id: 469a0a3c78b0eca82527cd85e2205fb8fb89d645
prerequisite-patch-id: 2974ef211db5253d9782018e352d2a6ff0b0ef54
prerequisite-patch-id: 2cfffd80947941892421dae99b7fa0f9f9715884
prerequisite-patch-id: 466c2cb9f0a107bbd1dbd8526f4eff2bdb55f1ce
prerequisite-patch-id: d4966ae63e86d24b0bf578da4dae871cd9002b12
prerequisite-patch-id: fccde6f1fa385b5af0195f81fcb95acd71822428
prerequisite-patch-id: 16048ee15e392b0b9217b8923939b0059311abd2
prerequisite-patch-id: 5c9ae9aa294f72f63ae2c3551507dfbd92525803
prerequisite-patch-id: 758bdb686290c018cbd5b7d005354019f9d15248
prerequisite-patch-id: 4125b799fc9577b1a46427e45618fa0174f7a4b3
prerequisite-patch-id: 60760e0c98ab7ccd2ca22ae3e9f20ff5a94c6e91
-- 
2.34.1


