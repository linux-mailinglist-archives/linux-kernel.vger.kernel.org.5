Return-Path: <linux-kernel+bounces-132244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99928991ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077041C22821
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823F13C3EC;
	Thu,  4 Apr 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NpGmvf3G"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4F13C3DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272326; cv=fail; b=Zd5Kd6tb/BGl7ubTHQM63XeYXlm/gWz+gtLyz1gDr6I2BchjtU13U2rRV3w/jVyakipc0/lOg28XQrZYDn/hvAAYfo9eJHzr/JgC5Y4moG1ATI2NLe6cAyQJhkwy0Je0GsBDJ1VnytbCU0omlx1V77t2hejxsU0xACZskNI3NFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272326; c=relaxed/simple;
	bh=HvRoEvMt9q4SQ1X5XXjunFIDo/QQ+DGe+1yndyurXBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZtnWzIuG2tyWExp2RXF/lmRqAfMhQri5JbjEtFHiK3b6Vu7QVSBdbd9D4/SEGRysav/akcAtczNj+tDrLooFcvBELihDDI/PuJscPpHk1xVtrPbhvDRhJluG2Tb+QCzQzFnqCn6yCCmd0qBhatW5ic4ELbDRd5OdIvSwdtmtPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NpGmvf3G; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EimUzGdSRhqMRjhTVkugdrjIVi1HVnqB3VoceaYGqADNUo3s6vQxMNp9snaCkDGzSchEA4laPA02+zv2Mu05WhMjBWPIzHmvuMEmtSbcjTtwAo5Z6EescBSO1TzAIki7Sls995BvEAXp+8gpz7jmRj0gk54+MxQ+7zv5FdzSJqWcXeKDDAak1jYkKnzDShigpzc+WBfhEH8GAWSWr5rF3V4vrN0aydfqHMPU9tuVRNSbD7AGUE8sxoOtD7DxiSg5lcSoFw/UWUrP0pbVv2ew7Tai5s5H5FTyn+rq3K5i+BrRzn/kqMC9KWD9W25N4w+VuaRjniWvy5fW3+elO7I0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHSodj0GqwZea2cUnOdZNuVerpQ0f8rgFAq1UqU6UlI=;
 b=nS0TnBbuyoyHYNEjYt3HQlMrWkUjRi6KbEanzaIRndI2sYB1PQ2Fol4TpTFg6r6zPj275JrTBfe1HtJ7mV9NT5Swn7MhigdyE4UJjL3N+8s+AMq20VWZuKGqUgE84c26w/ANIxzCqEfLpwDnvXhtAvI2ajI7YeWyxRl9UWheaArfK0HhwXkCKyJI0UB/2ceqZh1L8XE55TLAaidMdNFUGItnlsmk6ooDuZq3wQbDnqfnX3+zgmQwev8if3hjpPlbk5sYAdfzVeZFDZ05ObykR+3SYrn09U9p5lC2cbzQ4Uv8z1T174zEHaHY+BzWyCWJdTm4cnW/f+fnWNQ/UrfQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHSodj0GqwZea2cUnOdZNuVerpQ0f8rgFAq1UqU6UlI=;
 b=NpGmvf3G6aYrpQX4f5zNwyzEhSpBxm2DkO7Sp+DtzZQyikvNbjgpx+uDbYC9R9SCOF9ghOVthWc4mZ9qRqhoFqY5v8ZTgc5G38UqMvAMYY9/KsH44aAWHoezbt3p67Ib3PkPIryLBBIjQhkOz1FFxPLugLivUotLU/2H0kZbYm4=
Received: from BYAPR11CA0079.namprd11.prod.outlook.com (2603:10b6:a03:f4::20)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 23:11:59 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::b3) by BYAPR11CA0079.outlook.office365.com
 (2603:10b6:a03:f4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 23:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:11:58 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:11:57 -0500
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
Subject: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on kexec
Date: Thu, 4 Apr 2024 23:11:48 +0000
Message-ID: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712270975.git.ashish.kalra@amd.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com> <cover.1712270975.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 11199496-6a8d-4ab7-3c3b-08dc54fca0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SSgSFktirR2Hh8E2oEOfkxi4BTd7x3DnpFJD4azYr8dus83TXhwOayO2AWtK6GaDOI8Yd6/e0kgOLp4pgmR4v13g5rSw9UNPMkuQ/8pu7uxwaJMXlpsYBI5mSxEB2C+0Gb3ORtmcm5oWHDYEfBU9jTLKFDCExt/+0u+JoNUHnkqD0Bzz18ulM0QSVbI0KGNCXQYZ20QdCyNf3i1tgcaaotRRw8UOPqlW18fPaFoATGPYagTxNerzNZAgI4XtLjohiUmyuzG3PTcx1xw2xvnqlVOc17Y7NE4cSTTjjL5QIpMtNZwycZIhokuH2c6gdXfh0dUbUhJ0GwG13j3y/QxXeOeF+fSkrkq8sDv6dA7RpgSSAJMwNhQaYpmGgGxukx4zbkDQWIhuzWfxo+dyNh7KdCf8M8JIZbiSw6eLks09xbsGnGnlzmlHph7RGRYK1kcQlR5l7yiUvd/I7fHydtNO83JXf3qm2tXxq31ZbwzlazqDzrgOs7OzCpsGZar/KXn0/7BTNq9JlfNFqLBas6Wt2J1Fe1CYp9u27FKqN8BXEfAhjYOZ749SkqNZLos2XYYqAZAwuQsOMY01+Tx3oqnKOrurMONCoDFa1AarIW2NJRfeR1yJrMA60EBBv99F71cayYRnEwYcy09KDR8n00MqouQC//5bkD5WmEaIqs4TKckZAJ+ybeHkQzVMax6NR2ILH0sl2SJ7hEgOkXyt4zJBpFPtmrYD/MgPAYEVKyjqPgscya/eN/k3FAj8y0P49oMh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:58.7360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11199496-6a8d-4ab7-3c3b-08dc54fca0fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260

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
 arch/x86/include/asm/probe_roms.h |   1 +
 arch/x86/include/asm/sev.h        |   4 +
 arch/x86/kernel/probe_roms.c      |  16 +++
 arch/x86/kernel/sev.c             | 169 ++++++++++++++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c     |   3 +
 5 files changed, 193 insertions(+)

diff --git a/arch/x86/include/asm/probe_roms.h b/arch/x86/include/asm/probe_roms.h
index 1c7f3815bbd6..d50b67dbff33 100644
--- a/arch/x86/include/asm/probe_roms.h
+++ b/arch/x86/include/asm/probe_roms.h
@@ -6,4 +6,5 @@ struct pci_dev;
 extern void __iomem *pci_map_biosrom(struct pci_dev *pdev);
 extern void pci_unmap_biosrom(void __iomem *rom);
 extern size_t pci_biosrom_size(struct pci_dev *pdev);
+extern void snp_kexec_unprep_rom_memory(void);
 #endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9477b4053bce..51197a544693 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -230,6 +230,8 @@ u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
 void sev_show_status(void);
+void snp_kexec_unshare_mem(void);
+void snp_kexec_stop_conversion(bool crash);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -260,6 +262,8 @@ static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
 static inline void sev_show_status(void) { }
+void snp_kexec_unshare_mem(void) {}
+static void snp_kexec_stop_conversion(bool crash) {}
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..457f1e5c8d00 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -177,6 +177,22 @@ size_t pci_biosrom_size(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pci_biosrom_size);
 
+void snp_kexec_unprep_rom_memory(void)
+{
+	unsigned long vaddr, npages, sz;
+
+	/*
+	 * Switch back ROM regions to shared so that their validation
+	 * does not fail during kexec kernel boot.
+	 */
+	vaddr = (unsigned long)__va(video_rom_resource.start);
+	sz = (system_rom_resource.end + 1) - video_rom_resource.start;
+	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+
+	snp_set_memory_shared(vaddr, npages);
+}
+EXPORT_SYMBOL(snp_kexec_unprep_rom_memory);
+
 #define ROMSIGNATURE 0xaa55
 
 static int __init romsignature(const unsigned char *rom)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b59b09c2f284..1395c9f0fae4 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -41,6 +41,7 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/probe_roms.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -91,6 +92,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Last address to be switched to private during kexec */
+static unsigned long kexec_last_addr_to_make_private;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -927,6 +931,171 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
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
+	unsigned long size;
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
+		size = page_level_size(level);
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
+	/*
+	 * Switch back any specific memory regions such as option
+	 * ROM regions back to shared so that (re)validation does
+	 * not fail when kexec kernel boots.
+	 */
+	snp_kexec_unprep_rom_memory();
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
index d314e577836d..dab2dc2207fb 100644
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


