Return-Path: <linux-kernel+bounces-46856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A209F84457C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582D7296B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57812CD9F;
	Wed, 31 Jan 2024 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwmnLCBn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD012BF29
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720552; cv=none; b=CiGXtJdAkpVoGmbsLDqxjeXR5InjBfv5BzxR/KwU+57bfETtd7/FA458b3juASfZtc6/Tki4XU3U0bA42VlSuXsZYICNvTBCkVtv8rFAHyS5wyY4OG9J+kFVYQrOa90dZMR6trJAf/jH3KZIRH+dA5ThSC/QGbIOVhpPcxPThZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720552; c=relaxed/simple;
	bh=hTg5k74QmpvyvwjY4YbpJ3C/Nr/lrvB+Z01K6o3yy00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUzeObbCy2xk+FWT4M0peUXeC2qStgqqDgQchWXjO0Qyxc92Y73qIvBOHH5rY4axbR9m2jKL6yklxoVFPwHAxxnHhxrArEiGtgAul4qKP5Wjy2VtaYIzUcXv5YMpIW893GSqjHkyK80jJE5t4KGUKH2T2YTt6b9zWSrdRmliiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwmnLCBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706720549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PPWOOEFuJus9zo4CJIRzMe9cHcboMBvYvYCgkjyXYM=;
	b=ZwmnLCBnMxJIHLNRHQwQJ4yhV6HVZDKj5jR0+3S6tJSiRO0GHtXLSc/pl2QDc/z4vKvsaX
	SitM3oj6+JXq2W0wKU9siwwjTJeCv3iygn2KIeMCF77qGONKt845cZFYsFm6MbJ9urRu0i
	tr5vRllbvyWAmuRfIs4q0mLDI+okfgo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-TEyGMUkjMv-SjfJFdFiMew-1; Wed,
 31 Jan 2024 12:02:25 -0500
X-MC-Unique: TEyGMUkjMv-SjfJFdFiMew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4F593810B1A;
	Wed, 31 Jan 2024 17:02:24 +0000 (UTC)
Received: from [10.22.18.157] (unknown [10.22.18.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8646D134;
	Wed, 31 Jan 2024 17:02:24 +0000 (UTC)
Message-ID: <16edcd04-061e-4e6a-87a1-681810432edb@redhat.com>
Date: Wed, 31 Jan 2024 12:02:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] workqueue: Enable unbound cpumask update on
 ordered workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Cestmir Kalina <ckalina@redhat.com>,
 Alex Gladkov <agladkov@redhat.com>
References: <20240130183336.511948-1-longman@redhat.com>
 <20240130183336.511948-4-longman@redhat.com>
 <Zbp8k1mbKuujC94q@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zbp8k1mbKuujC94q@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 1/31/24 12:00, Tejun Heo wrote:
> Hello,
>
> On Tue, Jan 30, 2024 at 01:33:36PM -0500, Waiman Long wrote:
>> +/* requeue the work items stored in wq->o_list */
>> +static void requeue_ordered_works(struct workqueue_struct *wq)
>> +{
>> +	LIST_HEAD(head);
>> +	struct work_struct *work, *next;
>> +
>> +	raw_spin_lock_irq(&wq->o_lock);
>> +	if (list_empty(&wq->o_list))
>> +		goto unlock_out;	/* No requeuing is needed */
>> +
>> +	list_splice_init(&wq->o_list, &head);
>> +	raw_spin_unlock_irq(&wq->o_lock);
>> +
>> +	/*
>> +	 * Requeue the first batch of work items. Since it may take a while
>> +	 * to drain the old pwq and update the workqueue attributes, there
>> +	 * may be a rather long list of work items to process. So we allow
>> +	 * queue_work() callers to continue putting their work items in o_list.
>> +	 */
>> +	list_for_each_entry_safe(work, next, &head, entry) {
>> +		list_del_init(&work->entry);
>> +		local_irq_disable();
>> +		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
>> +		local_irq_enable();
>> +	}
>> +
>> +	/*
>> +	 * Now check if there are more work items queued, if so set ORD_WAIT
>> +	 * and force incoming queue_work() callers to busy wait until the 2nd
>> +	 * batch of work items have been properly requeued. It is assumed
>> +	 * that the 2nd batch should be much smaller.
>> +	 */
>> +	raw_spin_lock_irq(&wq->o_lock);
>> +	if (list_empty(&wq->o_list))
>> +		goto unlock_out;
>> +	WRITE_ONCE(wq->o_state, ORD_WAIT);
>> +	list_splice_init(&wq->o_list, &head);
>> +	raw_spin_unlock(&wq->o_lock);	/* Leave interrupt disabled */
>> +	list_for_each_entry_safe(work, next, &head, entry) {
>> +		list_del_init(&work->entry);
>> +		__queue_work_rcu_locked(WORK_CPU_UNBOUND, wq, work);
>> +	}
>> +	WRITE_ONCE(wq->o_state, ORD_NORMAL);
>> +	local_irq_enable();
>> +	return;
>> +
>> +unlock_out:
>> +	WRITE_ONCE(wq->o_state, ORD_NORMAL);
>> +	raw_spin_unlock_irq(&wq->o_lock);
>> +}
> I'm not a big fan of this approach. It's a rather big departure from how
> things are usually done in workqueue. I'd much prefer sth like the
> following:
>
> - Add the ability to mark an unbound pwq plugged. If plugged,
>     pwq_tryinc_nr_active() always fails.
>
> - When cpumasks need updating, set max_active of all ordered workqueues to
>    zero and flush them. Note that if you set all max_actives to zero (note
>    that this can be another "plug" flag on the workqueue) first, all the
>    ordered workqueues would already be draining, so calling flush_workqueue()
>    on them sequentially shouldn't take too long.
>
> - Do the normal pwq allocation and linking but make sure that all new
>    ordered pwqs start plugged.
>
> - When update is done, restore the max_actives on all ordered workqueues.
>
> - New work items will now get queued to the newest dfl_pwq which is plugged
>    and we know that wq->pwqs list contain pwqs in reverse creation order. So,
>    from pwq_release_workfn(), if the pwq being released is for an ordered
>    workqueue and not plugged, unplug the pwq right in front.
>
> This hopefully should be less invasive.
>
> Thanks.

Thanks for suggestion. I will rework the patch series to use this approach.

Cheers,
Longman


