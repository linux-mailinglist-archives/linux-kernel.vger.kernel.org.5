Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7827CEB79
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJRWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:50:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C3114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:50:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697669424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YtWId1/SWWenZl2luC/PqpUeo0OsJMpmqJeBR+/Tyc=;
        b=uUvSPDd3XhrZhpXVA2631gq17qLnbviYXo2VUT5bMvPixVAZUthWGXaTxI82oto+xKrxMa
        U7mHXnc9KRutNVvW+SPZw0DbOfq+M9HDVYnx6VvUH1GSeguC2sMgEpvx3R5ukmC4mdLGWX
        cRALJjf3fIUYh32xw0/Lo58RpoA1AW95dNtV5qp3G4F/9Ss84uEkerD9PfNteSsU1vQYBq
        8++Q/8xBPiygSHzJxDnSs1hFwsAjS3UVXssASGCKLkPWhNeALDubAXc3KLSLdAzNvTcQB9
        NV1iHtmNqza8ZfD7WUUITr5oVPkdDnZS5+xAy+NAiqljVZdttmnph3ENcVqqqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697669424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YtWId1/SWWenZl2luC/PqpUeo0OsJMpmqJeBR+/Tyc=;
        b=gAqNJSgUCCme+WXPT5IqZCHeiPj3HxCYSeErhFzM4RH7udkSeH1WRcTehKpvleSV1K+EhK
        qBD0APyAHi9/pNCQ==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: PIC probing code from e179f6914152 failing
In-Reply-To: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
Date:   Thu, 19 Oct 2023 00:50:23 +0200
Message-ID: <878r7z4kb4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2023 at 13:50, Mario Limonciello wrote:
> Recently an issue was reported to Bugzilla [1] that the Keyboard (IRQ 1) 
> and GPIO controller (IRQ 7) weren't working properly on two separate 
> Lenovo machines.  The issues are unique to Linux.
>
> In digging through them, they happen because Lenovo didn't set up the 
> PIC in the BIOS.
> Specifically the PIC probing code introduced by e179f6914152 ("x86, irq, 
> pic: Probe for legacy PIC and set legacy_pic appropriately") expects 
> that the BIOS sets up the PIC and uses that assertion to let Linux set 
> it up.
>
> One of the reporters confirmed that reverting e179f6914152 fixes the 
> issue.  Keyboard and GPIO controller both work properly.
>
> I wanted to ask if we can please revert that and come up with a 
> different solution for kexec with HyperV.
> Can guests instead perhaps detect in early boot code they're running in 
> an EFI based hypervisor and explicitly set 'legacy_pic = &null_legacy_pic;'?

No. This detection mechanism prevents PIC usage also in other
scenarios.

It's perfectly valid code and the assumption that you can read back what
you wrote to the master IMR is entirely correct. If that's not the case
then there is no PIC, the BIOS has disabled some parts of the legacy
block or did not initialize it.

Letting the kernel blindly assume that there is always a PIC is just
wrong. Worse, it puts the burden on everyone else to sprinkle
"legacy_pic = null_pic;" all over the place with dubious
conditions. That's exactly what the commit in question avoided.

So no, we are not going back there.

We could obviously change the probe() function to issue a full PIC
initialization sequence before reading a known written value
back. That's basically what the revert causes to happen via
legacy_pic->init().

But I fundamentally hate to do that because forcing the init sequence
just to make presumably broken code which has some dubious dependencies
on the PIC or on nr_legacy_irqs > 0 happy is not really a solution when
the PIC is actually not needed at all. For anything modern where all
legacy interrupts are routed to the IO/APIC the PIC does not make any
sense whatsoever.

We rather go and fix the real underlying problem.

The kernel can handle the legacy interrupts perfectly fine through the
IOAPIC. There is no hard requirement for the PIC at all except for
really old systems which had the timer interrupt wired to the PIC and
therefore required to route the timer interrupt through the PIC instead
of the IO/APIC or did not provide routing entries for the IO/APIC. See
the horrible hackery in check_timer() and the grossly misnomed
init_IO_APIC_traps().

I just took a random machine, forced the NULL PIC and added
'apic=verbose' to the kernel command line and magically all the legacy
interrupts are set up via IO/APIC despite the NULL PIC and therefore 0
preallocated legacy interrupts.

  apic 0 pin 0 not connected
 IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
 IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 2 Level:0 ActiveLow:0)
 IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
 ...

which is identical to the output with PIC enabled. That debug message is
emitted from mp_irqdomain_alloc() which is invoked via the PNP resource
management code.

Now /proc/interrupts:

           CPU0       CPU1       CPU2       CPU3        
  1:          0         56          0          0    IO-APIC   1-edge      i8042
  4:        442          0          0          0    IO-APIC   4-edge      ttyS0
  8:          0          0          0          0    IO-APIC   8-edge      rtc0
  9:          0          0          0          0    IO-APIC   9-fasteoi   acpi
 12:          0          0        122          0    IO-APIC  12-edge      i8042

Keyboard and serial are working, see?

The only interrupt which does not work is interrupt 0 because nothing
allocates interrupt 0 due to nr_legacy_irqs == 0, but that's a trivially
solvable problem.

That machine does not even need the timer interrupt because it has a
usable APIC and TSC deadline timer, so no APIC timer calibration
required. The same is true for CPUs which do not have a TSC deadline
timer, but enumerate the APIC frequency via CPUID or MSRs.

But that brings up an interesting question. How are those affected
machines even reaching a state where the user notices that just the
keyboard and the GPIO are not working? Why?

The CPUID/MSR APIC frequency enumeration is Intel specific and
everything else depends on a working timer interrupt to calibrate the
APIC timer frequency. So AMD CPUs require the timer interrupt to
work. The only explanation why this "works" in that null PIC case is
that the PIT/HPET interrupt is actually wired to pin 0, but that's
something to be determined...

Can I please get the following information from an affected machine:

  1) dmesg with 'apic=verbose' on the command line
  2) /proc/interrupts
  3) /sys/kernel/debug/irq/irqs/{0..15}

  #3 requires CONFIG_GENERIC_IRQ_DEBUGFS to be set.

Two versions of that please:

  1) Unpatched kernel
  2) Patched kernel

Thanks,

        tglx
