Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD067DEEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbjKBJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5AE136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698917456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iX+Zyro9Vv7rtY22N3E0y2lRJKkvZpd/Nu5v1BlBgqg=;
        b=Tc4C+nM1i148cgfe57LdcfWgoigHGmoUvkr1KDPzBXvsUTvt6NfvYWaAKeartpNR1/EH9t
        3COm20ESIoueEJg+kTfxMjgiYN6ChOSuPHb2KnEarMO8gkwv5hcOvL+3HtOIRaEVEbd2jT
        dJgxDh38k0iinYU3Ez+pfwvIQCprj0U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-U2XysyjnOeeDAoLLElrpxQ-1; Thu, 02 Nov 2023 05:30:55 -0400
X-MC-Unique: U2XysyjnOeeDAoLLElrpxQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32fa41d0564so355715f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698917454; x=1699522254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX+Zyro9Vv7rtY22N3E0y2lRJKkvZpd/Nu5v1BlBgqg=;
        b=aHTaEXtURFys+evnvlS7F5QbsbN9nJYMGwZw32UietJ9dAN1HhbijlHDy2gTfZfbOh
         xMpaY5l8ZLC4XuvCqNI5t22FQjrZozSFnHlFx4zHZH/SteJjaYaiRpo+7K+Pg0vUbzO9
         5cre5VrJw6+ThluTCgZ+Mpk2blAS91+8LNPRFItL5GSBup/BfcBpcrJGhwRNTohOMmBR
         wL4gmh8dui/pqErimgurYhT4Thx/QquxTtvlLUYhwk5b5NRM00g86WcQMUa/qXRRDRG6
         nO7sov8A0Va8qiI0jn0qd+JmNON6l9YENd4eBRVKgS0NOZtSF9xgOEPBpXw1pxP2CnGe
         +7mg==
X-Gm-Message-State: AOJu0YzUFFFQbbkpzmizDI6Bg1KjgLscylHNQ2i1LmkEfL1HiFG8yFu2
        jpniZqMkYGyj2hfVcGBkJEeneO75S5KZNLf+LvVMyr6pPaLb6daXldmPq02s4/o8E54G43sggOj
        6vw/r6yayvj1ae4cHkzO3ovPS
X-Received: by 2002:adf:d1c9:0:b0:32d:8094:f4c8 with SMTP id b9-20020adfd1c9000000b0032d8094f4c8mr14964840wrd.19.1698917454150;
        Thu, 02 Nov 2023 02:30:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJefxTBUdkBAsUbfEitv4kBhExUzxa9lyBbiVloDYjPTvae0broC6U52/4ab1eZovtomroMA==
X-Received: by 2002:adf:d1c9:0:b0:32d:8094:f4c8 with SMTP id b9-20020adfd1c9000000b0032d8094f4c8mr14964812wrd.19.1698917453734;
        Thu, 02 Nov 2023 02:30:53 -0700 (PDT)
Received: from localhost.localdomain ([151.29.57.115])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b0032db4825495sm292380wrw.22.2023.11.02.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 02:30:53 -0700 (PDT)
Date:   Thu, 2 Nov 2023 10:30:50 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 1/3] sched/core: Provide a method to check if a task
 is PI-boosted.
Message-ID: <ZUNsSqHiYu8WTHBb@localhost.localdomain>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
 <20230804113039.419794-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804113039.419794-2-bigeasy@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies for noticing only now, but I believe this is still part of the
6.6-rt patches and I've got the below question to ask.

On 04/08/23 13:30, Sebastian Andrzej Siewior wrote:
> Provide a method to check if a task inherited the priority from another
> task. This happens if a task owns a lock which is requested by a task
> with higher priority. This can be used as a hint to add a preemption
> point to the critical section.
> 
> Provide a function which reports true if the task is PI-boosted.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 609bde814cb06..77fd274133750 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1887,6 +1887,7 @@ static inline int dl_task_check_affinity(struct task_struct *p, const struct cpu
>  }
>  #endif
>  
> +extern bool task_is_pi_boosted(const struct task_struct *p);
>  extern int yield_to(struct task_struct *p, bool preempt);
>  extern void set_user_nice(struct task_struct *p, long nice);
>  extern int task_prio(const struct task_struct *p);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c739..132f06522efa0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8886,6 +8886,21 @@ static inline void preempt_dynamic_init(void) { }
>  
>  #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
>  
> +/*
> + * task_is_pi_boosted - Check if task has been PI boosted.
> + * @p:	Task to check.
> + *
> + * Return true if task is subject to priority inheritance.
> + */
> +bool task_is_pi_boosted(const struct task_struct *p)
> +{
> +	int prio = p->prio;
> +
> +	if (!rt_prio(prio))
> +		return false;
> +	return prio != p->normal_prio;

Does this need to also take DEADLINE tasks into consideration? We don't
change priority when they are boosted, only pi_se changes (please check
is_dl_boosted()).

Thanks,
Juri

