Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029A7AD87F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjIYNBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjIYNBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:01:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A88F9F;
        Mon, 25 Sep 2023 06:01:14 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RvNFR4w9hzMlbW;
        Mon, 25 Sep 2023 20:57:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 21:01:11 +0800
Message-ID: <efd9f7dc-c9e8-99a5-e139-20133b30903c@huawei.com>
Date:   Mon, 25 Sep 2023 21:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v8 10/16] irqchip/riscv-imsic: Add support for platform
 MSI irqdomain
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        <linux-riscv@lists.infradead.org>,
        Andrew Jones <ajones@ventanamicro.com>
References: <20230912174928.528414-1-apatel@ventanamicro.com>
 <20230912174928.528414-11-apatel@ventanamicro.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230912174928.528414-11-apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/13 1:49, Anup Patel wrote:
> The Linux platform MSI support requires a platform MSI irqdomain so
> let us add a platform irqchip driver for RISC-V IMSIC which provides
> a base IRQ domain and platform MSI domain. This driver assumes that
> the IMSIC state is already initialized by the IMSIC early driver.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/irqchip/Makefile                   |   2 +-
>  drivers/irqchip/irq-riscv-imsic-platform.c | 280 +++++++++++++++++++++
>  2 files changed, 281 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c
> 
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index d714724387ce..abca445a3229 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -95,7 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
>  obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
>  obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
>  obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
> -obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o
> +obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
>  obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
>  obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
>  obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
> new file mode 100644
> index 000000000000..b78f1b2ee3dc
> --- /dev/null
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/cpu.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/smp.h>
> +
> +#include "irq-riscv-imsic-state.h"
> +
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
> +
> +	if (out_msi_pa)
> +		*out_msi_pa = local->msi_pa +
> +			      (guest_index * IMSIC_MMIO_PAGE_SZ);
> +
> +	return 0;
> +}
> +
> +static int imsic_get_cpu(const struct cpumask *mask_val, bool force,
> +			 unsigned int *out_target_cpu)
> +{
> +	unsigned int cpu;
> +
> +	if (force)
> +		cpu = cpumask_first(mask_val);
> +	else
> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (out_target_cpu)
> +		*out_target_cpu = cpu;
> +
> +	return 0;
> +}
> +
> +static void imsic_irq_mask(struct irq_data *d)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> +	bitmap_clear(imsic->ids_enabled_bimap, d->hwirq, 1);
> +	__imsic_id_disable(d->hwirq);
> +	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> +
> +	imsic_ids_remote_sync();
> +}
> +
> +static void imsic_irq_unmask(struct irq_data *d)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&imsic->ids_lock, flags);
> +	bitmap_set(imsic->ids_enabled_bimap, d->hwirq, 1);
> +	__imsic_id_enable(d->hwirq);
> +	raw_spin_unlock_irqrestore(&imsic->ids_lock, flags);
> +
> +	imsic_ids_remote_sync();
> +}
> +
> +static void imsic_irq_compose_msi_msg(struct irq_data *d,
> +				      struct msi_msg *msg)
> +{
> +	phys_addr_t msi_addr;
> +	unsigned int cpu;
> +	int err;
> +
> +	cpu = imsic_id_get_target(d->hwirq);
> +	if (WARN_ON(cpu == UINT_MAX))
> +		return;
> +
> +	err = imsic_cpu_page_phys(cpu, 0, &msi_addr);
> +	if (WARN_ON(err))
> +		return;
> +
> +	msg->address_hi = upper_32_bits(msi_addr);
> +	msg->address_lo = lower_32_bits(msi_addr);
> +	msg->data = d->hwirq;
> +}
> +
> +#ifdef CONFIG_SMP
> +static int imsic_irq_set_affinity(struct irq_data *d,
> +				  const struct cpumask *mask_val,
> +				  bool force)
> +{
> +	unsigned int target_cpu;
> +	int rc;
> +
> +	rc = imsic_get_cpu(mask_val, force, &target_cpu);
> +	if (rc)
> +		return rc;
> +
> +	imsic_id_set_target(d->hwirq, target_cpu);
> +	irq_data_update_effective_affinity(d, cpumask_of(target_cpu));

According to the “The RISC-V Advanced Interrupt Architecture Version
0.2-draft”，the "3.1 Interrupt files and interrupt identities" has
following description.

Thus the total number of MSI sources that can be separately distinguished
within a system is potentially the product of the number of interrupt
identities at a single interrupt
file times the total number of interrupt files in the system, over all
harts.

In my opinion, the MSI interrupt number is a local interrupt number.
However, when the above interrupt affinity is set, it is processed as a
global interrupt number, which seems not comply with the above RISC-V
specifications.

> +
> +	return IRQ_SET_MASK_OK;
> +}
> +#endif
> +
> +static struct irq_chip imsic_irq_base_chip = {
> +	.name			= "IMSIC-BASE",
> +	.irq_mask		= imsic_irq_mask,
> +	.irq_unmask		= imsic_irq_unmask,
> +#ifdef CONFIG_SMP
> +	.irq_set_affinity	= imsic_irq_set_affinity,
> +#endif
> +	.irq_compose_msi_msg	= imsic_irq_compose_msi_msg,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int imsic_irq_domain_alloc(struct irq_domain *domain,
> +				  unsigned int virq,
> +				  unsigned int nr_irqs,
> +				  void *args)
> +{
> +	int i, hwirq, err = 0;
> +	unsigned int cpu;
> +
> +	err = imsic_get_cpu(cpu_online_mask, false, &cpu);
> +	if (err)
> +		return err;
> +
> +	hwirq = imsic_ids_alloc(get_count_order(nr_irqs));
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		imsic_id_set_target(hwirq + i, cpu);
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &imsic_irq_base_chip, imsic,
> +				    handle_simple_irq, NULL, NULL);
> +		irq_set_noprobe(virq + i);
> +		irq_set_affinity(virq + i, cpu_online_mask);
> +		/*
> +		 * IMSIC does not implement irq_disable() so Linux interrupt
> +		 * subsystem will take a lazy approach for disabling an IMSIC
> +		 * interrupt. This means IMSIC interrupts are left unmasked
> +		 * upon system suspend and interrupts are not processed
> +		 * immediately upon system wake up. To tackle this, we disable
> +		 * the lazy approach for all IMSIC interrupts.
> +		 */
> +		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> +	}
> +
> +	return 0;
> +}
> +
> +static void imsic_irq_domain_free(struct irq_domain *domain,
> +				  unsigned int virq,
> +				  unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +
> +	imsic_ids_free(d->hwirq, get_count_order(nr_irqs));
> +	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
> +}
> +
> +static const struct irq_domain_ops imsic_base_domain_ops = {
> +	.alloc		= imsic_irq_domain_alloc,
> +	.free		= imsic_irq_domain_free,
> +};
> +
> +static struct irq_chip imsic_plat_irq_chip = {
> +	.name			= "IMSIC-PLAT",
> +};
> +
> +static struct msi_domain_ops imsic_plat_domain_ops = {
> +};
> +
> +static struct msi_domain_info imsic_plat_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> +	.ops	= &imsic_plat_domain_ops,
> +	.chip	= &imsic_plat_irq_chip,
> +};
> +
> +static int imsic_irq_domains_init(struct device *dev)
> +{
> +	/* Create Base IRQ domain */
> +	imsic->base_domain = irq_domain_create_tree(dev->fwnode,
> +					&imsic_base_domain_ops, imsic);
> +	if (!imsic->base_domain) {
> +		dev_err(dev, "failed to create IMSIC base domain\n");
> +		return -ENOMEM;
> +	}
> +	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
> +
> +	/* Create Platform MSI domain */
> +	imsic->plat_domain = platform_msi_create_irq_domain(dev->fwnode,
> +						&imsic_plat_domain_info,
> +						imsic->base_domain);
> +	if (!imsic->plat_domain) {
> +		dev_err(dev, "failed to create IMSIC platform domain\n");
> +		irq_domain_remove(imsic->base_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imsic_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imsic_global_config *global;
> +	int rc;
> +
> +	if (!imsic) {
> +		dev_err(dev, "early driver not probed\n");
> +		return -ENODEV;
> +	}
> +
> +	if (imsic->base_domain) {
> +		dev_err(dev, "irq domain already created\n");
> +		return -ENODEV;
> +	}
> +
> +	global = &imsic->global;
> +
> +	/* Initialize IRQ and MSI domains */
> +	rc = imsic_irq_domains_init(dev);
> +	if (rc) {
> +		dev_err(dev, "failed to initialize IRQ and MSI domains\n");
> +		return rc;
> +	}
> +
> +	dev_info(dev, "  hart-index-bits: %d,  guest-index-bits: %d\n",
> +		 global->hart_index_bits, global->guest_index_bits);
> +	dev_info(dev, " group-index-bits: %d, group-index-shift: %d\n",
> +		 global->group_index_bits, global->group_index_shift);
> +	dev_info(dev, " mapped %d interrupts at base PPN %pa\n",
> +		 global->nr_ids, &global->base_addr);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imsic_platform_match[] = {
> +	{ .compatible = "riscv,imsics" },
> +	{}
> +};
> +
> +static struct platform_driver imsic_platform_driver = {
> +	.driver = {
> +		.name		= "riscv-imsic",
> +		.of_match_table	= imsic_platform_match,
> +	},
> +	.probe = imsic_platform_probe,
> +};
> +
> +static int __init imsic_platform_init(void)
> +{
> +	/*
> +	 * Register IMSIC driver as early as possible so that IMSIC
> +	 * platform device is probed as soon as it is created.
> +	 */
> +	return platform_driver_register(&imsic_platform_driver);
> +}
> +core_initcall(imsic_platform_init);
