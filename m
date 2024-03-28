Return-Path: <linux-kernel+bounces-122308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005AA88F4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E2029F7E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFE21364;
	Thu, 28 Mar 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9UKqMWB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0A22092
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590786; cv=none; b=hu8NWLXeGYBuqUhgGnrrJfVvwVVyZ4jA7bievyyyuaVqNtQWFRI+IU00ReQ6cw5EYb6085/7LUiNGKqI7juhtiYZwogzjCCmEBOlPXe7cwCeXD/7oazeaP/9haC4/LTfymRmYD5lXjCZIAw3ZMwoYOUEYT46W+m8dLcTFnbifEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590786; c=relaxed/simple;
	bh=AH3ZSLj4vhSj2IBP6+WKnZ5lWH4r9Ur13Q6fmrRBewo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfDhnabOaz1C58H5OZ7+IVZpim93L7GHkuZvEDIE6mIMiu4yM0xJp9Kyr1t8sVONewLij8dxA91m/CswDvWXkStIu6osiRVWG6+P5znA6n1FDjxsoMyUmLDxTP3uVCMmrNoCZP38LOMJPFOe2V7IK1QLZghZuNiPnZMr+VLQQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9UKqMWB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711590784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGrCCIEqgGoPQ+c4NYkn0V6dFitHSmmoXt4A1C3TGLs=;
	b=J9UKqMWBYOQO8oMZ7fdSF9Hl3BwGSVNXJwk0M4PO7Q4x5qOEW7VxiS3IvVsiQXlBnZR7GP
	3JL/A6cQnSHYwd/AG0TINBK2ReZCq+RWOSL6Ux2+15CEb2GMYllVp6Kk3uTz7CFi2DRKVz
	IOYho9rSciaVg7zBgD5HYWTnyoY3mTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-lk96PMowNmi8VSOtzW0Kmw-1; Wed, 27 Mar 2024 21:52:56 -0400
X-MC-Unique: lk96PMowNmi8VSOtzW0Kmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 500C385A58B;
	Thu, 28 Mar 2024 01:52:56 +0000 (UTC)
Received: from [10.22.33.225] (unknown [10.22.33.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 07C0F1C060D0;
	Thu, 28 Mar 2024 01:52:55 +0000 (UTC)
Message-ID: <38ba7584-3e74-44e3-b1f5-6e42179856a5@redhat.com>
Date: Wed, 27 Mar 2024 21:52:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/pvqspinlock: Use try_cmpxchg_acquire() in
 trylock_clear_pending()
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240325140943.815051-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 3/25/24 10:09, Uros Bizjak wrote:
> Use try_cmpxchg_acquire(*ptr, &old, new) instead of
> cmpxchg_relaxed(*ptr, old, new) == old in trylock_clear_pending().
> x86 CMPXCHG instruction returns success in ZF flag, so this change
> saves a compare after cmpxchg.
>
> Also change the return type of the function to bool.
>
> No functional change intended.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   kernel/locking/qspinlock_paravirt.h | 31 ++++++++++++-----------------
>   1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
> index 169950fe1aad..77ba80bd95f9 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -116,11 +116,12 @@ static __always_inline void set_pending(struct qspinlock *lock)
>    * barrier. Therefore, an atomic cmpxchg_acquire() is used to acquire the
>    * lock just to be sure that it will get it.
>    */
> -static __always_inline int trylock_clear_pending(struct qspinlock *lock)
> +static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
>   {
> +	u16 old = _Q_PENDING_VAL;
> +
>   	return !READ_ONCE(lock->locked) &&
> -	       (cmpxchg_acquire(&lock->locked_pending, _Q_PENDING_VAL,
> -				_Q_LOCKED_VAL) == _Q_PENDING_VAL);
> +	       try_cmpxchg_acquire(&lock->locked_pending, &old, _Q_LOCKED_VAL);
>   }
>   #else /* _Q_PENDING_BITS == 8 */
>   static __always_inline void set_pending(struct qspinlock *lock)
> @@ -128,27 +129,21 @@ static __always_inline void set_pending(struct qspinlock *lock)
>   	atomic_or(_Q_PENDING_VAL, &lock->val);
>   }
>   
> -static __always_inline int trylock_clear_pending(struct qspinlock *lock)
> +static __always_inline bool trylock_clear_pending(struct qspinlock *lock)
>   {
> -	int val = atomic_read(&lock->val);
> -
> -	for (;;) {
> -		int old, new;
> -
> -		if (val  & _Q_LOCKED_MASK)
> -			break;
> +	int old, new;
>   
> +	old = atomic_read(&lock->val);
> +	do {
> +		if (old & _Q_LOCKED_MASK)
> +			return false;
>   		/*
>   		 * Try to clear pending bit & set locked bit
>   		 */
> -		old = val;
> -		new = (val & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
> -		val = atomic_cmpxchg_acquire(&lock->val, old, new);
> +		new = (old & ~_Q_PENDING_MASK) | _Q_LOCKED_VAL;
> +	} while (!atomic_try_cmpxchg_acquire (&lock->val, &old, new));
>   
> -		if (val == old)
> -			return 1;
> -	}
> -	return 0;
> +	return true;
>   }
>   #endif /* _Q_PENDING_BITS == 8 */
>   
Reviewed-by: Waiman Long <longman@redhat.com>


