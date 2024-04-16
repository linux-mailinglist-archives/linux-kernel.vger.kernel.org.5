Return-Path: <linux-kernel+bounces-146676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776E8A691D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB6B2228D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9112881C;
	Tue, 16 Apr 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke4jaNFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AB12838C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264846; cv=none; b=cwDKdTUbMEanSJuBphhkGQWpBJJqM+VuU1ZXAm4UbTITgqgnBkYOjzYCxwMYEA5mbDdvZBxCOnFMZ/94c+dNTZQe7XPlor4CucBa1XDzGVVeU0kA9oNvUIYZrxEg0ivmZz1Lz7hGwLEU+X6neOuhDUuxo6uzFTUq2Y2e9X+GD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264846; c=relaxed/simple;
	bh=aWURHaW6nMbtOaq7cs7J8asmqnfs4zo48Doy+jGT7OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqWrNTKQ1tASSXjZC6aAbY4bzkGNXhzpcnvDheXHbILJJfS5FfRLtnP6NzXcz5u8YBbhFkbiQg9aru1rJ4mCps9jl0oXgKZCuA1tEPNhHwfZvq+4sn4zFwB2zyPamQSsI/y/TdMWzZ+7ZcQm5zTmukWP/5VUr6IKtmkofwwg92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke4jaNFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713264844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vksiSYsM8KsJ+KPHxeVsLrfiOXJjytB2/Y6GtczvRok=;
	b=Ke4jaNFebkubdudnDWUZx0Fo0GV64820tpHs46rB1QVhg/DnOXA3qNv7pi87Y93S7DgVkK
	+jdVx48PfBLecvFH05LlGv5Nf/VgKSBgkh9a5XVhwUQMywSECOvLqkJMXgDLLDzA5IZUkb
	uxghN47gHifaNb29xJrVg0OCdHh+8Qg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-poJEbeu8P8a0A6cbvUChwQ-1; Tue, 16 Apr 2024 06:54:02 -0400
X-MC-Unique: poJEbeu8P8a0A6cbvUChwQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516da5d2043so3975735e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713264841; x=1713869641;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vksiSYsM8KsJ+KPHxeVsLrfiOXJjytB2/Y6GtczvRok=;
        b=jc0tixYVgW3Y1okLLUvPRI6HVDAraeHFrzPNhw5goz+kDPza3fEqseX32iy9U/tC3g
         aqVqYnv1fkUYJD3PWiL70aF2jd75DDg0mGgVhNeeI9gKDI9YXZcZ9+GdQRKC1CYs+avd
         FbteoiqLdVmYKWuBHX0Sbw85NKXRh/gXXKBQnf0w2X3zRNZXZ7smHo6XdenqRC35a3zT
         HRGSjDX7hiRu0JqUx6UF7PE5EoKLi+9k3jSerYisfhgO2PAvaycoI/3vrf4GcnWSJNOV
         ykcuvZ2erI+GVdIUv7MqI2BqT01m17C7fZnHfIuz7ATa6fTqGv/KxToc3kQJTCJdKCuD
         ibow==
X-Forwarded-Encrypted: i=1; AJvYcCVPeHs6qBCUwQLHdhbvA5cfW1td8iiRSJd0Oq+jB19kB0hWqhWtbmg79aMxnyII5yCI1CUaS8OyT1GJ/6bBgX43yQG+zgxAGpZLrrjQ
X-Gm-Message-State: AOJu0YwPWGTm1ODIEFVcP+z52rlJCv4r82dTRfG6s5JMHgzL9gkYbPV0
	sKMXxSIfLO+Wl2eXLRzfMtm7RBAFddXllRocHmSzKdkqlvyYaaNOcwny+GUGbqz+2xs6UMsHjBJ
	tGDEV24n2JH4hz2FfbDFd6gQf2qPiNhSHDSVAgQg0hYa2LZuX5P7krez4GvnDYw==
X-Received: by 2002:ac2:4d09:0:b0:517:5ee6:4f59 with SMTP id r9-20020ac24d09000000b005175ee64f59mr10898839lfi.41.1713264841177;
        Tue, 16 Apr 2024 03:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPDzhc+dnDcQDP4Z+aS7WixHRBj2jxLWq85y08tsCZn7jmiv4TgvWsTyDD8ukS8UV4JnB7mw==
X-Received: by 2002:ac2:4d09:0:b0:517:5ee6:4f59 with SMTP id r9-20020ac24d09000000b005175ee64f59mr10898813lfi.41.1713264840719;
        Tue, 16 Apr 2024 03:54:00 -0700 (PDT)
Received: from [192.168.3.108] (p4ff2389d.dip0.t-ipconnect.de. [79.242.56.157])
        by smtp.gmail.com with ESMTPSA id l13-20020ac2430d000000b00518c0034e1esm808919lfh.50.2024.04.16.03.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 03:54:00 -0700 (PDT)
Message-ID: <c1455047-6a93-4cab-ab96-804024bede84@redhat.com>
Date: Tue, 16 Apr 2024 12:53:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/18] mm: improve folio_likely_mapped_shared() using
 the mapcount of large folios
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, cgroups@vger.kernel.org, chris@zankel.net,
 corbet@lwn.net, dalias@libc.org, fengwei.yin@intel.com,
 glaubitz@physik.fu-berlin.de, hughd@google.com, jcmvbkbc@gmail.com,
 linmiaohe@huawei.com, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev,
 naoya.horiguchi@nec.com, peterx@redhat.com, richardycc@google.com,
 ryan.roberts@arm.com, shy828301@gmail.com, willy@infradead.org,
 ysato@users.sourceforge.jp, ziy@nvidia.com
References: <20240409192301.907377-6-david@redhat.com>
 <20240416104008.41979-1-ioworker0@gmail.com>
 <3ef81fe3-2584-4db8-ab66-eaa44c035707@redhat.com>
 <CAK1f24kph=hV6Da=fAXFuKChx5JVasPLYC7efQbPr+JT0WxQ1A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24kph=hV6Da=fAXFuKChx5JVasPLYC7efQbPr+JT0WxQ1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.04.24 12:52, Lance Yang wrote:
> On Tue, Apr 16, 2024 at 6:47 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.04.24 12:40, Lance Yang wrote:
>>> Hey David,
>>>
>>> Maybe I spotted a bug below.
>>
>> Thanks for the review!
>>
>>>
>>> [...]
>>>    static inline bool folio_likely_mapped_shared(struct folio *folio)
>>>    {
>>> -     return page_mapcount(folio_page(folio, 0)) > 1;
>>> +     int mapcount = folio_mapcount(folio);
>>> +
>>> +     /* Only partially-mappable folios require more care. */
>>> +     if (!folio_test_large(folio) || unlikely(folio_test_hugetlb(folio)))
>>> +             return mapcount > 1;
>>> +
>>> +     /* A single mapping implies "mapped exclusively". */
>>> +     if (mapcount <= 1)
>>> +             return false;
>>> +
>>> +     /* If any page is mapped more than once we treat it "mapped shared". */
>>> +     if (folio_entire_mapcount(folio) || mapcount > folio_nr_pages(folio))
>>> +             return true;
>>>
>>> bug: if a PMD-mapped THP is exclusively mapped, the folio_entire_mapcount()
>>> function will return 1 (atomic_read(&folio->_entire_mapcount) + 1).
>>
>> If it's exclusively mapped, then folio_mapcount(folio)==1. In which case
>> the previous statement:
>>
>> if (mapcount <= 1)
>>          return false;
>>
>> Catches it.
> 
> You're right!
> 
>>
>> IOW, once we reach this point we now that folio_mapcount(folio) > 1, and
>> there must be something else besides the entire mapping ("more than once").
>>
>>
>> Or did I not address your concern?
> 
> Sorry, my mistake :(

No worries, thanks for the review and thinking this through!

-- 
Cheers,

David / dhildenb


