Return-Path: <linux-kernel+bounces-69278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA6858687
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0ED1F2337C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449912FF60;
	Fri, 16 Feb 2024 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gbNTdydo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BpURH+0+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD6131E5C;
	Fri, 16 Feb 2024 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114333; cv=none; b=Py7GM8JUWA0vGzLh1f1ZPC56AfgF8Ao6nt4QV4WPBHD0CRq46arSiEyQAdVcuxmNo93KWO768lTOPFu2l+ylOohuihmhgDytzeQCzF3NJZfwrQQmyUdPQPRR/8NHJmMCoNn0ItXGAicfgKLa2mBuurBtsGQ+vanNTgUJvE542nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114333; c=relaxed/simple;
	bh=CS9fziBxwe+7011P3OXioKG7MNBGD/GypjYfCe0rofE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgj4dx+DOZMI/8+XY93E4QV8bJKoK6uGzJrGaGgOMH0RPv1WQ8OBDBcM13zKVaOgm8V9D3zg1Gutf03JaUU/3hRch6eTWmSszUClYaIrYmvpKLH/HEG0fUCWr3XGJjLNONSD5FlYl29BkE9mKWjIrZ+fH2DTNDwQQ6bB4AM3FW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gbNTdydo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BpURH+0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708114329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+tB/kujNFZx/PbFJr0491oadBrKTzcZgAtTbdQTbqQ=;
	b=gbNTdydo+jPjWAaDEyAIVo7CttcHnz19JfMZKu5oH7PExkQJzPI71koXdu1noRALZlkOA9
	/2MPhKB7vMO2MKYpvk1ZBD1khMgYU5fLTc4M+F9C+RiIhHjElze2iYjA+07CMmXwA90E4O
	Vuag8DCAud4DJ86TpQSXoD8Q/WXd082wKG2wCWhoTLLD5I9vxg/iPPWfSy69OycishX86U
	EV+uwj9+q+Idj6HtIUM63U5FlztfVMe7J0x04FFKQ4GVTQWx1+kgwg7TRZ8dGLBrehBJbX
	XfWE5SQ7mWqIfr/BpQK8efWD/8d+RsBjeTT+cAUuUlhdEedxYsSk/2RIzHvE1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708114329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+tB/kujNFZx/PbFJr0491oadBrKTzcZgAtTbdQTbqQ=;
	b=BpURH+0+9HpxXJvYp/YzPs0YvtEwHXWZekkb6bcARTmdv7gkGdhnHCAgGCl6LOmuPrkxbt
	7iAkQwkR1pdlTdAQ==
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
Subject: Re: [PATCH v12 19/25] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <20240127161753.114685-20-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-20-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 21:12:08 +0100
Message-ID: <87eddccgo7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> +static int imsic_cpu_page_phys(unsigned int cpu,
> +			       unsigned int guest_index,
> +			       phys_addr_t *out_msi_pa)
> +{
> +	struct imsic_global_config *global;
> +	struct imsic_local_config *local;
> +
> +	global = &imsic->global;
> +	local = per_cpu_ptr(global->local, cpu);
> +
> +	if (BIT(global->guest_index_bits) <= guest_index)
> +		return -EINVAL;

As the callsite does not care about the return value, just make this
function boolean and return true on success.

> +	if (out_msi_pa)
> +		*out_msi_pa = local->msi_pa +
> +			      (guest_index * IMSIC_MMIO_PAGE_SZ);
> +
> +	return 0;
> +}
> +
> +static void imsic_irq_mask(struct irq_data *d)
> +{
> +	imsic_vector_mask(irq_data_get_irq_chip_data(d));
> +}
> +
> +static void imsic_irq_unmask(struct irq_data *d)
> +{
> +	imsic_vector_unmask(irq_data_get_irq_chip_data(d));
> +}
> +
> +static int imsic_irq_retrigger(struct irq_data *d)
> +{
> +	struct imsic_vector *vec = irq_data_get_irq_chip_data(d);
> +	struct imsic_local_config *local;
> +
> +	if (WARN_ON(vec == NULL))
> +		return -ENOENT;
> +
> +	local = per_cpu_ptr(imsic->global.local, vec->cpu);
> +	writel(vec->local_id, local->msi_va);
> +	return 0;
> +}
> +
> +static void imsic_irq_compose_vector_msg(struct imsic_vector *vec,
> +					 struct msi_msg *msg)
> +{
> +	phys_addr_t msi_addr;
> +	int err;
> +
> +	if (WARN_ON(vec == NULL))
> +		return;
> +
> +	err = imsic_cpu_page_phys(vec->cpu, 0, &msi_addr);
> +	if (WARN_ON(err))
> +		return;

	if (WARN_ON(!imsic_cpu_page_phys(...)))
        	return
Hmm?

> +
> +	msg->address_hi = upper_32_bits(msi_addr);
> +	msg->address_lo = lower_32_bits(msi_addr);
> +	msg->data = vec->local_id;
> +}
> +
> +static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
> +{
> +	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
> +}
> +
> +#ifdef CONFIG_SMP
> +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
> +{
> +	struct msi_msg msg[2] = { [1] = { }, };
> +
> +	imsic_irq_compose_vector_msg(vec, msg);
> +	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
> +}
> +
> +static int imsic_irq_set_affinity(struct irq_data *d,
> +				  const struct cpumask *mask_val,
> +				  bool force)
> +{
> +	struct imsic_vector *old_vec, *new_vec;
> +	struct irq_data *pd = d->parent_data;
> +
> +	old_vec = irq_data_get_irq_chip_data(pd);
> +	if (WARN_ON(old_vec == NULL))
> +		return -ENOENT;
> +
> +	/* Get a new vector on the desired set of CPUs */
> +	new_vec = imsic_vector_alloc(old_vec->hwirq, mask_val);
> +	if (!new_vec)
> +		return -ENOSPC;
> +
> +	/* If old vector belongs to the desired CPU then do nothing */
> +	if (old_vec->cpu == new_vec->cpu) {
> +		imsic_vector_free(new_vec);
> +		return IRQ_SET_MASK_OK_DONE;
> +	}

You can spare that exercise by checking it before the allocation:

        if (cpumask_test_cpu(old_vec->cpu, mask_val))
		return IRQ_SET_MASK_OK_DONE;

> +
> +	/* Point device to the new vector */
> +	imsic_msi_update_msg(d, new_vec);

> +static int imsic_irq_domain_alloc(struct irq_domain *domain,
> +				  unsigned int virq, unsigned int nr_irqs,
> +				  void *args)
> +{
> +	struct imsic_vector *vec;
> +	int hwirq;
> +
> +	/* Legacy-MSI or multi-MSI not supported yet. */

What's legacy MSI in that context?

> +	if (nr_irqs > 1)
> +		return -ENOTSUPP;
> +
> +	hwirq = imsic_hwirq_alloc();
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	vec = imsic_vector_alloc(hwirq, cpu_online_mask);
> +	if (!vec) {
> +		imsic_hwirq_free(hwirq);
> +		return -ENOSPC;
> +	}
> +
> +	irq_domain_set_info(domain, virq, hwirq,
> +			    &imsic_irq_base_chip, vec,
> +			    handle_simple_irq, NULL, NULL);
> +	irq_set_noprobe(virq);
> +	irq_set_affinity(virq, cpu_online_mask);
> +
> +	/*
> +	 * IMSIC does not implement irq_disable() so Linux interrupt
> +	 * subsystem will take a lazy approach for disabling an IMSIC
> +	 * interrupt. This means IMSIC interrupts are left unmasked
> +	 * upon system suspend and interrupts are not processed
> +	 * immediately upon system wake up. To tackle this, we disable
> +	 * the lazy approach for all IMSIC interrupts.

Why? Lazy works perfectly fine even w/o an irq_disable() callback.

> +	 */
> +	irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);

> +
> +#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)

You really love macro indirections :)

> +static const struct msi_parent_ops imsic_msi_parent_ops = {
> +	.supported_flags	= MSI_GENERIC_FLAGS_MASK,
> +	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> +				  MSI_FLAG_USE_DEF_CHIP_OPS,
> +	.bus_select_token	= DOMAIN_BUS_NEXUS,
> +	.bus_select_mask	= MATCH_PLATFORM_MSI,
> +	.init_dev_msi_info	= imsic_init_dev_msi_info,
> +};
> +
> +int imsic_irqdomain_init(void)
> +{
> +	struct imsic_global_config *global;
> +
> +	if (!imsic || !imsic->fwnode) {
> +		pr_err("early driver not probed\n");
> +		return -ENODEV;
> +	}
> +
> +	if (imsic->base_domain) {
> +		pr_err("%pfwP: irq domain already created\n", imsic->fwnode);
> +		return -ENODEV;
> +	}
> +
> +	global = &imsic->global;

Please move that assignment down to the usage site. Here it's just a
distraction.

> +	/* Create Base IRQ domain */
> +	imsic->base_domain = irq_domain_create_tree(imsic->fwnode,
> +					&imsic_base_domain_ops, imsic);
> +	if (!imsic->base_domain) {
> +		pr_err("%pfwP: failed to create IMSIC base domain\n",
> +			imsic->fwnode);
> +		return -ENOMEM;
> +	}
> +	imsic->base_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	imsic->base_domain->msi_parent_ops = &imsic_msi_parent_ops;

Thanks,

        tglx

