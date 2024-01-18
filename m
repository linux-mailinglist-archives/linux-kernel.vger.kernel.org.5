Return-Path: <linux-kernel+bounces-30070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9018318C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B425E28205B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091324207;
	Thu, 18 Jan 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvCucDr8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23621A12
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578864; cv=none; b=d83hM1ix3bRuKWixz+p6k8Xllzn7RYggrQswpc0d0CgXBj80pZu2yJFWSsL/RGxPE4ZMVQdmZL9QgTiLIJ22bZlT6Qh1TFUetNfsxHAWN31x9JlS6ioyrhRyrJ3osiVurRC0pjZQxHdRK3qMqfVPHiKERCtHEGv79MUHvNJFZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578864; c=relaxed/simple;
	bh=gRbv+Ya+wAtvYVKm40larVj51oStCtuaHpchF+mS1AA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=ECw6nULQ1KHteuZGTT9ORGLgFLl2alCkpBqZ03uDJxyXyO90/ihfOeUDRBXjeLryksFQgciTzb56yGdsnhJA1/3cj/tQ7EoKhIy3hQFtuF7Pzdsvnk1k43Omphgff3toNC06+xApJ4UBdMHRHDZXALJ3tcbR9GMR/yoQf9JOeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvCucDr8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705578862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OHwKzJv3R0m8MySq3Fc2/ItXBRnuqGyox1pUE6Hjkc4=;
	b=CvCucDr8P9jnh7YkwZplxiBptWyvdiioKwIYr3RQel63khCol933R/EjI81P5kl9dwnSLi
	l12Ah3UJbJ2yriFVXDV85LAy4vbTfgMyRGgE0IwHaQehWXb/QP9TM2yCm8gOf8hQuUAyB6
	eh2GFxuTH5eqsfnLN99OrcrELVeKgI4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-gxM6b_ATN3ihQwhgKyNPkw-1; Thu, 18 Jan 2024 06:54:20 -0500
X-MC-Unique: gxM6b_ATN3ihQwhgKyNPkw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e5769e2deso4478435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578859; x=1706183659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHwKzJv3R0m8MySq3Fc2/ItXBRnuqGyox1pUE6Hjkc4=;
        b=NiTtrd+zB1BgY1N+967Mm7+oc32BMdYgdqek53IYVMEU1Fuby5a0SCjN0OTd1bQCQC
         ZAoaVBA7d8U2YxrAso7NgEP0VXp5PHVcjohwSgSnrH32ync0kflkesv2u5UgY9zxxfL4
         2VupTn+o64+6b3xxF1d/n25PxFCJvFzEhYewN/gGPZRUIiCsBizEkuzFdC1B0hXuqVle
         nEbZpko1D1EqvombAX/urM8qfACm7yM6upnJa44jKuMXzrEn1XUkSlhG1tGbnDLC6KnG
         OgUP8SUY+NyORffx6lbR9TnR2LFvDXGcgmyRqtfLIDICgdyMmgV7H5FjZHtIxTuZN1Hg
         dnAg==
X-Gm-Message-State: AOJu0Yy4QOjWEQTL0FXGdJk9ezuw1F8U1UZfOfWuFfQJ0SlImusFt8Zt
	7v1r3o7FZPv7v1BwFdyLNAkiCi03qd9qWH6j9RIWFK81iNZqrxUH7ErtCq2eGvMhd/11FOdMl+S
	EBWQATaah7Ywo14MTE3SqMa7/dyvRIXxCe5icOdbVAjA3BgDJUv4pbYiquo4KFg==
X-Received: by 2002:a05:600c:16c4:b0:40e:4def:3da8 with SMTP id l4-20020a05600c16c400b0040e4def3da8mr245818wmn.217.1705578859681;
        Thu, 18 Jan 2024 03:54:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYIMpEH/QEBKAEbSlwoeGMXRkgus+krFjK0gdOjOuhlMetkfZsaVFItW7eeXXycfhuypdVyw==
X-Received: by 2002:a05:600c:16c4:b0:40e:4def:3da8 with SMTP id l4-20020a05600c16c400b0040e4def3da8mr245809wmn.217.1705578859273;
        Thu, 18 Jan 2024 03:54:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:c100:d899:37c2:8567:acd? (p200300cbc705c100d89937c285670acd.dip0.t-ipconnect.de. [2003:cb:c705:c100:d899:37c2:8567:acd])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d66c8000000b00336e69fbc32sm3855986wrw.102.2024.01.18.03.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:54:18 -0800 (PST)
Message-ID: <58efd8d4-28aa-45d6-b384-7463568b24bb@redhat.com>
Date: Thu, 18 Jan 2024 12:54:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] mm: rmap: weaken the WARN_ON in
 __folio_add_anon_rmap()
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, ryan.roberts@arm.com,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com,
 wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yuzhao@google.com, surenb@google.com,
 steven.price@arm.com, Barry Song <v-songbaohua@oppo.com>,
 Chuanhua Han <hanchuanhua@oppo.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-6-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240118111036.72641-6-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.01.24 12:10, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> In do_swap_page(), while supporting large folio swap-in, we are using the helper
> folio_add_anon_rmap_ptes. This is triggerring a WARN_ON in __folio_add_anon_rmap.
> We can make the warning quiet by two ways
> 1. in do_swap_page, we call folio_add_new_anon_rmap() if we are sure the large
> folio is new allocated one; we call folio_add_anon_rmap_ptes() if we find the
> large folio in swapcache.
> 2. we always call folio_add_anon_rmap_ptes() in do_swap_page but weaken the
> WARN_ON in __folio_add_anon_rmap() by letting the WARN_ON less sensitive.
> 
> Option 2 seems to be better for do_swap_page() as it can use unified code for
> all cases.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chuanhua Han <hanchuanhua@oppo.com>
> ---
>   mm/rmap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f5d43edad529..469fcfd32317 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1304,7 +1304,10 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>   		 * page.
>   		 */
>   		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> -				 level != RMAP_LEVEL_PMD, folio);
> +				 level != RMAP_LEVEL_PMD &&
> +				 (!IS_ALIGNED(address, nr_pages * PAGE_SIZE) ||
> +				 (folio_test_swapcache(folio) && !IS_ALIGNED(folio->index, nr_pages)) ||
> +				 page != &folio->page), folio);
>   		__folio_set_anon(folio, vma, address,
>   				 !!(flags & RMAP_EXCLUSIVE));
>   	} else if (likely(!folio_test_ksm(folio))) {


I have on my todo list to move all that !anon handling out of 
folio_add_anon_rmap_ptes(), and instead make swapin code call add 
folio_add_new_anon_rmap(), where we'll have to pass an exclusive flag 
then (-> whole new folio exclusive).

That's the cleaner approach.

-- 
Cheers,

David / dhildenb


