Return-Path: <linux-kernel+bounces-157190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DED8B0E24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98871C247D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BB15FA8D;
	Wed, 24 Apr 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRThHCjF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE415B97E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972549; cv=none; b=jvbdSL4PXTtCxqG9Xi6M855VlgicYPJvJ8dBwgFluOvVL/ivZxeA2c2TI+whnoibwTtwtrvBpAsaULYH2oRFNtL6co/DuHwg7Qe2L7dOZe464ZBRFIl+gl+PVOxmc4IOZE9yg+RKw/DyYiiE8CKwjOsVYZqxDYY9ttjJtt2RT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972549; c=relaxed/simple;
	bh=hdSr3OoVyNWX+151cpCIB9tJWKCnZWOwugI9xoUWmWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjoSAgfpqfJ/c+VPNwdEnNSnKJOt98s3nGuqjAdvl/cuzxtSwQBhona/T9EQpZv6OG3Pe4+hzH9qEkMb4bEBW75cxWmZtu/tN5ysISnCdy08Hh5aGpJJKQVzwWqqco/oKQCcotjt6XT3w9/qwid7bZe0bWfAHrAvdiYLqethnq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JRThHCjF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713972547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZEJp/mhsJN4ER43ot9dFcBJVuSAFehmL/rhGxfiI5bo=;
	b=JRThHCjFqIQ7rnbKKm7JuGGgTiKZn54WDypfgqDniTdNXBbpKvQa/ZyPamSRR0SjY+fiHv
	QSPxWF3g+tj63q1v9Jw1Abcn0KNOBb04ERBgh4+0TMecgwfi5G1BeQMNdDYh11FpQCmAEv
	MyHe5mh4TaW0muQ55N5fQqqSy+eV+KU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-SfY_nDiGPxe3Nfw4QjDT9A-1; Wed, 24 Apr 2024 11:29:06 -0400
X-MC-Unique: SfY_nDiGPxe3Nfw4QjDT9A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so4429396f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972544; x=1714577344;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEJp/mhsJN4ER43ot9dFcBJVuSAFehmL/rhGxfiI5bo=;
        b=mB5GDa2w1TvWTr79v7WNlAEBnMO2gdR15QJMLX8G4tUnEWCIna4eo8CTbApLHoK8kv
         rEsuPz5YiGbP3G2ZD4aJ7/sr4txu/RInpa1DQAtlcWMLn5LR23Pq6Y41Lh0uu+3TNrYC
         YOsfY1RunUsbciwgkvohmiHgigV3Qpd85BPSGbkdwLCtoUkuKSJSJDpBENwOEhP7lU0B
         eLSp9XEl5SvMhPbABIXqh+B6Rxw8vYhdYacI/1oqupaoBP9qEGt5ckM0P/+iMgeMq4Pc
         siaN29v9xPmDePGIAxw5CkgEw7OiTH1v62Qv+9cq8tOqVauSyM18dm+UuzDzpDYbhjCn
         NG8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzHbG3xDITd3wLJePyXkzKIrnwWWm1V+qE1zT2UFxxHCZ/r/n3cy7pVq6JgDFe6bjlMipki369pmhvBZJTf3q8lAmV7PnAWscAOLRr
X-Gm-Message-State: AOJu0YxO0LE1bhFDxN4Gukvj7lqWWLOia3IwyhmikmzqrEMpwlGBIRx+
	GGRHGaCkaNxBjlvnBwEOgDYezTUoBixqxlF+nl6+tWHBZ6sk9s0OWLiRX9LzoebZEn4lpu2gyuH
	nmJTQmmPrwjrRyd0r3XYXj4JzzXJobs8+RVeGfyZfrjE8SEWD7yQcr5ZYaKf5QA==
X-Received: by 2002:a5d:47c1:0:b0:34b:dc52:265b with SMTP id o1-20020a5d47c1000000b0034bdc52265bmr1086652wrc.49.1713972544725;
        Wed, 24 Apr 2024 08:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9kcJgw6tU4GEfJ/+s2f39siAqViX3EQAdIm57net5ujoaw3chaOw32HLJ1Gk2hoPGSGV1tg==
X-Received: by 2002:a5d:47c1:0:b0:34b:dc52:265b with SMTP id o1-20020a5d47c1000000b0034bdc52265bmr1086628wrc.49.1713972544299;
        Wed, 24 Apr 2024 08:29:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:1f00:7a4e:8f21:98db:baef? (p200300cbc70d1f007a4e8f2198dbbaef.dip0.t-ipconnect.de. [2003:cb:c70d:1f00:7a4e:8f21:98db:baef])
        by smtp.gmail.com with ESMTPSA id cs18-20020a056000089200b003437799a373sm17557155wrb.83.2024.04.24.08.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:29:03 -0700 (PDT)
Message-ID: <a1196e94-a4aa-4da2-95fa-b835abf79560@redhat.com>
Date: Wed, 24 Apr 2024 17:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: introduce per-order mTHP split counters
To: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org
Cc: 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <ab18a4b1-bcbf-4417-b43a-5feae3b5ba66@redhat.com>
 <11455268-d522-4b3a-8961-892e42cc50f0@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <11455268-d522-4b3a-8961-892e42cc50f0@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.04.24 17:20, Ryan Roberts wrote:
> On 24/04/2024 16:00, David Hildenbrand wrote:
>> On 24.04.24 15:51, Lance Yang wrote:
>>> Hi all,
>>>
>>> At present, the split counters in THP statistics no longer include
>>> PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
>>> counters to monitor the frequency of mTHP splits. This will assist
>>> developers in better analyzing and optimizing system performance.
>>>
>>> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>>>           split_page
>>>           split_page_failed
>>>           deferred_split_page
>>>
>>> Thanks,
>>> Lance
>>> ---
>>>
>>> Lance Yang (2):
>>>    mm: add per-order mTHP split counters
>>>    mm: add docs for per-order mTHP split counters
>>>
>>>    Documentation/admin-guide/mm/transhuge.rst | 16 ----------------
>>
>> We really have to start documenting these, and what the sementics are.
> 
> I think the diffstat is backwards; the series definitely adds more lines than it
> removes. And patch 2 is adding 16 lines of docs, not removing them. How are you
> generating this? `git format-patch` should do it correctly for you.
> 
>>
>> E.g., is split_page_failed contained in split_page? Is deferred_split_page
>> contained in split_page?
>>
>> But also: just don't call it "split_page". Drop the "_page".
>>
>> split
>> split_failed
>> split_deferred
> 
> I guess we are back in "should we be consistent with the existing vmstats"
> territory, which uses split_page/split_page_failed/deferred_split_page
> 

Yeah, "thp_split_page" really is odd "transparent huge page split page".

> But here, I agree that dropping _page is nicer.
Right; we also shouldn't call it "thp_split_page" here :)

-- 
Cheers,

David / dhildenb


