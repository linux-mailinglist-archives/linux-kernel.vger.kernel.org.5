Return-Path: <linux-kernel+bounces-95008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BDD87480F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64694B22E4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923F322626;
	Thu,  7 Mar 2024 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eDBsA1hQ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AA1BF31
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 06:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792519; cv=none; b=oWCq2wGti3ppyyHUQIeH4xKNjOdhmv4iKbKHwLAoph6uubBkPigSw3KaOqN8e5zMeCiKFOm+LNBXJOMmLxSg05y5//XDTxZAclQOux1AXQytTOJcMiytLGp+zIfF0Plwuz4vFMZDsuxm0V1LGvUUrNr4XkV37kAwBtfy1+rBD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792519; c=relaxed/simple;
	bh=QKwzNGAsKsvRTs/1Psocg21Y9gPoueC9GIDaUhtN3LU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HTpojGnDYJ+K0eJOFgDjrOdrPJfHMDO3JiYBSno9wQ6+AZCgyYzodgXQ/DxGTFJldyMpn67+WJkfNg+9bmfgRo1ulB4vKOSn4hNzeG/46WxParOC3lSezcNcSEgTKOg7TaVp0bRRzW8fCmWIMrzB0pldwhmt0aHjTYzZrixh5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=eDBsA1hQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f5cdca7a3so13014076d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 22:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709792516; x=1710397316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImzynJrvqwnXUnHjeXPOvdUqQOzMzF7+CE154eZIXmo=;
        b=eDBsA1hQHAgEV8aHc0nuN/omxBZnhCJ2t/FIvkHo/ux1o677HRqg/3Xg2BrzdWcik1
         OnPqASsdrb27SxkgNODcNACzlMAjHwNKRkFuSmmVX2fucXDSBjA5K3HWmEJF1nfXzFUL
         Fl2ZjvCptujOb0H7EBmSbhq8Fz/QuyUjVbuts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792516; x=1710397316;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImzynJrvqwnXUnHjeXPOvdUqQOzMzF7+CE154eZIXmo=;
        b=ROfO6wPITTrPJ5Q6XY5z10ePi0ydw9dFpLPyzW9ZFYdISHGASfPtRJMasz8vAfm5RO
         UdSucABMBzyzhlpPKNbZLp1xUTuO9ta6dhv7J9GAqlGbb3g/86jWBc9pJv1D1BdNPOY4
         2Lj6C+bKpO5kFoG7SdNzc926Le++f/s3TsE6DLAcKpGleUICBJUX7O8IjlcvoZer9OuN
         oGTW2JP2qYsieNoiKDLRN3pCFnJtYAJYZZJ9DjRqkp3tTQpna6OqPINEvYjEX43doWzm
         1RvGtdZhwUgZXl+8gVKfAYQqU+fmVQa4hf0zHVpowG4QITcJOSyaC/oTwFkJIaADVLcy
         6/4w==
X-Forwarded-Encrypted: i=1; AJvYcCUABwT6ZCRazrQsTsMyzdvPg7Gxu0e7JEKRRdKczrhOs46CKIXheVFb46VdHrOItbXy4JdZDMzasWsCQuUNc3mXf3PFH4LfeZTvLoED
X-Gm-Message-State: AOJu0YymrGiJqUSWrQ1UH92NRsT3P4cSOPLr/wB0/WpnAPFP+EsXkNHa
	x2Xrh8APuU4/CbGTiPHCN8Orjuuc3/sR2H7vXhfwoR3IgMjWM6cC72aoBPIQjUk=
X-Google-Smtp-Source: AGHT+IEUHmSxAYv6krmrCkWACPHTjZZ0qM1Lexgz4DY/Diu+g2F2ILXdGJS83UruM29x7RqIp5pb2A==
X-Received: by 2002:a05:6214:5588:b0:690:a672:a107 with SMTP id mi8-20020a056214558800b00690a672a107mr211509qvb.0.1709792516084;
        Wed, 06 Mar 2024 22:21:56 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id lq9-20020a0562145b8900b0069055b05705sm7219808qvb.132.2024.03.06.22.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 22:21:55 -0800 (PST)
Message-ID: <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>
Date: Thu, 7 Mar 2024 01:21:50 -0500
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
In-Reply-To: <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/2024 5:31 PM, Joel Fernandes wrote:
> 
> 
> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
>> Fix a below race by not releasing a wait-head from the
>> GP-kthread as it can lead for reusing it whereas a worker
>> can still access it thus execute newly added callbacks too
>> early.
>>
>> CPU 0                              CPU 1
>> -----                              -----
>>
>> // wait_tail == HEAD1
>> rcu_sr_normal_gp_cleanup() {
>>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>>     wait_tail->next = next;
>>     // done_tail = HEAD1
>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>     queue_work() {
>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>>         __queue_work()
>>     }
>> }
>>
>>                                set_work_pool_and_clear_pending()
>>                                rcu_sr_normal_gp_cleanup_work() {
>> // new GP, wait_tail == HEAD2
>> rcu_sr_normal_gp_cleanup() {
>>     // executes all completion, but stop at HEAD1
>>     wait_tail->next = HEAD1;
>>     // done_tail = HEAD2
>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>     queue_work() {
>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>>         __queue_work()
>>     }
>> }
>>                                  // done = HEAD2
>>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
>>                                  // head = HEAD1
>>                                  head = done->next;
>>                                  done->next = NULL;
>>                                  llist_for_each_safe() {
>>                                  // completes all callbacks, release HEAD1
>>                                  }
>>                                }
>>                                // Process second queue
>>                                set_work_pool_and_clear_pending()
>>                                rcu_sr_normal_gp_cleanup_work() {
>>                                // done = HEAD2
>>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
>>
>> // new GP, wait_tail == HEAD3
>> rcu_sr_normal_gp_cleanup() {
>>     // Finds HEAD2 with ->next == NULL at the end
>>     rcu_sr_put_wait_head(HEAD2)
>>     ...
>>
>> // A few more GPs later
>> rcu_sr_normal_gp_init() {
>>      HEAD2 = rcu_sr_get_wait_head();
>>      llist_add(HEAD2, &rcu_state.srs_next);
>>                                // head == rcu_state.srs_next
>>                                head = done->next;
>>                                done->next = NULL;
>>                                llist_for_each_safe() {
>>                                 // EXECUTE CALLBACKS TOO EARLY!!!
>>                                 }
>>                                }
>>
>> Reported-by: Frederic Weisbecker <frederic@kernel.org>
>> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> ---
>>  kernel/rcu/tree.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 31f3a61f9c38..475647620b12 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
>>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>  
>>  	/*
>> -	 * Process (a) and (d) cases. See an illustration. Apart of
>> -	 * that it handles the scenario when all clients are done,
>> -	 * wait-head is released if last. The worker is not kicked.
>> +	 * Process (a) and (d) cases. See an illustration.
>>  	 */
>>  	llist_for_each_safe(rcu, next, wait_tail->next) {
>> -		if (rcu_sr_is_wait_head(rcu)) {
>> -			if (!rcu->next) {
>> -				rcu_sr_put_wait_head(rcu);
>> -				wait_tail->next = NULL;
>> -			} else {
>> -				wait_tail->next = rcu;
>> -			}
>> -
>> +		if (rcu_sr_is_wait_head(rcu))
>>  			break;
>> -		}
>>  
>>  		rcu_sr_normal_complete(rcu);
>>  		// It can be last, update a next on this step.
>> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
>>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>>  
>> -	if (wait_tail->next)
>> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>> +	/*
>> +	 * We schedule a work in order to perform a final processing
>> +	 * of outstanding users(if still left) and releasing wait-heads
>> +	 * added by rcu_sr_normal_gp_init() call.
>> +	 */
>> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>  }

One question, why do you need to queue_work() if wait_tail->next == NULL?

AFAICS, at this stage if wait_tail->next == NULL, you are in CASE f. so the last
remaining HEAD stays?  (And llist_for_each_safe() in
rcu_sr_normal_gp_cleanup_work becomes a NOOP).

Could be something like this, but maybe I missed something:

@@ -1672,7 +1674,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct
work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-       struct llist_node *wait_tail, *next, *rcu;
+       struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
        int done = 0;

        wait_tail = rcu_state.srs_wait_tail;
@@ -1707,7 +1709,8 @@ static void rcu_sr_normal_gp_cleanup(void)
         * of outstanding users(if still left) and releasing wait-heads
         * added by rcu_sr_normal_gp_init() call.
         */
-       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
+       if (rcu)
+               queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
 }

 /*

