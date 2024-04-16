Return-Path: <linux-kernel+bounces-146482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D613F8A65D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF161F242FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E41136E2B;
	Tue, 16 Apr 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHJ0kJh9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F28665B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255272; cv=none; b=VPvzUtNNw93UHH5e4fpsqbbhvgTjKHLRagIe7ml8C+JoBQhCVIlEM3rJjI6iaN1Bxko/f208URkxA14f2fDRuDOTdfAGiMbYzjSzMEWB2Tpj3vGyxIJwYCvflOApkasA1m6c1t2eXP/D4RJz1sXrMcaJvLbYe3yC1ihpxqAchLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255272; c=relaxed/simple;
	bh=kctLRBMK3Qz2HtPiP0W//k9unCHHpbdKfjpv63DN7Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI0nXO74UYts9rO48kh5UzuGYh0uJ4hO7fh7HeaNeu8IF1Ww3X8XBBQeAxUPPUebuWNJWMSyjV3smwgA5l2K3kxpRrrL6EB8+NzU1IM5MALF/CdeSL7m69rBcH3uJCyZWvxZ0l7K2qFd/eFM3+t7afcZ/Af++e1Xbbggryoo7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHJ0kJh9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V8Q+pndAsQQAY0qNWKgXv1w760BOqZhw5UdE5L9yztg=;
	b=GHJ0kJh9eQ84zWI1ML/EMMEsanLlGR+utCl2fU3xmY6qXim9g4jOi9zoKOMOQIcNgBDe+K
	FFoTzZi3CTfl/dCSM0l5LrqTQk4nBYXzdfsC6hny26+dPyiW+C7pd3FsqtBR3HvE9qERF4
	wGn8vpx+Z3FtfN+zMp9o3wS3m9em4t0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-xLMXLgJ4Or-MDowu-x8KdQ-1; Tue, 16 Apr 2024 04:14:21 -0400
X-MC-Unique: xLMXLgJ4Or-MDowu-x8KdQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-347f92ab882so807214f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255260; x=1713860060;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V8Q+pndAsQQAY0qNWKgXv1w760BOqZhw5UdE5L9yztg=;
        b=Lhwy00HMMQXebWevqm2WTfzwF8M12Nsg+7QEs2lKprDerH9st3Hj9Kg4Mp62EeSXZ7
         9nAbcYnIQrZVIwrcJiXb+vi8c0b6iGRHe/QFGQP6/BQa+9XjEtC/jC+Ny3T7p1eJvByu
         mBYjgdx3VNFEFRy8wrmnWgEougvbhNpMSL8Poy0n67ouaccIu/iLLHMHMeWsWC24/Hr2
         AlVmTyZMCFpK1BcbuvcBKcEjBPfBTVqrKmg+pK07oQahymHjKaXNZpE/H7f+XwdJhULA
         8z/bnShBjq/NevT5VFZRGsujViCFZCdgut9mteq6L3V4dSo1HRsQpbqKFRBQJiHGs2eC
         xvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt7IEdrk6XFx3sBD+aH0vA/CUTD6I0Uj7DgWg0lxEptu+EcT8uOsXexr8BlwmIp48Ka+N1s18IuTMmDyo8kWwUWQnLvLGRkCYdeJB2
X-Gm-Message-State: AOJu0YxsQSiSUaS1G8dIrL4U9bQoEJfTuw32MR2dqELRzczEZXy80iEH
	UQJrj/SIe7S1hO9r2sp6zp5YFoPhuZ4RVUN3hyWt0U40w1Axrq7WvCyeyAK9kw7j0gDiCmSdzEd
	IMW+vIxaV8WH3g12txRUL/TA6aLBx1vTXFEbqDCBm75NgiLd0DzB/Q9q9odaoxg==
X-Received: by 2002:a5d:6882:0:b0:343:8455:58d6 with SMTP id h2-20020a5d6882000000b00343845558d6mr7104427wru.26.1713255259965;
        Tue, 16 Apr 2024 01:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnkbs5EvtTmxZkrS/4r5n1ltnckSJxu5QdYjOIVWZ+Pfiraruo2wLkYjGcdZiJD9Ht/wS5eg==
X-Received: by 2002:a5d:6882:0:b0:343:8455:58d6 with SMTP id h2-20020a5d6882000000b00343845558d6mr7104418wru.26.1713255259539;
        Tue, 16 Apr 2024 01:14:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb46000000b00346cdf48262sm13411210wrs.2.2024.04.16.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 01:14:19 -0700 (PDT)
Message-ID: <fba4f0cb-6d18-4d7c-8b2e-3300be1c20e3@redhat.com>
Date: Tue, 16 Apr 2024 10:14:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] mm: add per-order mTHP anon_swpout and
 anon_swpout_fallback counters
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com,
 linux-kernel@vger.kernel.org, peterx@redhat.com, ryan.roberts@arm.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 yosryahmed@google.com, yuzhao@google.com, corbet@lwn.net
References: <20240412114858.407208-1-21cnbao@gmail.com>
 <20240412114858.407208-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240412114858.407208-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 13:48, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This helps to display the fragmentation situation of the swapfile, knowing
> the proportion of how much we haven't split large folios.  So far, we only
> support non-split swapout for anon memory, with the possibility of
> expanding to shmem in the future.  So, we add the "anon" prefix to the
> counter names.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>   include/linux/huge_mm.h | 2 ++
>   mm/huge_memory.c        | 4 ++++
>   mm/page_io.c            | 1 +
>   mm/vmscan.c             | 3 +++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index d4fdb2641070..7cd07b83a3d0 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -268,6 +268,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_ANON_SWPOUT,
> +	MTHP_STAT_ANON_SWPOUT_FALLBACK,
>   	__MTHP_STAT_COUNT
>   };
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index dfc38cc83a04..58f2c4745d80 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -555,11 +555,15 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> +DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
>   
>   static struct attribute *stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
>   	&anon_fault_fallback_attr.attr,
>   	&anon_fault_fallback_charge_attr.attr,
> +	&anon_swpout_attr.attr,
> +	&anon_swpout_fallback_attr.attr,
>   	NULL,
>   };
>   
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a9a7c236aecc..46c603dddf04 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -217,6 +217,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
>   		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>   		count_vm_event(THP_SWPOUT);
>   	}
> +	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
>   #endif
>   	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>   }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bca2d9981c95..49bd94423961 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1231,6 +1231,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   						goto activate_locked;
>   				}
>   				if (!add_to_swap(folio)) {
> +					int __maybe_unused order = folio_order(folio);
> +
>   					if (!folio_test_large(folio))
>   						goto activate_locked_split;
>   					/* Fallback to swap normal pages */
> @@ -1242,6 +1244,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   							THP_SWPOUT_FALLBACK, 1);
>   						count_vm_event(THP_SWPOUT_FALLBACK);
>   					}
> +					count_mthp_stat(order, MTHP_STAT_ANON_SWPOUT_FALLBACK);

Why the temporary variable for order?

count_mthp_stat(folio_order(order),
                 MTHP_STAT_ANON_SWPOUT_FALLBACK);

.. but now I do wonder if we want to pass the folio to count_mthp_stat() ?

Anyhow

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


