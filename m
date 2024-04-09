Return-Path: <linux-kernel+bounces-137615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A689E49F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99E01C20777
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888A15885F;
	Tue,  9 Apr 2024 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjxG7KVU"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210F13E3E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695410; cv=fail; b=S4qdazDm3nVeQi12Sdf45imSRUqBrRLsTXI/AEsnWGVxN2kOJMp8NMOLqoc+Q7lEaMNtp77HnR8OIG3zUyDL1Eh5x3+i+ZVIs0AZigrAWQ/emOWTjFvdQTBxHw9pTsVviVI0Ylo3MsUtgRy5v7+rlEudMv6ZVo9fwQYOacsMscs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695410; c=relaxed/simple;
	bh=MWwGjGckud1QUJVTKHebiece/NnrdzeKPSJ3mr+Uxuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5P1btEMn7IETfcIq/gJ2ywz0KR8YLG7gTovW+QJrX+vM4gTKLCoGnGQXvH7zinKEXhF3jOtSSbPRTMbz8ufiBDhPUR3sM+bNDoiJJAOGwDmbCOkBrEKpdj/csgtP+cGUvN+p/fjjRowen+JWzDf3TMvHuFy61f70niTkBNbmqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjxG7KVU; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSrfKwJRVt0320x03TUnEo2vRXeOR6UENJpgsOBeY/eXPcocGo2g9kPM4k70XKLOWs5aNQdZvt/pHZksuTygkcXOg10V2UIb1PvsBk6Pd7bK5NKHdWsC7vB6Vk9hB0yUc6fS8UTHai6yTzJkix2ziRujct4+CS3JheQkgeJsAPVwlxSu7ZVaWdmHruUfeMq9RW1oSCbbdPlJEUQ+cSFNBzaRFq6zlhwTyqnUBSKUkJ5u4jlyjzajr3yhNIIWJyWaBdxKab6XAkOpm6MsTqAtskaqPb/EjrkdZ7zqEs8S9EMzuIBqymj3CU/CuuIksziqnhiOAXMPvfgsKcyXfAec8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPwK0EfkYVEFcfPHqkBUreEVPFQlTsGgE4Lw2nzlxd4=;
 b=MnMG4Dms6Bsk3UgSstw3V01T8lsdfDwRXLYXVrWXrO3Ube253pkFbwlgc7FAV5fSQ1+1EaeYSvgRyK2CfA/hXAYTPhAjmCUAmaGwPxbPACsZoMmaA1emmCGNQv5+KiqyUbcGfjd86N0Kqqkbt4jN3zP5FuYGRRRIJmzJtmtNU6St4MQJK+bZtcGNirsqsPdBI6jT1fSjQzdrqyqNYoHrEOHiUhFPCCZoxvaUbDHig+YooPczrnSWlsGwOYm399S7BEmnvkXrYdxptpc6AC9B4Y54X5/8yJAvSddrQwm4JLAlZJ2+Ahgy1MLVCJa5NFaXOpLrioqiMrGeTOPqFA3p1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPwK0EfkYVEFcfPHqkBUreEVPFQlTsGgE4Lw2nzlxd4=;
 b=OjxG7KVUrDe0G2XeU9nkCpOA2juIdlAJlF7VR9oknM890+0JtDyOK0ZUmOT1TtTU+grhol7L/G6l5eo1Yl0jSExlkfvsVdJwvnrqKIuJnddryEGqWQRYLt9ryrLWYibNAl9yKwPpcEzkRc6ZUmGeWFMLYDw5uGUgnWZu61pqd2k=
Received: from SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 20:43:24 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::7f) by SJ0PR05CA0067.outlook.office365.com
 (2603:10b6:a03:332::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 20:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:43:23 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:43:22 -0500
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
Subject: [PATCH v4 4/4] x86/snp: Convert shared memory back to private on kexec
Date: Tue, 9 Apr 2024 20:43:13 +0000
Message-ID: <b24885f5495f6b8ba2f9e825fda9188fcbf28231.1712694667.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf0c1c9-1207-40fe-56e4-08dc58d5b322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b0rcN4tI9De5Y6508rkDuTS12qUaOQ++n8dSD85ElPesOaP2ua8qlyIBGAEIn0IE1qYIbdB7ZOJySGvZoTYZUuLzaefCLDnbU4iUvXE9D0PhrXp+GJDJ1s1QOZdIEhnu1Q5w+CEx4ZSvM8J/5NYMPohDdhcyAa21rpuK0DrBLrcE2ApeQJeqK3FU0YBNvJ7c1/vRkbbo3KIDZkXe5RjxD7/NvuKwyz/kxnK8WFOZicjw7byt3/1cDWnHpADSESwiODSD7mUKGFizLzz7d0CWSdJiSogRs4QmR5rspTbY+ofKAYR/FmfJaL3wA8POlpjyhqNq90JBDp1JAPmhPlvLkH0VEOYM0yf6ePoJf/VFM/Qvt3XvZ3Sx5MGc4BY4xJcWHaPXX0B6JsDVDN40+tKitNR2fbT4Dfao6/e+zpdm3ijeYiIURR7CsmqOmqeCZWsiFE1MZZnJw2YSjsrfyD5XNXR/LHMDK3YVLqfdyVFAlmsJShPxrIHbHm2tSSbhlqlnXeBoYIZFfUIvpJNM+rZnKF+a0QrZ1MPI2UX7Et7Yc/00RnIPyGmriyIrZOIHPQPwxfvujwK0qXbR+reNz/kxmE/+pKzRMXUhRNPiP+oteU0iR1jx25UhFs3VtMoyFhvnOD3CvsisAP9uByqvCsyvjjGgTKankiVzNjoxoCqwYHzKddb7uIyR8lpPCdfg16MbwZzhetFwYlabMiB8UBc6c9tD5blZXcHT/5+cww+m/SNMeu2jREt4HcJ2p8VIik4h
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:43:23.5480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf0c1c9-1207-40fe-56e4-08dc58d5b322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

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
index 38ad066179d8..17f616963beb 100644
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


