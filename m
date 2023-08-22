Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07C783A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjHVGf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjHVGf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:35:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A693FBC;
        Mon, 21 Aug 2023 23:35:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE0F12F4;
        Mon, 21 Aug 2023 23:36:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2D23F740;
        Mon, 21 Aug 2023 23:35:48 -0700 (PDT)
Date:   Tue, 22 Aug 2023 07:35:41 +0100
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/7] arm64: ipi_debug: Add support for backtrace using
 the debug IPI
Message-ID: <ZORXPXbi3f8tUY-N@FVFF77S0Q05N>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
 <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
 <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:06:50PM -0700, Doug Anderson wrote:
> On Mon, Aug 7, 2023 at 3:23 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jun 01, 2023 at 02:31:49PM -0700, Douglas Anderson wrote:
> > > From: Sumit Garg <sumit.garg@linaro.org>

> > >  static irqreturn_t ipi_debug_handler(int irq, void *data)
> > >  {
> > > -     /* nop, NMI handlers for special features can be added here. */
> > > +     irqreturn_t ret = IRQ_NONE;
> > > +
> > > +     /*
> > > +      * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're calling
> > > +      * a function with "nmi_" in the name but it works fine even if we
> > > +      * are using a regulaor IPI.
> > > +      */
> > > +     if (nmi_cpu_backtrace(get_irq_regs()))
> > > +             ret = IRQ_HANDLED;
> > >
> >
> > Does this need the printk_deferred_{enter,exit}() that 32-bit arm has?
> 
> I don't _think_ so, but I also don't _think_ it's needed for arm32.
> ;-) Let me explain my logic and you can tell me if it sounds right to
> you.
> 
> If we're doing the backtrace in pseudo-NMI context then we definitely
> don't need it. Specifically, the printk_deferred_{enter,exit}() just
> manages the per-cpu "printk_context" value. That value doesn't matter
> if "in_nmi()" returns true.
> 
> If we're _not_ doing the backtrace in pseudo-NMI context then I think
> we also don't need it. After all, if we're not in pseudo-NMI context
> then it's perfectly fine to print, right?
> 
> While it's hard to know 100% for sure, my best guess is that in arm
> this might have helped prevent stack traces from getting interspersed
> among one another. I guess this is no longer needed as of commit
> 55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and
> regs")? In any case, when I tested this earlier things seemed to
> printout fine without it...

Thanks for that explanation; that makes sense to me! Looking around a bit I see
that x86 doesn't bother either.

> That being said, it wouldn't hurt to include it here and I'll do it if you
> want.

No need -- I'm happy without it.

Thanks,
Mark.
