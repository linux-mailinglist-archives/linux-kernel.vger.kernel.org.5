Return-Path: <linux-kernel+bounces-158192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CED8B1CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C480282469
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D342076035;
	Thu, 25 Apr 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2KYzzhz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5D78C66
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033605; cv=none; b=XqRBEIgLS1YWPWb/1qXTqi0/2r6XnbgHAgmeJfLLjztD4H7l3sQh65UpF4MOUWRlzPJq97/n3qqwwM7eRcNrNApjA3VeVlR+2jkgL3/gFrUqzi4qGAMjNylXcwx7IBbwc7dYYLrcrFuUJ5Nu9llEWfzeIuHw3LR+BiBydUy66JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033605; c=relaxed/simple;
	bh=3V6jlj4PlwsQWvMr8dDkhP5Tvh46HMQL6MuiqFpM2aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKq3C+WhArsgDsNKb784tMZsk7PDI4xmI85GZXYDG0z9Nt5KeC2xP4jUSYVI0+0YPxoUf/2b91Jj6Dp0lVrPpIcs7Gw2CQq3my0pmCQ/u+8PfB+EboovZk+8iugAwnJbCrSPQProtXcB48JIrTtkE7Kb56a2rhetk7GxCXLIDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2KYzzhz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714033602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kghZ7NSaCZFV0M/Xc1wvQWlGakuhyfaOna+6mlQjMq8=;
	b=E2KYzzhzctuItz5Em3RwdGNQ4S5bKGqpFVnyJB/PDMZBqrtQhBIXyGGOoBj6aUnluHsfO1
	C4JY6Kvy3mUwTr810m4M+cu5ywBQvpwl+Rt0iqLOqww/zzMhlND3txurtYk0PKsGlWAuPw
	airvI2Yp4G2oAlM02XpzfcgYCv5KZlI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-2fpA8tb3P6e6NZjB5EoimQ-1; Thu, 25 Apr 2024 04:26:40 -0400
X-MC-Unique: 2fpA8tb3P6e6NZjB5EoimQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-51affa83f97so558857e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714033599; x=1714638399;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kghZ7NSaCZFV0M/Xc1wvQWlGakuhyfaOna+6mlQjMq8=;
        b=hhJkPA8d6EX6pFxjCJOOzzIqS91l/cDNZo4bMxYYM2B5nTpp0JNHEuvZ1XGem0E575
         0ExylEN02nm3QSesjk+Pzp46tZfsqtma3DGyFU/iKMwFjmWiGrRf14/PtD4TC7MmXsE3
         LhK/HARxkH2IJXNrkVOKxwwHf2czAqTD0gDEb1xZLRm5lV75J5dJXGWNqQXh3h+HorjP
         WkgxFIV+IlEvi0XzqaOc/fcH3VgSbz4Ih6IoTea5F0bxXe1J2SzPt/nnshAgt853NKSa
         2HIqN3eaStkfdg5oyRzWsnTZGm6rb8LNBhbappY7Dv9XRjU8tpRBQPVEinKTVo4ZYCIX
         ZbgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE5WrWe3ulus88JUgQlBSsr954Pg4wZhEFivjn6jeykKTip1KoW/Rl+8pC61lNAIqQx+2qUppwbRLJfrN4Wsc04qbFfOYVQxIyvexB
X-Gm-Message-State: AOJu0YwYks/ndSqJRKA6iJUNNWoalGDytytqPJHcSiULPeDYlkZ8lUWc
	vmfmNMnauXQ35I9AtFbXbxjaUcujw5YeQHME/UXai+pmPFZcqoIPYNRwnMvMijfUdB1/dIlSuhu
	p5TagipefyH5Z8/ItVUMC9dkdMvTkE5+HIhZiJ080RWGe/QvsCyy5PymMUplo4g==
X-Received: by 2002:ac2:546b:0:b0:518:bc7c:413a with SMTP id e11-20020ac2546b000000b00518bc7c413amr3339044lfn.69.1714033599215;
        Thu, 25 Apr 2024 01:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2rDh0RbiLvH7tzPc1rSgUygrDqOW1pNu+SekelcV4r3SRYgkQVcOXmYKWzQEtVzxKo2Nzng==
X-Received: by 2002:ac2:546b:0:b0:518:bc7c:413a with SMTP id e11-20020ac2546b000000b00518bc7c413amr3339022lfn.69.1714033598643;
        Thu, 25 Apr 2024 01:26:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b0041668162b45sm29951027wmp.26.2024.04.25.01.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 01:26:38 -0700 (PDT)
Message-ID: <94ae96f7-79ce-4b3f-a272-6af62d01a3f8@redhat.com>
Date: Thu, 25 Apr 2024 10:26:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add mTHP support for anonymous share pages
To: Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
 <c1f68109-7665-4905-996f-f1067dfa2cb6@linux.alibaba.com>
 <80b5f87e-c156-4ccc-98f0-96f1fd864273@arm.com>
 <ef4f15dd-da31-4a1e-bec5-62a7002c4f7c@linux.alibaba.com>
 <5b8b22e7-6355-4b08-b5b5-1e33ebae6f16@arm.com>
 <813fe7fd-3004-4e8b-801d-95c33559a025@linux.alibaba.com>
 <76f816dd-3bbf-48c9-a630-3787051cf289@arm.com>
 <8c0d6358-3c16-4a57-822c-04b3b3403fe6@linux.alibaba.com>
 <4204b5f6-21f0-4aa2-a625-3dd2f416b649@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4204b5f6-21f0-4aa2-a625-3dd2f416b649@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.04.24 10:17, Ryan Roberts wrote:
> On 25/04/2024 07:20, Baolin Wang wrote:
>>
>>
>> On 2024/4/24 22:20, Ryan Roberts wrote:
>>> On 24/04/2024 14:49, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/4/24 18:01, Ryan Roberts wrote:
>>>>> On 24/04/2024 10:55, Baolin Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2024/4/24 16:26, Ryan Roberts wrote:
>>>>>>> On 24/04/2024 07:55, Baolin Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024/4/23 18:41, Ryan Roberts wrote:
>>>>>>>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>>>>>>>> Anonymous pages have already been supported for multi-size (mTHP)
>>>>>>>>>> allocation
>>>>>>>>>> through commit 19eaf44954df, that can allow THP to be configured
>>>>>>>>>> through the
>>>>>>>>>> sysfs interface located at
>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>>>>>>>
>>>>>>>>>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>>>>>>>>>> configured through the sysfs interface, and can only use the PMD-mapped
>>>>>>>>>> THP, that is not reasonable. Many implement anonymous page sharing through
>>>>>>>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>>>>>>>>>> therefore, users expect to apply an unified mTHP strategy for anonymous
>>>>>>>>>> pages,
>>>>>>>>>> also including the anonymous shared pages, in order to enjoy the
>>>>>>>>>> benefits of
>>>>>>>>>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>>>>>>>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB
>>>>>>>>>> miss
>>>>>>>>>> etc.
>>>>>>>>>
>>>>>>>>> This sounds like a very useful addition!
>>>>>>>>>
>>>>>>>>> Out of interest, can you point me at any workloads (and off-the-shelf
>>>>>>>>> benchmarks
>>>>>>>>> for those workloads) that predominantly use shared anon memory?
>>>>>>>>
>>>>>>>> As far as I know, some database related workloads make extensive use of
>>>>>>>> shared
>>>>>>>> anonymous page, such as PolarDB[1] in our Alibaba fleet, or MySQL likely
>>>>>>>> also
>>>>>>>> uses shared anonymous memory. And I still need to do some investigation to
>>>>>>>> measure the performance.
>>>>>>>>
>>>>>>>> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL
>>>>>>>
>>>>>>> Thanks for the pointer!
>>>>>>>
>>>>>>>>
>>>>>>>>>> The primary strategy is that, the use of huge pages for anonymous shared
>>>>>>>>>> pages
>>>>>>>>>> still follows the global control determined by the mount option "huge="
>>>>>>>>>> parameter
>>>>>>>>>> or the sysfs interface at
>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>>>> The utilization of mTHP is allowed only when the global 'huge' switch is
>>>>>>>>>> enabled.
>>>>>>>>>> Subsequently, the mTHP sysfs interface
>>>>>>>>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>>>>>>>>> is checked to determine the mTHP size that can be used for large folio
>>>>>>>>>> allocation
>>>>>>>>>> for these anonymous shared pages.
>>>>>>>>>
>>>>>>>>> I'm not sure about this proposed control mechanism; won't it break
>>>>>>>>> compatibility? I could be wrong, but I don't think shmem's use of THP
>>>>>>>>> used to
>>>>>>>>> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
>>>>>>>>
>>>>>>>> Yes, I realized this after more testing.
>>>>>>>>
>>>>>>>>> doesn't make sense to me that we now depend upon the
>>>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
>>>>>>>>> default disables all sizes except 2M, which is set to "inherit" from
>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled).
>>>>>>>>>
>>>>>>>>> The other problem is that shmem_enabled has a different set of options
>>>>>>>>> (always/never/within_size/advise/deny/force) to enabled
>>>>>>>>> (always/madvise/never)
>>>>>>>>>
>>>>>>>>> Perhaps it would be cleaner to do the same trick we did for enabled;
>>>>>>>>> Introduce
>>>>>>>>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all
>>>>>>>>> the
>>>>>>>>> same values as the top-level
>>>>>>>>> /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>>>>>>>>> plus the additional "inherit" option. By default all sizes will be set to
>>>>>>>>> "never" except 2M, which is set to "inherit".
>>>>>>>>
>>>>>>>> Sounds good to me. But I do not want to copy all same values from top-level
>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
>>>>>>>> always within_size advise never deny force
>>>>>>>>
>>>>>>>> For mTHP's shmem_enabled interface, we can just keep below values:
>>>>>>>> always within_size advise never
>>>>>>>>
>>>>>>>> Cause when checking if mTHP can be used for anon shmem, 'deny' is equal to
>>>>>>>> 'never', and 'force' is equal to 'always'.
>>>>>>>
>>>>>>> I'll admit it wasn't completely clear to me after reading the docs, but my
>>>>>>> rough
>>>>>>> understanding is:
>>>>>>>
>>>>>>>      - /sys/kernel/mm/transparent_hugepage/shmem_enabled controls
>>>>>>>        mmap(SHARED|ANON) allocations (mostly; see rule 3)
>>>>>>>      - huge=... controls tmpfs allocations
>>>>>>>      - deny and force in shmem_enabled are equivalent to never and always for
>>>>>>>        mmap(SHARED|ANON) but additionally override all tmpfs mounts so they
>>>>>>> act as
>>>>>>>        if they were mounted with huge=never or huge=always
>>>>>>>
>>>>>>> Is that correct? If so, then I think it still makes sense to support per-size
>>>>>>
>>>>>> Correct.
>>>>>>
>>>>>>> deny/force. Certainly if a per-size control is set to "inherit" and the
>>>>>>> top-level control is set to deny or force, you would need that to mean
>>>>>>> something.
>>>>>>
>>>>>> IMHO, the '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled' interface
>>>>>> should only control the anonymous shmem. And 'huge=' controls tmpfs
>>>>>> allocation,
>>>>>> so we should not use anonymous control to override tmpfs control, which
>>>>>> seems a
>>>>>> little mess?
>>>>>
>>>>> I agree it would be cleaner to only handle mmap(SHARED|ANON) here, and leave
>>>>> the
>>>>> tmpfs stuff for another time. But my point is that
>>>>> /mm/transparent_hugepage/shmem_enabled already interferes with tmpfs if the
>>>>> value is deny or force. So if you have:
>>>>>
>>>>> echo deny > /mm/transparent_hugepage/shmem_enabled
>>>>
>>>> IIUC, this global control will cause shmem_is_huge() to always return false, so
>>>> no matter how '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' is set,
>>>> anonymous shmem will not use mTHP. No?
>>>
>>> No, that's not how '/mm/transparent_hugepage/hugepage-xxxkB/enabled' works, and
>>> I think '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' should follow
>>> the established pattern.
>>>
>>> For anon-private, each size is controlled by its
>>> /mm/transparent_hugepage/hugepage-xxxkB/enabled value. Unless that value is
>>> "inherit", in which case the value in /mm/transparent_hugepage/enabled is used
>>> for that size.
>>>
>>> That approach enables us to 1) maintain back-compat and 2) control each size
>>> independently
>>>
>>> 1) is met because the default is that all sizes are initially set to "never",
>>> except the PMD-size (e.g. /mm/transparent_hugepage/hugepage-2048kB/enabled)
>>> which is initially set to inherit. So any mTHP unaware SW can still modify
>>> /mm/transparent_hugepage/enabled and it will still only apply to PMD size.
>>>
>>> 2) is met because mTHP aware SW can come along and e.g. enable the 64K size
>>> (echo always > /mm/transparent_hugepage/hugepage-64kB/enabled) without having to
>>> modify the value in /mm/transparent_hugepage/enabled.
>>
>> Thanks for explanation. Initially, I want to make
>> ‘/mm/transparent_hugepage/shmem_enabled’ be a global control for huge page, but
>> I think it should follow the same strategy as anon mTHP as you said.
>>
>>>>> echo inherit > /mm/transparent_hugepage/hugepage-64kB/shmem_enabled
>>>>>
>>>>> What does that mean?
>>>
>>> So I think /mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled will need to
>>> support the deny and force values. When applied to non-PMD sizes, "deny" can
>>> just be a noop for now, because there was no way to configure a tmpfs mount for
>>> non-PMD size THP in the first place. But I'm not sure what to do with "force"?
>>
>> OK. And I also prefer that "force" should be a noop too, since anon shmem
>> control should not configure tmpfs huge page allocation.
> 
> I guess technically they won't be noops, but (for the non-PMD-sizes) "force"
> will be an alias for "always" and "deny" will be an alias for "never"?
> 
> I was just a bit concerned about later changing that behavior to also impact
> tmpfs once tmpfs supports mTHP; could that cause breaks? But thinking about it,
> I don't see that as a problem.

Is the question what should happen if we "inherit" "force" or if someone 
specifies "force" for a mTP size explicitly?

-- 
Cheers,

David / dhildenb


