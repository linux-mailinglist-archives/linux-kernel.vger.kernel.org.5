Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB07DAD83
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJ2Rbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2Rbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:31:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB4AC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:31:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698600697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czSOa5APrOwjC65ep3L/a1WR9+Fo2vLgEdO5NlLCZ+I=;
        b=2PIwh5kyXQzqCeOIiA4cyNwO8zpXypEZ1IiB+LETWHzyiH3I8lJV2yOgROI9P6Ta/DzxRb
        hQzLFDufb2/I7bwXFuSbBTFPqtAYCf0I2L6Lc5nYmLdKneRZiQ9J/ii+njnEpX2t68mMwz
        0n1BDL237R4UOZgjlrJIdDQB7xnumbcnxhoy32t/j26zB4s7igEvdRPaoxaoHN+eKNTkZy
        TZLx5b+lpzjq6G0T9UgGqKv/ykBoUnpao64mRbcJhdH2PAcG8b+h4UO9/W8aXItg1Sn3Ub
        eQBs0m+Fm1ul0z3LHFOWNjJpjT/J3IwUZny/St2TdSGuuYkp1F+WnAr/V7oQrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698600697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czSOa5APrOwjC65ep3L/a1WR9+Fo2vLgEdO5NlLCZ+I=;
        b=XsE2YM75vIZT3fXLsB5H3/kl4eVCN8+NkkulTnWltOymrlVwQMVFKnk9evBb4EdoJU+qtF
        qfPw/WF2mNWRUfCg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
In-Reply-To: <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
Date:   Sun, 29 Oct 2023 18:31:36 +0100
Message-ID: <87r0ldz66f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:

> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> offline itself. The new TEST mailbox command can be used to test the CPU
> offlined successfully and BIOS has control over it.
>
> Add CPU offling support for ACPI MADT wakeup method by implementing
> custom cpu_die, play_dead and stop_other_cpus SMP operations.
>
> CPU offlining makes possible to hand over secondary CPUs over kexec, not

makes it possible

> limiting the second kernel with single CPU.

s/with/to/

> The change conforms to the approved ACPI spec change proposal. See the
> +SYM_FUNC_START(asm_acpi_mp_play_dead)
> +	/* Load address of reset vector into RCX to jump when kernel is ready */
> +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> +
> +	/* Turn off global entries. Following CR3 write will flush them. */
> +	movq	%cr4, %rdx
> +	andq	$~(X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4
> +
> +	/* Switch to identity mapping */
> +	movq	acpi_mp_pgd(%rip), %rax
> +	movq	%rax, %cr3

You can just make this function:

    asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);

then you have the reset vector in RDI and the pgd in RSI and spare the
global variables.

>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> @@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
>  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
>  
> +u64 acpi_mp_pgd;
> +u64 acpi_mp_reset_vector_paddr;

See above (static) and __ro_after_init please

> +
> +void asm_acpi_mp_play_dead(void);
> +
> +static void __init *alloc_pgt_page(void *context)
> +{

What's the purpose of the context argument?

> +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +/*
> + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> + * the same place as in the kernel page tables. The function switches to
> + * the identity mapping and has be present at the same spot in before and
> + * after transition.

Why does it need to be there after the CPU jumped to the reset vector?

> + */
> +static int __init init_transition_pgtable(pgd_t *pgd)
> +{
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> +	unsigned long vaddr, paddr;
> +	int result = -ENOMEM;
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
> +			goto err;

        return -ENOMEM?

the error labels is pretty silly without an actual cleanup, right?

> +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> +	}
> +	p4d = p4d_offset(pgd, vaddr);
> +	if (!p4d_present(*p4d)) {
> +		pud = (pud_t *)alloc_pgt_page(NULL);
> +		if (!pud)
> +			goto err;

Ditto. But what mops up the already allocated page above?
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> +
> +	return 0;
> +err:
> +	return result;
> +}

Can you please move that function to the place where it is used?

> +
> +static void acpi_mp_play_dead(void)
> +{
> +	play_dead_common();
> +	asm_acpi_mp_play_dead();
> +}
> +
> +static void acpi_mp_cpu_die(unsigned int cpu)
> +{
> +	int apicid = per_cpu(x86_cpu_to_apicid, cpu);

u32 apicid

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
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> +		udelay(1);
> +}
> +
> +static void acpi_mp_stop_other_cpus(int wait)
> +{
> +	smp_shutdown_nonboot_cpus(smp_processor_id());

This clearly was never tested with lockdep. At the point where
stop_other_cpus() is invoked the invoking CPU has interrupts disabled...

> +}
> +
> +static void acpi_mp_crash_stop_other_cpus(void)
> +{
> +	smp_shutdown_nonboot_cpus(smp_processor_id());

Yuck. Crash can happen at arbitrary places. So you really cannot invoke
the whole CPU hotplug state machine from here.

There is a reason why the other implementation just kick CPUs into some
"safe" state.

> +	/* The kernel is broken so disable interrupts */
> +	local_irq_disable();
> +}
> +
> +static int __init acpi_mp_setup_reset(u64 reset_vector)
> +{
> +	pgd_t *pgd;
> +	struct x86_mapping_info info = {
> +		.alloc_pgt_page = alloc_pgt_page,
> +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> +	};
> +
> +	pgd = alloc_pgt_page(NULL);
> +
> +	for (int i = 0; i < nr_pfn_mapped; i++) {
> +		unsigned long mstart, mend;

Missing newline

> +		mstart = pfn_mapped[i].start << PAGE_SHIFT;
> +		mend   = pfn_mapped[i].end << PAGE_SHIFT;
> +		if (kernel_ident_mapping_init(&info, pgd, mstart, mend))
> +			return -ENOMEM;
> +	}
> +
> +	if (kernel_ident_mapping_init(&info, pgd,
> +				      PAGE_ALIGN_DOWN(reset_vector),
> +				      PAGE_ALIGN(reset_vector + 1))) {
> +		return -ENOMEM;
> +	}
> +
> +	if (init_transition_pgtable(pgd))
> +		return -ENOMEM;
> +
> +	smp_ops.play_dead = acpi_mp_play_dead;
> +	smp_ops.cpu_die = acpi_mp_cpu_die;
> +	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
> +	smp_ops.crash_stop_other_cpus = acpi_mp_crash_stop_other_cpus;
> +
> +	acpi_mp_reset_vector_paddr = reset_vector;
> +	acpi_mp_pgd = __pa(pgd);
> +
> +	return 0;
> +}
> +
>  static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
>  {
>  	if (!acpi_mp_wake_mailbox_paddr) {
> @@ -74,31 +223,43 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  	struct acpi_madt_multiproc_wakeup *mp_wake;
>  
>  	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> +	if (!mp_wake)
> +		return -EINVAL;
> +
> +	if (end - (unsigned long)mp_wake < ACPI_MADT_MP_WAKEUP_SIZE_V0)
> +		return -EINVAL;
> +	if (mp_wake->header.length < ACPI_MADT_MP_WAKEUP_SIZE_V0)
>  		return -EINVAL;
>  
>  	acpi_table_print_madt_entry(&header->common);
>  
>  	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
>  
> -	cpu_hotplug_disable_offlining();
> +	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
> +	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
> +		acpi_mp_setup_reset(mp_wake->reset_vector);
> +	} else {
> +		cpu_hotplug_disable_offlining();
>  
> -	/*
> -	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> -	 * It limits kexec: the second kernel won't be able to use more than
> -	 * one CPU.
> -	 *
> -	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> -	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> -	 *
> -	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> -	 * indicate that the mailbox is not usable.  This prevents the
> -	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> -	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> -	 *
> -	 * This is Linux-specific protocol and not reflected in ACPI spec.
> -	 */
> -	mp_wake->mailbox_address = 0;
> +		/*
> +		 * ACPI MADT doesn't allow to offline CPU after it got woke up.

This is not longer accurate as V1 allows that ....

> +		 * It limits kexec: the second kernel won't be able to use more
> +		 * than one CPU.

Thanks,

        tglx
