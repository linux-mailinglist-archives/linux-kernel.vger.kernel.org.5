Return-Path: <linux-kernel+bounces-21116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 059D7828A24
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D3E1F25B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170843A1D4;
	Tue,  9 Jan 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TezDVAY1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96D38F9A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704818351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gALjVpnW2FKki+TZoBpk1J20dJjfEldE4c8nd18BouY=;
	b=TezDVAY1qj/rDpPFhc71Zattm/pw5RIwXVXdKrh2PhA//tvDbUaZZVckI+AWtz0p7wqcT7
	ca1sCaqrbOzg15QERV2SgbZJWbMgYfxvo+5kng790Z1gOvN6oej5xjqfkI86uHD8zHtktO
	CCHlRf0UKNh+8yDmN17v5pGT84kcrlQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-9pVJLRnBOb-uYCDMV09uJg-1; Tue, 09 Jan 2024 11:39:05 -0500
X-MC-Unique: 9pVJLRnBOb-uYCDMV09uJg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA16583152B;
	Tue,  9 Jan 2024 16:39:04 +0000 (UTC)
Received: from [10.22.9.97] (unknown [10.22.9.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66CC82949;
	Tue,  9 Jan 2024 16:39:04 +0000 (UTC)
Message-ID: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com>
Date: Tue, 9 Jan 2024 11:39:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] workqueue: Add rcu lock check after work execute end
Content-Language: en-US
To: Xuewen Yan <xuewen.yan@unisoc.com>, tj@kernel.org, jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org, ke.wang@unisoc.com
References: <20240109111014.2689-1-xuewen.yan@unisoc.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240109111014.2689-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 1/9/24 06:10, Xuewen Yan wrote:
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
> it means that the rcu lock is still held after the work ends.
> At this time, we print err info and print the work func.
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/workqueue.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 2989b57e154a..a5a0df824df1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -2634,11 +2634,12 @@ __acquires(&pool->lock)
>   	lock_map_release(&lockdep_map);
>   	lock_map_release(&pwq->wq->lockdep_map);
>   
> -	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
> -		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
> +	if (unlikely(in_atomic() || lockdep_depth(current) > 0) ||
> +		rcu_preempt_depth() > 0) {

The rcu_preempt_depth() check should be within the unlikely() helper. 
Other than that, it looks good to me.

Cheers,
Longman

> +		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
>   		       "     last function: %ps\n",
> -		       current->comm, preempt_count(), task_pid_nr(current),
> -		       worker->current_func);
> +		       current->comm, preempt_count(), rcu_preempt_depth(),
> +		       task_pid_nr(current), worker->current_func);
>   		debug_show_held_locks(current);
>   		dump_stack();
>   	}


