Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA6811818
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442430AbjLMPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442351AbjLMPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:47:37 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB42F2;
        Wed, 13 Dec 2023 07:47:42 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3BDFis7u072509;
        Wed, 13 Dec 2023 23:44:54 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Wed, 13 Dec 2023 23:44:53 +0800
Date:   Wed, 13 Dec 2023 23:44:49 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Anup Patel <apatel@ventanamicro.com>
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
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <ycliang@andestech.com>, <inochiama@outlook.com>
Subject: Re: [PATCH v5 03/16] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
Message-ID: <ZXnRcfuvQBo6UDCx@APC323>
References: <20231213070301.1684751-1-peterlin@andestech.com>
 <20231213070301.1684751-4-peterlin@andestech.com>
 <CAK9=C2WC2i7XkjDgbjccVn03BYfnE_YS4YiA6ZWMj6GDyTjJKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2WC2i7XkjDgbjccVn03BYfnE_YS4YiA6ZWMj6GDyTjJKA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3BDFis7u072509
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 08:15:28PM +0530, Anup Patel wrote:
> On Wed, Dec 13, 2023 at 12:35 PM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > Add support for the Andes hart-level interrupt controller. This
> > controller provides interrupt mask/unmask functions to access the
> > custom register (SLIE) where the non-standard S-mode local interrupt
> > enable bits are located.
> >
> > To share the riscv_intc_domain_map() with the generic RISC-V INTC and
> > ACPI, add a chip parameter to riscv_intc_init_common(), so it can be
> > passed to the irq_domain_set_info() as private data.
> >
> > Andes hart-level interrupt controller requires the "andestech,cpu-intc"
> > compatible string to be present in interrupt-controller of cpu node.
> > e.g.,
> >
> >   cpu0: cpu@0 {
> >       compatible = "andestech,ax45mp", "riscv";
> >       ...
> >       cpu0-intc: interrupt-controller {
> >           #interrupt-cells = <0x01>;
> >           compatible = "andestech,cpu-intc", "riscv,cpu-intc";
> >           interrupt-controller;
> >       };
> >   };
> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> > Changes v1 -> v2:
> >   - New patch
> > Changes v2 -> v3:
> >   - Return -ENXIO if no valid compatible INTC found
> >   - Allow falling back to generic RISC-V INTC
> > Changes v3 -> v4: (Suggested by Thomas [1])
> >   - Add comment to andes irq chip function
> >   - Refine code flow to share with generic RISC-V INTC and ACPI
> >   - Move Andes specific definitions to include/linux/soc/andes/irq.h
> > Changes v4 -> v5: (Suggested by Thomas)
> >   - Fix commit message
> >   - Subtract ANDES_SLI_CAUSE_BASE from d->hwirq to calculate the value of mask
> >   - Do not set chip_data to the chip itself with irq_domain_set_info()
> >   - Follow reverse fir tree order variable declarations
> >
> > [1] https://patchwork.kernel.org/project/linux-riscv/patch/20231019135723.3657156-1-peterlin@andestech.com/
> > ---
> >  drivers/irqchip/irq-riscv-intc.c | 53 ++++++++++++++++++++++++++++----
> >  include/linux/soc/andes/irq.h    | 17 ++++++++++
> >  2 files changed, 64 insertions(+), 6 deletions(-)
> >  create mode 100644 include/linux/soc/andes/irq.h
> >
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index 2fdd40f2a791..0b6bf3fb1dba 100644
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
> >         csr_set(CSR_IE, BIT(d->hwirq));
> >  }
> >
> > +static void andes_intc_irq_mask(struct irq_data *d)
> > +{
> > +       /*
> > +        * Andes specific S-mode local interrupt causes (hwirq)
> > +        * are defined as (256 + n) and controlled by n-th bit
> > +        * of SLIE.
> > +        */
> > +       unsigned int mask = BIT(d->hwirq - ANDES_SLI_CAUSE_BASE);
> > +
> > +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> > +               csr_clear(CSR_IE, mask);
> > +       else
> > +               csr_clear(ANDES_CSR_SLIE, mask);
> > +}
> > +
> > +static void andes_intc_irq_unmask(struct irq_data *d)
> > +{
> > +       unsigned int mask = BIT(d->hwirq - ANDES_SLI_CAUSE_BASE);
> > +
> > +       if (d->hwirq < ANDES_SLI_CAUSE_BASE)
> > +               csr_set(CSR_IE, mask);
> > +       else
> > +               csr_set(ANDES_CSR_SLIE, mask);
> 
> Clearly, Andes does not have any CSR for:
> XLEN <= local interrupt <ANDES_SLI_CAUSE_BASE
> and
> ANDES_SLI_CAUSE_BASE + XLEN <= local interrupt

Ah, what am I doing here.
sorry for that silly patch.

Regards,
Peter Lin

> Regards,
> Anup
