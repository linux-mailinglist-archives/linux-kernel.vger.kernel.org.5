Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE77EB5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjKNRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 12:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 12:43:18 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93773D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:43:14 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b9ff6d89e6so2322465241.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 09:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699983793; x=1700588593; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgNnHklrVf4CEZOSBNA49jhgL7Qc9Y6fPpmgmtnPFWs=;
        b=pYwmUWJ5pZ2K0w3mxqx42wDVbj9IrM4zD3eYjToEdBMnU8UH6Mb4NecwTW0PKbEzMI
         Sii9vLjh5LfFDBimqNygzNKKHGr3lRzLSVhPIdhU3SxKndYdrzeGtS+qIfYlgiZcKdWM
         VYO4sN9ISJseuvBV2Z1aZugxbbEkcrgwqCLUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983793; x=1700588593;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgNnHklrVf4CEZOSBNA49jhgL7Qc9Y6fPpmgmtnPFWs=;
        b=cY357RHdRfGnf3xCdLEHitNf+DIkWmv0lnHoNzduYqA0xFJAllWPHqSRK9NQwyMRo3
         XV2FN1wmXTKuPilYBdvsdZD0urnhAktdjSzZgHjWbomktAs99R9rtmhr9+3ivLm8fbxJ
         IhbTSBOkmTZDqaxOjdb1302YoTiSEfLZvM4G7MNqGxjejT5NoIquv6P/JoZe+UKa/mKp
         ffPcUeM2IvYpj1UfIZuh3Ics03QcQoBNfZJVzsB17DdGXhdgZiBtbQLoXyEZNA+p0eew
         xK6AjpyaPG+gvTk2I5PysBOte1xb9+8DozjuhctsvbZfWtmzfqNtS947nCw4kv/+0HzC
         4+Jw==
X-Gm-Message-State: AOJu0Yy7sI6saz99thMWtPr9pFaSJqlR0YmtlBNRuLzciTEjvlJ9/Eru
        xMIFqUoPqmk0FPtlF9s4bBCvhQ==
X-Google-Smtp-Source: AGHT+IGKDuHREPCh6BgK3qGalRzbxDwjBVISuvghGoF8/KGX3b/yn/VhdG/2qLcMrwR33OTo5fXa/A==
X-Received: by 2002:a05:6102:4716:b0:45f:b8c7:94f5 with SMTP id ei22-20020a056102471600b0045fb8c794f5mr9573505vsb.33.1699983793491;
        Tue, 14 Nov 2023 09:43:13 -0800 (PST)
Received: from smtpclient.apple ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id mk3-20020a056214580300b006263a9e7c63sm3037417qvb.104.2023.11.14.09.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 09:43:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] sched: Update ->next_balance correctly during newidle balance
Date:   Tue, 14 Nov 2023 12:43:02 -0500
Message-Id: <9D54E400-BF9B-4D82-8A97-7E681C1D5263@joelfernandes.org>
References: <ZVOVkDf28foTkn/A@vingu-book>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <ZVOVkDf28foTkn/A@vingu-book>
To:     Vincent Guittot <vincent.guittot@linaro.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

> On Nov 14, 2023, at 10:43 AM, Vincent Guittot <vincent.guittot@linaro.org>=
 wrote:
>=20
> =EF=BB=BFLe jeudi 09 nov. 2023 =C3=A0 10:02:54 (+0000), Joel Fernandes a =C3=
=A9crit :
>> Hi Vincent,
>>=20
>> Sorry for late reply, I was in Tokyo all these days and was waiting to ge=
t to
>> writing a proper reply. See my replies below:
>>=20
>>> On Thu, Oct 26, 2023 at 04:23:35PM +0200, Vincent Guittot wrote:
>>> On Sun, 22 Oct 2023 at 02:28, Joel Fernandes <joel@joelfernandes.org> wr=
ote:
>>>>=20
>>>> On Fri, Oct 20, 2023 at 03:40:14PM +0200, Vincent Guittot wrote:
>>>>> On Fri, 20 Oct 2023 at 03:40, Joel Fernandes (Google)
>>>>> <joel@joelfernandes.org> wrote:
>>>>>>=20
>>>>>> From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
>>>>>>=20
>>>>>> When newidle balancing triggers, we see that it constantly clobbers
>>>>>> rq->next_balance even when there is no newidle balance happening due t=
o
>>>>>> the cost estimates.  Due to this, we see that periodic load balance
>>>>>> (rebalance_domains) may trigger way more often when the CPU is going i=
n
>>>>>> and out of idle at a high rate but is no really idle. Repeatedly
>>>>>> triggering load balance there is a bad idea as it is a heavy operatio=
n.
>>>>>> It also causes increases in softirq.
>>>>>=20
>>>>> we have 2 balance intervals:
>>>>> - one when idle based on the sd->balance_interval =3D sd_weight
>>>>> - one when busy which increases the period by multiplying it with
>>>>> busy_factor =3D 16
>>>>=20
>>>> On my production system I see load balance triggering every 4 jiffies! I=
n a
>>>=20
>>> Which kind of system do you have? sd->balance_interval is in ms
>>=20
>> Yes, sorry I meant it triggers every jiffies which is extreme sometimes. I=
t
>> is an ADL SoC (12th gen Intel, 4 P cores 8 E cores) get_sd_balance_interv=
al()
>> returns 4 jiffies there. On my Qemu system, I see 8 jiffies.
>=20
> Do you have details about the sched_domain  hierarchy ?
> That could be part of your problem (see below)

Since I am at LPC I am not at that machine right now but I could provide it n=
ext
week. I replied below:

>=20
>>=20
>> [...]
>>>>>> Another issue is ->last_balance is not updated after newidle balance
>>>>>> causing mistakes in the ->next_balance calculations.
>>>>>=20
>>>>> newly idle load balance is not equal to idle load balance. It's a
>>>>> light load balance trying to pull one  task and you can't really
>>>>> consider it to the normal load balance
>>>>=20
>>>> True. However the point is that it is coupled with the other load balan=
ce
>>>> mechanism and the two are not independent. As you can see below, modify=
ing
>>>> rq->next_balance in newidle also causes the periodic balance to happen m=
ore
>>>> aggressively as well if there is a high transition from busy to idle an=
d
>>>> viceversa.
>>>=20
>>> As mentioned, rq->next_balance is updated whenever cpu enters idle
>>> (i.e. in newidle_balance() but it's not related with doing a newly
>>> idle load balance.
>>=20
>> Yes, I understand that. But my point was that the update of rq->next_bala=
nce
>> from the newidle path is itself buggy and interferes with the load balanc=
e
>> happening from the tick (trigger_load_balance -> run_rebalance_domains).
>=20
> Newidle path is not buggy.

Sure perhaps not directly newidle but something else is buggy as you
indicated below:

> It only uses sd->last_balance + interval to
> estimate the next balance  which is the correct thing to do. Your problem
> comes from the update of sd->last_balance which never happens and remains
> in the past whereas you call run_rebalance_domains() which should
> run load_balance for all domains with a sd->last_balance + interval in the=

> past.
> Your problem most probably comes from the should_we_balance which always o=
r
> "almost always" returns false in your use case for some sched_domain and
> prevents to updat sd->last_balance. Could you try the patch below ?
> It should fix your problem of trying to rebalance every tick whereas
> rebalance_domain is called.
> At least this should show if it's your problem but I'm not sure it's the r=
ight
> things to do all the time ...

You raise a good point, the root cause is indeed last_balance being
stuck in the past, or such.

I will try the patch below and let you know. Also my previous diff where
I cap the next balance setting also makes the issue go away, when I was last=
 testing.

Thanks Vincent!

 - Joel=20


>=20
> ---
> kernel/sched/fair.c | 18 ++++++------------
> 1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3745ca289240..9ea1f42e5362 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11568,17 +11568,6 @@ static void rebalance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
>        need_decay =3D update_newidle_cost(sd, 0);
>        max_cost +=3D sd->max_newidle_lb_cost;
>=20
> -        /*
> -         * Stop the load balance at this level. There is another
> -         * CPU in our sched group which is doing load balancing more
> -         * actively.
> -         */
> -        if (!continue_balancing) {
> -            if (need_decay)
> -                continue;
> -            break;
> -        }
> -
>        interval =3D get_sd_balance_interval(sd, busy);
>=20
>        need_serialize =3D sd->flags & SD_SERIALIZE;
> @@ -11588,7 +11577,12 @@ static void rebalance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
>        }
>=20
>        if (time_after_eq(jiffies, sd->last_balance + interval)) {
> -            if (load_balance(cpu, rq, sd, idle, &continue_balancing)) {
> +            /*
> +             * Stop the load balance at this level. There is another
> +             * CPU in our sched group which is doing load balancing more
> +             * actively.
> +             */
> +            if (continue_balancing && load_balance(cpu, rq, sd, idle, &co=
ntinue_balancing)) {
>                /*
>                 * The LBF_DST_PINNED logic could have changed
>                 * env->dst_cpu, so we can't know our idle
> --
> 2.34.1
>=20
>>=20
>>> But your problem is more related with the fact that
>>> nohz.needs_update is set when stopping cpu timer in order to update
>>> nohz.next_balance which is then used to kick a "real" idle load
>>> balance
>>=20
>> Well, independent of nohz idle balance, I think we need to fix this issue=
 as
>> mentioned above. This effect the periodic one as mentioned in the commit l=
og.
>>=20
>> See here another trace I collected this time dumping the 'interval'. Ther=
e is
>> a tug of war happening between the newidle balance and the periodic balan=
ce.
>>=20
>> The periodic one sets rq->next_balance for cpu 0 to 760,143 and then the
>> newidle comes in pulls it back a 118 jiffies to 760,024. This is actually=
 in
>> the past because jiffies is currently 760,045 !!
>>=20
>> This triggers the periodic balance againwhich sets rq->next_balance back t=
o
>> 760,143.
>>=20
>> Rinse and repeat. End result is you have periodic balance every jiffies. W=
ith
>> this patch the issue goes away but we could fix it differently as you
>> mentioned, we need to pull newidle balance back but perhaps not so
>> aggressively. How about something like the untested diff I enclosed at th=
e
>> end of this email?
>>=20
>> <idle>-0   [000]  13.081781: rebalance_domains: rq[cpu=3D0]->next_balance=
: 760,024 -> 760,143 (jiffies=3D760,045)
>> cyclictest-120   [000]  13.081806: update_next_balance: sd->next_balance:=
 761,045 -> 760,024 (jiffies=3D760,045, interval=3D8)
>> cyclictest-120   [000]  13.081807: newidle_balance: this_rq[cpu=3D0]->nex=
t_balance: 760,143 -> 760,024 (jiffies=3D760,045)
>> cyclictest-120   [000]  13.082130: update_next_balance: sd->next_balance:=
 761,045 -> 760,024 (jiffies=3D760,045, interval=3D8)
>> cyclictest-120   [000]  13.082338: update_next_balance: sd->next_balance:=
 761,045 -> 760,024 (jiffies=3D760,045, interval=3D8)
>> cyclictest-120   [000]  13.082636: update_next_balance: sd->next_balance:=
 761,045 -> 760,024 (jiffies=3D760,045, interval=3D8)
>> <idle>-0   [000]  13.082823: trigger_load_balance: time_after_eq(jiffies=3D=
760,046, rq->next_balance=3D760,024) =3D 1
>> <idle>-0   [000]  13.082823: softirq_raise: vec=3D7 [action=3DSCHED]
>> <idle>-0   [000]  13.082871: rebalance_domains: rq[cpu=3D0]->next_balance=
: 760,024 -> 760,143 (jiffies=3D760,046)
>> trace-cmd-114   [000]  13.082876: update_next_balance: sd->next_balance: 7=
61,046 -> 760,024 (jiffies=3D760,046, interval=3D8)
>> trace-cmd-114   [000]  13.082876: newidle_balance: this_rq[cpu=3D0]->next=
_balance: 760,143 -> 760,024 (jiffies=3D760,046)
>> cyclictest-120   [000]  13.083333: update_next_balance: sd->next_balance:=
 761,046 -> 760,024 (jiffies=3D760,046, interval=3D8)
>> cyclictest-120   [000]  13.083633: update_next_balance: sd->next_balance:=
 761,046 -> 760,024 (jiffies=3D760,046, interval=3D8)
>> <idle>-0   [000]  13.083656: trigger_load_balance: time_after_eq(jiffies=3D=
760,047, rq->next_balance=3D760,024) =3D 1
>> <idle>-0   [000]  13.083656: softirq_raise: vec=3D7 [action=3DSCHED]
>> <idle>-0   [000]  13.083702: rebalance_domains: rq[cpu=3D0]->next_balance=
: 760,024 -> 760,143 (jiffies=3D760,047)
>> cyclictest-120   [000]  13.083729: update_next_balance: sd->next_balance:=
 761,047 -> 760,024 (jiffies=3D760,047, interval=3D8)
>> cyclictest-120   [000]  13.083730: newidle_balance: this_rq[cpu=3D0]->nex=
t_balance: 760,143 -> 760,024 (jiffies=3D760,047)
>> cyclictest-120   [000]  13.083960: update_next_balance: sd->next_balance:=
 761,047 -> 760,024 (jiffies=3D760,047, interval=3D8)
>> cyclictest-120   [000]  13.084069: update_next_balance: sd->next_balance:=
 761,047 -> 760,024 (jiffies=3D760,047, interval=3D8)
>> cyclictest-120   [000]  13.084423: update_next_balance: sd->next_balance:=
 761,047 -> 760,024 (jiffies=3D760,047, interval=3D8)
>> cyclictest-120   [000]  13.084633: trigger_load_balance: time_after_eq(ji=
ffies=3D760,048, rq->next_balance=3D760,024) =3D 1
>> cyclictest-120   [000]  13.084633: softirq_raise: vec=3D7 [action=3DSCHED=
]
>> cyclictest-120   [000]  13.084678: rebalance_domains: rq[cpu=3D0]->next_b=
alance:
>>=20
>>>>>> Fix by updating last_balance when a newidle load balance actually
>>>>>> happens and then updating next_balance. This is also how it is done i=
n
>>>>>> other load balance paths.
>>>>>>=20
>>>>>> Testing shows a significant drop in softirqs when running:
>>>>>> cyclictest -i 100 -d 100 --latency=3D1000 -D 5 -t -m  -q
>>>>>>=20
>>>>>> Goes from ~6k to ~800.
>>>>>=20
>>>>> Even if your figures look interesting, your patch adds regression in
>>>>> the load balance and the fairness.
>>>>=20
>>>> Yes I see that now. However it does illustrate the problem IMO.
>>>>=20
>>>>> We can probably do improve the current behavior for decreasing number
>>>>> of ILB but your proposal is not the right solution IMO
>>>>=20
>>>> One of the problems is if you have task goes idle a lot, then the
>>>> newidle_balance mechanism triggers the periodic balance every jiffie (o=
nce
>>>> per millisecond on HZ=3D1000).
>>>=20
>>> every msec seems quite a lot.
>>=20
>> Yeah!
>>=20
>>>>=20
>>>> Following are some traces I collected.
>>>>=20
>>>> cyclictest-123   [003]   522.650574  newidle_balance: this_rq[cpu=3D3]-=
>next_balance: 221,264 -> 221,145 (jiffies=3D221,157)
>>>>   <idle>-0      [003]   522.651443  trigger_load_balance: time_after_eq=
(jiffies=3D221,158, rq->next_balance=3D221,145) =3D 1
>>>>   <idle>-0      [003]   522.651461  rebalance_domains: rq[cpu=3D3]->nex=
t_balance: 221,145 -> 221,264 (jiffies=3D221,158)
>>>> cyclictest-123   [003]   522.651494  newidle_balance: this_rq[cpu=3D3]-=
>next_balance: 221,264 -> 221,145 (jiffies=3D221,158)
>>>>   <idle>-0      [003]   522.652522  trigger_load_balance: time_after_eq=
(jiffies=3D221,159, rq->next_balance=3D221,145) =3D 1
>>>>   <idle>-0      [003]   522.652560  rebalance_domains: rq[cpu=3D3]->nex=
t_balance: 221,145 -> 221,264 (jiffies=3D221,159)
>>>> cyclictest-124   [003]   522.652586  newidle_balance: this_rq[cpu=3D3]-=
>next_balance: 221,264 -> 221,145 (jiffies=3D221,159)
>>>>   <idle>-0      [003]   522.654492  trigger_load_balance: time_after_eq=
(jiffies=3D221,161, rq->next_balance=3D221,145) =3D 1
>>>>   <idle>-0      [003]   522.654534  rebalance_domains: rq[cpu=3D3]->nex=
t_balance: 221,145 -> 221,264 (jiffies=3D221,161)
>>>=20
>>> Ok, so IIUC your trace above, this happens because the tick is not
>>> stop after entering idle so it continues to fire and triggers a load
>>> balance without checking if there is a need like what is done for nohz
>>> mode
>>=20
>> The tick is normally not stopped if the CPU is awakened too soon by a tim=
er.
>> That's pretty normal AFAIK. As you can see in the traces above, cyclictes=
t
>> keeps waking up.
>>=20
>>>> things worse for power on ARM where you have uclamp stuff happening in t=
he
>>>> load balance paths which is quite heavy when I last traced that..
>>>>=20
>>>> Further, we have observed in our tracing on real device that the update=
 of
>>>> rq->next_balance from the newidle path is itself buggy... we observed t=
hat
>>>> because newidle balance may not update rq->last_balance, it is possible=
 that
>>>> rq->next_balance when updated by update_next_balance() will be updated t=
o a
>>>> value that is in the past and it will be stuck there for a long time! P=
erhaps
>>>> we should investigate more and fix that bug separately. Vineeth could p=
rovide
>>>> more details on the "getting stuck in the past" behavior as well.
>>>=20
>>> sd->last_balance reflects last time an idle/busy load_balance happened
>>> (newly idle is out of the scope for the points that I mentioned
>>> previously).  So if no load balance happens for a while, the
>>> rq->next_balance can be in the past but I don't see a problem here. It
>>> just means that a load balance hasn't happened for a while. It can
>>> even move backward if it has been set when busy but the cpu is now
>>> idle
>>=20
>> Sure, but I think it should at least set it by get_sd_balance_interval() i=
nto
>> the future. Like so (untested)? Let me know what you think and thanks!
>>=20
>> ---8<-----------------------
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a3318aeff9e8..0d6667d31c51 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -11314,6 +11314,30 @@ get_sd_balance_interval(struct sched_domain *sd,=
 int cpu_busy)
>>    return interval;
>> }
>>=20
>> +/*
>> + * Update the next balance from newidle balance.
>> + * The update of next_balance from newidle balance tries to make sure th=
at
>> + * we don't trigger periodic balance too far in the future on a now-idle=

>> + * system.  This is just like update_next_balance except that since
>> + * sd->last_balance may not have been updated for a while, we're careful=
 to
>> + * not set next_balance in the past.
>> + */
>> +static inline void
>> +update_next_balance_newidle(struct sched_domain *sd, unsigned long *next=
_balance)
>> +{
>> +    unsigned long interval, next;
>> +
>> +    /* used by new idle balance, so cpu_busy =3D 0 */
>> +    interval =3D get_sd_balance_interval(sd, 0);
>> +    next =3D sd->last_balance + interval;
>> +
>> +    next =3D max(next, jiffies + interval);
>> +
>> +    if (time_after(*next_balance, next)) {
>> +        *next_balance =3D next;
>> +    }
>> +}
>> +
>> static inline void
>> update_next_balance(struct sched_domain *sd, unsigned long *next_balance)=

>> {
>> @@ -12107,7 +12131,7 @@ static int newidle_balance(struct rq *this_rq, st=
ruct rq_flags *rf)
>>        (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>>=20
>>        if (sd)
>> -            update_next_balance(sd, &next_balance);
>> +            update_next_balance_newidle(sd, &next_balance);
>>        rcu_read_unlock();
>>=20
>>        goto out;
>> @@ -12124,7 +12148,7 @@ static int newidle_balance(struct rq *this_rq, st=
ruct rq_flags *rf)
>>        int continue_balancing =3D 1;
>>        u64 domain_cost;
>>=20
>> -        update_next_balance(sd, &next_balance);
>> +        update_next_balance_newidle(sd, &next_balance);
>>=20
>>        if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>>            break;
