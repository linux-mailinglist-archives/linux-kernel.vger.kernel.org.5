Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91307C4F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjJKKGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJKKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B83A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ru13DeRhXr5O3lJX/bII3hYV9X/ReGtUQEVXr8wohKQ=; b=aaPURNkjX2snHXUeJIYyPubMB8
        /Zy+9ilAeWg8NwyLQdZQq7trCwxwsLEWdRMhsFV635OLGiz1+sIPXHKO+LCvuFUZ1zYsHaknzEjC6
        AQUfqp14I56qF8mBzzAWPcmEaBmhOnP+6UWPgA56gj2XBRWz9Dqt3F1XeCra6ZQME84WHd7fYwjAi
        Utzb4KwuW350k1aPt07U0PQefPH+k5unVztRWWV3waqAlqkyWJrUsia85N83BDkqXwcXWjZtrzunq
        4x81KM/I/UiVgAlr5Mw3Kr57f8nCoYZ2bPmb1E4oRYC6pSp/b/Fd2aYZBnqBSCU8v3ZmdO3P51Ced
        6KMz5ALg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqW5l-0007rV-1c;
        Wed, 11 Oct 2023 10:05:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97B7D30026F; Wed, 11 Oct 2023 12:05:26 +0200 (CEST)
Date:   Wed, 11 Oct 2023 12:05:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
Message-ID: <20231011100526.GE6337@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.654144274@infradead.org>
 <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
 <20231011073001.GI14330@noisy.programming.kicks-ass.net>
 <3156c8fe-5488-4044-8282-79495bf89f6d@bytedance.com>
 <20231011094539.GE6307@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011094539.GE6307@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:45:39AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 11, 2023 at 04:30:26PM +0800, Abel Wu wrote:
> > On 10/11/23 3:30 PM, Peter Zijlstra Wrote:
> > > On Wed, Oct 11, 2023 at 12:15:28PM +0800, Abel Wu wrote:
> > > > On 5/31/23 7:58 PM, Peter Zijlstra wrote:
> > > > > +/*
> > > > > + * Compute virtual time from the per-task service numbers:
> > > > > + *
> > > > > + * Fair schedulers conserve lag:
> > > > > + *
> > > > > + *   \Sum lag_i = 0
> > > > > + *
> > > > > + * Where lag_i is given by:
> > > > > + *
> > > > > + *   lag_i = S - s_i = w_i * (V - v_i)
> > > > 
> > > > Since the ideal service time S is task-specific, should this be:
> > > > 
> > > > 	lag_i = S_i - s_i = w_i * (V - v_i)
> > > 
> > > It is not, S is the same for all tasks. Remember, the base form is a
> > > differential equation and all tasks progress at the same time at dt/w_i
> > > while S progresses at dt/W.
> > 
> > IIUC it's V progresses at dt/W and is same for all tasks, not S which is
> > measured in real time (V*w_i).
> 
> Clearly I should wake up before replying ;-)
> 
>   V = S/W, so dV = dt/W and dS = dt
> 
> Anyway, the point is that both V and S are the same across all tasks,
> all tasks execute in parallel with infinitely small time increments.
> 
> In reality this can't work ofc, so we get the approximations v_i and s_i
> and lag is the deviation from the ideal.

Ah, I think I see. I'm making a mess of things aren't I.

I've got to run some errands, but I'll try and reply more coherently
after.
