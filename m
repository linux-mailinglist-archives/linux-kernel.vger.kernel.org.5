Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5687B7A6477
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjISNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjISNKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:10:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7B8F4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QXs2a8eD9JuWpImPXplS7bjZ/mwT38MbbloUG5yxoO8=; b=h+4gkjE20ihoPRya6zT4bK2QOd
        0xJnoF3tC+jloVqHO9zirAV51Xfz8+zrpxblMIC31odnAtrzQfDh/OdkC0S4UwLyVMbMNOCvIjODK
        fLaSJaSLtknwmDMs+R5OT4iMkKUbmZw8AE8IXa9v5UtZwhz4S6dGaUCSRbgHvojXdPdKwbYUt7a8L
        lD4owL+V3UjBrDLo+seEZKvBLHAlm0Dp9pj65XAwx6jn8pzzAj+Bkp3yWKItUVximTukyvXwI0Czg
        u6jxmKJ8d87cnXUfIZg2ngwXHLTwhpEshnsdWEJQOUaMXio2ZZtQ0t9/TnU2GieDz8CEfoXvZcnHV
        uOOgHesg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiaUv-00DcZW-0H;
        Tue, 19 Sep 2023 13:10:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31375300585; Tue, 19 Sep 2023 15:10:38 +0200 (CEST)
Date:   Tue, 19 Sep 2023 15:10:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230919131038.GC39346@noisy.programming.kicks-ass.net>
References: <CACMJSevZQgik7S-62fz9H7+Mib+W0CgYMV4GyWjYV7N_E6iHVQ@mail.gmail.com>
 <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
 <20230915221332.GC23174@noisy.programming.kicks-ass.net>
 <20230919125752.GA39346@noisy.programming.kicks-ass.net>
 <20230919125954.GB39346@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919125954.GB39346@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 02:59:54PM +0200, Peter Zijlstra wrote:


> +	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {
>  
> +		scoped_guard (task_lock, task) {
> +			retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +			if (retval)
> +				return retval;
> +		}
>  
> +		scoped_guard (write_lock, &tasklist_lock) {
> +			if (unlikely(task->exit_state))
> +				return -EPERM;
> +			if (task->ptrace)
> +				return -EPERM;
>  
> +			task->ptrace = flags;
>  
> +			ptrace_link(task, current);
> +
> +			/* SEIZE doesn't trap tracee on attach */
> +			if (!seize)
> +				send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
> +
> +			ptrace_set_stopped(task);
> +
> +		}
> +
> +		goto success;
>  	}
> +	return -ERESTARTNOINTR;
>  
> +success:
> +	/*
> +	 * We do not bother to change retval or clear JOBCTL_TRAPPING
> +	 * if wait_on_bit() was interrupted by SIGKILL. The tracer will
> +	 * not return to user-mode, it will exit and clear this bit in
> +	 * __ptrace_unlink() if it wasn't already cleared by the tracee;
> +	 * and until then nobody can ptrace this task.
> +	 */
> +	wait_on_bit(&task->jobctl, JOBCTL_TRAPPING_BIT, TASK_KILLABLE);
> +	proc_ptrace_connector(task, PTRACE_ATTACH);
> +
> +	return 0;

This isn't exactly nice..

I tried something like:

	scoped_cond_guard (mutex_intr, return -EINTR, &task->signal->cred_guard_mutex) {
		...
	}

Which I can make work, but then I also tried to capture my other case:

	scoped_cond_guard (rwsem_down_intr, if (task) return -EINTR,
			   task ? &task->signal->exec_guard_mutex : NULL)  {

		...
	}

But I can't get that to work because of that extra if, the not case
doesn't fall through and do the body.

Anyway, I'll poke more..
