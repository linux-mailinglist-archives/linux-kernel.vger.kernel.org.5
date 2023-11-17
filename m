Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302ED7EEE67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjKQJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjKQJZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:25:47 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E0ED56;
        Fri, 17 Nov 2023 01:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guXus9uH0FtCWZaDTlKgZ0PR6col0jhDMGMT5oJhEVM=; b=SrKj/vIsYJgpnCM83sG0ipdpJ0
        N0MsKblH+oANZx/KJGb2LUz+KuEqjAdFJSoFDqUktMPYDNZpx3Nn044HkgXDLjRxet8aM8jg4zJ71
        pa/9d46jAhrcGLiMf3nTRJd4LWciONWgjxt0doUoVOh1m+LeE31wOZz4YxBU+jFWCOh2yD+dYv7ha
        fv8+JtjkT3cSeBGEifCEZIOVmQ1/0ByvSlFV3/o66SthRI2xrJ7+y5qa99pgijYfned9S/+Y7YvDR
        oS2IkgkXulz897E8P0Fy5Wo/EluUYw5ekPn1FNsZO1wN/yIcbMhtiJdK2cQvUzGw9+NI2JVZ+0TGb
        3/ARDTOQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3v4I-007B1g-1Z;
        Fri, 17 Nov 2023 09:25:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29F8A300478; Fri, 17 Nov 2023 10:23:18 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:23:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tobias Huschle <huschle@linux.ibm.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, netdev@vger.kernel.org,
        mst@redhat.com, jasowang@redhat.com
Subject: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6 sched/fair: Add
 lag based placement)
Message-ID: <20231117092318.GJ8262@noisy.programming.kicks-ass.net>
References: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b38bc27cc2c480f0c5383366416455@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Your email is pretty badly mangled by wrapping, please try and
reconfigure your MUA, esp. the trace and debug output is unreadable.

On Thu, Nov 16, 2023 at 07:58:18PM +0100, Tobias Huschle wrote:

> The base scenario are two KVM guests running on an s390 LPAR. One guest
> hosts the uperf server, one the uperf client.
> With EEVDF we observe a regression of ~50% for a strburst test.
> For a more detailed description of the setup see the section TEST SUMMARY at
> the bottom.

Well, that's not good :/

> Short summary:
> The mentioned kworker has been scheduled to CPU 14 before the tracing was
> enabled.
> A vhost process is migrated onto CPU 14.
> The vruntimes of kworker and vhost differ significantly (86642125805 vs
> 4242563284 -> factor 20)

So bear with me, I know absolutely nothing about virt stuff. I suspect
there's cgroups involved because shiny or something.

kworkers are typically not in cgroups and are part of the root cgroup,
but what's a vhost and where does it live?

Also, what are their weights / nice values?

> The vhost process wants to wake up the kworker, therefore the kworker is
> placed onto the runqueue again and set to runnable.
> The vhost process continues to execute, waking up other vhost processes on
> other CPUs.
> 
> So far this behavior is not different to what we see on pre-EEVDF kernels.
> 
> On timestamp 576.162767, the vhost process triggers the last wake up of
> another vhost on another CPU.
> Until timestamp 576.171155, we see no other activity. Now, the vhost process
> ends its time slice.
> Then, vhost gets re-assigned new time slices 4 times and gets then migrated
> off to CPU 15.

So why does this vhost stay on the CPU if it doesn't have anything to
do? (I've not tried to make sense of the trace, that's just too
painful).

> This does not occur with older kernels.
> The kworker has to wait for the migration to happen in order to be able to
> execute again.
> This is due to the fact, that the vruntime of the kworker is significantly
> larger than the one of vhost.

That's, weird. Can you add a trace_printk() to update_entity_lag() and
have it print out the lag, limit and vlag (post clamping) values? And
also in place_entity() for the reverse process, lag pre and post scaling
or something.

After confirming both tasks are indeed in the same cgroup ofcourse,
because if they're not, vruntime will be meaningless to compare and we
should look elsewhere.

Also, what HZ and what preemption mode are you running? If kworker is
somehow vastly over-shooting it's slice -- keeps running way past the
avg_vruntime, then it will build up a giant lag and you get what you
describe, next time it wakes up it gets placed far to the right (exactly
where it was when it 'finally' went to sleep, relatively speaking).

> We found some options which sound plausible but we are not sure if they are
> valid or not:
> 
> 1. The wake up path has a dependency on the vruntime metrics that now delays
> the execution of the kworker.
> 2. The previous commit af4cf40470c2 (sched/fair: Add cfs_rq::avg_vruntime)
> which updates the way cfs_rq->min_vruntime and
>     cfs_rq->avg_runtime are set might have introduced an issue which is
> uncovered with the commit mentioned above.

Suppose you have a few tasks (of equal weight) on you virtual timeline
like so:

   ---------+---+---+---+---+------
            ^       ^
	    |       `avg_vruntime
	    `-min_vruntime

Then the above would be more or less the relative placements of these
values. avg_vruntime is the weighted average of the various vruntimes
and is therefore always in the 'middle' of the tasks, and not somewhere
out-there.

min_vruntime is a monotonically increasing 'minimum' that's left-ish on
the tree (there's a few cases where a new task can be placed left of
min_vruntime and its no longer actuall the minimum, but whatever).

These values should be relatively close to one another, depending
ofcourse on the spread of the tasks. So I don't think this is causing
trouble.

Anyway, the big difference with lag based placement is that where
previously tasks (that do not migrate) retain their old vruntime and on
placing they get pulled forward to at least min_vruntime, so a task that
wildly overshoots, but then doesn't run for significant time can still
be overtaken and then when placed again be 'okay'.

Now OTOH, with lag-based placement,  we strictly preserve their relative
offset vs avg_vruntime. So if they were *far* too the right when they go
to sleep, they will again be there on placement.

Sleeping doesn't help them anymore.

Now, IF this is the problem, I might have a patch that helps:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/eevdf&id=119feac4fcc77001cd9bf199b25f08d232289a5c

That branch is based on v6.7-rc1 and then some, but I think it's
relatively easy to rebase the lot on v6.6 (which I'm assuming you're
on).

I'm a little conflicted on the patch, conceptually I like what it does,
but the code it turned into is quite horrible. I've tried implementing
it differently a number of times but always ended up with things that
either didn't work or were worse.

But if it works, it works I suppose.

