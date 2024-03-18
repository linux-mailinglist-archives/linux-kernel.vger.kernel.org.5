Return-Path: <linux-kernel+bounces-105901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9B87E633
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF31F224F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB622C6B6;
	Mon, 18 Mar 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aA//cief"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4182C6A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755289; cv=none; b=BZ6WbWmmG7BWZPBTj025P/LEEfA4KSwtVJRQTfz7I3HNR9P62QtoeaOagI0yNmsKKpPm5GF5RY5m8qJHMPsxdimIkVLMZUEwH2edvkPfpQP0SyBooS27DaJgm04po9KYSDsUKQC+AR9qxUbhXt7RxrkZ5JIOwHoCeJakrAlFQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755289; c=relaxed/simple;
	bh=yLZm8UmDIbSLbszppiTYYW6vVaMGGuKCFnvT//osZEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDg6QhyCpv9k0GYUi6fWlpPGVdCMrp8jHMmStkmFZYZ7+a4sfglVg+9CYOv+kIbMtFFC0PM7+8k1Y0BvCZZPST79c48jj3RKKRq/Sb+BS3eYxxd7lyZWJaM3w4x2egeOqMSj7jAU3ff+az70dpLjCxrYyUIpmuu68dIuK4ZvhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aA//cief; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710755286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nELhg4+vsVbvdDiQeSgfbHglrwF0XWGALe3+9j7o4IM=;
	b=aA//ciefOrKZ6Sn9WJS64kg4mS+aNFlJ2RBpdxCEM1xcuL72lyDd2MBr43qwdKgUigPkit
	IUrz6YRdDmdwOdijddXtzJCWXqh/7+Rqn2ifijKcV+l22HGmBWknD9+MXNc281eYIofnXB
	flElNd8kUacatUf6Tdk6CrgfnzPEfHw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-v-jYkp9DM9GhoFhhrrt_1g-1; Mon, 18 Mar 2024 05:48:04 -0400
X-MC-Unique: v-jYkp9DM9GhoFhhrrt_1g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33eb8721b64so2402997f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710755283; x=1711360083;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nELhg4+vsVbvdDiQeSgfbHglrwF0XWGALe3+9j7o4IM=;
        b=j4J8fFWfBtPS1oSaxAL1NGn7m8Q5KSg/1d4SuGEbWUARHwbZG1krUCV7hvtuhxWvWh
         vFG/XAyeScPKnc7gQumz9x8LqOhIDKaAIjQsAOYi6agy0RvgvXRGPSL8pekYpaDDdoRc
         E24J3wqMlZ65dxnp2CeN4MRJY1tY/cKTUEoIL/eTon02UBap7pZZ18wt+xnqSwJL6Xkz
         nbQV+g/pYmwawaRNncAXZ96cC/fdxi0kTZJHEHqCzWj5NdGatpK+WGpxIwTw1UfkVlmw
         V5ngzIsRQl4zuPothIG9msqJyLWtC+Apcs1CQUKmV+FmwOif1ssVnJL6WENEuK2j8vqH
         LG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4xEi4VFJbotc7tF/5UZ0xatqAHLOZobP99Auh0R1tJTbALl8Ag28OLM3gSLOPi+1376TbZKavOmsTuqimcCLb//Cym8R+jHgvJjVh
X-Gm-Message-State: AOJu0Yzc1EHYOuq2INiGbDoEpHBZgJwmVQBj8xxDt2lk6Ab/OYboil6D
	r7BD3ghazIfr2U4J2EW9xr/48jtA+aapJMN4KZxxOmLkavFTWkT9HL7Om1Nnhl1QksV0hxko061
	6aQpRy/7aKGbcatAY6d1FliyyzH+T6zJ1W+OhVcqNg3L+kP6iP5lZx8B4vJGJWQ==
X-Received: by 2002:a5d:5750:0:b0:33e:8fd:1173 with SMTP id q16-20020a5d5750000000b0033e08fd1173mr7686356wrw.60.1710755283645;
        Mon, 18 Mar 2024 02:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvjXZ/WmgxRXjUi1dpzJdRashyJr7cTUrwHNawSmLcVzolzcX+6CNKcKQ4GNC+8GK8pw3T4g==
X-Received: by 2002:a5d:5750:0:b0:33e:8fd:1173 with SMTP id q16-20020a5d5750000000b0033e08fd1173mr7686336wrw.60.1710755283190;
        Mon, 18 Mar 2024 02:48:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d638a000000b0033e206a0a7asm9318645wru.26.2024.03.18.02.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:48:02 -0700 (PDT)
Message-ID: <ca6cca00-8a1b-48c8-b93a-99a772103b8e@redhat.com>
Date: Mon, 18 Mar 2024 10:48:01 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f00316da-e45d-46c1-99b8-ee160303eaaa@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 10:42, Baolin Wang wrote:
> 
> 
> On 2024/3/18 14:16, Huang, Ying wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> Now the anonymous page allocation already supports multi-size THP (mTHP),
>>> but the numa balancing still prohibits mTHP migration even though it is an
>>> exclusive mapping, which is unreasonable. Thus let's support the exclusive
>>> mTHP numa balancing firstly.
>>>
>>> Allow scanning mTHP:
>>> Commit 859d4adc3415 ("mm: numa: do not trap faults on shared data section
>>> pages") skips shared CoW pages' NUMA page migration to avoid shared data
>>> segment migration. In addition, commit 80d47f5de5e3 ("mm: don't try to
>>> NUMA-migrate COW pages that have other uses") change to use page_count()
>>> to avoid GUP pages migration, that will also skip the mTHP numa scaning.
>>> Theoretically, we can use folio_maybe_dma_pinned() to detect the GUP
>>> issue, although there is still a GUP race, the issue seems to have been
>>> resolved by commit 80d47f5de5e3. Meanwhile, use the folio_estimated_sharers()
>>> to skip shared CoW pages though this is not a precise sharers count. To
>>> check if the folio is shared, ideally we want to make sure every page is
>>> mapped to the same process, but doing that seems expensive and using
>>> the estimated mapcount seems can work when running autonuma benchmark.
>>>
>>> Allow migrating mTHP:
>>> As mentioned in the previous thread[1], large folios are more susceptible
>>> to false sharing issues, leading to pages ping-pong back and forth during
>>> numa balancing, which is currently hard to resolve. Therefore, as a start to
>>> support mTHP numa balancing, only exclusive mappings are allowed to perform
>>> numa migration to avoid the false sharing issues with large folios. Similarly,
>>> use the estimated mapcount to skip shared mappings, which seems can work
>>> in most cases (?), and we've used folio_estimated_sharers() to skip shared
>>> mappings in migrate_misplaced_folio() for numa balancing, seems no real
>>> complaints.
>>
>> IIUC, folio_estimated_sharers() cannot identify multi-thread
>> applications.  If some mTHP is shared by multiple threads in one
> 
> Right.
> 

Wasn't this "false sharing" previously raised/described by Mel in this 
context?

>> process, how to deal with that?
> 
> IMHO, seems the should_numa_migrate_memory() already did something to help?
> 
> ......
> 	if (!cpupid_pid_unset(last_cpupid) &&
> 				cpupid_to_nid(last_cpupid) != dst_nid)
> 		return false;
> 
> 	/* Always allow migrate on private faults */
> 	if (cpupid_match_pid(p, last_cpupid))
> 		return true;
> ......
> 
> If the node of the CPU that accessed the mTHP last time is different
> from this time, which means there is some contention for that mTHP among
> threads. So it will not allow migration.
> 
> If the contention for the mTHP among threads is light or the accessing
> is relatively stable, then we can allow migration?
> 
>> For example, I think that we should avoid to migrate on the first fault
>> for mTHP in should_numa_migrate_memory().
>>
>> More thoughts?  Can we add a field in struct folio for mTHP to count
>> hint page faults from the same node?
> 
> IIUC, we do not need add a new field for folio, seems we can reuse
> ->_flags_2a field. But how to use it? If there are multiple consecutive
> NUMA faults from the same node, then allow migration?

_flags_2a cannot be used. You could place something after _deferred_list 
IIRC. But only for folios with order>1.

But I also wonder how one could achieve that using a new field.

-- 
Cheers,

David / dhildenb


