Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48767D09B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376417AbjJTHvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:51:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60A8A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:51:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507c50b7c36so621450e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697788274; x=1698393074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mrqe+VaNyg+k16K8uNieYvGU9qfJUtjNYAfSLsQb4w=;
        b=Zzio+iARSeQxccD9VVTuq6D/dnAPIYjjXQQfvhQWbh6YCWvFEnMmV8r2FN9GaeTear
         kR9sfAX9CuupOq3qcyx9SKWZZU7ukZJLfa8XXWcCYrNhO03YFmi0+WuZ1pQP6YspChjD
         RRcUYH0dn1DZH50jadUiwQETAmrZKTcjYOPUNts9bNlDuJZWI7pzemk7Yp2OtfoqHlZ2
         ri4O7djtT3A45EVvK5LDfLn9vQR8o1PFf72PQRmc4hwNbcCALT8F9W1XJhESYeh+yvLg
         muLA3THnQglh3CgovYVhfNTVpK9eHDALKnlZS4KyWTyDTb7cksvXAELLmhPHdDCjWw4m
         w99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697788274; x=1698393074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mrqe+VaNyg+k16K8uNieYvGU9qfJUtjNYAfSLsQb4w=;
        b=EZCk5SpVdiVhQty5wzb9FbLCM2imfiM3BYz1Lo9fyzELfU2T7ZBgialTo1VdaahZIh
         dMnffsG99m/P7mzU8D/YBC+vZsHMvzCxjAoOBgETH7EDIOXmwSJFjwNSwm8YMlSsiL46
         XpLMBIdzZ2oymPZEetJe+E6A6oeWiJb98T2oUh/QSax2DMDG2dJeu5v90Z1YuAUyKToV
         LVPHyGmHTLagPNa5IUsf2k8oq0dQq9/2IHrzGPmTDcb2HZ6QBiyNdlLn50Ihm6llbRla
         QsbSmYm46WAb1TtSIUEkqYAaUwBH8KrBQzHNRYJ3b3+F+b2Wf3f4kbUAENcnpPOFTLPH
         tOJg==
X-Gm-Message-State: AOJu0YyluBw5Sj72NdZYZezvIEAI30OaAhdo+d8r15CUTn3FVd5MhGx6
        e5s4DKuPa+B4RUPHhqd+CLQ=
X-Google-Smtp-Source: AGHT+IFQOb4eOxyPRC6LQC2Q6VTlzY0Ik1B0kbnUFlGvgV5qpxFZlh1THAbPo3f1F7rWOdm0y6x8SQ==
X-Received: by 2002:ac2:5e9c:0:b0:503:1875:5ae5 with SMTP id b28-20020ac25e9c000000b0050318755ae5mr702341lfq.38.1697788273850;
        Fri, 20 Oct 2023 00:51:13 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906261900b00992e14af9c3sm964876ejc.143.2023.10.20.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:51:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 09:51:10 +0200
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
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/3] sched/nohz: Update comments about NEWILB_KICK
Message-ID: <ZTIxbrgYHdTMfhVs@gmail.com>
References: <20231020014031.919742-1-joel@joelfernandes.org>
 <20231020014031.919742-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020014031.919742-2-joel@joelfernandes.org>
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

> How ILB is triggered without IPIs is cryptic. Out of mercy for future
> code readers, document it in code comments.
> 
> The comments are derived from a discussion with Vincent in a past
> review.
> 
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/fair.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 965c30fbbe5c..8e276d12c3cb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11959,8 +11959,19 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>  }
>  
>  /*
> - * Check if we need to run the ILB for updating blocked load before entering
> - * idle state.
> + * Check if we need to directly run the ILB for updating blocked load before
> + * entering idle state. Here we run ILB directly without issuing IPIs.
> + *
> + * Note that when this function is called, the tick may not yet be stopped on
> + * this CPU yet. nohz.idle_cpus_mask is updated only when tick is stopped and
> + * cleared on the next busy tick. In other words, nohz.idle_cpus_mask updates
> + * don't align with CPUs enter/exit idle to avoid bottlenecks due to high idle
> + * entry/exit rate (usec). So it is possible that _nohz_idle_balance() is
> + * called from this function on (this) CPU that's not yet in the mask. That's
> + * OK because the goal of nohz_run_idle_balance() is to run ILB only for
> + * updating the blocked load of already idle CPUs without waking up one of
> + * those idle CPUs and outside the preempt disable / irq off phase of the local
> + * cpu about to enter idle, because it can take a long time.

Much appreciated! Feel free to update comments for the entire relevant code 
base, a lot of it has become cryptic and under-documented at best as 
complexity increased ...

Thanks,

	Ingo
