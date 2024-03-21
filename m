Return-Path: <linux-kernel+bounces-110803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22999886422
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDD11F2219B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6837C24B23;
	Thu, 21 Mar 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="antIcENk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A01E51D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065170; cv=none; b=spbZtXkNX777fXM9iRiN7sL6XKm18T2nLJ7KBrpT3tyAOILl28Ijx8NItTTFAplcj5IybZU02WEQXTLLGHF+DtXrIJIZ+MNNhPtdrhgEUNNvnvftdpB3XiHgPc4YltVEwYE6lLR821LU9oqA4cu7T59QPnzjM9/ZCqzS8ERUAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065170; c=relaxed/simple;
	bh=4Q+p2QjxUsyn/rIV7g00o61wU/Eh8gkjD4j0glgts/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaZE0mG9wK91+y3/IDy6LoLorQ8U5GlqtKUJML83CsupezkNToiyOYE/jDPXMswmi7TkMd/Rj2f1FK1GwXjWGGVjmefabElOWTEpeLL+RByAkN6hwlQHrZSxEModETKCF330rC7waJTDos7MvRx1HSBczEHWLIwY6njQ50Ysrio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=antIcENk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711065166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph3FIOMOHyBf+pCthVqaqeQaRLXOxCyWEwyLs7Vklo8=;
	b=antIcENkGrghyONTvDdn9NT1xWg3wtef1IWrROFOKDSdSjIT4mvtwGblp3c6NocRnmkhPN
	67LbtFk7vSslAZf66aWSVmdhJIB4NMJw8xxIKCJhnGGiVt6yXGpS+8Ls5q3Z0ZlXA1ADbc
	4QbtgVirOCp6LJ3jfKVu9d6EzA10Bj0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-r4TfCC1VOJm8N5GRtB0_pA-1; Thu,
 21 Mar 2024 19:52:43 -0400
X-MC-Unique: r4TfCC1VOJm8N5GRtB0_pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92C5C1C04198;
	Thu, 21 Mar 2024 23:52:42 +0000 (UTC)
Received: from [10.22.32.107] (unknown [10.22.32.107])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 443603C20;
	Thu, 21 Mar 2024 23:52:42 +0000 (UTC)
Message-ID: <feb68b86-899e-42a2-a680-4a73366e540d@redhat.com>
Date: Thu, 21 Mar 2024 19:52:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/qspinlock: Use atomic_try_cmpxchg_relaxed() in
 xchg_tail()
Content-Language: en-US
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20240321195309.484275-1-ubizjak@gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240321195309.484275-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 3/21/24 15:52, Uros Bizjak wrote:
> Use atomic_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> atomic_cmpxchg_relaxed (*ptr, old, new) == old in xchg_tail().
> x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg.
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
>   kernel/locking/qspinlock.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..1df5fef8a656 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -220,21 +220,18 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>    */
>   static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>   {
> -	u32 old, new, val = atomic_read(&lock->val);
> +	u32 old, new;
>   
> -	for (;;) {
> -		new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> +	old = atomic_read(&lock->val);
> +	do {
> +		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
>   		/*
>   		 * We can use relaxed semantics since the caller ensures that
>   		 * the MCS node is properly initialized before updating the
>   		 * tail.
>   		 */
> -		old = atomic_cmpxchg_relaxed(&lock->val, val, new);
> -		if (old == val)
> -			break;
> +	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
>   
> -		val = old;
> -	}
>   	return old;
>   }
>   #endif /* _Q_PENDING_BITS == 8 */

LGTM, note that this xchg_tail() variant is not used in all the distros 
that I am aware of as it requires NR_CPUS >= 16k.

Reviewed-by: Waiman Long <longman@redhat.com>



