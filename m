Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939417DE1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbjKAN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbjKAN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:26:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573ECF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698845185; x=1730381185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05eUvS3RedhhXCBFQIn/RW/rMVXJukr5CxJro4wh1PM=;
  b=n2d+LIq7WfEHp8Al0o11a24j7406hEospjbKiuh0wmTRAm6Q5aftN/+X
   f0ISd+6Ob60gLIR82Cz9Hnx6f4OVyKQ5vnGRV7xmPbRo2jTnAaTWIO2D4
   VdKY2TNU+ZleWyJsGWSjQg+i5eJ0Cvfo40CGwr/bT/AIxawyPtxFG93Dc
   D1OI/9ZaJo5WyqJwBgzRvpVjX7lyc4S1yppdA7m6yP8VGLV3v4smwQQ4/
   WSn6CUHFGs9EGZZykKeLHfxm9rMGDUFXYVWqowUJGV1qMeLlHYSxEx2B/
   HTfrPUTMRRMtpiGgiUWr7rT9Ce2zToS7xU/kRwTEWuo17ZHOnwW9Q7VbQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388310493"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="388310493"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:26:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760940760"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760940760"
Received: from ddraghic-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:26:19 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8E58E10A2F9; Wed,  1 Nov 2023 16:26:16 +0300 (+03)
Date:   Wed, 1 Nov 2023 16:26:16 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231101132616.nviynrbb53acpnv5@box>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
 <87r0ldz66f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0ldz66f.ffs@tglx>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 06:31:36PM +0100, Thomas Gleixner wrote:
> On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:
> 
> > MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> > offlining: BIOS provides a reset vector where the CPU has to jump to
> > offline itself. The new TEST mailbox command can be used to test the CPU
> > offlined successfully and BIOS has control over it.
> >
> > Add CPU offling support for ACPI MADT wakeup method by implementing
> > custom cpu_die, play_dead and stop_other_cpus SMP operations.
> >
> > CPU offlining makes possible to hand over secondary CPUs over kexec, not
> 
> makes it possible
> 
> > limiting the second kernel with single CPU.
> 
> s/with/to/

Okay.

> > The change conforms to the approved ACPI spec change proposal. See the
> > +SYM_FUNC_START(asm_acpi_mp_play_dead)
> > +	/* Load address of reset vector into RCX to jump when kernel is ready */
> > +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> > +
> > +	/* Turn off global entries. Following CR3 write will flush them. */
> > +	movq	%cr4, %rdx
> > +	andq	$~(X86_CR4_PGE), %rdx
> > +	movq	%rdx, %cr4
> > +
> > +	/* Switch to identity mapping */
> > +	movq	acpi_mp_pgd(%rip), %rax
> > +	movq	%rax, %cr3
> 
> You can just make this function:
> 
>     asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> 
> then you have the reset vector in RDI and the pgd in RSI and spare the
> global variables.

Yeah, it is better. Thanks.

> >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> > @@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> > +u64 acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> 
> See above (static) and __ro_after_init please
> 
> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> 
> What's the purpose of the context argument?

To conform to x86_mapping_info::alloc_pgt_page type.

I will rename the argument to 'dummy' and add comment.

> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +/*
> > + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> > + * the same place as in the kernel page tables. The function switches to
> > + * the identity mapping and has be present at the same spot in before and
> > + * after transition.
> 
> Why does it need to be there after the CPU jumped to the reset vector?

After transition to the identity mapping, not after jumping to reset
vector. I will adjust the comment.

> > + */
> > +static int __init init_transition_pgtable(pgd_t *pgd)
> > +{
> > +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> > +	unsigned long vaddr, paddr;
> > +	int result = -ENOMEM;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +	pte_t *pte;
> > +
> > +	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> > +	pgd += pgd_index(vaddr);
> > +	if (!pgd_present(*pgd)) {
> > +		p4d = (p4d_t *)alloc_pgt_page(NULL);
> > +		if (!p4d)
> > +			goto err;
> 
>         return -ENOMEM?
> 
> the error labels is pretty silly without an actual cleanup, right?

Right.

> > +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> > +	}
> > +	p4d = p4d_offset(pgd, vaddr);
> > +	if (!p4d_present(*p4d)) {
> > +		pud = (pud_t *)alloc_pgt_page(NULL);
> > +		if (!pud)
> > +			goto err;
> 
> Ditto. But what mops up the already allocated page above?

Oops. I will add cleanup in acpi_mp_setup_reset() if
kernel_ident_mapping_init() or init_transition_pgtable() fails.

> > +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> > +
> > +	return 0;
> > +err:
> > +	return result;
> > +}
> 
> Can you please move that function to the place where it is used?

Sure.

> > +
> > +static void acpi_mp_play_dead(void)
> > +{
> > +	play_dead_common();
> > +	asm_acpi_mp_play_dead();
> > +}
> > +
> > +static void acpi_mp_cpu_die(unsigned int cpu)
> > +{
> > +	int apicid = per_cpu(x86_cpu_to_apicid, cpu);
> 
> u32 apicid

Okay.

> > +	unsigned long timeout;
> > +
> > +	/*
> > +	 * Use TEST mailbox command to prove that BIOS got control over
> > +	 * the CPU before declaring it dead.
> > +	 *
> > +	 * BIOS has to clear 'command' field of the mailbox.
> > +	 */
> > +	acpi_mp_wake_mailbox->apic_id = apicid;
> > +	smp_store_release(&acpi_mp_wake_mailbox->command,
> > +			  ACPI_MP_WAKE_COMMAND_TEST);
> > +
> > +	/* Don't wait longer than a second. */
> > +	timeout = USEC_PER_SEC;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> > +		udelay(1);
> > +}
> > +
> > +static void acpi_mp_stop_other_cpus(int wait)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> 
> This clearly was never tested with lockdep. At the point where
> stop_other_cpus() is invoked the invoking CPU has interrupts disabled...

Hm. I do have lockdep enabled and there's no reported.

And I am not sure why it should complain. At this point we are running on
reboot cpu (after migrate_to_reboot_cpu()).

Could you elaborate on what the problem here?

> > +}
> > +
> > +static void acpi_mp_crash_stop_other_cpus(void)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> 
> Yuck. Crash can happen at arbitrary places. So you really cannot invoke
> the whole CPU hotplug state machine from here.
> 
> There is a reason why the other implementation just kick CPUs into some
> "safe" state.

Yeah, fair enough.

What about the implementation below? It is heavily inspired by
nmi_shootdown_cpus().

BTW, I don't understand why nmi_shootdown_cpus() needs 'crashing_cpu' if
it uses apic_send_IPI_allbutself(). 'crashing_cpu' == self, no?


static atomic_t waiting_for_crash_ipi;
static bool crash_ipi_issued;

static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
{
	local_irq_disable();

	crash_save_cpu(regs, raw_smp_processor_id());

	cpu_emergency_stop_pt();

	disable_local_APIC();

	/*
	 * Prepare the CPU for reboot _after_ invoking the callback so that the
	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
	 */
	cpu_emergency_disable_virtualization();

	atomic_dec(&waiting_for_crash_ipi);

	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
			      acpi_mp_pgd);

	return NMI_HANDLED;
}

static void acpi_mp_crash_stop_other_cpus(void)
{
	unsigned long timeout;

	/* The kernel is broken so disable interrupts */
	local_irq_disable();

	/*
	 * Avoid certain doom if a shootdown already occurred; re-registering
	 * the NMI handler will cause list corruption, modifying the callback
	 * will do who knows what, etc...
	 */
	if (WARN_ON_ONCE(crash_ipi_issued))
		return;

	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);

	/* Would it be better to replace the trap vector here? */
	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
				 NMI_FLAG_FIRST, "crash"))
		return;		/* Return what? */

	apic_send_IPI_allbutself(NMI_VECTOR);

	WRITE_ONCE(crash_ipi_issued, 1);

	/* Don't wait longer than a second. */
	timeout = USEC_PER_SEC;
	while (atomic_read(&waiting_for_crash_ipi) && timeout--)
		udelay(1);
}

> > +	/* The kernel is broken so disable interrupts */
> > +	local_irq_disable();
> > +}
> > +
> > +static int __init acpi_mp_setup_reset(u64 reset_vector)
> > +{
> > +	pgd_t *pgd;
> > +	struct x86_mapping_info info = {
> > +		.alloc_pgt_page = alloc_pgt_page,
> > +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> > +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> > +	};
> > +
> > +	pgd = alloc_pgt_page(NULL);
> > +
> > +	for (int i = 0; i < nr_pfn_mapped; i++) {
> > +		unsigned long mstart, mend;
> 
> Missing newline
> 

Okay.

> >  
> > -	/*
> > -	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> > -	 * It limits kexec: the second kernel won't be able to use more than
> > -	 * one CPU.
> > -	 *
> > -	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> > -	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> > -	 *
> > -	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> > -	 * indicate that the mailbox is not usable.  This prevents the
> > -	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> > -	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> > -	 *
> > -	 * This is Linux-specific protocol and not reflected in ACPI spec.
> > -	 */
> > -	mp_wake->mailbox_address = 0;
> > +		/*
> > +		 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> 
> This is not longer accurate as V1 allows that ....
> 

Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
