Return-Path: <linux-kernel+bounces-108890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1777881170
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D025B1C2343E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350303F9DB;
	Wed, 20 Mar 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie4uKGyi"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DC3EA9C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936196; cv=none; b=U5AoFtWC61n0FTfNdbxCTjolEijbOnuKmHE8qLplk4O0/T9m6CNx0sM8yzvUki9CldNzuC5n7DXJqMFD846P4Y4JSybHLUikpRuem9IkYyebz3ppJGkz85ReFqsVtaztHBasnIlhloOkevsliYu7VbI4DIyHfpTqx5C3CHUTJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936196; c=relaxed/simple;
	bh=Ph5Y3t4V9Ilh9TejaQuF5yjKbwO0v7oIAU5fLicb7V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I+JUvKg6MZAFDYI2Vh6PGWl6IU2/GQLcndf/W5V6odXdH/WYtNFwcaCtH/vD4/bPKovSuF/07kFP54KfpeDoKl3Hjy2hII6c20mOTpJASS98IbKYgjtRG2C5JHidSiEFCcDrvLwqJeLryCQRSm92VC9n3fLtFQxJVwkON2GF978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie4uKGyi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e8f765146fso252638b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710936194; x=1711540994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rjyl0RsxCiR3BnHPMVorROqGtL6yCk3lVv5lYb3r+gY=;
        b=Ie4uKGyi7wJumF8OLxNBnjeKAMpE+V7WrMSEL9aHOLWvMHMbaGMURXsA/97UNMqG0W
         v91/OHZnpaoztL/Ml2H+gT2gI7n+AHqM4l0aV0rN8WTIuUWDOwxGzQLp6SXWb9zjUI+C
         zmYSm+VH5ZIn2/UpgtRo4ooz+6dDVX9ce4yOzcCEcSXBkdmoqu4sqEnErQizRO/+PsNl
         RBAQqxQ0tpT2AeVY4IDoYy/QPCHLgSvupaRHbbDvF3ed4qyrYYYVH6n3sgo9Q1m4WfUM
         ot+GoX3CtazhZk3HERJmZiV6eY+Bsqd8C/YAPcEowZDhf+O2Lq7nT2RQVT2IV5a/5twU
         dACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710936194; x=1711540994;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjyl0RsxCiR3BnHPMVorROqGtL6yCk3lVv5lYb3r+gY=;
        b=sITTpi/Di0myuXRt6GNjfsPV4VU1ySrVriNpWxdZD/KmZcD4U6wCeR/t6JOzImNPzt
         LQbkR+Bm/WwRC8/x0FVUgwDlHHOuoI8eW5fdmKaM3MF/es1sGPM/QdO/6qxGWVrTunmA
         rGYq8DB1i7rJJENpfGWe0uO1s0Z/a5vUjgNngg3HKhkDHMdYXifCKvsRgWWXsSZQXRYR
         iFO6oSrzYr9wop45ceJDtsWMOI+uQXgLfAUAdCOUoTEmPMxX9OdNgKwzv2EPcoRSuY+v
         JQYOlo3WOLrskwEYcDDtEs3Vz3xayWBa/yWtREfY+dcNEkJcupKsPuM/KDw1VNHOTNEo
         tI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdCPJgObqdukFdNCaERWZBhMu0ShTfs8rlkcbm/uR5i/LzA61BHGRTbDCVCgFiBHbZPpQtBVMGRW5PgLLdH+rgXyNI5MnEHMuqqi5r
X-Gm-Message-State: AOJu0YzwXAcK+GftdVDs+FlABxHOaw3Jy6Tplqi1t3gcSN/onpIH33u/
	/JdjYwS4U/Blb5tOh73+QoNBtgjOKG1/iq3qxvAkeO6YmLHK40az
X-Google-Smtp-Source: AGHT+IEF/J0DHWSNcDOcZmL/hIiqI/9PDuGnKLhV3Qcp0yU1M5alvi1nAMXSzoSut1e/uHxnGCJxBg==
X-Received: by 2002:a05:6a00:2284:b0:6e7:821b:e972 with SMTP id f4-20020a056a00228400b006e7821be972mr1811564pfe.29.1710936194212;
        Wed, 20 Mar 2024 05:03:14 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id h25-20020a62b419000000b006e739e09504sm3925090pfn.137.2024.03.20.05.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 05:03:13 -0700 (PDT)
Message-ID: <fd01f8ec-123e-4739-9a5b-2589eb711563@gmail.com>
Date: Wed, 20 Mar 2024 20:03:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] mm/ksm: catch tail page abnormal in
 page_stable_node
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 kasong@tencent.com, Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240318121443.3991104-1-alexs@kernel.org>
 <7a0d7d0e-d241-4942-b6c1-e60d597b3dd6@redhat.com>
 <54a8ec22-ce00-425c-bb58-54cf8606a362@gmail.com>
 <280409c6-3479-4c6b-a94e-1d90994917cd@redhat.com>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <280409c6-3479-4c6b-a94e-1d90994917cd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/20/24 5:29 PM, David Hildenbrand wrote:
> On 20.03.24 10:05, Alex Shi wrote:
>>
>>
>> On 3/18/24 8:25 PM, David Hildenbrand wrote:
>>> On 18.03.24 13:14, alexs@kernel.org wrote:
>>>> From: Alex Shi <alexs@kernel.org>
>>>>
>>>> commit 19138349ed59 ("mm/migrate: Add folio_migrate_flags()") change the
>>>> meaning of func page_stable_node() to check the compound head for tail
>>>> 'page' instead of tail page self.
>>>> But seems both semantics are same at results, the func always return NULL
>>>>    for tail page. So adding a bug monitor here in case of abnormal.
>>>>
>>>> Signed-off-by: Alex Shi <alexs@kernel.org>
>>>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> Cc: Chris Wright <chrisw@sous-sol.org>
>>>> To: linux-kernel@vger.kernel.org
>>>> To: linux-mm@kvack.org
>>>> To: Andrew Morton <akpm@linux-foundation.org>
>>>> ---
>>>>    mm/ksm.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index 8c001819cf10..3ff469961927 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -1091,7 +1091,12 @@ static inline struct ksm_stable_node *folio_stable_node(struct folio *folio)
>>>>      static inline struct ksm_stable_node *page_stable_node(struct page *page)
>>>>    {
>>>> -    return folio_stable_node(page_folio(page));
>>>> +    struct ksm_stable_node *node;
>>>> +
>>>> +    node = folio_stable_node(page_folio(page));
>>>> +    VM_BUG_ON_PAGE(PageTail(page) && node, page);
>>>
>>> I don't really understand why we would want this.
>>>
>>> Only KSM folios can have a node in the stable tree. KSM folios cannot be large folios. At that is precisely what folio_stable_node() checks.
>>>
>>> If we'd have a large folio identify as a KSM folio we'd be in much bigger trouble.
>>>
>>>
>>> Besides, I'm sure you read "22) Do not crash the kernel" in Documentation/process/coding-style.rst
>>>
>>
>> Hi David,
>>
>> Thanks for comments!
>> Forgive my stupidity, I understand KSM stable tree has no compound pages, but when searching a tail page in ksm_do_scan(), why we couldn't be in a race, that another VM doing THP collapse on the same contents pages, while the 3rd vm is doing hugepage spliting?
> 
> We always call cmp_and_merge_page() while holding a reference on the page.
> 
> There, we call page_stable_node() directly and via stable_tree_search()->page_stable_node() on that page.
> 
> When stable_tree_search() returns a kpage, we also hold a reference to that kpage. So calling page_stable_node() on the kpage behaves the same.
> 
> As we are holding page references, pages cannot be split/merged and we should not see any races in page_stable_node().
> 
> Am I missing something?
> 
> Note that your change would also not help here: if it would be racy, you'd also not reliably catch any tail pages.
> 
> But it should not be racy unless I am missing something.
> 

Hi David,

Thanks for the info, I see.

BTW, I should cc you for my KSM folio patchset review: https://lore.kernel.org/linux-mm/20240320074049.4130552-2-alexs@kernel.org/

Best regards!
Alex

