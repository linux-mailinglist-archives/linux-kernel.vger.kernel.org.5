Return-Path: <linux-kernel+bounces-121869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6388EEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95B029E20E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797D14F9FF;
	Wed, 27 Mar 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpaxMHQy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6355227
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565931; cv=none; b=QU/ZvKutfMj7YO6bVc/glXGdxQIwHqyQESdNOAk5jpwkv1vJNjk8NTlhUh9kPFjdUAzM+i2Ipz4iZ9RWQTt7INTCfYw5jANwHH/TVMMj7AoI6D4nfFQKPLAsPk/QzudWWUyt6VRPJfC6l2W3Rsuyfoy7bJG9QQtDOFI6z1kwAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565931; c=relaxed/simple;
	bh=syxSHPmUcwOxaYZQm90XUTPVxeDYZ2RFD5QSfLdCGE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKVoRKJjjOdCj5sa55acGxUsTL8Y7GAoqMI5xWNLtQjJmtZBwB/zLGOhm0u2V3EuQWpFMJbUzW/zv37cQHf8Os+vk8zpgVgenlr1xDx1s8nq0amGCBJ+zhcYzZ6hcu+gd0EmbSTrXs/SMCrS1TlwZXa0HM2d3PywOlsNb85tapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpaxMHQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711565928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAska0hL8RMpabamwQoIPg/k45FzhjCym0nLiCVueuE=;
	b=OpaxMHQy60yJRerg17ogUDQ/YeRAt96pdWv9sta3G/qrT85mYhDaEnkFypDVGLRoCXX3of
	sOo7y6bGhK0x6kWVYTl4oQ5GS9JhcQdRYv3vo2elVR0B4+gM60WVD+buR8J8cI60GEGK93
	uNtMzypewmMCekjYoaAwUBkr8E3nSHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-zspy6GMCPC2cjmZ9rLFaog-1; Wed, 27 Mar 2024 14:58:44 -0400
X-MC-Unique: zspy6GMCPC2cjmZ9rLFaog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51BEE185A784;
	Wed, 27 Mar 2024 18:58:44 +0000 (UTC)
Received: from [10.22.33.225] (unknown [10.22.33.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3591492BC9;
	Wed, 27 Mar 2024 18:58:43 +0000 (UTC)
Message-ID: <de42b70a-c69c-4777-ab07-2921d34ecb85@redhat.com>
Date: Wed, 27 Mar 2024 14:58:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Audra Mitchell <aubaker@redhat.com>
References: <20240307184707.961255-1-longman@redhat.com>
 <20240307114630.32702099ac24c182b91da517@linux-foundation.org>
 <ZgRarOvI3Zhos9Gl@arm.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZgRarOvI3Zhos9Gl@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 3/27/24 13:43, Catalin Marinas wrote:
> On Thu, Mar 07, 2024 at 11:46:30AM -0800, Andrew Morton wrote:
>> On Thu,  7 Mar 2024 13:47:07 -0500 Waiman Long <longman@redhat.com> wrote:
>>> When some error conditions happen (like OOM), some kmemleak functions
>>> call printk() to dump out some useful debugging information while holding
>>> the kmemleak_lock. This may cause deadlock as the printk() function
>>> may need to allocate additional memory leading to a create_object()
>>> call acquiring kmemleak_lock again.
>>>
>>> An abbreviated lockdep splat is as follows:
>>>
>>> ...
>>>
>>> Fix this deadlock issue by making sure that printk() is only called
>>> after releasing the kmemleak_lock.
>>>
>>> ...
>>>
>>> @@ -427,9 +442,19 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>>>   		else if (untagged_objp == untagged_ptr || alias)
>>>   			return object;
>>>   		else {
>>> +			if (!get_object(object))
>>> +				break;
>>> +			/*
>>> +			 * Release kmemleak_lock temporarily to avoid deadlock
>>> +			 * in printk(). dump_object_info() is called without
>>> +			 * holding object->lock (race unlikely).
>>> +			 */
>>> +			raw_spin_unlock(&kmemleak_lock);
>>>   			kmemleak_warn("Found object by alias at 0x%08lx\n",
>>>   				      ptr);
>>>   			dump_object_info(object);
>>> +			put_object(object);
>>> +			raw_spin_lock(&kmemleak_lock);
>>>   			break;
>> Please include a full description of why this is safe.  Once we've
>> dropped that lock, the tree is in an unknown state and we shouldn't
>> touch it again.  This consideration should be added to the relevant
>> functions' interface documentation and the code should be reviewed to
>> ensure that we're actually adhering to this.  Or something like that.
>>
>> To simply drop and reacquire a lock without supporting analysis and
>> comments does not inspire confidence!
> I agree it looks fragile. I think it works, the code tends to bail out
> on those errors and doesn't expect the protected data to have remained
> intact. But we may change it in the future and forgot about this.
>
> I wonder whether we can actually make things slightly easier to reason
> about, defer the printing until unlock, store the details in some
> per-cpu variable. Another option would be to have a per-CPU array to
> store potential recursive kmemleak_*() callbacks during the critical
> regions. This should be bounded since the interrupts are disabled. On
> unlock, we'd replay the array and add those pointers.

It looks like most of the callers of __lookup_object() will bail out 
when an error happen. So there should be no harm in temporarily 
releasing the lock. However, I do agree that it is fragile and future 
changes may break it. This patch certainly need more work.

Cheers,
Longman

>


