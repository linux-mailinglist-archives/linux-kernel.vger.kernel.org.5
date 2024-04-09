Return-Path: <linux-kernel+bounces-137611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF989E49B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01682841AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E615885F;
	Tue,  9 Apr 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="se/ttn4j"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF509370
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695348; cv=fail; b=g0hxThTsKkzR3ZMaCpEHex1U7hxkxbdEBUpJ/wnQ/qS51ApTr+rSCs6cb9QAxkZlo12256Kboq3ApAwbRk4WNNExVMM3xg4Mv/wJQH7lFAxjbvOzKG1xL8Q0DnFOoDi78zn4jecy0OXrVqVNfzjtagJz5XN0F0qBRlcirI8qtkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695348; c=relaxed/simple;
	bh=ckupJ1AEqIvoPYI+QZfDfhgy1lZJoEHpvrxtgu31qew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB0HCnqTBD967zlub53facVrI9AFeS9PGLFQ6HlqBU/U+FF1+jyTCq8dvpwtws7qYwsgHV+s8KhWNbbgv+zQWKl1tTMjchCvRIHCRBHVVwv3Lf2mvaPyFEdUcY3yTh7KZccJ0WFGkMy0OhdseJAtcDqKviW3bTp+9XPfUKZit8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=se/ttn4j; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWQrF3r/jIIBDXYzeYxJkU03XS6/EpUx0pIYX6CTTmD89GxkyuI+8sk2PaXycizBZoA8IJCoNcWMGJZcs/MXSvmB+e0OJina6ReFhKjesWyYRxbM3Foewv+mhKFb0fEhHu7ERhRkoOVFiAqGYiApcIp7N6pfrJuR5+ka/i9Sa1SbjfSjT0nTehT/AF0l2ac9C06/s7SQdMy1piBWpYjBhgqyLDLBe9XRncTQ9jlpdejFXJSg+BMNmenP1tOjwYJWvQ93ZszZGyOgVacG/NsfHPw+YwwWcvBAtEAGe6NDeHOzMdt6zcN1U+T2iDuzJdWxzkNYghDJo+oZ6Pac+filzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+VW4y73FrLHpfUH7m6j5ssx1LBS1HYrfuBzPx9FKGc=;
 b=PKahphnMtefMPdr0jkcLNeSqXMd+Y1s5iqrMRvyY2l9O94UAAGEXzPqexxs0B5wt5hwXxkp21QYXIgF7VKN0KiAIJNKpL50IKs4UyBqghghQC9xlN2ewALN7sOp7m/hoN8S4fogjVx2piNIJLqdpGDYyvEw2eDtPhiX7S7eorwld6itQz4CKwBpHQ0F4s6oIgfmkibfWfm9PAczjsaIH/djSoWiOS9uqOehIJfeClLFRr6AfldZpobViCAXkF1ZUW01XrIBffa126FWPSNAAFHavMEoK9LJymVTHCt1j6ilc/5BxWhJACp+h+sj56tcQItg9pItKll7IShxMEAhLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+VW4y73FrLHpfUH7m6j5ssx1LBS1HYrfuBzPx9FKGc=;
 b=se/ttn4ju7OMH1BiIV9Ao0ZkjB1c/UA/+Q7+QQ1IQoMZ2MhAH7UkQo+qAms0aQTlnoAe1oA6AEe1q7d9fI8vwu6zlOsICiTl/444iKze9GR/qMttIz4Nu/diyQBF6nNuBZv22iLXGnzvhT0gZh+YaFIni/FqIqa/1bom0OfeapQ=
Received: from DM6PR07CA0088.namprd07.prod.outlook.com (2603:10b6:5:337::21)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 20:42:23 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::c8) by DM6PR07CA0088.outlook.office365.com
 (2603:10b6:5:337::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 20:42:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:42:20 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:42:18 -0500
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
Subject: [PATCH v4 0/4] x86/snp: Add kexec support
Date: Tue, 9 Apr 2024 20:42:09 +0000
Message-ID: <cover.1712694667.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 96af7323-6e3f-4b0f-0041-08dc58d58d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sClr8Q5fnBHiNR5IX/a9YkScucPTX24toSdXq1oMyl22Uboniqp87fXZRAmJj3YqM6azxEFoIHZ8w2T1iWbZiEZhIfB/eBdd51oNJsF1foEsaTwOCnU7fkx4sZa1V29Tx7hoIDnLvMOL9OQEAWT/H3yrFNB9Q7Xyqf9dwCG1/aMCM7VS5UBAVJcY1d2R4nxhEm9pqwD6XCdEYn22J57M2bk5CJ0GVbIS9LpjCoRgGLGiSUK+nefvOzsg6HjoK5E+4Uq3Q9N7CT6ouV708zlMQ01JScD+qf3xo0tEj6HJ15jbPgK4a679TF/N6cUiFm4CGCFLVWXRo7O75W1oYFG73ZTa9A9yLt4z4+SwyMEnrpwJWFCJSF+QWRAcOFhl0MFGkFaXVv3l8o9xez/eB4lIAnIdPa3G9oigCLmFkGcP8VDK2ZJdaAAVUIyAcqlexkgCtAlZNBRjfKJkQ1M4J7+OajucsUSvssa41EDLcCtEwrfjWT4A14Czn537qVuH2L/TBOVDzYTA4KL5X6XU/ti4b/mYlw1FF8OlhPhyo8Go2m43tPNSoBMk3D/MiJ5Rr93jzFD3yrA8JlNJpTd9ixBUk8TqoYwV8ipjvH6K8CFb1y351JRh7OjnIWx49UBdm3JOG6lpbvDdvV6YUHCADqX1PPK4iIu33roWc0zM+7iOqiPhftasx7Q+o3E/0M0HbrggwKFHSQ8WM7auFHrSX3AFZtuNZo6mS4z6XGC1S7o+Rnqt4574F5CRy878orUYSYsD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:42:20.1700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96af7323-6e3f-4b0f-0041-08dc58d58d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

From: Ashish Kalra <ashish.kalra@amd.com>

The patchset adds bits and pieces to get kexec (and crashkernel) work on
SNP guest.

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

Ashish Kalra (4):
  efi/x86: skip efi_arch_mem_reserve() in case of kexec.
  x86/sev: add sev_es_enabled() function.
  x86/boot/compressed: Skip Video Memory access in Decompressor for
    SEV-ES/SNP.
  x86/snp: Convert shared memory back to private on kexec

 arch/x86/boot/compressed/misc.c |   6 +-
 arch/x86/boot/compressed/misc.h |   1 +
 arch/x86/boot/compressed/sev.c  |   5 +
 arch/x86/boot/compressed/sev.h  |   2 +
 arch/x86/include/asm/sev.h      |   4 +
 arch/x86/kernel/sev.c           | 161 ++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c   |   3 +
 arch/x86/platform/efi/quirks.c  |  20 +++-
 8 files changed, 198 insertions(+), 4 deletions(-)

-- 
2.34.1


