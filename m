Return-Path: <linux-kernel+bounces-87199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CC86D0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB08FB22587
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977E070AF3;
	Thu, 29 Feb 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXfI4by3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0coO4Cc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439C1EB42
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228570; cv=none; b=BZwGvpOlYPIEaTq7EyFANuzojdIM1Dl6xoiaO9kWDQ+QjF+zbzz50JqfJJjxrxjB3qv45TxwWxfrO+go+/5GuVnMWX+PIj/3fOzhE2VLixdWLIwjEDODVGubpjxcWxQ7D5Scwe0Y9mq9rgXKrWI3sG/+uZ2k8zHinIhzVODuR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228570; c=relaxed/simple;
	bh=yeKcJOLy1njyemQ5Tl9jEyFRkzapZUSc5QRkXNW0P3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUKD7s+tXOH0m4eVYajneVvJ+9wEYNBABoxB6kbzCjFz5+awiE635d7I9IfYZz18YTDyhWrPy6MpR6v3vlIsRO0W6fUmQUmsA0KbiXi8rit4EVgBRNE/ywtlyrxi7/pYeXTefRh7+Vwu36ou0P6jBzll5l/z551XZLZmsEGOOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXfI4by3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0coO4Cc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709228567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujeIxvSFSQUGbulyJ+o3KKiI0KcbSdZPdN9R9JucPJo=;
	b=LXfI4by30DHBqfzWPbBiAOTLrjn2XTgU6pqj8wmm4Qf1dmlUozdjKI34FuYSya+ZWXu1Uc
	CRZacPP+g3YZ1sJslQCYMjQgCdS4gGjFpR2tUlfXmmVrixdDIjMYW4e/fohyzeCeh4bNCe
	4qJZn2473TiyibgeGTuTC1Igo7Sp75y5GuYwb7fnvWzFG51RnpwoJmY34CUu7fuptbuWDc
	o4lh9HTMT6Zno/+dso6ay1ovVeOXI7TNYR7HYJHyJo0eIDocFiT3Eadypb2mGbNwdddhYc
	SwXED+2nfQh/DzvxWAi4dp5yZGnuNRPUMRb7M0DE3x5SZOVobeBkCeykBubxHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709228567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ujeIxvSFSQUGbulyJ+o3KKiI0KcbSdZPdN9R9JucPJo=;
	b=v0coO4Cc6NRk9gFWT+XAuUQG1TWdaTk1UBdmykYs+bTYlc250kZVyU9/YPYCpAl8/U+X85
	zf6tTBPrt96/pcCg==
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH 1/2] sched/core: switch struct rq->nr_iowait to a normal
 int
In-Reply-To: <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk>
References: <20240228192355.290114-1-axboe@kernel.dk>
 <20240228192355.290114-2-axboe@kernel.dk> <8734tb8b57.ffs@tglx>
 <c3abe716-3d8f-47dc-9c7d-203b05b25393@kernel.dk>
Date: Thu, 29 Feb 2024 18:42:47 +0100
Message-ID: <87wmqn6uaw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 10:19, Jens Axboe wrote:
> On 2/29/24 9:53 AM, Thomas Gleixner wrote:
>> On Wed, Feb 28 2024 at 12:16, Jens Axboe wrote:
>>> In 3 of the 4 spots where we modify rq->nr_iowait we already hold the
>> 
>> We modify something and hold locks? It's documented that changelogs
>> should not impersonate code. It simply does not make any sense.
>
> Agree it doesn't read that well... It's meant to say that we already
> hold the rq lock in 3 of the 4 spots, hence using atomic_inc/dec is
> pointless for those cases.

That and the 'we'. Write it neutral.

The accounting of rq::nr_iowait is using an atomic_t but 3 out of 4
places hold runqueue lock already. ....

So but I just noticed that there is actually an issue with this:

>  unsigned int nr_iowait_cpu(int cpu)
>  {
> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +	struct rq *rq = cpu_rq(cpu);
> +
> +	return rq->nr_iowait - atomic_read(&rq->nr_iowait_remote);

The access to rq->nr_iowait is not protected by the runqueue lock and
therefore a data race when @cpu is not the current CPU.

This needs to be properly annotated and explained why it does not
matter.

So s/Reviewed-by/Un-Reviewed-by/

Though thinking about it some more. Is this split a real benefit over
always using the atomic? Do you have numbers to show?

Thanks,

        tglx




