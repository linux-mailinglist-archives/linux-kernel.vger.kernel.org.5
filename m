Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4B076A002
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjGaSGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:06:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B9E4E;
        Mon, 31 Jul 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bgNgYvfq1f04oO5f+UeUXJk/NCLsVQfflOIVPVkc6w0=; b=imw1vShSbrgZqY10Wi/22TBYgn
        2Oj9rT3mbhenOucH+BlnUNV+MY3s1rgmrs64lf4TyrRjqC4XQ0+/Wyvjg5wyXByqxjTs6sZq2uEDS
        9qQEaieHqVsEuFZ5ABbxx8HCVQon+4zqp4WvRjDfGQ19113YR3xA5Vx9X6JLK/2gP7LnzHAmA/doE
        5/RI6+QifMck3AeUGOb4pCuizvqS8+hv4858PqYh0HYvTxCjF1fkg9YGmTpBGvPYIONQ7PfZZA1Yz
        4XV6TIEPXdY2Iur3Byatcs+RE7kIHxmG7s9eRAjSyg4yl1UX9QcjLyd+QJiB7doix9x07vaHbOiNi
        to7dSAtg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQXHO-00CzTq-1u;
        Mon, 31 Jul 2023 18:06:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B27B3002CE;
        Mon, 31 Jul 2023 20:06:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BE84203C242E; Mon, 31 Jul 2023 20:06:01 +0200 (CEST)
Date:   Mon, 31 Jul 2023 20:06:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
Message-ID: <20230731180601.GS29590@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net>
 <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
 <20230731113850.GE29590@hirez.programming.kicks-ass.net>
 <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
 <CAJZ5v0jz1aZdNHPH5x=VoDjfdMnD_+iE2CuYN5=nk=CMxSkXpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jz1aZdNHPH5x=VoDjfdMnD_+iE2CuYN5=nk=CMxSkXpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:27:27PM +0200, Rafael J. Wysocki wrote:

> BTW, note that teo records timers as "hits", because it has an idea
> about when the next timer should occur and that's because it calls
> tick_nohz_get_sleep_length().
> 
> If it doesn't call that function, it will not be able to tell the
> difference between a non-tick timer and any other wakeup, so the
> non-tick timer wakeups will then be recorded as "intercepts" which
> will skew it towards shallow states over time.  That's one of the
> reasons why I would prefer to only avoid calling
> tick_nohz_get_sleep_length() when the candidate idle state is really
> shallow.

Can be fixed using tick_nohz_get_next_hrtimer() I think. Let me try that
tomorrow.
