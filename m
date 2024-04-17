Return-Path: <linux-kernel+bounces-148970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AACC8A89D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140471F217BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD3171666;
	Wed, 17 Apr 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTnyJ2/6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01121411CF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373557; cv=none; b=Yw3u5n8uEtIPJkvkST+ZOenHvJcB+HG6xPsJ5ETq+ESB9kHbXxC2rRcb2f/EBqO5ORA+wo6pZM8iHlr+hjG3PG5gSz6vPY2lWyqFHTbCId5BClr9Krbap4ymNkdblU2Rq+UkWUnAAW43vXxM7vK4WEZswyPXtqdM0V6goFEQoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373557; c=relaxed/simple;
	bh=Ac+/jOoPhZW4eMh9PQibzAsT2JDJYYkdkAzJUsa7Q14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvY/WuLBhm3x/v4Wjj+1pb1KYs3AB/uyBdRhOY7mKw6hrBpwAZre4VUHOvOJSydN6gfPHs0DLmp/tqrdJ/JnIqvOthMl/Th1OvuQr1NRNdEvxFOhnn94CmZnAn5ObspsG9TCGI0jr2VuYph9+aP+tBO3MalY1eT8dEtBT9kunQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTnyJ2/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713373554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ncf1XoHGI+ylvBcF2Dm0xfBNX/SOu6WyAZGaChqXuW4=;
	b=DTnyJ2/6HV7egM3cRzSeOE6TPWSbfLhtd8SbMxYxPHciY+Glxd8+4Hm38j9Fln2gajpy/n
	do8isgnHGIx8ggVjG+Q7TMJEF2ajsj8MxBI4r+MYdH3NRVNYEKtWKnd8P9WNbamT0M+VvD
	SfHNtPpozvjYF455sjppjqn16mo7Nvs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-a5DaWzbKOAyGT5QIb8LMcQ-1; Wed, 17 Apr 2024 13:05:53 -0400
X-MC-Unique: a5DaWzbKOAyGT5QIb8LMcQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d883dab079so55311011fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373551; x=1713978351;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ncf1XoHGI+ylvBcF2Dm0xfBNX/SOu6WyAZGaChqXuW4=;
        b=F2jquPZt0cg58nhMQWAOg/fURCsZrhYv5F9+wlozp2buFL20G6vfQhB8aTSJf6uC44
         Qw+3d4uanTQ5dssOVl6AIzy8/8IeSJb+1xJi0Ngl5fGjWCx+zE/jLoPVSi21tj6zJVoS
         8ml3j+n6BAVYWcP++UcnnyZuRA8GJujph9p7X2i3H4YJnrZftL9OtD4zeVJjHatoJA8V
         MmsI5jFUzDlsilZPajRvLP49QMGcEtLrN3hvIOA/melB0bJ1YJU1ltws6CKOkFq3NfGO
         SsxAkb9y0EkMC5T3KL9JvUirCI2HvTARbXtGRcKljF4nQRL06eby9l4i7Smtt5BQ2JTj
         uGdg==
X-Forwarded-Encrypted: i=1; AJvYcCUepLO4LCZIOqlTU1O44PIQQtCkpyPJD8yJFaEdC4DYcq9i8uzfc/mdPJBEE31XdRSyeGpS6AfrB725yLBZ2XqsnMkAhg19GPYUBuIy
X-Gm-Message-State: AOJu0YwQZ8nWvodu+4dAqphSYWSnGT+Nqq2gAVxbQjTOBy0I8l83YjcT
	68oRDJbCEiZz1xByngXbTygTmwITRFPgyeHo8qXazD4wfNaUZV6jhtjshIpfyOyST6gzkyQHLlJ
	HgyPm7Z1oaT4YqO5ZnNHPqf3/EMSf8/9oMvojZax+QxMew1rBLYRbRTFLCBVfuA==
X-Received: by 2002:a2e:9ed0:0:b0:2d8:a969:5e1 with SMTP id h16-20020a2e9ed0000000b002d8a96905e1mr13673049ljk.10.1713373551649;
        Wed, 17 Apr 2024 10:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRy9o5eTm24d+hd7S116fYIqHCMb9GGG16z/LgSpk9YhjQpeoo2xCT/6xyuWC6eXEYKWNz7Q==
X-Received: by 2002:a2e:9ed0:0:b0:2d8:a969:5e1 with SMTP id h16-20020a2e9ed0000000b002d8a96905e1mr13673016ljk.10.1713373551087;
        Wed, 17 Apr 2024 10:05:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:2300:653:c844:4858:570f? (p200300cbc74523000653c8444858570f.dip0.t-ipconnect.de. [2003:cb:c745:2300:653:c844:4858:570f])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b00418a02674edsm3469787wmg.38.2024.04.17.10.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 10:05:50 -0700 (PDT)
Message-ID: <cd659e3e-dbe4-4168-8162-64bc02f9cba7@redhat.com>
Date: Wed, 17 Apr 2024 19:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240417141436.77963-1-ioworker0@gmail.com>
 <20240417141436.77963-4-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240417141436.77963-4-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.04.24 16:14, Lance Yang wrote:
> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
> splitting if the large folio is fully mapped within the target range.
> 
> If a large folio is locked or shared, or if we fail to split it, we just
> leave it in place and advance to the next PTE in the range. But note that
> the behavior is changed; previously, any failure of this sort would cause
> the entire operation to give up. As large folios become more common,
> sticking to the old way could result in wasted opportunities.
> 
> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
> the same size results in the following runtimes for madvise(MADV_FREE) in
> seconds (shorter is better):
> 
> Folio Size |   Old    |   New    | Change
> ------------------------------------------
>        4KiB | 0.590251 | 0.590259 |    0%
>       16KiB | 2.990447 | 0.185655 |  -94%
>       32KiB | 2.547831 | 0.104870 |  -95%
>       64KiB | 2.457796 | 0.052812 |  -97%
>      128KiB | 2.281034 | 0.032777 |  -99%
>      256KiB | 2.230387 | 0.017496 |  -99%
>      512KiB | 2.189106 | 0.010781 |  -99%
>     1024KiB | 2.183949 | 0.007753 |  -99%
>     2048KiB | 0.002799 | 0.002804 |    0%
> 
> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com
> 
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

Some of the changes could have been moved into separate patches to ease 
review ;)

At least the folio_pte_batch() change and factoring out some stuff from 
madvise_cold_or_pageout_pte_range(). But see below on the latter.

> ---
>   mm/internal.h |  12 ++++-
>   mm/madvise.c  | 141 ++++++++++++++++++++++++++++----------------------
>   mm/memory.c   |   4 +-
>   3 files changed, 91 insertions(+), 66 deletions(-)

[...]

> diff --git a/mm/madvise.c b/mm/madvise.c
> index f5e3699e7b54..d6f1889d6308 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
>   	       file_permission(vma->vm_file, MAY_WRITE) == 0;
>   }
>   
> +static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
> +					  struct folio *folio, pte_t *ptep,
> +					  pte_t pte, bool *any_young,
> +					  bool *any_dirty)
> +{
> +	int max_nr = (end - addr) / PAGE_SIZE;
> +	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;

Reverse Christmas tree looks nicer ;)

> +
> +	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
> +			       any_young, any_dirty);
> +}
> +
> +static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t *pmd,
> +					   unsigned long addr,
> +					   struct folio *folio, pte_t **pte,
> +					   spinlock_t **ptl)
> +{
> +	int err;
> +
> +	if (!folio_trylock(folio))
> +		return false;
> +
> +	folio_get(folio);
> +	pte_unmap_unlock(*pte, *ptl);
> +	err = split_folio(folio);
> +	folio_unlock(folio);
> +	folio_put(folio);
> +
> +	*pte = pte_offset_map_lock(mm, pmd, addr, ptl);

Staring at this helper again, I am really not sure if we should have it. 
Calling semantics are "special" and that pte_t **pte is just ... 
"special" as well ;)

Can we just leave that part as is, in the caller? That would also mean 
less madvise_cold_or_pageout_pte_range() churn ... which i would welcome 
as part of this patch.

[...]

> @@ -741,19 +767,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   		}
>   
>   		if (pte_young(ptent) || pte_dirty(ptent)) {
> -			/*
> -			 * Some of architecture(ex, PPC) don't update TLB
> -			 * with set_pte_at and tlb_remove_tlb_entry so for
> -			 * the portability, remap the pte with old|clean
> -			 * after pte clearing.
> -			 */
> -			ptent = ptep_get_and_clear_full(mm, addr, pte,
> -							tlb->fullmm);
> -
> -			ptent = pte_mkold(ptent);
> -			ptent = pte_mkclean(ptent);
> -			set_pte_at(mm, addr, pte, ptent);
> -			tlb_remove_tlb_entry(tlb, pte, addr);
> +			clear_young_dirty_ptes(vma, addr, pte, nr,
> +					       CYDP_CLEAR_YOUNG |
> +						       CYDP_CLEAR_DIRTY);

That indent looks odd. I suggest simply having a local variable

const cydp_t cydp_flags = CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;

and then use cydp_flags here that will make this easier to read.

-- 
Cheers,

David / dhildenb


