Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAE7CDFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345009AbjJROe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjJROdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:33:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DA12B;
        Wed, 18 Oct 2023 07:30:27 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697639425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkP/X9V4BRzXP+KA1z4swAloH4uUhoVIL/ZvP/gPtak=;
        b=e2A9kBAAPgYWoXZFBb2SNE2WNH+qQChpdp6gtfb+Dpq57XasHpfr7ypk0yDLnx3U0lev56
        Z9JoQ1NPvfzYA6vZSZEN9QEic8OC/GcHslM15bQqODgFr8Mfniq29pI1kw7vCcSqkqE/oz
        hsLjXfeJhMbrrE7+LTnVV7HIjtJfHPEPoJdR1xkYsZ3HnC/hMQLtJcEE4NPKBJwVA8Qgce
        AE9wPhqHrNUA5+Ge/SfvuawbBLunPMBjoH3UHwZMKXsuubVH8+WSNVrXOC1bxA/CZm2yi8
        bi3vToU48VTFXaHh/rm2CEcnCHxqbUPXPLaTLGKrIyYgke7IydrExtJHCfDy2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697639425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkP/X9V4BRzXP+KA1z4swAloH4uUhoVIL/ZvP/gPtak=;
        b=IKikuqjrWpHbH1cMa7lab7VCZmDwnr16FJkdnMgVtJs9LwL7yw++CuM59yrBBs/y5OK+Sh
        mUpARtNF8jm6CBDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.6-rc4-rt7
Message-ID: <20231018143024.79vRO3R3@linutronix.de>
References: <20231004160655.0D-7XFo_@linutronix.de>
 <70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 11:23:59 [+0200], Pierre Gondois wrote:
> Hello,
Hi,

> The issue seems to be related to this patchset:
> https://lore.kernel.org/all/20230112194314.845371875@infradead.org/
> but as I was unable to really diagnose the issue, it might aswell be
> something else.

Is it easy to figure when this faulty behaviour was introduced?

> It seems the memory/registers get corrupted, cf the recurring error
> messages:
> - Undefined instruction
> - Unable to handle kernel paging request at virtual address
> - Mem abort info
> Splats seem to happen while taking IRQs while going out of idle or
> when handling a syscall. More splat variations could be generated,
> but 5 should be enough I believe.
>=20
> When running a non-PREEMPT_RT kernel, splats don't appear, so the issue
> might be related to the way locks are handled in PREEMPT_RT. I don't
> deeply understand the relation between rcu/irq/tracing so far, if someone
> has an idea of what could happen, this would be helpful :)

I've been looking at these splats. Do you have auth-pointer or shadow
stack enabled?

> Regards,
> Pierre
>=20
> Splats:
> [splat-1]
> [...] Internal error: Oops - Undefined instruction: 0000000002000000 [#1]=
 PREEMPT_RT SMP
=E2=80=A6
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   a8c47bfd        ldp     x29, x30, [sp], #64
>    4:   d50323bf        autiasp
>    8:   d65f03c0        ret
>    c:   d503201f        nop
>   10:*  d503233f        paciasp         <-- trapping instruction

paciasp is the undefined instruction. I don't see paciasp to be patched
out if not supported by the CPU so it is a NOP if not supported. What
could go wrong here?

> [splat-2]
> [...] Unable to handle kernel paging request at virtual address 001c71c71=
c71d434
=E2=80=A6
> [...] pc : ttwu_do_activate (kernel/sched/core.c:3855)
> [...] lr : ttwu_do_activate (kernel/sched/sched.h:1363 kernel/sched/sched=
=2Eh:1507 kernel/sched/core.c:3846)
=E2=80=A6
> [...] x20: ffff80008000bcd8 x19: ffff00097eedebc0 x18: 071c71c71c71c71c
> [...] x8 : 00000000000645ab x7 : ffff800080149d58 x6 : 0000000000000000

=E2=80=A6
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   f001dd89        adrp    x9, 0x3bb3000
>    4:   f9068668        str     x8, [x19, #3336]
>    8:   f9418129        ldr     x9, [x9, #768]
>    c:   d341fd08        lsr     x8, x8, #1
>   10:*  f9068e68        str     x8, [x19, #3352]                <-- trapp=
ing instruction

So this reads as
	store x8 to x19 + #3352, 0xffff00097eedebc0 + 3352
	store 0x00000000000645ab to 0xffff00097eedf8d8

But the kernel complains about 001c71c71c71d434 which is not exactly
what I computed. But it is familiar to x18. Looking at those two
 0x07 1c71c71c71 c71c
 0x00 1c71c71c71 d434

the pattern in the middle is the same. And 0xd434 - 0xc71c =3D 0xd18 which
is 3352.=20

x18 is the shadow stack (?) and contains the same value in splat-1 and
is zero in splat-3 and splat-4.

> [splat-3]
> [...] Mem abort info:
> [...]   ESR =3D 0x0000000096000045
> [...]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [...]   SET =3D 0, FnV =3D 0
> [...]   EA =3D 0, S1PTW =3D 0
> [...]   FSC =3D 0x05: level 1 translation fault
> [...] Data abort info:
> [...]   ISV =3D 0, ISS =3D 0x00000045, ISS2 =3D 0x00000000
> [...]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> [...]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [...] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000ed344000
> [...] [ffff800886adb8b8] pgd=3D10000009fffff003, p4d=3D10000009fffff003, =
pud=3D0000000000000000
> [...] Internal error: Oops: 0000000096000045 [#1] PREEMPT_RT SMP
> [...] Modules linked in:
> [...] CPU: 1 PID: 264 Comm: rtla-static Not tainted 6.6.0-rc4-rt8-00102-g=
97b0e2d47443 #1193
> [...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Devel=
opment Platform, BIOS EDK II Oct  4 2023
> [...] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> [...] pc : rcu_is_watching (kernel/rcu/tree.c:695)
> [...] lr : trace_irq_disable (./include/trace/events/preemptirq.h:36)
> [...] sp : ffff800086adb8d0
> [...] x29: ffff800086adb8e0 x28: ffff0008062a4ec0 x27: 0000000000000030
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   54fffb61        b.ne    0xffffffffffffff6c  // b.any
>    4:   17ffffe4        b       0xffffffffffffff94
>    8:   d503201f        nop
>    c:   d503233f        paciasp
>   10:*  a9be7bfd        stp     x29, x30, [sp, #-32]!           <-- trapp=
ing instruction

This looks like a stack entry. So this looks sane and if SP is correct
then nothing should go wrong. The fault says "translation fault" so my
guess would be that SP is not correct and we have to page tables backing
ffff800086adb8d0.

> [splat-4]
> [...] Mem abort info:
> [...]   ESR =3D 0x0000000096000045
> [...]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [...]   SET =3D 0, FnV =3D 0
> [...]   EA =3D 0, S1PTW =3D 0
> [...]   FSC =3D 0x05: level 1 translation fault
> [...] Data abort info:
> [...]   ISV =3D 0, ISS =3D 0x00000045, ISS2 =3D 0x00000000
> [...]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> [...]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
=E2=80=A6
> [...] lr : trace_irq_disable (./include/trace/events/preemptirq.h:36)
> [...] sp : ffff800086adb8d0
> [...] x29: ffff800086adb8e0 x28: ffff0008062a4ec0 x27: 0000000000000030
=E2=80=A6
>    c:   d503233f        paciasp
>   10:*  a9be7bfd        stp     x29, x30, [sp, #-32]!           <-- trapp=
ing instruction

This seems to be same as splat-3 including register.

> [splat-5]
> [...] Internal error: Oops - Undefined instruction: 0000000002000000 [#1]=
 PREEMPT_RT SMP
> [...] Modules linked in:
> [...] CPU: 2 PID: 40 Comm: rcuc/2 Not tainted 6.6.0-rc4-rt8-00102-g97b0e2=
d47443 #1194
> [...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Devel=
opment Platform, BIOS EDK II Oct  4 2023
> [...] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> [...] pc : trace_pelt_irq_tp (./include/trace/events/sched.h:?)
> [...] lr : irqtime_account_irq (kernel/sched/cputime.c:64)
> [...] sp : ffff8000851d3ce0
> [...] x29: ffff8000851d3ce0 x28: 0000000000000020 x27: ffff800083ce4e80
> [...] x26: ffff800083d46180 x25: 000000000000000a x24: 0000000000000000
> [...] x23: 0000000000000007 x22: 0000000000000000 x21: ffff00097eeebf50
> [...] x20: 0000000000002a08 x19: ffff00080092b480 x18: ffff8000850fd038
> [...] x17: ffff800084e05000 x16: ffff800084445bf0 x15: 0000000008a87beb
> [...] x14: 000000003bb0a251 x13: 0000000000000006 x12: 0000000934346b33
> [...] x11: 0000000100000000 x10: 0000000000000001 x9 : 0000000014443054
> [...] x8 : ffff00097eeebeb0 x7 : ffff80008012d608 x6 : 0000000000000000
> [...] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000851d3d80
> [...] x2 : ffff00080092b480 x1 : 0000000000000000 x0 : 000000b814aa1780
> [...] Call trace:
> [...] trace_pelt_irq_tp (./include/trace/events/sched.h:?)
> [...] __do_softirq (./include/linux/vtime.h:? kernel/softirq.c:593)
> [...] __local_bh_enable_ip (kernel/softirq.c:?)
> [...] local_bh_enable (./include/linux/bottom_half.h:34)
> [...] rcu_cpu_kthread (kernel/rcu/tree.c:2493)
> [...] smpboot_thread_fn (kernel/smpboot.c:?)
> [...] kthread (kernel/kthread.c:389)
> [...] ret_from_fork (arch/arm64/kernel/entry.S:854)
> [...] Code: 17ffffc2 d4210000 17ffffe4 d503201f (819e3608)
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   17ffffc2        b       0xffffffffffffff08
>    4:   d4210000        brk     #0x800
>    8:   17ffffe4        b       0xffffffffffffff98
>    c:   d503201f        nop
>   10:*  819e3608        .inst   0x819e3608 ; undefined          <-- trapp=
ing instruction

Knowing what PC is could help to figure out if this is really
trace_pelt_irq_tp. The brk opcode could be a warning since it jumps back
afterwards. But the trapping code a different/ wrong page that is mapped
here. Or it jumped too far.
I don't know why trace_pelt_irq_tp is visible here. This should be just
a nop which is patched at runtime to some underscroll function ;) I
might be missing something.

Sebastian
