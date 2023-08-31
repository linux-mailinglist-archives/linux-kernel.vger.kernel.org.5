Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9E78E7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbjHaIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjHaIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0219A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693469730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8MlZdnaiAdZ4cakYlJruX/gxcGJziK5klvRHpw3VpE=;
        b=ZWrmEBjSD1fQSG9qbURK83ACqUz6VyyjVIkR+tJDxASUwYBjKFepk1/+W4616CaquBMQ3o
        dRCVKUBaYmFcig1FYS3TE7nM8QCCjUEbRb0FzsmeDmE383fsv2qDxTYLDwDuLRrNeR9mU+
        9mU+JoMKF/1mDGQj3dKKJpwJQbZYVQ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-PR_aoCsnN9qO8bp-awPALg-1; Thu, 31 Aug 2023 04:15:26 -0400
X-MC-Unique: PR_aoCsnN9qO8bp-awPALg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9F3B8022E4;
        Thu, 31 Aug 2023 08:15:25 +0000 (UTC)
Received: from fedora (unknown [10.72.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC792026D35;
        Thu, 31 Aug 2023 08:15:19 +0000 (UTC)
Date:   Thu, 31 Aug 2023 16:15:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
Message-ID: <ZPBLy41y0NQTJ6Bw@fedora>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
 <87edjk5st8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edjk5st8.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Wed, Aug 30, 2023 at 07:44:03PM +0200, Thomas Gleixner wrote:
> Ming!
> 
> On Fri, Aug 18 2023 at 22:01, Ming Lei wrote:
> 
> > group_cpus_evenly() could be part of storage driver's error handler,
> > such as nvme driver, when may happen during CPU hotplug, in which
> > storage queue has to drain its pending IOs because all CPUs associated
> > with the queue are offline and the queue is becoming inactive. And
> > handling IO needs error handler to provide forward progress.
> >
> > Then dead lock is caused:
> >
> > 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> > handler is waiting for inflight IO
> >
> > 2) error handler is waiting for CPU hotplug lock
> >
> > 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> > error handling can't provide forward progress.
> >
> > Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> > in which two stage spreads are taken: 1) the 1st stage is over all present
> > CPUs; 2) the end stage is over all other CPUs.
> 
> That solves the deadlock, but makes the code racy against a concurrent
> hot-add operation which modifies cpu_present_mask. IOW, it introduces a
> data race.

Good catch, we can annotate it with data_race(), and I think here the
readonly access to cpu_present_mask is fine, and we have many such usage,
such as for_each_present_cpu().

> 
> The changelog does not explain why this does not matter nor does the
> comment.

OK, I will document the change, such as:

There isn't difference compared with holding cpu hotplug lock, because the cpu
hp state is always changed even though cpu_present_mask isn't updated
with the lock. And all CPUs are always covered during the spread, the difference
is just that it is done in 1st stage or 2nd stage.

If you don't object, I will post next version with above change.


Thanks,
Ming

