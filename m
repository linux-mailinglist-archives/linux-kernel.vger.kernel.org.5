Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D537EC717
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344472AbjKOPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbjKOPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:23:20 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88749187
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=EL2coC0zdaCT6BuLnvSWKcGL4SPBWw2G576onj7IuMU=; b=q9kxswLPiuLamSLBrH2x36ofpR
        XcILte117LiDRSgtVGDRcLzmMJPLPXed0B4bXtO50oD1Psls89sx/+YSWZSXA3NWK6ZCFSsjE8cTn
        42rz4BicJ/UCcCcRenwsQW/00WPK8pBKW8rJfUnnXgLkoZ820o9zvBGPsl/0g9xwZ8tYqhEa7KNlk
        ySUFJSJbh+anVSsZwbI1KrU5NL80bXBydFrplv3eAqgM9VtXP2LrrzlmwLPVoHGsUuPiXh0Bq6SGt
        0eA/hs0aYJgJCIjTEHvpciVeXjyVpWIMmSppo9xgocLjhn8JnKsPXvZbb2o9nUw/9S0x/6hZtR/P9
        EFP1pfvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3HjH-0047In-1t;
        Wed, 15 Nov 2023 15:22:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45B03300427; Wed, 15 Nov 2023 16:22:59 +0100 (CET)
Date:   Wed, 15 Nov 2023 16:22:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/fair: introduce core_vruntime and
 core_min_vruntime
Message-ID: <20231115152259.GB8262@noisy.programming.kicks-ass.net>
References: <20231115113341.13261-1-CruzZhao@linux.alibaba.com>
 <20231115113341.13261-4-CruzZhao@linux.alibaba.com>
 <20231115122027.GZ8262@noisy.programming.kicks-ass.net>
 <246dee1f-5e14-e075-13c7-ce876305cb54@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <246dee1f-5e14-e075-13c7-ce876305cb54@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 09:42:13PM +0800, cruzzhao wrote:
> 
> 
> 在 2023/11/15 下午8:20, Peter Zijlstra 写道:
> > On Wed, Nov 15, 2023 at 07:33:40PM +0800, Cruz Zhao wrote:
> >> To compare the priority of sched_entity from different cpus of a core,
> >> we introduce core_vruntime to struct sched_entity and core_min_vruntime
> >> to struct cfs_rq.
> >>
> >> cfs_rq->core->core_min_vruntime records the min vruntime of the cfs_rqs
> >> of the same task_group among the core, and se->core_vruntime is the
> >> vruntime relative to se->cfs_rq->core->core_min_vruntime.
> > 
> > But that makes absolutely no sense. vruntime of different RQs can
> > advance at wildly different rates. Not to mention there's this random
> > offset between them.
> > 
> > No, this cannot be.
> 
> Force idle vruntime snapshot does the same thing, comparing
> sea->vruntime - cfs_rqa->min_vruntime_fi with seb->vruntime -
> cfs_rqb->min_vruntime_fi, while sea and seb may have wildly different rates.

But that subtracts a from a and b from b, it doesn't mix a and b.

Note that se->vruntime - cfs_rq->min_vruntime is a very poor
approximation of lag. We have actual lag now.

Note that:

  (sea - seb) + (min_fib - min_fia) =
  (sea - min_fia) + (min_fib - seb) =
  (sea - min_fia) - (seb - min_fib) =
  'lag'a - 'lag'b

It doesn't mix absolute a and b terms anywhere.

> Actually, cfs_rq->core->core_min_vruntime does the same thing as
> cfs_rq->min_vruntime_fi, providing a baseline, but
> cfs_rq->core->core_min_vruntime is more accurate.

min(cfs_rqa, cfs_rqb) is nonsense. And I can't see how min_vruntime_fi
would do anything like that.

> I've tried to implement a fair enough mechanism of core_vruntime, but
> it's too complex because of the weight, and it costs a lot. So this is a
> compromise solution.

'this' is complete nonsense and not motivated by any math.

> BTW, is there any other solutions to solve this problem?

Well, this is where it all started:

  https://lkml.kernel.org/r/20200506143506.GH5298%40hirez.programming.kicks-ass.net

The above lag thing is detailed in a follow up:

  https://lkml.kernel.org/r/20200515103844.GG2978%40hirez.programming.kicks-ass.net

Anyway, I think the first of those links has the start of the
multi-queue formalism, see the S_k+l bits. Work that out and see where
it ends.

I did go a bit further, but I've forgotten everything since, it's been
years.

Anyway, nothing like this goes in without a fairly solid bit of math in
the changelog to justify it.

Also, I think Joel complained about something like this at some point,
and he wanted to update the core tree more often, because IIRc his
observation was that things got stale or something.
