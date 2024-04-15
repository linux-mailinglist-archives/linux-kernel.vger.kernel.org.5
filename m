Return-Path: <linux-kernel+bounces-144684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B948A4930
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6291F2177B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909024B2A;
	Mon, 15 Apr 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQKfcJw2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2520DD3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166693; cv=none; b=Oj5y4fELRSmYhTW8HEJaU+r8dI9lNJ7EZVKtYr569K0HLp5s1lZ1SVCakxH4PiXBH2jhqOpq8H5iG5MhYPezpphWZfLJFwUdMtb77IE+YZ+tOxCRKjViUuFr6h45Ud0UqeN8WdbXAWggyKN/PNCQ+9fyh7Rb98Sbx1dILZ4jl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166693; c=relaxed/simple;
	bh=QOHoOrrzM/7hqcpJV8DAayBXA1XOlEqJnq2DqdjW8pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3hZhp3+0gWQDVfYyZxJg4nXHE6EMLikTOZ6HzzFBn9LHLV+5o6AgVRA6Yw8pK9JTmmb5DK8CyhMewOJ+llJD7hX6wGQkl/5pSE9C7yUGBrxHRjB+oWHBTAE+V7AvdGDB1QeIP86HchrtmAS3n0giMTtw16Jyn7XLsY6JPEzFi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQKfcJw2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713166690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WoQHMmhnMBLWNP7V4ndFchCm/FDy6+UPtMgS61XLZNg=;
	b=KQKfcJw2CRgA0MNuGr1OYxcG54MYw4XJMGQBll7oUUp7oLDVqj2/9hsdRQSxVNq6KJAot+
	qHPb+ngZOFQg3nAJmeOivhd5D7Grbu3PQawXbcxCzXdCdXu7/qJ43+UEB0Wu51TH/Xj2gK
	BLSdbnkWlIJ6bA6RukfhpzI8A4/LSmg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-VbLQ9YwNP0CG4tvIiANyEw-1; Mon, 15 Apr 2024 03:37:59 -0400
X-MC-Unique: VbLQ9YwNP0CG4tvIiANyEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416a844695dso13645925e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166678; x=1713771478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WoQHMmhnMBLWNP7V4ndFchCm/FDy6+UPtMgS61XLZNg=;
        b=hVbW6VAaUEMG3oC5PHsL+BtyMFuUD55g2eCvBztRmxquNXgcVN+J11AYKn8KDPIvYy
         fnsE6/PIJoOU+8xZceGTzEguJp3wVniiHk3BmEqY7B24ETL2CZXKKZxRX1xmoy/9bJxl
         rl5dnjDmLHPmgb4UEuVZnCk8/IPxUUosGl5p94z2ch3ahZN1uKbhv1/Jpq6/W1mEfT5y
         LEg9g3eRGzcCZmgmquba3TzCeVaJNBFMQdMWe/qjvWL5hDFFNw+QGm7UUV0EU5utaj+z
         P5voo0QlBXH2Rbc1xiQDkemalpC8BeKxGWe+OA15sYBxaNEtvEXgW780Dn8jpjCu+Cvf
         7VzA==
X-Forwarded-Encrypted: i=1; AJvYcCX250HfEXJjEPzjaovu7cHaNBB6ZQJbk8pnhWkhyYWDkgWJwzGNH5xdgAVDI1Dp0s5hdPT52WHKfC9D5WSQAW6XYHMc7S8M5704/WzW
X-Gm-Message-State: AOJu0YycCZc06qWHvF/p6llm10/NkTDcbX/1jNFF4IIfEow0RziOlSss
	6mFPNQ+2beASEjoQNwYrPV1LuXwSIY4GmFhxdyYHdR423qWd+Z7Tnk/3F/LY9SHe6aAcAUBbKux
	nwnZRnx5C60rPUqc68VpTaV1bJFn4yJiA97waZSUO9VCvh2vo39tbgyD1GTGCnQ==
X-Received: by 2002:a05:600c:4e91:b0:418:5ac:39cf with SMTP id f17-20020a05600c4e9100b0041805ac39cfmr6753836wmq.35.1713166678433;
        Mon, 15 Apr 2024 00:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7jZcJuC+6ooiHyFg7iVx4nCPuUVVOX4mAWXBrJhsop9nJwDZSwTTuybMYdpJMpZXSGdl/Mw==
X-Received: by 2002:a05:600c:4e91:b0:418:5ac:39cf with SMTP id f17-20020a05600c4e9100b0041805ac39cfmr6753815wmq.35.1713166678065;
        Mon, 15 Apr 2024 00:37:58 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6f66.dip0.t-ipconnect.de. [91.12.111.102])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0041665d968f1sm14949544wmg.47.2024.04.15.00.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 00:37:57 -0700 (PDT)
Message-ID: <d38a4edf-1a07-4aa5-a2c1-e3b6c7865b4e@redhat.com>
Date: Mon, 15 Apr 2024 09:37:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] userfaultfd: remove WRITE_ONCE when setting
 folio->index during UFFDIO_MOVE
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, peterx@redhat.com, lokeshgidra@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240415020821.1152951-1-surenb@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240415020821.1152951-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 04:08, Suren Baghdasaryan wrote:
> When folio is moved with UFFDIO_MOVE it gets locked before the rmap and
> index are modified. Due to the folio lock being already held, WRITE_ONCE()
> is not needed when setting the folio index. Remove it.
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> ---
>   mm/huge_memory.c | 2 +-
>   mm/userfaultfd.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 58f2c4745d80..ee12726291f1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2200,7 +2200,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>   		}
>   
>   		folio_move_anon_rmap(src_folio, dst_vma);
> -		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +		src_folio->index = linear_page_index(dst_vma, dst_addr);
>   
>   		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
>   		/* Follow mremap() behavior and treat the entry dirty after the move */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index b70618e8dcd2..575ccf90325a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1026,7 +1026,7 @@ static int move_present_pte(struct mm_struct *mm,
>   	}
>   
>   	folio_move_anon_rmap(src_folio, dst_vma);
> -	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +	src_folio->index = linear_page_index(dst_vma, dst_addr);
>   
>   	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>   	/* Follow mremap() behavior and treat the entry dirty after the move */
> 
> base-commit: 3aec6b2b34e219898883d1e9ea7e911b4d3762a9

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


