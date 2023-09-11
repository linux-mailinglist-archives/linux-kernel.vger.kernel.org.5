Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CA79A5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjIKINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIKINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:13:39 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA3DD9;
        Mon, 11 Sep 2023 01:13:33 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 38B8CmIs070091;
        Mon, 11 Sep 2023 16:12:48 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 11 Sep 2023 16:12:45 +0800
Date:   Mon, 11 Sep 2023 16:12:45 +0800
From:   Yu-Chien Peter Lin <peterlin@andestech.com>
To:     Anup Patel <anup@brainfault.org>
CC:     <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor.dooley@microchip.com>,
        <atishp@atishpatra.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>
Subject: Re: [RFC PATCH 2/4] irqchip/riscv-intc: Support large non-standard
 hwirq number
Message-ID: <ZP7L_ahJOBXnCSP7@APC323>
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-3-peterlin@andestech.com>
 <CAAhSdy0iy_7-XaE0s97J8jUESUzV-4BMsxsJ8QFNDyHgtv63ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy0iy_7-XaE0s97J8jUESUzV-4BMsxsJ8QFNDyHgtv63ZA@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 38B8CmIs070091
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 06:36:52PM +0530, Anup Patel wrote:
> On Thu, Sep 7, 2023 at 7:48 AM Yu Chien Peter Lin
> <peterlin@andestech.com> wrote:
> >
> > Currently, the implementation of the RISC-V INTC driver uses the
> > interrupt cause as hwirq and has a limitation of supporting a
> > maximum of 64 hwirqs. However, according to the privileged spec,
> > interrupt cause >= 16 are defined for platform use.
> >
> > This limitation prevents us from fully utilizing the available
> > local interrupt sources. Additionally, the hwirqs used on RISC-V
> > are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> > or T-Head's PMU irq) being currently used for supervisor mode.
> >
> > The patch switches to using irq_domain_create_tree() which
> > creates the radix tree map, allowing us to handle a larger
> > number of hwirqs.
> >
> > Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> > Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> >
> > ---
> > There are 3 hwirqs of local interrupt source exceed 64 defined in
> > AX45MP datasheet [1] Table 56: AX45MP-1C scause Value After Trap:
> > - 256+16 Slave port ECC error interrupt (S-mode)
> > - 256+17 Bus write transaction error interrupt (S-mode)
> > - 256+18 Performance monitor overflow interrupt(S-mode)
> >
> > [1] http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > ---
> >  drivers/irqchip/irq-riscv-intc.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > index 4adeee1bc391..76e1229c45de 100644
> > --- a/drivers/irqchip/irq-riscv-intc.c
> > +++ b/drivers/irqchip/irq-riscv-intc.c
> > @@ -24,8 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> >  {
> >         unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> >
> > -       if (unlikely(cause >= BITS_PER_LONG))
> > -               panic("unexpected interrupt cause");
> > +       if (!irq_find_mapping(intc_domain, cause))
> > +               panic("unexpected interrupt cause: %ld", cause);
> 
> Checking irq_find_mapping() is redundant here instead check the return
> value of generic_handle_domain_irq() and print warning on error.
> 
> >
> >         generic_handle_domain_irq(intc_domain, cause);
> >  }
> > @@ -117,8 +117,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> >  {
> >         int rc;
> >
> > -       intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> > -                                              &riscv_intc_domain_ops, NULL);
> > +       intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
> > +                                            NULL);
> 
> This is incomplete because you have additional customization on-top-of
> vanilla RISC-V INTC.
> 
> I suggest to do the following:
> 1) Define an enum of types of INTC (such as generic, andestech, etc)
> 2) Define new compatible string "andestec,cpu-intc" for you custom INTC
>     and pass that information to riscv_intc_init_common()
> 3) Extend riscv_intc_domain_map() to use custom andestech_intc_chip
>     for the custom local irqs. The andestech_intc_chip will provide andes
>     specific mask/unmask mechanism.

Hi Anup,

Sure, we will introduce the Andes INTC for a custom IRQ chip.

Thanks,
Peter Lin

> >         if (!intc_domain) {
> >                 pr_err("unable to add IRQ domain\n");
> >                 return -ENXIO;
> > @@ -132,8 +132,6 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> >
> >         riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
> >
> > -       pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.34.1
> >
> 
> Regards,
> Anup
