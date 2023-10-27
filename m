Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9522F7DA27D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbjJ0VbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbjJ0VbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:31:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD431AA;
        Fri, 27 Oct 2023 14:31:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698442270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3ydkUdxmdu8Q6Xk3rvcibo+LtnkXdHvqYhmoDPKsk0=;
        b=nFlv+Yk1z3jyLLIFAQyCeF9SWE2sCxPSfuj/MEC+4J6iIOnrUXp45E478PpdIiKQAShYyH
        qiWbJTMdNqAvI9bF1Sm+VyXNvHuZqReKJAj1X0piZU/jZsjhvmaXuflJNy+nnww75E4BTK
        8GO4iHybdoqzWBkrjkrIROnID0CDGB9CHRzjqNcB2S+CbK9AlwcEFenUqjpVvT470e1IGu
        VGvCCxwUlP42vN8rO6AfTyXoeYHZnGUrCSgpoD43/DKPddBtzkbUICdkfY60F/O2STtf8o
        /9FxpRPa1IZWvDTgyt9U+SsKzd1a7DD/CSSrAPRhJoCws0vKZFQsj9K+vxxu0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698442270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3ydkUdxmdu8Q6Xk3rvcibo+LtnkXdHvqYhmoDPKsk0=;
        b=k1Rp8X7eqTciHkSjcLMawHwC8l0e17/+XNPsMe0oHUwLoUOrFYnX+4xCt3ncmOy0sUkbNa
        oAtD5YRRzDOfKYDg==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/2] x86: Enable x2apic during resume from suspend if
 used previously
In-Reply-To: <20231026170330.4657-2-mario.limonciello@amd.com>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <20231026170330.4657-2-mario.limonciello@amd.com>
Date:   Fri, 27 Oct 2023 23:31:09 +0200
Message-ID: <87wmv721nm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario!

On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:

> If x2apic was enabled during boot with parallel startup
> it will be needed during resume from suspend to ram as well.

Lacks an explanation why it is needed.

> Store whether to enable into the smpboot_control global variable
> and during startup re-enable it if necessary.
>
> This fixes resume from suspend on workstation CPUs with x2apic
> enabled.

You completely fail to describe the failure mode.

> It will also work on systems with one maxcpus=1 but still using
> x2apic since x2apic is also re-enabled in lapic_resume().

This sentence makes no sense. What's so special about maxcpus=1?

Absolutely nothing.

lapic_resume() is a syscore op and is always invoked on the CPU which
handles suspend/resume. The point is that __x2apic_enable() which is
invoked from there becomes a NOOP because X2APIC is already enabled.

So what are you trying to tell me?

I really appreciate your enthusiasm of chasing and fixing bugs, but your
change logs and explanations are really making it hard to keep that
appreciation up.

>  	/*
> -	 * Ensure the CPU knows which one it is when it comes back, if
> -	 * it isn't in parallel mode and expected to work that out for
> -	 * itself.
> +	 * Ensure x2apic is re-enabled if necessary and the CPU knows which
> +	 * one it is when it comes back, if it isn't in parallel mode and
> +	 * expected to work that out for itself.

The x2apic comment is misplaced. It should be above the x2apic
conditional as it has nothing to do with the initial condition because
even if X2APIC is enabled then the parallel startup might be disabled.

Go and read this comment 3 month from now and try to make sense of it.

>  	 */
> -	if (!(smpboot_control & STARTUP_PARALLEL_MASK))
> +	if (smpboot_control & STARTUP_PARALLEL_MASK) {
> +		if (x2apic_enabled())
> +			smpboot_control |= STARTUP_ENABLE_X2APIC;

This bit is sticky after resume, so any subsequent CPU hotplug operation
will see it as well.

This lacks an explanation why this is correct and why this flag is not
set early during boot before the APs are brought up.

> +	} else {
>  		smpboot_control = smp_processor_id();
> +	}
>  #endif
>  	initial_code = (unsigned long)wakeup_long64;
>  	saved_magic = 0x123456789abcdef0L;
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index ea6995920b7a..300901af9fa3 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -237,9 +237,14 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	 * CPU number is encoded in smpboot_control.
>  	 *
>  	 * Bit 31	STARTUP_READ_APICID (Read APICID from APIC)
> +	 * Bit 30	STARTUP_ENABLE_X2APIC (Enable X2APIC mode)
>  	 * Bit 0-23	CPU# if STARTUP_xx flags are not set
>  	 */
>  	movl	smpboot_control(%rip), %ecx
> +
> +	testl	$STARTUP_ENABLE_X2APIC, %ecx
> +	jnz	.Lenable_x2apic

Why is this tested here? The test clearly belongs into .Lread_apicid

> +
>  	testl	$STARTUP_READ_APICID, %ecx
>  	jnz	.Lread_apicid
>  	/*
> @@ -249,6 +254,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	andl	$(~STARTUP_PARALLEL_MASK), %ecx
>  	jmp	.Lsetup_cpu
>  
> +.Lenable_x2apic:
> +	/* Enable X2APIC if disabled */
> +	mov	$MSR_IA32_APICBASE, %ecx
> +	rdmsr
> +	testl	$X2APIC_ENABLE, %eax
> +	jnz	.Lread_apicid_msr
> +	orl	$X2APIC_ENABLE, %eax
> +	wrmsr
> +	jmp	.Lread_apicid_msr

And this part just moves in front of .Lread_apicid_msr and spares
the jump at the end.

>  .Lread_apicid:
>  	/* Check whether X2APIC mode is already enabled */
>  	mov	$MSR_IA32_APICBASE, %ecx

That aside, I'm still failing to see the actual failure scenario due to
the utter void in the change log.

The kernel has two mechanisms which end up with X2APIC enabled:

    1) BIOS has it enabled already, which is required for any machine
       which has more than 255 CPUs, but BIOS can decide to enable
       X2APIC even with less than 256 CPUs.

    2) BIOS has not enabled it, but the kernel enables it because the
       CPU supports it.

The major difference is:

    #1 prevents the MMIO fixmap for the APIC to be installed

    #2 installs the fixmap but does not use it. It's never torn down.

Let's look at these two cases in the light of resume:

    #1 If the BIOS enabled X2APIC mode then the only way how this can
       fail on resume is that the BIOS did not enable X2APIC mode in the
       resume path before going back into the kernel and due to the
       non-existent MMIO mapping there is no way to read the APIC ID.

    #2 It does not matter whether the BIOS enabled X2APIC mode during
       resume because the MMIO mapping exists and the APIC ID read via
       MMIO should be identical to the APIC ID read via the X2APIC MSR.

       If not, then there is something fundamentally wrong.

How is this working during the initial bringup of the APs?

    #1 If the APs do not have X2APIC enabled by the BIOS then they will
       crash and burn during bringup due to non-existent MMIO mapping.

    #2 The APs can read their APIC ID just fine via MMIO and it
       obviously is the same as the APIC ID after the bringup enabled
       X2APIC mode. Otherwise the kernel would not work at all.

So the only reasonable explanation for the failure is that the BIOS
fails to reenable X2APIC mode on resume either on the CPU which handles
suspend/resume or on the subsequent AP bringups, which is not clear at
all due to the bit being sticky and the changelog being full of void in
that aspect.

That said the sticky bit is wrong for the following case with older CPUs
where X2APIC requires up to date microcode loaded to work correctly:

    boot maxcpus=4
      load microcode    // Same sequence applies for AP (CPU1-3)
      enable x2apic
    suspend
       set X2APIC enable bit in smpboot_control
    resume
    bringup CPU4
       enable X2APIC early --> fail due to lack of microcode fix

Whether this affects the APIC ID readout or not, which we don't know and
even if we consider this case to be academic, it's still fundamentally
wrong from a correctness point of view.

So without proper information about the failure scenario this "fix" is
simply going nowhere.

Please provide the following information:

  - dmesg of the initial boot up to 'smp: Bringing up secondary CPUs ...'

  - A proper description of the failure case:

    - Is the CPU which handles suspend/resume failing?

    - Is a subsequent AP bringup failing?

    - Is the failure due to the lack of MMIO mapping ?

    - Is the failure due to a bogus APIC ID retrieved via MMIO ?

Thanks for making me do your homework (again),

        tglx
