Return-Path: <linux-kernel+bounces-140032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E48A0A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B961C2133D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CBF13F44E;
	Thu, 11 Apr 2024 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDtvx33K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CD513F01E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821989; cv=none; b=CtYhVfz0oL0JrMokhq4wsapVvhwpeLkv1Fmx4nJfIP0+Th+WAozlhXmFrdOpzxge/nz1C5jg/EGEqKONTHI6cFdSgF9Z/XPwPGSrRHmyUBugGhY35k5xlHiU67oj8WEGPUcylnHxba1qGB2Kx58kAqhHbm6d8BkM6jDFvt0IRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821989; c=relaxed/simple;
	bh=J/4NE2wDFXFGDqkqeJKeu6UJgsoVJBlTyB8oBdYvACQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSAm2HH05tzdRTnl5XRynMJungSXk0Dz/KZD9AAUoPPgg6StyNJkTPFyGe005OH4DtIy84jWVGypSzrQT/JxJeMaXDFJJOAJAOQC3YVTSIoMQGrIhc8aeg1sZFEg03ziRQ5Q0DIvUK5wAc4dfAsXyxNpCt0l0ssdW4O25qhew2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDtvx33K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712821986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q+tfuFqnhzTrXThrKMSHQ0jiZCkn/HKtQJy2YLEJJmk=;
	b=gDtvx33KdmnMzut5AEWHf+oomYOz/W3DQC78n1XA3UzYlgEiZKE/PXRU+6eCpG6A4b5kN+
	ZVa0JDlVgS/84djY5efYxx+CFAp3dHortvxxEjmFpNolZV2qtzmv60LZmqopzoHMmSVtSC
	NUNgtDgA4BLXpgqezvSV4fI3wdtMrbA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-kVZInfyoPxS6USiv3F8wjg-1; Thu, 11 Apr 2024 03:53:04 -0400
X-MC-Unique: kVZInfyoPxS6USiv3F8wjg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416b91d1328so11490895e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821983; x=1713426783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+tfuFqnhzTrXThrKMSHQ0jiZCkn/HKtQJy2YLEJJmk=;
        b=F86S+zAsRaLgbub+OtWIMe40Cfnb9RhaG7HRxHmY168PMABIGXcwWxVYS9W5k4i+2w
         BM+L+CQr4utNbF6HIbvtokE26YKLCPzpZfgn6gQVK0XmVoZh0NIpXxdZkzq4SaNKtxGP
         9dFNKl2uG5m7ZCzZlB+Me/uAM9+pvPHM/NuJnu3FPAnh0qmZy+4/jV7L5rnSFQ91Tnml
         JpwchgXl4/cIEbKaXORZkhX+eBGAq40M3PFP7ww820w6ZvFRWLp9z4US9Q4mTmj4CTDt
         ows5dQGNzAMecAP9tyLXvr+yYWAl1+Y88M8yRzbi9Si+f9jDpGxPozgjgZ5cWounIXTu
         N+pA==
X-Forwarded-Encrypted: i=1; AJvYcCXSJmmXpvwwk0OnYWaHiAOPQBiR9hnp8RyWnJxddEY+2J5+8QMPfx0eYjgpcELbaNPEfYldYYQl0LzwBnRIWGWHx0TPaeulbKhqVn/L
X-Gm-Message-State: AOJu0YwJCpvZY+CxAHJ7nNt83wC9Vp0PkqdBParMbtyZYoVP8hyIxyi+
	aJMOqMuLA3UgCAGTLzhMjdjPYiu4vgWXfzxhNAWlVK8B4GXeHePV1AqsNRluhxIHIz40CZGfBom
	6/4ooaq+SgDUvaLn87GNzigNVM2CpFtVZpc6tifIINs67z4NioknWnhGl5iFU+w==
X-Received: by 2002:a05:600c:3583:b0:416:a0a9:213e with SMTP id p3-20020a05600c358300b00416a0a9213emr3346983wmq.13.1712821983696;
        Thu, 11 Apr 2024 00:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8nKXkptfTMUNNVToaD0izcEsnr5oE+9imKQuHGpaj8bK6rvbpVDaopeRYN6NwHS8CBDJBqQ==
X-Received: by 2002:a05:600c:3583:b0:416:a0a9:213e with SMTP id p3-20020a05600c358300b00416a0a9213emr3346966wmq.13.1712821983259;
        Thu, 11 Apr 2024 00:53:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b00416aca5ff66sm4702531wmq.19.2024.04.11.00.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 00:53:02 -0700 (PDT)
Message-ID: <8a79bfbd-b01d-4425-8fd9-de2d3e6cd1af@redhat.com>
Date: Thu, 11 Apr 2024 09:53:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] mm/ksm: Convert chain series funcs and replace
 get_ksm_page
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zik.eidus@ravellosystems.com, willy@infradead.org, aarcange@redhat.com,
 hughd@google.com, chrisw@sous-sol.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>
References: <20240411061713.1847574-1-alexs@kernel.org>
 <20240411061713.1847574-9-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240411061713.1847574-9-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 08:17, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> In ksm stable tree all page are single, let's convert them to use and
> folios as well as stable_tree_insert/stable_tree_search funcs.
> And replace get_ksm_page() by ksm_get_folio() since there is no more
> needs.
> 
> It could save a few compound_head calls.
> 
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> ---

Nit: "mm/ksm: convert ..." so in your series all start lowercase :)

[...]

> @@ -3244,7 +3238,7 @@ void folio_migrate_ksm(struct folio *newfolio, struct folio *folio)
>   		/*
>   		 * newfolio->mapping was set in advance; now we need smp_wmb()
>   		 * to make sure that the new stable_node->kpfn is visible
> -		 * to get_ksm_page() before it can see that folio->mapping
> +		 * to ksm_get_folio() before it can see that folio->mapping
>   		 * has gone stale (or that folio_test_swapcache has been cleared).
>   		 */
>   		smp_wmb();
> @@ -3271,7 +3265,7 @@ static bool stable_node_dup_remove_range(struct ksm_stable_node *stable_node,
>   	if (stable_node->kpfn >= start_pfn &&
>   	    stable_node->kpfn < end_pfn) {
>   		/*
> -		 * Don't get_ksm_page, page has already gone:
> +		 * Don't ksm_get_folio, page has already gone:
>   		 * which is why we keep kpfn instead of page*
>   		 */
>   		remove_node_from_stable_tree(stable_node);
> @@ -3359,7 +3353,7 @@ static int ksm_memory_callback(struct notifier_block *self,
>   		 * Most of the work is done by page migration; but there might
>   		 * be a few stable_nodes left over, still pointing to struct
>   		 * pages which have been offlined: prune those from the tree,
> -		 * otherwise get_ksm_page() might later try to access a
> +		 * otherwise ksm_get_folio() might later try to access a
>   		 * non-existent struct page.
>   		 */
>   		ksm_check_stable_tree(mn->start_pfn,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f1..9f0494fd902c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -616,7 +616,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>   	folio_migrate_ksm(newfolio, folio);
>   	/*
>   	 * Please do not reorder this without considering how mm/ksm.c's
> -	 * get_ksm_page() depends upon ksm_migrate_page() and PageSwapCache().
> +	 * ksm_get_folio() depends upon ksm_migrate_page() and PageSwapCache().
>   	 */
>   	if (folio_test_swapcache(folio))
>   		folio_clear_swapcache(folio);

I'd have moved these 3 into a separate patch, but fine with me

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


