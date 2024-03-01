Return-Path: <linux-kernel+bounces-88714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1146E86E5BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957B5B24E04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19746B3;
	Fri,  1 Mar 2024 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vzvcqDYD"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC57F3C29;
	Fri,  1 Mar 2024 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311085; cv=none; b=SlMIskWxEGRp+b00h26eUX5PG7ZuF1HAHHBdV5i5pvI4IFrizxtNHnDJZ1vLCTrTVPiZLvE5IT0/tbX0i2/dJW4a02przXENTvRPBIw9o9YfnBGkXTvbgOr5QrgJoro9nDEaKXh45C1QcsQlFY9EBvTs781fwxyFpTOugpb5p0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311085; c=relaxed/simple;
	bh=kxcPnu0fhPYzuZ42n+29yXL+hWBsAeXa8e2UmWZhueY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRHHtdbskcyLu6xuJyPDXs/Rj3rU0O7TyiPS0QuXBHGt6id+Hbs4XpdkoZOVZ8RNbdOuTtXEe4w3iZPebSts96ZO8C999QQp25lWH9byn9zQWF+XWPJKQHmXIrn4SX2buM3KrA6iTcGzDAQFskVdb1N3f6NlNeYXVzdM2nHGavo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=vzvcqDYD; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709311072;
	bh=kxcPnu0fhPYzuZ42n+29yXL+hWBsAeXa8e2UmWZhueY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vzvcqDYDL5ec91kEut4gMp+A26q5HCk735VqZCH6l5aHgIyxvX/j1uPHFrbja2QZ+
	 WFPNeClSJA2a8wVnusBc0HxX4vbPlgW4YuBrIbnvdyKvEbsJ3LokAJtDRyhCpqV1XR
	 ZVB67trnYLjI7SZp/AkuF6m+if/BZUMrK7Vx2gTyqAQx0SuwsEuaiI6feMlRkH9nFC
	 Gd4UOl+G7OO63E0PXyRJnQSBgqleDQMYleYBsLqtHJtA1z7253r3GQ6QJ6KNUwDS9n
	 zs5yR9XE/g1ws2k51aGpeG8PSRTXryYZfv6a4+6mcL31myd1v3gMWTL702fZpbont1
	 m1w2EQOW2NHXQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TmYfl6TXMzfPb;
	Fri,  1 Mar 2024 11:37:51 -0500 (EST)
Message-ID: <fde2e34a-2f5f-4bee-8f6f-60acf2e0d4a3@efficios.com>
Date: Fri, 1 Mar 2024 11:37:54 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: use READ_ONCE() to read
 cpu_buffer->commit_page in concurrent environment
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, linke <lilinke99@qq.com>,
 paulmck <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>
References: <tencent_3F31ADAB6142D8948E5BD02B854ED2A77106@qq.com>
 <20240301104945.43119349@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240301104945.43119349@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-01 10:49, Steven Rostedt wrote:
> On Fri, 1 Mar 2024 13:37:18 +0800
> linke <lilinke99@qq.com> wrote:
> 
>>> So basically you are worried about read-tearing?
>>>
>>> That wasn't mentioned in the change log.
>>
>> Yes. Sorry for making this confused, I am not very familiar with this and
>> still learning.
> 
> No problem. We all have to learn this anyway.
> 
>>
>>> Funny part is, if the above timestamp read did a tear, then this would
>>> definitely not match, and would return the correct value. That is, the
>>> buffer is not empty because the only way for this to get corrupted is if
>>> something is in the process of writing to it.
>>
>> I agree with you here.
>>
>> 	commit = rb_page_commit(commit_page);
>>
>> But if commit_page above is the result of a torn read, the commit field
>> read by rb_page_commit() may not represent a valid value.
> 
> But commit_page is a word length, and I will argue that any compiler that
> tears "long" words is broken. ;-)

[ For those tuning in, we are discussing ring_buffer_iter_empty()
   "commit_page = cpu_buffer->commit_page;" racy load. ]

I counter-argue that real-world compilers *are* broken based on your
personal definition, but we have to deal with them, as documented
in Documentation/memory-barriers.txt (see below).

What is the added overhead of using a READ_ONCE() there ? Why are
we wasting effort trying to guess the compiler behavior if the
real-world performance impact is insignificant ?

Quote from memory-barrier.txt explaining the purpose of {READ,WRITE}_ONCE():

"(*) For aligned memory locations whose size allows them to be accessed
      with a single memory-reference instruction, prevents "load tearing"
      and "store tearing," in which a single large access is replaced by
      multiple smaller accesses."

I agree that {READ,WRITE}_ONCE() are really not needed at initialization,
when there are demonstrably no concurrent accesses to the data

But trying to eliminate {READ,WRITE}_ONCE() on concurrently accessed fields
just adds complexity, prevents static analyzers to properly understand the
code and report issues, and just obfuscates the code.

Thanks,

Mathieu

> 
>>
>> In this case, READ_ONCE() is only needed for the commit_page.
> 
> But we can at least keep the READ_ONCE() on the commit_page just because it
> is used in the next instruction.
> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


