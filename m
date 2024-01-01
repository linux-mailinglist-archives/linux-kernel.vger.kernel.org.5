Return-Path: <linux-kernel+bounces-13826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8068212F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFD91F2212F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 04:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21D8C05;
	Mon,  1 Jan 2024 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuQOV7V8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A98BE0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704082408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2w6gP/r1kZh4IA5V7Iwl9YCEdVnK3Y0Y/TP+Gf1xTU=;
	b=FuQOV7V8G0LGI//0iJ+8BDV/WfgQuIIKJUFJm+50h4qvV+u37Omt9mnXHyktHQ+u56hwdD
	2Nc4SQRuCPne3e3fmHLV1qTlzwmboNVlLl1ClYY4Oz3BpLMIUVj1+RNReJNrkr8IkQItLE
	RjOIObGR8RV+Q/kSAPJen0S7a/lMPEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-bK0lsNcVOzqeuZ2Qc6xYxQ-1; Sun, 31 Dec 2023 23:13:26 -0500
X-MC-Unique: bK0lsNcVOzqeuZ2Qc6xYxQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 615D7185A781;
	Mon,  1 Jan 2024 04:13:26 +0000 (UTC)
Received: from [10.22.16.25] (unknown [10.22.16.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2ACC2166B31;
	Mon,  1 Jan 2024 04:13:25 +0000 (UTC)
Message-ID: <544f928d-4444-4b26-9da6-bdf0c4d9831b@redhat.com>
Date: Sun, 31 Dec 2023 23:13:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 4/5] locking/osq_lock: Avoid writing to node->next
 in the osq_lock() fast path.
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
 <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 12/31/23 16:54, David Laight wrote:
> When osq_lock() returns false or osq_unlock() returns static
> analysis shows that node->next should always be NULL.
> This means that it isn't necessary to explicitly set it to NULL
> prior to atomic_xchg(&lock->tail, curr) on extry to osq_lock().
>
> Just in case there a non-obvious race condition that can leave it
> non-NULL check with WARN_ON_ONCE() and NULL if set.
> Note that without this check the fast path (adding at the list head)
> doesn't need to to access the per-cpu osq_node at all.
>
> Signed-off-by: David Laight <david.laight@aculab.com>
> ---
>   kernel/locking/osq_lock.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 27324b509f68..35bb99e96697 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -87,12 +87,17 @@ osq_wait_next(struct optimistic_spin_queue *lock,
>   
>   bool osq_lock(struct optimistic_spin_queue *lock)
>   {
> -	struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> -	struct optimistic_spin_node *prev, *next;
> +	struct optimistic_spin_node *node, *prev, *next;
>   	int curr = encode_cpu(smp_processor_id());
>   	int prev_cpu;
>   
> -	node->next = NULL;
> +	/*
> +	 * node->next should be NULL on entry.
> +	 * Check just in case there is a race somewhere.
> +	 * Note that this is probably an unnecessary cache miss in the fast path.
> +	 */
> +	if (WARN_ON_ONCE(raw_cpu_read(osq_node.next) != NULL))
> +		raw_cpu_write(osq_node.next, NULL);
>   
>   	/*
>   	 * We need both ACQUIRE (pairs with corresponding RELEASE in
> @@ -104,8 +109,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	if (prev_cpu == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> -	node->prev_cpu = prev_cpu;
> +	node = this_cpu_ptr(&osq_node);
>   	prev = decode_cpu(prev_cpu);
> +	node->prev_cpu = prev_cpu;
>   	node->locked = 0;
>   
>   	/*
Reviewed-by: Waiman Long <longman@redhat.com>


