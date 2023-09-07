Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7875797446
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjIGPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344589AbjIGPd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:33:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A031BF5;
        Thu,  7 Sep 2023 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3WFJ/CyRLDbsGvdiQprNjEUyWtZ4FKis4fJnhduuJtU=; b=IEkvclf72qZHteRaWKJ/MXfSY0
        LmiryMpgIAzo25gO9gHYKydzx65Qid+hYSB3Q3oM1zNWyft4SMa6M9HTtyxXP7up3IZUxx/px+8iC
        jabr9E3MRzW5ravGFBh79Xa00aVU5kzxkf3kw6iwnI6PiwRsf66szEznCuIu3m3yLEclq95Zf7mOn
        H85BKiSz80BsllZxErHmCO8UHTJyBe6R97WYjsxisoqb1PzElgdsvO5qUn4nyguqc8bZ/JKD1rQ0k
        Arr1f5AcmfBsKdA49ZB0TtzJ2xUtdOCPbVO98Walrdnid/VhstKHk22SOVhs6FLTtz2VhsYyjTeSB
        SZVxXsjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeEjs-001nr5-0Q;
        Thu, 07 Sep 2023 13:08:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DE62300687; Thu,  7 Sep 2023 15:08:05 +0200 (CEST)
Date:   Thu, 7 Sep 2023 15:08:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230907130805.GE10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:31:56AM +0100, Qais Yousef wrote:

> Equally recent discussion in PELT HALFLIFE thread highlighted the need for
> a way to tune system response time to achieve better perf, power and thermal
> characteristic for a given system
> 
> 	https://lore.kernel.org/lkml/20220829055450.1703092-1-dietmar.eggemann@arm.com/
> 

> To further help tune the system, we introduce PELT HALFLIFE multiplier as
> a boot time parameter. This parameter has an impact on how fast we migrate, so
> should compensate for whoever needed to tune fits_capacity(); and it has great
> impact on default response_time_ms. Particularly it gives a natural faster rise
> time when the system gets busy, AND fall time when the system goes back to
> idle. It is coarse grain response control that can be coupled with finer grain
> control via schedutil's response_time_ms.

You're misrepresenting things... The outcome of that thread above was
that PELT halftime was not the primary problem. Specifically:

  https://lore.kernel.org/lkml/424e2c81-987d-f10e-106d-8b4c611768bc@arm.com/

mentions that the only thing that gaming nonsense cares about is DVFS
ramp-up.

None of the other PELT users mattered one bit.

Also, ISTR a fair amount of this was workload dependent. So a solution
that has per-task configurability -- like UTIL_EST_FASTER, seems more
suitable.


I'm *really* hesitant on adding all these mostly random knobs -- esp.
without strong justification -- which you don't present. You mostly seem
to justify things with: people do random hack, we should legitimize them
hacks.

Like the last time around, I want the actual problem explained. The
problem is not that random people on the internet do random things to
their kernel.
