Return-Path: <linux-kernel+bounces-107916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7EC880379
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B79282E23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D81BF2A;
	Tue, 19 Mar 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HN4uQQil"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63283179A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869395; cv=none; b=ttFffI8qRnlZvF0qLJIiT6eRDFKWrmqnRMOqmfr5uwiMWjp+RPpzVOzPeduoyBxPseacGefs9wySv4uoZIlZyksbUeXx8MpwZRX56PWuuV1owuCSumbP+0OhmYCX/KpXSRMw9FBm6jjzh8dJ8g71uDH0Y7echd84n77Ddq+kNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869395; c=relaxed/simple;
	bh=p5DlegjkqXmaO2leoq8/zMuptH6ZXgU5GSZvgXNBGzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXpmlFjjuI1wZlcpRGXLKTrO1eYJA3e+DhMoLRgAE5lxDEDIkChAa8EAgo60v9U3UqcJQHiYFFQFzbBT55IRml5SsTgyPILUojxzgHLc0Or3yFN3hs1jXYElXTrD8BiVLmFURH7D/SRpCLK/6ZjyiBaRWptv87Zj/W8Kd5ZrD40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=HN4uQQil; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6963c0c507eso855466d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710869392; x=1711474192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRSOwVQmD/LUS31oTkPPiVrE1LXL9Wggo9W1oa7Xqec=;
        b=HN4uQQiliF8H+21+jOszD1upgzY2VB1TseCOGPVfoHtWrxXuVSFQ3bYs0AzCwReVeL
         xKuolTuzKLDs6ncwFjsbCJe6cR1upOkfgwHuQNpWs/t608uEiSLv/wxvwGFlh8E8UPM7
         aTdYy+QgJR0Pov0xdKJ0hjX3ZqeULfthW1UOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710869392; x=1711474192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRSOwVQmD/LUS31oTkPPiVrE1LXL9Wggo9W1oa7Xqec=;
        b=EVsOyASFAr6pLaTNGnqcwkh92d2HI8YNMqFhyC7e+Zxn5pOmod1YXOgyH/CiGVlnkX
         dIRJoN+0le5sgkCCmXij784Ek9Cso8mumDOUrazft1duQ3Hmrpepn4sex5/rNgMf5z46
         YiLp7p8wuLzPvTMdEmDYyS4R8GP8fFM7i0aHMxbTxOTbBUVpOlDJTtUQkZADv9oz2o9E
         M0cDmXFYeHHvgPRZCsAnW7gGwIiDbO97LZWHa0M2yuQ06246obL3Hv7LMtukKOoj2ku3
         8AcDpDIbZ7k49P8MNyF9z8/ujE6yyiirGmXXmMSym7HQgydHDAhdM+C55cMxX1D6tfm2
         J+Zw==
X-Gm-Message-State: AOJu0YxY6rPcVjYAtUnzUyPIvRCtiDZ/v9+rBDvKRKGkkEkZv9pG8J45
	KvVi8FeI3kZSbts2P3reEjzRthPDXlwFhcqKmmz82VT/N+4bgE984OYHNKQaEiE=
X-Google-Smtp-Source: AGHT+IGu7LUL9quQcRUsQ0Nb34H4Ih+SoDe4tWH2pdqhjwvnhpTcHmsBT+sioVWp/+WorLokHQlYIA==
X-Received: by 2002:ad4:4eab:0:b0:68f:a954:bba1 with SMTP id ed11-20020ad44eab000000b0068fa954bba1mr5302484qvb.26.1710869392049;
        Tue, 19 Mar 2024 10:29:52 -0700 (PDT)
Received: from [10.5.0.2] ([185.195.59.198])
        by smtp.gmail.com with ESMTPSA id 15-20020ad45b8f000000b00690dbc390dcsm6681062qvp.89.2024.03.19.10.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 10:29:51 -0700 (PDT)
Message-ID: <8f221ab6-6d34-4c3b-a6a7-6c1de405000a@joelfernandes.org>
Date: Tue, 19 Mar 2024 13:29:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636> <20240319160252.GA186534@joelbox2>
 <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
 <ZfnKv1K85Nkwy7p4@pc638.lan>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZfnKv1K85Nkwy7p4@pc638.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/19/2024 1:26 PM, Uladzislau Rezki wrote:
> On Tue, Mar 19, 2024 at 12:11:28PM -0400, Joel Fernandes wrote:
>> On Tue, Mar 19, 2024 at 12:02 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>>>
>>> On Tue, Mar 19, 2024 at 03:48:46PM +0100, Uladzislau Rezki wrote:
>>>> On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
>>>>>
>>>>>
>>>>>> On Mar 19, 2024, at 5:53 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>>>>
>>>>>> ﻿On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
>>>>>>>
>>>>>>>
>>>>>>>>> On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
>>>>>>>>
>>>>>>>> ﻿Hello, Joel!
>>>>>>>>
>>>>>>>> Sorry for late checking, see below few comments:
>>>>>>>>
>>>>>>>>> In the synchronize_rcu() common case, we will have less than
>>>>>>>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
>>>>>>>>> is pointless just to free the last injected wait head since at that point,
>>>>>>>>> all the users have already been awakened.
>>>>>>>>>
>>>>>>>>> Introduce a new counter to track this and prevent the wakeup in the
>>>>>>>>> common case.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>>>>> ---
>>>>>>>>> Rebased on paul/dev of today.
>>>>>>>>>
>>>>>>>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
>>>>>>>>> kernel/rcu/tree.h |  1 +
>>>>>>>>> 2 files changed, 32 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
>>>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
>>>>>>>>>   .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
>>>>>>>>>   .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>>>>>>>>>       rcu_sr_normal_gp_cleanup_work),
>>>>>>>>> +    .srs_cleanups_pending = ATOMIC_INIT(0),
>>>>>>>>> };
>>>>>>>>>
>>>>>>>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
>>>>>>>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>>>>>>>>>    * the done tail list manipulations are protected here.
>>>>>>>>>    */
>>>>>>>>>   done = smp_load_acquire(&rcu_state.srs_done_tail);
>>>>>>>>> -    if (!done)
>>>>>>>>> +    if (!done) {
>>>>>>>>> +        /* See comments below. */
>>>>>>>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>>>>>>>>>       return;
>>>>>>>>> +    }
>>>>>>>>>
>>>>>>>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>>>>>>>>>   head = done->next;
>>>>>>>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>>>>>>>>>
>>>>>>>>>       rcu_sr_put_wait_head(rcu);
>>>>>>>>>   }
>>>>>>>>> +
>>>>>>>>> +    /* Order list manipulations with atomic access. */
>>>>>>>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> /*
>>>>>>>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>>>>>>>>> */
>>>>>>>>> static void rcu_sr_normal_gp_cleanup(void)
>>>>>>>>> {
>>>>>>>>> -    struct llist_node *wait_tail, *next, *rcu;
>>>>>>>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
>>>>>>>>>   int done = 0;
>>>>>>>>>
>>>>>>>>>   wait_tail = rcu_state.srs_wait_tail;
>>>>>>>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>>>>>>>           break;
>>>>>>>>>   }
>>>>>>>>>
>>>>>>>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
>>>>>>>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>>>>>>> +    /*
>>>>>>>>> +     * Fast path, no more users to process. Remove the last wait head
>>>>>>>>> +     * if no inflight-workers. If there are in-flight workers, let them
>>>>>>>>> +     * remove the last wait head.
>>>>>>>>> +     */
>>>>>>>>> +    WARN_ON_ONCE(!rcu);
>>>>>>>>>
>>>>>>>> This assumption is not correct. An "rcu" can be NULL in fact.
>>>>>>>
>>>>>>> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
>>>>>>> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
>>>>>>> him to rebase his patch on top of this one.
>>>>>>>
>>>>>>> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
>>>>>>>>
>>>>>> I think we should agree on your patch first otherwise it becomes a bit
>>>>>> messy or go with a Neeraj as first step and then work on youth. So, i
>>>>>> reviewed this patch based on latest Paul's dev branch. I see that Neeraj
>>>>>> needs further work.
>>>>>
>>>>> You are right. So the only change is to drop the warning and those braces. Agreed?
>>>>>
>>>> Let me check a bit. Looks like correct but just in case.
>>>>
>>>
>>> Thanks. I was also considering improving it for the rcu == NULL case, as
>>> below. I will test it more before re-sending.
>>>
>>> On top of my patch:
>>>
>>> ---8<-----------------------
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 0df659a878ee..a5ef844835d4 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>                         break;
>>>         }
>>>
>>> +
>>> +       /* Last head stays. No more processing to do. */
>>> +       if (!rcu)
>>> +               return;
>>> +
>>
>> Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
>> in any case, the original patch except the warning should hold.
>> Still, I am testing the above diff now.
>>
>>  - Joel
>>
> Just in case, it is based on your patch:
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bd29fe3c76bf..98546afe7c21 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1711,29 +1711,25 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	 * if no inflight-workers. If there are in-flight workers, let them
>  	 * remove the last wait head.
>  	 */
> -	WARN_ON_ONCE(!rcu);
> -	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> -
> -	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
> -		/* Order atomic access with list manipulation. */
> -		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> +	if (wait_tail->next && rcu_sr_is_wait_head(wait_tail->next) && !wait_tail->next->next &&
> +			!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {


Yes this also works. But also if wait_tail->next == NULL, then you do not need
to queue worker for that case as well. I sent this as v3.

If you want to add that and resend my patch with the above diff, that would also
be fine. Or I can do that, let me know.  Thanks!

 - Joel

