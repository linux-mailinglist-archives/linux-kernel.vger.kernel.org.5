Return-Path: <linux-kernel+bounces-22356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE9E829C87
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD2FB26250
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846314B5A3;
	Wed, 10 Jan 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwvPaVQU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3C4A9B7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704896903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dMIStNutlFiVBwZuPV1sf1gnJ2SuNkDDtTHQI8wxuM=;
	b=IwvPaVQU7tcuZolCHcQhKf1g1W3BNyJw1gE6DFs8STpyIXDp7eYyUwW5JWOKg2myosBivb
	EGM8AkvdIwz4xNhIV8COtGQ+7Col43xyq1DOeE2qY82HXPjszWsGU2rXeAkhm/IHx2vf6t
	9u2/VKoFWetlEQjBOwjKmWkEE1sc0RQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-IT_lNvwvPbSCPyzIlp8ohw-1; Wed,
 10 Jan 2024 09:28:18 -0500
X-MC-Unique: IT_lNvwvPbSCPyzIlp8ohw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFCB53C0ED62;
	Wed, 10 Jan 2024 14:28:17 +0000 (UTC)
Received: from [10.22.9.232] (unknown [10.22.9.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 83EC53C2E;
	Wed, 10 Jan 2024 14:28:17 +0000 (UTC)
Message-ID: <b9f8a545-95ff-4ca5-b2af-6d01fd4aaa09@redhat.com>
Date: Wed, 10 Jan 2024 09:28:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] workqueue: Add rcu lock check after work execute end
Content-Language: en-US
To: Xuewen Yan <xuewen.yan@unisoc.com>, tj@kernel.org
Cc: jiangshanlai@gmail.com, ke.wang@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com>
 <20240110032724.3339-1-xuewen.yan@unisoc.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240110032724.3339-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 1/9/24 22:27, Xuewen Yan wrote:
> Now the workqueue just check the atomic and lock after
> work execute end. However, sometimes, drivers's work
> may don't unlock rcu after call rcu_read_lock().
> And as a result, it would cause rcu stall, but the rcu stall warning
> can not dump the work func, because the work has finished.
>
> In order to quickly discover those works that do not call
> rcu_read_unlock after rcu_read_lock(). Add the rcu lock check.
>
> Use rcu_preempt_depth() to check the work's rcu status,
> Normally, this value is 0. If this value is bigger than 0,
> it means the work are still holding rcu lock.
> At this time, we print err info and print the work func.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> V2:
> - move check to unlikely() helper (Longman)
> ---
>   kernel/workqueue.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 2989b57e154a..c2a73364f5ad 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2634,11 +2634,12 @@ __acquires(&pool->lock)
>   	lock_map_release(&lockdep_map);
>   	lock_map_release(&pwq->wq->lockdep_map);
>   
> -	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
> -		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
> +	if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
> +		rcu_preempt_depth() > 0)) {
> +		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
>   		       "     last function: %ps\n",
> -		       current->comm, preempt_count(), task_pid_nr(current),
> -		       worker->current_func);
> +		       current->comm, preempt_count(), rcu_preempt_depth(),
> +		       task_pid_nr(current), worker->current_func);
>   		debug_show_held_locks(current);
>   		dump_stack();
>   	}

This can be a useful additional sanity test.

Reviewed-by: Waiman Long <longman@redhat.com>


