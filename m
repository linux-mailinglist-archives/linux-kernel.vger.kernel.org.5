Return-Path: <linux-kernel+bounces-105756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BE87E3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77A71C20D65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9622337;
	Mon, 18 Mar 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fo74uAIf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AE22EF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710745394; cv=fail; b=k/Pl1KzRiv5vyvkbXALz1MZQpdyTNgzSaR/fGBF6wU0+avPRowCLEi41KReXnfT0CU//RhWtwPEV06u6dR0d5POsZ30NUk5TtOuIlKsrx12Bub5+bKWuhglNCjtaG/piI4ZlFeSOHKrir+LYM3kilopt9sml1l2VnQ2hVZifZLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710745394; c=relaxed/simple;
	bh=8hJ410T3Uk4Ok856KLfyUMVjyzfcAfhv2d2CZpTV7xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/UeeufUNvlHQ2GmLOiIYBf/tnWEfrESpokkIGz+GtfDkYNxAyaIodp+nUi8ILAfHKMz6cmreWqd19tXpBAn24Jf853GMaahKYE/V4X8lVlHx2zAnXXAPFRhp5Tib+1U6QnMDiFOaVaKkYnlV30lixWrwnTrFT6seh5C90WhOk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fo74uAIf; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US7kn1SfyM1fvyGbpz4Ck0HTkmDF10GUVdNpc5BTZIiKtuVu5ExzxoQcfHIDYkfyoLBvnoAWozDTI9CHgiNIkPgX0ZgSTilz1AlJ01XyWX5UV+yPOgimGE5fGwOuNsuAXyHSZ9BCgk3l4QZtMUptu3VZSddgueha8Yrj88a1MOw1j/v5UB71KfBIbL3QPpa7Kry3VYw5A8NujgirZ+UsqmviYCI+hv3HUjHofRaEmfSkhkYdrEUjxX7Eclt23VVA3ODhldez52XaFSEi4N0g8GZq8o4b58uFxrs4eXI+DvZKDT+rPLWf8kzfjowesKJaY1+WxMLSYrL5hbUYTgfKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/QKZc2mVZKBDRuwUbmF7cQjECjNcuCBUC2ilShYk0Y=;
 b=EfAHVjiL1jPeUs/1fllgA8s5uS5fanea/olT4Z6Tb3OGRn1SeGbtpWlG2cCoHGxgdM3yAx4aOYP+dyVtZUHDkrZA9qVV7fwBMh2kt5q5svgQG2jvWsWfWve6B7GnHpDC460dOBI3y5SItp8MkzwJdKV6dyp+4FQWU5s6g4MjTYQbq4fuvBU0qWZtsvbS7r7kBcOJsLk3JanBKE6Qw1JKj5Tb1C9eg1sJDFoUoE76AGhN3ILjsXe9c5MVHnoQvZIk7PvicyP6ljZ8YZOowbp3VM5/BIqlYLuHTI2WXsEGC5NLPFI7fCcdnEcVCOq5ZLeDDdZYQ5nfP2kY+euAZny3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/QKZc2mVZKBDRuwUbmF7cQjECjNcuCBUC2ilShYk0Y=;
 b=Fo74uAIfmGe1eIBxOd05IBNGUOnsNQEzMfnV0FGxetk4PJEHsLC5DiT5UUlKQuUPyKmVW7ieiAvBnuMdje5WyKO9dDYPo7QH36N3nJawIKrukadLnfnFO7qU3537CUjr2/VjOfoMKuTKPdMtILWpvQ93UmMIJtA+KtHEikEpbcw=
Received: from DM6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:5:190::42)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 07:03:09 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::a2) by DM6PR11CA0029.outlook.office365.com
 (2603:10b6:5:190::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 07:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 07:03:09 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 02:03:08 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <elena.reshetova@intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <seanjc@google.com>, <michael.roth@amd.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <bdas@redhat.com>, <vkuznets@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>
Subject: [PATCH v2 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Mon, 18 Mar 2024 07:02:59 +0000
Message-ID: <939164bb3d073b42577a082ac30c3f03de217594.1710744412.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710744412.git.ashish.kalra@amd.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com> <cover.1710744412.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: a316e5d8-593f-489f-0ed2-08dc47197850
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QA2ZaBPcI4AQUt/FFadLU+9g+/RzviwK2XKx+rmXl2XE8gOa83DKYcVgP6wn0aQKfpr26stKIMd4c8CBvfEraBp3tzRRxwbAsKAq6tE7U4hBtLe9xIiROJxa2EFRGXMAKbIrJnvHCWY0fOsFmu1+xrymIF80a+JXF3w8v9ZkZEjI16H2Ht8GlYrAdTceEY28YrU2Mub9GFLgCn44Kpf9UTtz2KeCkryYFYlqFavSNeadpqqigIAzmVZJD4CAcgABY6peuAC9ik5hJMV9RftX7Gsi69EKZqnFp/VUEFpWdz2zx5by1ea5A1tenoOb+8UE8lJpKHQgPubNT1SJ3BHOW1sKspzpRClsiiq8oXaItgKr5aU4d0Cd/ul3dtB8IDNM7bh8t/2WWcFRI/bmwa8MS2ZIC7YGn3LVp+B8Hab3JrtXXxDiCwdsHpgAholHb7rsvJSsqtsGU8wW72pO7T5MmhNUqycMTHLraibg0BtPG+ORLyz1CXsIjE0fMUsYRj23va/s/lM8AGu261Pk5qqgHyVIeqcqottAOxKfZ9LytB0zg4E/fq4rCXt1G0fDt0zdJJP06CLpRo8Udu0uv0Uf2mwSkYAwi+zNi6Vzlh9Q49A5sW7tI1MJlizyt4Yq5KCgCzO49gyfTzt1iT43HaBa/M4pMFgVCX3skUN7G4LSP5bmDKLyzQLp/EtU4kTQn2+2gYkYQC9Ht/P7GETKd5GELgfmxhNrjSAFxxUJDhmQTUMVamqWpC5GVWMB6c3ILEy/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 07:03:09.7253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a316e5d8-593f-489f-0ed2-08dc47197850
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

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
index d7b27cb34c2b..867518b9bcad 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -229,6 +229,8 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void kdump_sev_callback(void);
+void snp_kexec_unshare_mem(void);
+void snp_kexec_stop_conversion(bool crash);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -258,6 +260,8 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void kdump_sev_callback(void) { }
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
index 1ef7ae806a01..7443a9620a31 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -40,6 +40,7 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/probe_roms.h>
 
 #define DR7_RESET_VALUE        0x400
 
@@ -71,6 +72,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Last address to be switched to private during kexec */
+static unsigned long kexec_last_addr_to_make_private;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -906,6 +910,171 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
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


