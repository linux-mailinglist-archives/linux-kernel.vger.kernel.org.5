Return-Path: <linux-kernel+bounces-146004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786538A5E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9AD284CED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69DC158DDD;
	Mon, 15 Apr 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cwKnm77q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB82158DB0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223427; cv=fail; b=Fqm2vP36VJMDN37IK5pBOhqu2oCIu58l1Z6SegLVJ7/d/lP5AgiZApskwBZ+qNHKWz33cZmzZ3endDu2i24XyhoYVjIfI9M/P7H2TYo9ITa+ZT2Hcq/ke82T6p09ACZMYUKeD02KUWhInT+/2GCW5HYqpZd0rQ6wJ37eOTuE1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223427; c=relaxed/simple;
	bh=MWwGjGckud1QUJVTKHebiece/NnrdzeKPSJ3mr+Uxuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJXC+UdIGqwh+SCfSdV4I1J2bwXZezcXthgYiCPDZeVf2jdyM5XW7655K7O5QSr+MuMJwzypX7PkmeO+UFEPdoyZbslXAwfbrQXXglcIHcPLbCD+vn4kB9B4mQgD5XTyjn+obMswQ6JHa8sxUIv1ruiW6+ice/qoBsndlVh+Z74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cwKnm77q; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqV2827g4A71Ufa8efXNikBxeGdYvUr/gv8P3q/4/5DTY33WsUg1Vkx6kdptt9Nq4mvd9gHQhftUUz0QHAet6W7068kmHwuHwbUcqtBTOR3baGaUZ1XPH3swj/7M8HTZ2glmwJOft1I8STEvvmy8JEoFYGLZKC/dsd0N+pRzWnp2KCaHbWYKjVDmHMyi2dFB1KAtE8hWySDvZayVV8EMk7QCd+7czK4+WHEYQz0hZ7ev0ev2AQTp5yBGEaSb73ufBIQNnS5lixONnPXnleqihpwz51q3B/wq72Xwb+whScw6VKrDsUFb5GCjIORFSI4TG/shPz54KkadKYMr7pW7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPwK0EfkYVEFcfPHqkBUreEVPFQlTsGgE4Lw2nzlxd4=;
 b=QWoe1QbI88B98CQOe0sFv6TCf6PNz2m3F611UqolanWJjYmZHKWUQiRJ1pUxhzeltma7Lu3iAA0mz+tIJzaq3/oaW/rWrWptEsYw4RP0B1OS3RbFSvEZkRrzJ/gV704fUVQnQm+8fK/+oFBy5kGRGDbNwRF/KEl5IJDwgQUcFHmagnosyqQAbZlPTvK0oCnMSdN80Y6koU5da8DxzRotb/12DyJAZ/cy0vTq1clnk6Ir9MicBrbq2XE7q66GgwH4jhvi7U8iAe8yA/vXxsuhwNa7ADuUOJvHQhfcBxdnpQeZ4rjm+cyAefMEJ1YqkvUeOz7DzkbI5iCvmpWWR7bG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPwK0EfkYVEFcfPHqkBUreEVPFQlTsGgE4Lw2nzlxd4=;
 b=cwKnm77qfcxufeHcJTVs7kS6tQ9VorAQgYqGvLhLuI6wAt3xbUacbqRYqO8LVs0jllLe9xPNG942SAp5dVpqiwC7tfbIvAMpflCQ1otsd0YvNy8yFzJLUhrS3liWM8wdn01/Hrbr66tYldMmqhki3YWN2owhYIMahy1pFuUoo2o=
Received: from BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:23:43 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::dc) by BL0PR05CA0001.outlook.office365.com
 (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.19 via Frontend
 Transport; Mon, 15 Apr 2024 23:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 23:23:43 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 18:23:42 -0500
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
Subject: [PATCH v5 3/3] x86/snp: Convert shared memory back to private on kexec
Date: Mon, 15 Apr 2024 23:23:33 +0000
Message-ID: <fafa1566b81ef3923ba8f9331e97d1341dd2d5a9.1713222642.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713222642.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1713222642.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a7fd58-c2ec-4393-709d-08dc5da31742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SVu5kwY0COY2K3L/TUA+HVIBI+AobnWpJF0PBTwSzR4Zlf5r1HfiT/EFhUG+izoCU0ibo8Tajwmqjr0u20P3SSKXoIh2pfdPiw6gbPMGBP2PlRTOUnoRI3A5kACoqiNf7pAhpImn/NggSneLXXMOPsbFwNO5B+IasqNXAoNvLc6hGVuRziD1A3t+6cHfSU4/tYZmexd5J0ODMQMRSTPA70Myg220ppc27D/XlLuiYhKQ825SMNKcQAeMSUOT4n92y7czdS4KJJ7cEo0nUZbGOczoe/ouQhUM482ZhM4DT5HHtJ9iqFDXGloUQuXSJ4QtqtkvDHPEpvZ5rceWtXh8K/Lpd3kDryzbxPFNNPNgn/mFJXVF3ZupK9lqdt3pbAp8QF6hyz3ocD5CbE1/CELF5wVylGk6LEoGoSphO4AcBk3HdHkpGd2nlbaXwXFKxFg/vdb/8APIpcRPIqHyTt47xT3mmC6D1bKWT/UX+5zQUNaX2f67AwykG4xWG9IxwimiB80yp1gIxIvR/hPWuWP20peCFbS7GwqLFzJkubjIvn89vFFDaewOVdtHqK/lwOkkwKTdiqxlt7lyHmMNyQ1BZTGpa9kXX1NrqR+rwrM7gV6+TYYBm2+Q08DG8bXS6pVkSoyK/OKDroXXw2ANZh00lVfKlHDLV/ooa+6BhVLKhdrguZ9YIHWIjcZnEbS1+aEVWiQz1+Mh7iAgSiO4iJ0oPG4FjKfedbQJJm0cUstWIYwvK2YIEMeVbIHYeVPKcoS0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:23:43.0737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a7fd58-c2ec-4393-709d-08dc5da31742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232

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


