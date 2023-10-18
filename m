Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678B77CEC03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJRX0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:26:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123BB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:25:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087FDC433C7;
        Wed, 18 Oct 2023 23:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697671557;
        bh=af17yLZpE3wW13wgbbG7qsclNS+Q+/70kryD8tR9vus=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dcC+16VZjCAqBhgmAGKfV0sppXpPVjtU9Hz+1b+ySEvlu/YldQfbU1aodtjPY+FnR
         VMLblIq3AZjPdjrts4AaUBoCIbWuZwtbANJUyG7v3kq+KgvHB7gAOpWerlzcmNeNtu
         15y4uPHEJCO8WXbGjotfhg5fsuINk8P56ChrxUdmSBmIpCr04BIzcce8J41D6fA4HQ
         EH3f+CxzFjPmeBNEi7mcka0fO5tbPawT3ZI5WwQSlWkhkh/O76exOO04Zg64EHhB0R
         V8PNt34ZvQRgFHgE3HqHXgpD9iXRkCliQ0mMVR26jeml47O95tKAryiL9ceZmk/036
         I9i8UAQDGOk3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 810FBCE0BB0; Wed, 18 Oct 2023 16:25:56 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:25:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>, urezki@gmail.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <63d6ddfa-16ca-4c19-b542-a95f27d72f96@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttrngmq0.ffs@tglx>
 <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87il74qghh.fsf@oracle.com>
 <7520a5b9-b604-4da2-b874-32505f175f39@paulmck-laptop>
 <875y334k6m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y334k6m.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:53:05AM +0200, Thomas Gleixner wrote:
> On Wed, Oct 18 2023 at 10:51, Paul E. McKenney wrote:
> > On Wed, Oct 18, 2023 at 05:09:46AM -0700, Ankur Arora wrote:
> 
> Can you folks please trim your replies. It's annoying to scroll
> through hundreds of quoted lines to figure out that nothing is there.
> 
> >>  This probably allows for more configuration flexibility across archs?
> >>  Would allow for TREE_RCU=y, for instance. That said, so far I've only
> >>  been working with PREEMPT_RCU=y.)
> >
> > Then this is a bug that needs to be fixed.  We need a way to make
> > RCU readers non-preemptible.
> 
> Why?

So that we don't get tail latencies from preempted RCU readers that
result in memory-usage spikes on systems that have good and sufficient
quantities of memory, but which do not have enough memory to tolerate
readers being preempted.

							Thanx, Paul
