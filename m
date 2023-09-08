Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5372798A80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbjIHQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238765AbjIHQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:12:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CBB4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cV6rs7lHoym9wKU70XXMlIT0xCEu+NT4XjD1eOpxkE=; b=GxySJT4x09iGEvotlTKMCSioaA
        E+kdzkusdHMTPQGJcUgoSUWwosJ0bw1QD5okJVh2JM95TndU3GKqspXj1ABI6sChYqZ7r1yu0UUWK
        5sIse92nEs/yHOZmdP7qhlmI7vsJfqqNeBfPNwUdMYfOyw8JmjfLDXhaG8TuaYAWAL24BVGtweE+/
        +ACCZb5dcr0sEnU5VU4NM36DgpAnENkya7Z4wS3bIk/OAzKi243trJ1ogV6rrT918IQ8Fx3UGtISF
        k74ZUyavJCFyt2LXjcSD0Zmcn63084QiXKaVRDycg/BoEMlteiFgQXRLWnZfiprMAJ42qB4Prv07z
        BfMTdtFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qee56-0014Kr-Sv; Fri, 08 Sep 2023 16:11:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BF6830057E; Fri,  8 Sep 2023 18:11:40 +0200 (CEST)
Date:   Fri, 8 Sep 2023 18:11:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
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
Message-ID: <20230908161140.GM19320@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
 <20230907080729.GA16872@noisy.programming.kicks-ass.net>
 <658f807e-7f7a-e6d2-25e7-00eb2187af2a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658f807e-7f7a-e6d2-25e7-00eb2187af2a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 05:28:46PM +0200, Daniel Bristot de Oliveira wrote:

> Let me see if I got it:
> 
> 	- Always start the server, but throttled with full runtime...
> 	- Unconditionally decrement fair_server.dl_runtime from update_curr_fair()
> 		(check if it is not decremented twice as it runs)
> 	- When the dl timer fire, replenish or throttle for the next period?
> 
> is that the base for it?

Yes. So if dl timer fires and it still has runtime replenish will not
move the deadline and it will become eligible to run. If it has 0
runtime, replenish does it's thing, ups runtime and moves the deadline
forward and then the zero-laxity condition will re-throttle, goto 1
etc..
