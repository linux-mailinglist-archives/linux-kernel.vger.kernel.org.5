Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80B17D3B91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjJWP7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:59:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86577FF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:59:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698076757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ge7YpKS4lssiAYM57LXq+mqFDhr1vlGo6+N9KkTg1zc=;
        b=bpS9Eld8DBfJKJj232XqAploXznxrTK74B1at6SgN3SA59zoBSbspQjFle1B9eyIPvjW87
        XFqmt9UBT1HRrEzH7ZvCxQhj+FQSKHhr9ht4WQ/Xq0ZOrwZsV61z7RpMZ27ext9d2WbUb0
        a1oxKnjfX+/MaAhYR7UAMQqgswmUHZKVkhcy9yIn9v5CBLlM+WP4O2QCe6sJZRqNgCP3RG
        fGiBOSvCkIiiMftLs5yYzhYlWzFJc0s0nsqzol/OVlAR7hDQkObJW9Qiq9CA3f47DABLXK
        Tv+XH5njML+ELM6Z8qKbK0gR+r1/K3ZRr3bhMSp45w7WV43KTp1AVUEZZb1ibg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698076757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ge7YpKS4lssiAYM57LXq+mqFDhr1vlGo6+N9KkTg1zc=;
        b=CxujF1Mzrlhll7LfvH1lqopCZxUo4lOaGqs+sOYBy9rPaDygfQh1C4jmRNaB2B8WxaY5Jv
        WMmSsa85010O84BA==
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: PIC probing code from e179f6914152 failing
In-Reply-To: <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx> <e79dea49-0c07-4ca2-b359-97dd1bc579c8@amd.com>
Date:   Mon, 23 Oct 2023 17:59:16 +0200
Message-ID: <87ttqhcotn.ffs@tglx>
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

On Thu, Oct 19 2023 at 16:20, Mario Limonciello wrote:
> On 10/18/2023 17:50, Thomas Gleixner wrote:
>> The only interrupt which does not work is interrupt 0 because nothing
>> allocates interrupt 0 due to nr_legacy_irqs == 0, but that's a trivially
>> solvable problem.
>
>  From David's logs I can see that the timer interrupt gets wired up to 
> IRQ2 instead of IRQ0.

Sure, but that's not really a problem. Nothing needs the timer
interrupt in principle.

> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 2 Level:0 ActiveLow:0)
>
> In my hacked up forcing NULL pic case this fixes that:
>
> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index 43c1c24e934b..885687e64e4e 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -424,7 +424,7 @@ static int legacy_pic_probe(void)
>   }
>
>   struct legacy_pic null_legacy_pic = {
> -       .nr_legacy_irqs = 0,
> +       .nr_legacy_irqs = 1,
>          .chip = &dummy_irq_chip,
>          .mask = legacy_pic_uint_noop,
>          .unmask = legacy_pic_uint_noop,
>
> I think it's cleaner than changing all the places that use 
> nr_legacy_irqs().

No. It's not cleaner. It's a hack and you still need to audit all places
which depend on nr_legacy_irqs(). Also why '1'? You could as well use
'16', no?

> On my side this makes:
>
> IOAPIC[0]: Preconfigured routing entry (33-2 -> IRQ 0 Level:0
> ActiveLow:0)

Sure, but that can be achieved by other means in a clean way as
well. Can we please focus on analyzing the underlying problems instead
of trying random hacks? The timer part is well understood already.

>> That machine does not even need the timer interrupt because it has a
>> usable APIC and TSC deadline timer, so no APIC timer calibration
>> required. The same is true for CPUs which do not have a TSC deadline
>> timer, but enumerate the APIC frequency via CPUID or MSRs.
>
> Don't you need it for things like rtcwake to be able to work?

Timer != RTC.

The RTC interrupt is separate (IRQ 8), but in the case of this system it
is using the HPET-RTC emulation which fails to initialize because
interrupt 0 is not available.

>> But that brings up an interesting question. How are those affected
>> machines even reaching a state where the user notices that just the
>> keyboard and the GPIO are not working? Why?
>
> So the GPIO controller driver (pinctrl-amd) uses platform_get_irq() to 
> try to discover the IRQ to use.
>
> This calls acpi_irq_get() which isn't implemented on x86 (hardcodes 
> -EINVAL).
>
> I can "work around it" by:
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..2b4b436c65d8 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -187,7 +187,8 @@ int platform_get_irq_optional(struct platform_device 
> *dev, unsigned int num)
>          }
>
>          r = platform_get_resource(dev, IORESOURCE_IRQ, num);
> -       if (has_acpi_companion(&dev->dev)) {
> +       if (IS_ENABLED(CONFIG_ACPI_GENERIC_GSI) &&
> +            has_acpi_companion(&dev->dev)) {
>                  if (r && r->flags & IORESOURCE_DISABLED) {
>                          ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
>                          if (ret)

So why is acpi_irq_get() reached when the PIC is disabled, but not when
the PIC is enabled? Because of the below:

> but the resource that is returned from the next hunk ?

next hunk? The resource is returned by platform_get_resource() above, no?

> has the resource flags set wrong in the NULL pic case:
>
> NULL case:
> r: AMDI0030:00 flags: 0x30000418
> PIC case:
> r: AMDI0030:00 flags: 0x418
>
> IOW NULL pic case has IORESOURCE_DISABLED / IORESOURCE_UNSET

So the real question is WHY are the DISABLED/UNSET flags not set in the
PIC case?

> NULL case:
> handler:  handle_edge_irq
> dstate:   0x3740c208
>              IRQ_TYPE_LEVEL_LOW
>
> PIC case:
> handler:  handle_fasteoi_irq
> dstate:   0x3740e208
>              IRQ_TYPE_LEVEL_LOW
>              IRQD_LEVEL
>
> I guess something related to the callpath for mp_register_handler().

Guessing is not helpful.

There is a difference in how the allocation info is set up when legacy
PIC is enabled, but that does not explain the above resource flag
difference.

As there is no override for IRQ7:

[    0.011415] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.011417] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 20, APIC INT 02
[    0.011418] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.011419] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID 20, APIC INT 09
...
[    0.011425] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 20, APIC INT 07

the initial setup of the IOAPIC interrupt is edge, while the initial
setup of the legacy PIC is level. But that gets changed later to edge
when the IOAPIC is initialized.

I'm not seeing the magic which make the above different yet, though I'm
100% sure by now that this "works" definitely not by design. It just
works by pure luck.

Now when platform_get_irq_optional() sets the trigger type via
irqd_set_trigger_type() it just sets LEVEL_LOW, but does not change the
handler and does not set IRQD_LEVEL. It does neither change the IO/APIC
pin setup. This happens because the IOAPIC interrupt chip does not
implement an irq_set_type() callback.

IOW the whole machinery depends on magic setup ordering vs. PIC and pure
luck. Adding the callback is not rocket science, but while it should
make the interrupt work it still does not explain the magic "working"
when the legacy PIC is enabled.

Let me sit down and add a pile of debug printks to all the relevant
places as we really need to understand the underlying magic effects of
legacy PIC first.

Thanks,

        tglx
