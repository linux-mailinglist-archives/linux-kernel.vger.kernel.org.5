Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A807D8215
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjJZLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjJZLyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:54:35 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 849011AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:54:30 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,253,1694707200"; 
   d="scan'208";a="94461326"
Date:   Thu, 26 Oct 2023 19:54:18 +0800
From:   Fang Xiang <fangxiang3@xiaomi.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix the coherent issue in
 its_setup_baser() when shr = 0.
Message-ID: <ZTpTauttERYInyA/@oa-fangxiang3.localdomain>
References: <20231026020116.4238-1-fangxiang3@xiaomi.com>
 <87sf5x6cdu.wl-maz@kernel.org>
 <ZTonzQvHedqa7Uj9@oa-fangxiang3.localdomain>
 <86bkcl4sve.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86bkcl4sve.wl-maz@kernel.org>
X-Originating-IP: [10.237.8.19]
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To BJ-MBX15.mioffice.cn
 (10.237.8.135)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:48:05AM +0100, Marc Zyngier wrote:
> On Thu, 26 Oct 2023 09:48:13 +0100,
> Fang Xiang <fangxiang3@xiaomi.com> wrote:
> > 
> > On Thu, Oct 26, 2023 at 09:01:17AM +0100, Marc Zyngier wrote:
> > > On Thu, 26 Oct 2023 03:01:16 +0100,
> > > Fang Xiang <fangxiang3@xiaomi.com> wrote:
> > > > 
> > > > The table would not be flushed if the input parameter shr = 0 in
> > > > its_setup_baser() and it would cause a coherent problem.
> > > 
> > > Would? Or does? I'm asking, as you have previously indicated that this
> > > workaround was working for you.
> > > 
> > > Have you actually observed a problem? Or is that by inspection?
> > > 
> > I actually observed this problem on my device. GIC get a dirty table
> > because CPU did not flush the clean one to memory.
> 
> So how comes you previously reported that it was working for you?
> 

It is a complicated situation. Just the Virtual CPUs table is dirty on
my device, so the physical LPI works well.

> > > > 
> > > > Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
> > > > ---
> > > >  drivers/irqchip/irq-gic-v3-its.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > > > index 75a2dd550625..58a9f24ccfa7 100644
> > > > --- a/drivers/irqchip/irq-gic-v3-its.c
> > > > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > > > @@ -2394,13 +2394,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
> > > >  		 * non-cacheable as well.
> > > >  		 */
> > > >  		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
> > > > -		if (!shr) {
> > > > +		if (!shr)
> > > >  			cache = GITS_BASER_nC;
> > > > -			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > > > -		}
> > > > +
> > > >  		goto retry_baser;
> > > >  	}
> > > >  
> > > > +	if (!shr)
> > > > +		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > > > +
> > > 
> > > This is wrong. You're doing the cache clean *after* the register has
> > > been programmed with its final value, and the ITS is perfectly allowed
> > > to prefetch anything it wants as soon as you program the register. The
> > > clean must thus happen before the write. Yes, it was wrong before, but
> > > you are now making it wrong always.
> > Sorry for that. But on my device, GIC would not read the table before
> > ITS enable(GITS_CTLR.Enabled == 1). When ITS is disabled, the prefetch
> > happens ever in other platforms?
> 
> GITS_CTLR.Enabled == 1 controls the *translation* (i.e. whether a
> write to GITS_TRANSLATER gets processed or not). It doesn't say
> anything of the tables that are pointed to by the ITS.
> 
> If you care to read the spec, you will find this (Arm IHI 0069H, page
> 5-95, "Software access to the private ITS tables"):
> 
> <quote>
> * For a table that is pointed to by a GITS_BASER<n> register for which
>   GITS_BASER<n>.Valid == 1 and GITS_BASER<n>.Indirect == 0, behavior is
>   UNPREDICTABLE if the table is written by software.
> </quote>
> 
> and a cache clean definitely counts as a write from the PoV of the
> ITS. What your device does is pretty much irrelevant, as the
> architecture allows any sort of access as soon as the Valid bit is
> set.
> 

Yes, I see it. The tables should be flushed before we write the GITS_BASER[n]
registers.

> > > 
> > > >  	if (val != tmp) {
> > > >  		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
> > > >  		       &its->phys_base, its_base_type_string[type],
> > > 
> > > Overall, I think we need a slightly better fix. Since non-coherent
> > > ITSs are quickly becoming the common case, we can save ourselves some
> > > effort and hoist the quirked attributes early.
> > > 
> > > Does the hack below work for you?
> > > 
> > > 	M.
> > > 
> > > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > > index 75a2dd550625..d76d44ea2de1 100644
> > > --- a/drivers/irqchip/irq-gic-v3-its.c
> > > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > > @@ -2379,12 +2379,12 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
> > >  		break;
> > >  	}
> > >  
> > > +	if (!shr)
> > > +		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > > +
> > >  	its_write_baser(its, baser, val);
> > >  	tmp = baser->val;
> > >  
> > > -	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
> > > -		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
> > > -
> > >  	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
> > >  		/*
> > >  		 * Shareability didn't stick. Just use
> > > @@ -2394,10 +2394,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
> > >  		 * non-cacheable as well.
> > >  		 */
> > >  		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
> > > -		if (!shr) {
> > > +		if (!shr)
> > >  			cache = GITS_BASER_nC;
> > > -			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > > -		}
> > > +
> > >  		goto retry_baser;
> > >  	}
> > >  
> > > @@ -2609,6 +2608,11 @@ static int its_alloc_tables(struct its_node *its)
> > >  		/* erratum 24313: ignore memory access type */
> > >  		cache = GITS_BASER_nCnB;
> > >  
> > > +	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE) {
> > > +		cache = GITS_BASER_nC;
> > > +		shr = 0;
> > > +	}
> > > +
> > >  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
> > >  		struct its_baser *baser = its->tables + i;
> > >  		u64 val = its_read_baser(its, baser);
> > > 
> > There maybe a risk in this patch above when non-shareable attibute indicated
> > by hardware, the table would not be flushed ever.
> 
> How? If the HW rejects the shareability attribute, we set shr to 0 and
> hit the retry path. At this point, we will clean the page to the PoC
> before writing the register again.
> 
> What am I missing?
> 

Sorry, It is a good fix. I will test it on my device and give a feedback
soon.

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
