Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663747B27AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjI1Vom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1Vol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:44:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7ED19D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:44:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695937476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGjepNcDQZMCY4f7saBj8ug9eG8q1NjucB0xcANdtdw=;
        b=UjCkVUuksRe89PS9UoXkC/hMfxp9JIrk3Amcnpzo7p5m/iS7rYEvxIrkm4DZpT5Qydq8In
        WsVAGdIJaYRcfi+q4CfDY8m4pB1v5aOFqo1ijSRsgLKA5/fUNGwofDjmLq3PoGAvnE1UlD
        G2wn+XSM5ReWhnoJ6+EphV8W4NmLp15rVXZIARFPGgO/Vs+Du9mcGN98nZ12b8pwkrKIbo
        r9Jhgu8f+5BCel1CLsB5iGVkye1n8+4qJXLNNarSYr0x7UmLMRaJV4OY8tZ3Lhx1xNQ8aB
        CiIoJxs/Axjftwjdx84ZAiDGjBl1BjXPF0nQmDdCK38/MNEmXwDTOv81kTlcUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695937476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGjepNcDQZMCY4f7saBj8ug9eG8q1NjucB0xcANdtdw=;
        b=2tiGWDP7CZydnFljXaVJKM7NWTHA4dAvaTN9YMJPLvcidp+8543NeoT6l9h5oTQXpd/M75
        u2PD/bZ//ZHBgDAg==
To:     =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Subject: Re: Loosening time namespace restrictions
In-Reply-To: <CAAi7L5c+7UoCOmKHAY4E1w_pwDS=qVOGsO+tfx6e3Zu+kyxHig@mail.gmail.com>
References: <CAAi7L5c+7UoCOmKHAY4E1w_pwDS=qVOGsO+tfx6e3Zu+kyxHig@mail.gmail.com>
Date:   Thu, 28 Sep 2023 23:44:35 +0200
Message-ID: <87lecqdlbw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21 2023 at 18:39, Micha=C5=82 C=C5=82api=C5=84ski wrote:
> I faced a problem with the current implementation of time ns while
> using it for container migration. I'd like users of CLOCK_MONOTONIC to
> notice as small of a jump as possible in the clock after migration,
> since according to the documentation "this clock does not count time
> that the system is suspended". In that case the formula for clock
> monotonic offset is "m1_monotonic - m2_monotonic - migration_downtime"
> where m<n>_monotonic is clock monotonic value on the n-th machine.
> Unfortunately due to time ns restrictions, I have to set the offsets
> before putting any process in the namespace. I also can't move
> multithreaded processes between namespaces. So I would have to know
> the migration downtime before the migration is close to done, which
> seems impossible. For that reason I'd like to drop the requirement of
> having to set the offsets before putting any processes in the
> namespace. What do you think? Is it possible to implement this and get
> it merged or should I forgo it? If you think it's possible, I'd
> appreciate any pointers on how to get this done (or how to solve my
> problem in another way).

Lots of word salad. Seems your newline key has an issue. Let me split
that up for you.

> I faced a problem with the current implementation of time ns while
> using it for container migration.
>
> I'd like users of CLOCK_MONOTONIC to notice as small of a jump as
> possible in the clock after migration, since according to the
> documentation "this clock does not count time that the system is
> suspended".

"I'd like" is not a technical term and the documentation reference
to what clock MONOTONIC represents does not help either.

> In that case the formula for clock monotonic offset is "m1_monotonic -
> m2_monotonic - migration_downtime" where m<n>_monotonic is clock
> monotonic value on the n-th machine.

I which case?=20

> Unfortunately due to time ns restrictions, I have to set the offsets
> before putting any process in the namespace.

That's obvious because how would you guarantee that the process cannot
observe the wrong time or does not expire timers early?

> I also can't move multithreaded processes between namespaces.

I have no idea what you are trying to tell me here.

  1) What has this to do with multi-threading?

     Are you suggesting that having thread A of a process to be in a
     different time domain than thread B of a process is something
     useful?

     Seriously this does not make any sense at all and if you think
     that's something useful then you completely failed to explain the
     use case.
=20
  2) How does moving a process from a time namespace A to a time
     namespace B make sense at all?

     That's simply impossible unless time namespace A and time namespace
     B are identical. Otherwise you screw up time readouts and armed
     timers in one go. If they are identical then there is no point to
     move it, right?

     Aside of that you fail again to describe which problem you are
     trying to solve.

> So I would have to know the migration downtime before the migration is
> close to done, which seems impossible. For that reason I'd like to
> drop the requirement of having to set the offsets before putting any
> processes in the namespace.

How do you guarantee that the process cannot observe time going
backwards and timers firing early when you set the offset after you
restored the process into the time name space and resumed it?

The answer is: Not at all.=20

> What do you think? Is it possible to implement this and get it merged
> or should I forgo it? If you think it's possible, I'd appreciate any
> pointers on how to get this done (or how to solve my problem in
> another way).

I still have not figured out which problem you are trying to solve, so
giving advice would involve crystal balls. I misplaced mine and even if
I could find it again I'd refuse to use it for giving techical advice.

Thanks,

        tglx
