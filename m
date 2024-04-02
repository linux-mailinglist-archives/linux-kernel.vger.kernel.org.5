Return-Path: <linux-kernel+bounces-128361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E48959DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9DE81F2353E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6971315A489;
	Tue,  2 Apr 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpmd0MXj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685681598F6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076012; cv=none; b=p1zsV47GcX1ccGQEbpc42HZthF7t1ItZuTfyLLxJBOZO6dpnzc/HXBidGcFyTjvluOH3ulJTuuo7ZLiSMXmmSQMTQ1vpOTdZutDAU6ijI60nBA32r+a82dW8rbZNKvl5s1ZNiKyuA2/HRH4C/yWFE0bwCRWuVLZq9G4PCl3/qHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076012; c=relaxed/simple;
	bh=agCorDctzOnEBAOUE8vStWX0Yxg1CI1HzeGRcPoVj6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJHj+AydPKtbKTVjyMMTlP2bmk9g6hrx+2p4zhlLS3AkbmNaKuUlAB/obTuwPW5bhxapiAsDsK3PZOybUcZiwXZKwv8c/P0Kh9luQFWU60zSyWyvst0HSnVz0Ml4qESrPncv+F7Dmww3vZ8ERGV2jZbcfH897d9icoxR8+OsDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpmd0MXj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712076009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iEb1HUNjpnqEgLGmlXxstqgOUp3S0IqEbnWahtuTkPk=;
	b=hpmd0MXjgJHQCXMsNPgRbG+wPn+eoMVy/l4jpXkTlTjbsFYX+K490jU4eHjFuYWlcEYZlh
	Oc1zg/jW/2j9wTcoqIvo+Aaneu6oEtcVXGbxnuP2Mg6JypOCIhHOq2JHaAS6WKicjENK6n
	Xt0uzKWk6GuEcA4hv3VociXqZcXO0M8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-WeTDQxHvOCqZGcnYQ1IFsw-1; Tue, 02 Apr 2024 12:40:08 -0400
X-MC-Unique: WeTDQxHvOCqZGcnYQ1IFsw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d818a149bbso15246091fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 09:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076006; x=1712680806;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iEb1HUNjpnqEgLGmlXxstqgOUp3S0IqEbnWahtuTkPk=;
        b=fOFWdqLKdcG3bZPJlwZ0Ue95q9Tn/s0PnJdmSkvOM9SB9fTImhD1oPIJz9iVXmagaN
         3eer8t1xxyioc5p5m3iQV/JAVc702e07Ufvttc5XEGMXZallFUkZSvdC8tTQMiE0MtAn
         2OWb7iSjKZKDiJWvD9StWz+9Gx9xkReVxwgFBAEh1x9tSTr/wdkT+qAKkz1wNsPjNJhv
         3vAURj5QsIuB5c4bQ2A9ClQX3BcnhjboGA2LWBnrrGNK6JV0T86IkljwplPfsOU7s5e3
         /g4slPoL0az0f5RpTd3jHiRSX0dK0qfCXjOkWk+58sxxafallIOIWQscocaHG/0fEhFv
         JIHA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+Mdtu02xsBeXqYQ/loxSAzzfotPdO5MlVW0O/0LB4QHIfn8FfrjrehLRft04b+PUjyaQbfXmVVdfL95R2XWaa4vC2SYqhex7eoXy
X-Gm-Message-State: AOJu0Yw4vNXu4QM+/IPrz91DLlhj1kQ9gIrvWuaauO9S09uSfKgrLKIX
	IOlmMz3mQMSTcj0zx6/DLB8eQhhrBo5jp4e0czchsSJ/Ez8xQONIBK5/Zj7Ol60PxngTvgudxlg
	AbL9z3wCwUN2XHBA2NP7Y/rUrxQVqDaHRH8sW+ShG61bK3PIJFN6ek3NiQD4qEQ==
X-Received: by 2002:a2e:a1c6:0:b0:2d6:f56a:2c93 with SMTP id c6-20020a2ea1c6000000b002d6f56a2c93mr100945ljm.49.1712076006578;
        Tue, 02 Apr 2024 09:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuQTtY35SlGNEgobFjthAxTwDvUNM6x0Hlf/gyIfohvOtboRJqBmL5hKdTw7+tWAipqSJUXw==
X-Received: by 2002:a2e:a1c6:0:b0:2d6:f56a:2c93 with SMTP id c6-20020a2ea1c6000000b002d6f56a2c93mr100927ljm.49.1712076006141;
        Tue, 02 Apr 2024 09:40:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c732:e600:4982:2903:710f:f20a? (p200300cbc732e60049822903710ff20a.dip0.t-ipconnect.de. [2003:cb:c732:e600:4982:2903:710f:f20a])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b004161b59e230sm2538868wmo.41.2024.04.02.09.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 09:40:05 -0700 (PDT)
Message-ID: <98d4ef76-93e4-4e76-be60-9f0076389dc5@redhat.com>
Date: Tue, 2 Apr 2024 18:40:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] mm/gup: Handle hugetlb in the generic
 follow_page_mask code
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, peterx@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Yang Shi <shy828301@gmail.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Mike Kravetz <mike.kravetz@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Jones <andrew.jones@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Rik van Riel <riel@surriel.com>, linux-arm-kernel@lists.infradead.org,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, James Houghton <jthoughton@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-14-peterx@redhat.com>
 <adfdd89b-ee56-4758-836e-c66a0be7de25@arm.com>
 <5d9dd9a7-e544-4741-944c-469b79c2c649@redhat.com>
 <ZgwrhKuypBtSpKdI@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZgwrhKuypBtSpKdI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 18:00, Matthew Wilcox wrote:
> On Tue, Apr 02, 2024 at 05:26:28PM +0200, David Hildenbrand wrote:
>>> The oops trigger is at mm/gup.c:778:
>>> VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
>>>
>>> So 2M passed ok, and its failing for 32M, which is cont-pmd. I'm guessing you're trying to iterate 2M into a cont-pmd folio and ending up with an unexpected tail page?
>>
>> I assume we find the expected tail page, it's just that the check
>>
>> VM_BUG_ON_PAGE(!PageHead(page) && !is_zone_device_page(page), page);
>>
>> Doesn't make sense with hugetlb folios. We might have a tail page mapped in
>> a cont-pmd entry. As soon as we call follow_huge_pmd() on "not the first
>> cont-pmd entry", we trigger this check.
>>
>> Likely this sanity check must also allow for hugetlb folios. Or we should
>> just remove it completely.
>>
>> In the past, we wanted to make sure that we never get tail pages of THP from
>> PMD entries, because something would currently be broken (we don't support
>> THP > PMD).
> 
> That was a practical limitation on my part.  We have various parts of
> the MM which assume that pmd_page() returns a head page and until we
> get all of those fixed, adding support for folios larger than PMD_SIZE
> was only going to cause trouble for no significant wins.
> 
> I agree with you we should get rid of this assertion entirely.  We should
> fix all the places which assume that pmd_page() returns a head page,
> but that may take some time.
> 
> As an example, filemap_map_pmd() has:
> 
>         if (pmd_none(*vmf->pmd) && folio_test_pmd_mappable(folio)) {
>                  struct page *page = folio_file_page(folio, start);
>                  vm_fault_t ret = do_set_pmd(vmf, page);
> 
> and then do_set_pmd() has:
> 
>          if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
>                  return ret;
> 
> so we'd simply refuse to use a PMD to map a folio larger than PMD_SIZE.
> There's a lot of work to be done to make this work generally (not to
> mention figuring out how to handle mapcount for such folios ;-).

Yes :)

-- 
Cheers,

David / dhildenb


