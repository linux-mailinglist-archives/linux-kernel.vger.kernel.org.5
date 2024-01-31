Return-Path: <linux-kernel+bounces-46312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86694843DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4271C2A4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7078681;
	Wed, 31 Jan 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtC/33LC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DC6DD18
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699227; cv=none; b=FrrbsQzL3vUlLiQ6loHeTATBslNM986QD1hUgmXUQImvio1p5aNpqb1dHNBgdv1OnFVedf9MroDqKtClh/N1w0RhJh6ulCJ9wFbO3nDwalYj4Q40MI8w1Vn+OH7P06W4ol8Y9s8HkCKY6WLNdy7dyDF+1dAKPBIHxY0CnQIjUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699227; c=relaxed/simple;
	bh=y1aOz6OUiR7wW0QMb1injJoBMWIH2KVJ2c55hImj2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9mtl7sZxRMYSiJ9Dxms1zBdeVk57msVfnkezKtzpkdeMHBDA3hH3//KuwRd77pltYPOVVbeNq/Sz6MTG54taAGkrdStvywM4QGj9vVZsLeWGJ8YHJb4HShBmU4+xPB9vw5/ZznaDHbTLDaOP5hr8DucPCz9V7A82Sqz7pNwDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtC/33LC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706699224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EPrRA4G16rNph0HwrpyFZd0WmfVM9XjFuWwPmxCMxPs=;
	b=CtC/33LCoqJBJwl7TsH4fmL12fP25ZzjySKiXds81roVhXV8dXQCqJkUyg2hwYs5cm24Jt
	3HUN3npN61lVsPIdV/ACwP+fy2AL9otjEpmMovVg3r3sPuJ9+oyhgU+9QbBio6igXhmV/G
	OlzyrWmpch7cFIDZPPEI41nFgc3kslg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-iKJAv2gDMXiSqHLPOq6wjA-1; Wed, 31 Jan 2024 06:07:02 -0500
X-MC-Unique: iKJAv2gDMXiSqHLPOq6wjA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33afc40d5b3so705424f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699221; x=1707304021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPrRA4G16rNph0HwrpyFZd0WmfVM9XjFuWwPmxCMxPs=;
        b=i0rsRsiAuMyP0fJ1ePgblbUpqrlxVf+p9N9glsb0i2bmRq74I9Jz7d2aQoRob5x7w9
         LoApRSvRWrV26lCAY8kmoMXQS/1oy8Aoz4S1AO3q3bbSsn6l0u1RYZVdJw2fvBQaaDet
         HmEUTw4ASgaka4h1EbVoNSbqE7Kq08z3Xq9V8S3LozlSHkQNnfj4U/SHsa3XYbXpDBn4
         fHJSuDaCprZpv0ufOhda66/RIfM7oLRkbkw+Zk6XnWczvm51OPt7kTRYffY9b5Tro3lR
         ZvKjRdA3sCNzetovRHPiJEZSO+K4OAdJQaRIHXvqcyTDnJI7DE0On2UQeT4ajfnVn9j5
         MdHw==
X-Gm-Message-State: AOJu0YzFNAlHA/pqDqFrdmKkuwf/GkH4IneaMmUwOvHiJ5WB/HiW53t5
	aGj32Jw70VM7y2HAHllbZt+KmU4k5AQjnulDRtKwOxk5vMYr6ZvMY1ivhqcehW/6bdWp9wVcXEf
	TlzrilIXOMLYm0aKmelwQ78ivuWPMF+UQBapPulNB6y8n2XLHeUDgbn6A8bpLMQ==
X-Received: by 2002:adf:cd0b:0:b0:336:6377:6e3d with SMTP id w11-20020adfcd0b000000b0033663776e3dmr731868wrm.66.1706699221608;
        Wed, 31 Jan 2024 03:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA/lbkXBUTF2Q1hwLU6vcNIzd8zfJwdZPFVoQqQvBcWoL3J9lF0IZkIJXh4wwNAzmG9wj1/Q==
X-Received: by 2002:adf:cd0b:0:b0:336:6377:6e3d with SMTP id w11-20020adfcd0b000000b0033663776e3dmr731857wrm.66.1706699221183;
        Wed, 31 Jan 2024 03:07:01 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id fo4-20020a056000290400b0033af3294417sm6643931wrb.21.2024.01.31.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 03:07:00 -0800 (PST)
Message-ID: <a1a0e9b3-dae2-418f-bd63-50e65f471728@redhat.com>
Date: Wed, 31 Jan 2024 12:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] mm/memory: optimize fork() with PTE-mapped THP
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240129124649.189745-1-david@redhat.com>
 <a335a9d2-9b8f-4eb8-ba22-23a223b59b06@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a335a9d2-9b8f-4eb8-ba22-23a223b59b06@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.01.24 11:43, Ryan Roberts wrote:
> On 29/01/2024 12:46, David Hildenbrand wrote:
>> Now that the rmap overhaul[1] is upstream that provides a clean interface
>> for rmap batching, let's implement PTE batching during fork when processing
>> PTE-mapped THPs.
>>
>> This series is partially based on Ryan's previous work[2] to implement
>> cont-pte support on arm64, but its a complete rewrite based on [1] to
>> optimize all architectures independent of any such PTE bits, and to
>> use the new rmap batching functions that simplify the code and prepare
>> for further rmap accounting changes.
>>
>> We collect consecutive PTEs that map consecutive pages of the same large
>> folio, making sure that the other PTE bits are compatible, and (a) adjust
>> the refcount only once per batch, (b) call rmap handling functions only
>> once per batch and (c) perform batch PTE setting/updates.
>>
>> While this series should be beneficial for adding cont-pte support on
>> ARM64[2], it's one of the requirements for maintaining a total mapcount[3]
>> for large folios with minimal added overhead and further changes[4] that
>> build up on top of the total mapcount.
>>
>> Independent of all that, this series results in a speedup during fork with
>> PTE-mapped THP, which is the default with THPs that are smaller than a PMD
>> (for example, 16KiB to 1024KiB mTHPs for anonymous memory[5]).
>>
>> On an Intel Xeon Silver 4210R CPU, fork'ing with 1GiB of PTE-mapped folios
>> of the same size (stddev < 1%) results in the following runtimes
>> for fork() (shorter is better):
>>
>> Folio Size | v6.8-rc1 |      New | Change
>> ------------------------------------------
>>        4KiB | 0.014328 | 0.014035 |   - 2%
>>       16KiB | 0.014263 | 0.01196  |   -16%
>>       32KiB | 0.014334 | 0.01094  |   -24%
>>       64KiB | 0.014046 | 0.010444 |   -26%
>>      128KiB | 0.014011 | 0.010063 |   -28%
>>      256KiB | 0.013993 | 0.009938 |   -29%
>>      512KiB | 0.013983 | 0.00985  |   -30%
>>     1024KiB | 0.013986 | 0.00982  |   -30%
>>     2048KiB | 0.014305 | 0.010076 |   -30%
> 
> Just a heads up that I'm seeing some strange results on Apple M2. Fork for
> order-0 is seemingly costing ~17% more. I'm using GCC 13.2 and was pretty sure I
> didn't see this problem with version 1; although that was on a different
> baseline and I've thrown the numbers away so will rerun and try to debug this.
> 

So far, on my x86 tests (Intel, AMD EPYC), I was not able to observe 
this. fork() for order-0 was consistently effectively unchanged. Do you 
observe that on other ARM systems as well?


> | kernel      |   mean_rel |   std_rel |
> |:------------|-----------:|----------:|
> | mm-unstable |       0.0% |      1.1% |
> | patch 1     |      -2.3% |      1.3% |
> | patch 10    |      -2.9% |      2.7% |
> | patch 11    |      13.5% |      0.5% |
> | patch 12    |      15.2% |      1.2% |
> | patch 13    |      18.2% |      0.7% |
> | patch 14    |      20.5% |      1.0% |
> | patch 15    |      17.1% |      1.6% |
> | patch 15    |      16.7% |      0.8% |
> 
> fork for order-9 is looking good (-20%), and for the zap series, munmap is
> looking good, but dontneed is looking poor for both order-0 and 9. But one thing
> at a time... let's concentrate on fork order-0 first.

munmap and dontneed end up calling the exact same call paths. So a big 
performance difference is rather surprising and might indicate something 
else.

(I think I told you that I was running in some kind of VMA merging 
problem where one would suddenly get with my benchmark 1 VMA per page. 
The new benchmark below works around that, but I am not sure if that was 
fixed in the meantime)

VMA merging can of course explain a big difference in fork and munmap 
vs. dontneed times, especially when comparing different code base where 
that VMA merging behavior was different.

> 
> Note that I'm still using the "old" benchmark code. Could you resend me the link
> to the new code? Although I don't think there should be any effect for order-0
> anyway, if I understood your changes correctly?

This is the combined one (small and large PTEs):

https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/pte-mapped-folio-benchmarks.c?inline=false

-- 
Cheers,

David / dhildenb


