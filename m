Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B632D7977E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjIGQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbjIGQgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEE13A87
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694104446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6pBZs/c9Y6NCYTrCpyNIhqrYSKpcMzWZkZzIdnppgZc=;
        b=MN+m3cmMuS6LHGLRJs5W9K3X98EBYIDGgJybqEwWFtu2WUqvTYtZIbbvHIg7TZCAguGOM5
        SglytvkDVxjTosL4c8Tr+puF0W+ziPh+ODMxRRtUXJQ9PeU+xiDyP63xOe3ODKQaV8OYAA
        9VXN4dlReeMwiWMpw9GVkdQPUnQxHwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-z7u1wnX4NvKaT5Syx2brzA-1; Thu, 07 Sep 2023 10:17:11 -0400
X-MC-Unique: z7u1wnX4NvKaT5Syx2brzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 743C694B521;
        Thu,  7 Sep 2023 14:17:10 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.194.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C7111460FE5;
        Thu,  7 Sep 2023 14:17:06 +0000 (UTC)
Date:   Thu, 7 Sep 2023 10:17:03 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix nohz_full vs rt bandwidth
Message-ID: <20230907141703.GA441901@lorien.usersys.redhat.com>
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
 <1823b6fd-037f-38dc-2d33-0879d77768c3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1823b6fd-037f-38dc-2d33-0879d77768c3@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On Wed, Sep 06, 2023 at 02:45:39PM +0800 Hao Jia wrote:
> 
> Friendly ping...
> 
> On 2023/8/21 Hao Jia wrote:
> > Since the commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop
> > when cfs bandwidth in use") was merged, it handles conflicts between
> > NOHZ full and cfs_bandwidth well, and the scheduler feature HZ_BW
> > allows us to choose which one to prefer.
> > 
> > This conflict also exists between NOHZ full and rt_bandwidth,
> > these two patches try to handle it in a similar way.
> >

Are you actually hitting this in the real world?

We, for example, no longer enable RT_GROUP_SCHED so this is a non-issue
for our use cases.  I'd recommend considering that. (Does it even
work with cgroup2?)

In some ways what you have is a simplification of code, but it also
obfuscates the stop_tick conditions by hiding them all in the class
specific functions.  It was easier to see why the tick didn't stop
looking at the original code.

It would be better to do this only if it is really needed, in my opinion.


Cheers,
Phil

> > patch1: Extracts a can_stop_tick() callback function for each
> > sched_class from sched_can_stop_tick(), it will make things clearer
> > and also convenient to handle the conflict between NOHZ full
> > and rt_bandwidth.
> > 
> > patch2: If the HZ_BW scheduler feature is enabled, and the RT task
> > to be run is constrained by rt_bandwidth runtime. Then it will
> > prevent NO_HZ full from stopping tick.
> > 
> > Hao Jia (2):
> >    sched/core: Introduce sched_class::can_stop_tick()
> >    sched/rt: Block nohz tick_stop when rt bandwidth in use
> > 
> >   kernel/sched/core.c     | 67 +++++--------------------------
> >   kernel/sched/deadline.c | 16 ++++++++
> >   kernel/sched/fair.c     | 56 +++++++++++++++++++++++---
> >   kernel/sched/rt.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
> >   kernel/sched/sched.h    |  5 ++-
> >   5 files changed, 168 insertions(+), 65 deletions(-)
> > 
> 

-- 

