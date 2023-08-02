Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902176C81C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHBIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjHBIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399951702;
        Wed,  2 Aug 2023 01:12:24 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:12:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690963941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+LOkiy0bdFsN7LZd7vhWhs6DTXJ4Uak5jbvEroTI/w=;
        b=w5JqT0y/m8SHDfmhnYeiqKbXMYTZ0e56iujusf9pIycUoRgcbEEq8qMs891dQgqcpzwbUx
        1vTpV9eVOr1hyXAXqcFa+C3npUXlK92sOswVkiYx+Zt+yNpJV60gO+L9BjUVujRkBNf0vS
        ktSOgqs/BTp7ZHdBuT0JFYC2ZNd98WtXw3jEuP4/GZ7cNqcJuGX1rYSODq/YnPC7kD50yV
        BA4K+I31w4T590mTvwQ9I7rMnIPlvLKZbYAAhorm0epIxJF+5i6CMZ2Enn7NQ+zIRZE+lA
        gWlBzzYFa+DTMv5ql/D5D8IRqoqF8SraIIrX6EYTt/PV13p3ywgdYvu05JHCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690963941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+LOkiy0bdFsN7LZd7vhWhs6DTXJ4Uak5jbvEroTI/w=;
        b=pPax1xHu+fiA5lMI44X6HTTNU/T/5nFn2oxiTq04EhzGTgB26Do453wqCERba6GtRVJEag
        +Uc2B8fzoCAaNjBA==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 0/3] cpuidle,teo: Improve TEO tick decisions
In-Reply-To: <CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com>
Message-ID: <11e17c44-7c4c-88de-546e-263c5a6aad2@linutronix.de>
References: <20230728145515.990749537@infradead.org> <8b6b73a7-aff4-21e-5c55-294fcf67934e@linutronix.de> <CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1619686854-1690963941=:2229"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1619686854-1690963941=:2229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 31 Jul 2023, Rafael J. Wysocki wrote:

> On Mon, Jul 31, 2023 at 1:47 PM Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
> >
> > Hi,
> >
> > On Fri, 28 Jul 2023, Peter Zijlstra wrote:
> >
> > > Hi,
> > >
> > > Wanted to send this yesterday, but my home server died and took everything
> > > down :/
> > >
> > > These patches are lightly tested but appear to behave as expected.
> > >
> > >
> >
> > As I was asked to see if the patches of Raphael improve the behavior, I
> > rerun the tests with Raphaels v2 as well as with Peters RFC patchset. Here
> > are the results (compared to upstream):
> 
> Thanks for the numbers!
> 
> >                         upstream                raphael v2              peter RFC
> >
> > Idle Total              2533    100.00%         1183    100.00%         5563    100.00%
> > x >= 4ms                1458    57.56%          1151    97.30%          3385    60.85%
> > 4ms> x >= 2ms           91      3.59%           12      1.01%           133     2.39%
> > 2ms > x >= 1ms          56      2.21%           3       0.25%           80      1.44%
> > 1ms > x >= 500us        64      2.53%           1       0.08%           98      1.76%
> > 500us > x >= 250us      73      2.88%           0       0.00%           113     2.03%
> > 250us > x >=100us       76      3.00%           2       0.17%           106     1.91%
> > 100us > x >= 50us       33      1.30%           4       0.34%           75      1.35%
> > 50us > x >= 25us        39      1.54%           4       0.34%           152     2.73%
> > 25us > x >= 10us        199     7.86%           4       0.34%           404     7.26%
> > 10us > x > 5us          156     6.16%           0       0.00%           477     8.57%
> > 5us > x                 288     11.37%          2       0.17%           540     9.71%
> >
> > tick_nohz_next_event()
> > count                   8839790                 6142079                 36623
> >
> > Raphaels Approach still does the tick_nohz_get_sleep_length() execution
> > unconditional. It executes ~5000 times more tick_nohz_next_event() as the
> > tick is stopped. This relation improved massively in Peters approach
> > (factor is ~7).
> 
> So I'm drawing slightly different conclusions from the above.
> 
> First, because there are different numbers of idle cycles in each
> case, I think it only makes sense to look at the percentages.
> 
> So in both the "upstream" and "Peter RFC" cases there is a significant
> percentage of times when the tick was stopped and the measure idle
> duration was below 25 us (25.39% and 25.54%, respectively), whereas in
> the "Rafael v2" case that is only 0.51% of times (not even 1%).  This
> means a huge improvement to me, because all of these cases mean that
> the governor incorrectly told the idle loop to stop the tick (it must
> have selected a shallow state and so it should have not stopped the
> tick in those cases).  To me, this clearly means fixing a real bug in
> the governor.
> 
> Now, I said in the changelog of my v1 that the goal was not to reduce
> the number of tick_nohz_get_sleep_length() invocations, so I'm not
> sure why it is regarded as a comparison criteria.
> 

I just mentioned this relation as the percentage values are obvious. I
know, your approach does not adress the tick_nohz_get_sleep_length
invocations, but it might be worth a try - I saw your new patchset
adressing it and will have a deeper look at it today/tomorrow. Thanks!

I also try to play around with the timer logics (moving marking timer base
idle into tick_nohz_stop_tick), but the results does not look pretty good
at the moment.
--8323329-1619686854-1690963941=:2229--
