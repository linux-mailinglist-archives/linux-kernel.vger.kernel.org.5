Return-Path: <linux-kernel+bounces-160661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB0C8B40B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFDB20FF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113082231F;
	Fri, 26 Apr 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3z1fgMz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88942BE78
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714162563; cv=none; b=rWa5DYhHqrqewohvn1JLxpGaE8IpCXe6yNGJlk5TJ53Kvepol8T1yjG+XLE8yVMNEddNEM7TKsq1KCr01LQ70PWsq/dTRkQRvJpqO/Dr0zsLC87WVD/TOFZS5Y4zkkKbKUvIooeYHQeqH9V1ngaYO7lmTi/J1OkqSgnuDrw01lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714162563; c=relaxed/simple;
	bh=QOb0pMtvQZqkyXM2cKG7sVyRIbhmD+Kao8kRo05tE/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP40hUrj9FPbcbt4niVXiqnLbeAvvSkuKp7SSC4o2zQB9yXwJCVZ1LgtQ91dQgrAqf7OzrX05dVebTC8ZWseFPW8Z+S5D4qliDWJFwv47tjwBPHVeINIYYSH3mKFcIXVYn8XD5+J5u/VJzKK3p9uvh5xnJvBmIiNYYxyOUWVGR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3z1fgMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714162560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vToWV5vASMi+fZgoCGpmvNhNmoHHQoBMV+N4YbWAGTA=;
	b=D3z1fgMzBf2LulscG2zjG9klPKBwjccCIPSiWnLCNi/OgSiClm1PFKJRGhQOItWFtsAYuH
	gyDHnrD9QOy1WF4XMrc39goQO5pVEvaWhYQ3/eUUhpb8kXvqP/E44K57Vwpz0FbIBLyyae
	Pr+8adjLI83KsSYiGIz5/A3D9aKNWC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-x7RXyyvXOv-rrJmxOHykdQ-1; Fri, 26 Apr 2024 16:15:58 -0400
X-MC-Unique: x7RXyyvXOv-rrJmxOHykdQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b4bde57a8so1586735f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714162557; x=1714767357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vToWV5vASMi+fZgoCGpmvNhNmoHHQoBMV+N4YbWAGTA=;
        b=XyPwvDiZkmUy8CXgSwJ2Orwp5B723I5F0i8vt+H1rY1P39WxkPsYqXvPvnqyu03QoO
         EYTbKufq1dkTx3STDVkYEN+0lnsVlZ6cjbFuZh1pzMvJsGCO+nzhmbE3UfwrBXVt/Zer
         uYjkMoRpc6AnHgEUXtnE3QhK/gcKmpRxGKpYadAmrQfED2q3zLUPN84VNOPDFxYdJ9GG
         wb6NEeGvuO4YFVkt1464iB5XVptqvLTGlUw1ukyTztzb0YQByd9zwKi59NgHweFZXfz+
         pwta/In069/v4LS4bddCBTKEk329CTJoDKpJMSXv+29eRIc+kqkaN7F6qiNfaQUvo1H4
         TpXA==
X-Forwarded-Encrypted: i=1; AJvYcCXYvSMFrcPBAATnkpBo3HnSQuHz+Q0z703yqfjymJbJIE3cTl5hxFOVx29L9hDQT9ksNPLdjmIleTitFl6cUonrq9EoNs69doZcd61N
X-Gm-Message-State: AOJu0Yy0eiZ0CbOGf9teIetGSLWfZXxSq7qf3OVqv0ABlwfcQIZn1KMO
	DlG27A9O1OmyNtkYXRCYPYf3ZptiRf+HWf3tRxGNcdJuv2EBm2UJf8TuZF0SDhTRya1kCAG/6Ht
	2vzrN8YqU82qhN5Pk52GpQRtDCS84kSlc1JivueVqHGfSNuK1n8TrcP4oFF7nQQ==
X-Received: by 2002:a05:6000:1242:b0:346:251a:396d with SMTP id j2-20020a056000124200b00346251a396dmr2783460wrx.51.1714162557534;
        Fri, 26 Apr 2024 13:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh/7GhLBtj4NAqKvPWSqOASis9LdT8e7Eis7o/TMNRN3K9vMs+msX60hCRhi+vCdi5qu/+Fg==
X-Received: by 2002:a05:6000:1242:b0:346:251a:396d with SMTP id j2-20020a056000124200b00346251a396dmr2783448wrx.51.1714162557080;
        Fri, 26 Apr 2024 13:15:57 -0700 (PDT)
Received: from [192.168.3.108] (p4ff235c4.dip0.t-ipconnect.de. [79.242.53.196])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d6111000000b0034c768b3f5fsm1297637wrt.87.2024.04.26.13.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 13:15:56 -0700 (PDT)
Message-ID: <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
Date: Fri, 26 Apr 2024 22:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240426190253.541419-1-zi.yan@sent.com>
 <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
 <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 21:20, Zi Yan wrote:
> On 26 Apr 2024, at 15:08, David Hildenbrand wrote:
> 
>> On 26.04.24 21:02, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> In __folio_remove_rmap(), a large folio is added to deferred split list
>>> if any page in a folio loses its final mapping. But it is possible that
>>> the folio is fully unmapped and adding it to deferred split list is
>>> unnecessary.
>>>
>>> For PMD-mapped THPs, that was not really an issue, because removing the
>>> last PMD mapping in the absence of PTE mappings would not have added the
>>> folio to the deferred split queue.
>>>
>>> However, for PTE-mapped THPs, which are now more prominent due to mTHP,
>>> they are always added to the deferred split queue. One side effect
>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
>>> unintentionally increased, making it look like there are many partially
>>> mapped folios -- although the whole folio is fully unmapped stepwise.
>>>
>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
>>> folio is unmapped in one go and can avoid being added to deferred split
>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
>>> noise when we cannot batch-unmap a complete PTE-mapped folio in one go
>>> -- or where this type of batching is not implemented yet, e.g., migration.
>>>
>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
>>> to tell if the whole folio is unmapped. If the folio is already on
>>> deferred split list, it will be skipped, too.
>>>
>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>    mm/rmap.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2608c40dffad..a9bd64ebdd9a 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    {
>>>    	atomic_t *mapped = &folio->_nr_pages_mapped;
>>>    	int last, nr = 0, nr_pmdmapped = 0;
>>> +	bool partially_mapped = false;
>>>    	enum node_stat_item idx;
>>>     	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>> @@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    					nr++;
>>>    			}
>>>    		} while (page++, --nr_pages > 0);
>>> +
>>> +		partially_mapped = !!nr && !!atomic_read(mapped);
>>
>> Nit: The && should remove the need for both !!.
> 
> My impression was that !! is needed to convert from int to bool and I do
> find "!!int && !!int" use in the kernel. 

I might be wrong about this, but if you wouldn't write

	if (!!nr && !!atomic_read(mapped))

then

bool partially_mapped = nr && atomic_read(mapped);

is sufficient.

&& would make sure that the result is either 0 or 1, which
you can store safely in a bool, no matter which underlying type
is used to store that value.

But I *think* nowdays, the compiler will always handle that
correctly, even without the "&&" (ever since C99 added _Bool).

Likely, also

	bool partially_mapped = nr & atomic_read(mapped);

Would nowadays work, but looks stupid.


Related: https://lkml.org/lkml/2013/8/31/138

---
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <inttypes.h>

volatile uint64_t a = 0x8000000000000000ull;

void main (void) {
         printf("uint64_t a = a: 0x%" PRIx64 "\n", a);

         int i1 = a;
         printf("int i1 = a: %d\n", i1);

         int i2 = !!a;
         printf("int i2 = !!a: %d\n", i2);

         bool b1 = a;
         printf("bool b1 = a: %d\n", b1);

         bool b2 = !!a;
         printf("bool b2 = !!a: %d\n", b2);
}
---
$ ./test
uint64_t a = a: 0x8000000000000000
int i1 = a: 0
int i2 = !!a: 1
bool b1 = a: 1
bool b2 = !!a: 1
---

Note that if bool would be defined as "int", you would need the !!, otherwise you
would lose information.

But even for b1, the gcc generates now:

  40118c:       48 8b 05 7d 2e 00 00    mov    0x2e7d(%rip),%rax        # 404010 <a>
  401193:       48 85 c0                test   %rax,%rax
  401196:       0f 95 c0                setne  %al


My stdbool.h contains

#define bool	_Bool

And I think C99 added _Bool that makes that work.

But I didn't read the standard, and it's time for the weekend :)

-- 
Cheers,

David / dhildenb


