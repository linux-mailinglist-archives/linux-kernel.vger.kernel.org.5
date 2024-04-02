Return-Path: <linux-kernel+bounces-127989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF18895421
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EDB2863FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667477F7EC;
	Tue,  2 Apr 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEPvEsah"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD757EF10
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062745; cv=none; b=u3x4nudPcjCWj8yCjvrIXT89/a763ADSc9GP40kk0gumcFjyK1Of6SsOxypxnI327i4PV9Z3g37BAwFzzqXNnXPhwAmw2dOkRaPmMUDsi2FE3eT1SnyL9NL+stP6UAcbWWbYzMKZVM8A2nMo3OjsWERd3SAoxMkjBupYcWF62P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062745; c=relaxed/simple;
	bh=w7G5DdOk7rwBY1MtpU7UsFJo21O6wvzqvoKsO+sEzTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYzBgNQRqrSMtp2m2obLPtDPNwqNdfrPsf+kzuEjYSABGmkq+zluIha6E7qsjBKIitVjbfRELO5yV/V3J5Wruj4Hi42upoxYyXjiOpnNGsJZb7PeuJsbF1SVxKSi+PiRthKZIguSUTIUpGCaD3ZEA063/7+4HVEQO1s3gE3gJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEPvEsah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712062742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TmiKzNpoTThIDgDgzTh3VqdhrMkp9oIKMyB8Og+9cyc=;
	b=fEPvEsahOU1p+aIPNgheuapeba+KE3U+WC2mHIGD6iyAIbIQ5zhwAS58yoUs+3MobvX/Ij
	0xctA2a53Ng+JBICJ9uXo5ljoUKSRXYZMlg9xNLP3JpwxtWRDu3aAJiV0UdrUfPPAFP/Pb
	1pVCvXWj62BXXw7uvBhPOpqwfKiQ3wY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-k-JQlBogN_CAUU52oHjjhA-1; Tue, 02 Apr 2024 08:58:54 -0400
X-MC-Unique: k-JQlBogN_CAUU52oHjjhA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed2f873b4so2694738f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062733; x=1712667533;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmiKzNpoTThIDgDgzTh3VqdhrMkp9oIKMyB8Og+9cyc=;
        b=q6ITNl72ZrvHfHUPmWI2mFcW/FeHn4NJUTQ6yZmNpAR+mKpZa3/rqdcbGOkLGu4g1l
         ArjXDm0TtOXGMn+KOzj/0VKgGPX7uL8iqx4k0xbt5DkbaKh2/xViR3F38425t5HpPl5h
         TrIZhS5JAXpsN5xpupgKTC7QJRSqAJ7nXvqTqgrM9isDKUXzRRb4yGyXakOPZV7FC810
         Fu7FC66cGbFMsewPjRXtyev05M5VvxS9AsXoG/cJSnM/SHA8wmKlhS6nJQoqngKX17kl
         Tln1WdDakv+79rfSd2hXJVrXmJuMxCv7x/7RWtgyGvenIAk6J2UxedPMVRG7HQh8XO4h
         oGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDPzJj0IPS/hQ/IFYOfcz7DJFxyO0mKEpCVLe5Eqy2UNe5OJR8DN3qsgMcaKO7oyTPqIGOGMl2f3rIQFZ3FRUSC2IppshoXkxHdMe
X-Gm-Message-State: AOJu0Yxrn2aQlzx5APxMLX2C87t5SB6uKn2papwoTdKnOhxGRsbvcVdH
	kw58auvoB5a6tUk9vAf6cfMZ2azPlkxP36hdA+aS0IJhYC20zER3+1bOB/xqzMZBlDJWJU2ykW0
	Q0oBrILT6VGKIckFcqOUFTfH/6rZ3E9JgiOsSw/IH0WWsVEJkma3zQKpE2O1pqQ==
X-Received: by 2002:adf:f18f:0:b0:341:a640:b516 with SMTP id h15-20020adff18f000000b00341a640b516mr8027082wro.70.1712062733622;
        Tue, 02 Apr 2024 05:58:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaC3Eovc49fr7XF3UPg6ZNunFrc5iwvSdh0K2O0b9k6yhB6B5FpLiaHwTzO+LgFHTAXUGH/A==
X-Received: by 2002:adf:f18f:0:b0:341:a640:b516 with SMTP id h15-20020adff18f000000b00341a640b516mr8027069wro.70.1712062733252;
        Tue, 02 Apr 2024 05:58:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:e600:4982:2903:710f:f20a? (p200300cbc732e60049822903710ff20a.dip0.t-ipconnect.de. [2003:cb:c732:e600:4982:2903:710f:f20a])
        by smtp.gmail.com with ESMTPSA id bq21-20020a5d5a15000000b00341cb22a8d4sm14229799wrb.108.2024.04.02.05.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 05:58:52 -0700 (PDT)
Message-ID: <736b982a-57c9-441a-812c-87cdee2e096e@redhat.com>
Date: Tue, 2 Apr 2024 14:58:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/1] mm: fix unproperly folio_put by changing API in
 read_pages
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, NeilBrown <neilb@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Cc: Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240401081734.1433755-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.04.24 10:17, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> An VM_BUG_ON in step 9 of [1] could happen as the refcnt is dropped
> unproperly during the procedure of read_pages()->readahead_folio->folio_put.
> This is introduced by commit 9fd472af84ab ("mm: improve cleanup when
> ->readpages doesn't process all pages")'.
> 
> key steps of[1] in brief:
> 2'. Thread_truncate get folio to its local fbatch by find_get_entry in step 2
> 7'. Last refcnt remained which is not as expect as from alloc_pages
>      but from thread_truncate's local fbatch in step 7
> 8'. Thread_reclaim succeed to isolate the folio by the wrong refcnt(not
>      the value but meaning) in step 8
> 9'. Thread_truncate hit the VM_BUG_ON in step 9
> 
> [1]
> Thread_readahead:
> 0. folio = filemap_alloc_folio(gfp_mask, 0);
>         (refcount 1: alloc_pages)
> 1. ret = filemap_add_folio(mapping, folio, index + i, gfp_mask);
>         (refcount 2: alloc_pages, page_cache)
> 
> Thread_truncate:
> 2. folio = find_get_entries(&fbatch_truncate);
>         (refcount 3: alloc_pages, page_cache, fbatch_truncate))
> 
> Thread_readahead:
> 3. Then we call read_pages()
>         First we call ->readahead() which for some reason stops early.
> 4. Then we call readahead_folio() which calls folio_put()
>         (refcount 2: page_cache, fbatch_truncate)
> 5. Then we call folio_get()
>         (refcount 3: page_cache, fbatch_truncate, read_pages_temp)
> 6. Then we call filemap_remove_folio()
>         (refcount 2: fbatch_truncate, read_pages_temp)
> 7. Then we call folio_unlock() and folio_put()
>         (refcount 1: fbatch_truncate)
> 
> Thread_reclaim:
> 8. collect the page from LRU and call shrink_inactive_list->isolate_lru_folios
>          shrink_inactive_list
>          {
>              isolate_lru_folios
>              {
>                 if (!folio_test_lru(folio)) //false
>                     bail out;
>                 if (!folio_try_get(folio)) //false
>                     bail out;
>              }
>           }
>           (refcount 2: fbatch_truncate, reclaim_isolate)
> 
> 9. call shrink_folio_list->__remove_mapping
>          shrink_folio_list()
>          {
>              folio_try_lock(folio);
>              __remove_mapping()
>              {
>                  if (!folio_ref_freeze(2)) //false
>                      bail out;
>              }
>              folio_unlock(folio)
>              list_add(folio, free_folios);
>          }
>          (folio has refcount 0)
> 
> Thread_truncate:
> 10. Thread_truncate will hit the refcnt VM_BUG_ON(refcnt == 0) in
> release_pages->folio_put_testzero
>          truncate_inode_pages_range
>          {
>              folio = find_get_entries(&fbatch_truncate);
>              truncate_inode_pages(&fbatch_truncate);
>              folio_fbatch_release(&fbatch_truncate);
>              {
>                  folio_put_testzero(folio); //VM_BUG_ON here
>              }
>          }
> 
> fix: commit 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't process all pages")'

Something that would help here is an actual reproducer that triggersthis 
issue.

To me, it's unclear at this point if we are talking about an actual 
issue or a theoretical issue?

-- 
Cheers,

David / dhildenb


