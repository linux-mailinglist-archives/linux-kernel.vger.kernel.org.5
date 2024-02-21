Return-Path: <linux-kernel+bounces-75191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CB285E47B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE53B213BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836583CAE;
	Wed, 21 Feb 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS6BeSvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39397F7EA;
	Wed, 21 Feb 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536164; cv=none; b=NMwIovxXcnpJYY+WmxV1vm1KpOboXrzpvTR150GYf2WuOJUe9rFN3SqEUM5AK74UgL9ZXJTqQI5FAZ8RN9LqgchviWeAgmyHsKwmSaAUtALSxEbgXtx37BLnvTFH1yKlI+wrWdP0XJ4yXQjKuJzRk3lGOBUt6S2sEx5aY4/hSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536164; c=relaxed/simple;
	bh=blg5JU8tDMyTEMnxPmEINNG8w4b5crwe8Ll8EbiY46w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JgQDKxVpaOzs8cEwb+TmHyt5zQJufgRRj36oqMPg8/bNNVgSAOsUs3lKfieZ05eMJCeUKr5DhiYoAaZjv2OZGdeBPUDYX71235s15R+C/HIS+eRmGoC1U+b/Aono9rBeDWruLvJdw97cnOr7QtyP66qqeU2N+0H9UfKiMaJPUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS6BeSvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE996C433C7;
	Wed, 21 Feb 2024 17:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708536163;
	bh=blg5JU8tDMyTEMnxPmEINNG8w4b5crwe8Ll8EbiY46w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uS6BeSvp5tQGb7tUlatSA/6AdxlnEqgjZPLPhr6LKL2tCyHmyDbdKRfzPS5FAWS9h
	 5m1LOHkjES0ipSOeDSL5tcJz44ykKBaIkXK8HNmJI96vuZZ3SAnXIoqD45xVPGoOYt
	 o8QzAj15C6JcXC/J6h42DDG/vCskLuUz3ocow7c4bExBhrXzOZumMNiTCvqsInTi5C
	 PvHc0P00mfCSC2JJZ2ksFd/m4QmfmQy5BhzTAnSFHQoJBD1ZndQam64PHic0VPDW9S
	 rI+bVOD5JBrV2noI1rPqGMASyOA+IQuUeceifL3AcwuLzdiwnImYBY46T27+Ob5deH
	 k03G6v925g45Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>, Marc
 Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
 linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <CAK9=C2WXR49KZg3rstChqAHda+hUhPm3AEo6o2jh0NM3kvoSUA@mail.gmail.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com>
 <87frxnfj3p.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Xnzg3KAVETXN+ZGLWhVtaJuU4uXs3WH2ZondkBJMHFcA@mail.gmail.com>
 <874je2yqn9.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2WXR49KZg3rstChqAHda+hUhPm3AEo6o2jh0NM3kvoSUA@mail.gmail.com>
Date: Wed, 21 Feb 2024 18:22:40 +0100
Message-ID: <87frxl3f6n.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> On Wed, Feb 21, 2024 at 5:29=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> >> > +void imsic_vector_mask(struct imsic_vector *vec)
>> >> > +{
>> >> > +     struct imsic_local_priv *lpriv;
>> >> > +
>> >> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
>> >> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
>> >> > +             return;
>> >> > +
>> >> > +     /*
>> >> > +      * This function is called through Linux irq subsystem with
>> >> > +      * irqs disabled so no need to save/restore irq flags.
>> >> > +      */
>> >> > +
>> >> > +     raw_spin_lock(&lpriv->lock);
>> >> > +
>> >> > +     vec->enable =3D false;
>> >> > +     bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
>> >> > +     __imsic_remote_sync(lpriv, vec->cpu);
>> >> > +
>> >> > +     raw_spin_unlock(&lpriv->lock);
>> >> > +}
>> >>
>> >> Really nice that you're using a timer for the vector affinity change,
>> >> and got rid of the special/weird IMSIC/sync IPI. Can you really use a
>> >> timer for mask/unmask? That makes the mask/unmask operation
>> >> asynchronous!
>> >>
>> >> That was what I was trying to get though with this comment:
>> >> https://lore.kernel.org/linux-riscv/87sf24mo1g.fsf@all.your.base.are.=
belong.to.us/
>> >>
>> >> Also, using the smp_* IPI functions, you can pass arguments, so you
>> >> don't need the dirty_bitmap tracking the changes.
>> >
>> > The mask/unmask operations are called with irqs disabled so if
>> > CPU X does synchronous IPI to another CPU Y from mask/unmask
>> > operation then while CPU X is waiting for IPI to complete it cannot
>> > receive IPI from other CPUs which can lead to crashes and stalls.
>> >
>> > In general, we should not do any block/busy-wait work in
>> > mask/unmask operation of an irqchip driver.
>>
>> Hmm, OK. Still, a bit odd that when the .irq_mask callback return, the
>> masking is not actually completed.
>>
>> 1. CPU 0 tries to mask an interrupt tried to CPU 1.
>> 2. The timer is queued on CPU 1.
>> 3. The call irq_mask returns on CPU 0
>> 4. ...the irq is masked at some future point, determined by the callback
>>    at CPU 1
>>
>> Is that the expected outcome?
>
> Yes, that's right.
>
>>
>> There are .irq_mask implementation that does seem to go at length
>> (blocking) to perform the mask, e.g.: gic_mask_irq() which calls
>> gic_{re,}dist_wait_for_rwp that have sleep/retry loops. The GIC3 ITS
>> code has similar things going on.
>
> The gic_{re,}dist_wait_for_rwp() polls on a HW register for completion
> which will certainly complete in a predictable time whereas waiting
> for IPI to be executed by another CPU is not predictable and fragile.
>
>>
>> I'm not saying you're wrong, I'm just trying to wrap my head around the
>> masking semantics.
>>
>> > The AIA IMSIC spec allows setting ID pending bit using MSI write
>> > irrespective whether ID is enabled or not but the interrupt will be
>> > taken only after ID is enabled. In other words, there will be no
>> > loss of interrupt with delayed mask/unmask using async IPI or
>> > lazy timer.
>>
>> No loss, but we might *get* an interrupt when we explicitly asked not to
>> get any. Maybe that's ok?
>>
>
> The delayed spurious interrupt after masking is avoided by additional
> masking at the source of interrupt. For wired-to-MSI interrupts, we have
> additional masking on the APLIC MSI-mode. For PCI MSI interrupts, we
> have additional masking at PCI device level using pci_msi_mask_irq().

Thanks for the clarifications, Anup! Much appreciated!

