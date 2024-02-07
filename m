Return-Path: <linux-kernel+bounces-57052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA184D35E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF451F23E72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165F127B46;
	Wed,  7 Feb 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSTAfZLg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD11EB5D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339553; cv=none; b=EreKAmS5R54lWcleHh5r6ALYnHW6gny3m27cQbjsnSM2HarUh3qcqQiP2hNH0TCssXYyFziFDBbsqm3PKN7T7KLEUyTlUseACJ/EkmbgM80APCIeQUWCtVtNls77ZQFR44yz6DEVtHm2dQNw/fl10KKHrYXQV4FbQignG1vV7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339553; c=relaxed/simple;
	bh=1u8+w8JRDRlMuGyzCQ6b/QFRYRG08f0EBzEHIQL5020=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2hIWuQpZxKmflQ2mA/kKKHzgzYmswEdo4i9sh4RLgeJSPYwjeL9gnxv2sIAhf0usyDhXPlVRoch4+8J6SxbG4vj9r/7w7WLOEuB5KGLjJhfwd3Md4bqq/6f9XQwLzgCQ9R7ZAYJ0M6AtLcvbx5gNIlOdL2QjtZnmu3xJbfVplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSTAfZLg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707339550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urdSK3q6LEylT9J40lI59X25HcIsTQfG2a5ZKmLblw4=;
	b=XSTAfZLgkuzsaO92BLRwQ44x4XtwCZU5V5k4vKP2pXGH6Zha0bJjaBXvztVJN0DN4U3lfu
	LATXySoOmR1HyFY29yvters8OijOG429mJjJ/icdsfR5XfbhjTAawU6r+5ztFkSiuymKPD
	BSoFOO9yxxkrGvIQIOX73pK5lY/OyyM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-posd1eLwMruFSA0G1t4pow-1; Wed,
 07 Feb 2024 15:59:07 -0500
X-MC-Unique: posd1eLwMruFSA0G1t4pow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B86873C0009F;
	Wed,  7 Feb 2024 20:59:06 +0000 (UTC)
Received: from [10.22.9.228] (unknown [10.22.9.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47B2D2166B31;
	Wed,  7 Feb 2024 20:59:06 +0000 (UTC)
Message-ID: <69641d8a-8f1c-4a57-81af-0b26c8b1d2cd@redhat.com>
Date: Wed, 7 Feb 2024 15:59:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wq/for-6.9 v4 2/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
 Costa Shulyupin <cshulyup@redhat.com>
References: <20240207011911.975608-1-longman@redhat.com>
 <20240207011911.975608-3-longman@redhat.com>
 <ZcO8-JDXkoDeMFVT@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcO8-JDXkoDeMFVT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 2/7/24 12:25, Tejun Heo wrote:
> Hello, Waiman.
>
> On Tue, Feb 06, 2024 at 08:19:09PM -0500, Waiman Long wrote:
> ...
>> + * The unplugging is done either in apply_wqattrs_cleanup() [fast path] when
>> + * the workqueue was idle or in pwq_release_workfn() [slow path] when the
>> + * workqueue was busy.
> I'm not sure the distinction between fast and slow paths is all that useful
> here. Both are really cold paths.
Yes, both are cold paths. Maybe a more accurate description is with 
respect to the latency that a new work item may experience since 
apply_wqattrs_cleanup() should be executed earlier than 
pwq_release_workfn().
>
>> +static void unplug_oldest_pwq(struct workqueue_struct *wq,
>> +			      struct pool_workqueue *exlude_pwq)
>> +{
>> +	struct pool_workqueue *pwq;
>> +	unsigned long flags;
>> +	bool found = false;
>> +
>> +	for_each_pwq(pwq, wq) {
>> +		if (pwq == exlude_pwq)
>> +			continue;
>> +		if (!pwq->plugged)
>> +			return;	/* No unplug needed */
>> +		found = true;
>> +		break;
>> +	}
>> +	if (WARN_ON_ONCE(!found))
>> +		return;
>> +
>> +	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
>> +	if (!pwq->plugged)
>> +		goto out_unlock;
>> +	pwq->plugged = false;
>> +	if (pwq_activate_first_inactive(pwq, true))
>> +		kick_pool(pwq->pool);
>> +out_unlock:
>> +	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
>> +}
> I don't quite understand why this needs iteration and @exclude_pwq.
> Shouldn't something like the following be enough?
>
> static void unplug_oldest_pwq(struct workqueue_struct *wq)
> {
> 	struct pool_workqueue *pwq;
>
> 	raw_spin_lock_irq(&pwq->pool->lock);
> 	pwq = list_first_entry_or_null(&pwq->pwqs, ...);
> 	if (pwq)
> 		pwq->plugged = false;
> 	raw_spin_unlock_irq(&pwq->pool->lock);
> }
>
It is because this function can be called from apply_wqattrs_cleanup() 
where I need to exclude ctx->dfl_pwq from being considered.
>> @@ -4740,6 +4796,13 @@ static void pwq_release_workfn(struct kthread_work *work)
>>   		mutex_lock(&wq->mutex);
>>   		list_del_rcu(&pwq->pwqs_node);
>>   		is_last = list_empty(&wq->pwqs);
>> +
>> +		/*
>> +		 * For ordered workqueue with a plugged dfl_pwq, restart it now.
>> +		 */
>> +		if (!is_last && (wq->flags & __WQ_ORDERED))
>> +			unplug_oldest_pwq(wq, NULL);
> This makes sense.
>
>> @@ -4906,8 +4969,26 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
> ...
>> +		/*
>> +		 * It is possible that ctx->dfl_pwq (previous wq->dfl_pwq)
>> +		 * may not be the oldest one with the plugged flag still set.
>> +		 * unplug_oldest_pwq() will still do the right thing to allow
>> +		 * only one unplugged pwq in the workqueue.
>> +		 */
>> +		if ((ctx->wq->flags & __WQ_ORDERED) &&
>> +		     ctx->dfl_pwq && !ctx->dfl_pwq->refcnt)
>> +			unplug_oldest_pwq(ctx->wq, ctx->dfl_pwq);
>> +		rcu_read_unlock();
> But why do we need this? Isn't all that needed to call unplug_oldest during
> workqueue initialization and chaining unplugging from pwq release from there
> on?

Yes, it is possible to just do unplug_oldest_pwq() in 
pwq_release_workfn() and don't do it in apply_wqattrs_cleanup(). As said 
above, I just want to reduce the latency when the old pwq to be retired 
is idle. I can certainly update the patch to just do it in 
pwq_release_workfn() if you don't that it is necessary to do that too in 
apply_wqattrs_cleanup(). That will eliminate the need for the extra 
arugment and simplify unplug_oldest_pwq().

Cheers,
Longman



