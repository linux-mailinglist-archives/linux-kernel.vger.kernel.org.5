Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB79790D97
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 20:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345958AbjICSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjICSyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:54:50 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE21EC6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 11:54:46 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-26f3975ddd4so555179a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 11:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693767286; x=1694372086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uobh8XOdAdzG9jTmIoYvamtEQeDJRuQ6vuNi/kysB0=;
        b=LEvqZlx0Gm1evoEDaTEYKXdBJHJAJ4STLC+rLeI9TtSbRWrX77LYKkO/mFwiz27Df2
         0EVHMpRUvi3WoeZ6BY3BhIHlyXDAcr1//C448fi3Am0i8R9XyZQXd79oucGo/Y0RGTJr
         Zvl7ptIgQx3WagI/yJT3RCtOVBkrwedwHlMwDS1ZMYt2cXwpjz/D+wJa4Uxt+TWIXbyG
         zDEKSTKCnvxnfzJXHblInBVUEcNBjNpBjaLdbJg0iLtShWTlFwCAhLppPXFECAywklmS
         X/gxF3aw71AQiY2s2ET7DMd4GqLe68g/7aHSCcl6mlV+Hm+gXzSsNbqCY6dwf9z87mSX
         i4Jw==
X-Gm-Message-State: AOJu0YySVW88K1wS0/tIOMZce1Cf0jeFJYgRFgGMjnMRN7vkYWlfTmwO
        YxASNnaiBdM80GmF0DrwdN8=
X-Google-Smtp-Source: AGHT+IEvDzVBuoYAo/IUw4eBq2hBZddKriSGhMOPA07yEr7FYhMImh/JH62zIzqw9X64SbVMgnwH9Q==
X-Received: by 2002:a17:90a:9c06:b0:263:72fe:3ef7 with SMTP id h6-20020a17090a9c0600b0026372fe3ef7mr7232328pjp.42.1693767286023;
        Sun, 03 Sep 2023 11:54:46 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.215])
        by smtp.gmail.com with ESMTPSA id gv9-20020a17090b11c900b0026f39c90111sm6149632pjb.20.2023.09.03.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 11:54:45 -0700 (PDT)
Date:   Sun, 3 Sep 2023 11:54:41 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        boqun.feng@gmail.com, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, jstultz@google.com,
        juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
        mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
Subject: Re: [PATCH v2 5/6] locking/rtmutex: Use rt_mutex specific scheduler
 helpers
Message-ID: <ZPTWcThhRyCktBqA@sultan-box.localdomain>
References: <20230825181033.504534-1-bigeasy@linutronix.de>
 <20230825181033.504534-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825181033.504534-6-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 08:10:32PM +0200, Sebastian Andrzej Siewior wrote:
> --- a/kernel/locking/rwbase_rt.c
> +++ b/kernel/locking/rwbase_rt.c
> @@ -71,6 +71,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  	struct rt_mutex_base *rtm = &rwb->rtmutex;
>  	int ret;
>  
> +	rwbase_pre_schedule();
>  	raw_spin_lock_irq(&rtm->wait_lock);
>  
>  	/*
> @@ -125,6 +126,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
>  		rwbase_rtmutex_unlock(rtm);
>  
>  	trace_contention_end(rwb, ret);
> +	rwbase_post_schedule();
>  	return ret;
>  }
>  
> @@ -237,6 +239,8 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  	/* Force readers into slow path */
>  	atomic_sub(READER_BIAS, &rwb->readers);
>  
> +	rt_mutex_pre_schedule();
> +
>  	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
>  	if (__rwbase_write_trylock(rwb))
>  		goto out_unlock;
> @@ -248,6 +252,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  		if (rwbase_signal_pending_state(state, current)) {
>  			rwbase_restore_current_state();
>  			__rwbase_write_unlock(rwb, 0, flags);
> +			rt_mutex_post_schedule();
>  			trace_contention_end(rwb, -EINTR);
>  			return -EINTR;
>  		}
> @@ -266,6 +271,7 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
>  
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> +	rt_mutex_post_schedule();
>  	return 0;
>  }

Shouldn't rwbase_write_lock() use rwbase_{pre|post}_schedule()?

With this change as-is, I observe deadlocks due to lock recursion from
write_lock() specifically, because write_lock() ends up flushing block requests.

Sultan
