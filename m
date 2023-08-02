Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92176CB0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjHBKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjHBKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:38:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD21995;
        Wed,  2 Aug 2023 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MCmsxQqALuz6Ywdo1dTk+WNBTl8HlNFhVPItDng2+ho=; b=DGrvXazK8uXe3OoPO2V8KXqx3E
        zz4Woh2zPnCcUX2CksudgwDtGmH5jz6NvUICTcCQPZGAW3+3Mjhq/vfpQXU3/AK4p4bFXExCPXpKt
        32EmBgNYNic5JAgKhTiQHRl4UOcvkWivDDlMkH8Ti/4fzPNecY5WVP9TRrzX1EgJS1w7dnWQ64/rO
        2CGyGTONOmx+IESCtqh27lpebRbmTlnxEjftHHLTjANticGs1nbcJjFmC0irYoK1rRV5LkFMEh5vx
        Mhacn+kgEUmh3BzqIIr0gKPvAp3r/tX45yBxSSYMtXBfH1WuLe8REf0c3FJUl+23k6DX9Moza1/d+
        IKNQlbmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qR9BT-00Fs5w-28;
        Wed, 02 Aug 2023 10:34:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9A083001DD;
        Wed,  2 Aug 2023 12:34:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7D3E2102E8CE; Wed,  2 Aug 2023 12:34:26 +0200 (CEST)
Date:   Wed, 2 Aug 2023 12:34:26 +0200
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
Message-ID: <20230802103426.GB210177@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
 <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
 <CAJZ5v0iVKRY5-YvQmMbZ3+eZNHJgXt=CoYedNueAJyT9+Ld5Dg@mail.gmail.com>
 <20230731090935.GB29590@hirez.programming.kicks-ass.net>
 <CAJZ5v0jh5oozZm7OvN9j1iHtzYQzPMOJ=Nt0HaJKYyJ218Cezw@mail.gmail.com>
 <20230731113850.GE29590@hirez.programming.kicks-ass.net>
 <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h+KC+uMiOE4m4Dp4=iHMkekutk+B+cwb0de8Fvswv6jA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:55:35PM +0200, Rafael J. Wysocki wrote:

> > In that case you cannot tell the difference between I'm good to use this
> > state and I'm good to disable the tick and still use this state.
> 
> No, you don't, but is it really worth the fuss?

My somewhat aged IVB-EP sits around 25 us for restarting the tick.

Depending on the C state, that is a significant chunk of exit latency,
and depending on how often you do the whole NOHZ dance, this can add up
to significant lost runtime too.

And these are all machines that have a usable TSC, these numbers all go
up significantly when you somehow end up on the HPET or similar wreckage.

Stopping the tick is slightly more expensive, but in the same order, I
get around 30 us on the IVB, vs 25 for restarting it. Reprogramming the
timer (LAPIC/TSC-DEADLINE) is the main chunk of it I suspect.

So over-all that's 55 us extra latency for the full idle path, which can
definitely hurt.

So yeah, I would say this is all worth it.

My ADL is somewhat better, but also much higher clocked, and gets around
10 us for a big core and 16 us for a little core for restarting the
tick.
