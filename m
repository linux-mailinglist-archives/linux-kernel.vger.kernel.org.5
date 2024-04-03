Return-Path: <linux-kernel+bounces-130596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EF897A45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CB5B22604
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06515625F;
	Wed,  3 Apr 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b="nnBiZ33m"
Received: from anarch128.org (anarch128.org [23.253.174.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5915538C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.253.174.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177562; cv=none; b=JlknZwdmmhpV+i3NMpC34x1/OgKndBrWEkJtjx/D96uQKeAou3il0gYrJlf3nUVP7rr0uO33T05IUSo3Xo/GG1LHul8kY9sSaaws4rISKzeGdeiJXzxTpZnmu90oulnVjc+IkJ+YW67vNQcjba5oZIJ8lhKhGar16UIN6sXT0L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177562; c=relaxed/simple;
	bh=AMc1I2TaKoVWjxsT9qjIO65Tk4eOlaXInyGoGKhCZD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTgnuaL4npo5wlw9rQfBtt0bEs7F9YcIY8wVSPc8jMAUSEcApeQwZ9P+VbqB9zSxkJ1RyKZA+pbGYBVIRLGv254Oc8In3VXjpKxOmsKwfkvFhAi4nWA6cRorBubmQ/nYIUCKEI+YBoF8BSdv6SXNkmPgQfnvWc+zkI9Bx++TxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com; spf=pass smtp.mailfrom=metaparadigm.com; dkim=fail (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=nnBiZ33m reason="signature verification failed"; arc=none smtp.client-ip=23.253.174.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaparadigm.com
Received: from [192.168.1.8] (default-rdns.vocus.co.nz [202.150.110.104] (may be forged))
	(authenticated bits=0)
	by anarch128.org (8.15.2/8.15.2/Debian-22) with ESMTPSA id 433KdslA381233
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 3 Apr 2024 20:39:57 GMT
Authentication-Results: anarch128.org;
    auth=pass;
    dkim=pass (2048-bit rsa key sha256) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=nnBiZ33m header.a=rsa-sha256 header.s=100043;
    x-return-mx=pass header.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org);
    x-return-mx=pass smtp.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=metaparadigm.com;
	s=100043; t=1712176799;
	bh=AMc1I2TaKoVWjxsT9qjIO65Tk4eOlaXInyGoGKhCZD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnBiZ33mwWx1v2SFfOue0yNpwV4LGKHxPLl2QNGdOj0v/xZN5uNgQ0mR4wWNzatSO
	 sHVSc3t4YvJNC76KvLFCdYNd9CqpSeIG+4KotVeoXfADmuWn/gtOtSpMBCzCvOcKDm
	 kFBBob/RQrel3c6umtwiwfrNw6BpUfDakdI3bF4QlyNLMejngTdXhD7LTVioCCWRMW
	 6YLsji47JclD8XqCvwSYs2jQ7hBYG2PDgredtALIugMPbTvmTH0qfTOiPwDIWelmZE
	 KzA75DuLY5UGo4IIQOubwjFReTjlili6YYuTQM7ki55Ef2euqFDzsJV3VSPnDQogRx
	 m0THBL2lFS3Hw==
Message-ID: <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
Date: Thu, 4 Apr 2024 09:39:48 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: user-space concurrent pipe buffer scheduler interactions
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <969ccc0f-d909-4b45-908e-e98279777733@metaparadigm.com>
 <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com>
Content-Language: en-US
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm
In-Reply-To: <CAHk-=wj3khqjXnHmShPj+tZvC=SyUitTZ7BkDO-rqu_aCVPrXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 05:56, Linus Torvalds wrote:
> On Tue, 2 Apr 2024 at 13:54, Michael Clark <michael@metaparadigm.com> wrote:
>>
>> I am working on a low latency cross-platform concurrent pipe buffer
>> using C11 threads and atomics.
> 
> You will never get good performance doing spinlocks in user space
> unless you actually tell the scheduler about the spinlocks, and have
> some way to actually sleep on contention.
> 
> Which I don't see you as having.

We can work on this.

So maybe it is possible to look at how many LOCK instructions were 
retired in the last scheduler quantum ideally with retired-success, 
retired-failed for interlocked-compare-and-swap. Maybe it is just a 
performance counter and doesn't require perf tracing switched on?

Then you can probably make a queue of processes in lock contention but 
the hard part is deducing who had contention with who. I will need to 
think about this for a while. We know the latency when things are not 
contended because these critical sections are usually small. It's about 
~200-400ns and you can get these numbers in a loop at boot up.

But I don't know how we can see spinning on acquires. It makes me think 
that the early relaxed/acquire comparison before the LOCK op is bad. I 
got a very minor performance boost but it would break the strategy I 
just mentioned because we wouldn't have a LOCK CMPXCHG in our spin loop. 
We would know for certain "that" process had a failed LOCK CMPXCHG.

So I would need to delete this line and other lines like this:

https://github.com/michaeljclark/cpipe/blob/13c0ad1a865b9cc0174fc8f61d76f37bdbf11d4d/include/buffer.h#L317

I also want a user-space wrapper for futexes for a waitlist_t that 
rechecks conditions and uses cond_timeout on old broken POSIX systems so 
that we won't deadlock due to a missed wake-up. FreeBSD, macOS and 
Windows are starting to look like they might have something we can use.

WaitOnAddress in Windows has a compare not-equals, and supports 8, 16, 
32, and 64 bit words, but when used to construct equals, which is what I 
need, or less-than or greater-than it could suffer from thundering herd 
if used in a decentralized way in user-space. Maybe we would need an 
address waiter list for an address stashed in a CPU struct for the lead 
waiter, then centrally recheck the condition and when appropriate 
reschedule those sleeping in the queue for events on that address?

Sorry I don't know how the Linux scheduler and futexes work internally.
I just want to use this stuff in user-space. I want a POSIX waitlist_t.

I am working on a tiny emulator for the Windows Hypervisor which is how 
I justify the present "embedded" version which spins. This pipe buffer 
is for a tiny test kernel to get rid of a janky lock around printf.

- https://github.com/michaeljclark/emu

Thanks,
Michael.

