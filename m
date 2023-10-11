Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AAE7C46CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344453AbjJKAkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13A8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696984769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fg8S2ybDrfMwqKipB/ZC4g70QBQJPgN1wyoLIe+e5WY=;
        b=Am9Lvz1bwV2D8/5D8hZj8MTRqIJMuaC9EMkLdHywXpDm5+6BAc/l4q/WgxdmV5P1GTtIJ2
        589XadSVJKNffw7FpIkS+wAwj74mMd0cZI89AvvZtKIl4nMrUVdLcA6iY8xcBvIlueSqls
        IrMfR6F0GHI6nuBbJg09HVsoJI4YVgU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-x1ArTAfuNyO6mavzfsztEw-1; Tue, 10 Oct 2023 20:39:17 -0400
X-MC-Unique: x1ArTAfuNyO6mavzfsztEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10896101A550;
        Wed, 11 Oct 2023 00:39:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC0462029296;
        Wed, 11 Oct 2023 00:39:10 +0000 (UTC)
Date:   Wed, 11 Oct 2023 08:39:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSXuqZNsyjJk1FGX@fedora>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 10, 2023 at 08:45:44AM -1000, Tejun Heo wrote:
> (cc'ing Frederic)
> 
> On Tue, Oct 10, 2023 at 10:22:16PM +0800, Ming Lei wrote:
> > Kernel parameter of `isolcpus=` is used for isolating CPUs for specific
> > task, and user often won't want block IO to disturb these CPUs, also long
> > IO latency may be caused if blk-mq kworker is scheduled on these isolated
> > CPUs.
> > 
> > Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
> > the responsibility should be on wq user.
> > 
> > Add one block layer parameter for not running block kworker on isolated
> > CPUs.
> > 
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Andrew Theurer <atheurer@redhat.com>
> > Cc: Joe Mario <jmario@redhat.com>
> > Cc: Sebastian Jug <sejug@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index ec922c6bccbe..c53b5b522053 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/prefetch.h>
> >  #include <linux/blk-crypto.h>
> >  #include <linux/part_stat.h>
> > +#include <linux/sched/isolation.h>
> >  
> >  #include <trace/events/block.h>
> >  
> > @@ -42,6 +43,13 @@
> >  #include "blk-rq-qos.h"
> >  #include "blk-ioprio.h"
> >  
> > +static bool respect_cpu_isolation;
> > +module_param(respect_cpu_isolation, bool, 0444);
> > +MODULE_PARM_DESC(respect_cpu_isolation,
> > +		"Don't schedule blk-mq worker on isolated CPUs passed in "
> > +		"isolcpus= or nohz_full=. User need to guarantee to not run "
> > +		"block IO on isolated CPUs (default: false)");
> 
> Any chance we can centralize these? It's no fun to try to hunt down module
> params to opt in different subsystems and the housekeeping interface does
> have some provisions for selecting different parts. I'd much prefer to see
> these settings to be collected into a central place.

I guess it is hard to solve in a central place, such as workqueue.

Follows the workqueue API:

/**
   * queue_work_on - queue work on specific cpu
   * @cpu: CPU number to execute work on
   * @wq: workqueue to use
   * @work: work to queue
   *
   * We queue the work to a specific CPU, the caller must ensure it
   * can't go away.  Callers that fail to ensure that the specified
   * CPU cannot go away will execute on a randomly chosen CPU.
   * But note well that callers specifying a CPU that never has been
   * online will get a splat.
   *
   * Return: %false if @work was already on a queue, %true otherwise.
   */
  bool queue_work_on(int cpu, struct workqueue_struct *wq,
                     struct work_struct *work)

The caller specifies one cpu to queue work, what can queue_work_on()
do if the specified CPU is isolated? If the API is changed by dealing
with isolated CPU, the caller has to modify for adapting with the API
change.

Secondly isolated CPUs still can be override by 'taskset -C
$isolated_cpus', that is why I add one blk-mq module parameter,
but the module parameter can be removed, just with two extra effects
if block IOs are submitted from isolated CPUs:

- driver's ->queue_rq() can be queued on other CPU or UNBOUND CPU,
which looks fine

- IO timeout may be triggered during cpu hotplug, but this way had
been long time, maybe not one big deal too.

I appreciate that any specific suggestions about dealing with isolated CPUs
generically for bound WQ can be shared.

Thanks,
Ming

