Return-Path: <linux-kernel+bounces-84266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09DC86A456
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7D91C2395A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AFF394;
	Wed, 28 Feb 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PADcZh3v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9D184
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079540; cv=none; b=KmKxfqaMd34SNq1t0/ZgpwvuaL1LDXdQbd6lg24LqqbYreDpLGQ1JGNarMC3D8eaOEq8zmo43LqtYWNW/u3O8uaQwxR9YKo85oPWu2mVvI9+CCEjiSv2U6nQ0dKYruFUtk5cevs1IQUHmIsZTKUidwdaGnipm98a0jxNSXbZ8MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079540; c=relaxed/simple;
	bh=FVSeD4Pk2eVwQO7m1VCe3ZeIpBK/+5YdtA765iGVivc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouB1QOFEprik1VgH3Lnd3rFv/zb8CrbaPsl7nCBYFOR78lUhnyry9yYWksLNGGx9TghTvZKFmYJE9xkLlIpgNOp6veasOCDWbAqISEX4lndG7UUzDgb0qMOUsAObxfGOG5UqBiRyN94RyCHIA3JFiEiUnfZ44TuT115lVqsGCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PADcZh3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709079537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+y2/rIrM//LoT0p81Y4fj7h17Wgjo3fgrDHfZo+yaug=;
	b=PADcZh3v8HtFSNuGegjuedUrTfiM99B8sI3uqikxf6qnAklfC4u2K1nGS87e7iua5bM70Y
	vHzgNfSzLl1Vuw3Q0Mf9OuLcep112ieRUy2u/r6l2fT1LGJglb7yflRIwI9SlrbTf2PPCc
	iglAirnmH6n45a6QKTh42IiUU2HS+vQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-OhloJvxeMT2_iyrzYD1kpw-1; Tue, 27 Feb 2024 19:18:56 -0500
X-MC-Unique: OhloJvxeMT2_iyrzYD1kpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 970A6185A780;
	Wed, 28 Feb 2024 00:18:55 +0000 (UTC)
Received: from [10.22.17.72] (unknown [10.22.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C419492BC6;
	Wed, 28 Feb 2024 00:18:55 +0000 (UTC)
Message-ID: <c29d648c-451a-42af-81d3-e1660e3af46f@redhat.com>
Date: Tue, 27 Feb 2024 19:18:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/percpu-rwsem: Trigger contention tracepoints only
 if contended
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <20231108215322.2845536-1-namhyung@kernel.org>
 <CAM9d7chyJun57UV-6qRzgTzDEmUu5Z0mStgjRbrg2dcjUkMQzw@mail.gmail.com>
 <CAM9d7cjQv=RiOkW5=7vXUSwQn5v1XQNiJyL9egGy2VgmKWO69Q@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAM9d7cjQv=RiOkW5=7vXUSwQn5v1XQNiJyL9egGy2VgmKWO69Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 2/27/24 18:02, Namhyung Kim wrote:
> Hello,
>
> On Mon, Nov 20, 2023 at 12:28 PM Namhyung Kim <namhyung@kernel.org> wrote:
>> Ping!
>>
>> On Wed, Nov 8, 2023 at 1:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>> It mistakenly fires lock contention tracepoints always in the writer path.
>>> It should be conditional on the try lock result.
> Can anybody take a look at this?  This makes a large noise
> in the lock contention result.
>
> Thanks,
> Namhyung
>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>   kernel/locking/percpu-rwsem.c | 11 ++++++++---
>>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
>>> index 185bd1c906b0..6083883c4fe0 100644
>>> --- a/kernel/locking/percpu-rwsem.c
>>> +++ b/kernel/locking/percpu-rwsem.c
>>> @@ -223,9 +223,10 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
>>>
>>>   void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>>>   {
>>> +       bool contended = false;
>>> +
>>>          might_sleep();
>>>          rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
>>> -       trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
>>>
>>>          /* Notify readers to take the slow path. */
>>>          rcu_sync_enter(&sem->rss);
>>> @@ -234,8 +235,11 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>>>           * Try set sem->block; this provides writer-writer exclusion.
>>>           * Having sem->block set makes new readers block.
>>>           */
>>> -       if (!__percpu_down_write_trylock(sem))
>>> +       if (!__percpu_down_write_trylock(sem)) {
>>> +               trace_contention_begin(sem, LCB_F_PERCPU | LCB_F_WRITE);
>>>                  percpu_rwsem_wait(sem, /* .reader = */ false);
>>> +               contended = true;
>>> +       }
>>>
>>>          /* smp_mb() implied by __percpu_down_write_trylock() on success -- D matches A */
>>>
>>> @@ -247,7 +251,8 @@ void __sched percpu_down_write(struct percpu_rw_semaphore *sem)
>>>
>>>          /* Wait for all active readers to complete. */
>>>          rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
>>> -       trace_contention_end(sem, 0);
>>> +       if (contended)
>>> +               trace_contention_end(sem, 0);
>>>   }
>>>   EXPORT_SYMBOL_GPL(percpu_down_write);
>>>
>>> --
>>> 2.42.0.869.gea05f2083d-goog

Yes, that makes sense. Sorry for missing this patch.

Reviewed-by: Waiman Long <longman@redhat.com>


