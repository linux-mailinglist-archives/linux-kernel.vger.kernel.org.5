Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F044679CFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbjILLZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjILLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:24:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74F10E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvRsZ8jHEZWSXxYqRgH5jVyNSga1PXW6GomFP+uyXv0=; b=LE7GRKzGPI1MnV/gY3EhWjOO91
        aLoymo9B6RZS8P8hqjW4Z4bLF3AwWpxPfpkiPVSCnnSD08IEpUlHIHpSUQ0QQRu+iQpIQwr3mFub3
        8ulGFqzXgEnvcY4fXO88v2HB7d6mmzqIDg14CgZPZfa1feh9rLSBEbiU3k5+jPrRriETg8b5O+ozF
        PJoSryjiPq+0/YU2vS+F9au9epIojDva9hQvJH4FRzMdQI1T1Wc5iVVXBTLhdevYay05+pRvbic9C
        ekCBuwYP2zTxjPMjJzRa3/eoEzNYNdoFcGnCAIOodf3MkV+X51b4pJ4JXqJRVdkRDm3W0CTGhR71K
        6OyonlJw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg1Ut-0063ms-37;
        Tue, 12 Sep 2023 11:24:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15628300348; Tue, 12 Sep 2023 13:24:01 +0200 (CEST)
Date:   Tue, 12 Sep 2023 13:24:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Message-ID: <20230912112400.GG35261@noisy.programming.kicks-ass.net>
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net>
 <20230912111711.DHVKG-B4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912111711.DHVKG-B4@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:17:11PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-09-11 16:11:35 [+0200], Peter Zijlstra wrote:
> > Aside from this being just plain gross, this also destroys determinism
> > of futex_pi, which completely defeats the purpose of the whole thing.
> 
> No objections here.
> 
> > Now.. the reason we need hb->lock at this point is to avoid the
> > wake_futex_pi() -EAGAIN case.
> > 
> > This happens when futex_top_waiter() and rt_mutex_top_waiter() state
> > becomes inconsistent. The current rules are such that this inconsistency
> > will not be observed.
> > 
> > Notably the case that needs to be avoided is where futex_lock_pi() and
> > futex_unlock_pi() interleave such that unlock will fail to observe a new
> > waiter.
> > 
> > *However* the case at hand is where a waiter is leaving, in this case
> > what happens is that we'll fail to observe a waiter that is already
> > gone, which is harmless afaict.
> 
> Sounds harmless. I sure something will be pop up in a few years and we
> will look back this ;)

Oh absolutely, I already hate this... It's dangerous as heck, because
if we ever do trip the race the other way around it will silently
misbehave.

However, compared to the other hack ... :-(

