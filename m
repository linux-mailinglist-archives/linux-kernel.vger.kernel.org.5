Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DCF7BB777
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjJFMTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJFMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:19:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22AC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:19:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5F4C433C9;
        Fri,  6 Oct 2023 12:19:27 +0000 (UTC)
Date:   Fri, 6 Oct 2023 13:19:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek
 FW
Message-ID: <ZR/7TW1at0ltc4P4@arm.com>
References: <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
 <ZRwJKBZaYwF1rrur@FVFF77S0Q05N>
 <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
 <ZRxCCZxZWCG0NBur@FVFF77S0Q05N>
 <CAD=FV=Xk-OMKQPXxU9Z9HOcWwUxxrmLZ4vD0u5ouZRW_zDFDPg@mail.gmail.com>
 <ZR03liCodnTQWs7s@FVFF77S0Q05N>
 <86jzs2ofqs.wl-maz@kernel.org>
 <CAD=FV=XasZR6dhKBjpbYfby4F1Nu_bsq1m_HP+NpufjsJi0COg@mail.gmail.com>
 <ZR6Pjk_3gpx1K3pF@FVFF77S0Q05N>
 <CAD=FV=VbxM-hftVKsp2JhQpnQm9u_H86rQbnucS5-x-q8j0QQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VbxM-hftVKsp2JhQpnQm9u_H86rQbnucS5-x-q8j0QQA@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 08:34:56AM -0700, Doug Anderson wrote:
> On Thu, Oct 5, 2023 at 3:27 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Oct 04, 2023 at 07:04:12AM -0700, Doug Anderson wrote:
> > > On Wed, Oct 4, 2023 at 3:15 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > On Wed, 04 Oct 2023 10:59:50 +0100,
> > > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > Given you haven't seen any issues, I suspect those are getting reset to fixed
> > > > > values that happens to work out for us, but it is a bit worrisome more
> > > > > generally (e.g. the LPI case above).
> > > >
> > > > It is likely that these SoCs don't even have an ITS.
> > >
> > > Right. That was what we decided [1] when Marc pointed this out earlier.
> > >
> > > Overall: we know that this firmware behavior is not good but we're
> > > stuck with it. :( At the very least, any new devices coming out will
> > > have this fixed. Presumably if old devices are working OK enough today
> > > (as long as you don't enable pseudo-NMI) then they can be made to keep
> > > working?
> > >
> > > So circling back: what patch should we actually land?
> >
> > For now I'd prefer we took the patch I sent in:
> >
> >   https://lore.kernel.org/linux-arm-kernel/ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com/
> >
> > ... as that leaves us no worse than before this series, and it's pretty simple.
> 
> Sounds good to me!
> 
> Catalin / Will: Please yell if there's anything you need me to do.
> Otherwise I'll assume you'll pick up Mark's patch instead of my patch
> #1 and then you'll pick up my patch #2.

I applied both to the arm64 for-next/backtrace-ipi branch. Thanks.

-- 
Catalin
