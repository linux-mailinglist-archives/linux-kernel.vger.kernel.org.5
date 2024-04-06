Return-Path: <linux-kernel+bounces-133775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 344D689A87A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43AB282D37
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38327125DC;
	Sat,  6 Apr 2024 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3KC/a7V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CB8C8E1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712371202; cv=none; b=gttU3oS4JC21kCY40KWaT9+D41Cpjfn6TB1Kg3bDuJBXASL5J8dRpJM8T+c5a0bzW46LMk6R7gGtYZcFmrHtb9eco31jCgbZhWbo1oAD4lS62PcT9QYcHPa8GhEb/WONuCG6lMYno2HSE3nJgOSjRPdrpi1PSnidoMjdw1ppY1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712371202; c=relaxed/simple;
	bh=sO2EQQtfCTdFd4jXvSDM2x+7AjI/KHqqPxsujAmIuGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zs84QXTNwoy1EHLbShYAhkLyZXBoW3dQeyDZjJzoIBQET0vjWbmnqa/kg5gfn7WCXWIKKwqWoZkij3+pYNUmV1mX7LtUsdyKwSghCCPHcScslkAzGyMPvQG3BaxTQMcaQL/qNzb4/kxd6G+lmApyCsYEUG4xliV7w18wwMqfnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3KC/a7V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712371199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhyMJE+ElOP3Y8M4yz3wVNLcPBnn/sRAIecaPUAaVLE=;
	b=d3KC/a7VHAIoix8xnF61o/UGMcu4aS5DU61045BEguOjqVAn2026kKIA9ErRCdwQNSBmsg
	C5EQNUIrt7Mi9ioFDyQd/UlhMswsIg01zyu0kFfWyfeYcXmOjoRdOsh7lxDbqp1zWOquHz
	LFFwT3ksJEOKzXfELYlVP7k+cwXJoSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-oHgtdRbfNxuBy6vv9oRanA-1; Fri, 05 Apr 2024 22:39:56 -0400
X-MC-Unique: oHgtdRbfNxuBy6vv9oRanA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23DE380B1E0;
	Sat,  6 Apr 2024 02:39:56 +0000 (UTC)
Received: from [10.22.10.118] (unknown [10.22.10.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5E1940C6CB3;
	Sat,  6 Apr 2024 02:39:55 +0000 (UTC)
Message-ID: <221c28a1-cb61-4a8f-96b5-d9407e53d759@redhat.com>
Date: Fri, 5 Apr 2024 22:39:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] locking/rwsem: Add __always_inline annotation to
 __down_write_common() and inlined callers
Content-Language: en-US
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Tim Murray <timmurray@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 kernel-team@android.com
References: <20240405200535.2239155-1-jstultz@google.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240405200535.2239155-1-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 4/5/24 16:05, John Stultz wrote:
> Apparently despite it being marked inline, the compiler
> may not inline __down_write_common() which makes it difficult
> to identify the cause of lock contention, as the blocked
> function in traceevents will always be listed as
> __down_write_common().
>
> So add __always_inline annotation to the common function (as
> well as the inlined helper callers) to force it to be inlined
> so the blocking function will be listed (via Wchan) in
> traceevents.
>
> This mirrors commit 92cc5d00a431 ("locking/rwsem: Add
> __always_inline annotation to __down_read_common() and inlined
> callers") which did the same for __down_read_common.
>
> I sort of worry that I'm playing wack-a-mole here, and talking
> with compiler people, they tell me inline means nothing, which
> makes me want to cry a little. So I'm wondering if we need to
> replace all the inlines with __always_inline, or remove them
> because either we mean something by it, or not.
>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: kernel-team@android.com
> Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
> Reported-by: Tim Murray <timmurray@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>   kernel/locking/rwsem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index c6d17aee4209..33cac79e3994 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1297,7 +1297,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
>   /*
>    * lock for writing
>    */
> -static inline int __down_write_common(struct rw_semaphore *sem, int state)
> +static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
>   {
>   	int ret = 0;
>   
> @@ -1310,12 +1310,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
>   	return ret;
>   }
>   
> -static inline void __down_write(struct rw_semaphore *sem)
> +static __always_inline void __down_write(struct rw_semaphore *sem)
>   {
>   	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
>   }
>   
> -static inline int __down_write_killable(struct rw_semaphore *sem)
> +static __always_inline int __down_write_killable(struct rw_semaphore *sem)
>   {
>   	return __down_write_common(sem, TASK_KILLABLE);
>   }

Whether inlining happens or not really depends on the compiler used. Anyway,

Acked-by: Waiman Long <longman@redhat.com>


Thanks,
Longman


