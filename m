Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5A7929CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353396AbjIEQ2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354876AbjIEPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C67198
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693927485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5YWYrk9E5bM6uhBXBTllgdrAq5T252fZkEOBXpxiVs=;
        b=gRuYlvUIT30YgohQ8LGNcViGSPQUvUzj50hfaCQaakJX8luTZet5sa4a0bAafTXs0UqhVy
        gExDW7S4b3+pGlCANFUP5DXdQRP11MtwydsTfNT7BWJQVnIYkJAmRXmfYx29SG/Bz6dZy3
        2ptfv104UCaCpEFAP5QHR2XWn5Y+O7E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9DgYiOLrMxOytXnwhbJpoQ-1; Tue, 05 Sep 2023 11:24:44 -0400
X-MC-Unique: 9DgYiOLrMxOytXnwhbJpoQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-500ac71f353so2767702e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 08:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693927482; x=1694532282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5YWYrk9E5bM6uhBXBTllgdrAq5T252fZkEOBXpxiVs=;
        b=B7ho7m13S7pzlDyaW/5RgC39DVASeN74ZUGSJyCEQrKH97u+mO5+nkmfKTT1yL2X9N
         YUOcRpZxg11QOiYcWR9GMmI8I5h1RRwL0YxvlwrGddOGr42jlCtlL1zciBrU/8zI17eq
         527PO+dArJOuEb6QtUSMChXZnr+qIvwmrV7PCyPTW8wc2uAyWW9jPvZsT0MyJx70p4LX
         dM4q5JDs/urbQ2WSNyUg0DUMzVOJubX3yGeSHJy0t4zH5CULzXYayKJw0D/Qtnt9l/QU
         fem5VSiwfrU/9WhRBFz/yOPNQWcrnipgOFSBp+SNf9rkzRB4IWRhIfqle/YR4AbI/X7P
         FmnA==
X-Gm-Message-State: AOJu0YzfMxbWWuAUjvMUlA0gXIFP6fEToirmffPCt0pEfTgkBkbm5DUK
        o9KrNM0pzgeLoWQ2CsWQKk7gcP1xsldWTRmt/yWn5CSOaMnq431ntJ4wmp1sgMsN9YbA7GKfTi0
        JXATnXN4MvW8ZKrnRh7oZ2xgx
X-Received: by 2002:a05:6512:200e:b0:500:a6c1:36f7 with SMTP id a14-20020a056512200e00b00500a6c136f7mr108210lfb.3.1693927482740;
        Tue, 05 Sep 2023 08:24:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfhgKU6XCIYKD3TCcjFOlr7db7M9qRFhA1x34eONm3SEJaFkr98lVPkoRTZA3EyrgrfJ6IGg==
X-Received: by 2002:a05:6512:200e:b0:500:a6c1:36f7 with SMTP id a14-20020a056512200e00b00500a6c136f7mr108186lfb.3.1693927482362;
        Tue, 05 Sep 2023 08:24:42 -0700 (PDT)
Received: from [192.168.0.224] (a-rm20-17.tin.it. [212.216.165.208])
        by smtp.gmail.com with ESMTPSA id l26-20020a056402125a00b00525c01f91b0sm7229407edw.42.2023.09.05.08.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 08:24:41 -0700 (PDT)
Message-ID: <b3b3a5c5-6688-966d-3d78-3e140730cb7b@redhat.com>
Date:   Tue, 5 Sep 2023 17:24:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 6/7] sched/deadline: Deferrable dl server
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1693510979.git.bristot@kernel.org>
 <754dab7f30695ca10a41613068bb63db3bfea003.1693510979.git.bristot@kernel.org>
 <20230905134203.GA20703@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20230905134203.GA20703@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 15:42, Peter Zijlstra wrote:
> On Thu, Aug 31, 2023 at 10:28:57PM +0200, Daniel Bristot de Oliveira wrote:
>> +void dl_server_start(struct sched_dl_entity *dl_se, int defer)
>>  {
>> +	if (dl_se->server_state != DL_SERVER_STOPPED) {
>> +		WARN_ON_ONCE(!(on_dl_rq(dl_se) || dl_se->dl_throttled));
>> +		return;
>> +	}
>> +
>> +	if (defer) {
>> +		/*
>> +		 * Postpone the replenishment to the (next period - the execution time)
>> +		 *
>> +		 * With this in place, we have two cases:
>> +		 *
>> +		 * On the absence of DL tasks:
>> +		 *	The server will start at the replenishment time, getting
>> +		 *	its runtime before now + period. This is the expected
>> +		 *	throttling behavior.
>> +		 *
>> +		 * In the presense of DL tasks:
>> +		 *	The server will be replenished, and then it will be
>> +		 *	schedule according to EDF, not breaking SCHED_DEADLINE.
>> +		 *
>> +		 *	In the first cycle the server will be postponed at most
>> +		 *	at period + period - runtime at most. But then the
>> +		 *	server will receive its runtime/period.
>> +		 *
>> +		 *	The server will, however, run on top of any RT task, which
>> +		 *	is the expected throttling behavior.
>> +		 */
>> +		dl_se->deadline = rq_clock(dl_se->rq) + dl_se->dl_period - dl_se->dl_runtime;
> 
> I was confused by this, but this is an instance of
> replenish_dl_new_period(), where we explicitly do not preserve the
> period.

yeah, it is two operations in one (so not straight forward). It sets the period as the now - runtime, so..


>> +		/* Zero the runtime */
>> +		dl_se->runtime = 0;
>> +		/* throttle the server */
>> +		dl_se->dl_throttled = 1;

as the server is throttled, it will set the replenishing timer for now - runtime + period because
of the deadline.

> These comments are both obvious and placed so as to make everything
> unreadable :/ 

I can't disagree :-) I will remove.

>> +
>> +		dl_se->server_state = DL_SERVER_DEFER;
>> +		start_dl_timer(dl_se);
>> +		return;
>> +	}
>> +
>>  	if (!dl_server(dl_se)) {
>>  		dl_se->dl_server = 1;
>>  		setup_new_dl_entity(dl_se);
>>  	}
>> +
>> +	dl_se->server_state = DL_SERVER_RUNNING;
>>  	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>>  }
> 
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 580e6764a68b..b9d0f08dc8ca 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6499,9 +6499,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  	 */
>>  	util_est_enqueue(&rq->cfs, p);
>>  
>> -	if (!rq->cfs.h_nr_running)
>> -		dl_server_start(&rq->fair_server);
>> -
>>  	/*
>>  	 * If in_iowait is set, the code below may not trigger any cpufreq
>>  	 * utilization updates, so do it here explicitly with the IOWAIT flag
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index e23cc67c9467..7595110a5a3e 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1537,6 +1537,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>>  
>>  	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
>>  		enqueue_pushable_task(rq, p);
>> +
>> +	if (sched_fair_server_needed(rq))
>> +		dl_server_start(&rq->fair_server, rq->fair_server_defer);
>>  }
>>  
>>  static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>> @@ -1547,6 +1550,9 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>>  	dequeue_rt_entity(rt_se, flags);
>>  
>>  	dequeue_pushable_task(rq, p);
>> +
>> +	if (!sched_fair_server_needed(rq))
>> +		dl_server_stop(&rq->fair_server);
>>  }
>>  
>>  /*
> 
> I'm thinking this is wrong -- ISTR there definite benefits to explicit
> slack time scheduling, meaning the server should also run while DL tasks
> are on.

I can add the check to enable it also in the presence of DL tasks, we just need
to have consider that the dl server is a dl task as well when disabling.

It is a benefit because it will fix the case in which a CPU full of DL tasks
(possible with global).

Additionally, running the server when there are only fair tasks
> is mostly harmless, right? So why this change?

Rhe problem is that we never know when a RT one will arrive :-/

E.g., only fair tasks, server enabled. All fine :-) Then an RT arrives, and gets
postponed by the server... RT people complaining (for those thinking on adding
a server for RT, we will have a similar problem as we have with throttling today +
DL has no fixed priority).

We will still face the same problem with defferable server, and the example is the same,
just with a shift in the RT arrival. e.g., only fair task for (server period - runtime),
then the server gets enabled, and a 1us after the RT arrives and gets postponed... again.

So the need to enable it only after the dispatch of a kind of RT (or DL to be added)
tasks that can cause starvation.

We could simplify it by enabling only on RT/DL arrival but... if there is nothing to
starve... it is not needed anyways so less overhead avoiding the enqueue...

> 
> One of the benefits was -- IIRC, that we no longer need to subtract some
> random margin from the reservation limit, but there were more I think.
> 

We can simplify things because we can start ignoring the rt throttling limit when
there is no need to throttle... like on grub (but, only after we remove the rt
throttling).

Thoughts?
-- Daniel

