Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CE794446
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbjIFUJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjIFUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:09:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB88198E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IWRauGgfrnnZLkU3oyZlz7GvuOrCS1ynxFHxzRGiEN8=; b=D3Sv0y3rc6sEcVHK2gNnmavfrm
        s3V73rfzkB3M1Jv606Op8mnWArT7KtAsjK6A3HAsZLFa4vpb58MCWTfbptoHptDwb3lXD0c1/TR5o
        4i9+yQ/MerWu+A0929nGza4BSDCrU3Qj3KDLmfD9UWV1aotHG3u4O1k3664S4qQjRqv9YZd3Ku+gs
        bqkShLmW21pNNkvFxU1nH/4PJSb2JF1tnI8ZRmzY+f0adg+jaJX/5kBbHveDQOB9wtxtiMEhBXLYL
        YY5bdo7RTVn1wxJWoixud+CUl1BHp4Am84Q1wvnGozxHTFbF1W1kacV60EC8asBYFC2+u1QufJYUy
        mMhBCb/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdypT-001Ft2-0z;
        Wed, 06 Sep 2023 20:08:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E295300422; Wed,  6 Sep 2023 22:08:48 +0200 (CEST)
Date:   Wed, 6 Sep 2023 22:08:48 +0200
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
Message-ID: <20230906200848.GA35105@noisy.programming.kicks-ass.net>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
 <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
 <20230906082952.GB38741@noisy.programming.kicks-ass.net>
 <0ce80c5d-2433-13d5-33df-d110cf8faa9c@redhat.com>
 <20230906200406.GF28278@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906200406.GF28278@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:04:06PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 06, 2023 at 04:58:11PM +0200, Daniel Bristot de Oliveira wrote:
> 
> > > So one thing we could do is have update_curr_fair() decrement
> > > fair_server's runtime and yield the period then it hits 0 (and capping
> > > it at 0, not allowing it to go negative or so).
> > > 
> > > That way you only force the situation when FAIR hasn't had it's allotted
> > > time this perio, and only for as much as to make up for the time it
> > > lacks.
> > 
> > We can also decrease the runtime to a negative number while in
> > defer/throttle state, and let the while in replenish_dl_entity() to
> > replenish with the += runtime;
> 
> Yes, but my point was that fair_server gives a lower bound of runtime
> per period, more -- if available -- is fine.
> 
> If we allow negative runtime, you'll affect future periods, and that is
> not desired in this case.
> 
> Or am I still confused?

That is, let update_curr_fair() decrement fair_server runtime
*unconditionally* -- even if the task was not selected through the
server.

Specifically, if the fair task is selected normally due to lack of
deadline tasks, that runtime *still* counts towards the fair-server and
have the server yield the period when zero.

This means that fair_server is only effective IFF 'normal' execution
doesn't match the fair_server.runtime execution.


