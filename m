Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734BC804391
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376327AbjLEAq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbjLEApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:45:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EBA11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737138; x=1733273138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8b6nnzvT7MJKGtUPhN9ZDFjx6caST117rFTmJst0Njg=;
  b=foXu8RPGhqzF6GxRPuTrqcqsd7OcHA6AnW4eXr2ihnXU4wGYKe+rVBHp
   Ex3thwpFcbpnUXs6pINcWZ0HA77uF3EADobnW832oFUB49OKPyFbmk8PZ
   x8iW3I6YsQSlBjgA5ONH0STX5xkiW9bf8x+mGLDg3Yy5NGk9QRyAookCe
   h/gBle8ZlmyEuFZs/HluYvBBXND/ZSrC4NUnxpwxzyuq//HeOPWqQd0OV
   s61JwAcxvnPnPebCb5Mrz5vxlUiMnaeQNjp2/26SD1RMKNmXAWKL5/XZI
   JvRVyKSvcmEzoU3TnxuD9todC2AZ5T7IrrPnJ1H0RG0qDeFs6ObpxZfB8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688751"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="944067958"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="944067958"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C31E410A454; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
Date:   Tue,  5 Dec 2023 03:45:10 +0300
Message-ID: <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADT Multiprocessor Wakeup structure version 1 brings support of CPU
offlining: BIOS provides a reset vector where the CPU has to jump to
offline itself. The new TEST mailbox command can be used to test the CPU
offlined successfully and BIOS has control over it.

Add CPU offling support for ACPI MADT wakeup method by implementing
custom cpu_die, play_dead and stop_other_cpus SMP operations.

CPU offlining makes is possible to hand over secondary CPUs over kexec,
not limiting the second kernel to single CPU.

The change conforms to the approved ACPI spec change proposal. See the
Link.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
---
 arch/x86/include/asm/smp.h           |   1 +
 arch/x86/kernel/acpi/Makefile        |   2 +-
 arch/x86/kernel/acpi/madt_playdead.S |  21 ++
 arch/x86/kernel/acpi/madt_wakeup.c   | 295 +++++++++++++++++++++++++--
 arch/x86/kernel/reboot.c             |  12 +-
 include/acpi/actbl2.h                |  15 +-
 6 files changed, 321 insertions(+), 25 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt_playdead.S

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..3c8efba86d5c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*crash_play_dead)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index 8c7329c88a75..37b1f28846de 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_ACPI)			+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)			+= apei.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
-obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
+obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt_playdead.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y					+= cstate.o
diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/acpi/madt_playdead.S
new file mode 100644
index 000000000000..68f83865a1e3
--- /dev/null
+++ b/arch/x86/kernel/acpi/madt_playdead.S
@@ -0,0 +1,21 @@
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+
+	.text
+	.align PAGE_SIZE
+SYM_FUNC_START(asm_acpi_mp_play_dead)
+	/* Turn off global entries. Following CR3 write will flush them. */
+	movq	%cr4, %rdx
+	andq	$~(X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4
+
+	/* Switch to identity mapping */
+	movq	%rsi, %rax
+	movq	%rax, %cr3
+
+	/* Jump to reset vector */
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rdi
+SYM_FUNC_END(asm_acpi_mp_play_dead)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 5d92d12f1042..f8cf7a048743 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -1,9 +1,18 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/pgtable.h>
+#include <linux/sched/hotplug.h>
 #include <asm/apic.h>
 #include <asm/barrier.h>
+#include <asm/init.h>
+#include <asm/intel_pt.h>
+#include <asm/nmi.h>
 #include <asm/processor.h>
+#include <asm/reboot.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
@@ -11,6 +20,228 @@ static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
 static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
 
+static u64 acpi_mp_pgd __ro_after_init;
+static u64 acpi_mp_reset_vector_paddr __ro_after_init;
+
+void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
+
+static void crash_acpi_mp_play_dead(void)
+{
+	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
+			      acpi_mp_pgd);
+}
+
+static void acpi_mp_play_dead(void)
+{
+	play_dead_common();
+	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
+			      acpi_mp_pgd);
+}
+
+static void acpi_mp_cpu_die(unsigned int cpu)
+{
+	u32 apicid = per_cpu(x86_cpu_to_apicid, cpu);
+	unsigned long timeout;
+
+	/*
+	 * Use TEST mailbox command to prove that BIOS got control over
+	 * the CPU before declaring it dead.
+	 *
+	 * BIOS has to clear 'command' field of the mailbox.
+	 */
+	acpi_mp_wake_mailbox->apic_id = apicid;
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_TEST);
+
+	/* Don't wait longer than a second. */
+	timeout = USEC_PER_SEC;
+	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
+		udelay(1);
+}
+
+static void acpi_mp_stop_other_cpus(int wait)
+{
+	smp_shutdown_nonboot_cpus(smp_processor_id());
+}
+
+/* The argument is required to match type of x86_mapping_info::alloc_pgt_page */
+static void __init *alloc_pgt_page(void *dummy)
+{
+	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+/*
+ * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
+ * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
+ * to the identity mapping and the function has be present at the same spot in
+ * the virtual address space before and after switching page tables.
+ */
+static int __init init_transition_pgtable(pgd_t *pgd)
+{
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	unsigned long vaddr, paddr;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	vaddr = (unsigned long)asm_acpi_mp_play_dead;
+	pgd += pgd_index(vaddr);
+	if (!pgd_present(*pgd)) {
+		p4d = (p4d_t *)alloc_pgt_page(NULL);
+		if (!p4d)
+			return -ENOMEM;
+		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
+	}
+	p4d = p4d_offset(pgd, vaddr);
+	if (!p4d_present(*p4d)) {
+		pud = (pud_t *)alloc_pgt_page(NULL);
+		if (!pud)
+			return -ENOMEM;
+		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+	}
+	pud = pud_offset(p4d, vaddr);
+	if (!pud_present(*pud)) {
+		pmd = (pmd_t *)alloc_pgt_page(NULL);
+		if (!pmd)
+			return -ENOMEM;
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+	}
+	pmd = pmd_offset(pud, vaddr);
+	if (!pmd_present(*pmd)) {
+		pte = (pte_t *)alloc_pgt_page(NULL);
+		if (!pte)
+			return -ENOMEM;
+		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+	}
+	pte = pte_offset_kernel(pmd, vaddr);
+
+	paddr = __pa(vaddr);
+	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+
+	return 0;
+}
+
+static void __init free_pte(pmd_t *pmd)
+{
+	pte_t *pte = pte_offset_kernel(pmd, 0);
+
+	memblock_free(pte, PAGE_SIZE);
+}
+
+static void __init free_pmd(pud_t *pud)
+{
+	pmd_t *pmd = pmd_offset(pud, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		if (!pmd_present(pmd[i]))
+		    continue;
+
+		if (pmd_leaf(pmd[i]))
+		    continue;
+
+		free_pte(&pmd[i]);
+	}
+
+	memblock_free(pmd, PAGE_SIZE);
+}
+
+static void __init free_pud(p4d_t *p4d)
+{
+	pud_t *pud = pud_offset(p4d, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_PUD; i++) {
+		if (!pud_present(pud[i]))
+			continue;
+
+		if (pud_leaf(pud[i]))
+		    continue;
+
+		free_pmd(&pud[i]);
+	}
+
+	memblock_free(pud, PAGE_SIZE);
+}
+
+static void __init free_p4d(pgd_t *pgd)
+{
+	p4d_t *p4d = p4d_offset(pgd, 0);
+	int i;
+
+	for (i = 0; i < PTRS_PER_P4D; i++) {
+		if (!p4d_present(p4d[i]))
+			continue;
+
+		free_pud(&p4d[i]);
+	}
+
+	if (pgtable_l5_enabled())
+		memblock_free(p4d, PAGE_SIZE);
+}
+
+static void __init free_pgd(pgd_t *pgd)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PGD; i++) {
+		if (!pgd_present(pgd[i]))
+			continue;
+
+		free_p4d(&pgd[i]);
+	}
+
+	memblock_free(pgd, PAGE_SIZE);
+}
+
+static int __init acpi_mp_setup_reset(u64 reset_vector)
+{
+	pgd_t *pgd;
+	struct x86_mapping_info info = {
+		.alloc_pgt_page = alloc_pgt_page,
+		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
+		.kernpg_flag    = _KERNPG_TABLE_NOENC,
+	};
+
+	pgd = alloc_pgt_page(NULL);
+	if (!pgd)
+		return -ENOMEM;
+
+	for (int i = 0; i < nr_pfn_mapped; i++) {
+		unsigned long mstart, mend;
+
+		mstart = pfn_mapped[i].start << PAGE_SHIFT;
+		mend   = pfn_mapped[i].end << PAGE_SHIFT;
+		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
+			free_pgd(pgd);
+			return -ENOMEM;
+		}
+	}
+
+	if (kernel_ident_mapping_init(&info, pgd,
+				      PAGE_ALIGN_DOWN(reset_vector),
+				      PAGE_ALIGN(reset_vector + 1))) {
+		free_pgd(pgd);
+		return -ENOMEM;
+	}
+
+	if (init_transition_pgtable(pgd)) {
+		free_pgd(pgd);
+		return -ENOMEM;
+	}
+
+	smp_ops.play_dead = acpi_mp_play_dead;
+	smp_ops.crash_play_dead = crash_acpi_mp_play_dead;
+	smp_ops.cpu_die = acpi_mp_cpu_die;
+	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
+
+	acpi_mp_reset_vector_paddr = reset_vector;
+	acpi_mp_pgd = __pa(pgd);
+
+	return 0;
+}
+
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
 	if (!acpi_mp_wake_mailbox_paddr) {
@@ -68,37 +299,63 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
+static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
+{
+	cpu_hotplug_disable_offlining();
+
+	/*
+	 * Zero out mailbox address in the ACPI MADT wakeup structure
+	 * to indicate that the mailbox is not usable.  This prevents
+	 * the kexec()-ed kernel from reading a vaild mailbox, which in
+	 * turn makes the kexec()-ed kernel only be able to use the boot
+	 * CPU.
+	 *
+	 * This is Linux-specific protocol and not reflected in ACPI spec.
+	 *
+	 * acpi_mp_wake_mailbox_paddr already has the mailbox address.
+	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus for
+	 * the current kernel.
+	 */
+	mp_wake->mailbox_address = 0;
+}
+
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end)
 {
 	struct acpi_madt_multiproc_wakeup *mp_wake;
 
 	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
-	if (BAD_MADT_ENTRY(mp_wake, end))
+
+        /*
+         * Cannot use the standard BAD_MADT_ENTRY() to sanity check the @mp_wake
+         * entry.  'sizeof (struct acpi_madt_multiproc_wakeup)' can be larger
+         * than the actual size of the MP wakeup entry in ACPI table because the
+	 * 'reset_vector' is only available in the V1 MP wakeup structure.
+         */
+	if (!mp_wake)
+		return -EINVAL;
+	if (end - (unsigned long)mp_wake < ACPI_MADT_MP_WAKEUP_SIZE_V0)
+		return -EINVAL;
+	if (mp_wake->header.length < ACPI_MADT_MP_WAKEUP_SIZE_V0)
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(&header->common);
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
-	cpu_hotplug_disable_offlining();
-
-	/*
-	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
-	 * It limits kexec: the second kernel won't be able to use more than
-	 * one CPU.
-	 *
-	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
-	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
-	 *
-	 * Zero out mailbox address in the ACPI MADT wakeup structure to
-	 * indicate that the mailbox is not usable.  This prevents the
-	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
-	 * makes the kexec()-ed kernel only be able to use the boot CPU.
-	 *
-	 * This is Linux-specific protocol and not reflected in ACPI spec.
-	 */
-	mp_wake->mailbox_address = 0;
+	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
+	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
+		if (acpi_mp_setup_reset(mp_wake->reset_vector)) {
+			pr_warn("Failed to setup MADT reset vector\n");
+			acpi_mp_disable_offlining(mp_wake);
+		}
+	} else {
+		/*
+		 * CPU offlining requires version 1 of the ACPI MADT wakeup
+		 * structure.
+		 */
+		acpi_mp_disable_offlining(mp_wake);
+	}
 
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index c81afffaa954..99e6ab552da0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -878,10 +878,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
-	/* Assume hlt works */
-	halt();
-	for (;;)
-		cpu_relax();
+
+	if (smp_ops.crash_play_dead) {
+	    smp_ops.crash_play_dead();
+	} else {
+		halt();
+		for (;;)
+			cpu_relax();
+	}
 
 	return NMI_HANDLED;
 }
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 23b4cfb640fc..8348bf46a648 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1112,8 +1112,20 @@ struct acpi_madt_multiproc_wakeup {
 	u16 version;
 	u32 reserved;		/* reserved - must be zero */
 	u64 mailbox_address;
+	u64 reset_vector;
 };
 
+/* Values for Version field above */
+
+enum acpi_madt_multiproc_wakeup_version {
+	ACPI_MADT_MP_WAKEUP_VERSION_NONE = 0,
+	ACPI_MADT_MP_WAKEUP_VERSION_V1 = 1,
+	ACPI_MADT_MP_WAKEUP_VERSION_RESERVED = 2, /* 2 and greater are reserved */
+};
+
+#define ACPI_MADT_MP_WAKEUP_SIZE_V0	16
+#define ACPI_MADT_MP_WAKEUP_SIZE_V1	24
+
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
 #define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE  2048
 
@@ -1126,7 +1138,8 @@ struct acpi_madt_multiproc_wakeup_mailbox {
 	u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];	/* reserved for firmware use */
 };
 
-#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
+#define ACPI_MP_WAKE_COMMAND_WAKEUP	1
+#define ACPI_MP_WAKE_COMMAND_TEST	2
 
 /* 17: CPU Core Interrupt Controller (ACPI 6.5) */
 
-- 
2.41.0

