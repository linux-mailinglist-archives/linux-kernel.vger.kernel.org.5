Return-Path: <linux-kernel+bounces-166555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3398B9C58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA941C21AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAAE153501;
	Thu,  2 May 2024 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLLIh3Lp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A7152E02
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660426; cv=none; b=Cmf5lObAJUAh7vH8wIMNvsqrksjq0oDxjogrxzuhYfIWh7BMt1afEDtSNAULh8hIfXBYky4KqoOLCyW2UGg5b0UtPEzBdIyx7aE9cWmiNXgb9E77hjxD+oOjUNdilWnqBO8v0w6JVlYTAeNzo6ytXK42D063w99fG/loDz+3sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660426; c=relaxed/simple;
	bh=CThNwOWXheGNlv1xdNT8XhnhAcPVwCnaJI9uOLMSz9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZFw7KBWVDBacVD4DfIVWfl77kUOihdLJ++fdlY6t1lHp7jhRy+Ilh7cc0CVAgXl6NVW1L1v8il71rdkAcfGZCjCHqFBoXhtWyV/EVByc1GpAbl+fIRyJ0RO4MyE7vfzNq7JSbqlOqys4ZNy5QTSiXQEwauPNyRtdJXFpi0ETtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLLIh3Lp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714660424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CHYxkIQ8ku9Et4Lmsh2/94NqfW9qDb54vDaZA3KSs4s=;
	b=dLLIh3LpFvAGHRus/7rHX1LiSFyKWxPtGXR/2+SlYOxiSCwdd/HKDwbiok/rW0pvRzZNHn
	Ho8ZD+DCNkULsm5FKQnsyy54J0A3XUhpKuGi5ZmKVokiLjZo6r5LmniIVOHRjhHLWemljx
	BN8qqMMbARsbeU61Ldu9pCRHUnUk0jA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-tu4pvnBPNqmwelGYUbLMWQ-1; Thu, 02 May 2024 10:33:43 -0400
X-MC-Unique: tu4pvnBPNqmwelGYUbLMWQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34deefe9142so860743f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714660422; x=1715265222;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHYxkIQ8ku9Et4Lmsh2/94NqfW9qDb54vDaZA3KSs4s=;
        b=rLsJwvAiv8laZaRO0eBmBG3ZCb0JuLfZ8DD5R+Doda7viiXAb3IpBBvjIGKN62y6Q6
         W7q1Fj3eFX1yCUFNjYiGVj+xgPyJfbCjT62IrsGuOSC/+x4oDkZOBaNeVx+gi3/qGcoO
         GM2LQrKTOEYFBZHovfT+fEfZvIsR28J/XH0QKXUGo7lo3SXnB5PNEJGfv7GndRsj6U4O
         jJsvzWvZX3Dtt5Cy2UN1gHeHEZN8dyD/HEQu6rA5iEp5QQuWuTArvk4UXxeH7SgO3U8n
         65/VB4zYNJ1YsC0I9+7SpFmtaiA8oWsUOGzzrFEPfvteMpkgX2BH5v+qehTlMOwXNCY1
         DSaw==
X-Gm-Message-State: AOJu0YyC9emnzAB2oNBEsgIWt7LhqLxsmEvcgME1xYBDqeN64toDGBhi
	+lHfknc0aPo0QbfyBsoFPyLFmNWiupL0mWfQrgjfq5VQ/RVUZBduKim7266MgGRRaMRYedcNYzC
	ynuhMKIap73N+Jnc+7fwdpg3yNC2HaLbyDK9f9il/P8KtxdTbE2me5VzfyZKghA==
X-Received: by 2002:adf:e0c1:0:b0:34b:8bf:5fa5 with SMTP id m1-20020adfe0c1000000b0034b08bf5fa5mr4150wri.7.1714660421732;
        Thu, 02 May 2024 07:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSVc3GjlITyXVsLJLEkrUivUde0tR0KHggikIou3sLGcFYSBzjyDOHqUqvmqNv9AnT4rQVsg==
X-Received: by 2002:adf:e0c1:0:b0:34b:8bf:5fa5 with SMTP id m1-20020adfe0c1000000b0034b08bf5fa5mr4127wri.7.1714660421195;
        Thu, 02 May 2024 07:33:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id dy1-20020a0560000e4100b0034afaa9ca47sm1411938wrb.1.2024.05.02.07.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 07:33:40 -0700 (PDT)
Message-ID: <9e9ac4a3-461f-4ada-a41c-4432c947c818@redhat.com>
Date: Thu, 2 May 2024 16:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: document why hugetlb uses
 folio_mapcount() for COW reuse decisions
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>
References: <20240502085259.103784-1-david@redhat.com>
 <20240502085259.103784-3-david@redhat.com> <ZjOjCwrWg-Fd9gtI@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZjOjCwrWg-Fd9gtI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.05.24 16:28, Peter Xu wrote:
> On Thu, May 02, 2024 at 10:52:59AM +0200, David Hildenbrand wrote:
>> Let's document why hugetlb still uses folio_mapcount() and is prone to
>> leaking memory between processes, for example using vmsplice() that
>> still uses FOLL_GET.
>>
>> More details can be found in [1], especially around how hugetlb pages
>> cannot really be overcommitted, and why we don't particularly care about
>> these vmsplice() leaks for hugetlb -- in contrast to ordinary memory.
>>
>> [1] https://lore.kernel.org/all/8b42a24d-caf0-46ef-9e15-0f88d47d2f21@redhat.com/
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/hugetlb.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 417fc5cdb6eeb..a7efb350f5d07 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5963,6 +5963,13 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
>>   	/*
>>   	 * If no-one else is actually using this page, we're the exclusive
>>   	 * owner and can reuse this page.
>> +	 *
>> +	 * Note that we don't rely on the (safer) folio refcount here, because
>> +	 * copying the hugetlb folio when there are unexpected (temporary)
>> +	 * folio references could harm simple fork()+exit() users when
>> +	 * we run out of free hugetlb folios: we would have to kill processes
>> +	 * in scenarios that used to work. As a side effect, there can still
>> +	 * be leaks between processes, for example, with FOLL_GET users.
>>   	 */
>>   	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
>>   		if (!PageAnonExclusive(&old_folio->page)) {
> 
> Thanks for preparing such updates, David.
> 
> However is fork+exit the real problem?  E.g. if a child simply fork, do
> something, then exit, I don't see a major issue even if we follow refcount
> here (despite the "check against 1 or 2 or 3" issue, where hugetlb_fault
> can take one already).  As long as the child quits, all ref / map counts
> will be released then.  If the child needs to write to ANON|PRIV it needs
> to manage hugetlb reservations anyways.

The PAE flag was cleared and if there is any unexpected (temporary) 
reference (page migration, lockless swapcache lookups, whatever), we're 
in trouble.

> 
> In the case of vmsplice it's kind of malicious, and holding that refcount
> (with 0 mapcount) doesn't sound the common scenario to me.

Yes, I'm not that concerned about something that that APP would be 
triggering (vmsplice).

> 
> IIUC if we need to keep this, it was more about the case where (as you
> correctly mentioned in another follow up reply) hugetlb isn't that flexible
> to memory overcommits, and in many cases it won't have extra pages floating
> around to allow adhoc CoWs?  While random refcount boost is easy to happen,
> and here the problem is we simply cannot identify that v.s. vmsplice()
> malicious takers.

Yes, exactly.

-- 
Cheers,

David / dhildenb


