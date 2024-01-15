Return-Path: <linux-kernel+bounces-26010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002682D9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AA01C21927
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BDB168D9;
	Mon, 15 Jan 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3usj8aN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fo0RYHwo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B44168C4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705324251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWEMqJ3ZY8IoMhDyU06y+UtP311AunIjwISjvPisJoY=;
	b=v3usj8aNlB+kVv2boYs/C1kzdjc8i+y3spoTxS427OnOvfaNG0q//S0MVWT9KIdbCOryBU
	lG4SNUTCs02L1l6rI8C2ic1qmn+A2wXgwgxlxLhctGXGVyZ0fvVH6dZqM5fnfwGwk0vBfs
	52qCiitpIMVu+LzNQoztLDq/M7NV+ATIaAnb8z/IAqORDVAZ16kmXCvZ8dcGVeOahZibiE
	a1m/8NOFqERZB7FHGHlS39Ai1c7ei7aWEPq7nQHf61czUqOk7XFUFy+S7NHMpz7uSLLg4b
	VIVXuBVCQfHjXo3CFYLWbO4+IwyHITV8vrdFDdW+9ofTz8/CL1xDdP9ckW1kZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705324251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hWEMqJ3ZY8IoMhDyU06y+UtP311AunIjwISjvPisJoY=;
	b=fo0RYHwomUHBXvSpZCiQ7cTaaIOTdLIz4OYN3ByVC9R65et59Xh8Z7uxNeXkMDXstmkJdE
	4X7v0DliNivg0nCA==
To: Pierre Gondois <pierre.gondois@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
In-Reply-To: <fe5038e1-e06b-41dd-9584-cbd992bef1fe@arm.com>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com> <87a5pag6q7.fsf@somnus>
 <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com> <87mstaioy6.ffs@tglx>
 <fe5038e1-e06b-41dd-9584-cbd992bef1fe@arm.com>
Date: Mon, 15 Jan 2024 14:10:50 +0100
Message-ID: <877ckad9np.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pierre Gondois <pierre.gondois@arm.com> writes:

> Hello Thomas,
>
> On 1/12/24 15:52, Thomas Gleixner wrote:
>> On Fri, Jan 12 2024 at 14:39, Pierre Gondois wrote:
>>> On 1/12/24 11:56, Anna-Maria Behnsen wrote:
>>>> Pierre Gondois <pierre.gondois@arm.com> writes:
>>>>> I agree that the absence of cpuidle driver prevents from reaching deep
>>>>> idle states. FWIU, there is however still benefits in stopping the tick
>>>>> on such platform.
>>>>
>>>> What's the benefit?
>>>
>>> I did the following test:
>>> - on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
>>> - booting with 'cpuidle.off=1'
>>> - using the energy counters of the platforms
>>>     (the counters measure energy for the whole cluster of big/little CPUs)
>>> - letting the platform idling during 10s
>>>
>>> So the energy consumption would be up:
>>> - ~6% for the big CPUs
>>> - ~10% for the litte CPUs
>> 
>> Fair enough, but what's the actual usecase?
>> 
>> NOHZ w/o cpuidle driver seems a rather academic exercise to me.
>
> I thought Anna-Maria had a use-case for this.
> I just wanted to point out that this patch could potentially
> increase the energy consumption for her use-case, nothing more,
>

I saw tons of calls trying to stop the tick on a loaded system - which
decreased performance. Deep sleep states were disabled (by accident) in
the BIOS but NOHZ was enabled. So my proposal is to remove this
unconditional call trying to stop the tick.

Thanks,

        Anna-Maria

