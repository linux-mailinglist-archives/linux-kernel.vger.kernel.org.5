Return-Path: <linux-kernel+bounces-48408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F882845B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CC91F2BFC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E4626DE;
	Thu,  1 Feb 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UysrzrXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F962166;
	Thu,  1 Feb 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801246; cv=none; b=IPxDOGoztjPqLAgrkcblUUOMnE0MSTkn5J6+ddIRdCDnWSZb6qbzdtqLU46Tbdz2jq79SPwaINXoZbAgK3Qcfruhdgb8L2He0o1fukPmfeXNL2FfvI6hEBGQGWmblo5agHUDl911ab40r/GQNXTu2hlZJypnsJttO/61ynj9u6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801246; c=relaxed/simple;
	bh=J4oACJ7K02dl5yARmR3wThXfdDqsUmklZwHWhRZPSAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=to88ZmmDc6xUPHZuKpKaEYx7IknfqCwKpa8nENhESH4PVhg63EEFpx6ZPmouECITU2pNg5vemj6JY5MnBX1uMOKBAqHd5jk7FAEcumxsiimxgekosyGhHTu+XiXprWWHHWlkJAP0sTvTIx7n96Mbjo+oEh5bcEUFMz0+N3XsEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UysrzrXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDE5C433C7;
	Thu,  1 Feb 2024 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706801246;
	bh=J4oACJ7K02dl5yARmR3wThXfdDqsUmklZwHWhRZPSAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UysrzrXqbkN/eYckVeuBK8QLFf3oKCyaE5jk5aKqffI5wKVIHHGZYq7HdvPfkt9HP
	 TrHxL8Q7SmNs8sVFV8HmLJVGfHgE0G4E1mpRc6GWGveRktupuD4fUAl0jo+VrH36Wn
	 uD6vNQ/BzHFBwz31OKvv7SbNgL+j8DKLYAfOahQ4FsZh6TmWa9xixHW1lEaQdlmmuL
	 yvRqCWTymTvXjQB6Q42UCQ1Y4MKMscptPFzyDiNM7htsgKKimeG1u5IaeQ9Sa2ZKrB
	 kzcUKuqq4a3Y1r0Nr/rx3fSPtIL4WH30ScoiXxxXfLaubFQht9JU/4RI5S6w+uS6HH
	 Q8ulzLDRWjDSQ==
Message-ID: <88ffd0ec-ef43-4b26-9314-207606291af3@kernel.org>
Date: Thu, 1 Feb 2024 16:27:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
 <20240201102526.755de868@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240201102526.755de868@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/1/24 16:25, Steven Rostedt wrote:
> On Thu,  1 Feb 2024 16:13:39 +0100
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> Currently, the timerlat's hrtimer is initialized at the first read of
>> timerlat_fd, and destroyed at close(). It works, but it causes an error
>> if the user program open() and close() the file without reading.
>>
>> Move hrtimer_init to timerlat_fd open() to avoid this problem.
>>
>> No functional changes.
> 
> It can't be fixing something and not have any functional changes.
> 
> No functional changes means the code is restructured but the resulting
> assembly would be the same.
> 
> Like moving functions around in a file so that you don't need extra
> prototype declarations.
> 
> Please only add "No functional changes" if the function's assembly would be
> the same.

ok

>>
>> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")
> 
> With a fixes tag, I'm assuming his should go into v6.8 with a Cc stable?

right, I added it on Cc, but did not include the Cc:.. tag. It seems that I should have.

-- Daniel

> -- Steve
> 
> 
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
>> ---
>>  kernel/trace/trace_osnoise.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index bd0d01d00fb9..a8e28f9b9271 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -2444,6 +2444,9 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
>>  	tlat = this_cpu_tmr_var();
>>  	tlat->count = 0;
>>  
>> +	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>> +	tlat->timer.function = timerlat_irq;
>> +
>>  	migrate_enable();
>>  	return 0;
>>  };
>> @@ -2526,9 +2529,6 @@ timerlat_fd_read(struct file *file, char __user *ubuf, size_t count,
>>  		tlat->tracing_thread = false;
>>  		tlat->kthread = current;
>>  
>> -		hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
>> -		tlat->timer.function = timerlat_irq;
>> -
>>  		/* Annotate now to drift new period */
>>  		tlat->abs_period = hrtimer_cb_get_time(&tlat->timer);
>>  
> 


