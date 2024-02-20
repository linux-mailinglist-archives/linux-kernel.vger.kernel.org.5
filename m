Return-Path: <linux-kernel+bounces-73496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A027485C380
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AA51F22014
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14578B42;
	Tue, 20 Feb 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMe4b31x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAB7764C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453003; cv=none; b=LSvAJv8eWTKHfVJPpwUAT5hunAVrQ3OgI3DzeF0/DnznGK+/f9NIjSz5O3M221YhdIBYsVkFMJ6SsC4tUJIhL+TpEu/+Gt/jDR4N3EXw63v6F5uxQIqbZKT9UMnEtOIb9W0tpMAIGgyMHp2rXIWsjN8OV745ZnzpL9eRj8zIffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453003; c=relaxed/simple;
	bh=T0fFyQqP3q1hcE58aNQAcgzp0b58SdF4NddGLCl6Icg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kW4/WCgCNg/t6oyOIES0vBmLtNVM9zuJGYzSdYr1LErdLOrhRgyNd+pU8h436Fl/Foz5H1VJczygnLwq8lQsSTlsrfoiSIvwUNHMUi2+VPhGc8353sJg/DXF3S7YdQmqtz5hO2L4ggNht9GuqVQx9INULhsgL3K1Uzd6qcUrsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMe4b31x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708452991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CW58BqIo2kgSoOSF3BI1+OlNiG172/cSBqsJI7jUnGU=;
	b=BMe4b31xP6z2uv/GtpE5A6vZTmZ9jjttQu80iaWaWDZ9h8bK7iSURvi9a16SnRbZf3V1dq
	E4iO5jqzjd4iXVq+r8m5o+G7CCCKxrCrwkseefXoKpf8LFM6q8FehQxRrw7QS5FHdV6bmu
	rF6XUJo6fbspVXfIgBrCa0vtUJRkbAQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-y86hmdgcNhiDYFGaVg-rVw-1; Tue, 20 Feb 2024 13:16:28 -0500
X-MC-Unique: y86hmdgcNhiDYFGaVg-rVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D93E811E79;
	Tue, 20 Feb 2024 18:16:28 +0000 (UTC)
Received: from [10.22.9.202] (unknown [10.22.9.202])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10B29492BC6;
	Tue, 20 Feb 2024 18:16:27 +0000 (UTC)
Message-ID: <03c1eb2e-4eae-49be-94cb-b90894cc00a9@redhat.com>
Date: Tue, 20 Feb 2024 13:16:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
Content-Language: en-US
To: Guo Hui <guohui@uniontech.com>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, David.Laight@ACULAB.COM
Cc: linux-kernel@vger.kernel.org
References: <20240220073058.6435-1-guohui@uniontech.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240220073058.6435-1-guohui@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9


On 2/20/24 02:30, Guo Hui wrote:
> After extensive testing of osq_lock,
> we found that the performance of osq_lock is closely related to
> the distance between NUMA nodes.The greater the distance
> between NUMA nodes,the more serious the performance degradation of
> osq_lock.When a group of processes that need to compete for
> the same lock are on the same NUMA node,the performance of osq_lock
> is the best.when the group of processes is distributed on
> different NUMA nodes,as the distance between NUMA nodes increases,
> the performance of osq_lock becomes worse.
>
> This patch uses the following solutions to improve performance:
> Divide the osq_lock linked list according to NUMA nodes.
> Each NUMA node corresponds to an osq linked list.
> Each CPU is added to the linked list corresponding to
> its respective NUMA node.When the last CPU of
> the NUMA node releases osq_lock,osq_lock is passed to
> the next NUMA node.
>
> As shown in the figure below, the last osq_node1 on NUMA0 passes the lock
> to the first node (osq_node3) of the next NUMA1 node.
>
> -----------------------------------------------------------
> |            NUMA0           |            NUMA1           |
> |----------------------------|----------------------------|
> |  osq_node0 ---> osq_node1 -|-> osq_node3 ---> osq_node4 |
> -----------------------------|-----------------------------
>
> Set an atomic type global variable osq_lock_node to
> record the NUMA node number that can currently obtain
> the osq_lock lock.When the osq_lock_node value is
> a certain node number,the CPU on the node obtains
> the osq_lock lock in turn,and the CPUs on
> other NUMA nodes poll wait.
>
> This solution greatly reduces the performance degradation caused
> by communication between CPUs on different NUMA nodes.
>
> The effect on the 96-core 4-NUMA ARM64 platform is as follows:
> System Benchmarks Partial Index       with patch  without patch  promote
> File Copy 1024 bufsize 2000 maxblocks   2060.8      980.3        +110.22%
> File Copy 256 bufsize 500 maxblocks     1346.5      601.9        +123.71%
> File Copy 4096 bufsize 8000 maxblocks   4229.9      2216.1       +90.87%
>
> The effect on the 128-core 8-NUMA X86_64 platform is as follows:
> System Benchmarks Partial Index       with patch  without patch  promote
> File Copy 1024 bufsize 2000 maxblocks   841.1       553.7        +51.91%
> File Copy 256 bufsize 500 maxblocks     517.4       339.8        +52.27%
> File Copy 4096 bufsize 8000 maxblocks   2058.4      1392.8       +47.79%
That is similar in idea to the numa-aware qspinlock patch series.
> Signed-off-by: Guo Hui <guohui@uniontech.com>
> ---
>   include/linux/osq_lock.h  | 20 +++++++++++--
>   kernel/locking/osq_lock.c | 60 +++++++++++++++++++++++++++++++++------
>   2 files changed, 69 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index ea8fb31379e3..c016c1cf5e8b 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -2,6 +2,8 @@
>   #ifndef __LINUX_OSQ_LOCK_H
>   #define __LINUX_OSQ_LOCK_H
>   
> +#include <linux/nodemask.h>
> +
>   /*
>    * An MCS like lock especially tailored for optimistic spinning for sleeping
>    * lock implementations (mutex, rwsem, etc).
> @@ -11,8 +13,9 @@ struct optimistic_spin_queue {
>   	/*
>   	 * Stores an encoded value of the CPU # of the tail node in the queue.
>   	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
> +	 * The actual number of NUMA nodes is generally not greater than 32.
>   	 */
> -	atomic_t tail;
> +	atomic_t tail[32];

That is a no-go. You are increasing the size of a mutex/rwsem by 128 
bytes. If you want to enable this numa-awareness, you have to do it in a 
way without increasing the size of optimistic_spin_queue. My suggestion 
is to queue optimistic_spin_node in a numa-aware way in osq_lock.c 
without touching optimistic_spin_queue.

Cheers,
Longman


