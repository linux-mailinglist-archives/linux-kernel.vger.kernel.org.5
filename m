Return-Path: <linux-kernel+bounces-132087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C505C898F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89151C21B75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61022131BDB;
	Thu,  4 Apr 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4WYad8F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE25208C7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712261835; cv=none; b=nynyI+lLW1S2jfom/PcSOTsoK8+FEQSx+h+aLfstrFXc+EBijsEIhpjqGmrvHG8Dv22LCT8h0dhPo4ELGGcV3DywGOunJpNynTelTCpIH98zpm1Z3dagcgA30QiUs7vp72uQzDmDJC/zooX4Svxhi7ft6Q6jMHgff1s2lO3G5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712261835; c=relaxed/simple;
	bh=l4i1VfXXyF/9sgpFDR8Lfgl7mujfGTrqloEP+jFrhF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUWqIN0bsqmWocq+QhpdB1h+UbpoWKl7NA0YzK9VJnK4MTRGOkatxmy00zsZLo7MLmLTH5DJy/lP2lLqekfPOHwSw8891hvGTbGXWPQAkGkWhaqqnnaM1vKJom2Up6TjTuD6qhJxD4RWia6gcIn5PPbx9pekLje3yrdipYXbfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4WYad8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712261832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AlD3+JRTqK3YMA8PO9wM93sJuRW5Ur0nUu1cAUIAyjs=;
	b=b4WYad8Fu8u+vKsevRtps/uAlu+Uw3AR5KkSMxD38bQbkBN+daxgRSSksEDThXTWVM6bcJ
	3g4EA6X6bS9qUKuFzHKzt2w+a7mZ4c302iTXTJ/bR9adJbJ5fc591w1F+hlcS5gI2pCv5c
	4EJh9ngqfQyQ/jk2V4tM0s4lJR8XRh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-5Z0Z6VHrM4uB77F7lzmJ9w-1; Thu, 04 Apr 2024 16:17:11 -0400
X-MC-Unique: 5Z0Z6VHrM4uB77F7lzmJ9w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-414908c5403so6849045e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712261830; x=1712866630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlD3+JRTqK3YMA8PO9wM93sJuRW5Ur0nUu1cAUIAyjs=;
        b=Tx5ZhjVMSsyFwOv6XEmyTNO9ECeCfPSzRIpUYGS6HSLUHbUw3clrGzZTt6gFsqHqMb
         KpW55LB5vvd1xY+IGwyXo+qudiG37vWlSd1Li6DwSMjNY1pnNLwDw/R2zFvDmJbIoGfm
         SFpNHhdjBBit73DHLy/JFLkPrfOUDe3cBVdQKpTIJq+yvthYTwyH45E1DwlAaar1aSXO
         5VRxCqwwVRZxx+L+hvNVQx7IfzttXoFtejdutze48y4R23zSIKziuVYc5TFFhPuSpw83
         HaGK0ink5wWggV1mYBxIOFVegg9K5WpWNIiOBB0DDSL1Af2ZEXK/XJRJLpBq3YNl+Op+
         RbJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5gfYervgU6TDGzGazsk1XHWJn/74CxXHuKEIV1U7d6ho81TTSGODnL73n6pkU05YlDJiaR4ANTBlojecOVEvTL9LpBQhYARmS1eId
X-Gm-Message-State: AOJu0YzjI4gO4/LuP5cBvHbmodUsBNr28/P3zA3GSN26Qzq2DRVxj9Cq
	PhZuSzQqptlGvfGqs8xg4273zXkDoRKnpQrks5Y68ACCMXJO8z7B8F6b33da8fUXmbq1F4vDRA9
	YQUOAkD2tSEC8SmfsjBtOkDc1fVX0/MwDxZjEPIKa7oVV+tjyzMYnCusBD9jZIw==
X-Received: by 2002:a05:600c:3388:b0:415:6aee:2986 with SMTP id o8-20020a05600c338800b004156aee2986mr2769226wmp.12.1712261830309;
        Thu, 04 Apr 2024 13:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7GBhRLikK8B04HjnemNtEVBlY/0Zl3K/6P6jo1Ex7Oo1hl1jXDnzMq2pyHOPnfsWFuU8rCg==
X-Received: by 2002:a05:600c:3388:b0:415:6aee:2986 with SMTP id o8-20020a05600c338800b004156aee2986mr2769211wmp.12.1712261829938;
        Thu, 04 Apr 2024 13:17:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c743:de00:7030:120f:d1c9:4c3c? (p200300cbc743de007030120fd1c94c3c.dip0.t-ipconnect.de. [2003:cb:c743:de00:7030:120f:d1c9:4c3c])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b0041488691eb1sm3806475wmq.17.2024.04.04.13.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:17:09 -0700 (PDT)
Message-ID: <494abe83-521f-4c27-9a52-aefa5d5eafcb@redhat.com>
Date: Thu, 4 Apr 2024 22:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userfaultfd: change src_folio after ensuring it's
 unpinned in UFFDIO_MOVE
To: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
 kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
 zhengqi.arch@bytedance.com, kaleshsingh@google.com, ngeoffray@google.com
References: <20240404171726.2302435-1-lokeshgidra@google.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240404171726.2302435-1-lokeshgidra@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.04.24 19:17, Lokesh Gidra wrote:
> Commit d7a08838ab74 ("mm: userfaultfd: fix unexpected change to src_folio
> when UFFDIO_MOVE fails") moved the src_folio->{mapping, index} changing
> to after clearing the page-table and ensuring that it's not pinned. This
> avoids failure of swapout+migration and possibly memory corruption.
> 
> However, the commit missed fixing it in the huge-page case.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>   mm/huge_memory.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..89f58c7603b2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2259,9 +2259,6 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>   			goto unlock_ptls;
>   		}
>   
> -		folio_move_anon_rmap(src_folio, dst_vma);
> -		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> -
>   		src_pmdval = pmdp_huge_clear_flush(src_vma, src_addr, src_pmd);
>   		/* Folio got pinned from under us. Put it back and fail the move. */
>   		if (folio_maybe_dma_pinned(src_folio)) {
> @@ -2270,6 +2267,9 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
>   			goto unlock_ptls;
>   		}
>   
> +		folio_move_anon_rmap(src_folio, dst_vma);
> +		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
>   		_dst_pmd = mk_huge_pmd(&src_folio->page, dst_vma->vm_page_prot);
>   		/* Follow mremap() behavior and treat the entry dirty after the move */
>   		_dst_pmd = pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);

Ouch

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


