Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE77649CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjG0ID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjG0ICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:02:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4B72D4E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XgJc/ZZkyebkaGzMKv746VHu3v2bPe99MaMfLeRj7JU=; b=OBUMf7hexpg8XJHbTRd9JpbY2L
        td6pMQJkzogqYq9hcJimUClNlsa9D2wrMwQkAVVOlVGKlt/DcmDp5348UqfWHE8GnWm8YAgcNiiYD
        nT/ci5TwAkKUSOL8HOCad82q/Tn8X8e3HWt/mBocKquTnaXOTC4kL+jFUqJE7QtQ2DzH+wQVjxrZB
        tSjagmc6E8YwUDhSSVIhbkC7TE+ciMn3oAff5wztkabPYf3t82Ucwpz1Q87moCpJrTHsc3jVUlgiL
        Cfxq72iq5P8tUk9K44La995+VYlYJQwqN939UIWO2JrzZHcNVvLF9pcaYUxjoxP2Vyyj2jw+4wMN2
        /ow+IP+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOvu7-0071xm-0L;
        Thu, 27 Jul 2023 07:59:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57EA13001E5;
        Thu, 27 Jul 2023 09:59:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 320412012156C; Thu, 27 Jul 2023 09:59:22 +0200 (CEST)
Date:   Thu, 27 Jul 2023 09:59:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        g@hirez.programming.kicks-ass.net
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
Message-ID: <20230727075922.GA3886590@hirez.programming.kicks-ass.net>
References: <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de>
 <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
 <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
 <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
 <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
 <20230726161432.GW4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726161432.GW4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:14:32PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 26, 2023 at 05:53:46PM +0200, Rafael J. Wysocki wrote:
> 
> > > > That means we don't track nearly enough data to reliably tell anything
> > > > about disabling the tick or not. We should have at least one bucket
> > > > beyond TICK_NSEC for this.
> > >
> > > Quite likely.
> > 
> > So the reasoning here was that those additional bins would not be
> > necessary for idle state selection, but the problem of whether or not
> > to stop the tick is kind of separate from the idle state selection
> > problem if the target residency values for all of the idle states are
> > relatively short.  And so it should be addressed separately which
> > currently it is not.  Admittedly, this is a mistake.
> 
> Right, the C state buckets are enough to pick a state, but not to handle
> the tick thing.
> 
> The below hack boots on my ivb-ep with extra (disabled) states. Now let
> me go hack up teo to make use of that.
> 
> name		residency
> 
> POLL		0
> C1              1
> C1E             80
> C3              156
> C6              300
> TICK            1000
> POST-TICK       2000
> 

Ah, so last night (or rather, somewhat realy today) I realized I has the
buckets wrong.

We don't have buckets to the left, but buckets to the right, so the
above would give:

0: [0,1)
1: [1,80)
2: [80,156)
3: [156,300)
4: [300,1000)
5: [1000,2000)
6: [2000,...)

Which also means I can ditch the whole POST-TICK bucket. Let me get
breakfast and try all this again.
