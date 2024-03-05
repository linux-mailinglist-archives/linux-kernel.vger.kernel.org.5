Return-Path: <linux-kernel+bounces-91607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 212B9871432
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A701F2314F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9D93D0B5;
	Tue,  5 Mar 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2CQENP3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCB2942A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608869; cv=none; b=lKzCQLTcI50KrNCphC2OfFho1SS/KI1tLWzfLxOTWJA+iDELlDqbNVFhyrcG8XCgVXfLyF98KpdTpPspzEd63fi74Piwt77yJ4sJ6RZ2UrqTfeJXxdhI0s11A1eikzphJQkbr9wfRBguyxBU4ADRfTsJ/V+FsTdIsXwdtbBIkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608869; c=relaxed/simple;
	bh=BAIZttYr9CFZu/K50YIXtIb0ZZE7+4WLZelPCaIjosg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/gRRJ60gZ31gw81cns4JgwePLts7erxlIiiZA/RWlq+8ZaA0T43OMh1GblhjhNB570CGOzT3CSiJiHAGjQtZ2MCrUf1KKMdUK2w4mUXmlQO8j0FjakhUbtY34NuqSea7fehJbDHfBdOvUocr5ZoGTsbdabaV1d1aMnN1n2krXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2CQENP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709608863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h7TTCoR/Jp0ooBmr/f4+J3rHYWSV3rW1/afOQUBqeg=;
	b=d2CQENP3L3CMuVKR+0xEklk+FQl2qjxV6kgmTXE9edhWjmANMHpeurevMFDFyvNTGqaBxa
	sgeqr3MH1jfRNjAW9E/zTVPJgZPlcHeGn8AJZuSPhNm3D4xjvLPMDeld8zqNPk8aac9dKi
	biXbMTwhG4h6Wcaldjs2D4Pq+b/9B0U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Gei35NVMMYGpMismXOy2zg-1; Mon, 04 Mar 2024 22:20:58 -0500
X-MC-Unique: Gei35NVMMYGpMismXOy2zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9107310726A4;
	Tue,  5 Mar 2024 03:20:58 +0000 (UTC)
Received: from [10.22.8.66] (unknown [10.22.8.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 481612166B31;
	Tue,  5 Mar 2024 03:20:58 +0000 (UTC)
Message-ID: <147b6e99-dc5a-4b40-a1b2-8b957459e76d@redhat.com>
Date: Mon, 4 Mar 2024 22:20:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/kmemleak: Don't hold kmemleak_lock when calling
 printk()
Content-Language: en-US
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Audra Mitchell <aubaker@redhat.com>
References: <20240228191444.481048-1-longman@redhat.com>
 <ZeCh30o8i-wJVT7N@arm.com> <c5b07970-0523-420b-97ad-c08b50c69db2@redhat.com>
 <ZeHrC56llcicOjLP@arm.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZeHrC56llcicOjLP@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6


On 3/1/24 09:49, Catalin Marinas wrote:
> On Thu, Feb 29, 2024 at 10:55:38AM -0500, Waiman Long wrote:
>> On 2/29/24 10:25, Catalin Marinas wrote:
>>> On Wed, Feb 28, 2024 at 02:14:44PM -0500, Waiman Long wrote:
>>>> When some error conditions happen (like OOM), some kmemleak functions
>>>> call printk() to dump out some useful debugging information while holding
>>>> the kmemleak_lock. This may cause deadlock as the printk() function
>>>> may need to allocate additional memory leading to a create_object()
>>>> call acquiring kmemleak_lock again.
>>>>
>>>> Fix this deadlock issue by making sure that printk() is only called
>>>> after releasing the kmemleak_lock.
>>> I can't say I'm familiar with the printk() code but I always thought it
>>> uses some ring buffers as it can be called from all kind of contexts and
>>> allocation is not guaranteed.
>>>
>>> If printk() ends up taking kmemleak_lock through the slab allocator, I
>>> wonder whether we have bigger problems. The lock order is always
>>> kmemleak_lock -> object->lock but if printk() triggers a callback into
>>> kmemleak, we can also get object->lock -> kmemleak_lock ordering, so
>>> another potential deadlock.
>> object->lock is per object whereas kmemleak_lock is global. When taking
>> object->lock and doing a data dump leading to a call that takes the
>> kmemlock, it is highly unlikely the it will need to take that particular
>> object->lock again. I do agree that lockdep may still warn about it if that
>> happens as all the object->lock's are likely to be treated to be in the same
>> class.
> Yeah, it's unlikely. I think it can only happen if there's a bug in
> kmemleak (or slab) and the insertion fails because of the same object we
> try to dump. But I suspect lockdep will complain either way.
>
>> I should probably clarify in the change log that the lockdep splat is
>> actually,
>>
>> [ 3991.452558] Chain exists of: [ 3991.452559] console_owner -> &port->lock
>> --> kmemleak_lock
>>
>> So if kmemleak calls printk() acquiring either console_owner or port->lock.
>> It may cause deadlock.
> Could you please share the whole lockdep warning? IIUC, it's not the
> printk() code allocating memory but somewhere down the line in the tty
> layer.
Yes, I will do that in the next version.
>
> Anyway, I had a look again at the kmemleak locking (I've been meaning to
> simplify it for some time, drop the object->lock altogether). The only
> time we nest object->lock within kmemleak_lock is during scan_block().
> If we are unlucky to get some error on another CPU and dump that exact
> object with printk(), it could lead to deadlock.
>
> There's the dump_str_object_info() case as well triggered by a sysfs
> write but luckily this takes the scan_mutex (same as during
> scan_block()), so it solves the nesting problem.
>
> I think in those error cases we can even ignore the object->lock when
> dumping the info. Yeah, it can race, maybe not showing exactly the
> precise data in some rare cases, but in those OOM scenarios it's
> probably the least of our problem.

I was thinking about not taking the object->lock too. You are right that 
under OOM, a little bit of racing doesn't really matter. Will do that in 
the next version.

Cheers,
Longman


