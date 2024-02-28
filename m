Return-Path: <linux-kernel+bounces-84999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A786AEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894FD2840E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B67352C;
	Wed, 28 Feb 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW4fFzVC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292F1F608
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122348; cv=none; b=tsutMTONHfyhUsuFnfO9R/ciZ6WSETpUl/Fog8NAwTzPT2lyeBt5ew+lvBNP2g3Ys3wngEWzGWuUsofrqiJ3jrleK36ZkeT0CXdPCY/sD1B0W6JO+r3zb28Dwqk6VaZ5PnA0+uLMmmIowER4FDR1QR7KCGmTOY/LiT8UY9k/MxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122348; c=relaxed/simple;
	bh=UFVLGPA0XRRXe8W/+1MvQ5nRusePQSmiz/DB/+Ewjco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diq8DDOPh7VlLh9IdleD3e544F1+R4lyEgGOoiJUDjhAuBuMPr/MIOcLclhtqOiJhDM7oEVHospdtqI1ao7k85b4stK1031k5E7V5FTfUzMwgLdFqzppZg/M20pkIOqrvG3Q7pd3LKYMXNs3r+JHCkQUwpFG+JuKxXT/AFX6rHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cW4fFzVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709122346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Bawf9YKvOwBK/NSWkabIQBOK1tSWFXXnb4NlAEdtQU=;
	b=cW4fFzVCOYCmavJEaNT+r0PVrA8tckKBZJSnKg7pI3I+FaQb3LtwkoSF+uvQOL8Z60+kCn
	Q6U01SIDUvP1THuFIEDXA6o9dOCGH8lZfWirAYJfX5kUzmSAKCT14D0T53vi69ztm5BRW7
	wKfoBfqOlrWrDKnW0i+nEAonHsrCiOQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Nqkeh9uUPtGJ5gyLlybl4w-1; Wed, 28 Feb 2024 07:12:24 -0500
X-MC-Unique: Nqkeh9uUPtGJ5gyLlybl4w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e435a606aso28219815e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 04:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709122344; x=1709727144;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bawf9YKvOwBK/NSWkabIQBOK1tSWFXXnb4NlAEdtQU=;
        b=Aot4rJnX0cXM2C5ms2qtlKKxEqhZJ0cwmyqz1LUviuRR12poLbztSp1zRIIgwXl7Vk
         SLuhfA1goPxTCAAnNUCYkpurTsHHN4UR+xcntuh45+FWy2UVBUhxYbVKPW+TE21jvcpD
         TA8biSq+UV/Xci2b4DHRfrz77/UVpfTP2geTzT+XhcplN7EL4tgB0VPpOY3jbsskQtK/
         fjS8UrX2XsK4IeKBf1q7aSo5TKWekYGW9L0IcNVcz4g+cHvarzdT3a3KJJJbaHpKFM/U
         F4fV4ZjIdr7gt3kqXXGzKXLDO98V8PPN5FLApZlJwPjJudSR68+7WtKIaltVKYcMKRvg
         JzMQ==
X-Gm-Message-State: AOJu0Yx1qmmv5zN5lLrA0ssU06xbyOtmO9aAec4XU5e3ptlLR6J/0uPo
	WTA/J/Vi6NGpfVMZhjw64Fl1cpi29dMjn8dRnBTkWKS8gxjbQx7g264ej85ixWKhWyHpzVdmskf
	vkfdXyzsdi5ETX+fAUWs99jQL7HFYZQNmxn37lfxLhKUmzcuuWrV8+GffrmHoqw==
X-Received: by 2002:a05:600c:3483:b0:412:b0ef:22af with SMTP id a3-20020a05600c348300b00412b0ef22afmr2417944wmq.29.1709122343795;
        Wed, 28 Feb 2024 04:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6GtxVj14XyRuIXhKTLz5ownoWx0SPF1M79uF45Ef97XJErCrWj8d9ivuyvFouB10m3YTjNA==
X-Received: by 2002:a05:600c:3483:b0:412:b0ef:22af with SMTP id a3-20020a05600c348300b00412b0ef22afmr2417919wmq.29.1709122343345;
        Wed, 28 Feb 2024 04:12:23 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b00412b2afb2c8sm1905742wmf.26.2024.02.28.04.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 04:12:22 -0800 (PST)
Message-ID: <d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
Date: Wed, 28 Feb 2024 13:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20231025144546.577640-2-ryan.roberts@arm.com>
 <d108bd79-086b-4564-838b-d41afa055137@redhat.com>
 <6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
 <ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
 <ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
 <2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
 <049818ca-e656-44e4-b336-934992c16028@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <049818ca-e656-44e4-b336-934992c16028@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> How relevant is it? Relevant enough that someone decided to put that
>> optimization in? I don't know :)
> 
> I'll have one last go at convincing you: Huang Ying (original author) commented
> "I believe this should be OK.  Better to compare the performance too." at [1].
> That implies to me that perhaps the optimization wasn't in response to a
> specific problem after all. Do you have any thoughts, Huang?

Might make sense to include that in the patch description!

> OK so if we really do need to keep this optimization, here are some ideas:
> 
> Fundamentally, we would like to be able to figure out the size of the swap slot
> from the swap entry. Today swap supports 2 sizes; PAGE_SIZE and PMD_SIZE. For
> PMD_SIZE, it always uses a full cluster, so can easily add a flag to the cluster
> to mark it as PMD_SIZE.
> 
> Going forwards, we want to support all sizes (power-of-2). Most of the time, a
> cluster will contain only one size of THPs, but this is not the case when a THP
> in the swapcache gets split or when an order-0 slot gets stolen. We expect these
> cases to be rare.
> 
> 1) Keep the size of the smallest swap entry in the cluster header. Most of the
> time it will be the full size of the swap entry, but sometimes it will cover
> only a portion. In the latter case you may see a false negative for
> swap_page_trans_huge_swapped() meaning we take the slow path, but that is rare.
> There is one wrinkle: currently the HUGE flag is cleared in put_swap_folio(). We
> wouldn't want to do the equivalent in the new scheme (i.e. set the whole cluster
> to order-0). I think that is safe, but haven't completely convinced myself yet.
> 
> 2) allocate 4 bits per (small) swap slot to hold the order. This will give
> precise information and is conceptually simpler to understand, but will cost
> more memory (half as much as the initial swap_map[] again).
> 
> I still prefer to avoid this at all if we can (and would like to hear Huang's
> thoughts). But if its a choice between 1 and 2, I prefer 1 - I'll do some
> prototyping.

Taking a step back: what about we simply batch unmapping of swap entries?

That is, if we're unmapping a PTE range, we'll collect swap entries 
(under PT lock) that reference consecutive swap offsets in the same swap 
file.

There, we can then first decrement all the swap counts, and then try 
minimizing how often we actually have to try reclaiming swap space 
(lookup folio, see it's a large folio that we cannot reclaim or could 
reclaim, ...).

Might need some fine-tuning in swap code to "advance" to the next entry 
to try freeing up, but we certainly can do better than what we would do 
right now.

-- 
Cheers,

David / dhildenb


