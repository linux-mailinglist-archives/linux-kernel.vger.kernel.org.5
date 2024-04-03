Return-Path: <linux-kernel+bounces-129188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578568966B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C554288AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B660B91;
	Wed,  3 Apr 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfzXaEF0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839F66024A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129831; cv=none; b=Ut5GM6+U0CaYJ1IhLqTX7VUXpiXS9yXryA+qBm9tTwmwexW9HuVCCJNSUsERt0dGb2KGE8U5jHVbtSrrKJk1r+3m/9aDTHjAwLGBGfJzrhZimcAZhx8w3+UoL+CYnGUYUsA0AVEhfs9LHy+hcgkqI+klHziafeg8t+C6alG97XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129831; c=relaxed/simple;
	bh=CE0VL9Izi6gXHjWfnujW8Xr2jCxJZpbDcyw3Ly2XWco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2qEzMgm8akjz1BAs6JiAefzJ0x+/GEzs4Hkcd7dmbnhLMCvzChDwO1p/AKy9uya57AmcqTonOgZs1DPKlyllAGc7yeGYqZKmZrL6GbxCo5AxiLLw3d5hqHHrOkM3ItqjYupn3HEnI5i6IvdK3E267KrmVp+Cq9FOSQjd6D3jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfzXaEF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712129828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w4H/7PTpVluRbGhrJ4lzqUkOKl5myFD/THvmhB/V1hw=;
	b=AfzXaEF0Pm3bZs14NslntWar+SN158TdKkOyjS/sa4wL7GeUjtWne614X/S9wfOlcnHgpt
	Gr5z1RUUI2cWvtZTY2/mlI8AsygatU9gtazyecWB1ERKzeXYhLSR7m8pWwJ0ZpinjdhUto
	lEyGzvDpm9lEgi2GWmcwYVNvPg0lPIA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-a5V-xEbKO_iQ8jtPBtyntQ-1; Wed, 03 Apr 2024 03:37:07 -0400
X-MC-Unique: a5V-xEbKO_iQ8jtPBtyntQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6c8f170e2so60645731fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129825; x=1712734625;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4H/7PTpVluRbGhrJ4lzqUkOKl5myFD/THvmhB/V1hw=;
        b=Mlq5FtSnHOPgk+d2WkMyeRx1TRJqRbM3skx8jGn+DIJnzWnRZTWGuU89o8MF55y+DR
         AarlO0oG+anvD8Aw7Atp9QbcWR6AHO/lLyXhxvIv+q266C402piO0kV0Cm4GThE4e2mG
         foPJ1hmM/fX6KevvO4Hu/BBtLIEnQ3JXIfnivdoYmO41RARgNBE7zFNUmU88CF71Q4F+
         /0nAf9453O/PJnw0YIDKPmPR2V1+3qJkz7WlrXfwTY+Jieh4Ei2d3p4wdf3+8nHwmn8N
         ctrkkuUuUJLsyWuNHs88u4kj7jSw7/QOseHwlNIX8Yn6DlR5kwwuQ4OC1p1l8qF7rZny
         ZZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1w8Ar0p8+p5ExTQbCZ8gV4rX8GXV+jqbW8sIPtR2CfaSnGxNv0rVTl9kO3AyPa3SWIUBePh46UWHd/YWRFJ0YKYgtFfZviSNTvA9N
X-Gm-Message-State: AOJu0YzLE0azQO6E/WQPbKHybaYI4chf67xzCSWGV8lRP2PH1rvI83cP
	57km8Jv1q8zEkka35NiLQKz1m0+bJt/XTt9+gsFtKeVrBl0X93HyIHskX76Tr/625chJlcs64sf
	8UENePrgbmT6Fa7L3QdA9g+U4+abxRr7C5tA+uDEa4twAlX3ZStwuGBxbCJ5Rhg==
X-Received: by 2002:a05:651c:1a2b:b0:2d5:acde:9065 with SMTP id by43-20020a05651c1a2b00b002d5acde9065mr3845146ljb.34.1712129825677;
        Wed, 03 Apr 2024 00:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDZK/qA/swT61E1AzbzZ+24tkA3tA4M50V7IcLvXd8FeOipwqAgDuTxu966P3EmoN9uijlzA==
X-Received: by 2002:a05:651c:1a2b:b0:2d5:acde:9065 with SMTP id by43-20020a05651c1a2b00b002d5acde9065mr3845115ljb.34.1712129825163;
        Wed, 03 Apr 2024 00:37:05 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23870.dip0.t-ipconnect.de. [79.242.56.112])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004161c690b80sm4207136wmb.13.2024.04.03.00.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:37:04 -0700 (PDT)
Message-ID: <57f238d0-632a-4bc9-8d82-fbf1c51c14ff@redhat.com>
Date: Wed, 3 Apr 2024 09:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: Allow anon exclusive check over hugetlb tail
 pages
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, WANG Xuerui <kernel@xen0n.name>,
 Ryan Roberts <ryan.roberts@arm.com>, loongarch@lists.linux.dev
References: <20240403013249.1418299-1-peterx@redhat.com>
 <20240403013249.1418299-2-peterx@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403013249.1418299-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 03:32, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> PageAnonExclusive() used to forbid tail pages for hugetlbfs, as that used
> to be called mostly in hugetlb specific paths and the head page was
> guaranteed.
> 
> As we move forward towards merging hugetlb paths into generic mm, we may
> start to pass in tail hugetlb pages (when with cont-pte/cont-pmd huge
> pages) for such check.  Allow it to properly fetch the head, in which case
> the anon-exclusiveness of the head will always represents the tail page.
> 
> There's already a sign of it when we look at the fast-gup which already

"GUP-fast" ;)

> contain the hugetlb processing altogether: we used to have a specific
> commit 5805192c7b72 ("mm/gup: handle cont-PTE hugetlb pages correctly in
> gup_must_unshare() via GUP-fast") covering that area.  Now with this more
> generic change, that can also go away.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/linux/page-flags.h |  8 +++++++-
>   mm/internal.h              | 10 ----------
>   2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 888353c209c0..225357f48a79 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1095,7 +1095,13 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
>   static __always_inline int PageAnonExclusive(const struct page *page)
>   {
>   	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
> -	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
> +	/*
> +	 * Allow the anon-exclusive check to work on hugetlb tail pages.
> +	 * Here hugetlb pages will always guarantee the anon-exclusiveness
> +	 * of the head page represents the tail pages.
> +	 */
> +	if (PageHuge(page) && !PageHead(page))
> +		page = compound_head(page);
>   	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
>   }
>   
> diff --git a/mm/internal.h b/mm/internal.h
> index 9512de7398d5..87f6e4fd56a5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1259,16 +1259,6 @@ static inline bool gup_must_unshare(struct vm_area_struct *vma,
>   	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
>   		smp_rmb();
>   
> -	/*
> -	 * During GUP-fast we might not get called on the head page for a
> -	 * hugetlb page that is mapped using cont-PTE, because GUP-fast does
> -	 * not work with the abstracted hugetlb PTEs that always point at the
> -	 * head page. For hugetlb, PageAnonExclusive only applies on the head
> -	 * page (as it cannot be partially COW-shared), so lookup the head page.
> -	 */
> -	if (unlikely(!PageHead(page) && PageHuge(page)))
> -		page = compound_head(page);
> -
>   	/*
>   	 * Note that PageKsm() pages cannot be exclusive, and consequently,
>   	 * cannot get pinned.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


