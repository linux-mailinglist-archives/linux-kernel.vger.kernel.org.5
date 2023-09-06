Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B7794439
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbjIFUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIFUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:04:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81CD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fSfheHSKdKvsm55dIGjIk+LadeQyezLZQ5jl3d+yjp0=; b=YcWaleaPmVT6dWOpk7bzWuWm5g
        ta3rQUe5zG/E5rQGVRjrlq/fx4rOYq5GlRkdeLTa7XMi8rkWceBzSDm0vQOkhv1CG7S3W7mHesPov
        cdI6ub1On6XCpuUeElkVTaQXwpB5FdZntbRGUiuWAGvmH/s/8JN3wngEOq2BROqOylnux6Tdm3yMk
        7IoywH6GTsPaNV7BgNkNzNDySLKHzKTPBIzHpx+PxaACWpeRQA2BewhFgAcpwX2JcYvJnqB9sif/W
        phyISu1I9gJKlUAFbep1IXx6MbPYAb43pXpuvMas+sfpvHTHZpoxHu5n204Y5WX2Fnr9ScUC4CR1r
        obXC3xng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdykx-005Cpg-4F; Wed, 06 Sep 2023 20:04:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EFC630057E; Wed,  6 Sep 2023 22:04:06 +0200 (CEST)
Date:   Wed, 6 Sep 2023 22:04:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
Message-ID: <20230906200406.GF28278@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:

> > So one thing we could do is have update_curr_fair() decrement
> > fair_server's runtime and yield the period then it hits 0 (and capping
> > it at 0, not allowing it to go negative or so).
> > 
> > That way you only force the situation when FAIR hasn't had it's allotted
> > time this perio, and only for as much as to make up for the time it
> > lacks.
> 
> We can also decrease the runtime to a negative number while in
> defer/throttle state, and let the while in replenish_dl_entity() to
> replenish with the += runtime;

Yes, but my point was that fair_server gives a lower bound of runtime
per period, more -- if available -- is fine.

If we allow negative runtime, you'll affect future periods, and that is
not desired in this case.

Or am I still confused?

