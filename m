Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA27D716D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbjJYQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJYQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:05:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C444BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:05:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D97C433C7;
        Wed, 25 Oct 2023 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698249916;
        bh=c6iYE+MG+kMUSf/CPK47bC8qCmFUiFpvtnl6HQ3ZERI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LPYExIXEF4SXK8C5FGTW2PzdJuBtUnptTLPIoQRqVHPeKgGCddJtiw834cE9VrnMY
         7AEJlU2PBmYUMUPZfWGG4t5FGVNXubqN6Uk8LBMpSZc6lJ14gtGrQmz779DXLgvq5b
         jrbynVIdI9H4ynH+jn3In/eH4H/xBT0MB+RfEKqypq7D8yaN/JnAT7Z4b/7f4RUFFi
         97IlP1I6PxXzkUVvuTPfKJZr9BW35EWOnHWv0EpK2D6pSIPsjMMbbaY3/0IujbRdIk
         yWqmdZ6OdRmKUW94dAf6c1deNqHiItWyHUq/As2CBiCVECHv5FR9WT6ad//jbR/t4N
         KoN8nP8du9JmA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <CAK9=C2XpxYztxgD-5HQ+1kThBaRTv3pVk5eah4XHZ_8x62BwqQ@mail.gmail.com>
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com>
 <878r7srx04.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XpxYztxgD-5HQ+1kThBaRTv3pVk5eah4XHZ_8x62BwqQ@mail.gmail.com>
Date:   Wed, 25 Oct 2023 18:05:08 +0200
Message-ID: <875y2ug023.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Anup Patel <apatel@ventanamicro.com> writes:

> On Tue, Oct 24, 2023 at 6:35=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Hi Anup!
>>
>> Wow, I'm really happy to see that you're moving towards the 1-1 model!
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > The RISC-V advanced interrupt architecture (AIA) specification
>> > defines a new MSI controller called incoming message signalled
>> > interrupt controller (IMSIC) which manages MSI on per-HART (or
>> > per-CPU) basis. It also supports IPIs as software injected MSIs.
>> > (For more details refer https://github.com/riscv/riscv-aia)
>> >
>> > Let us add an early irqchip driver for RISC-V IMSIC which sets
>> > up the IMSIC state and provide IPIs.
>>
>> It would help (reviewers, and future bugfixers) if you add (here or in
>> the cover) what design decisions you've taken instead of just saying
>> that you're now supporting IMSIC.
>
> I agree with the suggestion but this kind of information should be
> in the source itself rather than commit description.

I think the high-level flow, and why you made certain design decisions
should be in the commit message.

The "how" in the code, the "why" in the commit message. Regardless -- it
would make it easier for reviewers to get into your code faster.

[...]

>> > +
>> > +     writel(IMSIC_IPI_ID, local->msi_va);
>>
>> Do you need the barriers here? If so, please document. If not, use the
>> _releaxed() version.
>
> We can't assume that _relaxed version of MMIO operations
> will work for RISC-V implementation so we conservatively
> use regular MMIO operations without _releaxed().

You'll need to expand on your thinking here, Anup. We can't just
sprinkle fences everywhere because of "we can't assume it'll work". Do
you need proper barriers for IPIs or not?

[...]

>> > +             mvec =3D lpriv->ids_move[i];
>> > +             lpriv->ids_move[i] =3D NULL;
>> > +             if (mvec) {
>> > +                     if (__imsic_id_read_clear_pending(i)) {
>> > +                             mlocal =3D per_cpu_ptr(imsic->global.loc=
al,
>> > +                                                  mvec->cpu);
>> > +                             writel(mvec->local_id, mlocal->msi_va);
>>
>> Again, do you need all the barriers? If yes, document. No, then relax
>> the call.
>
> Same comment as above.

Dito for me! ;-)

>> > +                     }
>> > +
>> > +                     lpriv->vectors[i].hwirq =3D UINT_MAX;
>> > +                     lpriv->vectors[i].order =3D UINT_MAX;
>> > +                     clear_bit(i, lpriv->ids_used_bitmap);
>> > +             }
>> > +
>> > +     }
>> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
>> > +}
>> > +
>> > +void imsic_local_delivery(bool enable)
>> > +{
>> > +     if (enable) {
>> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESH=
OLD);
>> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVER=
Y);
>> > +     } else {
>> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVE=
RY);
>> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRES=
HOLD);
>> > +     }
>>
>> My regular "early exit" nit. I guess I really dislike indentation. ;-)
>
> -ENOPARSE

if (...) {
  a();
  b();
  c();
} else {
  d();
  e();
}

vs

if (...) {
  a();
  b();
  c();
  return;
}

d();
e();

[...]

>> > +void imsic_vector_mask(struct imsic_vector *vec)
>> > +{
>> > +     struct imsic_local_priv *lpriv;
>> > +     unsigned long flags;
>> > +
>> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
>> > +             return;
>> > +
>> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
>> > +     bitmap_clear(lpriv->ids_enabled_bitmap, vec->local_id, 1);
>> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
>> > +
>> > +     imsic_remote_sync(vec->cpu);
>>
>> x86 seems to set a timer instead, for the remote cpu cleanup, which can
>> be much cheaper, and less in instrusive. Is that applicable here?
>
> The issue with that approach is deciding the right duration
> of timer interrupt. There might be platforms who need
> immediate mask/unmask response. We can certainely
> keep improving/tuning this over-time.

Any concrete examples where this is an actual problem?

[...]

>> > +void imsic_vector_move(struct imsic_vector *old_vec,
>> > +                     struct imsic_vector *new_vec)
>> > +{
>> > +     struct imsic_local_priv *old_lpriv, *new_lpriv;
>> > +     struct imsic_vector *ovec, *nvec;
>> > +     unsigned long flags, flags1;
>> > +     unsigned int i;
>> > +
>> > +     if (WARN_ON(old_vec->cpu =3D=3D new_vec->cpu ||
>> > +                 old_vec->order !=3D new_vec->order ||
>> > +                 (old_vec->local_id & IMSIC_VECTOR_MASK(old_vec)) ||
>> > +                 (new_vec->local_id & IMSIC_VECTOR_MASK(new_vec))))
>> > +             return;
>> > +
>> > +     old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
>> > +     if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] !=3D old_vec))
>> > +             return;
>> > +
>> > +     new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
>> > +     if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] !=3D new_vec))
>> > +             return;
>> > +
>> > +     raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
>> > +     raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
>> > +
>> > +     /* Move the state of each vector entry */
>> > +     for (i =3D 0; i < BIT(old_vec->order); i++) {
>> > +             ovec =3D old_vec + i;
>> > +             nvec =3D new_vec + i;
>> > +
>> > +             /* Unmask the new vector entry */
>> > +             if (test_bit(ovec->local_id, old_lpriv->ids_enabled_bitm=
ap))
>> > +                     bitmap_set(new_lpriv->ids_enabled_bitmap,
>> > +                                nvec->local_id, 1);
>> > +
>> > +             /* Mask the old vector entry */
>> > +             bitmap_clear(old_lpriv->ids_enabled_bitmap, ovec->local_=
id, 1);
>> > +
>> > +             /*
>> > +              * Move and re-trigger the new vector entry based on the
>> > +              * pending state of the old vector entry because we might
>> > +              * get a device interrupt on the old vector entry while
>> > +              * device was being moved to the new vector entry.
>> > +              */
>> > +             old_lpriv->ids_move[ovec->local_id] =3D nvec;
>> > +     }
>>
>> Hmm, nested spinlocks, and reimplementing what the irq matrix allocator
>> does.
>>
>> Convince me why irq matrix is not a good fit to track the interrupts IDs
>> *and* get handling/tracking for managed/unmanaged interrupts. You said
>> that it was the power-of-two blocks for MSI, but can't that be enfored
>> on matrix alloc? Where are you doing the special handling of MSI?
>>
>> The reason I'm asking is because I'm pretty certain that x86 has proper
>> MSI support (Thomas Gleixner can answer for sure! ;-))
>>
>> IMSIC smells a lot like the the LAPIC. The implementation could probably
>> be *very* close to what arch/x86/kernel/apic/vector.c does.
>>
>> Am I completly off here?
>>
>
> The x86 APIC driver only supports MSI-X due to which the IRQ matrix
> allocator only supports ID/Vector allocation suitable for MSI-X whereas
> the ARM GICv3 driver supports both legacy MSI and MSI-X. In absence
> of legacy MSI support, Linux x86 will fallback to INTx for PCI devices
> with legacy MSI support but for RISC-V platforms we can't assume that
> INTx is available because we might be dealing with an IMSIC-only
> platform.

You're mixing up MSI and *multi-MSI* (multiple MSI vectors).

x86 support MSI-X, MSI, and multi-MSI with IOMMU.

Gleixner has a some insights on why one probably should *not* jump
through hoops to support multi-MSI:
https://lore.kernel.org/all/877d7yhve7.ffs@tglx/

Will we really see HW requiring multi-MSI support on RISC-V systems
without IOMMU? To me this sounds like a theoretical exercise.

> Refer, x86_vector_msi_parent_ops in arch/x86/kernel/apic/msi.c and
> X86_VECTOR_MSI_FLAGS_SUPPORTED in arch/x86/include/asm/msi.h
>
> Refer, its_pci_msi_domain_info in drivers/irqchip/irq-gic-v3-its-pci-msi.c
>
> The changes which I think are need in the IRQ matrix allocator before
> integrating it in the IMSIC driver are the following:
> 1) IRQ matrix allocator assumed NR_VECTORS to be a fixed define
>     which the arch code provides but in RISC-V world the number of
>     IDs are discovered from DT or ACPI.

Ok, let's try to be bit more explicit. Have you had a look at
kernel/irq/matrix.c?

You need to define the IRQ_MATRIX_BITS (which x86 sets to NR_VECTORS).
This is the size of the bitmap. For IMSIC this would be 2047.

The matrix allocator is an excellent fit, modulo multi-MSI. It's battle
proven code.

> 2) IRQ matrix allocator needs to be support allocator multiple vectors
>     in power-of-2 which will allow IMSIC driver to support both legacy
>     MSI and MSI-X. This will involve changing the way best CPU is
>     found, the way bitmap APIs are used and adding some new APIs
>     for allocate vectors in power-of-2

...and all the other things multi-MSI requires.

> Based on above, I suggest we keep the integration of IRQ matrix
> allocator in the IMSIC driver as a separate series which will allow
> us to unblock other series (such as AIA ACPI support, power
> managment related changes in AIA drivers, etc).

I suggest removing the multi-MSI support, and use the matrix allocator.
We have something that looks like what x86 has (IMSIC). We have a
battle-proven implementation, and helper function. In my view it would
be just weird not to piggy-back on that work, and benefit from years of
bugfixes/things we haven't thought of.

Finally; I don't see that you're handling managed interrupt in the
series (Oh, the matrix allocator has support for that! ;-)).

I realize it's some changes, but the interrupt handling is a central
piece.

If you agree with my input, LMK if you're time/work-constrained, and I
can take a stab at integrating it in the series.


Bj=C3=B6rn
