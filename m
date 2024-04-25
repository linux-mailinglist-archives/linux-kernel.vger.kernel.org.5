Return-Path: <linux-kernel+bounces-158380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E198B1F03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79D01C208E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFC86626;
	Thu, 25 Apr 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4T+Vdnn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BF5D477
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040379; cv=none; b=BVZc2nJCDShbDe6EqU1B34PzPADtJzJ693VaSYSQ0g43X0YbLNqIcCxMsIdg1l98xGnGxKQU+3lzddVuFfCso5BvWzsZ0F/uaUQmGTjOskdGfnu8577/foipQ9BsmM4Ja56hJYFJ2xLfmFCUpofAGbaPpvBnyxa64+7kO8hVmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040379; c=relaxed/simple;
	bh=FeK+OFDrkP8sKBoj7+LLvHG/v8tIICGXFR15tM9RTtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcfANybahA0VifZtUnvCVwPRxE9Zb2OgyGFPftPTGlOXe5uHJg6FDYX0nFe0xrjPKi49DddzYKc7q1xs4erWPhkcd4iQ4aRc7HsQiDcIj7lrDVL9giCaV2CpwZ3tBvnQtXgmx/EC8Vo3PwQXdNVKJuNpuvJS56va2SL/YLyz60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4T+Vdnn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714040376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xb3pvMt8qo7yGQ53CyXAbZ18NUK9JTdP1GtZZWN2UHs=;
	b=J4T+VdnnoVU6XfOUQZKUbsRile8h78ILMpyCtqCF5lXAoHU9svDyDiKVo6BMXHSCCOGgE3
	wljjmxLwgP0hS24oARgPBiwfv3iDmSRiazd8cvH7j5n3aLsQRvF5h9rIDfNKVj77X7dXb6
	sa159QfyVEUvrq9ZEqTBbASKOBPei1g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591--l1NFZnSMfemvXx6W4C46g-1; Thu, 25 Apr 2024 06:19:35 -0400
X-MC-Unique: -l1NFZnSMfemvXx6W4C46g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34a49f5a6baso683387f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714040374; x=1714645174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xb3pvMt8qo7yGQ53CyXAbZ18NUK9JTdP1GtZZWN2UHs=;
        b=Tazj3x6KbcmzKXA2gZmJi7J2UTS4idY4mYs3CtrbPQVznk6ibbzZ/ndPspAjd5nBZs
         o7vf9l+Qsq5dqTCMY3G5+rs906hl4OpJUTQm4sX+nOan4eLzObZLF8z1zf2J1ZoNK0lQ
         JY2K5NJu3/tADAaoZY1Pos/Y2cfyNumsUn20oa2t8yEndHSAjqPngCpgkw6mMENtzrO1
         th2hqqhbMvXNJ3aNobd8Nwxw/5QJ7ZpY26/pdISEleOSlfQsU6EXwazytEKyO8GRpVLO
         uWsYTpdtGQ/LeLnrS/p893uS2RLPw5LAXiWkrHsfkIfpIHLi21Kzr7yb21IXRzdWxGGS
         2sCg==
X-Forwarded-Encrypted: i=1; AJvYcCXkSAkw8d5cR92ePMeKWlEAst6UR1u59KlPLwRUcuTkUhRuPrUdTbqw5KDDE/k1qePqn4dJ7ddtFiwAOMLvCEFmgnmUNCaTVcEp0nQA
X-Gm-Message-State: AOJu0Yy/13Y92cvxt80zmHr5G9J4ZlfgZNgEzASpDEZU2zqLWurN463L
	cFpgV6AG2dnlXAdhHam+pu6F07Oij2jwYKebRBSeJ9+qYfMlYVZNL4f36OUurUyutewCpggri69
	holPNt7Un4m6PKNRMuQdyySKBy5m9eehMDS4qLCSGS9uXhA8VBaADtySoJFtMDA==
X-Received: by 2002:a5d:4b83:0:b0:348:b435:2736 with SMTP id b3-20020a5d4b83000000b00348b4352736mr4318591wrt.51.1714040374012;
        Thu, 25 Apr 2024 03:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhKLwskiYnoQP/77uHc+J1X9AFsAoVsef58mmbmtvCkbibTpMoepcPHtkVlnFy3iKOJW31LA==
X-Received: by 2002:a5d:4b83:0:b0:348:b435:2736 with SMTP id b3-20020a5d4b83000000b00348b4352736mr4318561wrt.51.1714040373513;
        Thu, 25 Apr 2024 03:19:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe342000000b00343eac2acc4sm19416514wrj.111.2024.04.25.03.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 03:19:33 -0700 (PDT)
Message-ID: <533f37e9-81bf-4fa2-9b72-12cdcb1edb3f@redhat.com>
Date: Thu, 25 Apr 2024 12:19:32 +0200
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
 <94ae96f7-79ce-4b3f-a272-6af62d01a3f8@redhat.com>
 <71c1e953-84f9-4d47-bd4c-725a447627df@arm.com>
 <bf005e0f-6fda-4068-8af6-5f8c00257de7@redhat.com>
 <bc92c74e-80e2-4065-9b61-46adacdfd17a@linux.alibaba.com>
 <8665df72-0855-4f71-823b-5ff8d8342fd1@redhat.com>
 <c56af91f-3601-40f0-b5e7-e2468cb98972@linux.alibaba.com>
 <2f58b505-c276-463a-a7ef-42d64cbe5e7c@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2f58b505-c276-463a-a7ef-42d64cbe5e7c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.04.24 12:17, Ryan Roberts wrote:
> On 25/04/2024 10:50, Baolin Wang wrote:
>>
>>
>> On 2024/4/25 17:20, David Hildenbrand wrote:
>>> On 25.04.24 11:05, Baolin Wang wrote:
>>>>
>>>>
>>>> On 2024/4/25 16:57, David Hildenbrand wrote:
>>>>> On 25.04.24 10:46, Ryan Roberts wrote:
>>>>>> On 25/04/2024 09:26, David Hildenbrand wrote:
>>>>>>> On 25.04.24 10:17, Ryan Roberts wrote:
>>>>>>>> On 25/04/2024 07:20, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2024/4/24 22:20, Ryan Roberts wrote:
>>>>>>>>>> On 24/04/2024 14:49, Baolin Wang wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2024/4/24 18:01, Ryan Roberts wrote:
>>>>>>>>>>>> On 24/04/2024 10:55, Baolin Wang wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2024/4/24 16:26, Ryan Roberts wrote:
>>>>>>>>>>>>>> On 24/04/2024 07:55, Baolin Wang wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2024/4/23 18:41, Ryan Roberts wrote:
>>>>>>>>>>>>>>>> On 22/04/2024 08:02, Baolin Wang wrote:
>>>>>>>>>>>>>>>>> Anonymous pages have already been supported for multi-size
>>>>>>>>>>>>>>>>> (mTHP)
>>>>>>>>>>>>>>>>> allocation
>>>>>>>>>>>>>>>>> through commit 19eaf44954df, that can allow THP to be
>>>>>>>>>>>>>>>>> configured
>>>>>>>>>>>>>>>>> through the
>>>>>>>>>>>>>>>>> sysfs interface located at
>>>>>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> However, the anonymous shared pages will ignore the
>>>>>>>>>>>>>>>>> anonymous mTHP rule
>>>>>>>>>>>>>>>>> configured through the sysfs interface, and can only use
>>>>>>>>>>>>>>>>> the PMD-mapped
>>>>>>>>>>>>>>>>> THP, that is not reasonable. Many implement anonymous page
>>>>>>>>>>>>>>>>> sharing
>>>>>>>>>>>>>>>>> through
>>>>>>>>>>>>>>>>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage
>>>>>>>>>>>>>>>>> scenarios,
>>>>>>>>>>>>>>>>> therefore, users expect to apply an unified mTHP strategy
>>>>>>>>>>>>>>>>> for anonymous
>>>>>>>>>>>>>>>>> pages,
>>>>>>>>>>>>>>>>> also including the anonymous shared pages, in order to
>>>>>>>>>>>>>>>>> enjoy the
>>>>>>>>>>>>>>>>> benefits of
>>>>>>>>>>>>>>>>> mTHP. For example, lower latency than PMD-mapped THP,
>>>>>>>>>>>>>>>>> smaller memory
>>>>>>>>>>>>>>>>> bloat
>>>>>>>>>>>>>>>>> than PMD-mapped THP, contiguous PTEs on ARM architecture to
>>>>>>>>>>>>>>>>> reduce TLB
>>>>>>>>>>>>>>>>> miss
>>>>>>>>>>>>>>>>> etc.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This sounds like a very useful addition!
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Out of interest, can you point me at any workloads (and
>>>>>>>>>>>>>>>> off-the-shelf
>>>>>>>>>>>>>>>> benchmarks
>>>>>>>>>>>>>>>> for those workloads) that predominantly use shared anon memory?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> As far as I know, some database related workloads make
>>>>>>>>>>>>>>> extensive use of
>>>>>>>>>>>>>>> shared
>>>>>>>>>>>>>>> anonymous page, such as PolarDB[1] in our Alibaba fleet, or
>>>>>>>>>>>>>>> MySQL likely
>>>>>>>>>>>>>>> also
>>>>>>>>>>>>>>> uses shared anonymous memory. And I still need to do some
>>>>>>>>>>>>>>> investigation to
>>>>>>>>>>>>>>> measure the performance.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [1] https://github.com/ApsaraDB/PolarDB-for-PostgreSQL
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks for the pointer!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> The primary strategy is that, the use of huge pages for
>>>>>>>>>>>>>>>>> anonymous shared
>>>>>>>>>>>>>>>>> pages
>>>>>>>>>>>>>>>>> still follows the global control determined by the mount
>>>>>>>>>>>>>>>>> option "huge="
>>>>>>>>>>>>>>>>> parameter
>>>>>>>>>>>>>>>>> or the sysfs interface at
>>>>>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>>>>>>>>>>>>>>>>> The utilization of mTHP is allowed only when the global
>>>>>>>>>>>>>>>>> 'huge' switch is
>>>>>>>>>>>>>>>>> enabled.
>>>>>>>>>>>>>>>>> Subsequently, the mTHP sysfs interface
>>>>>>>>>>>>>>>>> (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>>>>>>>>>>>>>>>>> is checked to determine the mTHP size that can be used for
>>>>>>>>>>>>>>>>> large folio
>>>>>>>>>>>>>>>>> allocation
>>>>>>>>>>>>>>>>> for these anonymous shared pages.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm not sure about this proposed control mechanism; won't it
>>>>>>>>>>>>>>>> break
>>>>>>>>>>>>>>>> compatibility? I could be wrong, but I don't think shmem's
>>>>>>>>>>>>>>>> use of THP
>>>>>>>>>>>>>>>> used to
>>>>>>>>>>>>>>>> depend upon the value of
>>>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled?
>>>>>>>>>>>>>>>> So it
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yes, I realized this after more testing.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> doesn't make sense to me that we now depend upon the
>>>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
>>>>>>>>>>>>>>>> values
>>>>>>>>>>>>>>>> (which by
>>>>>>>>>>>>>>>> default disables all sizes except 2M, which is set to
>>>>>>>>>>>>>>>> "inherit" from
>>>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled).
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The other problem is that shmem_enabled has a different set
>>>>>>>>>>>>>>>> of options
>>>>>>>>>>>>>>>> (always/never/within_size/advise/deny/force) to enabled
>>>>>>>>>>>>>>>> (always/madvise/never)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Perhaps it would be cleaner to do the same trick we did for
>>>>>>>>>>>>>>>> enabled;
>>>>>>>>>>>>>>>> Introduce
>>>>>>>>>>>>>>>> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which
>>>>>>>>>>>>>>>> can have all
>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>> same values as the top-level
>>>>>>>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/shmem_enabled,
>>>>>>>>>>>>>>>> plus the additional "inherit" option. By default all sizes
>>>>>>>>>>>>>>>> will be set to
>>>>>>>>>>>>>>>> "never" except 2M, which is set to "inherit".
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Sounds good to me. But I do not want to copy all same values
>>>>>>>>>>>>>>> from
>>>>>>>>>>>>>>> top-level
>>>>>>>>>>>>>>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled':
>>>>>>>>>>>>>>> always within_size advise never deny force
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> For mTHP's shmem_enabled interface, we can just keep below
>>>>>>>>>>>>>>> values:
>>>>>>>>>>>>>>> always within_size advise never
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Cause when checking if mTHP can be used for anon shmem,
>>>>>>>>>>>>>>> 'deny' is equal to
>>>>>>>>>>>>>>> 'never', and 'force' is equal to 'always'.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I'll admit it wasn't completely clear to me after reading the
>>>>>>>>>>>>>> docs, but my
>>>>>>>>>>>>>> rough
>>>>>>>>>>>>>> understanding is:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>         - /sys/kernel/mm/transparent_hugepage/shmem_enabled
>>>>>>>>>>>>>> controls
>>>>>>>>>>>>>>           mmap(SHARED|ANON) allocations (mostly; see rule 3)
>>>>>>>>>>>>>>         - huge=... controls tmpfs allocations
>>>>>>>>>>>>>>         - deny and force in shmem_enabled are equivalent to
>>>>>>>>>>>>>> never and
>>>>>>>>>>>>>> always for
>>>>>>>>>>>>>>           mmap(SHARED|ANON) but additionally override all tmpfs
>>>>>>>>>>>>>> mounts so they
>>>>>>>>>>>>>> act as
>>>>>>>>>>>>>>           if they were mounted with huge=never or huge=always
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Is that correct? If so, then I think it still makes sense to
>>>>>>>>>>>>>> support
>>>>>>>>>>>>>> per-size
>>>>>>>>>>>>>
>>>>>>>>>>>>> Correct.
>>>>>>>>>>>>>
>>>>>>>>>>>>>> deny/force. Certainly if a per-size control is set to
>>>>>>>>>>>>>> "inherit" and the
>>>>>>>>>>>>>> top-level control is set to deny or force, you would need that
>>>>>>>>>>>>>> to mean
>>>>>>>>>>>>>> something.
>>>>>>>>>>>>>
>>>>>>>>>>>>> IMHO, the
>>>>>>>>>>>>> '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled' interface
>>>>>>>>>>>>> should only control the anonymous shmem. And 'huge=' controls
>>>>>>>>>>>>> tmpfs
>>>>>>>>>>>>> allocation,
>>>>>>>>>>>>> so we should not use anonymous control to override tmpfs
>>>>>>>>>>>>> control, which
>>>>>>>>>>>>> seems a
>>>>>>>>>>>>> little mess?
>>>>>>>>>>>>
>>>>>>>>>>>> I agree it would be cleaner to only handle mmap(SHARED|ANON)
>>>>>>>>>>>> here, and leave
>>>>>>>>>>>> the
>>>>>>>>>>>> tmpfs stuff for another time. But my point is that
>>>>>>>>>>>> /mm/transparent_hugepage/shmem_enabled already interferes with
>>>>>>>>>>>> tmpfs if the
>>>>>>>>>>>> value is deny or force. So if you have:
>>>>>>>>>>>>
>>>>>>>>>>>> echo deny > /mm/transparent_hugepage/shmem_enabled
>>>>>>>>>>>
>>>>>>>>>>> IIUC, this global control will cause shmem_is_huge() to always
>>>>>>>>>>> return
>>>>>>>>>>> false, so
>>>>>>>>>>> no matter how
>>>>>>>>>>> '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled' is set,
>>>>>>>>>>> anonymous shmem will not use mTHP. No?
>>>>>>>>>>
>>>>>>>>>> No, that's not how
>>>>>>>>>> '/mm/transparent_hugepage/hugepage-xxxkB/enabled' works, and
>>>>>>>>>> I think '/mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled'
>>>>>>>>>> should follow
>>>>>>>>>> the established pattern.
>>>>>>>>>>
>>>>>>>>>> For anon-private, each size is controlled by its
>>>>>>>>>> /mm/transparent_hugepage/hugepage-xxxkB/enabled value. Unless that
>>>>>>>>>> value is
>>>>>>>>>> "inherit", in which case the value in
>>>>>>>>>> /mm/transparent_hugepage/enabled is used
>>>>>>>>>> for that size.
>>>>>>>>>>
>>>>>>>>>> That approach enables us to 1) maintain back-compat and 2) control
>>>>>>>>>> each size
>>>>>>>>>> independently
>>>>>>>>>>
>>>>>>>>>> 1) is met because the default is that all sizes are initially set
>>>>>>>>>> to "never",
>>>>>>>>>> except the PMD-size (e.g.
>>>>>>>>>> /mm/transparent_hugepage/hugepage-2048kB/enabled)
>>>>>>>>>> which is initially set to inherit. So any mTHP unaware SW can
>>>>>>>>>> still modify
>>>>>>>>>> /mm/transparent_hugepage/enabled and it will still only apply to
>>>>>>>>>> PMD size.
>>>>>>>>>>
>>>>>>>>>> 2) is met because mTHP aware SW can come along and e.g. enable the
>>>>>>>>>> 64K size
>>>>>>>>>> (echo always > /mm/transparent_hugepage/hugepage-64kB/enabled)
>>>>>>>>>> without
>>>>>>>>>> having to
>>>>>>>>>> modify the value in /mm/transparent_hugepage/enabled.
>>>>>>>>>
>>>>>>>>> Thanks for explanation. Initially, I want to make
>>>>>>>>> ‘/mm/transparent_hugepage/shmem_enabled’ be a global control for
>>>>>>>>> huge page, but
>>>>>>>>> I think it should follow the same strategy as anon mTHP as you said.
>>>>>>>>>
>>>>>>>>>>>> echo inherit > /mm/transparent_hugepage/hugepage-64kB/shmem_enabled
>>>>>>>>>>>>
>>>>>>>>>>>> What does that mean?
>>>>>>>>>>
>>>>>>>>>> So I think /mm/transparent_hugepage/hugepage-xxxkB/shmem_enabled
>>>>>>>>>> will need to
>>>>>>>>>> support the deny and force values. When applied to non-PMD sizes,
>>>>>>>>>> "deny" can
>>>>>>>>>> just be a noop for now, because there was no way to configure a
>>>>>>>>>> tmpfs mount for
>>>>>>>>>> non-PMD size THP in the first place. But I'm not sure what to do
>>>>>>>>>> with "force"?
>>>>>>>>>
>>>>>>>>> OK. And I also prefer that "force" should be a noop too, since anon
>>>>>>>>> shmem
>>>>>>>>> control should not configure tmpfs huge page allocation.
>>>>>>>>
>>>>>>>> I guess technically they won't be noops, but (for the non-PMD-sizes)
>>>>>>>> "force"
>>>>>>>> will be an alias for "always" and "deny" will be an alias for "never"?
>>>>>>>>
>>>>>>>> I was just a bit concerned about later changing that behavior to
>>>>>>>> also impact
>>>>>>>> tmpfs once tmpfs supports mTHP; could that cause breaks? But
>>>>>>>> thinking about it,
>>>>>>>> I don't see that as a problem.
>>>>>>>
>>>>>>> Is the question what should happen if we "inherit" "force" or if someone
>>>>>>> specifies "force" for a mTP size explicitly?
>>>>>>
>>>>>> Well I think it amounts to the same thing; there isn't much point in
>>>>>> forbidding
>>>>>> "force" to be set directly because it can still be set indirectly through
>>>>>> "inherit". We can't forbid indirectly setting it, because "inherit"
>>>>>> could be set
>>>>>> first, then the top-level shmem_enabled changed to "force" after - and we
>>>>>> wouldn't want to fail that.
>>>>>
>>>>> The default for PMD should be "inherit", for the other mTHP sizes it
>>>>> should be "never".
>>>>>
>>>>> So we should fail if:
>>>>> * Setting top-level to "force" when any non-PMD size is "inherit"
>>>>> * Setting "inherit" of a non-PMD size when the top-level is force
>>>>
>>>> IMO, for tmpfs this is true, but for anon shmem, this 2 cases should not
>>>> fail.
>>>
>>> If force does not apply to an mTHP size, it should fail if it would get
>>> inherited. Until it applies and we enable it.
>>>
>>> I'm still confused about all the toggles here, so could be I am missing
>>> something.
>>
>> Yes, this is a little messy:(
>>
>> After thinking more, considering that 'force' is used to override the tmpfs
>> mount option, and 'inherit' will inherit the global setting. Your suggestion
>> will make the logic eary to understand (though it is valid for anon shmem mTHP
>> allocations, which are not part of this scenario), Ryan, what do you think?
> 
> I was thinking that ever returning an error code when trying to set "force" for
> /mm/transparent_hugepage/shmem_enabled would be weird behavior and to be avoided
> if possible.
> 
> But as always, David makes a clear and compelling case. I'm happy to go with his
> suggestion.

I'm afraid "as always" is far from true :D

> 
> I wonder if we should do the same for "deny"? The argument I previously made was
> that non-PMD-size mTHP is always effectively denied while tmpfs doesn't support
> mTHP, so we can allow "deny" and for now it would just be an alias for "never".
> The semantics don't change when you introduce tmpfs support.
> 
> Personally I lean towards allowing "deny" from day 1. David?

If it has clear semantics that can be fulfilled as of today, sure, we 
can have it.

-- 
Cheers,

David / dhildenb


