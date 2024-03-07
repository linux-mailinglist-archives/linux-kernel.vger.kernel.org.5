Return-Path: <linux-kernel+bounces-95038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B91874878
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0841C214DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214701CF8A;
	Thu,  7 Mar 2024 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Aqm7z3qX"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFA1CF8B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795388; cv=none; b=HSt56P7IDG/+EPNz05RWmMocdj2Df7v6o5YuGlY92wxEV76JH+yhZCbmHk8B1ionilLqUv5Qaf/J6B26fUqoJ42ddfNyO0Wy1qNehYD2yDAej1K45gEYnCaPNFFTcQ3tSfsk37xRyux8t08L9CfopYm1kSb8ZTLDy1YUOBesaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795388; c=relaxed/simple;
	bh=H3Oj7YVSjE5lygQ9LNeGdlfl3FllbKuGVmNq4NSs7XI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kZmIuVypAqh3NuaaaIT2AhcODGnbrXLXlpea+IrvOrF6C9+2umm40OmnLoOK9rMdhPNsFQSi1GDVlbn7fexlWjnECe5IeEpaMOOFXfBQQDMww1f8aS7h9aur4VrHsbqXmHR6bWlfkD4Znt/Be8FApy3qJUQQPTO3MtQyzqzrmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Aqm7z3qX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f51c5f9baso3097386d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709795384; x=1710400184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1wQ8L1RG9MA8OzGPeJCDbGLNl9WRFlezk1Chs/Lr88=;
        b=Aqm7z3qXA01DkSc9lwJpVizL1cMo781H4Hai57t4hPG9TA6oJGQuLhX1YhO7Fr3kYX
         ZBuhYIeBIBFy7R69Cq6fbFQj8EvJ+9gAPxgygFn4sI8955TkIEDvGmPu1ur1pH2kt4qJ
         ZSwlXPTDSsu8vpJhdYyTYa7tM65LAzWmM0+r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709795384; x=1710400184;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1wQ8L1RG9MA8OzGPeJCDbGLNl9WRFlezk1Chs/Lr88=;
        b=mVgt1wmMWChxKPRp/qgAMwF5utc9BbskIwXxyY2Q3pNNRz4z+DNXoNmhJBkpllxdo4
         teVwPjcI8SdzJAo0kh0I9MN62leUkvY+8apzhEpzlrG/PlQgk6ms4IGFuMJLW1+YrByk
         1lDG7NBpZLjGaKyxQZZZ207XsuYCO64DDtlocXS/S+ftIKXK1hejfTqh17uL1QljJFIO
         ZGF+5+TVpVuk2ytsGPDB4JkXjaQBjy3JFIp6ka8TrYm4SegmLfTGSFnO9KhA2moy+rLr
         uC9h9lmjx/1lcWAzj/du5Hc4LGDqXdCb+FHrNGEDf8D46CechEoTYivumPuDMf6hNeF4
         q0bg==
X-Forwarded-Encrypted: i=1; AJvYcCVgn8r0zgo+keTVyam8rfGqofBUJm+y44+dr84VvlxP9P10n2gtrzwfn9PpCFT1UlfWVMQ6tan3HpGg00SUdqKZWQ3jLQ27mkmKYb0Y
X-Gm-Message-State: AOJu0YxfzpSL4db2PIY4FIfmjTTwcxd2q0nkWX7z1WHrw8Lwq+nH42Zl
	ZJgwZzS7Yy7wIUGLpESnF7OVqnx9k4UNFzuiWNPpCMbkamI18i2ffwOMhdXnBtc=
X-Google-Smtp-Source: AGHT+IFzhppjHQaX7O0665/0IPiMifOekpbbC6B5+P8WIxI8E9LfaAjThGA/yXzfKgbetKi9sXoWWw==
X-Received: by 2002:a0c:f9c1:0:b0:690:99a2:cd5a with SMTP id j1-20020a0cf9c1000000b0069099a2cd5amr3460932qvo.10.1709795384130;
        Wed, 06 Mar 2024 23:09:44 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id qo17-20020a056214591100b00690459b2271sm8328963qvb.24.2024.03.06.23.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:09:43 -0800 (PST)
Message-ID: <648f31c5-e67c-4605-9ebd-7450e96a2dbe@joelfernandes.org>
Date: Thu, 7 Mar 2024 02:09:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
 <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>
In-Reply-To: <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/2024 1:21 AM, Joel Fernandes wrote:
> 
> 
> On 3/6/2024 5:31 PM, Joel Fernandes wrote:
>>
>>
>> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
>>> Fix a below race by not releasing a wait-head from the
>>> GP-kthread as it can lead for reusing it whereas a worker
>>> can still access it thus execute newly added callbacks too
>>> early.
>>>
>>> CPU 0                              CPU 1
>>> -----                              -----
>>>
>>> // wait_tail == HEAD1
>>> rcu_sr_normal_gp_cleanup() {
>>>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>>>     wait_tail->next = next;
>>>     // done_tail = HEAD1
>>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>     queue_work() {
>>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>>>         __queue_work()
>>>     }
>>> }
>>>
>>>                                set_work_pool_and_clear_pending()
>>>                                rcu_sr_normal_gp_cleanup_work() {
>>> // new GP, wait_tail == HEAD2
>>> rcu_sr_normal_gp_cleanup() {
>>>     // executes all completion, but stop at HEAD1
>>>     wait_tail->next = HEAD1;
>>>     // done_tail = HEAD2
>>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>     queue_work() {
>>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>>>         __queue_work()
>>>     }
>>> }
>>>                                  // done = HEAD2
>>>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
>>>                                  // head = HEAD1
>>>                                  head = done->next;
>>>                                  done->next = NULL;
>>>                                  llist_for_each_safe() {
>>>                                  // completes all callbacks, release HEAD1
>>>                                  }
>>>                                }
>>>                                // Process second queue
>>>                                set_work_pool_and_clear_pending()
>>>                                rcu_sr_normal_gp_cleanup_work() {
>>>                                // done = HEAD2
>>>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
>>>
>>> // new GP, wait_tail == HEAD3
>>> rcu_sr_normal_gp_cleanup() {
>>>     // Finds HEAD2 with ->next == NULL at the end
>>>     rcu_sr_put_wait_head(HEAD2)
>>>     ...
>>>
>>> // A few more GPs later
>>> rcu_sr_normal_gp_init() {
>>>      HEAD2 = rcu_sr_get_wait_head();
>>>      llist_add(HEAD2, &rcu_state.srs_next);
>>>                                // head == rcu_state.srs_next
>>>                                head = done->next;
>>>                                done->next = NULL;
>>>                                llist_for_each_safe() {
>>>                                 // EXECUTE CALLBACKS TOO EARLY!!!
>>>                                 }
>>>                                }
>>>
>>> Reported-by: Frederic Weisbecker <frederic@kernel.org>
>>> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>  kernel/rcu/tree.c | 22 ++++++++--------------
>>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 31f3a61f9c38..475647620b12 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>>  
>>>  	/*
>>> -	 * Process (a) and (d) cases. See an illustration. Apart of
>>> -	 * that it handles the scenario when all clients are done,
>>> -	 * wait-head is released if last. The worker is not kicked.
>>> +	 * Process (a) and (d) cases. See an illustration.
>>>  	 */
>>>  	llist_for_each_safe(rcu, next, wait_tail->next) {
>>> -		if (rcu_sr_is_wait_head(rcu)) {
>>> -			if (!rcu->next) {
>>> -				rcu_sr_put_wait_head(rcu);
>>> -				wait_tail->next = NULL;
>>> -			} else {
>>> -				wait_tail->next = rcu;
>>> -			}
>>> -
>>> +		if (rcu_sr_is_wait_head(rcu))
>>>  			break;
>>> -		}
>>>  
>>>  		rcu_sr_normal_complete(rcu);
>>>  		// It can be last, update a next on this step.
>>> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>>>  
>>> -	if (wait_tail->next)
>>> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>> +	/*
>>> +	 * We schedule a work in order to perform a final processing
>>> +	 * of outstanding users(if still left) and releasing wait-heads
>>> +	 * added by rcu_sr_normal_gp_init() call.
>>> +	 */
>>> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>>  }
> 
> One question, why do you need to queue_work() if wait_tail->next == NULL?
> 
> AFAICS, at this stage if wait_tail->next == NULL, you are in CASE f. so the last
> remaining HEAD stays?  (And llist_for_each_safe() in
> rcu_sr_normal_gp_cleanup_work becomes a NOOP).
> 

Never mind, sorry for spewing nonsense. You can never end up with CASE f here so
you still need the queue_work(). I think it is worth looking into how to free
the last HEAD, without queuing a work though (while not causing wreckage).

thanks,

 - Joel


