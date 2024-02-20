Return-Path: <linux-kernel+bounces-73061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2285BCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E781F24415
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5BE6A03D;
	Tue, 20 Feb 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7XhL5QD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4X6RGBC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37E6A02C;
	Tue, 20 Feb 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434961; cv=none; b=a3TQO+PNWYez1MM40a/T9jm/IcimxdVjV0H/gj0uzTpqc9NCTd3lUrbPoiOqD2vw88s6F1zcrldW7WIk5L23HfQH067rX7iOEF9sZY9QbUOW5zvq9dw4B4O1YLjDAR2Kt/wHdo54x/z/aBjCBbOCD37NK7ib/bFJkifuVph0inM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434961; c=relaxed/simple;
	bh=yl9YVH5jN3XdW69GxwmBq3TmbVjKA/XZZtR3aVTo4nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQ9l8YlI4F26HaXpseItnTNczKp7cE1LnwVFYcrNeFxDj+5Gatsx8GVh+31up+Scg34pegejf3dpDnYXVjpyhxRKb74JaJW6mKpSza6iS92b0fnuVgx13RWPCxtUqvPuRCMm1AwCcCqxXwXsK0AiG3KXl7afu1SXj/xpuKTazWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7XhL5QD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4X6RGBC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708434957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqdxGzZUmGMxRdh7uo3p0E+R2tLPgd1LjL8qg1QFmTU=;
	b=Q7XhL5QDJ14d2Y1Tx+7ezonbH4enMNnpcEYhrfiPydArxIBo49TcUIcHSnAqwQH0sc3viq
	vI4ZF4vECHUbrxZVuOnmFIBNvglMyLHiSKVmx1HahvscowYVY8to9tud+fwuLYG6MsRCD1
	rl5EvxPZkc/jxKNFUDlEaeI3M4FI5hfKZP3aQTkVtwNs/U0+DjRGLyF8Hb9OR0tZjr5Lje
	6w6xbSFEKpw3gHNWx8N5FpD1BrGtOa4njSJeDreLezGwgs8SANkuEJ3sYCo9hHs3dx+hB/
	as/wC10aA2PqMtS4e9OMGRHGS0bTyVPveL7oQtvleJz+Cyfxe2F+L7S7zX1XAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708434957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqdxGzZUmGMxRdh7uo3p0E+R2tLPgd1LjL8qg1QFmTU=;
	b=U4X6RGBC2a7V1eZO17Yk5mTUBWqEd4/8tuep93ec5raS5FrOPkm2Dt1tot761fnsWiBnS+
	ERGoPnAR15RUFMBA==
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish
 Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan
 <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anup Patel
 <apatel@ventanamicro.com>
Subject: Re: [PATCH v13 06/13] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240220060718.823229-7-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-7-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 14:15:56 +0100
Message-ID: <87a5nvi8dv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> The RISC-V advanced interrupt architecture (AIA) specification
> defines a new MSI controller called incoming message signalled
> interrupt controller (IMSIC) which manages MSI on per-HART (or
> per-CPU) basis. It also supports IPIs as software injected MSIs.
> (For more details refer https://github.com/riscv/riscv-aia)
>
> Let us add an early irqchip driver for RISC-V IMSIC which sets
> up the IMSIC state and provide IPIs.

s/Let us add/Add/

> +#else
> +static void imsic_ipi_starting_cpu(void)
> +{
> +}
> +
> +static void imsic_ipi_dying_cpu(void)
> +{
> +}
> +
> +static int __init imsic_ipi_domain_init(void)
> +{
> +	return 0;
> +}

Please condense this into

static void imsic_ipi_starting_cpu(void) { }
static void imsic_ipi_dying_cpu(void) { }
static int __init imsic_ipi_domain_init(void) { return 0; }

No point in wasting space for these stubs.

> + * To handle an interrupt, we read the TOPEI CSR and write zero in one
> + * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
> + * Linux interrupt number and let Linux IRQ subsystem handle it.
> + */
> +static void imsic_handle_irq(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int err, cpu = smp_processor_id();
> +	struct imsic_vector *vec;
> +	unsigned long local_id;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
> +		local_id = local_id >> TOPEI_ID_SHIFT;
> +
> +		if (local_id == IMSIC_IPI_ID) {
> +#ifdef CONFIG_SMP

	if (IS_ENABLED(CONFIG_SMP))

> +			ipi_mux_process();
> +#endif
> +			continue;
> +		}

> +
> +/* MUST be called with lpriv->lock held */

Instead of a comment which cannot be enforced just have

        lockdep_assert_held(&lpriv->lock);

right at the top of the function. That documents the requirement and
lets lockdep yell if not followed.

> +#ifdef CONFIG_SMP
> +static void imsic_local_timer_callback(struct timer_list *timer)
> +{
> +	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +	__imsic_local_sync(lpriv);
> +	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> +}
> +
> +/* MUST be called with lpriv->lock held */

Ditto

> +static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)

> +void imsic_vector_mask(struct imsic_vector *vec)
> +{
> +	struct imsic_local_priv *lpriv;
> +
> +	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
> +		return;

WARN_ON_ONCE(), no?

> +bool imsic_vector_isenabled(struct imsic_vector *vec)
> +{
> +	struct imsic_local_priv *lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	unsigned long flags;
> +	bool ret;
> +
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +	ret = vec->enable;
> +	raw_spin_unlock_irqrestore(&lpriv->lock, flags);

I'm not sure what you are trying to protect here. vec->enable can
obviously change right after the lock is dropped. So that's just a
snapshot, which is not any better than using

          READ_ONCE(vec->enable);

and a corresponding WRITE_ONCE() at the update site, which obviously
needs serialization.

> +static void __init imsic_local_cleanup(void)
> +{
> +	int cpu;
> +	struct imsic_local_priv *lpriv;

        struct imsic_local_priv *lpriv;
	int cpu;

Please.

> +void imsic_state_offline(void)
> +{
> +#ifdef CONFIG_SMP
> +	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
> +#endif

You can move that into the #ifdef below.

> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> +	irq_matrix_offline(imsic->matrix);
> +	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> +
> +#ifdef CONFIG_SMP
> +	raw_spin_lock_irqsave(&lpriv->lock, flags);
> +	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
> +	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
> +#endif
> +}


Thanks,

        tglx

