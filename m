Return-Path: <linux-kernel+bounces-76678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F0785FADD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 284DFB23BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734514601C;
	Thu, 22 Feb 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVKuLGwp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642712FB02;
	Thu, 22 Feb 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611327; cv=none; b=lgvl3dVJcNWn8GYuEplzlg41+U1GeFGTtb94AIu8BTmcYNCDShdSuaQ4r4nTlNrjSwgPcmKU7pnD8Qspw+IuICmz34PgwYEArUMrKgGl6DOlR0DlksfEsb2sxyUKQwRpwV5q1jDqw8bDOGrNms25Az6yzV25lwmsP0rYbUITeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611327; c=relaxed/simple;
	bh=kIZczWHR5/Nc3nYCAWYzUjsydPY/1nsM6oO6gbmZSHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQco+sQ5IH9sMEfELuEmtPe1OqwEkDdt5QH+Pbm8PfA9OcBDLIhL6B4WR8dhb9CIb+J4SeADdcd9h8PallXVhv06cxQLaIH6LZSESXmTcGoV1Nlx2KY0eHW2J+njQmzwHgQr+Jfer/fSIsK18bseRxA6h9sta7SA/KNradKvO3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVKuLGwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F7C433F1;
	Thu, 22 Feb 2024 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611327;
	bh=kIZczWHR5/Nc3nYCAWYzUjsydPY/1nsM6oO6gbmZSHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iVKuLGwp5DCor24xZgAAwTwbovowF/3KA6uXFHUuiRANLfpMQdn8lzSu93BRzigiF
	 zQHiyJFhIJro3MAq5tOfWq/PdEmtCHZZ+2lIbaH291kiNdNCwJAuWyOVyUzn48AKdc
	 sBtesUDmENKKh6ghBZQEal9sTLzLaEa0V0LVK8xWlCf9+fdjB44brVSGFaRDcwKWl2
	 KYPJlnO+cZngbU8tJUTJGgHY8aMRqruGi/jkJePAdeXaBjTpOEQ8QKEolQpNV2cJUE
	 1awqBYW+WNH8BPC74erA05naYUY5MwNXzi7Xvw2/Zg0o8i9mkE9CjZXj9zA34AS3YD
	 HIUl+FnTPD8PA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, Atish Patra
 <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v14 11/18] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <CAAhSdy3R9TCHG13vFk=sF0MvA60LtxOs9NbjSB7XBk+v1+XH4w@mail.gmail.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-12-apatel@ventanamicro.com>
 <87r0h4tzeq.fsf@all.your.base.are.belong.to.us>
 <CAAhSdy3R9TCHG13vFk=sF0MvA60LtxOs9NbjSB7XBk+v1+XH4w@mail.gmail.com>
Date: Thu, 22 Feb 2024 15:15:24 +0100
Message-ID: <874je0twjn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <anup@brainfault.org> writes:

> On Thu, Feb 22, 2024 at 6:43=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip=
/irq-riscv-imsic-state.c
>> > new file mode 100644
>> > index 000000000000..0c19ffb9ca3e
>> > --- /dev/null
>> > +++ b/drivers/irqchip/irq-riscv-imsic-state.c
>> > @@ -0,0 +1,870 @@
>>
>> [...]
>>
>> > +static void __imsic_local_sync(struct imsic_local_priv *lpriv)
>> > +{
>> > +     struct imsic_local_config *mlocal;
>> > +     struct imsic_vector *vec, *mvec;
>> > +     int i;
>> > +
>> > +     lockdep_assert_held(&lpriv->lock);
>> > +
>> > +     /* This pairs with the barrier in __imsic_remote_sync(). */
>> > +     smp_mb();
>>
>> I'm trying to figure out why this barrier is needed? All the updates are
>> done behind the spinlocks. If there're some ordering constraints that
>> I'm missing, please document them.
>>
>> > +
>> > +     for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + =
1) {
>> > +             if (!i || i =3D=3D IMSIC_IPI_ID)
>> > +                     goto skip;
>> > +             vec =3D &lpriv->vectors[i];
>> > +
>> > +             if (READ_ONCE(vec->enable))
>> > +                     __imsic_id_set_enable(i);
>> > +             else
>> > +                     __imsic_id_clear_enable(i);
>> > +
>> > +             /*
>> > +              * If the ID was being moved to a new ID on some other C=
PU
>> > +              * then we can get a MSI during the movement so check the
>> > +              * ID pending bit and re-trigger the new ID on other CPU
>> > +              * using MMIO write.
>> > +              */
>> > +             mvec =3D READ_ONCE(vec->move);
>> > +             WRITE_ONCE(vec->move, NULL);
>>
>> mvec =3D xchg(&vec->move, NULL) ?
>
> The __imsic_local_sync() is called with spinlock held.

Yeah, this was a readability comment.

>> > +             if (mvec && mvec !=3D vec) {
>> > +                     if (__imsic_id_read_clear_pending(i)) {
>> > +                             mlocal =3D per_cpu_ptr(imsic->global.loc=
al, mvec->cpu);
>> > +                             writel_relaxed(mvec->local_id, mlocal->m=
si_va);
>> > +                     }
>> > +
>> > +                     imsic_vector_free(&lpriv->vectors[i]);
>> > +             }
>> > +
>> > +skip:
>> > +             bitmap_clear(lpriv->dirty_bitmap, i, 1);
>> > +     }
>> > +}
>> > +
>> > +void imsic_local_sync_all(void)
>> > +{
>> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
>> > +     unsigned long flags;
>> > +
>> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
>> > +     bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
>> > +     __imsic_local_sync(lpriv);
>> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
>> > +}
>> > +
>> > +void imsic_local_delivery(bool enable)
>> > +{
>> > +     if (enable) {
>> > +             imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESH=
OLD);
>> > +             imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVER=
Y);
>> > +             return;
>> > +     }
>> > +
>> > +     imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
>> > +     imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
>> > +}
>> > +
>> > +#ifdef CONFIG_SMP
>> > +static void imsic_local_timer_callback(struct timer_list *timer)
>> > +{
>> > +     struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
>> > +     unsigned long flags;
>> > +
>> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
>> > +     __imsic_local_sync(lpriv);
>> > +     raw_spin_unlock_irqrestore(&lpriv->lock, flags);
>> > +}
>> > +
>> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsig=
ned int cpu)
>> > +{
>> > +     lockdep_assert_held(&lpriv->lock);
>> > +
>> > +     /*
>> > +      * Ensure that changes to vector enable, vector move and
>> > +      * dirty bitmap are visible to the target CPU.
>>
>> ...which case the spinlock(s) are enough, no?
>
> spinlocks are not fences.

They are indeed, and it would be hard to use them as locks otherwise
(acq/rel -- good ol' Documentation/memory-barriers.txt).

> If the timer wheel on the target cpu is already running and we don't
> have a fence here then the target cpu might not see the changes
> done by this cpu.

Remove the smp_mb() pair, the spinlocks are enough for this scenario!

>> > +      *
>> > +      * This pairs with the barrier in __imsic_local_sync().
>> > +      */
>> > +     smp_mb();
>> > +
>> > +     /*
>> > +      * We schedule a timer on the target CPU if the target CPU is not
>> > +      * same as the current CPU. An offline CPU will unconditionally
>> > +      * synchronize IDs through imsic_starting_cpu() when the
>> > +      * CPU is brought up.
>> > +      */
>> > +     if (cpu_online(cpu)) {
>> > +             if (cpu =3D=3D smp_processor_id()) {
>> > +                     __imsic_local_sync(lpriv);
>> > +                     return;
>> > +             }
>>
>> Maybe move this if-clause out from the cpu_online(), and only have
>> something like
>>   if (cpu_online(cpu) && !timer_pending(&lpriv->timer)) { ... }
>> inside the CONFIG_SMP guard...
>>
>> > +
>> > +             if (!timer_pending(&lpriv->timer)) {
>> > +                     lpriv->timer.expires =3D jiffies + 1;
>> > +                     add_timer_on(&lpriv->timer, cpu);
>> > +             }
>> > +     }
>> > +}
>> > +#else
>> > +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsig=
ned int cpu)
>> > +{
>> > +     lockdep_assert_held(&lpriv->lock);
>> > +     __imsic_local_sync(lpriv);
>> > +}
>> > +#endif
>>
>> ...where we can get rid of this special !SMP all together for this
>> function.
>
> I failed to understand what is wrong the current code.

Oh, nothing is wrong. Just trying to get rid of some ifdeffery.

>> > +void imsic_vector_mask(struct imsic_vector *vec)
>> > +{
>> > +     struct imsic_local_priv *lpriv;
>> > +
>> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> > +     if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
>> > +             return;
>> > +
>> > +     /*
>> > +      * This function is called through Linux irq subsystem with
>> > +      * irqs disabled so no need to save/restore irq flags.
>> > +      */
>> > +
>> > +     raw_spin_lock(&lpriv->lock);
>> > +
>> > +     vec->enable =3D false;
>>
>> Should have WRITE_ONCE to make the checkers happy.
>
> Okay, I will update.
>
>>
>> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
>> > +     __imsic_remote_sync(lpriv, vec->cpu);
>> > +
>> > +     raw_spin_unlock(&lpriv->lock);
>> > +}
>> > +
>> > +void imsic_vector_unmask(struct imsic_vector *vec)
>> > +{
>> > +     struct imsic_local_priv *lpriv;
>> > +
>> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> > +     if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
>> > +             return;
>> > +
>> > +     /*
>> > +      * This function is called through Linux irq subsystem with
>> > +      * irqs disabled so no need to save/restore irq flags.
>> > +      */
>> > +
>> > +     raw_spin_lock(&lpriv->lock);
>> > +
>> > +     vec->enable =3D true;
>>
>> Dito.
>
> Okay, I will update.
>
>>
>> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
>> > +     __imsic_remote_sync(lpriv, vec->cpu);
>> > +
>> > +     raw_spin_unlock(&lpriv->lock);
>> > +}
>> > +
>> > +static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, =
struct imsic_vector *vec,
>> > +                                  bool new_enable, struct imsic_vecto=
r *new_move)
>> > +{
>> > +     unsigned long flags;
>> > +     bool enabled;
>> > +
>> > +     raw_spin_lock_irqsave(&lpriv->lock, flags);
>> > +
>> > +     /* Update enable and move details */
>> > +     enabled =3D READ_ONCE(vec->enable);
>> > +     WRITE_ONCE(vec->enable, new_enable);
>>
>> Again, xchg() would be easier to read.
>
> why ? spinlock is not enough?

They're enough! Just readbaility/personal taste.


I'm running tests for this series now! Would be awesome to have the
series land for 6.9!

Cheers,
Bj=C3=B6rn

