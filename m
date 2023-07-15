Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99582754A99
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 20:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGOSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 14:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 14:19:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD726AF
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 11:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F9860B86
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 18:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43084C433C8;
        Sat, 15 Jul 2023 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689445140;
        bh=y4xCwqqsWYpomCA81KuGvnRmLLhlaq1VED7TNDAo9AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAl3TKLzKs/6Ytp+Md1HFeWLgvML80NyWqMg6v1CVo2q2T8Nw+65pzTkZWKKrt7PV
         X043Hv31Qdj8AIz/yGiK2P0H1oU1O2i5Uz7UIvSmBMPy9NskC2zyowXgwx9UXGvIUL
         WNEw78BSDA6W7ZdxntiikPELKHQsaRAzphE67lpNjLsETWVa/vBA7tMb0f9mEE7WuG
         SDeZzq9sxXzN2mj9mcnRf1PZdMe0FhuQFI5IzSh2RmR+cl7NSjvPux5SvhuchRnGNA
         pnyB2weKuLjjTrCdS6nYExv0k2ATdGSsFi37wDGcKVuhVuyKwd3b12PPumyhivSwjw
         OzHUmjhtlTthw==
Date:   Sat, 15 Jul 2023 20:18:57 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Message-ID: <ZLLjEVxM+kf84vgI@lothringen>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-4-frederic@kernel.org>
 <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
 <ZLHh71KIIioR85aa@lothringen>
 <CAEXW_YRTtvq0_YZiN=V9DZi2QxrC4hQFeUC9=JrgAKkg8KAnmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRTtvq0_YZiN=V9DZi2QxrC4hQFeUC9=JrgAKkg8KAnmw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 09:02:43PM -0400, Joel Fernandes wrote:
> On Fri, Jul 14, 2023 at 8:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 02:44:49PM -0400, Joel Fernandes wrote:
> > > On 7/14/23 08:08, Frederic Weisbecker wrote:
> > > One slight concern here though, where in the idle loop is the removed
> > > statement "tick_program_event(KTIME_MAX, 1);" happening if the tick was
> > > already stopped before? If it is happening in tick_nohz_stop_tick(), don't
> > > we early return from there and avoid doing that
> > > "tick_program_event(KTIME_MAX, 1);" altogether, if the tick was already
> > > stopped and the next event has not changed?
> > >
> > >         /* Skip reprogram of event if its not changed */
> > >         if (ts->tick_stopped && (expires == ts->next_tick)) {
> > >                 /* Sanity check: make sure clockevent is actually programmed */
> > >                 if (tick == KTIME_MAX || ts->next_tick ==  [...]
> > >                         return;
> > >               [...]
> > >       }
> >
> > Sure, if tick_program_event(KTIME_MAX, 1) was already called in the
> > previous idle loop iteration, then there is no need to call that again.
> >
> > Or am I missing something else?
> 
> Just take it with a grain of salt but I think you need to still call
> tick_program_event(KTIME_MAX, 1) here for the case where the tick was
> previously stopped, and then when the next tick fires (say after a
> long time T), but that tick is a one-off and does not result in
> restarting the tick -- then there is no one to call
> "tick_program_event(KTIME_MAX, 1)".

I'm a bit confused about that one-off thing. What can trigger that timer
interrupt if it has been stopped?

One thing can happen though: a pending timer IRQ while we are stopping the
tick (IRQs are disabled in that idle loop portion). But then that pending timer
interrupt is not going to reprogram another one. So it remains stopped.

Thanks.
