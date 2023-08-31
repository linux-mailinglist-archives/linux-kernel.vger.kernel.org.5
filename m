Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21078F08C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbjHaPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbjHaPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:45:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F4A4E4C;
        Thu, 31 Aug 2023 08:45:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 158B1C15;
        Thu, 31 Aug 2023 08:46:29 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB55A3F64C;
        Thu, 31 Aug 2023 08:45:41 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:45:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/7] irqchip/gic-v3: Enable support for SGIs to act
 as NMIs
Message-ID: <ZPC1nUw3qKWrC85l@FVFF77S0Q05N.cambridge.arm.com>
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
 <ZPBVB_z3FTl2nBy0@FVFF77S0Q05N>
 <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 08:31:37AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Aug 31, 2023 at 1:53 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 12:11:22PM -0700, Douglas Anderson wrote:
> > > As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> > > handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> > > and use handle_percpu_devid_irq() by default. Unfortunately,
> > > handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> > > context those should use handle_percpu_devid_fasteoi_nmi().
> > >
> > > In order to accomplish this, we just have to make room for SGIs in the
> > > array of refcounts that keeps track of which interrupts are set as
> > > NMI. We also rename the array and create a new indexing scheme that
> > > accounts for SGIs.
> > >
> > > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > > as IRQs/NMIs happen as part of this routine.
> > >
> > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I'll note that this change is a little more black magic to me than
> > > others in this series. I don't have a massive amounts of familiarity
> > > with all the moving parts of gic-v3, so I mostly just followed Mark
> > > Rutland's advice [1]. Please pay extra attention to make sure I didn't
> > > do anything too terrible.
> > >
> > > Mark's advice wasn't a full patch and I ended up doing a bit of work
> > > to translate it to reality, so I did not add him as "Co-developed-by"
> > > here. Mark: if you would like this tag then please provide it and your
> > > Signed-off-by. I certainly won't object.
> >
> > That's all reasonable, and I'm perfectly happy without a tag.
> >
> > I have one trivial nit below, but with or without that fixed up:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> > >
> > > [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com
> > >
> > > Changes in v12:
> > > - Added a comment about why we account for 16 SGIs when Linux uses 8.
> > >
> > > Changes in v10:
> > > - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
> > >
> > >  drivers/irqchip/irq-gic-v3.c | 59 +++++++++++++++++++++++++-----------
> > >  1 file changed, 41 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > > index eedfa8e9f077..8d20122ba0a8 100644
> > > --- a/drivers/irqchip/irq-gic-v3.c
> > > +++ b/drivers/irqchip/irq-gic-v3.c
> > > @@ -78,6 +78,13 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
> > >  #define GIC_LINE_NR  min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
> > >  #define GIC_ESPI_NR  GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
> > >
> > > +/*
> > > + * There are 16 SGIs, though we only actually use 8 in Linux. The other 8 SGIs
> > > + * are potentially stolen by the secure side. Some code, especially code dealing
> > > + * with hwirq IDs, is simplified by accounting for all 16.
> > > + */
> > > +#define SGI_NR               16
> > > +
> > >  /*
> > >   * The behaviours of RPR and PMR registers differ depending on the value of
> > >   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
> > > @@ -125,8 +132,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
> > >               __priority;                                             \
> > >       })
> > >
> > > -/* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
> > > -static refcount_t *ppi_nmi_refs;
> > > +/* rdist_nmi_refs[n] == number of cpus having the rdist interrupt n set as NMI */
> > > +static refcount_t *rdist_nmi_refs;
> > >
> > >  static struct gic_kvm_info gic_v3_kvm_info __initdata;
> > >  static DEFINE_PER_CPU(bool, has_rss);
> > > @@ -519,9 +526,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
> > >       }
> > >  }
> > >
> > > -static u32 gic_get_ppi_index(struct irq_data *d)
> > > +static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
> > > +{
> > > +     switch (__get_intid_range(hwirq)) {
> > > +     case SGI_RANGE:
> > > +     case PPI_RANGE:
> > > +             return hwirq;
> > > +     case EPPI_RANGE:
> > > +             return hwirq - EPPI_BASE_INTID + 32;
> > > +     default:
> > > +             unreachable();
> > > +     }
> > > +}
> > > +
> > > +static u32 gic_get_rdist_idx(struct irq_data *d)
> > >  {
> > > -     return __gic_get_ppi_index(d->hwirq);
> > > +     return __gic_get_rdist_idx(d->hwirq);
> > >  }
> >
> > Nit: It would be nicer to call this gic_get_rdist_index() to match
> > gic_get_ppi_index(); likewise with __gic_get_rdist_index().
> >
> > That's my fault given I suggested the gic_get_rdist_idx() name in:
> >
> >   https://lore.kernel.org/linux-arm-kernel/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com/
> >
> > ... so sorry about that!
> 
> Yeah, I kept the name you suggested even though it seemed a little
> inconsistent. I'll happily send a v13 with that fixed up, though I'll
> probably wait a little bit just to avoid spamming new versions too
> quickly. It's not like the patches can land in the middle of the merge
> window anyway.
> 
> Unless someone says otherwise, I guess this series is in good shape to
> land then. 

I think so, yes.

> Does anyone have any plans for the details of how to land it? I guess this
> would be something that Marc, Catalin and Will would need to hash out since
> the first patch would ideally go through a different tree than the others.

I suspect that as long as the GIC patch doesn't conflict with anything in the
irqchip tree (and assuming Marc's happy with it), we could route this all
through the arm64 tree as that's what we did when we added support for
pseudo-NMI in the first place.

Marc, thoughts?

Mark.
