Return-Path: <linux-kernel+bounces-75169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A3885E412
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79911F25574
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821183A05;
	Wed, 21 Feb 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9RcVRpR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t6lfnyh/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1849839E5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535448; cv=none; b=Qoxfui/8/Cwbt6dWLUD4y3puyChvxGLMU0079rzYdSRcOfMdKpskBeKClmjODi5i+YrIfvfSNHWp50Z6qrNFdz73cLyKAygweUIlSh8Z5oGkaSOlNiX3dhXYmA31oQaUi7a4/sChac31u4vDT9aGzgh4B3FrStqmlX3UtQo6bMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535448; c=relaxed/simple;
	bh=lR0rMh24z0ylg10w0OvDGiKJ0KBzucjbMGKtOl1x7l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bfz7NhwZpyE4XIRrxSpF+cD9OvgcO1jqPwmaO4X4u2wfXuPRJQCoZumpr+B53253wJ9rUYPUebuI3bBG+G8jfS/H24HOad1ygmDXD4DF+Brb9MU0k9ET8rnKPCG5OA53POKmN9UlTkhNfJ+q9+cr1bk29W7NX2llolDdjsdK26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9RcVRpR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t6lfnyh/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708535444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bw+z6sQUFE3Xg4n/9xU9BAzIHIwZ+UW1Dx+6qEYqlaw=;
	b=E9RcVRpR6ZIyljiI6aE47VzQ92MVBrGvNSF6NhWN2BeFGT2cxsy2q6nzXZy/UkI1Ynf1BX
	aMEis9oAIsKuX9pg/HP3JHahsvyiJpKWnNizuUaBjFwEJBmGQoOlC2nPonGApWrh+kNn99
	R3hIyTQ44Zo5QgGmRoFM+elIHiLKxd3tUrfSFi+fMCs0tXl2+9M+gisxEolT1gYmz1lort
	nFg/bADY4MXDyo995hUlxVUDdOHBxZBb58YJiKlIehnjER5/SAzbDKNkPEUszxVzpEuerR
	rzK73CqlY/+iZA5eesEVZ0ysfnJ80ILTt+cSCLXx1HYY4HHIYA7+CW0k/3jHRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708535444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bw+z6sQUFE3Xg4n/9xU9BAzIHIwZ+UW1Dx+6qEYqlaw=;
	b=t6lfnyh/tQPkJyVt1Mb22bEW+7j3QlmocvY72SqukEe2Zj2KJ4zXUGCqrKtYmTpviCS1tx
	GfI11SXZUhpAaICQ==
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 05/30] sched: *_tsk_need_resched() now takes resched_t
 as param
In-Reply-To: <87msruiwz6.fsf@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-6-ankur.a.arora@oracle.com> <87sf1o8oh2.ffs@tglx>
 <87msruiwz6.fsf@oracle.com>
Date: Wed, 21 Feb 2024 18:10:44 +0100
Message-ID: <8734tlhhez.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 14:37, Ankur Arora wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>>
>> The subject line reads odd...
>>
>>> -static inline bool test_tsk_need_resched(struct task_struct *tsk)
>>> +static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
>>>  {
>>> -	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>>> +		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
>>> +	else
>>> +		return false;
>>>  }
>>
>> Same like the others. This wants wrappers with now/lazy.
>
> So, when working on the scheduler changes, I found the simplest
> implementation was to define a function that takes into account
> current preemption mode, checks for idle, tick etc and returns
> the rescheduling policy, which __resched_curr() carries out.
>
> So, it would be useful to just pass the resched_t as a parameter
> instead of having now/lazy wrappers.

That's fine for specific functions which really need to handle the
rescheduling mode, but for all other random places having a nice wrapper
makes the code more readable.

Thanks,

        tglx

