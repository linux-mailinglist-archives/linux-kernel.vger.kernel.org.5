Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3E7E7FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjKJR5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjKJR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA486B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699602595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5L2aqjLIoZxvW1FDJ447KWQRslmns4QdSgUBHFpwClQ=;
        b=Leuvvr3A1/blmlSouEeCQQNM7gsg6zOZg2KzTOlAe9nog5uwLc3O2gJ6Pg76jfvOc86D+k
        eSQqUVsCxUngGaqm/RwQl7R8643SsCnnnkMXNFonrD4JUUHgVLH9qsx+wYQbsbvQGV5nC5
        cnRiMOZazZxv0C9n0+oTg3DDe5ToT44=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-7416gLsYPw6dwMacXBChlA-1; Fri,
 10 Nov 2023 02:49:51 -0500
X-MC-Unique: 7416gLsYPw6dwMacXBChlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F6B628EC10F;
        Fri, 10 Nov 2023 07:49:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.27])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43F9D2166B26;
        Fri, 10 Nov 2023 07:49:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 Nov 2023 08:48:48 +0100 (CET)
Date:   Fri, 10 Nov 2023 08:48:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        npiggin@gmail.com, ebiederm@xmission.com,
        michael.christie@oracle.com, mark.rutland@arm.com,
        jannh@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] exit: dump thread info on global init exit
Message-ID: <20231110074844.GB7768@redhat.com>
References: <20231110032043.34516-1-qiwu.chen@transsion.com>
 <20231110061557.GA58671@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110061557.GA58671@rlk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10, chenqiwu wrote:
>
> On Fri, Nov 10, 2023 at 11:20:43AM +0800, chenqiwu wrote:
> > Currently, there are various global init exit issues encountered
> > on Andriod/linux system. It's hard to debug these issues on product
> > environment without a usable coredump, This patch dump the last
> > exit thread executable sections and regs to find the exit reason
> > before panic.

Again, I am not going to comment the intent. I agree that the more info
the better, but I think someone else should ack this patch.

However. I won't argue, but somehow I can't say I really like it ;)
Can you look at panic_print_sys_info() called by panic() ?
Perhaps it makes more sense to introduce another PANIC_PRINT_XXX
option for dump_thread_maps_info() ?

To me it would be more clean/consistent wrt other info panic() reports.

Oleg.

> >
> > Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> > Tested-by: chenqiwu <qiwu.chen@transsion.com>
> > ---
> >  kernel/exit.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 76 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index ee9f43bed49a..af2e24bc3ecd 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/sched/task.h>
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/sched/cputime.h>
> > +#include <linux/sched/debug.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/capability.h>
> > @@ -806,6 +807,76 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
> >  	spin_unlock_irq(&sighand->siglock);
> >  }
> >
> > +/*
> > + * This function only dump thread executable sections to reduce maps space,
> > + * since an unhandled falut in user mode is likely generated from code section.
> > + */
> > +static void dump_thread_maps_info(struct task_struct *tsk)
> > +{
> > +	struct vm_area_struct *vma;
> > +	struct mm_struct *mm = tsk->mm;
> > +
> > +	if (!mmap_read_trylock(mm))
> > +		return;
> > +
> > +	VMA_ITERATOR(vmi, mm, 0);
> > +	pr_info("%s-%d: Dump maps info start\n", tsk->comm, task_pid_nr(tsk));
> > +	for_each_vma(vmi, vma) {
> > +		struct file *file = vma->vm_file;
> > +		int flags = vma->vm_flags;
> > +		unsigned long long pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> > +
> > +		if (file) {
> > +			if (flags & VM_EXEC) {
> > +				char tpath[256] = {0};
> > +				char *pathname = d_path(&file->f_path, tpath, sizeof(tpath));
> > +
> > +				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
> > +					vma->vm_start, vma->vm_end,
> > +					flags & VM_READ ? 'r' : '-',
> > +					flags & VM_WRITE ? 'w' : '-',
> > +					flags & VM_EXEC ? 'x' : '-',
> > +					flags & VM_MAYSHARE ? 's' : 'p',
> > +					pgoff, pathname);
> > +			}
> > +		} else {
> > +			const char *name = arch_vma_name(vma);
> > +
> > +			if (!name) {
> > +				struct mm_struct *mm = vma->vm_mm;
> > +
> > +				if (mm) {
> > +					if (vma_is_initial_heap(vma))
> > +						name = "[heap]";
> > +					else if (vma_is_initial_stack(vma))
> > +						name = "[stack]";
> > +				} else {
> > +					name = "[vdso]";
> > +				}
> > +			}
> > +
> > +			if (name && (flags & VM_EXEC)) {
> > +				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
> > +					vma->vm_start, vma->vm_end,
> > +					flags & VM_READ ? 'r' : '-',
> > +					flags & VM_WRITE ? 'w' : '-',
> > +					flags & VM_EXEC ? 'x' : '-',
> > +					flags & VM_MAYSHARE ? 's' : 'p', pgoff, name);
> > +			}
> > +		}
> > +	}
> > +	mmap_read_unlock(mm);
> > +	pr_info("%s-%d: Dump maps info end\n", tsk->comm, task_pid_nr(tsk));
> > +}
> > +
> > +static void dump_thread_info(struct task_struct *tsk)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(tsk);
> > +
> > +	dump_thread_maps_info(tsk);
> > +	show_regs(regs);
> > +}
> > +
> >  void __noreturn do_exit(long code)
> >  {
> >  	struct task_struct *tsk = current;
> > @@ -833,12 +904,14 @@ void __noreturn do_exit(long code)
> >  	group_dead = atomic_dec_and_test(&tsk->signal->live);
> >  	if (group_dead) {
> >  		/*
> > -		 * If the last thread of global init has exited, panic
> > -		 * immediately to get a useable coredump.
> > +		 * If the last thread of global init has exited, dump
> > +		 * some usable information before panic.
> >  		 */
> > -		if (unlikely(is_global_init(tsk)))
> > +		if (unlikely(is_global_init(tsk))) {
> > +			dump_thread_info(tsk);
> >  			panic("Attempted to kill init! exitcode=0x%08x\n",
> >  				tsk->signal->group_exit_code ?: (int)code);
> > +		}
> >
> >  #ifdef CONFIG_POSIX_TIMERS
> >  		hrtimer_cancel(&tsk->signal->real_timer);
> > --
> > 2.25.1
> >
>
> Add oleg for reviewer.
>

