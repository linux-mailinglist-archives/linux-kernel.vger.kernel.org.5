Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C4756AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGQRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGQRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:31:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B804619A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:31:17 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3461163c0b6so30110595ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689615051; x=1692207051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HADodmuuj5xDdcyZKc8OVGMGhqjz2cXJmOJkpmBShqI=;
        b=P8Q6uVoUsffxkGKlV1C0Mlilp71/gDb3JZPsAdHBm6RPA2Iyzg/5BPwSl7uXR4swZy
         OLTQF4woMNFZPr4yaatDJvnPJXBlonW8xD0CTDoyZ5PJBIR4MUQ995yYszYiyuJkLS8E
         B5G83QrRTGJz+RWJyhe1lDc7HlOUYECWswZZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615051; x=1692207051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HADodmuuj5xDdcyZKc8OVGMGhqjz2cXJmOJkpmBShqI=;
        b=ecL+pbLsG6MoRvuEH+HTzpVFYGinMVRRdL+lVeV+rKtgyvl6foSOZaEHExRwMCMqck
         7+PXn9+1Jq5MzDfow2A7xtVc840z+Rewai3qR/Wfma0OuiuDgqmS4nx12erRPPKO+xu/
         XjiOd/UQp2hNflJ0LbBVpl/FV4t/FGw72uKnpBwH9w1/l5Kk9vxqkp0ihLY1VLwmdGnj
         IR9AhaXf7Tm2o+mJgD+HYiE/osFHrEpCMr8okeGWv0iIqO+VZV6hsDT+py5BqTSacPK6
         UjvZRFjGSGtltimwvSxovt+Voo1rlD+Q4v4T4HBeDuL8SJiGG72ZO4eD3zXIFLnprrV0
         /5LQ==
X-Gm-Message-State: ABy/qLbu8o/AScu1/7CjXW/VtkbXd4HJitR9L/BmoMBOmSoIzjPmN2xA
        G1R7ZjmvVdBLDBaC+SvNJrkjXcvbE5nvPqXp3MU=
X-Google-Smtp-Source: APBJJlHhE63J6eElM98VSLDcSkU/HHfFfdfqTKU/6h2Hmk9zBoHV8FgDuhjD3dVlHD2+xB7/fqqBXg==
X-Received: by 2002:a05:6e02:16c5:b0:346:541c:1010 with SMTP id 5-20020a056e0216c500b00346541c1010mr457058ilx.18.1689615051380;
        Mon, 17 Jul 2023 10:30:51 -0700 (PDT)
Received: from localhost (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id z1-20020a92cec1000000b00342153b1b0csm86239ilq.34.2023.07.17.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:30:50 -0700 (PDT)
Date:   Mon, 17 Jul 2023 17:30:49 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, vineethrp@gmail.com
Subject: Re: [PATCH 3/3] tick/nohz: Don't shutdown the lowres tick from itself
Message-ID: <20230717173049.GA2760149@google.com>
References: <20230714120852.23573-1-frederic@kernel.org>
 <20230714120852.23573-4-frederic@kernel.org>
 <9347e3d4-e774-f75f-22c4-6c2dba294423@joelfernandes.org>
 <ZLHh71KIIioR85aa@lothringen>
 <CAEXW_YRTtvq0_YZiN=V9DZi2QxrC4hQFeUC9=JrgAKkg8KAnmw@mail.gmail.com>
 <ZLLjEVxM+kf84vgI@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLLjEVxM+kf84vgI@lothringen>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 08:18:57PM +0200, Frederic Weisbecker wrote:
> On Fri, Jul 14, 2023 at 09:02:43PM -0400, Joel Fernandes wrote:
> > On Fri, Jul 14, 2023 at 8:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > On Fri, Jul 14, 2023 at 02:44:49PM -0400, Joel Fernandes wrote:
> > > > On 7/14/23 08:08, Frederic Weisbecker wrote:
> > > > One slight concern here though, where in the idle loop is the removed
> > > > statement "tick_program_event(KTIME_MAX, 1);" happening if the tick was
> > > > already stopped before? If it is happening in tick_nohz_stop_tick(), don't
> > > > we early return from there and avoid doing that
> > > > "tick_program_event(KTIME_MAX, 1);" altogether, if the tick was already
> > > > stopped and the next event has not changed?
> > > >
> > > >         /* Skip reprogram of event if its not changed */
> > > >         if (ts->tick_stopped && (expires == ts->next_tick)) {
> > > >                 /* Sanity check: make sure clockevent is actually programmed */
> > > >                 if (tick == KTIME_MAX || ts->next_tick ==  [...]
> > > >                         return;
> > > >               [...]
> > > >       }
> > >
> > > Sure, if tick_program_event(KTIME_MAX, 1) was already called in the
> > > previous idle loop iteration, then there is no need to call that again.
> > >
> > > Or am I missing something else?
> > 
> > Just take it with a grain of salt but I think you need to still call
> > tick_program_event(KTIME_MAX, 1) here for the case where the tick was
> > previously stopped, and then when the next tick fires (say after a
> > long time T), but that tick is a one-off and does not result in
> > restarting the tick -- then there is no one to call
> > "tick_program_event(KTIME_MAX, 1)".
> 
> I'm a bit confused about that one-off thing. What can trigger that timer
> interrupt if it has been stopped?
> 
> One thing can happen though: a pending timer IRQ while we are stopping the
> tick (IRQs are disabled in that idle loop portion). But then that pending timer
> interrupt is not going to reprogram another one. So it remains stopped.

I think I see what you mean now. Maybe I wrongly assumed the above 'Skip
reprogram of event' code could early return and skip over
"tick_program_event(KTIME_MAX, 1);", but I think it cannot because of the
"expires != ts->next_tick" check.

 Maybe the "tick_program_event(KTIME_MAX, 1)" bit in tick_nohz_handler() is
 supposed to handle buggy hardware where an unexpected timer event came
 through? In such a situation, the idle loop will not write
 "tick_program_event(KTIME_MAX, 1);" again because it already did so the
 previous time, as you pointed.

Adding Vineeth who is also looking into this code.

thanks,

 - Joel

