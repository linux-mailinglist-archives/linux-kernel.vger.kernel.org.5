Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9F7C5557
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJKNZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjJKNZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:25:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B51A92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fjWlCAr02qhHiPzFN+j8xSGNeytzdn+jfQfHwKa+nhM=; b=PNQrCO1qldo1XHBEfFbOw2F3K+
        pJ2Mn3AGYevAa6PJALfrvv2J4i2qL6wV7mRRLq7pjNH4+BrPl18Kkj7t6EV4NFn0Wnngs3fBFqCHf
        y6BiozmkpXAp6qwd68NwBHV4cUm0ScJQV499k0wjyrF8dqLyCb2/Uaq9vIoEb5YzkBi7l05s8Plpo
        1dqCrXhklg4Me5o9neFzilft17ezyJrd52P0BTUf9usM8Ybm4Rdm0Z1Etla5j9dYfOjvZTnyRJkEh
        sSMKe5Wts7fnBb3Sw+nt5G/vtY9sJJd1JCQDpNo+Rqg6hajXAl8VZUvej8UgGrQ/X8ineVODPvML8
        U5oJ5Kcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqZCq-00AzE3-GF; Wed, 11 Oct 2023 13:24:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C6FA30036C; Wed, 11 Oct 2023 15:24:56 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:24:56 +0200
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
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
Message-ID: <20231011132456.GO14330@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 08:00:22PM +0800, Abel Wu wrote:
> On 5/31/23 7:58 PM, Peter Zijlstra Wrote:
> >   		/*
> > +		 * If we want to place a task and preserve lag, we have to
> > +		 * consider the effect of the new entity on the weighted
> > +		 * average and compensate for this, otherwise lag can quickly
> > +		 * evaporate.
> > +		 *
> > +		 * Lag is defined as:
> > +		 *
> > +		 *   lag_i = S - s_i = w_i * (V - v_i)
> > +		 *
> > +		 * To avoid the 'w_i' term all over the place, we only track
> > +		 * the virtual lag:
> > +		 *
> > +		 *   vl_i = V - v_i <=> v_i = V - vl_i
> > +		 *
> > +		 * And we take V to be the weighted average of all v:
> > +		 *
> > +		 *   V = (\Sum w_j*v_j) / W
> > +		 *
> > +		 * Where W is: \Sum w_j
> > +		 *
> > +		 * Then, the weighted average after adding an entity with lag
> > +		 * vl_i is given by:
> > +		 *
> > +		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
> > +		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
> > +		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
> > +		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
> > +		 *      = V - w_i*vl_i / (W + w_i)
> > +		 *
> > +		 * And the actual lag after adding an entity with vl_i is:
> > +		 *
> > +		 *   vl'_i = V' - v_i
> > +		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
> > +		 *         = vl_i - w_i*vl_i / (W + w_i)
> > +		 *
> > +		 * Which is strictly less than vl_i. So in order to preserve lag
> 
> Maybe a stupid question, but why vl'_i < vl_i? Since vl_i can be negative.

So the below doesn't care about the sign, it simply inverts this
relation to express vl_i in vl'_i:

> > +		 * we should inflate the lag before placement such that the
> > +		 * effective lag after placement comes out right.
> > +		 *
> > +		 * As such, invert the above relation for vl'_i to get the vl_i
> > +		 * we need to use such that the lag after placement is the lag
> > +		 * we computed before dequeue.
> > +		 *
> > +		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
> > +		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
> > +		 *
> > +		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
> > +		 *                   = W*vl_i
> > +		 *
> > +		 *   vl_i = (W + w_i)*vl'_i / W

And then we obtain the scale factor: (W + w_i)/W, which is >1, right?

As such, that means that vl'_i must be smaller than vl_i in the absolute
sense, irrespective of sign.
