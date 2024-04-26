Return-Path: <linux-kernel+bounces-160387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851468B3CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4B91F22F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D6143889;
	Fri, 26 Apr 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G6myba9X"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE82230C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149347; cv=fail; b=CaV4cGjmXzANIsAE2We23pg9PqWJahO+vmA/eQBPyToSP1Vdc2j4WmwEKDtJ2sGCj1LdFeaSSbfLDheG2S0XfD79jFOchS71ZgAJohU/pXJDwQHzh47pc7p/ckSL9ad14n5O16LJv6wdZFZVhggOaUdkC1XvE4yWhXXhYNvoCbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149347; c=relaxed/simple;
	bh=HjbyeEWVR+iLQgayYETXWRgclt/8PmcXMc2I08W0xCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Faw25+34f15NfC4lGP4FuigaCk2q0DSYA1wDTWWVlh/B2bVhn0rWf2mtt0ETfDFGq5tDDqe+QNib2GA6EJs5dZB9AOd/Mlji8TtMbDSbP5S0n5zVTsU56yemLhRvvnOooVxNWJ5RWJkeVL+JF1n5wufKLeMVCvEUNHDwtpZXhBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G6myba9X; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1Wro/x8ezP1EG9QUJAetbHj6Tmi502CNIEkYD3UsNy5qPJSa3V1p0C9IL5FZVS+XS49G+9qY4pn6Wv2bcnuMy7PZ1BABjgFFCOK6KADFsOyh7bpEe2MCoduepmTdTsX0KNus4VJjZJRPb/p0t1bO+qJWfn48h6db57xJY7AA0aaYJLeAgvLWTdd5EyoZeHispIfv3cdw9mHr5HIyar3FYD/YjVhn9jI0uRVnOPIdjefl08mkJ0BrLOtCZXSHgHXqqNeGDHGBfYUTfR9d8dsD3aKSgHaBC8AUum1TMKzaDyknEAz0sjALNWBUVqzAjiN6ncJzsgwypqKfdS0iNCgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGjacbaSG0E4Xrc1HaZgxSpSaWSCfPXy//14N/+XCX8=;
 b=la9rU3uCP1BdFCdNuKSCNK+W2zJP0wUHNdG5pLl5gIGkWQD+4pMCdDbPaIUz3Va0/LGd8Q+SYT5oua9txhN4kgwjh9N1Sky91TPdbTp2zOJQyFgjaZJtEcl/LmF/4pg1qyzpHGZ4z72Kq5wSgJk85ZyiXbZJVp5aE4BRlZt+u3E/OesMHodEBQ7oQ97TA7fj+uXbSJjHLhfFCorVJllmLqWA3zfI62rCubhReEBOFMiav17wiwrrQvhLIKABWuSyBODo9Iy16sOADQDyr2e3TnuLblzWYqCF6O38Pdgqa/J4LSCt17fyj5jCWUsusdrpLlDhd2y9zPAQijv5zulKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGjacbaSG0E4Xrc1HaZgxSpSaWSCfPXy//14N/+XCX8=;
 b=G6myba9XYjR47YJTmSZyUu4UNdt1BShhdWQpVkduJfb7zryDE4lW7w09U5DeMRSW5Q6g5e5jacQKgJaVQLSr1dC87rLQtzVO3jkm1A0MzggBR7wtvJyYSKYFKF2zsRUR34oTwgr8/+kVqef6jyzDfHVR9yGoiq+DMlgQF++AfaA=
Received: from BLAPR03CA0148.namprd03.prod.outlook.com (2603:10b6:208:32e::33)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 16:35:42 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::bf) by BLAPR03CA0148.outlook.office365.com
 (2603:10b6:208:32e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Fri, 26 Apr 2024 16:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 16:35:41 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 11:35:35 -0500
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
Subject: [PATCH v6 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Fri, 26 Apr 2024 16:35:17 +0000
Message-ID: <c24516a4636a36d57186ea90ae26495b3c1cfb8b.1714148366.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714148366.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1714148366.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fd2dd6-5f05-4eb1-9c79-08dc660ee9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|82310400014|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JqZmv55s7cWBXtg8cbYKHStZ4T+usyqYdzDzoM9maLrfoO2AfrCfoOiPqTv2?=
 =?us-ascii?Q?CpOkIiDl2p/xVV21+ioIN3eWtfbQkBczEgJYp1D0ILY0eWrUvZw2cNN8D+DX?=
 =?us-ascii?Q?qtyGlcHflmLFDpRU2dOt6PP6fRqdI8W4v6sKFjWSFG8vKaJYNDkk99yvjIMC?=
 =?us-ascii?Q?t/gp182cqQHJ8myWudoMOpJR84nCaxAYBhxUECWtf7k7WCZxXCHMfDaCdSku?=
 =?us-ascii?Q?9lSrsjYysREY0vd77cmm88d5mVjGQWuOiqW9ram05sHEIkUzlhBnJh2+Swep?=
 =?us-ascii?Q?SYqbbv6CSNcS/lSQFm/H9yd7syvEPH0B/2N1Xs+az4q8dIACdB3BIvuWT2Xg?=
 =?us-ascii?Q?GYsS9MGk3m6Z9ETsKVmFDGPxc4n+Do7BbWCF5qZasj9p3FSDMCZMf9JDDTwb?=
 =?us-ascii?Q?AlibKhLjvGZhPXcS9VMFCyESlsID9SNVtMOWNIo84ab6+G1+YxKoN0jFuzxe?=
 =?us-ascii?Q?5hXdMaaCXSOzUppXsksFKT54ylgCf2TW9cWXJ/tQF90u1jU0O8RcDcbtIOZs?=
 =?us-ascii?Q?qVi8KJ3+8ZboL46oC0qMY/9X+HOKw4JxunShWdp6WQZl1RwPDUAxE74mNen7?=
 =?us-ascii?Q?hObjeSYmHCadPLGyoObxfpk+x/XYSyVuabUK96QXXIegfM9m6BQ43h5HQ8tz?=
 =?us-ascii?Q?44frAB43JihQ6NQ/WsTLri1u26WuKKgYwYSOFex7IN34pNqUITgJ0JzXKzbO?=
 =?us-ascii?Q?MOExS5J+Zr3Hbeqst6bvaKcx+jpvCTLV22rQtxclTY1Xrw8Buysu1+jQgwSX?=
 =?us-ascii?Q?OuPXi8nwRmWP0mGNAwtcrkJ44vXLyShmLoCxEqG6R5vhFgfIGbrmi1Ozvmvn?=
 =?us-ascii?Q?m0mIxTQY9XkqK1DpxSUX1hivXr4exJd0AjU2ttreCDAsxcYXZzMgfKMMcOMk?=
 =?us-ascii?Q?fBHTd5kx9/MFHDc7XWqplSkgI9JtWmHpUtS0ieVy4NY/cbOqZ+H361idI/vl?=
 =?us-ascii?Q?UF+xsLZ46AsTdwdlntTX+MUlBB0TVLdK28mavF+vQcWURr1ihcCLfT2uhR55?=
 =?us-ascii?Q?xIKoogmUJVmU0WLIWXqdc3ReQdzA78OEXMuq8noQHNdSzJDnPKZNE8wG/w3z?=
 =?us-ascii?Q?Z4kUdvRSyj8twlPXEzI6jiaYXR+nuovAsQzltoriaMibprFZztTVdDuNhgVf?=
 =?us-ascii?Q?Ogc7WjP89oCGo3ssoiDVErxjtDVYH/ZJ+bfFuUvl9mgM4nzN1OXrFxxR2zLy?=
 =?us-ascii?Q?TXDIOX8njobrvspa4iSNCJPmX95JKwSTIq/qpZc8SwfjYxi8eToMSQyzopvQ?=
 =?us-ascii?Q?RwHByd/D+v65dIzssI7DpQVHB7Oiq7nqhjwQLCadHMAq/BNUKny509gRIByb?=
 =?us-ascii?Q?TsO29dYYv+BCpvTjraTD4o9yfIe7i1dahBk+CKUfkKqr2bKSzGr8+uW0XxG1?=
 =?us-ascii?Q?ezTQEZo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:35:41.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fd2dd6-5f05-4eb1-9c79-08dc660ee9cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

From: Ashish Kalra <ashish.kalra@amd.com>

SNP guests allocate shared buffers to perform I/O. It is done by
allocating pages normally from the buddy allocator and converting them
to shared with set_memory_decrypted().

The second kernel has no idea what memory is converted this way. It only
sees E820_TYPE_RAM.

Accessing shared memory via private mapping will cause unrecoverable RMP
page-faults.

On kexec walk direct mapping and convert all shared memory back to
private. It makes all RAM private again and second kernel may use it
normally. Additionally for SNP guests convert all bss decrypted section
pages back to private and switch back ROM regions to shared so that
their revalidation does not fail during kexec kernel boot.

The conversion occurs in two steps: stopping new conversions and
unsharing all memory. In the case of normal kexec, the stopping of
conversions takes place while scheduling is still functioning. This
allows for waiting until any ongoing conversions are finished. The
second step is carried out when all CPUs except one are inactive and
interrupts are disabled. This prevents any conflicts with code that may
access shared memory.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h    |   4 +
 arch/x86/kernel/sev.c         | 161 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c |   3 +
 3 files changed, 168 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382afee4..78d40d08d201 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,8 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void sev_show_status(void);
+void snp_kexec_unshare_mem(void);
+void snp_kexec_stop_conversion(bool crash);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +260,8 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void sev_show_status(void) { }
+static inline void snp_kexec_unshare_mem(void) { }
+static inline void snp_kexec_stop_conversion(bool crash) { }
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 995f94467101..891257fde810 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -42,6 +42,8 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -92,6 +94,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Last address to be switched to private during kexec */
+static unsigned long kexec_last_addr_to_make_private;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -913,6 +918,162 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
+static bool set_pte_enc(pte_t *kpte, int level, void *va)
+{
+	pte_t new_pte;
+
+	if (pte_none(*kpte))
+		return false;
+
+	/*
+	 * Change the physical page attribute from C=0 to C=1. Flush the
+	 * caches to ensure that data gets accessed with the correct C-bit.
+	 */
+	if (pte_present(*kpte))
+		clflush_cache_range(va, page_level_size(level));
+
+	new_pte = __pte(cc_mkenc(pte_val(*kpte)));
+	set_pte_atomic(kpte, new_pte);
+
+	return true;
+}
+
+static bool make_pte_private(pte_t *pte, unsigned long addr, int pages, int level)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	/* Check for GHCB for being part of a PMD range. */
+	if ((unsigned long)ghcb >= addr &&
+	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
+		/*
+		 * Ensure that the current cpu's GHCB is made private
+		 * at the end of unshared loop so that we continue to use the
+		 * optimized GHCB protocol and not force the switch to
+		 * MSR protocol till the very end.
+		 */
+		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
+		kexec_last_addr_to_make_private = addr;
+		return true;
+	}
+
+	if (!set_pte_enc(pte, level, (void *)addr))
+		return false;
+
+	snp_set_memory_private(addr, pages);
+
+	return true;
+}
+
+static void unshare_all_memory(void)
+{
+	unsigned long addr, end;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		/*
+		 * pte_none() check is required to skip physical memory holes in direct mapped.
+		 */
+		if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			if (!make_pte_private(pte, addr, pages, level)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+		}
+
+		addr += size;
+	}
+	__flush_tlb_all();
+
+}
+
+static void unshare_all_bss_decrypted_memory(void)
+{
+	unsigned long vaddr, vaddr_end;
+	unsigned int level;
+	unsigned int npages;
+	pte_t *pte;
+
+	vaddr = (unsigned long)__start_bss_decrypted;
+	vaddr_end = (unsigned long)__start_bss_decrypted_unused;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
+		pte = lookup_address(vaddr, &level);
+		if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
+			continue;
+
+		set_pte_enc(pte, level, (void *)vaddr);
+	}
+	vaddr = (unsigned long)__start_bss_decrypted;
+	snp_set_memory_private(vaddr, npages);
+}
+
+/* Stop new private<->shared conversions */
+void snp_kexec_stop_conversion(bool crash)
+{
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	bool wait_for_lock = !crash;
+
+	if (!stop_memory_enc_conversion(wait_for_lock))
+		pr_warn("Failed to finish shared<->private conversions\n");
+}
+
+void snp_kexec_unshare_mem(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	unshare_all_memory();
+
+	unshare_all_bss_decrypted_memory();
+
+	if (kexec_last_addr_to_make_private) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		/*
+		 * Switch to using the MSR protocol to change this cpu's
+		 * GHCB to private.
+		 * All the per-cpu GHCBs have been switched back to private,
+		 * so can't do any more GHCB calls to the hypervisor beyond
+		 * this point till the kexec kernel starts running.
+		 */
+		boot_ghcb = NULL;
+		sev_cfg.ghcbs_initialized = false;
+
+		pr_debug("boot ghcb 0x%lx\n", kexec_last_addr_to_make_private);
+		pte = lookup_address(kexec_last_addr_to_make_private, &level);
+		size = page_level_size(level);
+		set_pte_enc(pte, level, (void *)kexec_last_addr_to_make_private);
+		snp_set_memory_private(kexec_last_addr_to_make_private, (size / PAGE_SIZE));
+	}
+}
+
 static int snp_set_vmsa(void *va, bool vmsa)
 {
 	u64 attrs;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e7b67519ddb5..49c40c2ed809 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -468,6 +468,9 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
+	x86_platform.guest.enc_kexec_stop_conversion = snp_kexec_stop_conversion;
+	x86_platform.guest.enc_kexec_unshare_mem     = snp_kexec_unshare_mem;
+
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
 	 * parallel bringup low level code. That raises #VC which cannot be
-- 
2.34.1


