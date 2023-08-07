Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E07725E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjHGNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjHGNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:35:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F5618C;
        Mon,  7 Aug 2023 06:35:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F3781FB;
        Mon,  7 Aug 2023 06:26:03 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777963F64C;
        Mon,  7 Aug 2023 06:25:17 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:25:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/7] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Message-ID: <ZNDwtMJmhk9pP3Nq@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
 <ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com>
 <CAFA6WYN7SH83mnTPqBj9=hCakM=KJkor7fMQasdeBe6Ue5JXRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYN7SH83mnTPqBj9=hCakM=KJkor7fMQasdeBe6Ue5JXRg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:52:40PM +0530, Sumit Garg wrote:
> On Mon, 7 Aug 2023 at 15:20, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jun 01, 2023 at 02:31:45PM -0700, Douglas Anderson wrote:
> > > @@ -542,16 +543,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
> > >               return -EINVAL;
> > >
> > >       /* desc lock should already be held */
> > > -     if (gic_irq_in_rdist(d)) {
> > > -             u32 idx = gic_get_ppi_index(d);
> > > +     switch (get_intid_range(d)) {
> > > +     case SGI_RANGE:
> > > +             break;
> > > +     case PPI_RANGE:
> > > +     case EPPI_RANGE:
> > > +             idx = gic_get_ppi_index(d);
> > >
> > >               /* Setting up PPI as NMI, only switch handler for first NMI */
> > >               if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
> > >                       refcount_set(&ppi_nmi_refs[idx], 1);
> > >                       desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
> > >               }
> > > -     } else {
> > > +             break;
> > > +     default:
> > >               desc->handle_irq = handle_fasteoi_nmi;
> > > +             break;
> > >       }
> >
> > As above, I reckon this isn't right, and we should treat all rdist interrupts
> > (which are all percpu) the same.
> >
> > I reckon what we should be doing here is make ppi_nmi_refs cover all of the
> > rdist interrupts (e.g. make that rdist_nmi_refs, add a gic_get_rdist_idx()
> > helper), and then here have something like:
> >
> >         if (gic_irq_in_rdist(d)) {
> >                 u32 idx = gic_get_rdist_idx(d);
> >
> >                 /*
> >                  * Setting up a percpu interrupt as NMI, only switch handler
> >                  * for first NMI
> >                  */
> >                 if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
> >                         refcount_set(&ppi_nmi_refs[idx], 1);
> >                         desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
> >                 }
> >         }
> 
> It looks like you missed the else part here as follows for all other
> interrupt types:
> 
>          } else {
>                  desc->handle_irq = handle_fasteoi_nmi;
>          }

Yes, sorry; I had meant for that to be included, i.e.

	if (gic_irq_in_rdist(d)) {
		u32 idx = gic_get_rdist_idx(d);

		/*
		 * Setting up a percpu interrupt as NMI, only switch handler
		 * for first NMI
		 */
		if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
			refcount_set(&ppi_nmi_refs[idx], 1);
			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
		}
	} else {
		desc->handle_irq = handle_fasteoi_nmi;
	}

> Apart from that, your logic sounds good to me.

Great!

Thanks,
Mark.
