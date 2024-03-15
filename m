Return-Path: <linux-kernel+bounces-104309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE487CC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D251C21D32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B798F1AADB;
	Fri, 15 Mar 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwyKjd+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207819BA5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501165; cv=none; b=NacjPRgQwgxJFho0IaR3VQ2jrawxe44FQUIddwcjMB/xkpan5L1cZLLzU/7Zu+0a5zZMgzO3ZQL+w/5R6WXu92ljD6KmKQZhKWgj8PYiMDbPax4iqQYKPoTzhYsL69qu9lc2dOoQAdNffFZVK08CGF+7TE/WVXZaNGzwOs2h+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501165; c=relaxed/simple;
	bh=bAJHU7DBs34PbTDTw+i0B/+nZEIVGRPnSWmDKfh8maU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arrVgu71JGiI8b6GVgGdlB+rMDZQgi3UJqVJ+h4RHVinqThpUDl8ciWBbFZl1SY3z1gYG9XGCoCy1hION7zoPZqYZH9yXCW2j+5rH0lvpBLPrDGpXyu9kiK3Vb8KwxM83WLFHk48I5jaT2quKYSFRF4AtqYNNj10YLGM4MyoDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwyKjd+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710501163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+N4nu0FHlV3EPKxempKSRPqLmNvX8Np95CYQieGhhmg=;
	b=AwyKjd+NbKzViM3Msw6JDZDMl1Cjfvr4KHtfnqrs12CZpY3nVb/Q0PrXTlVjDXsyNzbHG1
	YFVGCv3n+kZN3BaqTZIPSlQ3dFXwjVZMIjqpcu8Uq9YKrtxV0zprOcMp4DRJ3hKxQ3Fy9h
	XO+33IpBBiFgTAJq5XbzqSKR5gnKNek=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-DQMg7Z5BPGyvNv8UL9y_-A-1; Fri, 15 Mar 2024 07:12:41 -0400
X-MC-Unique: DQMg7Z5BPGyvNv8UL9y_-A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40fb505c97aso11678605e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501160; x=1711105960;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N4nu0FHlV3EPKxempKSRPqLmNvX8Np95CYQieGhhmg=;
        b=ejNqRBlc7ZAOPkYwTx1wGqLstfK6muOaBKHaJ7YRWx3e1eK7MQoZCiPQ/amSvslNdM
         HI7ufMTlFAak+eHoP7hrU1h+JiDQiIpV0z/zuUYlCCYtAz1a9Fs0BrqjRmF5bLfFvR6a
         YGNwUobWwWMemIGZ4JWBkuwLJFmKOZencbtIXhZy4O0xc/RfPNGEfAB1QL9DM+6VsYyR
         CnG/gxbSFQFtlC8Ih0g91X/e5GD6zQ64LlhON3EHOSfiW47eeW5o6Zlky/aGbha/se0K
         N9EpavSmmPt4jBTKJEmIfGIeO+w+LLhSR1dSP77qZilFWpZI5yEGBFo5DE5IbhbVk1Kj
         unxw==
X-Forwarded-Encrypted: i=1; AJvYcCXRL/w2GzLDROWOmyN+DUBpNTWpnUxqrTtbb5ErAKD9Tc4PiGZn8gJuaF3B+9smgHmkFC37TCCMRkXibKR4JVcFPgohw3/k3x/aVd/D
X-Gm-Message-State: AOJu0YxO0xkVHKixyEltFPquHC9VgVVdr6oc52KiDNKkWbEeaELbcBj+
	Fytbi+SfLJLENGOvNNd0lzP6+7U7Nbp0rD9jXomEGqbQ2qQYJZZm0ZHNoIbBQa/6VxbK73VLKXi
	WPr6pV9W4qdNXoRlktDHVogx0xFLP4+hhFqUlJ8+zdt0NTFjdsvBiKHBj+AFICw==
X-Received: by 2002:a05:600c:5246:b0:412:d68c:8229 with SMTP id fc6-20020a05600c524600b00412d68c8229mr2499659wmb.39.1710501160414;
        Fri, 15 Mar 2024 04:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8XRePItOvhPTDmPylHlgrKg6iPzpgM9y4syydgheo2+oL5h4QE8oJrLraLFJw/+mCZ+ferQ==
X-Received: by 2002:a05:600c:5246:b0:412:d68c:8229 with SMTP id fc6-20020a05600c524600b00412d68c8229mr2499628wmb.39.1710501160004;
        Fri, 15 Mar 2024 04:12:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:7700:ef08:112b:278d:7d90? (p200300cbc7197700ef08112b278d7d90.dip0.t-ipconnect.de. [2003:cb:c719:7700:ef08:112b:278d:7d90])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c502900b00413fe69037dsm2850831wmr.44.2024.03.15.04.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 04:12:39 -0700 (PDT)
Message-ID: <caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
Date: Fri, 15 Mar 2024 12:12:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yin Fengwei <fengwei.yin@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
 <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.03.24 11:49, Ryan Roberts wrote:
> On 15/03/2024 10:43, David Hildenbrand wrote:
>> On 11.03.24 16:00, Ryan Roberts wrote:
>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>> folios before swap-out. This benefits performance of the swap-out path
>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>> up for swapping in large folios in a future series.
>>>
>>> If the folio is partially mapped, we continue to split it since we want
>>> to avoid the extra IO overhead and storage of writing out pages
>>> uneccessarily.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    mm/vmscan.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head
>>> *folio_list,
>>>                        if (!can_split_folio(folio, NULL))
>>>                            goto activate_locked;
>>>                        /*
>>> -                     * Split folios without a PMD map right
>>> -                     * away. Chances are some or all of the
>>> -                     * tail pages can be freed without IO.
>>> +                     * Split partially mapped folios map
>>> +                     * right away. Chances are some or all
>>> +                     * of the tail pages can be freed
>>> +                     * without IO.
>>>                         */
>>> -                    if (!folio_entire_mapcount(folio) &&
>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>                            split_folio_to_list(folio,
>>>                                    folio_list))
>>>                            goto activate_locked;
>>
>> Not sure if we might have to annotate that with data_race().
> 
> I asked that exact question to Matthew in another context bt didn't get a
> response. There are examples of checking if the deferred list is empty with and
> without data_race() in the code base. But list_empty() is implemented like this:
> 
> static inline int list_empty(const struct list_head *head)
> {
> 	return READ_ONCE(head->next) == head;
> }
> 
> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps not
> sufficient for KCSAN?

Yeah, there is only one use of data_race with that list.

It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is 
in deferred list").

Looks like that was added right in v1 of that change [1], so my best 
guess is that it is not actually required.

If not required, likely we should just cleanup the single user.

[1] 
https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/

-- 
Cheers,

David / dhildenb


