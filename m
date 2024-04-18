Return-Path: <linux-kernel+bounces-150033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5798A9962
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099BB1C21C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10EA15FD0B;
	Thu, 18 Apr 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI8hMjtU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D515FCFB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441607; cv=none; b=EtC/Lb1jymvGBvG8JmZ+P4R1e9WkKEap8B6xCHKrs0+DhNAslVr5WWfwdApKCe6w93CmV/PDPp/PSh229/yTQNW4og4JyG8+CeWxQirmm4mlcuWudEOEa2frIxZcbaQjm5Q9L3yP2W1aXuq4mDsEjKdQYyhEcueN4Zk00qtGNZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441607; c=relaxed/simple;
	bh=WE9ol4jgaud3M9DK782EnS/jdkxysyf0MiewX7tFHyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3yWmRrPomZtp1FWA8mPy+9I3n8H/MFKErErDfgPURhlpIBF+2dCLq2yzNs7oYdhNna4jEE89ZOrer7IlHaCMsWBxX9m39CsKx0u9LAlbmPeWKcm3KmNZ15uVrT+2HupSMqKu8/Fygl1bPcv4otQPB0tccxWcu/2XU63PrSi+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI8hMjtU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LATllXZlJk+cYDGqNM/88KIOt+R2i5kafJXKmW3NbsE=;
	b=UI8hMjtU53U9j5QftDi9Gf0ezvhi/CGc1PXdThTtgrOcEkDVHQ4oU8+POto0Etm/CEGUB0
	HYm+UzlLFwPOqNvLGqVMkiXw80m4hG6xwm8RPMeUGcD5+7vQ1fFUEnT2pWMTHD50K7uu3w
	TxDgPmA0jHxotKVALlgNF1p4k6UpIu0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-gUr5mN-dO8ijxeBXqtsF-Q-1; Thu, 18 Apr 2024 08:00:01 -0400
X-MC-Unique: gUr5mN-dO8ijxeBXqtsF-Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41485831b2dso6629745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441600; x=1714046400;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LATllXZlJk+cYDGqNM/88KIOt+R2i5kafJXKmW3NbsE=;
        b=IRG9thHnj2nAXh7Sni595YgM73IhmK+An/HMdD2ivRS9zafEN4lfSbqX7IwV/rwl1B
         tTUzgVXA0GVKOFmQb9hlfOGNBGd+l+svKL87uZZcE+MIpY806xGvmYMF6zNoVwy0Vrxe
         QidHIuhlyU2TjTKgj8zYRVPRZwF82gPaC2W2WwwCL9IuNbur2BRoFWYqi3YnBTDMpUYw
         Yoazb+wb+IACAwOmiYrsL3jLWUExuMRjv7t2r1yJ0sxhJhA1DCALzEddGcqI7aIA5JYj
         dY90WoJaBtdwMKWZqJwd9wN5xi6z7KZfHiyDNLdBSJsVSYS4HInA0/C0pPn/ZemJnU/V
         5eFw==
X-Forwarded-Encrypted: i=1; AJvYcCUt5EvxaAZDkE58I6EuBsHGJP8glBo/f4BrVzQbKSRiH3+XVfgh5JiX7N2itiRVI69+uQSZRejiJuP0xHElkxJFnomvWMC9LV8gNw9y
X-Gm-Message-State: AOJu0YzSoV/QXZmvum9LzYfxqGI0qp3MkgHwbNmGl2U6FQNKFmRmLU4G
	t6moIVEFDzFPL0ZZ3O+0ToKc0XmTkhIc7kKpRfG3UHzHt59YRp0KQD87NRrcnNCWoNnOtmgMFy1
	rT0birfP5HY2TkaCKRthWtZwiRD/+at7+4fv9iz2GdXN2qDpUmaOaC2YmwvJ6KA==
X-Received: by 2002:a05:600c:354d:b0:418:f1d7:7029 with SMTP id i13-20020a05600c354d00b00418f1d77029mr713910wmq.6.1713441600519;
        Thu, 18 Apr 2024 05:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnU8PmTVYrjDUGIjLqcCgvjQnviIRRH7CDLJMwLooRGQ1pi28F9NTAUg+fX6jjd6oRIWufJg==
X-Received: by 2002:a05:600c:354d:b0:418:f1d7:7029 with SMTP id i13-20020a05600c354d00b00418f1d77029mr713887wmq.6.1713441600121;
        Thu, 18 Apr 2024 05:00:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id fl7-20020a05600c0b8700b00418ed02cd58sm1387257wmb.3.2024.04.18.04.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:59:59 -0700 (PDT)
Message-ID: <c73423cb-3288-47aa-b389-22566e883db7@redhat.com>
Date: Thu, 18 Apr 2024 13:59:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] mm/memory: add any_dirty optional pointer to
 folio_pte_batch()
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240418105750.98866-1-ioworker0@gmail.com>
 <20240418105750.98866-4-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418105750.98866-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 12:57, Lance Yang wrote:
> This commit adds the any_dirty pointer as an optional parameter to
> folio_pte_batch() function. By using both the any_young and any_dirty pointers,
> madvise_free can make smarter decisions about whether to clear the PTEs when
> marking large folios as lazyfree.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   mm/internal.h | 12 ++++++++++--
>   mm/madvise.c  | 19 ++++++++++++++-----
>   mm/memory.c   |  4 ++--
>   3 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index c6483f73ec13..daa59cef85d7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>    *		  first one is writable.
>    * @any_young: Optional pointer to indicate whether any entry except the
>    *		  first one is young.
> + * @any_dirty: Optional pointer to indicate whether any entry except the
> + *		  first one is dirty.
>    *

I was also wondering if we should make that function return a 
pte+nr_pages, instead of only nr_pages, and then simply have the 
function, based on new flags, merge data into the original PTE.

But let's do that separately.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


