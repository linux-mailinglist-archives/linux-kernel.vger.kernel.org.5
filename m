Return-Path: <linux-kernel+bounces-143274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00E8A3680
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96660281B82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95A150984;
	Fri, 12 Apr 2024 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9z6nxd3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45YL/6qm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A3514F9E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951379; cv=none; b=Vu2Tga2XCLx60MifskhO8x68CwEhzQGVZntbtRhkdoDFHPQgRSO+Nr5/DvxccOZobe76ppWkBX2EDf1u4ErQPI6GKOakbc/s27SvdI5A0fsgUTuLDX50DJpdOWxbK6nidYt5rY7Z0unSlk10JQKQ4cT1DNZAt1Tff4FqUysEHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951379; c=relaxed/simple;
	bh=jA6ARrGtgWJ7UuNLrRb9blum6qtvsT8qGF19szID6Yc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aR/GSogHCOuQqTqVoadIN1Aob6pqYFzYPfI3YOtU/6bAeNRWWnXM7x7TIz3QWo6z+AziBUPiNj0BMfIf8Rkvfl9Ee8JaO2+TV87O68a79ea4tPN5ZFSdlRqcaq7jaPuv+Uy4VJHpFpDIuIZUtg0sC+D6AIlVDV0P+wIjzfh1WMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9z6nxd3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45YL/6qm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712951376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wq8zW2oy5QC/9QD9CMB1fAp3LCVcl1LW1lDrklI7ZkM=;
	b=x9z6nxd3tbC96PsU8CcvXTH/20675Hw5LLOzdeHH7SYqP5f2dSGqj9PtSSJ3uXYB3Cn2Fd
	7S+wG3tLxgT2kmsmO6TJSaZl24iN8FcpsoRYY89IkimQKDyIKDKfXuKyhSrpM9vWyMTPoW
	IpW7hSg6tUlyPLeGNhKauJSvLFrocnDrfMMMpCFfHPW3raLPluWarsSqGlGd7coo6NSw6G
	8S3zVwvXEC/YfbkRbMxmUYJMMOAwP1WBAssrQeUWSFgZr4G3lWOWRxXrN/Hp3XF/hiWGxC
	WeyunrbAwcq8HTuW2HTSwD2BV86kDx0HjYL/3/JrqkFmk7WqaqUSA4MOOGZ0yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712951376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wq8zW2oy5QC/9QD9CMB1fAp3LCVcl1LW1lDrklI7ZkM=;
	b=45YL/6qmPa8wYhREKF9EEiuONy/EDAh2GdfHXoqN4ZXBeyxGy4fI7sBWx/nTlrJoJJNu5g
	KxRTrXd2Bu0GtUDg==
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 10/50] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_get()
In-Reply-To: <87cyquxw59.fsf@email.froward.int.ebiederm.org>
References: <20240410164558.316665885@linutronix.de>
 <20240410165551.571240036@linutronix.de>
 <87cyquxw59.fsf@email.froward.int.ebiederm.org>
Date: Fri, 12 Apr 2024 21:49:35 +0200
Message-ID: <87h6g6z7hs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 12 2024 at 13:40, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> -	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
>> +	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
>>  		expires = bump_cpu_timer(timer, now);
>>  	else
>>  		expires = cpu_timer_getexpires(&timer->it.cpu);
>> @@ -809,11 +811,13 @@ static void __posix_cpu_timer_get(struct
>>  		itp->it_value = ns_to_timespec64(expires - now);
>>  	} else {
> Why not make this else condition?
> 	} else if (!sigev_none) {
> And not need to change the rest of the code?

Duh, yes.
  		/*
>> -		 * The timer should have expired already, but the firing
>> -		 * hasn't taken place yet.  Say it's just about to expire.
>> +		 * A single shot SIGEV_NONE timer must return 0, when it is
>> +		 * expired! Timers which have a real signal delivery mode
>> +		 * must return a remaining time greater than 0 because the
>> +		 * signal has not yet been delivered.
>>  		 */
>> -		itp->it_value.tv_nsec = 1;
>> -		itp->it_value.tv_sec = 0;
>> +		if (!sigev_none)
>> +			itp->it_value.tv_nsec = 1;
>
> Do you perhaps need a comment somewhere that itp is zeroed in
> do_timer_gettime?  The code now depends upon that for setting
> itp->it_value when it did not used to, making it look at first
> glance like you have created an uninitialized variable.
>
> Probably just something in the description of the change would be
> sufficient.

Fair enough.

Thanks,

        tglx

