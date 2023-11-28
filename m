Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725E7FC193
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbjK1Pda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbjK1Pd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:33:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7B10CA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:33:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3783C433C7;
        Tue, 28 Nov 2023 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701185615;
        bh=LP3/JrPMcXVHdKgGdEW2PdVSDBoPRklTTWAdvXXRacM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIOb7azmwB9qpwQ8aXOLFY9U6HUlbTlDZOGeKaFQfdoOe3u73Q9C7yRWL3acgmAWW
         mU0dLxM4ZQdA4cU7OUvmz4hJHUG/PCcE5yQd3M8AWLPL1V5VhHIrcktaBuU//JM70I
         RiyRXyO7Pq/awXUYVCWFASqVTWtQ0OHZo3xy53N1xqSW24j5xt0+eOfoYZdgvJxBMI
         RITbuRBRQmus+g7k/oiAt3RLyISMxTPvidyOTtUxqds++hVKRrj1KPZxUoD8i9xHPG
         ed91PM0qAcJNuDLrXRTE6mscGp2LRsVYPjuhXKIQDm4yVCfcTLW69aclk01XtrPcsW
         A7W7L+nEqsH6g==
Date:   Tue, 28 Nov 2023 16:33:28 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231128-elastisch-freuden-f9de91041218@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <20231128-arsch-halbieren-b2a95645de53@brauner>
 <20231128135258.GB22743@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128135258.GB22743@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:52:59PM +0100, Oleg Nesterov wrote:
> On 11/28, Christian Brauner wrote:
> >
> > Should be simpler if you invert the logic?
> >
> > COMPLETELY UNTESTED
> 
> Agreed, this looks much better to me. But perhaps we can just add the new
> PF_KTHREAD_XXX flag and change fput
> 
> 
> 	--- a/fs/file_table.c
> 	+++ b/fs/file_table.c
> 	@@ -445,7 +445,8 @@ void fput(struct file *file)
> 		if (atomic_long_dec_and_test(&file->f_count)) {
> 			struct task_struct *task = current;
> 	 
> 	-		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> 	+		if (likely(!in_interrupt() &&
> 	+		    task->flags & (PF_KTHREAD|PF_KTHREAD_XXX) != PF_KTHREAD) {
> 				init_task_work(&file->f_rcuhead, ____fput);
> 				if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
> 					return;
> 
> ?
> 
> Then nfsd() can simply set PF_KTHREAD_XXX. This looks even simpler to me.

Yeah, I had played with that as well. Only reason I didn't do it was to
avoid a PF_* flag. If that's preferable it might be worth to just add
PF_TASK_WORK and decouple this from PF_KTHREAD. kthread creation and
userspace process creation are all based on the same struct
kernel_clone_args for a while now ever since we added this for clone3()
so we catch everything in copy_process():

diff --git a/fs/file_table.c b/fs/file_table.c
index 6deac386486d..5d3eb5ef4fc7 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -437,7 +437,7 @@ void fput(struct file *file)
                        file_free(file);
                        return;
                }
-               if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
+               if (likely(!in_interrupt() && (task->flags & PF_TASK_WORK))) {
                        init_task_work(&file->f_rcuhead, ____fput);
                        if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
                                return;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..8dfc06acc6a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1755,7 +1755,7 @@ extern struct pid *cad_pid;
                                                 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD             0x00200000      /* I am a kernel thread */
 #define PF_RANDOMIZE           0x00400000      /* Randomize virtual address space */
-#define PF__HOLE__00800000     0x00800000
+#define PF_TASK_WORK           0x00800000
 #define PF__HOLE__01000000     0x01000000
 #define PF__HOLE__02000000     0x02000000
 #define PF_NO_SETAFFINITY      0x04000000      /* Userland is not allowed to meddle with cpus_mask */
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..2604235c800f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2346,6 +2346,14 @@ __latent_entropy struct task_struct *copy_process(
        if (args->io_thread)
                p->flags |= PF_IO_WORKER;

+       /*
+        * By default only non-kernel threads can use task work. Kernel
+        * threads that manage task work explicitly can add that flag in
+        * their kthread callback.
+        */
+       if (!args->kthread)
+               p->flags |= PF_TASK_WORK;
+
        if (args->name)
                strscpy_pad(p->comm, args->name, sizeof(p->comm));

