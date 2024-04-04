Return-Path: <linux-kernel+bounces-130849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC9897DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8704E28BCBC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF761CD2C;
	Thu,  4 Apr 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b="cB8eaMbk"
Received: from anarch128.org (anarch128.org [23.253.174.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789153FC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.253.174.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712199630; cv=none; b=kwINY9ESoNNQYzL+AOegqq5njNv/tsbzHb40mmOYV5BmIL6bOIbOszodSah3QM4cmCy6Uc1G5qs/yoSEinwq6zO9ws/w+OskNZVHlrPq4vdhcCTCBd9aVFTQVYDwBHSq4pElNWk/3j3Jy2zitVAqxpP/rs9iG1uJB5Cf1xAKYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712199630; c=relaxed/simple;
	bh=5SI9nR0ptSdatwVFzKCc6PAX1XbR4oqA6lwr8yhV49U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYQCaDi9eJic+f57bgolcr3ZtQyCdFSXhP99QdbzZcqd2JoXwnu5sPEVwxcgxd2IEeIrDjsZ4qngjhq8pB56g9zOu+iNRjWTUeHXXCAwN3Evm6+aW6jzsgeC8rqZG2j9QELiBhYvORwY1HWcfN6i0SAeP6M2bKgC7+9SYQUNfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com; spf=pass smtp.mailfrom=metaparadigm.com; dkim=fail (2048-bit key) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=cB8eaMbk reason="signature verification failed"; arc=none smtp.client-ip=23.253.174.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metaparadigm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaparadigm.com
Received: from [192.168.1.5] (default-rdns.vocus.co.nz [202.150.110.104] (may be forged))
	(authenticated bits=0)
	by anarch128.org (8.15.2/8.15.2/Debian-22) with ESMTPSA id 4342xfv1401784
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Apr 2024 02:59:44 GMT
Authentication-Results: anarch128.org;
    auth=pass;
    dkim=pass (2048-bit rsa key sha256) header.d=metaparadigm.com header.i=@metaparadigm.com header.b=cB8eaMbk header.a=rsa-sha256 header.s=100043;
    x-return-mx=pass header.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org);
    x-return-mx=pass smtp.domain=metaparadigm.com policy.is_org=yes (MX Records found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=metaparadigm.com;
	s=100043; t=1712199587;
	bh=5SI9nR0ptSdatwVFzKCc6PAX1XbR4oqA6lwr8yhV49U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cB8eaMbkmETi1KzbZgyhSMtfadZe5bTy01fDmxTXWw0hUzPGRubQKlwyGt85X5MQa
	 VAffgcoeWGbq9FxYWI/ES20XdbOnOQE8mevw2KLJTJM8vCQbFNwnNAuR74UN6Pcppn
	 vfJi8XOeC1t6DBd+9jBfz57WuN/uC2rwgQmAdEOZBluL3wpGK5l17LftC2m8HGRijy
	 w3vwf8EkNlBdLNlq30uJlZIsJgkV19gGsd2Mogpr0qORgfKlYJpmVab4Mp66nt8+vx
	 RIrwisz+8NCTb0s0zbOKackpYA2G/IGh8JVYYdZyEC1c0P88nGxi4Za828K6G3M9Nf
	 YTq/WvjFCaFjQ==
Message-ID: <719745d9-cbb6-4691-a037-2ea7fff8494a@metaparadigm.com>
Date: Thu, 4 Apr 2024 15:59:36 +1300
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
 <1a116a43-fd2e-4f03-8a17-75816fc62717@metaparadigm.com>
 <CAHk-=wiOqTAX7nwQqHJ2Ti3dbxM-HrUJq3FD_Gjua5qW=QAoTg@mail.gmail.com>
Content-Language: en-US
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm
In-Reply-To: <CAHk-=wiOqTAX7nwQqHJ2Ti3dbxM-HrUJq3FD_Gjua5qW=QAoTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 09:57, Linus Torvalds wrote:
> On Wed, 3 Apr 2024 at 13:52, Michael Clark <michael@metaparadigm.com> wrote:
>>
>> On 4/4/24 05:56, Linus Torvalds wrote:
>>> On Tue, 2 Apr 2024 at 13:54, Michael Clark <michael@metaparadigm.com> wrote:
>>>>
>>>> I am working on a low latency cross-platform concurrent pipe buffer
>>>> using C11 threads and atomics.
>>>
>>> You will never get good performance doing spinlocks in user space
>>> unless you actually tell the scheduler about the spinlocks, and have
>>> some way to actually sleep on contention.
>>>
>>> Which I don't see you as having.
>>
>> We can work on this.
> 
> It's been tried.
> 
> Nobody ever found a use-case that is sufficiently convincing, but see
> the write-up at
> 
>     https://lwn.net/Articles/944895/

It's certainly interesting!

I wouldn't throw in the towel so soon until folks tried a bit harder. 
Even if we can't make it faster it would be neat to have an Austin Group 
meeting to give us user-space devels a waitlist_t so we don't hit that 
brain damaged deadlocky cond_wait foot-gun and realize its totally 
broken and that we must use cond_timedwait with some stupid delay until 
we can recheck the condition again in user-space in our "portable code".

Michael.

