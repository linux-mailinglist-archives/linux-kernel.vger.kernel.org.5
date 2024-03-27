Return-Path: <linux-kernel+bounces-120567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353FD88D96E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD3B1F281A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C722E85D;
	Wed, 27 Mar 2024 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8CNK09i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542761AACA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529253; cv=none; b=PnrW1aOhyy1Ofn71MUS5boA/e5K+DaSstCNKSXf4qYOba/JdOgtJXRVC9o34uCU/IAQXOJgYE7qYfqBJVxlTg3/dPVIrRvW2ryC9w3N/1BZx8y5fNFgq8ew7UiA7hbOV4jJkWTOFLutvMAbSi4Xc/mRBYxe4VpA+VEzJrF8JLKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529253; c=relaxed/simple;
	bh=Nk+sTw6sXrqUbMF7kLC1QIo2ShIJ3TTu73zArQ9dm7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM5+NnpZ0ktsiNrT7L5jeuVEwC7+7X1o4M2FtXBUWqK1zKAzFcBsXiFaRmyAggrKFHVzcAfLmM9R9WXcc0ifn4VWnIdd/2LB9Srkq2nnlcE9ty7ygkg76HPXyQ6aBv7ZthC59rICBb8lNb3pmCOOaAur8ovOtdKvonNAkD0hQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8CNK09i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711529249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mr6CHANv5/Pxd2mqOgkaDkz4dpnu39dS4lzW9kZ1PzQ=;
	b=K8CNK09iBFXbrmzFRNuGXT2uIM+d0nzGSNrDCMQDpMBzd90zGIvlhYe6rMM89xTjB44XzQ
	T95qH32/6bVzIpA9sA9ljT+luC/nFj5MrbJ8vQYzCneJMNb2xUJ38W3KfItL1WnZA+djRJ
	pixG+hjjqzSVrOi8V7y8N91E8DSIt3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-01aQsyapPBa3NkpZaPl-8A-1; Wed, 27 Mar 2024 04:47:28 -0400
X-MC-Unique: 01aQsyapPBa3NkpZaPl-8A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41485cd7d9dso25385575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529247; x=1712134047;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr6CHANv5/Pxd2mqOgkaDkz4dpnu39dS4lzW9kZ1PzQ=;
        b=VTFuDXUmP/OHESVEyIjf2ZzZW7EYzqzHm+Fr0gxZvrDm6XPAijSjG1fWPxDOH4gbH+
         0iYEtpF/MldtI8lpF+EyAy31GPmi1mTkdhnEjIB00FhAei43tPC0NCyjPlSc8PDN8+R+
         99E4nbVZBs42tqRVLj2wbUfnFz94FNHHKOD/yhD/4psmtCOScBeNHjSEaoVCvO0Luf7v
         jCAJbJfMiEil27nXvt9iuQo1rY9Piax2ugbWYgiyo9TSmEBinBx7/bysiPaDL1fyUS3l
         WYzFsxze4EMs2n3X2rA2+8idyYPCv5aafvYAv9E2AFny2iV/j6M9HzoFPHQTDSnDQ1jU
         bYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZLTUVEqZ5+6DgC4CN62/Y4xFdimmFfh+91EVXZH+XClZKmJTskZFVh0RtTr0Zd8SyC/YD2dkurc9EbJF3ygDD1hsnRwE0eD8bANkH
X-Gm-Message-State: AOJu0Yw5l/AdnEfpviOe5y19YJa1AHYhL+YDPhEDmw00yW5y0A5LraUS
	yPM0MIQTXMnYL68FCOOGH8u1zEjoMvYLuDQdRoz6Lel5uj/s525ZDC49uZC0G8wa1rryjwpE+26
	QUe1ndcADmd72MPBLqCTUi1pDvOBqx/+TSZdVa1QsoMwF+zDxM39aEGhDZXY6TQ==
X-Received: by 2002:a05:600c:a07:b0:414:7eca:d9a5 with SMTP id z7-20020a05600c0a0700b004147ecad9a5mr1889973wmp.12.1711529246888;
        Wed, 27 Mar 2024 01:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBOvbz8Zehv/FlOIpgY15QHwvHr+Q3GUSn1NCLjUZAtaX1/rX09Ir1S0ULPPyL6hQrL72Lhg==
X-Received: by 2002:a05:600c:a07:b0:414:7eca:d9a5 with SMTP id z7-20020a05600c0a0700b004147ecad9a5mr1889944wmp.12.1711529246385;
        Wed, 27 Mar 2024 01:47:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:8a00:362b:7e34:a3bc:9ddf? (p200300cbc7088a00362b7e34a3bc9ddf.dip0.t-ipconnect.de. [2003:cb:c708:8a00:362b:7e34:a3bc:9ddf])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c001200b00413eb5aa694sm1438713wmc.38.2024.03.27.01.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:47:25 -0700 (PDT)
Message-ID: <6248d6fb-b982-4ebd-93a9-7750cc4a5039@redhat.com>
Date: Wed, 27 Mar 2024 09:47:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: support multi-size THP numa balancing
Content-Language: en-US
To: "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
 wangkefeng.wang@huawei.com, jhubbard@nvidia.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
 <dee4268f1797f31c6bb6bdab30f8ad3df9053d3d.1711453317.git.baolin.wang@linux.alibaba.com>
 <87cyrgo2ez.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <bc671388-f398-4776-af15-c144f2c39d78@linux.alibaba.com>
 <87edbwm6fh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87edbwm6fh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.24 09:21, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> On 2024/3/27 10:04, Huang, Ying wrote:
>>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>>
>>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>>> but the numa balancing still prohibits mTHP migration even though it is an
>>>> exclusive mapping, which is unreasonable.
>>>>
>>>> Allow scanning mTHP:
>>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>>> issue, although there is still a GUP race, the issue seems to have been
>>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_likely_mapped_shared()
>>>> to skip shared CoW pages though this is not a precise sharers count. To
>>>> check if the folio is shared, ideally we want to make sure every page is
>>>> mapped to the same process, but doing that seems expensive and using
>>>> the estimated mapcount seems can work when running autonuma benchmark.
>>> Because now we can deal with shared mTHP, it appears even possible
>>> to
>>> remove folio_likely_mapped_shared() check?
>>
>> IMO, the issue solved by commit 859d4adc3415 is about shared CoW
>> mapping, and I prefer to measure it in another patch:)
> 
> I mean we can deal with shared mTHP (by multiple threads or multiple
> processes) with this patch.  Right?

It's independent of the folio order. We don't want to mess with shared COW pages, see

commit 859d4adc3415a64ccb8b0c50dc4e3a888dcb5805
Author: Henry Willard <henry.willard@oracle.com>
Date:   Wed Jan 31 16:21:07 2018 -0800

     mm: numa: do not trap faults on shared data section pages.
     
     Workloads consisting of a large number of processes running the same
     program with a very large shared data segment may experience performance
     problems when numa balancing attempts to migrate the shared cow pages.
     This manifests itself with many processes or tasks in
     TASK_UNINTERRUPTIBLE state waiting for the shared pages to be migrated.
..

that introduced this handling.

-- 
Cheers,

David / dhildenb


