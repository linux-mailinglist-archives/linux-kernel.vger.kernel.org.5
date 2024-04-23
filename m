Return-Path: <linux-kernel+bounces-154943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA1B8AE357
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6C1F223CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1016EB70;
	Tue, 23 Apr 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhzegNxe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7F4691
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870314; cv=none; b=WqiZFG9mhD0cTmUPo5XJqS7WkJS14G9R1XcRWQcyFuI4SmYABi0aluwCvnMJnVUJkZvBBMCO0gIyiBIpy8CKx8tppOoqf/RWUAwNIk4AZYiD9EFohhr+W2ZbEMtsY3FmBwOCy3OUA0rlmNwHPXLZjiDsM6KJQGQ7eqMNPNwJ4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870314; c=relaxed/simple;
	bh=w1uSIpY9FpVcmDza1G4oH4ZkDqM7XGjOMrKhtpxXzEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXvHEZwtjySwl/j75I9RD3WLKQqVhi0qG3IKe0zOTDLLbAfpBricvSs3agMGb58kR5nzz00alnd3hXaJZd2bYC7t0bPviTj+d/SWBuckAPJrR4vkOP0Q2ZzYQrzGBc0WpoL/SgD4tRDQylnZXezQ9jKGcgTDMzL4V5imGmOcAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhzegNxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713870312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EjKJ4AU8u7PAwlJohTc2cAX1xjzwI5Yp1vDnN6OM75w=;
	b=ZhzegNxe0pQeIrjw9JYJNR0sPjJq+TAedpHHWq82EBuuvDTGqJCAiZ9153o1bbV/U+Rsp3
	hPBxH8flb/J2DhVbOwi49gH431kQsWPIOmA3yBrV5/ayI+O/cW4JC1l9/9XIsBaBoI7XPb
	x9w+PogmJXp7Qdwxr6Kgu5VH/llPDjs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-uNN3C2xkN9OIdh75Thaz0g-1; Tue, 23 Apr 2024 07:05:11 -0400
X-MC-Unique: uNN3C2xkN9OIdh75Thaz0g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34b3fb802ddso788292f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870310; x=1714475110;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjKJ4AU8u7PAwlJohTc2cAX1xjzwI5Yp1vDnN6OM75w=;
        b=lJs6vaovQNlpf49+p75lOAPDrJ3XKJTLrkYDH67DfPKtyWaEHhjmDRbWdn4lU4bJOU
         IujqMgae9D1QdLJpBvLmcOmgccT3r6UiPeCwks/raMgx7KG96HCr3YxXThVOWMHlFuWF
         Z9QqCb5qBeNprm7A2kk18dSByCmDeLl4mEWD1nvaiXC14SPdfWsu6g97Jdv/Ya0vJI9A
         8R4onuMwuH8zgDG6ehojU7jeSTIEOARJUQwHqf9gDM+npYW9faK/f9BWOGq6VC5gqpt4
         6lsegr2t2qzm0FUo/jzKG1ZF2dR3A9R88MBga1CupBeLhrFkY1PG720+j67CqZPBHymR
         oDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw/0WXJ/BVsCDPkQw3yGmD6gWJv1HTVAndyUq0iJ7Rl6QQAhBTMJtbJm7TMUyOr020CPjeBrlXkt8EYXG5mKDk1wos5OntebAOZiC4
X-Gm-Message-State: AOJu0YyjgjLQZSfI+/rnKU4gpvk0WF1hKSvoFJD9ISzPBwEERqec4KHB
	t19UHjPkouWwQvWs6EtmvGn7pK2KCVm2TWOrswbz3StXSQSNR3qlJnyYKzxl+2pMPiKLJkkQqxU
	N9qaw2mDSQUF4ZTs76lm6tQxCmWRaP6oqt0+MupbHQ0czBWwBLjkF9rtyK48Hsg==
X-Received: by 2002:adf:fed0:0:b0:33e:76d7:a8ad with SMTP id q16-20020adffed0000000b0033e76d7a8admr8915432wrs.38.1713870309763;
        Tue, 23 Apr 2024 04:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwlddpYnAMq3cCjUD4VPpibURxlO35eJRB1XNrzQC4o/9df626d5GAoeOUmGMYwbMqsS8C8A==
X-Received: by 2002:adf:fed0:0:b0:33e:76d7:a8ad with SMTP id q16-20020adffed0000000b0033e76d7a8admr8915407wrs.38.1713870309296;
        Tue, 23 Apr 2024 04:05:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fd00:fb07:92f8:8f0c:6a08? (p200300cbc706fd00fb0792f88f0c6a08.dip0.t-ipconnect.de. [2003:cb:c706:fd00:fb07:92f8:8f0c:6a08])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm23433800wmq.15.2024.04.23.04.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:05:08 -0700 (PDT)
Message-ID: <8abcc8aa-473f-4a3c-a528-d32a0c8bfd75@redhat.com>
Date: Tue, 23 Apr 2024 13:05:07 +0200
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
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4b998e7d-153f-48cc-a9bb-8c84bb675581@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.04.24 12:41, Ryan Roberts wrote:
> On 22/04/2024 08:02, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>> through commit 19eaf44954df, that can allow THP to be configured through the
>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Many implement anonymous page sharing through
>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>> also including the anonymous shared pages, in order to enjoy the benefits of
>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
> 
> This sounds like a very useful addition!
> 
> Out of interest, can you point me at any workloads (and off-the-shelf benchmarks
> for those workloads) that predominantly use shared anon memory?
> 
>>
>> The primary strategy is that, the use of huge pages for anonymous shared pages
>> still follows the global control determined by the mount option "huge=" parameter
>> or the sysfs interface at '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
>> The utilization of mTHP is allowed only when the global 'huge' switch is enabled.
>> Subsequently, the mTHP sysfs interface (/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled)
>> is checked to determine the mTHP size that can be used for large folio allocation
>> for these anonymous shared pages.
> 
> I'm not sure about this proposed control mechanism; won't it break
> compatibility? I could be wrong, but I don't think shmem's use of THP used to
> depend upon the value of /sys/kernel/mm/transparent_hugepage/enabled? So it
> doesn't make sense to me that we now depend upon the
> /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled values (which by
> default disables all sizes except 2M, which is set to "inherit" from
> /sys/kernel/mm/transparent_hugepage/enabled).
> 
> The other problem is that shmem_enabled has a different set of options
> (always/never/within_size/advise/deny/force) to enabled (always/madvise/never)
> 
> Perhaps it would be cleaner to do the same trick we did for enabled; Introduce
> /mm/transparent_hugepage/hugepage-XXkb/shmem_enabled, which can have all the
> same values as the top-level /sys/kernel/mm/transparent_hugepage/shmem_enabled,
> plus the additional "inherit" option. By default all sizes will be set to
> "never" except 2M, which is set to "inherit".

Matches what I had in mind.

-- 
Cheers,

David / dhildenb


