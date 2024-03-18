Return-Path: <linux-kernel+bounces-106255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1A87EB80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C351F21A85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B234EB42;
	Mon, 18 Mar 2024 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMsfqMYk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4C433D2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773904; cv=none; b=JF7viZryspS11VfuIbnYXpiMAFk3km7Qvkx0GkhO9rrQEmmqIoyLG6BlIlioyGwNQyynJk4W3IfXY7tAmqL05DrlVyOuqqqJSo69Yzp0UNYqosszky/Zconx0XJhdeuPtElQAXwhDdoChB9wuEMtB1J1Tsg0G2H8+kQHhq7zthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773904; c=relaxed/simple;
	bh=tSbVa5Z6btKdp3yW4AkBgCu37ey2+Q3JXVgft6OjBgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDlgvB46bVUeeHBI9EZR65vzAd4PGyZNEhpFpl8gDDR1OMWmNXcKCGPiyZRO8cZnljzDwXukAvhmVlzeU0GiMK9zASx4L49d3s3k5QadqENJ2rZJOdvuJT12Y0W51sq2RLrW0M/RAecKgGHNMLssYiDMmQx9pawiTaTVM7WaPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMsfqMYk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710773901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xMgLu0OCltxyjtXAT4PkoS7YFHB3v1kUByFXQEZ0tc=;
	b=YMsfqMYkQGdo7KceJL16eOFv/mfwEO+iBW0vo3M4yrze+7eTHHwgUepDuYzcEHw6S8FcnQ
	liQ/4VdYu9hjEcyI6dVxJ+Ai+8Ds2wfrvAbQ7oUy3/6eyLdq9+v9lP5ELLzAm8RsvKbEqa
	rVngwcV8fveMYZ5svAugh39zYy27+VU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-oSj0YwSDPdWP0QMJK755yA-1; Mon, 18 Mar 2024 10:58:17 -0400
X-MC-Unique: oSj0YwSDPdWP0QMJK755yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18EF9891E6C;
	Mon, 18 Mar 2024 14:58:17 +0000 (UTC)
Received: from [10.22.34.80] (unknown [10.22.34.80])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5922410F43;
	Mon, 18 Mar 2024 14:58:15 +0000 (UTC)
Message-ID: <802f42ae-a49b-49e5-9cb3-53f26e57cbfb@redhat.com>
Date: Mon, 18 Mar 2024 10:58:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, 'Guo Hui' <guohui@uniontech.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240318055023.25546-1-guohui@uniontech.com>
 <e8e933ab37f84ac68ac70f4b1ed8d524@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e8e933ab37f84ac68ac70f4b1ed8d524@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 3/18/24 05:47, David Laight wrote:
> From: Guo Hui
>> Sent: 18 March 2024 05:50
>>
>> Changes in version v1:
>> The queue is divided according to NUMA nodes,
>> but the tail of each NUMA node is still stored
>> in the structure optimistic_spin_queue.
> The description should be before any 'changes'.
> The changes between versions don't go into the commit message.
>
> Does this change affect a real workload, or just some benchmark?
>
> In reality you don't want a lot of threads waiting on a single
> lock (of any kind).
> So if a real workload is getting a long queue of waiters on
> an OSQ lock then the underlying code really needs fixing to
> 'not do that' (either by changing the way the lock is held
> or acquired).
That is true.
>
> The whole osq lock is actually quite strange.
> (I worked out how it all worked a while ago.)
> It is an ordered queue of threads waiting for the thread
> spinning on a mutex/rwlock to either obtain the mutex or
> to give up spinning and sleep.
> I suspect that the main benefit over spinning on the mutex
> itself is the fact that it is ordered.
> It also remove the 'herd of wildebeest' doing a cmpxchg - but
> one will win and the others do back to a non-locked poll.

The main benefit of doing spinning instead of sleeping is its 
elimination of the task wakeup latency. Think of it this way, the use of 
optimistic spinning is to make a mutex more like a spinlock if none  of 
the lock contenders are going to sleep.

The osq_lock code is to eliminate the lock cacheline bouncing and 
contention problem that hurts performance if there are many spinners. 
The ordering is nice from a fairness point of view, but that is not the 
main motivator for doing osq_lock.

>
> Are the gains you are seeing from the osq-lock code itself,
> or because the thread that ultimately holds the mutex is running
> on the same NUMA node as the previous thread than held the mutex?
>
> One thing I did notice is if the process holding the mutex
> sleeps there is no way to get all the osq spinners to
> sleep at once. They each obtain the osq-lock, realise the
> need to sleep, and release it in turn.
> That is going to take a while with a long queue.
That is true too.
>
> I didn't look at the mutex/rwlock code (I'm sure they
> could be a lot more common - a mutex is a rwlock that
> only has writers!) but if one thread detects that it
> needs to be pre-empted it takes itself out of the osq-lock
> and, presumably, sleeps on the mutex.
> Unless that stops any other threads being added to the osq-lock
> wont it get completely starved?

Both mutex and rwsem has a lock handoff mechanism to disable optimistic 
spinning to avoid lock starvation of sleeping waiters.

Cheers,
Longman


