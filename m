Return-Path: <linux-kernel+bounces-87388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FB086D3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327DA1C21C16
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238EC13F43E;
	Thu, 29 Feb 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EkOtos11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jSPJoJy6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA313F437
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236399; cv=none; b=nHyaPvQKtraTebIsIR9ZVm1wfmqfMCYt6ZDOU30UxJMUJAFln1NXOOHSXR2SxeGKshPrwnggRB0TMEpe/kPyKgTLksQPvzh4+4J+CofVTBRQhFCk5EsbBGYYUrFjehatxkWZSyjZhnXI9bKLN1kXDhikp6EpGy/FWhLK2haA6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236399; c=relaxed/simple;
	bh=7cVGc3XJc7LUCWrnrSfpT+9yCIFMDLdsSmO94FN7zbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BFwlzhf6c1a3y7S7kpMdCZq7mBuYUF+ws3na+R04YqB0il6hm5cfAG3qnGQG4t3E+8r0My2LZm+Y3TjW5/CRtnqdcQOgqXeHeVFKQrE+02wyiif9qo0vUv3KMegcLOOjxKRBq2IAxQCWCbjKRlrh61Ru9Do+w5dTF0mQHSlDRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EkOtos11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jSPJoJy6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709236395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyGVohOZqLqcXDyINPi2cQ19fn0cSKsg53bbz66CcV8=;
	b=EkOtos11nWm3fsf9zvSKP12FH2tsE3TwzJ0bEm4W6vIzcB3vb3GeapC+dNVTn8eLFxif7p
	hNq7wQTurPfLPLJ5t3ocqtXqAFfZVI9fIL9Li88MtaxMTD3oi/ekuXwFgId8V/88ATB4Hf
	2fz0Q43P6F/DspVVI42SMQCHtY03eMGr3nV06dqfkl+B1ZJQp06tEofZeHPGEZP6IiryUG
	lO6L7clORqzFQRkoeuu8YYyG53vNxV++QaqmvnSnMpeHOujkKy5aXGEgX2JUUzXmHDOb+a
	rGuNCsCzspKQLAG4mZFzPm+/RVHR7s4xA8n3iqIanwZzuEfy8iDXnjrErRTp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709236395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyGVohOZqLqcXDyINPi2cQ19fn0cSKsg53bbz66CcV8=;
	b=jSPJoJy6kdlDz8RTlBDV/S3IkaImUUOennKvySHzHbcBR/9QMRilfjte1BCroFVVR96TQd
	u3AY+8ersw4IkgAQ==
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
In-Reply-To: <edd520ab-b95f-4a60-a35a-2490a6d5057f@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
 <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk> <87wmqn6uaw.ffs@tglx>
 <edd520ab-b95f-4a60-a35a-2490a6d5057f@kernel.dk>
Date: Thu, 29 Feb 2024 20:52:59 +0100
Message-ID: <87sf1b6o9w.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 10:49, Jens Axboe wrote:
> On 2/29/24 10:42 AM, Thomas Gleixner wrote:
>> So but I just noticed that there is actually an issue with this:
>> 
>>>  unsigned int nr_iowait_cpu(int cpu)
>>>  {
>>> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
>>> +	struct rq *rq = cpu_rq(cpu);
>>> +
>>> +	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);
>> 
>> The access to rq->nr_iowait is not protected by the runqueue lock and
>> therefore a data race when @cpu is not the current CPU.
>> 
>> This needs to be properly annotated and explained why it does not
>> matter.
>
> But that was always racy before as well, if someone else is inc/dec'ing
> ->nr_iowait while it's being read, you could get either the before or
> after value. This doesn't really change that. I could've sworn I
> mentioned that in the commit message, but I did not.

There are actually two issues here:

1) atomic_read() vs. atomic_inc/dec() guarantees that the read value
   is consistent in itself.

   Non-atomic inc/dec is not guaranteeing that the concurrent read is a
   consistent value as the compiler is free to do store/load
   tearing. Unlikely but not guaranteed to never happen.

   KCSAN will complain about it sooner than later and then someone has
   to go and do the analysis and the annotation. I rather let you do
   the reasoning now than chasing you down later :)

2) What's worse is that the result can be completely bogus:

   i.e.

   CPU0                                 CPU1                    CPU2
   a = rq(CPU1)->nr_iowait; // 0
                                        rq->nr_iowait++;
                                                                rq(CPU1)->nr_iowait_remote++;
   b = rq(CPU1)->nr_iowait_remote; // 1

   r = a - b; // -1
   return (unsigned int) r; // UINT_MAX

   The consumers of this interface might be upset. :)

   While with a single atomic_t it's guaranteed that the result is
   always greater or equal zero.

>> So s/Reviewed-by/Un-Reviewed-by/
>> 
>> Though thinking about it some more. Is this split a real benefit over
>> always using the atomic? Do you have numbers to show?
>
> It was more on Peter's complaint that now we're trading a single atomic
> for two, hence I got to thinking about nr_iowait in general. I don't
> have numbers showing it matters, as mentioned in another email the most
> costly part about this seems to be fetching task->in_iowait and not the
> actual atomic.

On the write side (except for the remote case) the cache line is already
dirty on the current CPU and I doubt that the atomic will be
noticable. If there is concurrent remote access to the runqueue then the
cache line is bouncing no matter what.

On the read side there is always an atomic operation required, so it's
not really different.

I assume Peter's complaint was about the extra nr_iowait_acct part. I
think that's solvable without the extra atomic_t member and with a
single atomic_add()/sub(). atomic_t is 32bit wide, so what about
splitting the thing and adding/subtracting both in one go?

While sketching this I noticed that prepare/finish can be written w/o
any conditionals.

int io_schedule_prepare(void)
{
	int flags = current->in_iowait + current->in_iowait_acct << 16;

	current->in_iowait = 1;
	current->in_iowait_acct = 1;
	blk_flush_plug(current->plug, true);
	return flags;
}

void io_schedule_finish(int old_wait_flags)
{
	current->in_iowait = flags & 0x01;
        current->in_iowait_acct = flags >> 16;
}

Now __schedule():

	if (prev->in_iowait) {
           	int x = 1 + current->in_iowait_acct << 16;

		atomic_add(x, rq->nr_iowait);
		delayacct_blkio_start();
	}

and ttwu_do_activate():

	if (p->in_iowait) {
        	int x = 1 + current->in_iowait_acct << 16;

                delayacct_blkio_end(p);
                atomic_sub(x, task_rq(p)->nr_iowait);
	}


and try_to_wake_up():

	delayacct_blkio_end(p);

	int x = 1 + current->in_iowait_acct << 16;

	atomic_add(x, task_rq(p)->nr_iowait);

nr_iowait_acct_cpu() becomes:

        return atomic_read(&cpu_rq(cpu)->nr_iowait) >> 16;

and nr_iowait_cpu():

        return atomic_read(&cpu_rq(cpu)->nr_iowait) & ((1 << 16) - 1);

Obviously written with proper inline wrappers and defines, but you get
the idea.

Hmm?

Thanks,

        tglx

