Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717C7D8579
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbjJZPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbjJZPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:03:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20C129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9JXxaYRYmSkXZPyr8is9yL820vMXmViHhclzJzT9u/0=; b=gBpFbiWzvbN93E3gafQXCGxQBO
        ZSRav/VBD5HLDT8ZoEjvC6BQx9M8rOSPOl3QEL2PxZUica4i+xwjVcn61jv2Jx2gZfK1q0foO3Lo3
        Oiypa5M9U9YPf+fSJx49QNhrGHCSW4bZi3PDLdVfh1eP6sabdCH0WNYIoW/iplHVq31ZtUdXFe7ir
        M3edVB7Rp+rv3K3V2yPu3pG8/v0iWRs7lui6RKLdd0ZNHVXDWnwfwcoWsFCYKh/FqvZzvC+1EZKja
        L1LFoF4WrZX2K+RdI3adZpZsKsMB/6MVURIeoSKdNGqSQp5dSTJxdSHyuYxycLNdlEagrQyB+NcXP
        hHT0qaPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qw1tP-00HPi2-0s;
        Thu, 26 Oct 2023 15:03:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9257300473; Thu, 26 Oct 2023 17:03:26 +0200 (CEST)
Date:   Thu, 26 Oct 2023 17:03:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>
Cc:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Oleg Nesterov <oleg@redhat.com>, dhowells@redhat.com
Subject: Re: [PATCH] Fixing directly deferencing a __rcu pointer warning
Message-ID: <20231026150326.GA33303@noisy.programming.kicks-ass.net>
References: <20231025165002.64ab92e6d55d204b66e055f4@linux-foundation.org>
 <20231026122748.359162-1-singhabhinav9051571833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026122748.359162-1-singhabhinav9051571833@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


$Subject should indicate a subsystem, also you seem to have a somewhat
random collection of Cc. It looks like dhowells is the cred guy and he's
not on.

On Thu, Oct 26, 2023 at 05:57:48PM +0530, Abhinav Singh wrote:
> This patch fixes the warning about directly dereferencing a pointer
> tagged with __rcu annotation.
> 
> Dereferencing the pointers tagged with __rcu directly should
> always be avoided according to the docs. There is a rcu helper
> functions rcu_dereference(...) to use when dereferencing a __rcu
> pointer. This functions returns the non __rcu tagged pointer which
> can be dereferenced just like a normal pointers.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>  kernel/fork.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 10917c3e1f03..802b7bbe3d92 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2369,7 +2369,7 @@ __latent_entropy struct task_struct *copy_process(
>  
>  	retval = -EAGAIN;
>  	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> -		if (p->real_cred->user != INIT_USER &&
> +		if (rcu_dereference(p->real_cred)->user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_cleanup_count;
>  	}

This seems entirely misguided and only makes the code more confusing.

AFAICT at this point @p is not life, we're constructing the new task,
but it's not yet published, therefore no concurrency possible.
Additionally we're not actually in an RCU critical section afaict.

> @@ -2692,7 +2692,7 @@ __latent_entropy struct task_struct *copy_process(
>  			 */
>  			p->signal->has_child_subreaper = p->real_parent->signal->has_child_subreaper ||
>  							 p->real_parent->signal->is_child_subreaper;
> -			list_add_tail(&p->sibling, &p->real_parent->children);
> +			list_add_tail(&p->sibling, &(rcu_dereference(p->real_parent)->children));
>  			list_add_tail_rcu(&p->tasks, &init_task.tasks);
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);

As to the real_parent, we hold the tasklist lock, which is the write
side lock for parent stuff, so rcu dereference is pointless here.
