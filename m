Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8476B8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjHAPiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjHAPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:38:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822426B0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QQvm9P3bQLEbjxfH7khUELo8UvP2QUFHLALD1WtUuME=; b=wSvZyfneEW42/vG5ICjcTiXKIZ
        ntOwC9W9kXXqMcXv4TcMoRj6aO6NvsE+WEfVilyOj7otN+d+C2sHL87Sl9usCT2ZpPGLWWRTH0JlE
        VZcc7ETB05DjPmxdvZCtQ6gI+UDajr3MtP4SpIdaF44p8dATKSl8hBmadMGOJt4A6yCF48zWJHWbO
        plKD7A5q1xC6YJCfwRnGkxkoVZ3GNH05+/I+hVXd0p3U918qLPzVUlaRpIW11jL7Alka9Shy01JJN
        QOlF2zZ0uT94lHhCMaZkaTbiSp0zwzu+et9/ZzsZtbAbRUzbXr07w3t3aG9Y5cA2iMyOijdEVBtjS
        OGNh9n3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQrRE-009bY8-Lm; Tue, 01 Aug 2023 15:37:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCFB03001DD;
        Tue,  1 Aug 2023 17:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D85A201AB903; Tue,  1 Aug 2023 17:37:31 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:37:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v6 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
Message-ID: <20230801153731.GD11704@hirez.programming.kicks-ass.net>
References: <20230712133357.381137-1-pauld@redhat.com>
 <20230712133357.381137-3-pauld@redhat.com>
 <20230731224934.GD51835@hirez.programming.kicks-ass.net>
 <20230801111342.GA268019@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801111342.GA268019@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 07:13:42AM -0400, Phil Auld wrote:
> On Tue, Aug 01, 2023 at 12:49:34AM +0200 Peter Zijlstra wrote:
> > On Wed, Jul 12, 2023 at 09:33:57AM -0400, Phil Auld wrote:
> > > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > > can easily run well past their quotas before a remote tick does
> > > accounting.  This leads to long, multi-period stalls before such
> > > tasks can run again. Currently, when presented with these conflicting
> > > requirements the scheduler is favoring nohz_full and letting the tick
> > > be stopped. However, nohz tick stopping is already best-effort, there
> > > are a number of conditions that can prevent it, whereas cfs runtime
> > > bandwidth is expected to be enforced.
> > > 
> > > Make the scheduler favor bandwidth over stopping the tick by setting
> > > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> > > runtime limit enabled. We use cfs_b->hierarchical_quota to
> > > determine if the task requires the tick.
> > > 
> > > Add check in pick_next_task_fair() as well since that is where
> > > we have a handle on the task that is actually going to be running.
> > > 
> > > Add check in sched_can_stop_tick() to cover some edge cases such
> > > as nr_running going from 2->1 and the 1 remains the running task.
> > 
> > These appear fine to me, except:
> >
> > > Add sched_feat HZ_BW (off by default) to control the tick_stop
> > > behavior.
> > 
> > What was the thinking here? This means nobody will be using this -- why
> > would you want this default disabled?
> > 
> 
> That was just a hedge in case it caused issues. I'd probably have had to
> enable it in RHEL anyway. Using a feature was to make it inocuous when
> disabled.  Would you prefer me to enable it or remove the sched_feat
> entirely? (or do you want to just switch that to true when you apply it?)

I've edited it to default enabled -- we can pull the feature flag
eventually I suppose.

Things didn't readily apply, so I've kicked at it a little. Should be in
queue/sched/core for the robots to chew on.
