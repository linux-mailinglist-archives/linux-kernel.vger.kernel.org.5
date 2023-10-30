Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8237DB3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjJ3HPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:15:09 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C5BD;
        Mon, 30 Oct 2023 00:15:05 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39U7Cl8k048592;
        Mon, 30 Oct 2023 15:12:47 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from APC323 (10.0.12.98) by ATCPCS16.andestech.com (10.0.1.222) with
 Microsoft SMTP Server id 14.3.498.0; Mon, 30 Oct 2023 15:12:46 +0800
Date:   Mon, 30 Oct 2023 15:12:46 +0800
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
        <ycliang@andestech.com>
Subject: Re: [RFC PATCH v3 RESEND 02/13] irqchip/riscv-intc: Allow large
 non-standard hwirq number
Message-ID: <ZT9XbuxE2vlvsfYG@APC323>
References: <20231023004100.2663486-1-peterlin@andestech.com>
 <20231023004100.2663486-3-peterlin@andestech.com>
 <87a5s44jyc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a5s44jyc.ffs@tglx>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Originating-IP: [10.0.12.98]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39U7Cl8k048592
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the review.

On Fri, Oct 27, 2023 at 09:12:59AM +0200, Thomas Gleixner wrote:
> On Mon, Oct 23 2023 at 08:40, Yu Chien Peter Lin wrote:
> > Currently, the implementation of the RISC-V INTC driver uses the
> > interrupt cause as hwirq and has a limitation of supporting a
> > maximum of 64 hwirqs. However, according to the privileged spec,
> > interrupt causes >= 16 are defined for platform use.
> >
> > This limitation prevents us from fully utilizing the available
> > local interrupt sources. Additionally, the hwirqs used on RISC-V
> > are sparse, with only interrupt numbers 1, 5 and 9 (plus Sscofpmf
> > or T-Head's PMU irq) being currently used for supervisor mode.
> >
> > The patch switches to using irq_domain_create_tree() which
> 
> git grep "This patch" Documentation/process/

Sure, will fix.

> > creates the radix tree map, allowing us to handle a larger
> > number of hwirqs.
> 
> Who is 'us'? We are not part of the chip and please write out 'hardware
> interrupts'

OK!

> > @@ -24,10 +24,8 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> >  {
> >  	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> >  
> > -	if (unlikely(cause >= BITS_PER_LONG))
> > -		panic("unexpected interrupt cause");
> > -
> > -	generic_handle_domain_irq(intc_domain, cause);
> > +	if (generic_handle_domain_irq(intc_domain, cause))
> > +		pr_warn("Failed to handle interrupt (cause: %ld)\n", cause);
> 
> pr_warn_once() or at least pr_warn_ratelimited().

OK!

> >  }
> >  
> >  /*
> > @@ -117,8 +115,8 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
> >  {
> >  	int rc;
> >  
> > -	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
> > -					       &riscv_intc_domain_ops, NULL);
> > +	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops,
> > +					     NULL);
> 
> Put it into one line. Linebreaking arguments is really only required
> when the line length is exceedingly long. This one is not.

OK! will fix.

Thanks,
Peter Lin
