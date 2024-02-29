Return-Path: <linux-kernel+bounces-87643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F8886D6DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0134C1C229E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5B1EB25;
	Thu, 29 Feb 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QWOF5Bbc"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF175806
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245812; cv=none; b=EXbZy+ZQKqTbV0QNsXZf441YUOMe0uilaz9f8DMo2Pirm3QV33uZA4QNyBVzf/qXpB/qsdNm7ldSj3D/3cWGbzCJD5esF8ZYCaX41n/FXA7dzxKUbXzNsmmyKFfA6CN+a7Hx1gUtpCwGCERKZaJzFFkJpWMUJ0exGpFLmEAq2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245812; c=relaxed/simple;
	bh=ksGtm/5gNB2SDcc56ws1PH4Lx+1Qb6E+zBOZVEOn7N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcmJRM8Mr0rTPpDs8PBXQmYrW4IVi9PPT1lY8XroUkbfqJ64taj1hHGio5gBigrjnaoHMeocd90N2FYBQBuWRKfCi4lz2788hCecIsBGoWG130fYbu7iTKJs3lbqzzP8jEt75cZX1BG9zhEvOQcXxhJtVqe4qGw5iV2BiPix1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QWOF5Bbc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-58962bf3f89so379857a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709245808; x=1709850608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ErM6yfCYTg/4I2BkMDH9uBO1PPmextOkga5IOfLrxE=;
        b=QWOF5BbcYwRPsCAqOEa6AwwgH5KOhEgYvTpo0iVAsPm2eTYz1yPGU1H8oE9U/K/cgQ
         aF8fMnET2U8u6K2pj9EOY1VqiTpODOjAUctcJPbur0C+TsDgZvFdk5TnKXl7FpVpdUWI
         2uaU7r/C7oi6UWr0oWWRLUu5VJ9FiOnWr+KmtFSiU3m3jyjXVpI9/qZ8jvGghOUB0gaj
         mRE6yN+K0G+Bj755dbULq7CqYuEZ/NIhhFU7EaABHXh+XyoZAXLxN4N3/dNBl9PJQahj
         Ec/vY242i4j+PIJpzUVetjHuawimXrSodzpGTsQZEpqBM5L5rSG9Dl07uHvFvxeRJ/MQ
         nTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245808; x=1709850608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ErM6yfCYTg/4I2BkMDH9uBO1PPmextOkga5IOfLrxE=;
        b=ryg1ZTGB9S32FJ9+svaFA0kjKsx7dcKqhU3Auxxi559k07PVPGIluuzbBvGOlh/BUU
         n1LcPZ7e2AhBxdkE6OYw7W/NdBDEyD0QjcXcOWTf81Ie1eyaJwoSUrLn2NpHSKo0ZmWa
         gQndzYFJpCfDJEPp22bLjd0i2w65mLoh/tsT7LiGuXMVq/4xScOEOe9CYtDdfWBlFzrA
         X7AslzouQqt4pcXMTwqvS3g6j8cZTzpnSrJh5hmvZBX6sQjWWtE10l1IahCwc6qdIKXw
         gI6EAGsGhT5TI34H3luY2ttye3gF6HQwaPIn3XGY6Yb7ibCTnXKGYRDtBcuPjo7UXaCb
         wT4w==
X-Forwarded-Encrypted: i=1; AJvYcCUeXhEd7A2E1fTCR5RgZNc5EON4HgG86vxOBYI4GIWi6VsHn5wPE4pm3BOx9qfCWUbhx/zoTF/oLV1lnjRpFJh/zte9V3CbooEnlKZl
X-Gm-Message-State: AOJu0YzHWTXK4JsgBg3TXpS+9GktKxcF9zBO9Tjby+5r/GTW8ZBj3B1x
	PASEkKnll2bxdk3KJbByMy2jV+CFqouNrzt/VN6tK6SRhQ/RfVRsVFTDQcMUb9YGSe0I2/sYdQp
	P
X-Google-Smtp-Source: AGHT+IGWKCtA6Zf6rGTf8KFQDAk6iBuDB7rLaEaeaJpmkhjLQJmJbDe5WGRw7H3twizGcFF8FDVGeA==
X-Received: by 2002:a05:6a20:9385:b0:1a1:2b54:ac99 with SMTP id x5-20020a056a20938500b001a12b54ac99mr3058157pzh.5.1709245808247;
        Thu, 29 Feb 2024 14:30:08 -0800 (PST)
Received: from ?IPV6:2600:380:7653:c550:3a45:5983:5159:8b0c? ([2600:380:7653:c550:3a45:5983:5159:8b0c])
        by smtp.gmail.com with ESMTPSA id l185-20020a6388c2000000b005dab535fac2sm1785812pgd.90.2024.02.29.14.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 14:30:07 -0800 (PST)
Message-ID: <f1fc564c-528a-47d0-8b68-d596d6681eb5@kernel.dk>
Date: Thu, 29 Feb 2024 15:30:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
 <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk> <87wmqn6uaw.ffs@tglx>
 <edd520ab-b95f-4a60-a35a-2490a6d5057f@kernel.dk> <87sf1b6o9w.ffs@tglx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87sf1b6o9w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 12:52 PM, Thomas Gleixner wrote:
> On Thu, Feb 29 2024 at 10:49, Jens Axboe wrote:
>> On 2/29/24 10:42 AM, Thomas Gleixner wrote:
>>> So but I just noticed that there is actually an issue with this:
>>>
>>>>  unsigned int nr_iowait_cpu(int cpu)
>>>>  {
>>>> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>>>> +	struct rq *rq = cpu_rq(cpu);
>>>> +
>>>> +	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
>>>
>>> The access to rq->nr_iowait is not protected by the runqueue lock and
>>> therefore a data race when @cpu is not the current CPU.
>>>
>>> This needs to be properly annotated and explained why it does not
>>> matter.
>>
>> But that was always racy before as well, if someone else is inc/dec'ing
>> ->nr_iowait while it's being read, you could get either the before or
>> after value. This doesn't really change that. I could've sworn I
>> mentioned that in the commit message, but I did not.
> 
> There are actually two issues here:
> 
> 1) atomic_read() vs. atomic_inc/dec() guarantees that the read value
>    is consistent in itself.
> 
>    Non-atomic inc/dec is not guaranteeing that the concurrent read is a
>    consistent value as the compiler is free to do store/load
>    tearing. Unlikely but not guaranteed to never happen.
> 
>    KCSAN will complain about it sooner than later and then someone has
>    to go and do the analysis and the annotation. I rather let you do
>    the reasoning now than chasing you down later :)

Fair enough.

> 2) What's worse is that the result can be completely bogus:
> 
>    i.e.
> 
>    CPU0                                 CPU1                    CPU2
>    a = rq(CPU1)->nr_iowait; // 0
>                                         rq->nr_iowait++;
>                                                                 rq(CPU1)->nr_iowait_remote++;
>    b = rq(CPU1)->nr_iowait_remote; // 1
> 
>    r = a - b; // -1
>    return (unsigned int) r; // UINT_MAX
> 
>    The consumers of this interface might be upset. :)
> 
>    While with a single atomic_t it's guaranteed that the result is
>    always greater or equal zero.

Yeah OK, this is a real problem...

>>> So s/Reviewed-by/Un-Reviewed-by/
>>>
>>> Though thinking about it some more. Is this split a real benefit over
>>> always using the atomic? Do you have numbers to show?
>>
>> It was more on Peter's complaint that now we're trading a single atomic
>> for two, hence I got to thinking about nr_iowait in general. I don't
>> have numbers showing it matters, as mentioned in another email the most
>> costly part about this seems to be fetching task->in_iowait and not the
>> actual atomic.
> 
> On the write side (except for the remote case) the cache line is already
> dirty on the current CPU and I doubt that the atomic will be
> noticable. If there is concurrent remote access to the runqueue then the
> cache line is bouncing no matter what.

That was my exact thinking too, same cacheline and back-to-back atomics
don't really matter vs a single atomic on it.

> On the read side there is always an atomic operation required, so it's
> not really different.
> 
> I assume Peter's complaint was about the extra nr_iowait_acct part. I
> think that's solvable without the extra atomic_t member and with a
> single atomic_add()/sub(). atomic_t is 32bit wide, so what about
> splitting the thing and adding/subtracting both in one go?
> 
> While sketching this I noticed that prepare/finish can be written w/o
> any conditionals.
> 
> int io_schedule_prepare(void)
> {
> 	int flags = current->in_iowait + current->in_iowait_acct << 16;
> 
> 	current->in_iowait = 1;
> 	current->in_iowait_acct = 1;
> 	blk_flush_plug(current->plug, true);
> 	return flags;
> }
> 
> void io_schedule_finish(int old_wait_flags)
> {
> 	current->in_iowait = flags & 0x01;
>         current->in_iowait_acct = flags >> 16;
> }
> 
> Now __schedule():
> 
> 	if (prev->in_iowait) {
>            	int x = 1 + current->in_iowait_acct << 16;
> 
> 		atomic_add(x, rq->nr_iowait);
> 		delayacct_blkio_start();
> 	}
> 
> and ttwu_do_activate():
> 
> 	if (p->in_iowait) {
>         	int x = 1 + current->in_iowait_acct << 16;
> 
>                 delayacct_blkio_end(p);
>                 atomic_sub(x, task_rq(p)->nr_iowait);
> 	}
> 
> 
> and try_to_wake_up():
> 
> 	delayacct_blkio_end(p);
> 
> 	int x = 1 + current->in_iowait_acct << 16;
> 
> 	atomic_add(x, task_rq(p)->nr_iowait);
> 
> nr_iowait_acct_cpu() becomes:
> 
>         return atomic_read(&cpu_rq(cpu)->nr_iowait) >> 16;
> 
> and nr_iowait_cpu():
> 
>         return atomic_read(&cpu_rq(cpu)->nr_iowait) & ((1 << 16) - 1);
> 
> Obviously written with proper inline wrappers and defines, but you get
> the idea.

I'll play with this a bit, but do we want to switch to an atomic_long_t
for this? 2^16 in iowait seems extreme, but it definitely seems possible
to overflow it.

-- 
Jens Axboe


