Return-Path: <linux-kernel+bounces-136721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C189D789
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E6E1C2220A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5485636;
	Tue,  9 Apr 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBGKDZPO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD317C0B0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660531; cv=none; b=Qbumdn1dfLpKKXPVRiy4Uh5AIl7HqmUbn8TqsbD0S1Rh7pM7YEwBCKvMeipM9IKLttZDGg18XOindHurq4KYK9JWFF2qxPYUdWngg5eEbaOtMQ0A2TJvURZWaAlqDIT2wBtIwuLT5w8tTQAD2Yeg4foGTpcN0xMn/JJdyzOmmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660531; c=relaxed/simple;
	bh=TURxfz+5f22Byehv5ksbQxQ/fqAEtro6k5FvuLPwYuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gb8kBtS7OiI8agggOYHh/c2wanZukmRgECiQCx8SsQcdaePvfkOLKecX6MjnJ0wg5+zwTBa7dnX0LsCzriQjRMqMh3H0saWQMFdysd5gtPSA1iNFz5an3NYILHTLo1nHwkFcadCC4YlTfLBglnzwAb+B32jXnfmHx/HGJVfkJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBGKDZPO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712660529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5EuvRYjhB2ByIJqrM8XsBqe7c9oo5XQaPdNDVkox+vI=;
	b=cBGKDZPOUPLRZMvnV/+ruTC4t16hVQ3PCNEFD8yFyfeUeZH8lS/ZB9Jv+2WPgBMPCJ3o3j
	ID4SdpsgaY+lr4FGFwNE27XgUSHq0KMmtp25p162WHw+8Umla8rLLeL5EUXn/8d4F87izx
	ksqSjX6WoQtuWuNo2gReWVQgXIQ/5LM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-IX9zh-SQNC6YoePpLvDpyQ-1; Tue, 09 Apr 2024 07:02:07 -0400
X-MC-Unique: IX9zh-SQNC6YoePpLvDpyQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41489c04e3aso22442635e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660526; x=1713265326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5EuvRYjhB2ByIJqrM8XsBqe7c9oo5XQaPdNDVkox+vI=;
        b=Gvxp454tOi4gwAGkQFe1eFi+48yDAiyjz0t6Bh3dir8MrraTyrRqXg0wTlRMqsVd1f
         aHszC2JRJy/27QZX11mWM5hmejQqOWv3xPdRZa6Y+eZ8Xqufk2r1v1v8+dQ6R93fh+e/
         fLJUiCozJOUHcrHCUGc2iccEKCqUuCHb8v2adBGmvzkpg6JFchDs4XuPI2P0kGt/FnO9
         WZs8ZKMYKtZ3qmXhoBxfAQnEGFnGvGx5sL5+7Jmk0Pfl+aFuLduuTNkDLQMcu1ZkSNHB
         Ps6GyNtPA2xv5H7wR5tO6aqgvbCAV87AV+u2v6mOFhDhM6c0KrFNs+8337xryov8guIy
         Fb6w==
X-Forwarded-Encrypted: i=1; AJvYcCVtxEnTqATEdZltQy3k2+FfGgs91pbaJrmfbcp4o2DMNJkvT0OZGZppy9Y8yWM0PkmSuomCCeDxMsMt/Z8yEvuONZRdRswPl6QZ1GXR
X-Gm-Message-State: AOJu0YxkCWCkl2kg5sGj1VrQSVJGndyAihsXgAb2FIUNnTNIUOdV77kh
	l9qeoHlPVy0144+0WjDH8maBcmesGJQzC6U6dsRfHZUprKGEP9Wk5ycmI2wosF8ukDCmhbiVd2M
	NmSK5+T5/dgSkfDnnupriEjcQGssd5h60xexrW95DSMMWaJdwDOe7gzS9yBpodA==
X-Received: by 2002:a05:600c:512a:b0:416:3317:5951 with SMTP id o42-20020a05600c512a00b0041633175951mr7239145wms.6.1712660526464;
        Tue, 09 Apr 2024 04:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFcNFxAXoOVObPD2o30lZXdjv6GTG+xWvlEs15Bo+7jeLAg5j8PlkRre9DjPi/ol87m/44Q==
X-Received: by 2002:a05:600c:512a:b0:416:3317:5951 with SMTP id o42-20020a05600c512a00b0041633175951mr7239130wms.6.1712660526034;
        Tue, 09 Apr 2024 04:02:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:be00:a285:bc76:307d:4eaa? (p200300cbc70abe00a285bc76307d4eaa.dip0.t-ipconnect.de. [2003:cb:c70a:be00:a285:bc76:307d:4eaa])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b004155387c08esm12420936wmq.27.2024.04.09.04.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 04:02:05 -0700 (PDT)
Message-ID: <7a8d8005-3cec-4647-82b0-2d55d0ef34fc@redhat.com>
Date: Tue, 9 Apr 2024 13:02:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] mm/ksm: Convert chain series funcs and replace
 get_ksm_page
To: alexs@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>
References: <20240409092826.1733637-1-alexs@kernel.org>
 <20240409092826.1733637-9-alexs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240409092826.1733637-9-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 11:28, alexs@kernel.org wrote:
> From: "Alex Shi (tencent)" <alexs@kernel.org>
> 
> In ksm stable tree all page are single, let's convert them to use and
> folios as well as stable_tree_insert/stable_tree_search funcs.
> And replace get_ksm_page() by ksm_get_folio() since there is no more
> needs.
> 
> It could save a few compound_head calls.
> 
> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

I don't recall giving that yet :)

You could have kept some get_ksm_page()->ksm_get_folio() into a separate 
patch.

i.e., "[PATCH v3 11/14] mm/ksm: remove get_ksm_page and related info" 
from your old series could have mostly stayed separately.

[...]

>   /*
> @@ -1829,7 +1821,7 @@ static __always_inline struct page *chain(struct ksm_stable_node **s_n_d,
>    * This function returns the stable tree node of identical content if found,
>    * NULL otherwise.
>    */
> -static struct page *stable_tree_search(struct page *page)
> +static void *stable_tree_search(struct page *page)

There is one caller of stable_tree_search() in cmp_and_merge_page().

Why the change from page* to void* ?

I suspect cmp_and_merge_page() could similarly be converted to some 
degree to let kpage be a folio (separate patch).

-- 
Cheers,

David / dhildenb


