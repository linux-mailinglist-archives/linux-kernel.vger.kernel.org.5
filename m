Return-Path: <linux-kernel+bounces-82867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D8868ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCE282D16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06E12FF96;
	Tue, 27 Feb 2024 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHc4txKv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D917B3D3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022831; cv=none; b=Gub8VAbAkj2T2qtIy9eOShdiRcIwOczM1pwhw98Lky/OBCfoNqCWPRCnNJHJRS4Iopcm3BHs2O+LyVfmxX7zQCeKP+wsRRwKDnH5SXpQSP9vzWrNktdXignIbR+PmeIZXUmh6HxAdBMkn/0I+XePC1yO4oyNOLEO0CAIL+QbOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022831; c=relaxed/simple;
	bh=kmgaKMwx+nTjW3sACuOORzkP54CjLMGSfiSp7H8iEeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHbMQe4Rm4bC2BK1O1qKqsvlXi9ObC8pEmtHxRJvufZjuZum8OsBBHDhMdQrnz0g7GJhul7n5IJUadoHK/ipffRj3xNeHA2HYhjfpSHEdmpwqHOUQMEfk3NiJQcStI5HoBEyNiciJ0jPNJMOcHdxDU4tciljjvNn8yLyQkQTNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHc4txKv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709022827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ljXsABoXgmTEOQtWNkyFzL6p6hV34LbdxIDJHMAqCnA=;
	b=FHc4txKv43JlxFfSIDfOVX1PuPiBo/xpNBaIp/4jU7HZLbGV3j1WNtiTbgU5Bn4MuAyY26
	i+kcug8BnVYDKj26gIDGmoLlofigR57l2G8/asbODjUezZgTPVjrwAQynRW8CTxf6B6z90
	zceHNsNyeJ26EG6DQMsKsXX6Nq/i+TA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-m83rb-j8NVyx6eINUkVW0A-1; Tue, 27 Feb 2024 03:33:45 -0500
X-MC-Unique: m83rb-j8NVyx6eINUkVW0A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512eb4e9a77so3418794e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709022824; x=1709627624;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljXsABoXgmTEOQtWNkyFzL6p6hV34LbdxIDJHMAqCnA=;
        b=L5fTyZy5shok91sZSPYxB/qib2JN7eR72nPY/Q/bK8zxUntx969lbVqNpsPZGztV4e
         q4VxauJHzH1h4t4qAJrZ8JMny3siBmhOBG3ZacrbrSmWC4AeisLq1zkA7wL8ZOxxf2N3
         gPZpGjndIyu9egztd8+EO02gCwJBiBsxgO6vt+6F4FlBDxPlT5dmhGrVQ+ecKrpkzxOl
         rdhD46Ck9MFfBJrkOimad7VFyTl6n4354E1ccM7ZaL0to+y1CPLJ9dZ/lrff4wmFmaKz
         4NZYz1wAh+urZTW/MMgjXN5WAdRAUJ/1jqOUeAjIybu36fCKLjbkGUEhpU4eH4muxzqO
         mXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVZIXZH4NYqFh1dobSkdIbe+VWLQZgWol+Nq6yf86ZqFa4G2Y7//iynNlbxQ9XsRyfH9v4k6piajO7bc+EkgTQeqOqtC2MGJWjyLhQQ
X-Gm-Message-State: AOJu0Yz7SYowWZPnE1lYXOoeR5/a4zbraNnPd0qycJGKjictaDyWCODZ
	4+18DIkLz5iOu6FK2+ggSXnLzuAIWDvqZPXzoOJtC2itPo8XuCL6HUz+nKdcMqwAvFpmTqxtmkE
	aOCphoaCgaPVuzTeIlLqmlUD04EJVTd4uzGuZynLe/U6NuJoJ9hiXamq0MTByyQ==
X-Received: by 2002:ac2:465b:0:b0:512:a89b:9bcf with SMTP id s27-20020ac2465b000000b00512a89b9bcfmr5531890lfo.17.1709022824054;
        Tue, 27 Feb 2024 00:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnLNPWWOzvzzo/CXRUoZ1oO963xrSpVPvL/fFVJOyUnosljiPnZWGph3CAPhsLjvGpRR3UxA==
X-Received: by 2002:ac2:465b:0:b0:512:a89b:9bcf with SMTP id s27-20020ac2465b000000b00512a89b9bcfmr5531878lfo.17.1709022823662;
        Tue, 27 Feb 2024 00:33:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9? (p200300cbc70776005c185a7dc5b7e7a9.dip0.t-ipconnect.de. [2003:cb:c707:7600:5c18:5a7d:c5b7:e7a9])
        by smtp.gmail.com with ESMTPSA id g2-20020a0565123b8200b0051313ecc5casm14881lfv.229.2024.02.27.00.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:33:43 -0800 (PST)
Message-ID: <2aa8b0f0-4fd4-469a-ba72-82fe01d37f15@redhat.com>
Date: Tue, 27 Feb 2024 09:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/memory: Fix boundary check for next PFN in
 folio_pte_batch()
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, 21cnbao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240227070418.62292-1-ioworker0@gmail.com>
 <90471b2f-826e-4275-a9a3-ec673c3e6af8@redhat.com>
 <CAK1f24nr=giiYW2CVtbpuUxNshb9ksLhtY_v-SK1_AVvQPUEdQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24nr=giiYW2CVtbpuUxNshb9ksLhtY_v-SK1_AVvQPUEdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.02.24 09:23, Lance Yang wrote:
> Hey David,
> 
> Thanks for taking time to review!
> 
> On Tue, Feb 27, 2024 at 3:30 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.02.24 08:04, Lance Yang wrote:
>>> Previously, in folio_pte_batch(), only the upper boundary of the
>>> folio was checked using '>=' for comparison. This led to
>>> incorrect behavior when the next PFN exceeded the lower boundary
>>> of the folio, especially in corner cases where the next PFN might
>>> fall into a different folio.
>>
>> Which commit does this fix?
>>
>> The introducing commit (f8d937761d65c87e9987b88ea7beb7bddc333a0e) is
>> already in mm-stable, so we would need a Fixes: tag. Unless, Ryan's
>> changes introduced a problem.
>>
>> BUT
>>
>> I don't see what is broken. :)
>>
>> Can you please give an example/reproducer?
> 
> For example1:
> 
> PTE0 is present for large folio1.
> PTE1 is present for large folio1.
> PTE2 is present for large folio1.
> PTE3 is present for large folio1.
> 
> folio_nr_pages(folio1) is 4.
> folio_nr_pages(folio2) is 4.
> 
> pte = *start_ptep = PTE0;
> max_nr = folio_nr_pages(folio2);
> 
> If folio_pfn(folio1) < folio_pfn(folio2),
> the return value of folio_pte_batch(folio2, start_ptep, pte, max_nr)
> will be 4(Actually it should be 0).
> 
> For example2:
> 
> PTE0 is present for large folio2.
> PTE1 is present for large folio1.
> PTE2 is present for large folio1.
> PTE3 is present for large folio1.
> 
> folio_nr_pages(folio1) is 4.
> folio_nr_pages(folio2) is 4.
> 
> pte = *start_ptep = PTE0;
> max_nr = folio_nr_pages(folio1);
> 

In both cases, start_ptep does not map the folio.

It's a BUG in your caller unless I am missing something important.


> If max_nr=4, the return value of folio_pte_batch(folio1, start_ptep,
> pte, max_nr)
> will be 1(Actually it should be 0).
> 
> folio_pte_batch() will soon be exported, and IMO, these corner cases may need
> to be handled.

No, you should fix your caller.

The function cannot possibly do something reasonable if start_ptep does 
not map the folio.

nr = pte_batch_hint(start_ptep, pte);
..
ptep = start_ptep + nr; /* nr is >= 1 */
..
return min(ptep - start_ptep, max_nr); /* will return something > 0 */

Which would return > 0 for something that does not map that folio.


I was trying to avoid official kernel docs for this internal helper, 
maybe we have to improve it now.

-- 
Cheers,

David / dhildenb


