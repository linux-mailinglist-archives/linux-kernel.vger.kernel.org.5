Return-Path: <linux-kernel+bounces-76567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0385F944
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4651F2569D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2013340A;
	Thu, 22 Feb 2024 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku47Uswl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C65FB81;
	Thu, 22 Feb 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607617; cv=none; b=Y71z5NWtSn3YBJjyLJHxCKg/zu8Sx8F1137rhpi3h6ICyUC5MmNDmyUoHEPCXQhoSpUjkCoTpP2mZsEjNQBeTkMIwfSHkFZvibA9vMEP2bmoiS6B67UmCk/oXwP7M6CIsDmd8lSDselINC184qt/2Q1trkELCfRZSC120oWVrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607617; c=relaxed/simple;
	bh=MbENokeI9PUY9gmhafxiQFG9i+/znCgTXAZEO2pR1D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qhiy6cblCNdKrjrvpMJV3cgsmVq5VdEFAswOmlH3N0/43ZqDpgq2lomYJn9Bck9BbguKezkQ4ZWyvIXtt3MT11ihG3saDTvvrCF94oCUs/imAGk8HwR8jhwIg5FLXMs6djx9AEEJDyOWsLw2QsmrYB9FbUI2zUsS7awQfUIpQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku47Uswl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CADC433F1;
	Thu, 22 Feb 2024 13:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708607616;
	bh=MbENokeI9PUY9gmhafxiQFG9i+/znCgTXAZEO2pR1D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ku47UswlrQW3XlqS3h0ikrchgU3HJschH2qvnH733wa9ZGvYzpW8Q6piRfczQ90/3
	 yIJ3IOyK9Co5eO+n3SftKdMEWWzIWpxZ/m5S6SDN5roVVAErAf7qd6gV8QpB1iYsPI
	 xpnRecMXxPxsk4rxnA1CbJdhHaybbAFT24gYhVlySCa9IBnAuE8EZh7ZDlrGLlmgrM
	 ERtcRNXsZZn0hjBeH4JNUg5uRzvbtfJYRw2LsaKZdgz5jbMdbJfK3znlaF5tu8ERLM
	 jwbMsxSm2//EDqnEUnx1JI55oxVE7zQacNyVrZK6JA7kaY+pnVyMgVBN43EO8iP7fC
	 cbxAFhXGqyRsQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas
 Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org, Atish
 Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Andrew Jones
 <ajones@ventanamicro.com>
Subject: Re: [PATCH v14 11/18] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240222094006.1030709-12-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-12-apatel@ventanamicro.com>
Date: Thu, 22 Feb 2024 14:13:33 +0100
Message-ID: <87r0h4tzeq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Anup Patel <apatel@ventanamicro.com> writes:

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> new file mode 100644
> index 000000000000..0c19ffb9ca3e
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -0,0 +1,870 @@

[...]

> +static void __imsic_local_sync(struct imsic_local_priv *lpriv)
> +{
> +	struct imsic_local_config *mlocal;
> +	struct imsic_vector *vec, *mvec;
> +	int i;
> +
> +	lockdep_assert_held(&lpriv->lock);
> +
> +	/* This pairs with the barrier in __imsic_remote_sync(). */
> +	smp_mb();

I'm trying to figure out why this barrier is needed? All the updates are
done behind the spinlocks. If there're some ordering constraints that
I'm missing, please document them.

> +
> +	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
> +		if (!i || i =3D=3D IMSIC_IPI_ID)
> +			goto skip;
> +		vec =3D &lpriv->vectors[i];
> +
> +		if (READ_ONCE(vec->enable))
> +			__imsic_id_set_enable(i);
> +		else
> +			__imsic_id_clear_enable(i);
> +
> +		/*
> +		 * If the ID was being moved to a new ID on some other CPU
> +		 * then we can get a MSI during the movement so check the
> +		 * ID pending bit and re-trigger the new ID on other CPU
> +		 * using MMIO write.
> +		 */
> +		mvec =3D READ_ONCE(vec->move);
> +		WRITE_ONCE(vec->move, NULL);

mvec =3D xchg(&vec->move, NULL) ?

> +		if (mvec && mvec !=3D vec) {
> +			if (__imsic_id_read_clear_pending(i)) {
> +				mlocal =3D per_cpu_ptr(imsic->global.local, mvec->cpu);
> +				writel_relaxed(mvec->local_id, mlocal->msi_va);
> +			}
> +
> +			imsic_vector_free(&lpriv->vectors[i]);
> +		}
> +
> +skip:
> +		bitmap_clear(lpriv->dirty_bitmap, i, 1);
> +	}
> +}
> +
> +void imsic_local_sync_all(void)
> +{
> +	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
> +	__imsic_local_sync(lpriv);
> +	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> +}
> +
> +void imsic_local_delivery(bool enable)
> +{
> +	if (enable) {
> +		imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHOLD);
> +		imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY);
> +		return;
> +	}
> +
> +	imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
> +	imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
> +}
> +
> +#ifdef CONFIG_SMP
> +static void imsic_local_timer_callback(struct timer_list *timer)
> +{
> +	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +	__imsic_local_sync(lpriv);
> +	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> +}
> +
> +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned=
 int cpu)
> +{
> +	lockdep_assert_held(&lpriv->lock);
> +
> +	/*
> +	 * Ensure that changes to vector enable, vector move and
> +	 * dirty bitmap are visible to the target CPU.

..which case the spinlock(s) are enough, no?

> +	 *
> +	 * This pairs with the barrier in __imsic_local_sync().
> +	 */
> +	smp_mb();
> +
> +	/*
> +	 * We schedule a timer on the target CPU if the target CPU is not
> +	 * same as the current CPU. An offline CPU will unconditionally
> +	 * synchronize IDs through imsic_starting_cpu() when the
> +	 * CPU is brought up.
> +	 */
> +	if (cpu_online(cpu)) {
> +		if (cpu =3D=3D smp_processor_id()) {
> +			__imsic_local_sync(lpriv);
> +			return;
> +		}

Maybe move this if-clause out from the cpu_online(), and only have
something like
  if (cpu_online(cpu) && !timer_pending(&lpriv->timer)) { ... }
inside the CONFIG_SMP guard...

> +
> +		if (!timer_pending(&lpriv->timer)) {
> +			lpriv->timer.expires =3D jiffies + 1;
> +			add_timer_on(&lpriv->timer, cpu);
> +		}
> +	}
> +}
> +#else
> +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned=
 int cpu)
> +{
> +	lockdep_assert_held(&lpriv->lock);
> +	__imsic_local_sync(lpriv);
> +}
> +#endif

..where we can get rid of this special !SMP all together for this
function.

> +
> +void imsic_vector_mask(struct imsic_vector *vec)
> +{
> +	struct imsic_local_priv *lpriv;
> +
> +	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
> +		return;
> +
> +	/*
> +	 * This function is called through Linux irq subsystem with
> +	 * irqs disabled so no need to save/restore irq flags.
> +	 */
> +
> +	raw_spin_lock(&lpriv->lock);
> +
> +	vec->enable =3D false;

Should have WRITE_ONCE to make the checkers happy.

> +	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> +	__imsic_remote_sync(lpriv, vec->cpu);
> +
> +	raw_spin_unlock(&lpriv->lock);
> +}
> +
> +void imsic_vector_unmask(struct imsic_vector *vec)
> +{
> +	struct imsic_local_priv *lpriv;
> +
> +	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
> +		return;
> +
> +	/*
> +	 * This function is called through Linux irq subsystem with
> +	 * irqs disabled so no need to save/restore irq flags.
> +	 */
> +
> +	raw_spin_lock(&lpriv->lock);
> +
> +	vec->enable =3D true;

Dito.

> +	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
> +	__imsic_remote_sync(lpriv, vec->cpu);
> +
> +	raw_spin_unlock(&lpriv->lock);
> +}
> +
> +static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, str=
uct imsic_vector *vec,
> +				     bool new_enable, struct imsic_vector *new_move)
> +{
> +	unsigned long flags;
> +	bool enabled;
> +
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +
> +	/* Update enable and move details */
> +	enabled =3D READ_ONCE(vec->enable);
> +	WRITE_ONCE(vec->enable, new_enable);

Again, xchg() would be easier to read.


Bj=C3=B6rn

