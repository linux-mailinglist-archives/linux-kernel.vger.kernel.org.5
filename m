Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15E772A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjHGQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHGQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:04:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFCAA10C4;
        Mon,  7 Aug 2023 09:04:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2191FB;
        Mon,  7 Aug 2023 09:05:03 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1FF83F59C;
        Mon,  7 Aug 2023 09:04:17 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:04:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
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
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Message-ID: <ZNEV_mz4VU1HyBc9@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
 <20230807152444.GA375529@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807152444.GA375529@aspen.lan>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 04:24:44PM +0100, Daniel Thompson wrote:
> On Mon, Aug 07, 2023 at 11:28:52AM +0100, Mark Rutland wrote:
> > On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
> > > IPI is backed by an NMI (or pseudo NMI) then this will let us debug
> > > even hard locked CPUs. When the debug IPI isn't backed by an NMI then
> > > this won't really have any huge benefit but it will still work.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > > Changes in v9:
> > > - Remove fallback for when debug IPI isn't available.
> > > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> > >
> > >  arch/arm64/kernel/ipi_debug.c |  5 +++++
> > >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
> > >  2 files changed, 19 insertions(+)
> >
> > This looks fine to me, but I'd feel a bit happier if we had separate SGIs for
> > the backtrace and the KGDB callback as they're logically unrelated.
> 
> I've no objections to seperate SGIs (if one can be found) but I'm curious
> what benefit emerges from giving them seperate IPIs.

Mostly an "I'd feel happier"; they're logically unrelated and having them
separate avoids the risk of them unintentionally getting in the way of the
other.

> Both interfaces are already designed to share and NMI-like IPI nicely
> (and IIUC they must share one on x86), neither is performance
> critical[1] and the content of /proc/interrupts for the IPI is seldom
> going to be of much interest.

Sure; I understand that. The flip side of "neither is performance critical" is
that they're seldom tested in terms of interaction with one another, and hence
for robustness I'd prefer they're separate.

I agree it's not strictly necessary, but given we can easily free up an SGI
slot, I think it'd be worthwhile. We can always decide to fold them together in
future if we have to.

I realise a similar argument could be applied to IPI_WAKEUP and IPI_RESCHEDULE,
but given that IPI_RESCHEDULE happens *all the time* and the wakeup handler
does literally nothing, I think the risk there is substantially lower.

Thanks,
Mark.

> As mentioned it is perfectly OK to separate them if there is space in
> the SGI allocations. However if any two functions are good candidates to
> share a scarce resource such as an SGI then it is these!
> 
> 
> Daniel.
> 
> 
> [1] In both cases their results are only required at human-scale
>     and the work of the both handlers is hugely more expensive than
>     either up front quick-check.
