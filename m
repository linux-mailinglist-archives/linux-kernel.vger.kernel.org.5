Return-Path: <linux-kernel+bounces-119429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB588C8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F4C1F8172C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A113C9B8;
	Tue, 26 Mar 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9xb629O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958A13C91A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469451; cv=none; b=kZ9Y/FiXbsVVMnw5DXLBd7dcCWI+8Jb4kj/k0YKdSuWEdav+ECxWLKYM8moxy8YyQr1u4mSyqXJlBMcgR0SOCepaEN5krSeEqxkHS0v35M8d2gZqXTXjsIaEPUsFgKnnxLF3c+9pzaXuPHxh3I2JywsZsU3QfM/Yi/oAcQh/A+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469451; c=relaxed/simple;
	bh=uDEsdZL44ys2mfc6Tu8wXrdevz+6olzqLlV5D6/p404=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut6w2VCg2FrD0RCbMA2qjROeAZNCAHGKemlB7ymCP4WK3B6svaTk3zziT47vnwdKPib7qImsWQy3JERztaj2mwyhq60P+Hyzgrjr30yo1Ur1gWKENUdX+OWngD3M0nDgGYXyDItcPLCWZlQNsf5hTGP1MQ1zuTEy2uk/BfaTMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9xb629O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711469448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xYWWKtJsyIiOOREH/jvgE2Pym6yl6SXL43dmFzzxj1M=;
	b=C9xb629OS7DhEbq4rnWVt792xNX0ANtBGtdG/LgMAJ2+4LZQGJXtH43enHjxX/CJrT2bOg
	MlYvM9qTEgfruvmggqPcHcn3bFN0hBHifyP+n75U1e6dOyxR6joyyZMAXvvs/dqDCmWUBQ
	hUzflemb2z50Yc84VDe9xlo2I8UoMmc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-LIP0ezOOMQKvu4w0w4X96A-1; Tue, 26 Mar 2024 12:10:46 -0400
X-MC-Unique: LIP0ezOOMQKvu4w0w4X96A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso29664615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469446; x=1712074246;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYWWKtJsyIiOOREH/jvgE2Pym6yl6SXL43dmFzzxj1M=;
        b=pTIHHxOh8izKvVehfV0+cLF0GFsQ+4EA2dhe4iFNKD1gAiV0vRcnnjnJdEhD14H/tC
         7I4DRMzyoB8sq8LZYAQRDsGUU6mVyE9vN8my7ubKQ2wJ1opHItldbgMJk0vXkw20ZmKW
         0LlO8NL8F1bKi2UiK4lXvmTM7Hq08jjoywCu13CTNaySyKenid6W15DxFV3JOpi47mLz
         GrffmSfwiRVRgDEL6KacF93bR/BbvKTV7nbhTdQmBF/5cE9/1SUop2JahkD4dFBNqydR
         n7Q5biWFiU8Rx2ZLGPhm3+bVAAB1/oBeUfJxQ2+0jrZ1P7qJPAx49vswehart3xoNDGf
         1/QA==
X-Forwarded-Encrypted: i=1; AJvYcCV6nP4mKbdFXFkEaJji5jj8IhCY9DyNRzhl2GwstUI0d31eKYFhM9SCnqva5FowFllNndMPK/ACl9+9fVTwFRMwD7MTq0LYHzFqcD54
X-Gm-Message-State: AOJu0Yw6u521+8/UIZ6x3hLivAKTrYw/UhHN+l5sQGVrL9Xp7NjH8SzE
	tSgbuKMYvR9JCjzl5RnEHbqJ4tp+1IgaAdvczYNASiBD5armim28Z6Jzet5S1FxoAdeucbRoZEQ
	HRXj0ngyiKaZpMGbdm2SQnnDoBVHLf+yKfXIz3/D1EWsSK06ID5Bhn8V29PP2ZA==
X-Received: by 2002:a05:600c:3d90:b0:414:90ea:34ad with SMTP id bi16-20020a05600c3d9000b0041490ea34admr927520wmb.6.1711469445749;
        Tue, 26 Mar 2024 09:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHHMeCfQQAYcQzf8EzgbgXZS09NcE5ekOSvfIcEXLaHftME0nWyseceBrLGav0KwMByU4/kQ==
X-Received: by 2002:a05:600c:3d90:b0:414:90ea:34ad with SMTP id bi16-20020a05600c3d9000b0041490ea34admr927494wmb.6.1711469445247;
        Tue, 26 Mar 2024 09:10:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b0041409db0349sm11999073wmb.48.2024.03.26.09.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:10:44 -0700 (PDT)
Message-ID: <cf16a19d-cc3b-4f19-a46f-83554a472368@redhat.com>
Date: Tue, 26 Mar 2024 17:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: hold PTL from the first PTE while reclaiming a
 large folio
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chrisl@kernel.org, hanchuanhua@oppo.com, hughd@google.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com,
 shy828301@gmail.com, v-songbaohua@oppo.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yuzhao@google.com
References: <20240306095219.71086-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240306095219.71086-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.03.24 10:52, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Within try_to_unmap_one(), page_vma_mapped_walk() races with other
> PTE modifications preceded by pte clear. While iterating over PTEs
> of a large folio, it only starts acquiring PTL from the first valid
> (present) PTE. PTE modifications can temporarily set PTEs to
> pte_none. Consequently, the initial PTEs of a large folio might
> be skipped in try_to_unmap_one().
> For example, for an anon folio, if we skip PTE0, we may have PTE0
> which is still present, while PTE1 ~ PTE(nr_pages - 1) are swap
> entries after try_to_unmap_one().
> So folio will be still mapped, the folio fails to be reclaimed
> and is put back to LRU in this round.
> This also breaks up PTEs optimization such as CONT-PTE on this
> large folio and may lead to accident folio_split() afterwards.
> And since a part of PTEs are now swap entries, accessing those
> parts will introduce overhead - do_swap_page.
> Although the kernel can withstand all of the above issues, the
> situation still seems quite awkward and warrants making it more
> ideal.
> The same race also occurs with small folios, but they have only
> one PTE, thus, it won't be possible for them to be partially
> unmapped.
> This patch holds PTL from PTE0, allowing us to avoid reading PTE
> values that are in the process of being transformed. With stable
> PTE values, we can ensure that this large folio is either
> completely reclaimed or that all PTEs remain untouched in this
> round.
> A corner case is that if we hold PTL from PTE0 and most initial
> PTEs have been really unmapped before that, we may increase the
> duration of holding PTL. Thus we only apply this optimization to
> folios which are still entirely mapped (not in deferred_split
> list).
> 
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   v2:
>    * Refine commit message and code comment after reading all comments
>      from Ryan and David, thanks!
>    * Avoid increasing the duration of PTL by applying optimization
>      on folios not in deferred_split_list with respect to Ying's
>      comment, thanks!
> 
>   mm/vmscan.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0b888a2afa58..7106741387e8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1270,6 +1270,18 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   
>   			if (folio_test_pmd_mappable(folio))
>   				flags |= TTU_SPLIT_HUGE_PMD;
> +			/*
> +			 * Without TTU_SYNC, try_to_unmap will only begin to hold PTL
> +			 * from the first present PTE within a large folio. Some initial
> +			 * PTEs might be skipped due to races with parallel PTE writes
> +			 * in which PTEs can be cleared temporarily before being written
> +			 * new present values. This will lead to a large folio is still
> +			 * mapped while some subpages have been partially unmapped after
> +			 * try_to_unmap; TTU_SYNC helps try_to_unmap acquire PTL from the
> +			 * first PTE, eliminating the influence of temporary PTE values.
> +			 */
> +			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
> +				flags |= TTU_SYNC;
>   
>   			try_to_unmap(folio, flags);
>   			if (folio_mapped(folio)) {

Hopefully this won't have unexpected performance "surprises".

I do wonder if we should really care about the "_deferred_list" 
optimization here, though, I'd just drop it.

In any case

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


