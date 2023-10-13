Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7187C7EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjJMHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJMHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:40:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84507B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2vT+ALa9vT2XjnLy1fOpBXo2FqIj5nje9O6fe8H/Kqg=; b=M9eQvmkIFkji2LL6JDHG9ESyyc
        CyrEBltzSZxUyfw/AO6+yeueTKlHY3pHnEGoWfyF3zAssCEk/SvHMoFhTl1PPAyigqJTBBQM8RDsP
        T0U6zHI+buRDudL9eYIJCvdgdIdazC2bksPmDObjplpW3M8DX8lhM/fFGdU4tr42BC5X1oH48lM+i
        VIe9BEnyHjArhnprXyVESsE1+eYaZzyYkptaYM8oDXnhpNs6GvsDhsFho5/OHaPKokSzvgZzxBUz5
        5H6jOlRyrfW9NUWUWY6YTr76VAb7Sz3AHzKPAoItbN40w5TMbr3vTN+fRySMkPENurgubtEsGSX6Q
        JHpnfpgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qrCjs-0048KY-Ei; Fri, 13 Oct 2023 07:37:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5CE1300365; Fri, 13 Oct 2023 09:37:39 +0200 (CEST)
Date:   Fri, 13 Oct 2023 09:37:39 +0200
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
Subject: Re: Re: [PATCH 03/15] sched/fair: Add lag based placement
Message-ID: <20231013073739.GA12118@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124603.794929315@infradead.org>
 <87f1feec-1be5-4d24-a206-e30238072ae1@bytedance.com>
 <20231011132456.GO14330@noisy.programming.kicks-ass.net>
 <57c6d8c8-380e-45d9-b9d0-690662fcd6f4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c6d8c8-380e-45d9-b9d0-690662fcd6f4@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 03:04:47PM +0800, Abel Wu wrote:
> On 10/11/23 9:24 PM, Peter Zijlstra Wrote:

> > > > +		 * we should inflate the lag before placement such that the
> > > > +		 * effective lag after placement comes out right.
> > > > +		 *
> > > > +		 * As such, invert the above relation for vl'_i to get the vl_i
> > > > +		 * we need to use such that the lag after placement is the lag
> > > > +		 * we computed before dequeue.
> > > > +		 *
> > > > +		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
> > > > +		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
> > > > +		 *
> > > > +		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
> > > > +		 *                   = W*vl_i
> > > > +		 *
> > > > +		 *   vl_i = (W + w_i)*vl'_i / W
> > 
> > And then we obtain the scale factor: (W + w_i)/W, which is >1, right?
> 
> Yeah, I see. But the scale factor is only for the to-be-placed entity.
> Say there is an entity k on the tree:
> 
> 	vl_k	= V - v_k
> 
> adding the to-be-placed entity i affects this by:
> 
> 	define delta := w_i*vl_i / (W + w_i)
> 
> 	vl'_k	= V' - v_k
> 		= V - delta - (V - vl_k)
> 		= vl_k - delta
> 
> hence for any entity on the tree, its lag is offsetted by @delta. So
> I wonder if we should simply do offsetting rather than scaling.

I don't see the point, the result is the same and computing delta seems
numerically less stable.
