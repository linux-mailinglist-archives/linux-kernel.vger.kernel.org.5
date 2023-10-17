Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A597CBBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJQGty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjJQGtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:49:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE51DEA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:49:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697525387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FE1gLbMogP0SwbL+MBx94k/MbhBH/aKzYuo6+Povrw=;
        b=boGkJasYeL3vD1USUD2ST/X8aISjFqsQ2P6gmV+YCXjR6n37kHLuwumy/X1lFlmQ8Px3S7
        DOjYfUOpFBWKWmY7DTtfL9mRuLEghMQWBOXXy3rpTy1b5ePglNN9ZRm3Sdj8osXGamLZ9E
        lH3F82iyKkIoLenCnjAMdDb5zWF+UTscm8y4ZWMyOFfPHVhaaEJ/0J6GoM1/zr/Usuffuk
        KchVdlzOK4PgAUt/Sc65IMzCQgEhZuFD7bfRxD+1DAdxSlT9CISmifZDH2QCHCW9+NlJrk
        WXF3uLsajYYPchcxuooqWLlgw5KXvgKkbcV289kFlZfchCfaOHTsstYu3d1AJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697525387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/FE1gLbMogP0SwbL+MBx94k/MbhBH/aKzYuo6+Povrw=;
        b=V+n9yJBoAbeGvpkx2NrV+eMTB5AtBHodwhqZF4scXV1QNZgoECqA04G36MK4/RNbXNyDxv
        KlaH48+l6gYuQEBg==
To:     paulmck@kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
In-Reply-To: <ae4e5836-bc42-42fa-bd41-2a2fd483acb5@paulmck-laptop>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <ae4e5836-bc42-42fa-bd41-2a2fd483acb5@paulmck-laptop>
Date:   Tue, 17 Oct 2023 08:49:46 +0200
Message-ID: <8734y97ng5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16 2023 at 16:03, Paul E. McKenney wrote:
> On Mon, Oct 16, 2023 at 11:47:55PM +0200, Thomas Gleixner wrote:
>> That said, this whole clocksource watchdog mess wants a proper
>> overhaul. It has become a pile of warts and duct tape by now and after
>> staring at it long enough there is no real reason to run it in a timer
>> callback anymore. It just can move into delayed work and the whole
>> locking problem can be reduced to the clocksource_mutex and some well
>> thought out atomic operations to handle the mark unstable case. But
>> that's a different story and not relevant for curing the problem at
>> hand.
>
> Moving the code to delayed work seems quite reasonable.
>
> But Thomas, you do understand that the way things have been going for
> the clocksource watchdog, pushing it out to delayed work will no doubt
> add yet more hair on large busy systems, right?  Yeah, yeah, I know,
> delayed work shouldn't be any worse than ksoftirqd.  The key word of
> course being "shouldn't".  ;-)

Yes, I'm aware of that. I still think it's worth at least to try it.

Thanks,

        tglx
