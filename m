Return-Path: <linux-kernel+bounces-105976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A5987E705
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFAD281AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24292D60A;
	Mon, 18 Mar 2024 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvJC1MPi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE92C693
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756957; cv=none; b=LAHa19Z7qPN8M5+U0+Ht+47aGWnyjCBBKz4ACMW1H0h0zWt+FncvrhG67V7ZAuSnNIVLbNDQTVyusmrTggHVejFJ0LccOaV70dViEqwsF6uIo+mN5qfnjeazLe3KukNoZBrpmsbkyARWqIDgb5u2d9VtQhUFnC1hTT2e1Tef69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756957; c=relaxed/simple;
	bh=ynaBZCdNmXv06/BZ5d8QMvixBlV5RPanq0NsX1+sZV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjXfhYdETGrVN3T6VRcu8kNiQv5ShollbRV0LVzoEUsOEMc6/JHUsPTTnFQhF18TxJL66VZ1tTyzeDwae5uEieY4IFimCGAbnBlYO4QlCs9hXj1o1WjKFU9BuB/Sso2yvId6ern4PvN8aNd/l+KIBjFj8KyAqgS4ZVnHmPDOfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvJC1MPi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710756954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DHY4Mq331qObVXvONZj6F4P1QbCaPeub6fko/Vcjvv8=;
	b=DvJC1MPizehzc5CMYd49PQUcU+iDSC3GYyMk/UVEJ2+CnbimzCTRsZvxS7J4ZH0vtUYR0g
	x2BbCOqPywPrmqpktCrZBxtl0zQ82sdx9pkee6zvceP3KF54FooxAVbwGNicfXNkvW7UK4
	fs4fdu13ahrxjs9WexDJy/Wi+dYFkN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-7DhVmhAMM7CsiynOtQWcYA-1; Mon, 18 Mar 2024 06:15:51 -0400
X-MC-Unique: 7DhVmhAMM7CsiynOtQWcYA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34172041676so455421f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756950; x=1711361750;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHY4Mq331qObVXvONZj6F4P1QbCaPeub6fko/Vcjvv8=;
        b=lxjkuXgcdU3DlOhAtWdlX5UnyRZV2FghE1kMdpJlrDMFTeHmEK/5ctl3P0Vn2Fp+av
         Mr/UoFLoVvKo3fy86TP5Q2h0Sf5qtEqMJubqY+6/rGK+8YPZaJoP44cSskSkJ5nHAc2b
         EY5Qh81FfaKJGXhOL0qiDBVTUkrjFMp94ahUrhh3BH+CaEC9PhR8IdJOLU9B3zJUWkBP
         YSOyjVA9mHKOZiIBRKnG54d+qsI2y5B50RV1FG4VbRgdkr5LKASQ5SNJqjey1i5YCVtW
         tW482iuFIeW5zEJaLpMnI1YHD503dTG7CYz3+Uk7yXCV7eQJAl6fr2bYu3AFueu04Aor
         x1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVAzdRBT0IaO4zh8UAKOwhWhhgOW9jn+v3YEff3ogX+6oEyh412+8NiSOaGKerl9wuLmB7AF3NR3wqD3nEM6j94beTwbhs6MffVzOVy
X-Gm-Message-State: AOJu0Yx9vVEK4FgPWLwnE+lHROO3X/I6AzkhGoMHBiRfqG6GdR1RAdkF
	rdFSK81/nUnfaVAYZBU40AnaqIjz2AjHfk9fSLh201TYfFMDblvypj/ozcVzK2A/kuLX3fWYhzH
	Uhz7fRaWjgFtkTv6phjZlMYODGzn2HVXoN8mdhxDoj5ZK1l2GkxtM2ma4sIf49g==
X-Received: by 2002:a05:6000:b4f:b0:33e:bb68:62b3 with SMTP id dk15-20020a0560000b4f00b0033ebb6862b3mr9339193wrb.1.1710756950179;
        Mon, 18 Mar 2024 03:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP96fNEmPfmSS0gew1N4BLjfBmizg4ugThfcFRfWpJrp3jcpo7pUhbeeHDIRPDcTD70WOYOg==
X-Received: by 2002:a05:6000:b4f:b0:33e:bb68:62b3 with SMTP id dk15-20020a0560000b4f00b0033ebb6862b3mr9339170wrb.1.1710756949728;
        Mon, 18 Mar 2024 03:15:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b0033e7715bafasm9429944wrs.59.2024.03.18.03.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 03:15:49 -0700 (PDT)
Message-ID: <8e13bce5-e353-4258-9891-97158b8ccd84@redhat.com>
Date: Mon, 18 Mar 2024 11:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: support multi-size THP numa balancing
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <903bf13fc3e68b8dc1f256570d78b55b2dd9c96f.1710493587.git.baolin.wang@linux.alibaba.com>
 <871q88vzc4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
 <ca6cca00-8a1b-48c8-b93a-99a772103b8e@redhat.com>
 <3bf2c3e1-44fd-4bc8-a97b-9da7b606aec0@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3bf2c3e1-44fd-4bc8-a97b-9da7b606aec0@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.03.24 11:13, Baolin Wang wrote:
> 
> 
> On 2024/3/18 17:48, David Hildenbrand wrote:
>> On 18.03.24 10:42, Baolin Wang wrote:
>>>
>>>
>>> On 2024/3/18 14:16, Huang, Ying wrote:
>>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>>
>>>>> Now the anonymous page allocation already supports multi-size THP
>>>>> (mTHP),
>>>>> but the numa balancing still prohibits mTHP migration even though it
>>>>> is an
>>>>> exclusive mapping, which is unreasonable. Thus let's support the
>>>>> exclusive
>>>>> mTHP numa balancing firstly.
>>>>>
>>>>> Allow scanning mTHP:
>>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data
>>>>> section
>>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared
>>>>> data
>>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>>> NUMA-migrate COW pages that have other uses") change to use
>>>>> page_count()
>>>>> to avoid GUP pages migration, that will also skip the mTHP numa
>>>>> scaning.
>>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>>> issue, although there is still a GUP race, the issue seems to have been
>>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the
>>>>> folio_estimated_sharers()
>>>>> to skip shared CoW pages though this is not a precise sharers count. To
>>>>> check if the folio is shared, ideally we want to make sure every
>>>>> page is
>>>>> mapped to the same process, but doing that seems expensive and using
>>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>>>
>>>>> Allow migrating mTHP:
>>>>> As mentioned in the previous thread[1], large folios are more
>>>>> susceptible
>>>>> to false sharing issues, leading to pages ping-pong back and forth
>>>>> during
>>>>> numa balancing, which is currently hard to resolve. Therefore, as a
>>>>> start to
>>>>> support mTHP numa balancing, only exclusive mappings are allowed to
>>>>> perform
>>>>> numa migration to avoid the false sharing issues with large folios.
>>>>> Similarly,
>>>>> use the estimated mapcount to skip shared mappings, which seems can
>>>>> work
>>>>> in most cases (?), and we've used folio_estimated_sharers() to skip
>>>>> shared
>>>>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>>>>> complaints.
>>>>
>>>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>>>> applications.  If some mTHP is shared by multiple threads in one
>>>
>>> Right.
>>>
>>
>> Wasn't this "false sharing" previously raised/described by Mel in this
>> context?
> 
> Yes, I got confused with the process's false sharing.
> 
>>>> process, how to deal with that?
>>>
>>> IMHO, seems the should_numa_migrate_memory() already did something to
>>> help?
>>>
>>> ......
>>>      if (!cpupid_pid_unset(last_cpupid) &&
>>>                  cpupid_to_nid(last_cpupid) != dst_nid)
>>>          return false;
>>>
>>>      /* Always allow migrate on private faults */
>>>      if (cpupid_match_pid(p, last_cpupid))
>>>          return true;
>>> ......
>>>
>>> If the node of the CPU that accessed the mTHP last time is different
>>> from this time, which means there is some contention for that mTHP among
>>> threads. So it will not allow migration.
>>>
>>> If the contention for the mTHP among threads is light or the accessing
>>> is relatively stable, then we can allow migration?
>>>
>>>> For example, I think that we should avoid to migrate on the first fault
>>>> for mTHP in should_numa_migrate_memory().
>>>>
>>>> More thoughts?  Can we add a field in struct folio for mTHP to count
>>>> hint page faults from the same node?
>>>
>>> IIUC, we do not need add a new field for folio, seems we can reuse
>>> ->_flags_2a field. But how to use it? If there are multiple consecutive
>>> NUMA faults from the same node, then allow migration?
>>
>> _flags_2a cannot be used. You could place something after _deferred_list
> 
> Could you be more explicit? I didn't see _flags_2 currently being used,
> did I miss something?

Yes, that we use it implicitly via page->flags on subpages (for example, 
some flags are still per-subpage and not per-folio).

-- 
Cheers,

David / dhildenb


