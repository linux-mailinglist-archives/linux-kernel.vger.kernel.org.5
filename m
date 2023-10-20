Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6987D09CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376440AbjJTHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376406AbjJTHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:53:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C851E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:53:56 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo683848a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697788434; x=1698393234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bS/fNgE7HshzP+B9hnPB+4ZnJQH4ERzD9aTrrrvTVT8=;
        b=GP2GwcJo2uXAUB0otWhLkpEBj4FzJFmHuWiERCzrfho1CMtlQoceWCqGaqW6j7jN2R
         lqklM+0CqA4vPQ4ZPS6EGJTpgMxMoeCBla013Klq+7/AnuvCEKvtutwbOee+It/u5VXY
         Wc5WdjKh9XeV+CKI6db29fykGUoH0DuT0phAFUGnY2MCyIGRTdDjY2UV0jekffwsaNcl
         BaTQAhJHAar8uw5Ivs9xEOvWdOPf4wkfcDbLlMVzYvan5XWcrEh5l+RsTwiXFkY0yJso
         WWaj+ru+VrCf+iWBabf56thYwlaCwmRzldFDbgNDCjKlzsOqYGysyUDDUBDZqQbyGLvl
         tinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697788434; x=1698393234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS/fNgE7HshzP+B9hnPB+4ZnJQH4ERzD9aTrrrvTVT8=;
        b=tKyNbz7ddQpO/b/aDVtuFLiqxZ3s8+YdMhSWzucJjNvka9N4XLxEUVMY8BZhkVCsPG
         eOYtfeuWDm8RU9G8dDx1AqdDVTtxQIp4obcgXlQhKOdIkJg4B7aL8GoHdD+brQ8D6tG/
         x3h5qP7y+wSUinxlWkCUsNM8IloXUYQFIJfpwIlzWUDS9TBzQnPIjUhmnQl7TlJb2oLR
         p5dlcaqCThc84BlqzCoL7ZnbCjlx3bNi/DK/kP068nB0E/cBlyPylN1M9I4HUi8pOJW1
         e9qAkqdZ4pGrOm/zDocnWuTg9Dj+xKKZB5MrTVvH7ifL2fzE7LmlVNhR1XTXc2X5k+VK
         0Uiw==
X-Gm-Message-State: AOJu0Yyy49bqxxgyMoIGMo81NugEqY0kV0hPxXN7A7Vj4iLLAO65bjO6
        LCXtb+PvxJrEjQA+FMJF0ZM=
X-Google-Smtp-Source: AGHT+IHEZcchen6ixd0kxn0P/WuskUEvLQh08rQ5h0owCPRMbI8OftiFjd5PUwd0QBfuw1foK2JYgw==
X-Received: by 2002:a17:907:2cc4:b0:9c3:d356:ad0c with SMTP id hg4-20020a1709072cc400b009c3d356ad0cmr742899ejc.24.1697788434435;
        Fri, 20 Oct 2023 00:53:54 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906019100b009ad8d444be4sm964958ejb.43.2023.10.20.00.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:53:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 09:53:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during
 newidle balance
Message-ID: <ZTIyD8EuhSmF4JFr@gmail.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020014031.919742-3-joel@joelfernandes.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Joel Fernandes (Google) <joel@joelfernandes.org> wrote:

> From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
> 
> When newidle balancing triggers, we see that it constantly clobbers 
> rq->next_balance even when there is no newidle balance happening due to 
> the cost estimates.  Due to this, we see that periodic load balance 
> (rebalance_domains) may trigger way more often when the CPU is going in 
> and out of idle at a high rate but is no really idle. Repeatedly 
> triggering load balance there is a bad idea as it is a heavy operation. 
> It also causes increases in softirq.
> 
> Another issue is ->last_balance is not updated after newidle balance 
> causing mistakes in the ->next_balance calculations.
> 
> Fix by updating last_balance when a newidle load balance actually happens 
> and then updating next_balance. This is also how it is done in other load 
> balance paths.
> 
> Testing shows a significant drop in softirqs when running:
> cyclictest -i 100 -d 100 --latency=1000 -D 5 -t -m  -q
> 
> Goes from ~6k to ~800.
> 
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8e276d12c3cb..b147ad09126a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12076,11 +12076,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> -
> -		if (sd)
> -			update_next_balance(sd, &next_balance);
>  		rcu_read_unlock();
> -
>  		goto out;
>  	}
>  	rcu_read_unlock();
> @@ -12095,8 +12091,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  		int continue_balancing = 1;
>  		u64 domain_cost;
>  
> -		update_next_balance(sd, &next_balance);
> -
>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>  			break;
>  
> @@ -12109,6 +12103,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  			t1 = sched_clock_cpu(this_cpu);
>  			domain_cost = t1 - t0;
>  			update_newidle_cost(sd, domain_cost);
> +			sd->last_balance = jiffies;
> +			update_next_balance(sd, &next_balance);
>  
>  			curr_cost += domain_cost;
>  			t0 = t1;

Okay, I'm applying patches #2 and #3, without #1: it should be safe
out of order, but let me know if I missed something ...

Thanks,

	Ingo
