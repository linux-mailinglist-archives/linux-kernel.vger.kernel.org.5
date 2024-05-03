Return-Path: <linux-kernel+bounces-168369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5718BB7A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E152A1C244DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C585938;
	Fri,  3 May 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyWFAYeu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3D81AAA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775629; cv=none; b=Ox8V8WakRTFXK+MTeUQVZxTrUSJkge4OYa+2GUJ2UAbjuLwEUs4U/bt1k7o+L++jYzc39y43HbJZ9XG09F3M48GCf2KqlTIZpnweI5bbUuTxuw1NW+T8uRBYjsuxrWmJe5ww/VBch21GiGCNszde+cE3HLGsGKeZyzeHgtjImLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775629; c=relaxed/simple;
	bh=xDFNZBvSqbEbTxDn2TC6qdc3zIqNh7A/RKlVBv3uOyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI+ZfyqGpWXQpomAX3WYNca4XLFwny6G3DanA+jduvL+oCGC644vTPgdLSnuEdX9jWgtUdbKjhSskES0x0NstQoo87Y0uaZE6uO2u1wXOxU+fsPbl/E3GOVyTJNr7OuZH7/LqsibKRV0Amc1KRrxHOOmT6gW+t0Tb42d8rF2L5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyWFAYeu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714775626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vszBq6XZYkgdDqLiNAGBuCkg3s8y/4KgnvEKqvVzdOk=;
	b=FyWFAYeu5tEhzd1LilXA4W6cpYwQbmxzyil0N6A8DmOeyOx9Fll/9gQWk9glvSkYH0TuGl
	gCXRMZSwzZWOeqAxZn2Kze7BDT66whRMRca9WWGl5OIlYW5kKqmywiFaXGUDtHRvSlp+bL
	Xgkdxq1shlZDYIxgPEJ65ZbDA/d1xA8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-vSlBPhHKMfaweeFRhgUK_A-1; Fri, 03 May 2024 18:33:43 -0400
X-MC-Unique: vSlBPhHKMfaweeFRhgUK_A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 299A518065AA;
	Fri,  3 May 2024 22:33:43 +0000 (UTC)
Received: from [10.22.34.156] (unknown [10.22.34.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D312A2026963;
	Fri,  3 May 2024 22:33:42 +0000 (UTC)
Message-ID: <ac4a1b8c-b7c8-47a0-82ad-cbe62a166560@redhat.com>
Date: Fri, 3 May 2024 18:33:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/qspinlock: Save qspinlock owner CPU into
 mcs_spinlock
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Vernon Lovejoy <vlovejoy@redhat.com>
References: <20240503215918.639519-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240503215918.639519-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4


On 5/3/24 17:59, Waiman Long wrote:
> When examining a contended spinlock in a crash dump, we can trace out the
> list of lock waiter CPUs waiting for the lock by following the linked
> list of mcs_spinlock structures. However, the actual owner of the lock
> is not there making it hard to figure out who the current lock owner is.
>
> Make it easier to figure out this information by saving the lock owner
> CPU into the mcs_spinlock structure of new MCS lock owner, if available,
> when acquiring the lock in the qspinlock slowpath. We can then follow
> the linked list of mcs_spinlock structures to the end to get an encoded
> CPU number of the lock owner, if set.
>
> This owner information is still not available when the lock is acquired
> directly in the fast path or in the pending code path. There is no easy
> way around that.
>
> The additional cost to get the current CPU number in the slowpath should
> be minimal as it should be in a hot cacheline.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Oh, I forgot that the mcs_spinlock has no backward information. Please 
ignore this patch and will send an updated one later.

Cheers,
Longman

> ---
>   kernel/locking/mcs_spinlock.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index 85251d8771d9..ac0ed0a8f028 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -13,11 +13,17 @@
>   #ifndef __LINUX_MCS_SPINLOCK_H
>   #define __LINUX_MCS_SPINLOCK_H
>   
> +/*
> + * Save an encoded version of the current MCS lock owner CPU to the
> + * mcs_spinlock structure of the next lock owner.
> + */
> +#define MCS_LOCKED	(smp_processor_id() + 1)
> +
>   #include <asm/mcs_spinlock.h>
>   
>   struct mcs_spinlock {
>   	struct mcs_spinlock *next;
> -	int locked; /* 1 if lock acquired */
> +	int locked; /* non-zero if lock acquired */
>   	int count;  /* nesting count, see qspinlock.c */
>   };
>   
> @@ -42,7 +48,7 @@ do {									\
>    * unlocking.
>    */
>   #define arch_mcs_spin_unlock_contended(l)				\
> -	smp_store_release((l), 1)
> +	smp_store_release((l), MCS_LOCKED)
>   #endif
>   
>   /*


