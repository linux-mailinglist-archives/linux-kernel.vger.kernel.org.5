Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2A80E928
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjLLKac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:30:30 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635FAC;
        Tue, 12 Dec 2023 02:30:34 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3BCASoWD093073;
        Tue, 12 Dec 2023 18:28:50 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Tue, 12 Dec 2023 18:28:47 +0800
Date:   Tue, 12 Dec 2023 18:28:47 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterz@infradead.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tim609@andestech.com>,
        <uwu@icenowy.me>, <wens@csie.org>, <will@kernel.org>,
        <ycliang@andestech.com>, <inochiama@outlook.com>
Subject: Re: [PATCH v4 03/13] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
Message-ID: <ZXg130SN3AOUmx_v@APC323>
References: <20231122121235.827122-1-peterlin@andestech.com>
 <20231122121235.827122-4-peterlin@andestech.com>
 <87y1e4r8db.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87y1e4r8db.ffs@tglx>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3BCASoWD093073
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Dec 08, 2023 at 05:01:36PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 22 2023 at 20:12, Yu Chien Peter Lin wrote:
> > To share the riscv_intc_domain_map() with the generic RISC-V INTC and
> > ACPI, we add a chip parameter to riscv_intc_init_common(), so it can be
> 
> s/we//
> 
> See: Documentation/process/
> 
> > passed to the irq_domain_set_info() as private data.
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index 2fdd40f2a791..30f0036c8978 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/smp.h>
> > +#include <linux/soc/andes/irq.h>
> >  
> >  static struct irq_domain *intc_domain;
> >  
> > @@ -46,6 +47,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
> >  	csr_set(CSR_IE, BIT(d->hwirq));
> >  }
> >  
> > +static void andes_intc_irq_mask(struct irq_data *d)
> > +{
> > +	/*
> > +	 * Andes specific S-mode local interrupt causes (hwirq)
> > +	 * are defined as (256 + n) and controlled by n-th bit
> > +	 * of SLIE.
> > +	 */
> > +	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
> 
> How is this supposed to be correct with BITS_PER_LONG == 64?

Yes, I should subtract ANDES_SLI_CAUSE_BASE directly here.

> > +
> > +	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> > +		csr_clear(CSR_IE, mask);
> > +	else
> > +		csr_clear(ANDES_CSR_SLIE, mask);
> > +}
> > +
> > +static void andes_intc_irq_unmask(struct irq_data *d)
> > +{
> > +	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
> 
> Ditto.
> 
> > +	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> > +		csr_set(CSR_IE, mask);
> > +	else
> > +		csr_set(ANDES_CSR_SLIE, mask);
> > +}
> 
> >  static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
> >  				 irq_hw_number_t hwirq)
> >  {
> > +	struct irq_chip *chip = d->host_data;
> > +
> >  	irq_set_percpu_devid(irq);
> > -	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
> > +	irq_domain_set_info(d, irq, hwirq, chip, d->host_data,
> 
> So this sets 'chip_data' to the chip itself. What's the point? Just set
> it to NULL as the chip obviously does not need chip_data at all.

Will fix. Thanks.

Best regards,
Peter Lin

> >  			    handle_percpu_devid_irq, NULL, NULL);
> >  
> >  	return 0;
> > @@ -112,11 +147,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
> >  	return intc_domain->fwnode;
> >  }
> >  
> > -static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> > +static int __init riscv_intc_init_common(struct fwnode_handle *fn,
> > +					 struct irq_chip *chip)
> >  {
> >  	int rc;
> >  
> > -	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
> > +	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, chip);
> >  	if (!intc_domain) {
> >  		pr_err("unable to add IRQ domain\n");
> >  		return -ENXIO;
> > @@ -138,6 +174,7 @@ static int __init riscv_intc_init(struct device_node *node,
> >  {
> >  	int rc;
> >  	unsigned long hartid;
> > +	struct irq_chip *chip = &riscv_intc_chip;
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
> 
> Thanks
> 
>         tglx
