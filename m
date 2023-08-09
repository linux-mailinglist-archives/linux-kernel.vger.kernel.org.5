Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF407764F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHIQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHIQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:24:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3C10F3;
        Wed,  9 Aug 2023 09:24:48 -0700 (PDT)
Date:   Wed, 9 Aug 2023 18:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691598286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JK89Mbjr0pt8D3aWna/X6ZHv5XeeBZsaLs0qOYl8Vhg=;
        b=uk42bsDspVqagb9e7Yb4qq7Eq/hobN98qDM5u0mlepqEWExSMktDUIfYJwhU6qz3AJgYLS
        UuFS6nrK7SPqxlKSnnkmgUpK+zgwQJ4HnyCxuII+1wUXKQmTnyLjvsa1gTBl6H70TXTsRS
        bYeH6q/Z2n4w5sHvWPQgmB5I76fU90hurfd1X5O7lHs10lTHBSdw+kuWZ2g7o+yBgtLVB9
        PuqxqMY6PymiWKfiVdpuwqVwyDaJBkTVWsr1axaRoPOZALlMkHj/F6wVdeWpmfhOkj8vc+
        B5Ps5LUL2NionKq+bWyb6Yykx9hV/EdJmGXYl0RMjUea5db1Hv3xBlb8pF22XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691598286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JK89Mbjr0pt8D3aWna/X6ZHv5XeeBZsaLs0qOYl8Vhg=;
        b=gFM5RAFADaCjfttF+Xusb0j8Jyb+h6hZ8w5PEJyDVvFPmXHkq5KgfsqFqO570qovV3Wq0O
        FrJmUXTtZR/W3uDg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Doug Smythies <dsmythies@telus.net>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers unconditionally
 every time
In-Reply-To: <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com>
Message-ID: <4872c41b-c8fd-1f84-7940-d4944c667e6f@linutronix.de>
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com> <002201d9ca0c$27606f70$76214e50$@telus.net> <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
 <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-532690441-1691597088=:19513"
Content-ID: <3492f271-133b-e3d8-56ac-d575304eb54@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-532690441-1691597088=:19513
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <e216b60-716f-b295-78d2-5640e1d41316@linutronix.de>

Hi,

On Tue, 8 Aug 2023, Doug Smythies wrote:
> On Tue, Aug 8, 2023 at 9:43 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Aug 8, 2023 at 5:22 PM Doug Smythies <dsmythies@telus.net> wrote:

[...]

> > > Conclusions: Overall, I am not seeing a compelling reason to
> > > proceed with this patch set.
> >
> > On the other hand, if there is a separate compelling reason to do
> > that, it doesn't appear to lead to a major regression.
> 
> Agreed.
> 

Regarding the compelling reason:

On a fully loaded machine with 256 CPUs tick_nohz_next_event() is executed
~48000 times per second. With this patchset it is reduced to ~120 times per
second. The factor for the difference is 400. This is already an
improvement.

tick_nohz_next_event() marks timer bases idle, whenever possible - even if
the tick is not stopped afterwards. When a timer is enqueued remote into an
idle timer base an IPI is sent. Calling tick_nohz_next_event() only when
the system is not that busy, prevents those unnecessary IPIs.

Beside of those facts, I'm working on the timer pull model [0]. With this,
non pinned timers can also be expired by other CPUs and do not prevent CPUs
from going idle. Those timers will be enqueued on the local CPU without any
heuristics. This helps to improve behavior when a system is idle (regarding
power). But the call of tick_nohz_next_event() will be more expensive which
led to a regression during testing. This regression is gone with the new
teo implementation - it seems that there is also an improvement under
load. I do not have finalized numbers, as it is still WIP (I came across
some other possible optimizations during analyzing the regression, which
I'm evaluating at the moment).

Thanks,

        Anna-Maria


[0] https://lore.kernel.org/lkml/20230524070629.6377-1-anna-maria@linutronix.de/

--8323329-532690441-1691597088=:19513--
