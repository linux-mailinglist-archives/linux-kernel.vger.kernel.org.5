Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1117C6111
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376550AbjJKXYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjJKXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:24:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BAA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:24:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9c145bb5bso37355ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697066681; x=1697671481; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAAKGVB+lelljepY7l9tUkyTVnRdooCMLwVeaoxxMw4=;
        b=1sw6xuoNwtrLEXhK+UmI8v+u3bBQxlk5VyAQqGwznvwTgQOsM9dkH3DtP6lEDZpCFR
         Jl15Tmee9ZzC0e2t9IHVWzdh8t/So8dKV5jvhZqfVMniXsKgzHxoey3NB8O36OkwPnmy
         BSJu7MxGz1EIVW9JIXKaLUz+OXAf4kiZeP13UQ4PigzcwrBhlvLIF87Znh4dIHSeRDZI
         OP7msvDjzSeGTaKirwf9/R+ywZ2/bA0k0vu7o/2FN/0b04DeFV6itdOLzosWOmHt7h+U
         atmm3WUn+Qfh3YPbRa3Od1kVZtBQVe6PmsSRbWjbizb5EFH6zHPWRK3dbyEd/2i3ATiT
         VX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697066681; x=1697671481;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAAKGVB+lelljepY7l9tUkyTVnRdooCMLwVeaoxxMw4=;
        b=AHsedt/gpfTFWoFDVE5RrpBf4EKFjKbnEIxhJDGXfvjzivgZlJv4NrHbADxYcwsLn4
         H0DdDP4+96uBevIodHssmDsSoFWhhMveN7bnzATFoIhnU+v6rlCZAUNA+4IDVuFvNfDf
         Sck9LPg/6VmHmQ0t3AS5hOo2AukDP+975OsBnwkokM2s4mvaVBkIqFqxZRErwLR/1CP6
         BCXW6Iow6MZKuPyLOvkbHcYWVx5i1IRPfvDhil3p/3AR9Mku4xaGlx7eugitD7j5qAqq
         mwDc0PhxAVxxLhf1zXzHaZK08zo0lfLl965GY5LNXuzhIM26Lsr2c0b/wpYVZWLqI/VC
         adnA==
X-Gm-Message-State: AOJu0YyjprOIEaTl+zfuW7U2Qo/T6ObvLUKvMoykzUqwufCNdrahq091
        01celDnBlc/Uy7euALsTZuL3kw==
X-Google-Smtp-Source: AGHT+IH9q4ltRTBEFYeoK6271feOM+SC/ECJaVYC7fj5pQItoScKzYH38AYflx06meM9EvXSMn2GoA==
X-Received: by 2002:a17:902:d2c6:b0:1c9:bfdb:aae4 with SMTP id n6-20020a170902d2c600b001c9bfdbaae4mr379571plc.18.1697066681416;
        Wed, 11 Oct 2023 16:24:41 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:5aa:bf1b:3872:9fec])
        by smtp.gmail.com with ESMTPSA id q134-20020a632a8c000000b005a2eed54421sm242567pgq.24.2023.10.11.16.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:24:40 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [RFC][PATCH 13/15] sched/fair: Implement latency-nice
In-Reply-To: <20230531124604.477939524@infradead.org> (Peter Zijlstra's
        message of "Wed, 31 May 2023 13:58:52 +0200")
References: <20230531115839.089944915@infradead.org>
        <20230531124604.477939524@infradead.org>
Date:   Wed, 11 Oct 2023 16:24:39 -0700
Message-ID: <xm26ttqwhhe0.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -952,6 +952,21 @@ int sched_update_scaling(void)
>  }
>  #endif
>  
> +void set_latency_fair(struct sched_entity *se, int prio)
> +{
> +	u32 weight = sched_prio_to_weight[prio];
> +	u64 base = sysctl_sched_base_slice;
> +
> +	/*
> +	 * For EEVDF the virtual time slope is determined by w_i (iow.
> +	 * nice) while the request time r_i is determined by
> +	 * latency-nice.
> +	 *
> +	 * Smaller request gets better latency.
> +	 */
> +	se->slice = div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
> +}
> +
>  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>  
>  /*


This seems questionable in combination with the earlier changes that
make things use se->slice by itself as the expected time slice:


> @@ -6396,13 +6629,12 @@ static inline void unthrottle_offline_cf
>  static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
>  {
>  	struct sched_entity *se = &p->se;
> -	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
>  	SCHED_WARN_ON(task_rq(p) != rq);
>  
>  	if (rq->cfs.h_nr_running > 1) {
> -		u64 slice = sched_slice(cfs_rq, se);
>  		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> +		u64 slice = se->slice;
>  		s64 delta = slice - ran;
>  
>  		if (delta < 0) {
> @@ -12136,8 +12382,8 @@ static void rq_offline_fair(struct rq *r
>  static inline bool
>  __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
>  {
> -	u64 slice = sched_slice(cfs_rq_of(se), se);
>  	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> +	u64 slice = se->slice;
>  
>  	return (rtime * min_nr_tasks > slice);
>  }
> @@ -12832,7 +13078,7 @@ static unsigned int get_rr_interval_fair
>  	 * idle runqueue:
>  	 */
>  	if (rq->cfs.load.weight)
> -		rr_interval = NS_TO_JIFFIES(sched_slice(cfs_rq_of(se), se));
> +		rr_interval = NS_TO_JIFFIES(se->slice);
>  
>  	return rr_interval;
>  }

We probably do not want a task with normal weight and low latency-weight
(aka high latency / latency-nice value) to be expected to have a very
very high slice value for some of these. get_rr_interval_fair is
whatever, it's not really a number that exists, and CONFIG_SCHED_CORE
isn't updated for EEVDF at all, but HRTICK at least probably should be
updated. Having such a task run for 68 times normal seems likely to have
far worse latency effects than any gains from other parts.
