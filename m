Return-Path: <linux-kernel+bounces-40601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1036A83E308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B938B23A89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552462231A;
	Fri, 26 Jan 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPcwDYMv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D581E876
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299399; cv=none; b=XLdxgKSqPhQNT3qBZ25ZH7GOe9yZKDB35bnD99F43XAWLt/obw6rk+ePbh3XayxHPzvi6uvM3e5j03rDJSaY26FAaGMWDJ0+7ynO2eMxsP1PFuhLn/B3tMO+cD2VwBZ6B1VfYc+KzH4dL5Rl6WfTJu+hTPyyttzmJ5MP0cldn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299399; c=relaxed/simple;
	bh=ywCH/SLKgogA9xDchCrsleSmFAAbZmIxUyWQVehcOpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b78ZTtaUZ2J7ub2EEWfO73wJxqy2RAsG4XSO6asyg47tNkhaB0sZqjuK3f9q/XkC1oVkgzAdH2b9VCkf4DRERVUW8MeRPzoV64r7Yd6ucZ/KXjouq9PjAT56i8P8pHhsdNypNQ9Q2mKRl1xfDKfQikAnU56zDTn9qFIuSchvuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPcwDYMv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706299397; x=1737835397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ywCH/SLKgogA9xDchCrsleSmFAAbZmIxUyWQVehcOpk=;
  b=IPcwDYMvlJpzaps4zTxGk0ISpN7LvWvHyPG0ah3SEDFrQ6z+2OZG137x
   6n15ze/KbIHe6kcIRBAQY2SbCApz22c6nqi7xVhATxxDzV3Mf00N/3Lny
   jwzfhStfURs6HPFQNw1CADtaamqLorZpC7VNVpBffrO07rRT+UEZLAKXT
   Vt1VXJoH4yvxTBMvl9BMjfmr9EkIR36/ij9TI1u6SWx5J9HlSA72/lcHX
   TaQDvsWDTtNlZj8sYRNGb9NkCymAVrY/w8vbyC3PEUy/ufuwzoJfG5ct0
   bntTKQfiWg9jq/e30sR6WwPXNlQ2wQhKIRQgqdRjxFSvz2mvksg3nJyhd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2447254"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2447254"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:03:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="910425321"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="910425321"
Received: from cheyunli-mobl1.amr.corp.intel.com (HELO [10.212.172.252]) ([10.212.172.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:03:15 -0800
Message-ID: <4aa2c961-a0dc-45dc-b996-57c8468660df@linux.intel.com>
Date: Fri, 26 Jan 2024 12:03:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 16/16] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240124125557.493675-17-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/24/24 4:55 AM, Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
>
> Add CPU offling support for the ACPI MADT wakeup method by implementing
> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
>
> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to a single CPU.
>
> The change conforms to the approved ACPI spec change proposal. See the
> Link.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  arch/x86/include/asm/acpi.h          |   2 +
>  arch/x86/kernel/acpi/Makefile        |   2 +-
>  arch/x86/kernel/acpi/madt_playdead.S |  28 ++++
>  arch/x86/kernel/acpi/madt_wakeup.c   | 184 ++++++++++++++++++++++++++-
>  include/acpi/actbl2.h                |  15 ++-
>  5 files changed, 227 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_playdead.S
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index 2625b915ae7f..021cafa214c2 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -81,6 +81,8 @@ union acpi_subtable_headers;
>  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  			      const unsigned long end);
>  
> +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> +
>  /*
>   * Check if the CPU can handle C2 and deeper
>   */
> diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> index 8c7329c88a75..37b1f28846de 100644
> --- a/arch/x86/kernel/acpi/Makefile
> +++ b/arch/x86/kernel/acpi/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_ACPI)			+= boot.o
>  obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
>  obj-$(CONFIG_ACPI_APEI)			+= apei.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> -obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
> +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt_playdead.o
>  
>  ifneq ($(CONFIG_ACPI_PROCESSOR),)
>  obj-y					+= cstate.o
> diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/acpi/madt_playdead.S
> new file mode 100644
> index 000000000000..4e498d28cdc8
> --- /dev/null
> +++ b/arch/x86/kernel/acpi/madt_playdead.S
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/linkage.h>
> +#include <asm/nospec-branch.h>
> +#include <asm/page_types.h>
> +#include <asm/processor-flags.h>
> +
> +	.text
> +	.align PAGE_SIZE
> +
> +/*
> + * asm_acpi_mp_play_dead() - Hand over control of the CPU to the BIOS
> + *
> + * rdi: Address of the ACPI MADT MPWK ResetVector
> + * rsi: PGD of the identity mapping
> + */
> +SYM_FUNC_START(asm_acpi_mp_play_dead)
> +	/* Turn off global entries. Following CR3 write will flush them. */
> +	movq	%cr4, %rdx
> +	andq	$~(X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4
> +
> +	/* Switch to identity mapping */
> +	movq	%rsi, %cr3
> +
> +	/* Jump to reset vector */
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rdi
> +SYM_FUNC_END(asm_acpi_mp_play_dead)
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 30820f9de5af..9e984e2191ba 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -1,10 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
> +#include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/kexec.h>
> +#include <linux/memblock.h>
> +#include <linux/pgtable.h>
> +#include <linux/sched/hotplug.h>
>  #include <asm/apic.h>
>  #include <asm/barrier.h>
> +#include <asm/init.h>
> +#include <asm/intel_pt.h>
> +#include <asm/nmi.h>
>  #include <asm/processor.h>
> +#include <asm/reboot.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
>  static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
> @@ -12,6 +21,154 @@ static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
>  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
>  
> +static u64 acpi_mp_pgd __ro_after_init;
> +static u64 acpi_mp_reset_vector_paddr __ro_after_init;
> +
> +static void acpi_mp_stop_this_cpu(void)
> +{
> +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr, acpi_mp_pgd);
> +}
> +
> +static void acpi_mp_play_dead(void)
> +{
> +	play_dead_common();
> +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr, acpi_mp_pgd);
> +}
> +
> +static void acpi_mp_cpu_die(unsigned int cpu)
> +{
> +	u32 apicid = per_cpu(x86_cpu_to_apicid, cpu);
> +	unsigned long timeout;
> +
> +	/*
> +	 * Use TEST mailbox command to prove that BIOS got control over
> +	 * the CPU before declaring it dead.
> +	 *
> +	 * BIOS has to clear 'command' field of the mailbox.
> +	 */
> +	acpi_mp_wake_mailbox->apic_id = apicid;
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_TEST);
> +
> +	/* Don't wait longer than a second. */
> +	timeout = USEC_PER_SEC;
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
> +		udelay(1);
> +
> +	if (!timeout)
Nit: IMO, since you are dumping failure error message (not timeout
message), you can use non zero acpi_mp_wake_mailbox->command
check. But it is up to you.
> +		pr_err("Failed to hand over CPU %d to BIOS\n", cpu);
> +}
> +
> +/* The argument is required to match type of x86_mapping_info::alloc_pgt_page */
> +static void __init *alloc_pgt_page(void *dummy)
> +{
> +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static void __init free_pgt_page(void *pgt, void *dummy)
> +{
> +	return memblock_free(pgt, PAGE_SIZE);
> +}
> +
> +/*
> + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> + * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
> + * to the identity mapping and the function has be present at the same spot in
> + * the virtual address space before and after switching page tables.
> + */
> +static int __init init_transition_pgtable(pgd_t *pgd)
> +{
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> +	unsigned long vaddr, paddr;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> +	pgd += pgd_index(vaddr);
> +	if (!pgd_present(*pgd)) {
> +		p4d = (p4d_t *)alloc_pgt_page(NULL);
> +		if (!p4d)
> +			return -ENOMEM;
> +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> +	}
> +	p4d = p4d_offset(pgd, vaddr);
> +	if (!p4d_present(*p4d)) {
> +		pud = (pud_t *)alloc_pgt_page(NULL);
> +		if (!pud)
> +			return -ENOMEM;
> +		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
> +	}
> +	pud = pud_offset(p4d, vaddr);
> +	if (!pud_present(*pud)) {
> +		pmd = (pmd_t *)alloc_pgt_page(NULL);
> +		if (!pmd)
> +			return -ENOMEM;
> +		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
> +	}
> +	pmd = pmd_offset(pud, vaddr);
> +	if (!pmd_present(*pmd)) {
> +		pte = (pte_t *)alloc_pgt_page(NULL);
> +		if (!pte)
> +			return -ENOMEM;
> +		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
> +	}
> +	pte = pte_offset_kernel(pmd, vaddr);
> +
> +	paddr = __pa(vaddr);
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> +
> +	return 0;
> +}
> +
> +static int __init acpi_mp_setup_reset(u64 reset_vector)
> +{
> +	pgd_t *pgd;
> +	struct x86_mapping_info info = {
> +		.alloc_pgt_page = alloc_pgt_page,
> +		.free_pgt_page	= free_pgt_page,
> +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> +	};
> +
> +	pgd = alloc_pgt_page(NULL);
> +	if (!pgd)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < nr_pfn_mapped; i++) {
> +		unsigned long mstart, mend;
> +
> +		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> +		mend   = pfn_mapped[i].end << PAGE_SHIFT;
> +		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
> +			kernel_ident_mapping_free(&info, pgd);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	if (kernel_ident_mapping_init(&info, pgd,
> +				      PAGE_ALIGN_DOWN(reset_vector),
> +				      PAGE_ALIGN(reset_vector + 1))) {
> +		kernel_ident_mapping_free(&info, pgd);
> +		return -ENOMEM;
> +	}
> +
> +	if (init_transition_pgtable(pgd)) {
> +		kernel_ident_mapping_free(&info, pgd);
> +		return -ENOMEM;
> +	}
> +
> +	smp_ops.play_dead = acpi_mp_play_dead;
> +	smp_ops.stop_this_cpu = acpi_mp_stop_this_cpu;
> +	smp_ops.cpu_die = acpi_mp_cpu_die;
> +
> +	acpi_mp_reset_vector_paddr = reset_vector;
> +	acpi_mp_pgd = __pa(pgd);
> +
> +	return 0;
> +}
> +
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {
>  	if (!acpi_mp_wake_mailbox_paddr) {
> @@ -97,14 +254,37 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	struct acpi_madt_multiproc_wakeup *mp_wake;
>  
>  	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> +
> +	/*
> +	 * Cannot use the standard BAD_MADT_ENTRY() to sanity check the @mp_wake
> +	 * entry.  'sizeof (struct acpi_madt_multiproc_wakeup)' can be larger
> +	 * than the actual size of the MP wakeup entry in ACPI table because the
> +	 * 'reset_vector' is only available in the V1 MP wakeup structure.
> +	 */
> +	if (!mp_wake)
> +		return -EINVAL;
> +	if (end - (unsigned long)mp_wake < ACPI_MADT_MP_WAKEUP_SIZE_V0)
> +		return -EINVAL;
> +	if (mp_wake->header.length < ACPI_MADT_MP_WAKEUP_SIZE_V0)
>  		return -EINVAL;
>  
>  	acpi_table_print_madt_entry(&header->common);
>  
>  	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
>  
> -	acpi_mp_disable_offlining(mp_wake);
> +	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
> +	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> +		if (acpi_mp_setup_reset(mp_wake->reset_vector)) {
> +			pr_warn("Failed to setup MADT reset vector\n");
> +			acpi_mp_disable_offlining(mp_wake);
> +		}
> +	} else {
> +		/*
> +		 * CPU offlining requires version 1 of the ACPI MADT wakeup
> +		 * structure.
> +		 */
> +		acpi_mp_disable_offlining(mp_wake);
> +	}
>  
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index e1a395af7591..2aedda70ef88 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -1120,8 +1120,20 @@ struct acpi_madt_multiproc_wakeup {
>  	u16 version;
>  	u32 reserved;		/* reserved - must be zero */
>  	u64 mailbox_address;
> +	u64 reset_vector;
>  };
>  
> +/* Values for Version field above */
> +
> +enum acpi_madt_multiproc_wakeup_version {
> +	ACPI_MADT_MP_WAKEUP_VERSION_NONE = 0,
> +	ACPI_MADT_MP_WAKEUP_VERSION_V1 = 1,
> +	ACPI_MADT_MP_WAKEUP_VERSION_RESERVED = 2, /* 2 and greater are reserved */
> +};
> +
> +#define ACPI_MADT_MP_WAKEUP_SIZE_V0	16
> +#define ACPI_MADT_MP_WAKEUP_SIZE_V1	24
> +
>  #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
>  #define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE  2048
>  
> @@ -1134,7 +1146,8 @@ struct acpi_madt_multiproc_wakeup_mailbox {
>  	u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];	/* reserved for firmware use */
>  };
>  
> -#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
> +#define ACPI_MP_WAKE_COMMAND_WAKEUP	1
> +#define ACPI_MP_WAKE_COMMAND_TEST	2
>  
>  /* 17: CPU Core Interrupt Controller (ACPI 6.5) */
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


