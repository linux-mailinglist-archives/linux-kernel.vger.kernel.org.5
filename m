Return-Path: <linux-kernel+bounces-94659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1352C8742CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109F52865A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631A1C287;
	Wed,  6 Mar 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r4D0hzFV"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A31BF3A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764298; cv=none; b=ouWbjOMR2vaITD/E47JJiQ7g0dxSQm5/kyf90Szfe770Z+NEYHzx9S/qdzH5GV9ids5nNGNwmfB4n2HzlA55oXxkoYdGKu/EMmTglks3BfvQyMg2bEgdybfNFmyrCJBzc2QfF1PK1w5s9BNZIw6UMPeRl5OIxmDPU9qjusvSfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764298; c=relaxed/simple;
	bh=jkSMKZEFyxNvIFUBBjp88Ty49k82+UaKm/wURkvGw/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQShkUq5w/Tw5lHHl1e6khOVCFK98j7DtDvqAvH2XoQhdgz2eld4T/Fvd9Lv5lyDDlXK7lAVV/j3onEHFtNsbt4nUGx58nOvKR7IvS/fiHK6VuREAv2FCCFiM2pQcGfeBKc1pTEW5T0uLHCkv9ckL1QqgjFPtGhpkk4lb3WIOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=r4D0hzFV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-787990149edso17756785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709764296; x=1710369096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccC1RjbQc1nU+spx5FRTry+2Kx/osM9yVi3iCqRXg8Y=;
        b=r4D0hzFVaaJhH51Kvgg5Vto9E+t22tFnrGU5ep3gA3rWD9xvwb2BHuwBFEuFH8YNe0
         nBsRL9vzRTZu7y+qPs6drt+lpdgQuqdLb90T3QYpti4qTjCp+UbbEde4+8HZuzIkWrkC
         OmtBS+TJrqiOslWPVUgZtOiLjIyBByQIezBVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764296; x=1710369096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccC1RjbQc1nU+spx5FRTry+2Kx/osM9yVi3iCqRXg8Y=;
        b=GB+pAcmfZvfHFcKV+GBCg8vQumy5UUJM6dfN7qhYw0jbj9YxOjFaIMFjvxdCgAmyfG
         aP60aIerSJAZWzG9KBYGUF3moQVSBjowico65aqjIO9K1NcVQeNKw2QrzjRb1YjsFH0A
         Daj0AhTu/M5/ckwDthNFweABq4sMuK4SSLjGTW5TcyFz+7SOAtPXCAmPfeBYnOvMaNMk
         Ex4lUTuKFUHeKeDXuYQMptgra8dpvrx9Fm9MU1G+w4wMA2iLoICAgjDHC0/zM14QExkP
         NZWw1yOJ8nAa6vypaO+yFvUVDLU4PcG2I97y+jXnL+cAvpe7O0qkgJQTV9qMiMSGPQJ/
         6DaA==
X-Forwarded-Encrypted: i=1; AJvYcCXgI5raAEAeqmzoGj3eTaKr40MIfkgKYfsYFcEVs4tIvI3il3lq07NmmROssdq6KvLXXUKiwJfW1SIk0R8b9qr6ksoC4Srp2lVXsEJ9
X-Gm-Message-State: AOJu0Yxz2EWwRlilB8zBXwubUHHof/lPx1CiK0+FBrbtvPS01dXiLl4T
	h00iwQm+ijyaxsY9FAjKwNA/ynLvF/SrA/1XUm0RjyUHEu2VKBmlEA0Fjsu6WDE=
X-Google-Smtp-Source: AGHT+IH++yr29yZ5WbfVsxOX2gr4gXWx4Hz/S3XIV7e2NQWcArHdiM0Do43GTxg1UJnI3qM9xO1pfA==
X-Received: by 2002:ae9:e118:0:b0:787:aacc:d8d with SMTP id g24-20020ae9e118000000b00787aacc0d8dmr7114726qkm.23.1709764295799;
        Wed, 06 Mar 2024 14:31:35 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a11b000b0078822c45424sm4317689qkk.127.2024.03.06.14.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 14:31:35 -0800 (PST)
Message-ID: <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
Date: Wed, 6 Mar 2024 17:31:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Content-Language: en-US
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240305195720.42687-1-urezki@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240305195720.42687-1-urezki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
> Fix a below race by not releasing a wait-head from the
> GP-kthread as it can lead for reusing it whereas a worker
> can still access it thus execute newly added callbacks too
> early.
> 
> CPU 0                              CPU 1
> -----                              -----
> 
> // wait_tail == HEAD1
> rcu_sr_normal_gp_cleanup() {
>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>     wait_tail->next = next;
>     // done_tail = HEAD1
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
> 
>                                set_work_pool_and_clear_pending()
>                                rcu_sr_normal_gp_cleanup_work() {
> // new GP, wait_tail == HEAD2
> rcu_sr_normal_gp_cleanup() {
>     // executes all completion, but stop at HEAD1
>     wait_tail->next = HEAD1;
>     // done_tail = HEAD2
>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>     queue_work() {
>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>         __queue_work()
>     }
> }
>                                  // done = HEAD2
>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
>                                  // head = HEAD1
>                                  head = done->next;
>                                  done->next = NULL;
>                                  llist_for_each_safe() {
>                                  // completes all callbacks, release HEAD1
>                                  }
>                                }
>                                // Process second queue
>                                set_work_pool_and_clear_pending()
>                                rcu_sr_normal_gp_cleanup_work() {
>                                // done = HEAD2
>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
> 
> // new GP, wait_tail == HEAD3
> rcu_sr_normal_gp_cleanup() {
>     // Finds HEAD2 with ->next == NULL at the end
>     rcu_sr_put_wait_head(HEAD2)
>     ...
> 
> // A few more GPs later
> rcu_sr_normal_gp_init() {
>      HEAD2 = rcu_sr_get_wait_head();
>      llist_add(HEAD2, &rcu_state.srs_next);
>                                // head == rcu_state.srs_next
>                                head = done->next;
>                                done->next = NULL;
>                                llist_for_each_safe() {
>                                 // EXECUTE CALLBACKS TOO EARLY!!!
>                                 }
>                                }
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 31f3a61f9c38..475647620b12 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>  
>  	/*
> -	 * Process (a) and (d) cases. See an illustration. Apart of
> -	 * that it handles the scenario when all clients are done,
> -	 * wait-head is released if last. The worker is not kicked.
> +	 * Process (a) and (d) cases. See an illustration.
>  	 */
>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> -		if (rcu_sr_is_wait_head(rcu)) {
> -			if (!rcu->next) {
> -				rcu_sr_put_wait_head(rcu);
> -				wait_tail->next = NULL;
> -			} else {
> -				wait_tail->next = rcu;
> -			}
> -
> +		if (rcu_sr_is_wait_head(rcu))
>  			break;
> -		}
>  
>  		rcu_sr_normal_complete(rcu);
>  		// It can be last, update a next on this step.
> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>  
> -	if (wait_tail->next)
> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> +	/*
> +	 * We schedule a work in order to perform a final processing
> +	 * of outstanding users(if still left) and releasing wait-heads
> +	 * added by rcu_sr_normal_gp_init() call.
> +	 */
> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>  }

Ah, nice. So instead of allocating/freeing in GP thread and freeing in worker,
you allocate heads only in GP thread and free them only in worker, thus
essentially fixing the UAF that Frederick found.

AFAICS, this fixes the issue.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

There might a way to prevent queuing new work as fast-path optimization, incase
the CBs per GP will always be < SR_MAX_USERS_WAKE_FROM_GP but I could not find a
workqueue API that helps there, and work_busy() has comments saying not to use that.

thanks,

 - Joel


