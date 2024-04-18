Return-Path: <linux-kernel+bounces-150037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DA18A9971
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68891F20FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5152C15F3EA;
	Thu, 18 Apr 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZwm9yvK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092715E5B2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441797; cv=none; b=fjhnUAhh/F8mWr1X9O6M7D7zwiiGz1B4MDfhkj7Mkca5sgwXSZNnY3QDG8gLqefoGssyXSezllq9gHVT8AqM0kK77ewpI8cMCbj0ghTh2NCR8PHdBMlJfMWPZz0++vF9ELkMXlZxSAwGLOycW78XqDuG4cOJxaE+V3aroCni4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441797; c=relaxed/simple;
	bh=dIN5ibiNjDcnglryE6cFy12BvK14wE7Zl5MMUArX634=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8fMAnFhtjXRDt/MUChuPu1Kmdh49PsC+hjoXVDwJrgSIFhAz8NLGYl8jopJHTTG8F3Ur5OGGJ1budfQV3aZacGqujDcFwAdOhvO61Fvy9wgdD1wDqUGFoDl9lfH2p81YNdcrxaTn2cf/EDd76cJdDEMxoYbvDVjGWQO1XUd5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZwm9yvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I52kKdJ22CxR+krHno97zYnQgTsBygWH4VGH+1uFaFI=;
	b=YZwm9yvKYjaeVo82E5USvG67+xDx8UmHFICQEH+ln/bKw6nzeq0eVuz5jVFy6/53DO6RUp
	Nwd3oAYg7W7+PAtsmHMmWxZpEbSih2xvPYijY47UVUKSpMc+SAIyVX4qAXFd/OhJadnjhO
	7Jc/VGpHqeQ1HTpViABVhLZe2/2xVhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-zh5jRtpcMw-hZV6zvOwV0g-1; Thu, 18 Apr 2024 08:03:07 -0400
X-MC-Unique: zh5jRtpcMw-hZV6zvOwV0g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4155db7b58cso4624935e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441787; x=1714046587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I52kKdJ22CxR+krHno97zYnQgTsBygWH4VGH+1uFaFI=;
        b=WCU2957xfMtC/+fL5DJoeiRQG260NBOGknsbcjdfnTJkyKnfiW2K2wDsV+bFGKzDgs
         VvdfA4uZtgGMQnfrEXgyAP7WEjNS0ZlBwBB7jkoqwMYovILjC3ccF4chTjvORUxVEauS
         UHexz6Mk9EQBCNHVLNU7plywmWPAE+LaYY/Ep41Ck+vXLEAbFFOOb4IigYpsYjgYjfe4
         OTOUti05eJoWfNaCShNrmtfsCVwqws3FpKHq4rCm1WorVgi5ZxRhJt8q50KDRCFKPLgu
         jbt2UXHauIpnkGYf7zioSq19tthO51PxfubFousfU73NC9SfeYGl8EppVkaPkoI2Ymty
         ZPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo6ZlnuTB3O0Z1ar3m6AHQeeHTbkRB/Z+pAimwoDPft1LNhGBvRPV56Yun8c7MuQxqbZSGbNl1ZRu+Ltpdbfjy4/P4zl7wtJMnE2bA
X-Gm-Message-State: AOJu0Yz7/+7rMWlUZwxdPs5brkwfWTweuCsnh6Q9yr09hrDqhitdgAwz
	SGPX28c9sj3Jjgjo8PEMArARVBl8P8TBBbisABO0fTNdxYAW3Dv/3M6zE6NfMfjFz7Z6EUq4Ce9
	ZQgfwsPRLO7YPPCY3vUnZ6ZC0x+iTut3ebd1N4j8Z6NuD7yTnkLM5tNOMlCV0UA==
X-Received: by 2002:a05:600c:1f0d:b0:418:ec8b:9e1b with SMTP id bd13-20020a05600c1f0d00b00418ec8b9e1bmr893488wmb.12.1713441786832;
        Thu, 18 Apr 2024 05:03:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM+23vZOkZtXhsHoLXjILiVzlIplixD0h7ofkJC1brany6nwU+i0zSK4p/1Snv51JwgGlL/Q==
X-Received: by 2002:a05:600c:1f0d:b0:418:ec8b:9e1b with SMTP id bd13-20020a05600c1f0d00b00418ec8b9e1bmr893473wmb.12.1713441786374;
        Thu, 18 Apr 2024 05:03:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm6350910wmq.4.2024.04.18.05.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 05:03:05 -0700 (PDT)
Message-ID: <2fdcee93-b8ad-4374-a8ab-7c7bed463813@redhat.com>
Date: Thu, 18 Apr 2024 14:03:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] mm/madvise: optimize lazyfreeing with mTHP in
 madvise_free
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240418105750.98866-1-ioworker0@gmail.com>
 <20240418105750.98866-5-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418105750.98866-5-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 12:57, Lance Yang wrote:
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
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   mm/madvise.c | 85 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4597a3568e7e..375ab3234603 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -643,6 +643,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   				unsigned long end, struct mm_walk *walk)
>   
>   {
> +	const cydp_t cydp_flags = CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY;
>   	struct mmu_gather *tlb = walk->private;
>   	struct mm_struct *mm = tlb->mm;
>   	struct vm_area_struct *vma = walk->vma;
> @@ -697,44 +698,57 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   			continue;
>   
>   		/*
> -		 * If pmd isn't transhuge but the folio is large and
> -		 * is owned by only this process, split it and
> -		 * deactivate all pages.
> +		 * If we encounter a large folio, only split it if it is not
> +		 * fully mapped within the range we are operating on. Otherwise
> +		 * leave it as is so that it can be marked as lazyfree. If we
> +		 * fail to split a folio, leave it in place and advance to the
> +		 * next pte in the range.
>   		 */
>   		if (folio_test_large(folio)) {
> -			int err;
> +			bool any_young, any_dirty;
>   
> -			if (folio_likely_mapped_shared(folio))
> -				break;
> -			if (!folio_trylock(folio))
> -				break;
> -			folio_get(folio);
> -			arch_leave_lazy_mmu_mode();
> -			pte_unmap_unlock(start_pte, ptl);
> -			start_pte = NULL;
> -			err = split_folio(folio);
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			if (err)
> -				break;
> -			start_pte = pte =
> -				pte_offset_map_lock(mm, pmd, addr, &ptl);
> -			if (!start_pte)
> -				break;
> -			arch_enter_lazy_mmu_mode();
> -			pte--;
> -			addr -= PAGE_SIZE;
> -			continue;
> +			nr = madvise_folio_pte_batch(addr, end, folio, pte,
> +						     ptent, &any_young, NULL);
> +
> +			if (nr < folio_nr_pages(folio)) {
> +				int err;
> +
> +				if (folio_likely_mapped_shared(folio))
> +					continue;
> +				if (!folio_trylock(folio))
> +					continue;
> +				folio_get(folio);
> +				arch_leave_lazy_mmu_mode();
> +				pte_unmap_unlock(start_pte, ptl);
> +				start_pte = NULL;
> +				err = split_folio(folio);
> +				folio_unlock(folio);
> +				folio_put(folio);
> +				start_pte = pte =
> +					pte_offset_map_lock(mm, pmd, addr, &ptl);

I'd just put it on a single line.

> +				if (!start_pte)
> +					break;
> +				arch_enter_lazy_mmu_mode();
> +				if (!err)
> +					nr = 0;
> +				continue;
> +			}
> +
> +			if (any_young)
> +				ptent = pte_mkyoung(ptent);
> +			if (any_dirty)

any_dirty is never set, likely missed to pass it to 
madvise_folio_pte_batch().

Apart from that LGTM and this patch is much easier to review now!


With above:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


