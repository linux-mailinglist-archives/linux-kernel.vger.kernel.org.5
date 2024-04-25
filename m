Return-Path: <linux-kernel+bounces-158108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60D8B1BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E39283251
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642B66BFA8;
	Thu, 25 Apr 2024 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1CmSc/N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458067C53
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029354; cv=none; b=JFTkgrFzKmkuC81h4Vnq53ULU9VfzifYGR/wd+EpqDU1kdc82V6r89Eyk91H3fhGUnHwOphHXIiycFMveJLcKEgU1E4xHH3kjwA46Y3QrYjIPjL5A/t6ZMok/g4aqyz9YREdDLEE9A1fQ/61kVlURHAyjcZlS8qTihNaj9kO8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029354; c=relaxed/simple;
	bh=HslKzg5oi/WWlbtNSgQIrbvn+L9jLBKFswHxxw0owuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfTGSqsXamYkyybno8Qo87s8zHBETufXwMBvKocogCe+hPC0JzEBpU1JSxYd6zgtMy0G1rLz0PNohhZTPFjWLIea+BlJMbyfbASaFAglQq5EQP04In3Eq/2/B/AVW1lAvSRgOmARGH0UhiIhiiRiXYcGjHkEJo/rp5DVUW0ueMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1CmSc/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714029351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VRqxNnnS/GVBQqPeovnhWlUZKk8RjPDHscyhjFF2r5c=;
	b=e1CmSc/NgI57OJZy27QKbRoaLbwbP8ws8eW5IqQoUUsRx2meUiRJ6QhFNTdNah7Y1iPu4L
	k+geImOSEhiqDJ5jkT05tXAJRpDfhsbTnhhG0O1NJPCxNEcxxtjfAfIWgAGku+KNvpGXps
	Pp/Zp4hg3CZGi5zKBdo+RtD8S6LdX+4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-IVCEX1eYNia2ViPu4I9ELQ-1; Thu, 25 Apr 2024 03:15:50 -0400
X-MC-Unique: IVCEX1eYNia2ViPu4I9ELQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2dd05014390so5314021fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029348; x=1714634148;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqxNnnS/GVBQqPeovnhWlUZKk8RjPDHscyhjFF2r5c=;
        b=T4T5aEeSXlReiTt3wXSnVPVBRv+QLa/Y+Nb96DmgjQoKSq+d33LdSrBGYs9iMHbClt
         GXlBuOptAV6kkZ0ZF3zuMB2MehI2CfwI+ldQo/w/viPvkeGW5KtVoYELIA+Pr0pI7B/6
         Ixxc2Mh4GbLICSXteWdHiWlDsfoiYbhfofKytjsbZ/Sh+uXsCTI7VpH+8vD3rLwWNftu
         7u4TUEMs4ZFSQbzv0bsVqLCJjBljn+C1NUbitUD4PrcKEsIMDWvhU5vCdcQbmXnF3duK
         /s9pczKwBYF7ZgwOn9wkwFpy/zJTn3fIkgKNtEoKuF8tZPo6g0Y7YNfpW/+yWtu5OGy9
         HTjw==
X-Forwarded-Encrypted: i=1; AJvYcCVyO/7nsKsrTmHlFo0gtwaB760ZC5cL9whY7B6AJI6iiw32Dq1Ab8sB35nmAEq2N+Kdm2GJEGc4+gWpMjpPvIvIOQ/5GYR9kU1Li0a+
X-Gm-Message-State: AOJu0Yz1v4+LfauvYw2X/4p6kLSttjUd0xQZGq5M27xYyL5P+jrGQnpT
	r8WwlVgjgNZ//6/JgjpNYRWx0Oe2jY3vrPlGy+4xA11krIBglJJ+U2jml3LcociB+B25JFCPfqA
	rd2NIEOaR5VpSrwr51Bvt7MSClXJIQCm7MG14hyFQxHdIPQ4hcI66b/euW2OEGw==
X-Received: by 2002:a2e:b5a4:0:b0:2dc:be5d:1660 with SMTP id f4-20020a2eb5a4000000b002dcbe5d1660mr3028540ljn.31.1714029348497;
        Thu, 25 Apr 2024 00:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3hrkjIeeDfXfVbENvOQ5ea/qAcdgarwwwo6tR/pAK7IkjE3h7cgeib4NEAXcywo5w5a+SoQ==
X-Received: by 2002:a2e:b5a4:0:b0:2dc:be5d:1660 with SMTP id f4-20020a2eb5a4000000b002dcbe5d1660mr3028523ljn.31.1714029348053;
        Thu, 25 Apr 2024 00:15:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:8200:487a:3426:a17e:d7b7? (p200300cbc7198200487a3426a17ed7b7.dip0.t-ipconnect.de. [2003:cb:c719:8200:487a:3426:a17e:d7b7])
        by smtp.gmail.com with ESMTPSA id u17-20020adfeb51000000b00347321735a6sm18992189wrn.66.2024.04.25.00.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:15:47 -0700 (PDT)
Message-ID: <815e2114-f739-4f2f-b09f-a23a2fc3214b@redhat.com>
Date: Thu, 25 Apr 2024 09:15:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240424211031.475756-1-zi.yan@sent.com>
 <CAHbLzkq61sTeRxU23gg3kMNBunxXH3GpkL6D56xcaepsDzFCJA@mail.gmail.com>
 <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <C617533C-4926-4FBA-8275-4446FDF48F31@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.04.24 00:39, Zi Yan wrote:
> On 24 Apr 2024, at 18:32, Yang Shi wrote:
> 
>> On Wed, Apr 24, 2024 at 2:10 PM Zi Yan <zi.yan@sent.com> wrote:
>>>
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>> if any page in a folio loses its final mapping. It is possible that
>>> the folio is unmapped fully, but it is unnecessary to add the folio
>>> to deferred split list at all. Fix it by checking folio->_nr_pages_mapped
>>> before adding a folio to deferred split list. If the folio is already
>>> on the deferred split list, it will be skipped.
>>>
>>> Commit 98046944a159 ("mm: huge_memory: add the missing
>>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
>>> fix everything. A fully unmapped PTE-mapped order-9 THP was also added to
>>> deferred split list and counted as THP_DEFERRED_SPLIT_PAGE, since nr is
>>> 512 (non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
>>> the order-9 folio is folio_test_pmd_mappable(). However, this miscount
>>> was present even earlier due to implementation, since PTEs are unmapped
>>> individually and first PTE unmapping adds the THP into the deferred split
>>> list.
>>
>> Shall you mention the miscounting for mTHP too? There is another patch
>> series adding the counter support for mTHP.
> 
> OK, will add it.

I thought I made it clear: this patch won't "fix" it. Misaccounting will 
still happen. Just less frequently.

Please spell that out.

>>
>>>
>>> With commit b06dc281aa99 ("mm/rmap: introduce
>>> folio_remove_rmap_[pte|ptes|pmd]()"), kernel is able to unmap PTE-mapped
>>> folios in one shot without causing the miscount, hence this patch.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>   mm/rmap.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index a7913a454028..220ad8a83589 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>                   * page of the folio is unmapped and at least one page
>>>                   * is still mapped.
>>>                   */
>>> -               if (folio_test_large(folio) && folio_test_anon(folio))
>>> -                       if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
>>> -                               deferred_split_folio(folio);
>>> +               if (folio_test_large(folio) && folio_test_anon(folio) &&
>>> +                   list_empty(&folio->_deferred_list) &&
>>
>> Do we really need this check? deferred_split_folio() does the same
>> check too. Bailing out earlier sounds ok too, but there may not be too
>> much gain.
> 
> Sure, I can remove it.

Please leave it. It's a function call that cannot be optimized out 
otherwise.



-- 
Cheers,

David / dhildenb


