Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33E771E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjHGKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjHGKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:41:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CAC61701;
        Mon,  7 Aug 2023 03:41:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E681FB;
        Mon,  7 Aug 2023 03:42:14 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875743F59C;
        Mon,  7 Aug 2023 03:41:27 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:41:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try
 to use NMI for it
Message-ID: <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Apologies for the delay.

On Mon, Jul 24, 2023 at 08:55:44AM -0700, Doug Anderson wrote:
> On Thu, Jun 1, 2023 at 2:37 PM Douglas Anderson <dianders@chromium.org> wrote:
> I'm looking for some ideas on what to do to move this patch series
> forward. Thanks to Daniel, the kgdb patch is now in Linus's tree which
> hopefully makes this simpler to land. I guess there is still the
> irqchip dependency that will need to be sorted out, though...
> 
> Even if folks aren't in agreement about whether this is ready to be
> enabled in production, I don't think anything here is super
> objectionable or controversial, is it? Can we land it? If you feel
> like it needs extra review, would it help if I tried to drum up some
> extra people to provide review feedback?

Ignoring the soundness issues I mentioned before (which I'm slowly chipping
away at, and you're likely lucky enough to avoid in practice)...

Having looked over the series, I think the GICv3 bit isn't quite right, but is
easy enough to fix. I've commented on the patch with what I think we should
have there.

The only major thing otherwise from my PoV is the structure of the debug IPI
framework. I'm not keen on that being a separate body of code and I think it
should live in smp.c along with the other IPIs. I'd also strongly prefer if we
could have separate IPI_CPU_BACKTRACE and IPI_CPU_KGDB IPIs, and I think we can
do that either by unifying IPI_CPU_STOP && IPI_CPU_CRASH_STOP or by reclaiming
IPI_WAKEUP by reusing a different IPI for the parking protocol (e.g.
IPI_RESCHEDULE).

I think it'd be nice if the series could enable NMIs for backtrace and the
CPU_{,CRASH_}STOP cases, with KGDB being the bonus atop. That way it'd be
clearly beneficial for anyone trying to debug lockups even if they're not a
KGDB user.

> Also: in case it's interesting to anyone, I've been doing benchmarks
> on sc7180-trogdor devices in preparation for enabling this. On that
> platform, I did manage to see about 4% reduction in a set of hackbench
> numbers when fully enabling pseudo-NMI. However, when I instead ran
> Speedometer 2.1 I saw no difference. See:
> 
> https://issuetracker.google.com/issues/197061987

Thanks for the pointer!

I know that there are a couple of things that we could do to slightly improve
local_irq_*() when using pNMIs, though I suspect that the bulk of the cost
there will come from the necessary synchronization.

Thanks,
Mark.
