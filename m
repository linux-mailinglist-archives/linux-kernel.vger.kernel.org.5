Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4181E7D125C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377673AbjJTPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:13:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0309DD7C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697814785; x=1729350785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9Wk6cd6IKgeaqajVONUJGgYr2RF+ZltIGpIcK3sbgs=;
  b=k861V4nE4zaUY346EasV8bNdiZdAV+B4XseraDiGjrZ5yDMMokowJdpb
   lCw3o3Pm8zr7R3MeLD37q6bZFP+F+lgmzEp6XAA7nLMiHabhz25pNiTh9
   +fVLBzWrlC8TTLbGpWr4Hv9ZuZIFq6V/Exr0w0rCBJ0r5rUaL9Lo+fvLT
   AfKDFp254ELy5Y1a29jJgTNRKTqxXeVAAXg8nSGSWTBuxVf+fDIp7ZXSH
   j2xSNEu2gbOh2SRT+b6LiQ9nZ3g9XEzCn1NgBaLKpigC+o7fvFyqaRKjK
   BUY5GXnmLNtkPvkp1hyb28r3uX2aVaQio2Eelg6VkUG6aGybFtwjhymVT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="376893688"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="376893688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761080292"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761080292"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:56 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 73E2210A29F; Fri, 20 Oct 2023 18:12:45 +0300 (+03)
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
Subject: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI MADT wakeup method
Date:   Fri, 20 Oct 2023 18:12:42 +0300
Message-ID: <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

CPU offlining makes possible to hand over secondary CPUs over kexec, not
limiting the second kernel with single CPU.

The change conforms to the approved ACPI spec change proposal. See the
Link.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
---
 arch/x86/kernel/acpi/Makefile      |   2 +-
 arch/x86/kernel/acpi/boot.c        |   2 +
 arch/x86/kernel/acpi/madt.S        |  24 ++++
 arch/x86/kernel/acpi/madt_wakeup.c | 197 ++++++++++++++++++++++++++---
 include/acpi/actbl2.h              |  15 ++-
 5 files changed, 220 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/madt.S

diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index 8c7329c88a75..ccb8198dd8d1 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_ACPI)			+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)			+= apei.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
-obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
+obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y					+= cstate.o
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 111bd226ad99..d537dbffa697 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -22,6 +22,7 @@
 #include <linux/efi-bgrt.h>
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
+#include <linux/sched/hotplug.h>
 
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
@@ -33,6 +34,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/init.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
diff --git a/arch/x86/kernel/acpi/madt.S b/arch/x86/kernel/acpi/madt.S
new file mode 100644
index 000000000000..a60435cf4a77
--- /dev/null
+++ b/arch/x86/kernel/acpi/madt.S
@@ -0,0 +1,24 @@
+#include <linux/linkage.h>
+#include <asm/nospec-branch.h>
+#include <asm/page_types.h>
+#include <asm/processor-flags.h>
+
+	.text
+	.align PAGE_SIZE
+SYM_FUNC_START(asm_acpi_mp_play_dead)
+	/* Load address of reset vector into RCX to jump when kernel is ready */
+	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
+
+	/* Turn off global entries. Following CR3 write will flush them. */
+	movq	%cr4, %rdx
+	andq	$~(X86_CR4_PGE), %rdx
+	movq	%rdx, %cr4
+
+	/* Switch to identity mapping */
+	movq	acpi_mp_pgd(%rip), %rax
+	movq	%rax, %cr3
+
+	/* Jump to reset vector */
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rcx
+SYM_FUNC_END(asm_acpi_mp_play_dead)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index ad170def2367..f9ff14ee2892 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -1,8 +1,13 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/pgtable.h>
+#include <linux/sched/hotplug.h>
 #include <asm/apic.h>
 #include <asm/barrier.h>
+#include <asm/init.h>
 #include <asm/processor.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
@@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
 static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
+u64 acpi_mp_pgd;
+u64 acpi_mp_reset_vector_paddr;
+
+void asm_acpi_mp_play_dead(void);
+
+static void __init *alloc_pgt_page(void *context)
+{
+	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+/*
+ * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
+ * the same place as in the kernel page tables. The function switches to
+ * the identity mapping and has be present at the same spot in before and
+ * after transition.
+ */
+static int __init init_transition_pgtable(pgd_t *pgd)
+{
+	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
+	unsigned long vaddr, paddr;
+	int result = -ENOMEM;
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
+			goto err;
+		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
+	}
+	p4d = p4d_offset(pgd, vaddr);
+	if (!p4d_present(*p4d)) {
+		pud = (pud_t *)alloc_pgt_page(NULL);
+		if (!pud)
+			goto err;
+		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+	}
+	pud = pud_offset(p4d, vaddr);
+	if (!pud_present(*pud)) {
+		pmd = (pmd_t *)alloc_pgt_page(NULL);
+		if (!pmd)
+			goto err;
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+	}
+	pmd = pmd_offset(pud, vaddr);
+	if (!pmd_present(*pmd)) {
+		pte = (pte_t *)alloc_pgt_page(NULL);
+		if (!pte)
+			goto err;
+		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+	}
+	pte = pte_offset_kernel(pmd, vaddr);
+
+	paddr = __pa(vaddr);
+	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+
+	return 0;
+err:
+	return result;
+}
+
+static void acpi_mp_play_dead(void)
+{
+	play_dead_common();
+	asm_acpi_mp_play_dead();
+}
+
+static void acpi_mp_cpu_die(unsigned int cpu)
+{
+	int apicid = per_cpu(x86_cpu_to_apicid, cpu);
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
+static void acpi_mp_crash_stop_other_cpus(void)
+{
+	smp_shutdown_nonboot_cpus(smp_processor_id());
+
+	/* The kernel is broken so disable interrupts */
+	local_irq_disable();
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
+
+	for (int i = 0; i < nr_pfn_mapped; i++) {
+		unsigned long mstart, mend;
+		mstart = pfn_mapped[i].start << PAGE_SHIFT;
+		mend   = pfn_mapped[i].end << PAGE_SHIFT;
+		if (kernel_ident_mapping_init(&info, pgd, mstart, mend))
+			return -ENOMEM;
+	}
+
+	if (kernel_ident_mapping_init(&info, pgd,
+				      PAGE_ALIGN_DOWN(reset_vector),
+				      PAGE_ALIGN(reset_vector + 1))) {
+		return -ENOMEM;
+	}
+
+	if (init_transition_pgtable(pgd))
+		return -ENOMEM;
+
+	smp_ops.play_dead = acpi_mp_play_dead;
+	smp_ops.cpu_die = acpi_mp_cpu_die;
+	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
+	smp_ops.crash_stop_other_cpus = acpi_mp_crash_stop_other_cpus;
+
+	acpi_mp_reset_vector_paddr = reset_vector;
+	acpi_mp_pgd = __pa(pgd);
+
+	return 0;
+}
+
 static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
 {
 	if (!acpi_mp_wake_mailbox_paddr) {
@@ -74,31 +223,43 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 	struct acpi_madt_multiproc_wakeup *mp_wake;
 
 	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
-	if (BAD_MADT_ENTRY(mp_wake, end))
+	if (!mp_wake)
+		return -EINVAL;
+
+	if (end - (unsigned long)mp_wake < ACPI_MADT_MP_WAKEUP_SIZE_V0)
+		return -EINVAL;
+	if (mp_wake->header.length < ACPI_MADT_MP_WAKEUP_SIZE_V0)
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(&header->common);
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
-	cpu_hotplug_disable_offlining();
+	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
+	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
+		acpi_mp_setup_reset(mp_wake->reset_vector);
+	} else {
+		cpu_hotplug_disable_offlining();
 
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
+		/*
+		 * ACPI MADT doesn't allow to offline CPU after it got woke up.
+		 * It limits kexec: the second kernel won't be able to use more
+		 * than one CPU.
+		 *
+		 * Now acpi_mp_wake_mailbox_paddr already has the mailbox
+		 * address. The acpi_wakeup_cpu() will use it to bring up
+		 * secondary cpus.
+		 *
+		 * Zero out mailbox address in the ACPI MADT wakeup structure
+		 * to indicate that the mailbox is not usable.  This prevents
+		 * the kexec()-ed kernel from reading a vaild mailbox, which in
+		 * turn makes the kexec()-ed kernel only be able to use the boot
+		 * CPU.
+		 *
+		 * This is Linux-specific protocol and not reflected in ACPI spec.
+		 */
+		mp_wake->mailbox_address = 0;
+	}
 
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
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

