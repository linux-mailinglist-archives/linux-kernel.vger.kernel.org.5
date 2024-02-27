Return-Path: <linux-kernel+bounces-84171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75886A350
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2832A291ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8355E48;
	Tue, 27 Feb 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bO6sNmPE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667255C2C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075151; cv=none; b=NCoiOQHr3+wXDOYMVveiaPsXCvWXB/y52n6eBCvK74ITTPDCtMR3y8sMWN0jQglzWwN19tgvLcTC4g7d11pTXZ+AP1ASnFVaUZuZxSokO5LMIRxnW0OGSxFO7P8dv7LRZ97lrL4ieFxInwRgLN8vu2BjQjK2aWXl3utTsbrRQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075151; c=relaxed/simple;
	bh=6LnhYVWIZ5kUVkapaxoOLhyJBetUqEtII+ABNwBvd2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPolrix61h5OENrJZps6EBFrxgtxT1uSLePp61y+0c/huHBgTXim+IdoTeSJNDwAGeG3wH6qJagsRIsxotj1tAa9kjGY32C3J7ZFF+xUQ7JfOymGffmVFcdXtZfPdRjPlaiS5YeAcyOxM25lYmVtBnuE49O3GMboDO328PODv5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bO6sNmPE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33dd2f0a0c4so1995892f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709075148; x=1709679948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JsCT02Xcuh9sC50sVTtsWlA8/Z9Tw5bA+OWtGAWjyuk=;
        b=bO6sNmPEvehJfjZJzCshoxudaE8Tlus2avzMRSMiVuF3+Ug3+lAIDHoCDJqK4lkPY+
         E2vh1uJh1h7fEwikzDexBxtAYl1mEvwxVS+MEuHPhcWm9Mi3q2urZYii2l9xI9aW9gm/
         H1BQBn8CJq7qUtsRk94rNfiR1XTLX1xy6fipiHm5feo7BjUoOdfTArd5i0X3mJX5h04+
         QnVIWRug3ZTYn4GrQ+pk+b8nwkMY/vTeQKPPJsz0DXs99UjQ/U4rHvvmsE2V3X8sPt5n
         0ikqdt2n5ZsD/aJO3CkhtR0A9WKMbo2UToJCe3C7EBbkMBhUCQnaZp3o9QcxUs6DuT6a
         FdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075148; x=1709679948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsCT02Xcuh9sC50sVTtsWlA8/Z9Tw5bA+OWtGAWjyuk=;
        b=I2lXO6KcH/EsgNODu0rHo3XlvZRW1TsASNRrxRnpUGFwJt2fOm8cGNqMspkDm/TteJ
         a9kFSGBQXe7QOvj99A93C8sSrC/d7CfRSYepoh7Z7ckz5Yh+qCTCJ1Ufzzx/kgRd04ZN
         4q+W6CwasK427s8KzUQw8uXPsHjJ7+cH+i/Y0neBPpJ+OKSjrUG2Ao/q4CKjD52Xf0Yp
         udxQH8Jc3LTdlANgkKtbByu+G3PgXjxak1kLgFhL3LTsfCt5MhRmz2Ddq0j6ZN2qZs4T
         gHrFN/uTNEqyYkURHD6/RewPWBcPN6pkaGrUqstJahqv5nJCkxy3+2aMyAoplBMxHZbB
         6JBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZjNGxjojaf2/UgcZY4y4zRqxiaE4MQdiQ6hi7sUTKHbMntBDImTHYZNp156JKaVd+S5CdzK4hwQNFt6yBwbrVmIE4xeAzt5PO0bZ
X-Gm-Message-State: AOJu0YxbxQ2kOQrLW5f/jHlFHyZeQqyNyFyiyAgejV63vmi3E+KUqgMT
	299606MsDYKnvy+sF1tYSrTixg0P0uZhPVGUCfLq+7t2nLcYqImXUOss3Il59RU=
X-Google-Smtp-Source: AGHT+IE+YabItcvT/Tlw+2YDOfdGwmkjDT3Kn/2+245AScOpPt2TEyRXdZhxzvgZMXHrcHABtcgboA==
X-Received: by 2002:a5d:674b:0:b0:33a:eb10:e9e8 with SMTP id l11-20020a5d674b000000b0033aeb10e9e8mr7827353wrw.43.1709075148355;
        Tue, 27 Feb 2024 15:05:48 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:1:102c:cc03:e11a:c6de? ([2620:10d:c092:500::6:94ac])
        by smtp.gmail.com with ESMTPSA id dq2-20020a0560000cc200b0033b483d1abcsm12574524wrb.53.2024.02.27.15.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:05:48 -0800 (PST)
Message-ID: <14d4705c-48a8-4d38-8132-7b849286137c@davidwei.uk>
Date: Tue, 27 Feb 2024 23:05:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to an
 unsigned int
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
References: <20240227211152.1099534-1-axboe@kernel.dk>
 <20240227211152.1099534-2-axboe@kernel.dk>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240227211152.1099534-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-27 21:06, Jens Axboe wrote:
> In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
> rq lock, and in the 4th one we can just grab it. This avoids an atomic
> in the scheduler fast path if we're in iowait, with the tradeoff being
> that we'll grab the rq lock for the case where a task is scheduled out
> in iowait mode on one CPU, and scheduled in on another CPU.
> 
> This obviously leaves the reading side as potentially racy, but that
> should be OK. iowait states change all of the time, and can change while
> it's being read as well, or summed up.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/sched/core.c    | 15 ++++++++++-----
>  kernel/sched/cputime.c |  2 +-
>  kernel/sched/sched.h   |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9116bcc90346..ecc6c26096e5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3789,7 +3789,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
>  #endif
>  	if (p->in_iowait) {
>  		delayacct_blkio_end(p);
> -		atomic_dec(&task_rq(p)->nr_iowait);
> +		task_rq(p)->nr_iowait--;
>  	}
>  
>  	activate_task(rq, p, en_flags);
> @@ -4354,8 +4354,13 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
>  		if (task_cpu(p) != cpu) {
>  			if (p->in_iowait) {
> +				struct rq *rq = task_rq(p);
> +				struct rq_flags rf;
> +
> +				rq_lock(rq, &rf);
> +				task_rq(p)->nr_iowait--;

Could this use rq directly, or does it not matter?

> +				rq_unlock(rq, &rf);
>  				delayacct_blkio_end(p);
> -				atomic_dec(&task_rq(p)->nr_iowait);
>  			}
>  
>  			wake_flags |= WF_MIGRATED;
> @@ -5463,7 +5468,7 @@ unsigned long long nr_context_switches(void)
>  
>  unsigned int nr_iowait_cpu(int cpu)
>  {
> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +	return cpu_rq(cpu)->nr_iowait;
>  }
>  
>  /*
> @@ -6681,7 +6686,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
>  
>  			if (prev->in_iowait) {
> -				atomic_inc(&rq->nr_iowait);
> +				rq->nr_iowait++;
>  				delayacct_blkio_start();
>  			}
>  		}
> @@ -10029,7 +10034,7 @@ void __init sched_init(void)
>  #endif
>  #endif /* CONFIG_SMP */
>  		hrtick_rq_init(rq);
> -		atomic_set(&rq->nr_iowait, 0);
> +		rq->nr_iowait = 0;

I checked that both ttwu_do_activate() and __schedule() have the rq lock
held, but I couldn't find it for this. Is it under the assumption that
the rq is in a pre-init state (maybe because scheduler_running = 0?) so
no lock is needed?

>  
>  #ifdef CONFIG_SCHED_CORE
>  		rq->core = rq;
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..b970b6c6151e 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -224,7 +224,7 @@ void account_idle_time(u64 cputime)
>  	u64 *cpustat = kcpustat_this_cpu->cpustat;
>  	struct rq *rq = this_rq();
>  
> -	if (atomic_read(&rq->nr_iowait) > 0)
> +	if (rq->nr_iowait)
>  		cpustat[CPUTIME_IOWAIT] += cputime;
>  	else
>  		cpustat[CPUTIME_IDLE] += cputime;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 001fe047bd5d..a1222a4bdc7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1049,7 +1049,7 @@ struct rq {
>  	u64			clock_idle_copy;
>  #endif
>  
> -	atomic_t		nr_iowait;
> +	unsigned int		nr_iowait;
>  
>  #ifdef CONFIG_SCHED_DEBUG
>  	u64 last_seen_need_resched_ns;

