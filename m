Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68E7E82ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbjKJTeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjKJTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:47 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EB59E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:16:01 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc394f4cdfso14275055ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699596961; x=1700201761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2HLlZpCoa4EdOVGvKilpnHs++TvH+B1Q4OUUNwocbQ=;
        b=GitwUUqKEDl1Vkh3xc1pHWrcMjppOgjdiptBAVGol2Dsg4EqkRmf1akvIVlRdjcijN
         yF4WVrHMAWxa4NwXUjfH7i5kGOThZsowmtdcx8/JYxm35zcvs/Dbp9W0FCb9TAcptQBm
         9NjpMdrVm6Eoy6IZNYnW7DctpsJI9OJ6qy/IdiBldHIv+rn2pPUgNQ5Gi4F3h4Ug8gi/
         n4gZHseAZVlb3SWnoX8nbVZ3TBHcUwd7fKmhT6pptQSgiNU3C8ND6TZwAV/CYOvrSuwG
         /yANsnmw1/3LKsooh9bUAKAILlzyN5idnPPkUeI1bVAxJIbptLVAyNWVweYhuqgCV7YX
         1pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596961; x=1700201761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2HLlZpCoa4EdOVGvKilpnHs++TvH+B1Q4OUUNwocbQ=;
        b=Vnek75XzC3K+s0UyMl8RAUR8mAlu6V+nulLcRD9+JpQF0Ft9xxzYHTXKGUO3Ud95OS
         NsYkNxDiwP+SRqA2/S4GuZelU6Ijcj5nkLfRIPYNIgWRehbTQb/4uVD6RPzL5KlSoUUg
         7aJbuZL8VE5hde6hpizzdMtBbYCVmZr+nFH71LaJ//4RYCmA26SPbAkTbV+OPK0ajE/1
         hUtkZ7MqD1Nzs6m7krv9ufoGsMlODX+oEc5+rH1Df1p7KnB/hi0/4FPQFnBkOrz7EJsk
         Vn2meN7EIky9aFdnNtUfXyoW/I2p2qQUwZqv+N0Bp5vaOYX90MXUp0gvOGIsXO9/7HVq
         Is0Q==
X-Gm-Message-State: AOJu0Yx70jjSMG4nas+zzSFiF9/6ywwqjEukt6KNUBPy/YSdpWu3OcCV
        V1Bvba/J5kR3SlrJeRMD5uo=
X-Google-Smtp-Source: AGHT+IGEgC95BjHqfvdyTO0U9CPifohVCBlGE4Mpdr705KhV6nL2ylt6HGrCOPKkQXG+g/nJr3fQUg==
X-Received: by 2002:a17:902:d4c5:b0:1c9:ea71:8032 with SMTP id o5-20020a170902d4c500b001c9ea718032mr8010084plg.31.1699596961121;
        Thu, 09 Nov 2023 22:16:01 -0800 (PST)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c8a0879805sm4544899pli.206.2023.11.09.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:16:00 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:15:57 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        npiggin@gmail.com, ebiederm@xmission.com, oleg@redhat.com
Cc:     michael.christie@oracle.com, mark.rutland@arm.com,
        jannh@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] exit: dump thread info on global init exit
Message-ID: <20231110061557.GA58671@rlk>
References: <20231110032043.34516-1-qiwu.chen@transsion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110032043.34516-1-qiwu.chen@transsion.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:20:43AM +0800, chenqiwu wrote:
> Currently, there are various global init exit issues encountered
> on Andriod/linux system. It's hard to debug these issues on product
> environment without a usable coredump, This patch dump the last
> exit thread executable sections and regs to find the exit reason
> before panic.
> 
> Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
> Tested-by: chenqiwu <qiwu.chen@transsion.com>
> ---
>  kernel/exit.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ee9f43bed49a..af2e24bc3ecd 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -13,6 +13,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sched/debug.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/capability.h>
> @@ -806,6 +807,76 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
>  	spin_unlock_irq(&sighand->siglock);
>  }
>  
> +/*
> + * This function only dump thread executable sections to reduce maps space,
> + * since an unhandled falut in user mode is likely generated from code section.
> + */
> +static void dump_thread_maps_info(struct task_struct *tsk)
> +{
> +	struct vm_area_struct *vma;
> +	struct mm_struct *mm = tsk->mm;
> +
> +	if (!mmap_read_trylock(mm))
> +		return;
> +
> +	VMA_ITERATOR(vmi, mm, 0);
> +	pr_info("%s-%d: Dump maps info start\n", tsk->comm, task_pid_nr(tsk));
> +	for_each_vma(vmi, vma) {
> +		struct file *file = vma->vm_file;
> +		int flags = vma->vm_flags;
> +		unsigned long long pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
> +
> +		if (file) {
> +			if (flags & VM_EXEC) {
> +				char tpath[256] = {0};
> +				char *pathname = d_path(&file->f_path, tpath, sizeof(tpath));
> +
> +				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
> +					vma->vm_start, vma->vm_end,
> +					flags & VM_READ ? 'r' : '-',
> +					flags & VM_WRITE ? 'w' : '-',
> +					flags & VM_EXEC ? 'x' : '-',
> +					flags & VM_MAYSHARE ? 's' : 'p',
> +					pgoff, pathname);
> +			}
> +		} else {
> +			const char *name = arch_vma_name(vma);
> +
> +			if (!name) {
> +				struct mm_struct *mm = vma->vm_mm;
> +
> +				if (mm) {
> +					if (vma_is_initial_heap(vma))
> +						name = "[heap]";
> +					else if (vma_is_initial_stack(vma))
> +						name = "[stack]";
> +				} else {
> +					name = "[vdso]";
> +				}
> +			}
> +
> +			if (name && (flags & VM_EXEC)) {
> +				pr_info("%08lx-%08lx %c%c%c%c %08llx %s\n",
> +					vma->vm_start, vma->vm_end,
> +					flags & VM_READ ? 'r' : '-',
> +					flags & VM_WRITE ? 'w' : '-',
> +					flags & VM_EXEC ? 'x' : '-',
> +					flags & VM_MAYSHARE ? 's' : 'p', pgoff, name);
> +			}
> +		}
> +	}
> +	mmap_read_unlock(mm);
> +	pr_info("%s-%d: Dump maps info end\n", tsk->comm, task_pid_nr(tsk));
> +}
> +
> +static void dump_thread_info(struct task_struct *tsk)
> +{
> +	struct pt_regs *regs = task_pt_regs(tsk);
> +
> +	dump_thread_maps_info(tsk);
> +	show_regs(regs);
> +}
> +
>  void __noreturn do_exit(long code)
>  {
>  	struct task_struct *tsk = current;
> @@ -833,12 +904,14 @@ void __noreturn do_exit(long code)
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
>  		/*
> -		 * If the last thread of global init has exited, panic
> -		 * immediately to get a useable coredump.
> +		 * If the last thread of global init has exited, dump
> +		 * some usable information before panic.
>  		 */
> -		if (unlikely(is_global_init(tsk)))
> +		if (unlikely(is_global_init(tsk))) {
> +			dump_thread_info(tsk);
>  			panic("Attempted to kill init! exitcode=0x%08x\n",
>  				tsk->signal->group_exit_code ?: (int)code);
> +		}
>  
>  #ifdef CONFIG_POSIX_TIMERS
>  		hrtimer_cancel(&tsk->signal->real_timer);
> -- 
> 2.25.1
>

Add oleg for reviewer.
