Return-Path: <linux-kernel+bounces-76134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9FF85F356
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12D3B21DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617412C683;
	Thu, 22 Feb 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSGG+t6M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B002BB10
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591425; cv=none; b=Osnxsdlj6wS+uZeH9WrblGrlPlgoBvC23h/q7mxlu7laUOZU5/dWzgj3hJf4POtfjufyipbNMvd/Wijz3et+FEopZ3Sv2T45WPYcTpZ3IdWwgKjDGT9yVYYIYYDcJLAKC5a18SX5EBbJTbdlrk+MgwTTCw7jsrJ8sjNOo35EzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591425; c=relaxed/simple;
	bh=MDeU5hNoYR8szkcGiheBDlrS8UtpqmAKhUwSrHtbKCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRfo2+SQXcUzP3jQmALyt6P3yzj0gld0QFfiq8mLPw6YLbVN41RZMkQuXL9ukFM1NSygzlB/++U0VhbPjGNrEx7I9KPhSTLpOyZ3T4KWx3CTTKWvYFAGBBI85KCDgUCCcVnLSF3ErfXmwB5OZL/WDUEMoLz5v5GXxCrg49QUTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSGG+t6M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708591411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mgHUUX8dMByqbwsZEjiWnQCuj3pWXP8pIG0ICD0fFAw=;
	b=aSGG+t6MfeXUcecIvVoLrbM8UQiBjefpaA03MQhA9FgF8rDGQddtka5ufY7jO1rvK+Nvxk
	v8WEzJ+0KUYMHD/s/LrUtmPqoZKlWZDDhiWBdVQT3rOsZLSj6soeer/3+B1PP6u5Lr6aVD
	irbbunBGFYzuqpnZWBi0hYDe/0GNWuU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-H2nGELHQP42VdDpsGCb4Ag-1; Thu, 22 Feb 2024 03:43:29 -0500
X-MC-Unique: H2nGELHQP42VdDpsGCb4Ag-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d8d785b08so208995f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591409; x=1709196209;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgHUUX8dMByqbwsZEjiWnQCuj3pWXP8pIG0ICD0fFAw=;
        b=mcgQCNnj7DDcNBa+ZJ2F3ugGyKKdsn24Gs3pOhneWUrkUgZLj7BuaWP10Dgm3D3YfX
         859jOpcgEt6gMM4nZJsQ5riBoHuo0rGQez8rScfQitBHQB6+lDOtpkd/tflEnud2M9bY
         1cYSMLIN9o9CubHQ5s2LQofV7P+6iJlcJztnakpYmHZoel32jqUmQ5ocO2IbqHO8A00a
         EoBnqUIYKe1PTE9vRGtHNPmIqbjqQHDC/5Own+yURh598xXxfODvTBoEet1jTvZ2Pw7w
         TE2DbRrUCl7rwFlSTA8WCLmTRsKsV1vLeluw0YX9fNTP2dUQpCvTkRI7EKLPFn4/pCcA
         uG/w==
X-Forwarded-Encrypted: i=1; AJvYcCVE8ReUetu/0jls6KE9y/h041L8ClbwvuNS3moUKK6a4VgvrRanhH7MNZNvBDifPNXqKvTi4UYKeEDGTDmPt9lrJUVTer5KNNN1xuak
X-Gm-Message-State: AOJu0YxIC/DqpSaNpika8/zAgM9xe3SMaswl0MaCwFyXNsBOZXRQgdVO
	Sf7ZS42RBwK3EBRY8Ai1acaVDqNZCc+iU7RgkCqCtLi4MUt+7NDzJ/eXkE/Mep9i+cDIVuRd3oJ
	fV5yYqbBLSiXTteo2Ctmd4HjzjayPMb6nLWn33cE88/SshaUOohm4dFkX6Yrk0w==
X-Received: by 2002:adf:e787:0:b0:33d:3f27:6626 with SMTP id n7-20020adfe787000000b0033d3f276626mr8381107wrm.22.1708591408770;
        Thu, 22 Feb 2024 00:43:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1a7Zh8vxk81NSij5wcg0YuK58zsgXpQIUWwDXJgS2mwlHf0fFKAqJT450/wl0hmXtSLcTMg==
X-Received: by 2002:adf:e787:0:b0:33d:3f27:6626 with SMTP id n7-20020adfe787000000b0033d3f276626mr8381095wrm.22.1708591408334;
        Thu, 22 Feb 2024 00:43:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c70f:8b00:ed48:6d18:2152:1cda? (p200300cbc70f8b00ed486d1821521cda.dip0.t-ipconnect.de. [2003:cb:c70f:8b00:ed48:6d18:2152:1cda])
        by smtp.gmail.com with ESMTPSA id bq18-20020a5d5a12000000b0033d97bd5ddasm517571wrb.85.2024.02.22.00.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:43:27 -0800 (PST)
Message-ID: <ad82668d-10c6-4670-97f3-77c60a391c5f@redhat.com>
Date: Thu, 22 Feb 2024 09:43:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: userfaultfd: fix unexpected change to src_folio when
 UFFDIO_MOVE fails
To: Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
 aarcange@redhat.com, surenb@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240222080815.46291-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.02.24 09:08, Qi Zheng wrote:
> After ptep_clear_flush(), if we find that src_folio is pinned we will fail
> UFFDIO_MOVE and put src_folio back to src_pte entry, but the change to
> src_folio->{mapping,index} is not restored in this process. This is not
> what we expected, so fix it.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   mm/userfaultfd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 4744d6a96f96..503ea77c81aa 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1008,9 +1008,6 @@ static int move_present_pte(struct mm_struct *mm,
>   		goto out;
>   	}
>   
> -	folio_move_anon_rmap(src_folio, dst_vma);
> -	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> -
>   	orig_src_pte = ptep_clear_flush(src_vma, src_addr, src_pte);
>   	/* Folio got pinned from under us. Put it back and fail the move. */
>   	if (folio_maybe_dma_pinned(src_folio)) {
> @@ -1019,6 +1016,9 @@ static int move_present_pte(struct mm_struct *mm,
>   		goto out;
>   	}
>   
> +	folio_move_anon_rmap(src_folio, dst_vma);
> +	WRITE_ONCE(src_folio->index, linear_page_index(dst_vma, dst_addr));
> +
>   	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>   	/* Follow mremap() behavior and treat the entry dirty after the move */
>   	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);

Indeed, LGTM.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


