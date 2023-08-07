Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6C8771EEC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjHGKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjHGKye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:54:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EDBA171A;
        Mon,  7 Aug 2023 03:54:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 166FC1FB;
        Mon,  7 Aug 2023 03:55:16 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1753F59C;
        Mon,  7 Aug 2023 03:54:30 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:54:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Message-ID: <ZNDNY_JfUxXm2vR5@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
 <a030019c7c5887d54b97054ed7d9af12@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a030019c7c5887d54b97054ed7d9af12@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:47:04AM +0100, Marc Zyngier wrote:
> On 2023-08-07 11:28, Mark Rutland wrote:
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
> > > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by
> > > NMI.
> > > 
> > >  arch/arm64/kernel/ipi_debug.c |  5 +++++
> > >  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > 
> > This looks fine to me, but I'd feel a bit happier if we had separate
> > SGIs for
> > the backtrace and the KGDB callback as they're logically unrelated.
> 
> Well, we're a bit stuck here.
> 
> We have exactly *one* spare SGI with GICv3, as we lose 8 of them
> to the secure side. One possibility would be to mux some of the
> lesser used IPIs onto two SGIs (one with standard priority, and
> one with NMI priority).

Understood; Doug and I suggested two options for that:

1) Unify/mux the IPI_CPU_STOP and IPI_CPU_CRASH_STOP IPIs

   The only *intended* difference between the two is that IPI_CPU_CRASH_STOP
   calls crash_save_cpu() before trying to stop the CPU, but the
   implementations have diverged significantly for unrelated reasons.

2) Remove IPI_WAKEUP

   We only use IPI_WAKEUP for the ACPI parking protocol, and we could reuse
   another IPI (e.g. IPI_RESCHEDULE) to achieve the same thing witout a
   dedicated IPI.

Thanks,
Mark.
