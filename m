Return-Path: <linux-kernel+bounces-108692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99816880E92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326C0B21A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0B3A8C0;
	Wed, 20 Mar 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0ED+tFb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFF383A1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926983; cv=none; b=eEF4pg0+oWhg83mNQJnPHAgS7Ga8PEcUxC6cuXhukYFjhuZsyci2JX+JbnGeVVX8p/iOvidKpxeWrlaRHfkKMOqoTvx+jzKsAxBKv1+OUbGDTA2g/L/6hlTUQuksExREuzNWxNvfh9tFOy6HQAGnn756dpErUWhumj+T6xGwYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926983; c=relaxed/simple;
	bh=jiUNB3M0CnY1s2eJDWD3IuKgwNxCvkGX/ic+9ZbGaaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X3DPx2AY8o/C+6++137VeAwI5sj9Vy8AEGuDKNYILSv7d3+5KDJQuafDhiBYO/rzPOXtoX4wTU6UTYUly707sZzx6WtnfFBLCrzEONssqpo71ygc0Tc7R6HuP5LEAAIb6S9vjQzpjJgRQFfTlo8s1O5aAFW6WSmZOkM7GiU3Lqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0ED+tFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710926980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QlWzVvG8MoY6BEfaD999fPLQHmpRDr3AzpSpkk6JYJI=;
	b=b0ED+tFbIpuons9kXUEz/jFwrlfLD5BFOvL6TZ2Zgs4cFPBZrKcrDVlxgk2oXOR3l92Hxo
	uL2OIOYpTmjvXNEWC5gapElKXmOStkGIPa10vH3nY8icex7UKaJZor0U7TyuF+d5VGeO2i
	9k/C8ThLgTcSqaEq+hbq59+Arf8QgM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-v2fJdEY_MbqbEw6XdojbsQ-1; Wed, 20 Mar 2024 05:29:39 -0400
X-MC-Unique: v2fJdEY_MbqbEw6XdojbsQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4478a3afso3400085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926978; x=1711531778;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlWzVvG8MoY6BEfaD999fPLQHmpRDr3AzpSpkk6JYJI=;
        b=RDOA4yO2TeBllmLUy3JiaLGoSCmLjDJMusLDTKjRXXCYUpvZ/GaKVSyfC9Hp4PKB4k
         cx0wvP0dICM3gvwIkS6kmQHD9G42EWr98aGZ04kbhpkq56MC31Ghjl6fToL2IBrNbB7V
         oBLxlSey+Rufi/l0Q1jUXl0et1KFnZs8T7TblmLeiADuTEj1a+028TH1bgrDo1bpCCw9
         R758ufIvBhcIJGoPEkt13QJg//FHSBhSHYZjRbnXZS+l3t4MYwa87/QNzZVcgziBrfYZ
         ov+ymYLpq6hbbUZFibZC3NXca3sDeIj9NUnWGEmhvkVHX1/TB6ZZJvDiWCR70cSE+j1B
         3OqA==
X-Forwarded-Encrypted: i=1; AJvYcCWPKNKnTVJJfVIYE4XPKdC9vI4Flcc++csn+3t+1KzyAHqyz/JW3llCZ+mBrkY2fqQNu+MD4CaYjcEbM1rw5XJuzl5ZvbPEbJRB2u0P
X-Gm-Message-State: AOJu0YykJ3LQzIT3dDmDAt28IMm4B7WGxk7JPDZ19eleJp8NYxINaspe
	oSrFWkcFINyrXR41rKlU62kkU2s19lJP65J7jMPGisEQQk24lGog/QmCfpYR2QXLe0+l6KJnOHU
	q3B6q62u3iZAeG475Jwf34NSj8bSaULjfmY2dUQ23NCglMnb2eI03HiWrO0K4ig==
X-Received: by 2002:a05:600c:4587:b0:414:37f:18dc with SMTP id r7-20020a05600c458700b00414037f18dcmr4611912wmo.1.1710926977951;
        Wed, 20 Mar 2024 02:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrxPu9ffLnPgGSI8KUDAMb6qXifSGCELmeiQY08eBgV/ZoGzpX0RUBywmEsXFMaK4OMAVoMA==
X-Received: by 2002:a05:600c:4587:b0:414:37f:18dc with SMTP id r7-20020a05600c458700b00414037f18dcmr4611891wmo.1.1710926977463;
        Wed, 20 Mar 2024 02:29:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:c400:9a2:3872:9372:fbc? (p200300cbc709c40009a2387293720fbc.dip0.t-ipconnect.de. [2003:cb:c709:c400:9a2:3872:9372:fbc])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d6ac3000000b0033dd2c3131fsm14298209wrw.65.2024.03.20.02.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 02:29:37 -0700 (PDT)
Message-ID: <280409c6-3479-4c6b-a94e-1d90994917cd@redhat.com>
Date: Wed, 20 Mar 2024 10:29:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm/ksm: catch tail page abnormal in
 page_stable_node
To: Alex Shi <seakeel@gmail.com>, alexs@kernel.org, kasong@tencent.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240318121443.3991104-1-alexs@kernel.org>
 <7a0d7d0e-d241-4942-b6c1-e60d597b3dd6@redhat.com>
 <54a8ec22-ce00-425c-bb58-54cf8606a362@gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <54a8ec22-ce00-425c-bb58-54cf8606a362@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.03.24 10:05, Alex Shi wrote:
> 
> 
> On 3/18/24 8:25 PM, David Hildenbrand wrote:
>> On 18.03.24 13:14, alexs@kernel.org wrote:
>>> From: Alex Shi <alexs@kernel.org>
>>>
>>> commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
>>> meaning of func page_stable_node() to check the compound head for tail
>>> 'page' instead of tail page self.
>>> But seems both semantics are same at results, the func always return NULL
>>>    for tail page. So adding a bug monitor here in case of abnormal.
>>>
>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: Chris Wright <chrisw@sous-sol.org>
>>> To: linux-kernel@vger.kernel.org
>>> To: linux-mm@kvack.org
>>> To: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>    mm/ksm.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 8c001819cf10..3ff469961927 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -1091,7 +1091,12 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
>>>      static inline struct ksm_stable_node *page_stable_node(struct page *page)
>>>    {
>>> -    return folio_stable_node(page_folio(page));
>>> +    struct ksm_stable_node *node;
>>> +
>>> +    node = folio_stable_node(page_folio(page));
>>> +    VM_BUG_ON_PAGE(PageTail(page) && node, page);
>>
>> I don't really understand why we would want this.
>>
>> Only KSM folios can have a node in the stable tree. KSM folios cannot be large folios. At that is precisely what folio_stable_node() checks.
>>
>> If we'd have a large folio identify as a KSM folio we'd be in much bigger trouble.
>>
>>
>> Besides, I'm sure you read "22) Do not crash the kernel" in Documentation/process/coding-style.rst
>>
> 
> Hi David,
> 
> Thanks for comments!
> Forgive my stupidity, I understand KSM stable tree has no compound pages, but when searching a tail page in ksm_do_scan(), why we couldn't be in a race, that another VM doing THP collapse on the same contents pages, while the 3rd vm is doing hugepage spliting?

We always call cmp_and_merge_page() while holding a reference on the page.

There, we call page_stable_node() directly and via 
stable_tree_search()->page_stable_node() on that page.

When stable_tree_search() returns a kpage, we also hold a reference to 
that kpage. So calling page_stable_node() on the kpage behaves the same.

As we are holding page references, pages cannot be split/merged and we 
should not see any races in page_stable_node().

Am I missing something?

Note that your change would also not help here: if it would be racy, 
you'd also not reliably catch any tail pages.

But it should not be racy unless I am missing something.

-- 
Cheers,

David / dhildenb


