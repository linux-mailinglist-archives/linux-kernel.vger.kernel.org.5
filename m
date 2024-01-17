Return-Path: <linux-kernel+bounces-29113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16868308E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E440B254C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A9920DD1;
	Wed, 17 Jan 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkpTqgTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435420DC9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503490; cv=none; b=Fa2R0OMpnAUxPiUuM+0KIfN6HYyc8LmfawHPo/yJb3MRKOeDpK7xKpF2WzykTjIY/TyBNcO4ymABniU7ph4WhH+jbI7wWoYYpJnlGRcvM70BhnXHSmPE0YwgianfaIHnmx9F0XLFIGKqjCzxGcUEGf6b9oPEXlj2OYyYGzx34rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503490; c=relaxed/simple;
	bh=oi+iVpi2yYmU+zXarbh88yTKN7zgJG92JdoIuA7p+WE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By; b=LqRH6I7Fym3W+t7XD8FvrMtJusK72QGUtOAHrMEkiL7CK3FYHI7wImfQcmFf3aKe0RyyLWKR0m3D/jZpN+RijfqgJevHbKT+ARBggWSMFPlyXEeM+HxBl3BAXRYt/Ckw/elUK+QQZVjB/g0AZBnnS6gc3sO56bTMgCUsZxnZTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkpTqgTs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705503486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DEnP8y6ow1wZht4vYBQf9dHQVMDU9DH9lh/OONQlnU=;
	b=SkpTqgTsOWMjuHbmqjrirpGwMNY70BZy/uIBWXy+l0IpVIagMOPUz1vm5G7+wsyqJZULcM
	Gall+l9ZPbrNE/JjmkO/XQuTc6Ac7qFQC19rCY0gnBCBigSWlTRY/oXfVuwTYqr6wvc0tF
	EfLdwt+SKfJueui40cGDWfDwQT5D7wA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-2WeDHH-SOtSx2ltXGO5nfg-1; Wed, 17 Jan 2024 09:58:04 -0500
X-MC-Unique: 2WeDHH-SOtSx2ltXGO5nfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71B5E836F88;
	Wed, 17 Jan 2024 14:58:03 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E7FD40C6EB9;
	Wed, 17 Jan 2024 14:58:02 +0000 (UTC)
Message-ID: <5a758416-8c70-4a0e-834d-fecf6c95c7d8@redhat.com>
Date: Wed, 17 Jan 2024 09:58:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Xuewen Yan <xuewen.yan94@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com
References: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com>
 <ZabBHHwZd70IDDxP@boqun-archlinux>
 <CAB8ipk--3-+K2bhQS_YMTgpxCkZRbX21Lv_x-nT298yx5YTJeg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAB8ipk--3-+K2bhQS_YMTgpxCkZRbX21Lv_x-nT298yx5YTJeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 1/16/24 23:35, Xuewen Yan wrote:
> On Wed, Jan 17, 2024 at 1:47 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>> On Mon, Jan 15, 2024 at 04:53:16PM +0800, Zhiguo Niu wrote:
>>> There is a deadlock scenario between lockdep and rcu when
>>> rcu nocb feature is enabled, just as following call stack:
>>>
>>>       rcuop/x
>>> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
>>> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
>>> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
>>> -002|__raw_spin_lock_irqsave(inline)
>>> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
>>> -003|wake_nocb_gp_defer(inline)
>>> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
>>> -004|__call_rcu_common(inline)
>>> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
>>> -005|call_rcu_zapped(inline)
>>> -005|free_zapped_rcu(ch = ?)// hold graph lock
>>> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
>>> -007|nocb_cb_wait(inline)
>>> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
>>> -008|kthread(_create = 0xFFFFFF80803122C0)
>>> -009|ret_from_fork(asm)
>>>
>>>       rcuop/y
>>> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
>>> -001|queued_spin_lock()
>>> -001|lockdep_lock()
>>> -001|graph_lock() // try to hold graph lock
>>> -002|lookup_chain_cache_add()
>>> -002|validate_chain()
>>> -003|lock_acquire
>>> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
>>> -005|lock_timer_base(inline)
>>> -006|mod_timer(inline)
>>> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
>>> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
>>> -007|__call_rcu_common(inline)
>>> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
>>> -008|call_rcu_hurry(inline)
>>> -008|rcu_sync_call(inline)
>>> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
>>> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
>>> -010|nocb_cb_wait(inline)
>>> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
>>> -011|kthread(_create = 0xFFFFFF8080363740)
>>> -012|ret_from_fork(asm)
>>>
>>> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
>>>
>> Nice! Looks like you find the root cause ;-) nocb_gp_lock and graph_lock
>> have an ABBA deadlock due to lockdep's dependency on RCU. I assume this
>> actually fixes the problem you saw?
>>
>> However, I want to suggest a different fix, please see below:
>>
>>> This patch release the graph lock before lockdep call_rcu.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>> ---
>>>   kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++-------------
>>>   1 file changed, 25 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index 151bd3d..c1d432a 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -6186,23 +6186,29 @@ static struct pending_free *get_pending_free(void)
>>>   /*
>>>    * Schedule an RCU callback if no RCU callback is pending. Must be called with
>>>    * the graph lock held.
>>> + *
>>> + * Return true if graph lock need be released by the caller, otherwise false
>>> + * means graph lock is released by itself.
>>>    */
>>> -static void call_rcu_zapped(struct pending_free *pf)
>>> +static bool call_rcu_zapped(struct pending_free *pf)
>>>   {
>>>        WARN_ON_ONCE(inside_selftest());
>>>
>>>        if (list_empty(&pf->zapped))
>>> -             return;
>>> +             return true;
>>>
>>>        if (delayed_free.scheduled)
>>> -             return;
>>> +             return true;
>>>
>>>        delayed_free.scheduled = true;
>>>
>>>        WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>>>        delayed_free.index ^= 1;
>>>
>>> +     lockdep_unlock();
>>>        call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>>> +
>>> +     return false;
>>>   }
>>>
>>>   /* The caller must hold the graph lock. May be called from RCU context. */
>>> @@ -6228,6 +6234,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>>>   {
>>>        struct pending_free *pf;
>>>        unsigned long flags;
>>> +     bool need_unlock;
>>>
>>>        if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>>>                return;
>>> @@ -6243,9 +6250,9 @@ static void free_zapped_rcu(struct rcu_head *ch)
>>>        /*
>>>         * If there's anything on the open list, close and start a new callback.
>>>         */
>>> -     call_rcu_zapped(delayed_free.pf + delayed_free.index);
>>> -
>>> -     lockdep_unlock();
>>> +     need_unlock = call_rcu_zapped(delayed_free.pf + delayed_free.index);
>>> +     if (need_unlock)
>>> +             lockdep_unlock();
>> Instead of returning a bool to control the unlock, I think it's better
>> that we refactor the call_rcu_zapped() a bit, so it becomes a
>> prepare_call_rcu_zapped():
>>
>>          // See if we need to queue an RCU callback, must called with
>>          // the lockdep lock held, returns false if either we don't have
>>          // any pending free or the callback is already scheduled.
>>          // Otherwise, a call_rcu() must follow this function call.
>>          static bool prepare_call_rcu_zapped(struct pending_free *pf)
>>          {
>>                  WARN_ON_ONCE(inside_selftest());
>>
>>                  if (list_empty(&pf->zapped))
>>                          return false;
>>
>>                  if (delayed_free.scheduled)
>>                          return false;
>>
>>                  delayed_free.scheduled = true;
>>
>>                  WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>>                  delayed_free.index ^= 1;
>>
>>                  return true;
>>          }
>>
>> , and here we can:
>>
>>          <lockdep_lock() is called previous>
>>          need_callback = prepare_call_rcu_zapped(...);
>>          lockdep_unlock();
>>          raw_local_irq_restore(flags);
>>
>>          if (need_callback)
>>                  call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> Would there be any problems if call_rcu is placed outside the shutdown
> interrupt?

call_rcu() doesn't need to be called with interrupt disabled. In fact, 
it calls local_irq_save() itself when necessary. So that is perfectly fine.

Cheers,
Longman


