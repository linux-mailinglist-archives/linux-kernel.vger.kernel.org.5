Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0415E757C59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjGRM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjGRM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509851B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689685085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItfF9BAoZCUcd1RLcTAQqHuRpA2rpdDfS5zixcXLgYY=;
        b=adI4kR7se0wWDlVEOXKyOEFw4qD0CNP/11Y/Jt4xFdk8KnGcxZwpeEA+9sDZGy3N3TO8oF
        QMJJts9YDGvhHqzLMHdW4ZTAl3MeSfA1A2qslRLu76owfNYow0yyig1YhfFHqOTD+RPILJ
        5MabbaRUbZO8tozgC/UGLSXpZpo49EE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-tb-lb0aNOoODxxwVESZ8Bw-1; Tue, 18 Jul 2023 08:58:02 -0400
X-MC-Unique: tb-lb0aNOoODxxwVESZ8Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2C822999B21;
        Tue, 18 Jul 2023 12:58:01 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0900E40C206F;
        Tue, 18 Jul 2023 12:58:00 +0000 (UTC)
Date:   Tue, 18 Jul 2023 08:57:59 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <20230718125759.GA126587@lorien.usersys.redhat.com>
References: <xm268rbkg4tg.fsf@google.com>
 <20230714125746.812891-1-pauld@redhat.com>
 <ZLWIDC2nlG8cb3VE@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLWIDC2nlG8cb3VE@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 08:27:24AM -1000 Tejun Heo wrote:
> On Fri, Jul 14, 2023 at 08:57:46AM -0400, Phil Auld wrote:
> > In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> > groups due to the previous fix simply taking the min.  It should
> > reflect a limit imposed at that level or by an ancestor. Even
> > though cgroupv2 does not require child quota to be less than or
> > equal to that of its ancestors the task group will still be
> > constrained by such a quota so this should be shown here. Cgroupv1
> > continues to set this correctly.
> > 
> > In both cases, add initialization when a new task group is created
> > based on the current parent's value (or RUNTIME_INF in the case of
> > root_task_group). Otherwise, the field is wrong until a quota is
> > changed after creation and __cfs_schedulable() is called.
> > 
> > Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
> 
> Does this really fix anything observable? I wonder whether this is more
> misleading than helpful. In cgroup2, the value simply wasn't being used,
> right?
>

It wasn't being used but was actively being set wrong. I mean if we are
going to bother doing the __cfs_schedulable() tg tree walk we might as
well have not been setting a bogus value. But that said, no it was not
observable until I tried to use it.

I'm fine if that's dropped. I just wanted it set right going forward :)


> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Reviewed-by: Ben Segall <bsegall@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
>

Thanks!


> > +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> > +		 * inherit when no limit is set. In both cases this is used
> > +		 * by the scheduler to determine if a given CFS task has a
> > +		 * bandwidth constraint at some higher level.
> 
> The discussion on this comment is stretching too long and this is fine too
> but what's worth commenting for cgroup2 is that the limit value itself
> doesn't mean anything and we're just latching onto the value used by cgroup1
> to track whether there's any limit active or not.

I thought that was implied by the wording. "If a given task has a bandwidth
contraint" not "what a given task's bandwidth constraint is".  In both cases
that's how the other parts of the scheduler are using it. The actual
non-RUNTIME_INF value only matters in this function (and only for cgroup1
indeed).

But... the value is just as accurate for cgroup2 and cgroup1.  The task is
still going to be limited by that bandwidth constraint even if its own
bandwidth limit is nominally higher, right? 


Cheers,
Phil

> 
> Thanks.
> 
> -- 
> tejun
> 

-- 

