Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D78052F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbjLELd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjLELdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:33:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1F359D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:25:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F30C433C8;
        Tue,  5 Dec 2023 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701775546;
        bh=CQUl6r/F98hCTeMx55KAWTeoJgu07gUHwR1xWmX6yNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLTebRxv/4gpihnvL89VfqlKXgGVT9mpg728cZCElhYBOWfXoHzvqAWGR8qHsA8SB
         GiS9izQ36sJktd/h0Y+gxlXMzScaBSAwYZc1fxyjNlzyJHhz8VOrz2tvWFaD0z25bP
         XfKQnOR2AEBm0kTW6Kx8RermVgftIxkekpMK24yTi49GcqcoRPnhGoftXfwmRaXgT7
         HG14m4vIIuG0Toql56xk1XWi3qEy9WxQFumRceDrBrDepdoXuLKpt2HgTjdtQkJOUt
         HtS9WEtsIiNe2LDRE6+6xI8k9DllWdIRajQbwfmJMp6tPp2cHT3usI+vpX9E0wm/hY
         0nz86682GBIdw==
Date:   Tue, 5 Dec 2023 12:25:40 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231205-simpel-anfragen-71ac550a80fe@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-2-neilb@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:36:41PM +1100, NeilBrown wrote:
> User-space processes always call task_work_run() as needed when
> returning from a system call.  Kernel-threads generally do not.
> Because of this some work that is best run in the task_works context
> (guaranteed that no locks are held) cannot be queued to task_works from
> kernel threads and so are queued to a (single) work_time to be managed
> on a work queue.
> 
> This means that any cost for doing the work is not imposed on the kernel
> thread, and importantly excessive amounts of work cannot apply
> back-pressure to reduce the amount of new work queued.
> 
> I have evidence from a customer site when nfsd (which runs as kernel
> threads) is being asked to modify many millions of files which causes
> sufficient memory pressure that some cache (in XFS I think) gets cleaned
> earlier than would be ideal.  When __dput (from the workqueue) calls
> __dentry_kill, xfs_fs_destroy_inode() needs to synchronously read back
> previously cached info from storage.  This slows down the single thread
> that is making all the final __dput() calls for all the nfsd threads
> with the net result that files are added to the delayed_fput_list faster
> than they are removed, and the system eventually runs out of memory.
> 
> This happens because there is no back-pressure: the nfsd isn't forced to
> slow down when __dput() is slow for any reason.  To fix this we can
> change the nfsd threads to call task_work_run() regularly (much like
> user-space processes do) and allow it to declare this so that work does
> get queued to task_works rather than to a work queue.
> 
> This patch adds a new process flag PF_RUNS_TASK_WORK which is now used
> instead of PF_KTHREAD to determine whether it is sensible to queue
> something to task_works.  This flag is always set for non-kernel threads.
> 
> task_work_run() is also exported so that it can be called from a module
> such as nfsd.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

The thing that bugs me the most about this is that we expose task work
infrastructure to modules which I think is a really bad idea. File
handling code brings so many driver to their knees and now we're handing
them another footgun.

I'm not per se opposed to all of this but is this really what the other
NFS maintainers want to switch to as well? And is this really that badly
needed and that common that we want to go down that road? I wouldn't
mind not having to do all this if we can get by via other means.

>  fs/file_table.c       | 3 ++-
>  fs/namespace.c        | 2 +-
>  include/linux/sched.h | 2 +-
>  kernel/fork.c         | 2 ++
>  kernel/task_work.c    | 1 +
>  5 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index ee21b3da9d08..d36cade6e366 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -435,7 +435,8 @@ void fput(struct file *file)
>  	if (atomic_long_dec_and_test(&file->f_count)) {
>  		struct task_struct *task = current;
>  
> -		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> +		if (likely(!in_interrupt() &&
> +			   (task->flags & PF_RUNS_TASK_WORK))) {
>  			init_task_work(&file->f_rcuhead, ____fput);
>  			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
>  				return;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e157efc54023..46d640b70ca9 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1328,7 +1328,7 @@ static void mntput_no_expire(struct mount *mnt)
>  
>  	if (likely(!(mnt->mnt.mnt_flags & MNT_INTERNAL))) {
>  		struct task_struct *task = current;
> -		if (likely(!(task->flags & PF_KTHREAD))) {
> +		if (likely((task->flags & PF_RUNS_TASK_WORK))) {
>  			init_task_work(&mnt->mnt_rcu, __cleanup_mnt);
>  			if (!task_work_add(task, &mnt->mnt_rcu, TWA_RESUME))
>  				return;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 77f01ac385f7..e4eebac708e7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1747,7 +1747,7 @@ extern struct pid *cad_pid;
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF__HOLE__00800000	0x00800000
> +#define PF_RUNS_TASK_WORK	0x00800000	/* Will call task_work_run() periodically */

The flag seems better to me than just relying on exit_work as itt's
easier to reason about.

>  #define PF__HOLE__01000000	0x01000000
>  #define PF__HOLE__02000000	0x02000000
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3b6d20dfb9a8..d612d8f14861 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2330,6 +2330,8 @@ __latent_entropy struct task_struct *copy_process(
>  	p->flags &= ~PF_KTHREAD;
>  	if (args->kthread)
>  		p->flags |= PF_KTHREAD;
> +	else
> +		p->flags |= PF_RUNS_TASK_WORK;
>  	if (args->user_worker) {
>  		/*
>  		 * Mark us a user worker, and block any signal that isn't
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index 95a7e1b7f1da..aec19876e121 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -183,3 +183,4 @@ void task_work_run(void)
>  		} while (work);
>  	}
>  }
> +EXPORT_SYMBOL(task_work_run);
> -- 
> 2.43.0
> 
