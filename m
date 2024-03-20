Return-Path: <linux-kernel+bounces-108292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA58808D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E91F23D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422271388;
	Wed, 20 Mar 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fybXy7YT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CE10EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896304; cv=none; b=lg4C6VQDGvPSBMWDpgT0bIFi4214sA4LvnjDPx0tL9fksMMFZdohtgBrA5y0dVvod43KInAPjJTN5vdRt5j7L2+wu2IgI6bcCXipGDYAYeYQ//hkPR8SqOWWdCUSUB8O5Jw4AoNFJr6ThxqzTD4d/j0hfqTH1qL4t+HSxaCuvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896304; c=relaxed/simple;
	bh=ODDLhKu+1KU4V9mcHaNAcljdYol6uu6w9jDZtEjqggQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL3UdZuhMzdysMNypdHe1jLxDyzYMiYwCZ3xAj1uWsQ7qUEyqow8jzXJpJ1Rf+fSWqd30fbRFf65NPJzi5CdYKmW+1Bbzzh0x+E0QpDpuK/DtdhXCXXw/g+WpDO4IX1DkiW292if2x89ESpN+ftuQI+3uETHcSABtD1ME1Ny4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fybXy7YT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710896301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZevwqzcF4VmkqXpA8LuwY1scKO7py2l61oxTNHbrbs=;
	b=fybXy7YTJrx5bSOsOBkElIl2faihnSPSoQOmTbseAaVyZNNmhdvgC9LZIQnYW+niKJNpOL
	5es5ti0QSKLlx0AD9Ue5fZDXiau7W8phChl2m3bwXzQJRaPpCpcj0KN/5oI0ys/qhyvhEG
	W6DPNpNgt4aEZBWTtzCLV1KDBFEEcd4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-KC4uT-v_NJ6GNUJID8XoVA-1; Tue,
 19 Mar 2024 20:58:19 -0400
X-MC-Unique: KC4uT-v_NJ6GNUJID8XoVA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABE9F1C031B0;
	Wed, 20 Mar 2024 00:58:18 +0000 (UTC)
Received: from [10.22.10.159] (unknown [10.22.10.159])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39AEE492BD1;
	Wed, 20 Mar 2024 00:58:18 +0000 (UTC)
Message-ID: <b346622a-f68f-42ce-8ea9-0445354250d8@redhat.com>
Date: Tue, 19 Mar 2024 20:58:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Clark Williams <williams@redhat.com>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
 <20240319141506.DUd9NKl4@linutronix.de>
 <9b4f3dac-779a-4eef-945b-3ca1455c0dfe@redhat.com>
 <20240319182050.U4AzUF3I@linutronix.de>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240319182050.U4AzUF3I@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 3/19/24 14:20, Sebastian Andrzej Siewior wrote:
> The commit cited below broke the build for PREEMPT_RT because
> rwsem_assert_held_write_nolockdep() passes a struct rw_semaphore but
> rw_base_assert_held_write() expects struct rwbase_rt. Fixing the type
> alone leads to the problem that WARN_ON() is not found because bug.h is
> missing.
>
> In order to resolve this:
> - Keep the assert (WARN_ON()) in rwsem.h (not rwbase_rt.h)
> - Make rwsem_assert_held_write_nolockdep() do the implementation
>    specific (rw_base) writer check.
> - Replace the "inline" with __always_inline which was used before.
>
> Fixes: f70405afc99b1 ("locking: Add rwsem_assert_held() and rwsem_assert_held_write()")
> Reported-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>    - Merge rwsem_held_write() into rwsem_assert_held_write_nolockdep() as
>      per Waiman Long / Matthew Wilcox.
>
>   include/linux/rwbase_rt.h | 4 ++--
>   include/linux/rwsem.h     | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
> index 29c4e4f243e47..f2394a409c9d5 100644
> --- a/include/linux/rwbase_rt.h
> +++ b/include/linux/rwbase_rt.h
> @@ -31,9 +31,9 @@ static __always_inline bool rw_base_is_locked(const struct rwbase_rt *rwb)
>   	return atomic_read(&rwb->readers) != READER_BIAS;
>   }
>   
> -static inline void rw_base_assert_held_write(const struct rwbase_rt *rwb)
> +static __always_inline bool rw_base_is_write_locked(const struct rwbase_rt *rwb)
>   {
> -	WARN_ON(atomic_read(&rwb->readers) != WRITER_BIAS);
> +	return atomic_read(&rwb->readers) == WRITER_BIAS;
>   }
>   
>   static __always_inline bool rw_base_is_contended(const struct rwbase_rt *rwb)
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 4f1c18992f768..c8b543d428b0a 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -167,14 +167,14 @@ static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
>   	return rw_base_is_locked(&sem->rwbase);
>   }
>   
> -static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +static __always_inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
>   {
>   	WARN_ON(!rwsem_is_locked(sem));
>   }
>   
> -static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
>   {
> -	rw_base_assert_held_write(sem);
> +	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
>   }
>   
>   static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
Reviewed-by: Waiman Long <longman@redhat.com>


