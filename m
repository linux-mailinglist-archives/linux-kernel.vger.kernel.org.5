Return-Path: <linux-kernel+bounces-69178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD88785856B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE01F25CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9B1353E5;
	Fri, 16 Feb 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mu/pj7R9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pRWjx0me"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752713328F;
	Fri, 16 Feb 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108851; cv=none; b=h6Z/AuYYZM6sIW854+VOryTRCBSXXPs2yuou3rOs5f3cp4UlZOfUX0Ylo5VbWdbDLXnJ1XoJQKRU5qF7UoKyO7Qvld4mZ8lIgHM71h3oRv+qBelE3QXyuVFoQbzkNWYQXq1alajrSd7Ikjg628NuyRi4lbvT9SwljK42onYG+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108851; c=relaxed/simple;
	bh=6kuuez1rbe+zXZsepv02zMHyDpQWsr/mhLLgJ+fU2T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XQcUvRuqB/zqsJ9TMpiXxSwgNgURsH5N6jojvHgpFU4ADzWYa6MshsVOD1y+NZGVUeqv8oVmf2mPzu3O+RykmM/+zU6oqGyfk6F6TFIDeDCApyYdEFWU07nBHk7XEnQhLGpqCRM5oS9Pip5JL71m9NGk48f/BU4kC+kTrWJ4b9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mu/pj7R9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pRWjx0me; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708108847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7LuufdWwL+SVl8iJBjtJX+BhhU6HA8hpHGpb95G2k=;
	b=mu/pj7R92qWz0kEo70/pEinc5+SsIMVdhBSfA6OzWr2Qkt1kZCRc57Als/7ciq6cUvDku1
	/qgmjdoO06SroVjrLSydBucQeU6rh6dr32CRYFCUun6rOk5GN1Ack2i8mKbDoe05d5HSvJ
	bxFG93pDm6GhPuWNoTnbacgWquKtZ+J3qKTABJw82bR0GP0D08oTChza7l4ap6OBq0ihL3
	hs1vfqh7oUqF7AoI1wU/l5iUY2CQ+FTwgWWLuSLCmt1hprRdq75hvIxjHu4ib2AuXoO265
	VVsGk37fJTIMhRUnT1ZCEZc/G8bWiIyoKZYUjwdiwk8IdPqN2ra6O4gE1c5ZVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708108847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj7LuufdWwL+SVl8iJBjtJX+BhhU6HA8hpHGpb95G2k=;
	b=pRWjx0meUdFCVOeKx6CGD/DhOGpFkPLDESfkGlBrQ06VD86ZaPhP1C8dTpOqt39a1gwDg1
	yXDCzfQ+GEUGa6CA==
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
Subject: Re: [PATCH v12 18/25] irqchip: Add RISC-V incoming MSI controller
 early driver
In-Reply-To: <20240127161753.114685-19-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-19-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 19:40:47 +0100
Message-ID: <87h6i8ckwg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> +
> +#ifdef CONFIG_SMP
> +static irqreturn_t imsic_local_sync_handler(int irq, void *data)
> +{
> +	imsic_local_sync();
> +	return IRQ_HANDLED;
> +}
> +
> +static void imsic_ipi_send(unsigned int cpu)
> +{
> +	struct imsic_local_config *local =
> +				per_cpu_ptr(imsic->global.local, cpu);

Let it stick out. We switched to line length 100 quite some time
ago. Applies to the rest of the series too.

> +	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
> +}
> +
> +static void imsic_ipi_starting_cpu(void)
> +{
> +	/* Enable IPIs for current CPU. */
> +	__imsic_id_set_enable(IMSIC_IPI_ID);
> +
> +	/* Enable virtual IPI used for IMSIC ID synchronization */
> +	enable_percpu_irq(imsic->ipi_virq, 0);
> +}
> +
> +static void imsic_ipi_dying_cpu(void)
> +{
> +	/*
> +	 * Disable virtual IPI used for IMSIC ID synchronization so
> +	 * that we don't receive ID synchronization requests.
> +	 */
> +	disable_percpu_irq(imsic->ipi_virq);

Shouldn't this disable the hardware too, i.e.

          __imsic_id_clear_enable()

?

> +}
> +
> +static int __init imsic_ipi_domain_init(void)
> +{
> +	int virq;
> +
> +	/* Create IMSIC IPI multiplexing */
> +	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
> +	if (virq <= 0)
> +		return (virq < 0) ? virq : -ENOMEM;
> +	imsic->ipi_virq = virq;
> +
> +	/* First vIRQ is used for IMSIC ID synchronization */
> +	virq = request_percpu_irq(imsic->ipi_virq, imsic_local_sync_handler,
> +				  "riscv-imsic-lsync", imsic->global.local);
> +	if (virq)
> +		return virq;

Please use a separate 'ret' variable. I had to read this 3 times to make
sense of it.

> +	irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
> +	imsic->ipi_lsync_desc = irq_to_desc(imsic->ipi_virq);

What's so special about this particular IPI that it can't be handled
like all the other IPIs?

> +static int __init imsic_early_probe(struct fwnode_handle *fwnode)
> +{
> +	int rc;
> +	struct irq_domain *domain;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +
> +	/* Find parent domain and register chained handler */
> +	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
> +					  DOMAIN_BUS_ANY);
> +	if (!domain) {
> +		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
> +		return -ENOENT;
> +	}
> +	imsic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
> +	if (!imsic_parent_irq) {
> +		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
> +		return -ENOENT;
> +	}
> +	irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
> +
> +	/* Initialize IPI domain */
> +	rc = imsic_ipi_domain_init();
> +	if (rc) {
> +		pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode);
> +		return rc;

Leaves the chained handler around and enabled.

> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
> +
> +#define imsic_csr_write(__c, __v)		\
> +do {						\
> +	csr_write(CSR_ISELECT, __c);		\
> +	csr_write(CSR_IREG, __v);		\
> +} while (0)

Any reason why these macros can't be inlines?

> +const struct imsic_global_config *imsic_get_global_config(void)
> +{
> +	return imsic ? &imsic->global : NULL;
> +}
> +EXPORT_SYMBOL_GPL(imsic_get_global_config);

Why is this exported?

> +#define __imsic_id_read_clear_enabled(__id)		\
> +	__imsic_eix_read_clear((__id), false)
> +#define __imsic_id_read_clear_pending(__id)		\
> +	__imsic_eix_read_clear((__id), true)

Please use inlines.

> +void __imsic_eix_update(unsigned long base_id,
> +			unsigned long num_id, bool pend, bool val)
> +{
> +	unsigned long i, isel, ireg;
> +	unsigned long id = base_id, last_id = base_id + num_id;
> +
> +	while (id < last_id) {
> +		isel = id / BITS_PER_LONG;
> +		isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
> +		isel += (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
> +
> +		ireg = 0;
> +		for (i = id & (__riscv_xlen - 1);
> +		     (id < last_id) && (i < __riscv_xlen); i++) {
> +			ireg |= BIT(i);
> +			id++;
> +		}

This lacks a comment what this is doing.

> +
> +		/*
> +		 * The IMSIC EIEx and EIPx registers are indirectly
> +		 * accessed via using ISELECT and IREG CSRs so we
> +		 * need to access these CSRs without getting preempted.
> +		 *
> +		 * All existing users of this function call this
> +		 * function with local IRQs disabled so we don't
> +		 * need to do anything special here.
> +		 */
> +		if (val)
> +			imsic_csr_set(isel, ireg);
> +		else
> +			imsic_csr_clear(isel, ireg);
> +	}
> +}
> +
> +void imsic_local_sync(void)
> +{
> +	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
> +	struct imsic_local_config *mlocal;
> +	struct imsic_vector *mvec;
> +	unsigned long flags;
> +	int i;
> +
> +	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> +	for (i = 1; i <= imsic->global.nr_ids; i++) {
> +		if (i == IMSIC_IPI_ID)
> +			continue;
> +
> +		if (test_bit(i, lpriv->ids_enabled_bitmap))
> +			__imsic_id_set_enable(i);
> +		else
> +			__imsic_id_clear_enable(i);
> +
> +		mvec = lpriv->ids_move[i];
> +		lpriv->ids_move[i] = NULL;
> +		if (mvec) {
> +			if (__imsic_id_read_clear_pending(i)) {
> +				mlocal = per_cpu_ptr(imsic->global.local,
> +						     mvec->cpu);
> +				writel_relaxed(mvec->local_id, mlocal->msi_va);
> +			}
> +
> +			imsic_vector_free(&lpriv->vectors[i]);
> +		}

Again an uncommented piece of magic which you will have forgotten what
it does 3 month down the road :)

> +
> +	}
> +	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
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
> +static void imsic_remote_sync(unsigned int cpu)
> +{
> +	/*
> +	 * We simply inject ID synchronization IPI to a target CPU
> +	 * if it is not same as the current CPU. The ipi_send_mask()
> +	 * implementation of IPI mux will inject ID synchronization
> +	 * IPI only for CPUs that have enabled it so offline CPUs
> +	 * won't receive IPI. An offline CPU will unconditionally
> +	 * synchronize IDs through imsic_starting_cpu() when the
> +	 * CPU is brought up.
> +	 */
> +	if (cpu_online(cpu)) {
> +		if (cpu != smp_processor_id())
> +			__ipi_send_mask(imsic->ipi_lsync_desc, cpumask_of(cpu));

Still wondering why this can't use the regular API. There might be a
reason, but then it wants to be documented.

> +		else
> +			imsic_local_sync();
> +	}
> +}
> +#else
> +static inline void imsic_remote_sync(unsigned int cpu)
> +{
> +	imsic_local_sync();
> +}
> +#endif
> +
> +void imsic_vector_mask(struct imsic_vector *vec)
> +{
> +	struct imsic_local_priv *lpriv;
> +	unsigned long flags;
> +
> +	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
> +	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
> +		return;
> +
> +	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);

AFAICT, this is used from an irqchip callback:

static void imsic_irq_mask(struct irq_data *d)
{
        imsic_vector_mask(irq_data_get_irq_chip_data(d));
}

So no need to use irqsave() here. Those callbacks run always with
interrupts disabled when called from the core.

> +void imsic_vector_move(struct imsic_vector *old_vec,
> +			struct imsic_vector *new_vec)
> +{
> +	struct imsic_local_priv *old_lpriv, *new_lpriv;
> +	unsigned long flags, flags1;
> +
> +	if (WARN_ON(old_vec->cpu == new_vec->cpu))
> +		return;
> +
> +	old_lpriv = per_cpu_ptr(imsic->lpriv, old_vec->cpu);
> +	if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] != old_vec))
> +		return;
> +
> +	new_lpriv = per_cpu_ptr(imsic->lpriv, new_vec->cpu);
> +	if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] != new_vec))
> +		return;
> +
> +	raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
> +	raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);

Lockdep should yell at you for this, rightfully so. And not only because
of the missing nested() annotation.

Assume there are two CPUs setting affinity for two different interrupts.

CPU0 moves an interrupt to CPU1 and CPU1 moves another interrupt to
CPU0. The resulting lock order is:

CPU0                     CPU1
lock(lpriv[CPU0]);       lock(lpriv[CPU1]);
lock(lpriv[CPU1]);       lock(lpriv[CPU0]);

a classic ABBA deadlock.

You need to take those locks always in the same order. Look at
double_raw_lock() in kernel/sched/sched.h.

> +	/* Unmask the new vector entry */
> +	if (test_bit(old_vec->local_id, old_lpriv->ids_enabled_bitmap))
> +		bitmap_set(new_lpriv->ids_enabled_bitmap,
> +			   new_vec->local_id, 1);

Either make that one line or please add brackets. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#bracket-rules

> +static int __init imsic_local_init(void)
> +{
> +	struct imsic_global_config *global = &imsic->global;
> +	struct imsic_local_priv *lpriv;
> +	struct imsic_vector *vec;
> +	int cpu, i;
> +
> +	/* Allocate per-CPU private state */
> +	imsic->lpriv = alloc_percpu(typeof(*(imsic->lpriv)));
> +	if (!imsic->lpriv)
> +		return -ENOMEM;
> +
> +	/* Setup per-CPU private state */
> +	for_each_possible_cpu(cpu) {
> +		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
> +
> +		raw_spin_lock_init(&lpriv->ids_lock);
> +
> +		/* Allocate enabled bitmap */
> +		lpriv->ids_enabled_bitmap = bitmap_zalloc(global->nr_ids + 1,
> +							  GFP_KERNEL);
> +		if (!lpriv->ids_enabled_bitmap) {
> +			imsic_local_cleanup();
> +			return -ENOMEM;
> +		}
> +
> +		/* Allocate move array */
> +		lpriv->ids_move = kcalloc(global->nr_ids + 1,
> +					sizeof(*lpriv->ids_move), GFP_KERNEL);
> +		if (!lpriv->ids_move) {
> +			imsic_local_cleanup();
> +			return -ENOMEM;
> +		}
> +
> +		/* Allocate vector array */
> +		lpriv->vectors = kcalloc(global->nr_ids + 1,
> +					 sizeof(*lpriv->vectors), GFP_KERNEL);
> +		if (!lpriv->vectors) {
> +			imsic_local_cleanup();
> +			return -ENOMEM;

Third instance of the same pattern. goto cleanup; perhaps?

> +struct imsic_vector *imsic_vector_alloc(unsigned int hwirq,
> +					const struct cpumask *mask)
> +{
> +	struct imsic_vector *vec = NULL;
> +	struct imsic_local_priv *lpriv;
> +	unsigned long flags;
> +	unsigned int cpu;
> +	int local_id;
> +
> +	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
> +	local_id = irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
> +	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
> +	if (local_id < 0)
> +		return NULL;
> +
> +	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
> +	vec = &lpriv->vectors[local_id];
> +	vec->hwirq = hwirq;
> +
> +	return vec;
> +}

..

> +int imsic_hwirq_alloc(void)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&imsic->hwirqs_lock, flags);
> +	ret = bitmap_find_free_region(imsic->hwirqs_used_bitmap,
> +				      imsic->nr_hwirqs, 0);
> +	raw_spin_unlock_irqrestore(&imsic->hwirqs_lock, flags);
> +
> +	return ret;
> +}

This part is just to create a unique hwirq number, right?

> +
> +	/* Find number of guest index bits in MSI address */
> +	rc = of_property_read_u32(to_of_node(fwnode),
> +				  "riscv,guest-index-bits",
> +				  &global->guest_index_bits);
> +	if (rc)
> +		global->guest_index_bits = 0;

So here you get the index bits, but then 50 lines further down you do
sanity checking. Wouldn't it make sense to do that right here?

Same for the other bits.

> +
> +/*
> + * The IMSIC driver uses 1 IPI for ID synchronization and
> + * arch/riscv/kernel/smp.c require 6 IPIs so we fix the
> + * total number of IPIs to 8.
> + */
> +#define IMSIC_IPI_ID				1
> +#define IMSIC_NR_IPI				8
> +
> +struct imsic_vector {
> +	/* Fixed details of the vector */
> +	unsigned int cpu;
> +	unsigned int local_id;
> +	/* Details saved by driver in the vector */
> +	unsigned int hwirq;
> +};
> +
> +struct imsic_local_priv {
> +	/* Local state of interrupt identities */
> +	raw_spinlock_t ids_lock;
> +	unsigned long *ids_enabled_bitmap;
> +	struct imsic_vector **ids_move;
> +
> +	/* Local vector table */
> +	struct imsic_vector *vectors;

Please make those structs tabular:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +void __imsic_eix_update(unsigned long base_id,
> +			unsigned long num_id, bool pend, bool val);
> +
> +#define __imsic_id_set_enable(__id)		\
> +	__imsic_eix_update((__id), 1, false, true)
> +#define __imsic_id_clear_enable(__id)	\
> +	__imsic_eix_update((__id), 1, false, false)

inlines please.

Thanks,

        tglx

