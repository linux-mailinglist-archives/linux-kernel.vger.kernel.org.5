Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7A76B2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHALSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjHALR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E384693
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690888428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kA4xN8X2MfzWKxTQBNCnJbEbWGPsqRHAYEWq7tejRS0=;
        b=eWchMFatNeSVcKp4llUP5FanSeWBcTf4n7Sf0Js/q2dTl2XgqEHOk0pD8lbCJ3doDM+QCz
        wwfmEddKPt6yricpwTD7CNORHNcJu0OOcNJhP9e2RKM9y2tXeW6fpZZhxBvP+NvLzrxJkk
        IQC6hhxmTgTV1+2J1Z3EJdgsgvVpaAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-79K1YrdOMW2wF6i12uudjw-1; Tue, 01 Aug 2023 07:13:45 -0400
X-MC-Unique: 79K1YrdOMW2wF6i12uudjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C096D81D9EC;
        Tue,  1 Aug 2023 11:13:44 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.8.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 85F3B2166B26;
        Tue,  1 Aug 2023 11:13:43 +0000 (UTC)
Date:   Tue, 1 Aug 2023 07:13:42 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20230801111342.GA268019@lorien.usersys.redhat.com>
References: <20230712133357.381137-1-pauld@redhat.com>
 <20230712133357.381137-3-pauld@redhat.com>
 <20230731224934.GD51835@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731224934.GD51835@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:49:34AM +0200 Peter Zijlstra wrote:
> On Wed, Jul 12, 2023 at 09:33:57AM -0400, Phil Auld wrote:
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again. Currently, when presented with these conflicting
> > requirements the scheduler is favoring nohz_full and letting the tick
> > be stopped. However, nohz tick stopping is already best-effort, there
> > are a number of conditions that can prevent it, whereas cfs runtime
> > bandwidth is expected to be enforced.
> > 
> > Make the scheduler favor bandwidth over stopping the tick by setting
> > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> > runtime limit enabled. We use cfs_b->hierarchical_quota to
> > determine if the task requires the tick.
> > 
> > Add check in pick_next_task_fair() as well since that is where
> > we have a handle on the task that is actually going to be running.
> > 
> > Add check in sched_can_stop_tick() to cover some edge cases such
> > as nr_running going from 2->1 and the 1 remains the running task.
> 
> These appear fine to me, except:
>
> > Add sched_feat HZ_BW (off by default) to control the tick_stop
> > behavior.
> 
> What was the thinking here? This means nobody will be using this -- why
> would you want this default disabled?
> 

That was just a hedge in case it caused issues. I'd probably have had to
enable it in RHEL anyway. Using a feature was to make it inocuous when
disabled.  Would you prefer me to enable it or remove the sched_feat
entirely? (or do you want to just switch that to true when you apply it?)

Thanks,
Phil

-- 

