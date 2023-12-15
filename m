Return-Path: <linux-kernel+bounces-1626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25181510E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F21C240FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE445C16;
	Fri, 15 Dec 2023 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TtQP+GF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d849ArFb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11A45BE8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702672154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdq43RkAMkdg64YcpCIrr5Wg9aGVqWCQPynJbOk//bU=;
	b=TtQP+GF6498gZz0p5GV9BYwaeHviZOgZWKhk7Fv+0l5DAjQSNO16kXf3H/3Ec5x3Zk3veD
	6Mv5luUPKrBmwgLzqIVKZ30I8T6Ups/t+8RG12TESFuVzfjai1GtQUnyNz5zukSJWVPq2V
	rGUz8E090pXzNqQpRxLd4Cw1tIvIaNsyJ7pGGdpaa6SRXPiO3btEE8U/IYdNzx7OJvLdg+
	nCI5OUFbKeewFcermt0SokMBUzIzVSA4kVzN72x5qOCY/ybspROM1CwFd/DYelIRac4CMW
	nQY3av0SKR8IiRif3d2L0DtL423+Xix5WKG5FlEkcKnkKjYJBk2xd4rCNsCmig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702672154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pdq43RkAMkdg64YcpCIrr5Wg9aGVqWCQPynJbOk//bU=;
	b=d849ArFbwUVVVXS+AJgHszyAoTXPSCgpdH4Mzi0wPuRdF+SUHe3NpdPovJ4cHqVgo4s2tC
	1hKUNFtrIwjsXgDQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv4 14/14] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
In-Reply-To: <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-15-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 21:29:13 +0100
Message-ID: <877clfmcpy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 05 2023 at 03:45, Kirill A. Shutemov wrote:

> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> offline itself.

CPU has to jump to for offlining itself.

> The new TEST mailbox command can be used to test the CPU offlined
> successfully and BIOS has control over it.

test whether the CPU offlined itself which means the BIOS has control
over the CPU and can online it again via the ACPI MADT wakeup method.

> Add CPU offling support for ACPI MADT wakeup method by implementing

for the ACPI

> custom cpu_die, play_dead and stop_other_cpus SMP operations.

cpu_die(), play_dead() ...

> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to single CPU.

to a single CPU.

> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index 4fab2ed454f3..3c8efba86d5c 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -38,6 +38,7 @@ struct smp_ops {
>  	int (*cpu_disable)(void);
>  	void (*cpu_die)(unsigned int cpu);
>  	void (*play_dead)(void);
> +	void (*crash_play_dead)(void);

This new callback and the callsite change wants to be introduced in a
preparatory patch. This one is doing too many things at once, really.
  
> diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/acpi/madt_playdead.S
> new file mode 100644
> index 000000000000..68f83865a1e3
> --- /dev/null
> +++ b/arch/x86/kernel/acpi/madt_playdead.S
> @@ -0,0 +1,21 @@
> +#include <linux/linkage.h>
> +#include <asm/nospec-branch.h>
> +#include <asm/page_types.h>
> +#include <asm/processor-flags.h>
> +
> +	.text
> +	.align PAGE_SIZE

Newline please

Please document what the register arguments to this function are.

> +SYM_FUNC_START(asm_acpi_mp_play_dead)
> +	/* Turn off global entries. Following CR3 write will flush them. */
> +	movq	%cr4, %rdx
> +	andq	$~(X86_CR4_PGE), %rdx
> +	movq	%rdx, %cr4
> +
> +	/* Switch to identity mapping */
> +	movq	%rsi, %rax
> +	movq	%rax, %cr3
> +
> +	/* Jump to reset vector */
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp	*%rdi
> +SYM_FUNC_END(asm_acpi_mp_play_dead)

> +static u64 acpi_mp_pgd __ro_after_init;
> +static u64 acpi_mp_reset_vector_paddr __ro_after_init;
> +
> +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);

Declarations want to be in a header file.

> +static void crash_acpi_mp_play_dead(void)
> +{
> +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
> +			      acpi_mp_pgd);

Pointless line break.

> +}
> +
> +static void acpi_mp_play_dead(void)
> +{
> +	play_dead_common();
> +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
> +			      acpi_mp_pgd);

Ditto.

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
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> +		udelay(1);

So this waits and then does nothing if the wait fails. What's the point?

...
<SNIP 170 lines of pagetable muck>

Do we really need this specific hackery or is there some similar
identity mapping muck which can be generalized?

> +	smp_ops.play_dead = acpi_mp_play_dead;
> +	smp_ops.crash_play_dead = crash_acpi_mp_play_dead;
> +	smp_ops.cpu_die = acpi_mp_cpu_die;
> +	smp_ops.stop_other_cpus = acpi_mp_stop_other_cpus;
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
> @@ -68,37 +299,63 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  	return 0;
>  }
>  
> +static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
> +{
> +	cpu_hotplug_disable_offlining();
> +
> +	/*
> +	 * Zero out mailbox address in the ACPI MADT wakeup structure
> +	 * to indicate that the mailbox is not usable.  This prevents
> +	 * the kexec()-ed kernel from reading a vaild mailbox, which in
> +	 * turn makes the kexec()-ed kernel only be able to use the boot
> +	 * CPU.
> +	 *
> +	 * This is Linux-specific protocol and not reflected in ACPI spec.
> +	 *
> +	 * acpi_mp_wake_mailbox_paddr already has the mailbox address.
> +	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus for
> +	 * the current kernel.
> +	 */
> +	mp_wake->mailbox_address = 0;
> +}

The previous patch could have split this out into a helper already, no?

> +
>  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
>  			      const unsigned long end)
>  {
>  	struct acpi_madt_multiproc_wakeup *mp_wake;
>  
>  	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> +
> +        /*
> +         * Cannot use the standard BAD_MADT_ENTRY() to sanity check the @mp_wake
> +         * entry.  'sizeof (struct acpi_madt_multiproc_wakeup)' can be larger
> +         * than the actual size of the MP wakeup entry in ACPI table because the
> +	 * 'reset_vector' is only available in the V1 MP wakeup structure.
> +         */

The comment is white space damaged. Use tabs everywhere please and not
only in one line.

Thanks,

        tglx

