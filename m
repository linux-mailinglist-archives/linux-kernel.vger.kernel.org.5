Return-Path: <linux-kernel+bounces-13823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461518212F1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FDC282331
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26819EC7;
	Mon,  1 Jan 2024 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ+N7ne4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707BA5A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704082164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ChtrIcmjzv1mH8hapA1WonjnaM6IRYgbnIKPoH/S1kA=;
	b=fJ+N7ne4ryD443qB6cs4pP5AsXxMmZk38y7wGRlD9e16eh33lYZedE0+7KmQ8wfAUECB1i
	658aPKfq14tfZ2Jp15JmugCkHeVIWU9d/oib7xXwAaxCTC4FoIBnu8hSeaaCpePWT4za3B
	yRy3cBjBzDnff+C+C2r+RavxMyxjhjE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-rawozoFjP_6dTpZyS08TyQ-1; Sun, 31 Dec 2023 23:09:20 -0500
X-MC-Unique: rawozoFjP_6dTpZyS08TyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3039884AC60;
	Mon,  1 Jan 2024 04:09:20 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B858251D5;
	Mon,  1 Jan 2024 04:09:19 +0000 (UTC)
Message-ID: <3a66efbd-fce0-49c3-bd71-63d52078d243@redhat.com>
Date: Sun, 31 Dec 2023 23:09:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 2/5] locking/osq_lock: Optimise the
 vcpu_is_preempted() check.
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'peterz@infradead.org'" <peterz@infradead.org>
Cc: "'mingo@redhat.com'" <mingo@redhat.com>,
 "'will@kernel.org'" <will@kernel.org>,
 "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 "'virtualization@lists.linux-foundation.org'"
 <virtualization@lists.linux-foundation.org>,
 'Zeng Heng' <zengheng4@huawei.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 12/31/23 16:52, David Laight wrote:
> The vcpu_is_preempted() test stops osq_lock() spinning if a virtual
> cpu is no longer running.
>
> Although patched out for bare-metal the code still needs the cpu number.
> Reading this from 'prev->cpu' is a pretty much guaranteed have a cache miss
> when osq_unlock() is waking up the next cpu.
>
> Instead save 'prev->cpu' in 'node->prev_cpu' and use that value instead.
> Update in the osq_lock() 'unqueue' path when 'node->prev' is changed.
>
> This is simpler than checking for 'node->prev' changing and caching
> 'prev->cpu'.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index e0bc74d85a76..eb8a6dfdb79d 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -14,8 +14,9 @@
>   
>   struct optimistic_spin_node {
>   	struct optimistic_spin_node *next, *prev;
> -	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> +	int locked;    /* 1 if lock acquired */
> +	int cpu;       /* encoded CPU # + 1 value */
> +	int prev_cpu;  /* encoded CPU # + 1 value */
>   };
>   
>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
> @@ -29,11 +30,6 @@ static inline int encode_cpu(int cpu_nr)
>   	return cpu_nr + 1;
>   }
>   
> -static inline int node_cpu(struct optimistic_spin_node *node)
> -{
> -	return node->cpu - 1;
> -}
> -
>   static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>   {
>   	int cpu_nr = encoded_cpu_val - 1;
> @@ -110,9 +106,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> -	node->locked = 0;
> +	node->prev_cpu = old;
>   	prev = decode_cpu(old);
>   	node->prev = prev;
> +	node->locked = 0;
>   
>   	/*
>   	 * osq_lock()			unqueue
> @@ -144,7 +141,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * polling, be careful.
>   	 */
>   	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
> -				  vcpu_is_preempted(node_cpu(node->prev))))
> +				  vcpu_is_preempted(READ_ONCE(node->prev_cpu) - 1)))
>   		return true;
>   
>   	/* unqueue */
> @@ -201,6 +198,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * it will wait in Step-A.
>   	 */
>   
> +	WRITE_ONCE(next->prev_cpu, prev->cpu);
>   	WRITE_ONCE(next->prev, prev);
>   	WRITE_ONCE(prev->next, next);
>   

Reviewed-by: Waiman Long <longman@redhat.com>

Reviewed-by: Waiman Long <longman@redhat.com>


