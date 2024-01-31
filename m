Return-Path: <linux-kernel+bounces-46607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CFC8441E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78F71F2369A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5B82886;
	Wed, 31 Jan 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MO4S90h8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B982867
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711394; cv=none; b=RZWzgQj2RfTW3F31XCClK4wVs9mcPBt7cF7+Frvz1YdxXSmCvdZ6q8OH2XAlZJKRrwLQ51/WmHXEOvoeX1f+FTZePM6SLJfmmQ0yL1hHxMI4wGVoGPZ2QPyGd2Op+nQlO4lhajdyQQOxly8s6syvsFyyUUovAdmp6S2iLb6FljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711394; c=relaxed/simple;
	bh=S2cw7vXihaf756j59IBh7Mh2bmapWP1zWnAzfiuIaUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUELeZXWJ2nXQAMFrxNGidBwLVPKxSdqdTJHiRB6+YYStsbeh5ySuAyh3bxGyUUS4XNy891cKYj//GXgX486FnCd4h0mXrk0obn3LfXtEPbGkk3Ig3zPtbjDNQtAd1SJgsJV2aVG5UXUjOslQcuYeosdfZU7hKpqEbBQnngj/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MO4S90h8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706711391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZZ8b65xFaoLyifj6soTcCK4V3mFrLiPMpU7F9cu2+Zw=;
	b=MO4S90h8v/5n1JdOQ22szy4MYjo0Y7z+wsOiSBG60+LlR/BIm7H2VsrcqFXStZAlFdsTjj
	VQDsNY0VHzy/lxTTu3wTN/0I1CHQrbPiM4xd0lr/33sFPoURac1CqEa7dyl/LVUW2X0ZhX
	HmApiAynI0W8NlmA9767Ul+1FJZtEFg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-0HQCYKm0PfGFTNteh_cVBQ-1; Wed, 31 Jan 2024 09:29:50 -0500
X-MC-Unique: 0HQCYKm0PfGFTNteh_cVBQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33b0c264adbso92122f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706711389; x=1707316189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ8b65xFaoLyifj6soTcCK4V3mFrLiPMpU7F9cu2+Zw=;
        b=SnS8OD8Sx2vFE1+FM8vkm1bOkkd6kBaujH/n2fjc/wHe2qD/uE7l7xYn4T/SXK2rFj
         8uZ3fZtDpW1n4sSxt+93gYArKVu0m41PWIPUvu6Iav8uGRUgCqv43wE2+cHihpMrTemt
         vcECtyQ5pgL0s9kaqjbszfmP1zI/+ZPvypfKuUkTGuPo3NZVO0cXLK0kUOwLmMi/v/5p
         iXWCGaJHOggXOMqf3YnF0RPMgJVQXuAG45dyITLqmk++YX1hsbjqpQkKmooaLFuP43YP
         t7PVUrzLwsfvcv3bqaX9AGsOeXoNB7RaGhZSwMqwiZ/11s/B0x8fDIN4IV0Uy2vo7uMp
         LSMg==
X-Gm-Message-State: AOJu0YzE2N8sYSOj/4vOOQPRpVlVITAsWBi9vEUsRyVjEC3rEei5MneP
	VU8W7DinUeqSe+BP/+VB++ElrLLKd0f7Ef59+XhBPrY1mKAPCzDVPPs/kRu7wBDbuDDFYa36j80
	JqX5u9H7HnmyGroahTAOt08rSWvMmK54ozZ3ytRo+NXJPvqUkz26T1n5kg6na5g==
X-Received: by 2002:a5d:598b:0:b0:33a:ff6f:608e with SMTP id n11-20020a5d598b000000b0033aff6f608emr1538697wri.39.1706711388907;
        Wed, 31 Jan 2024 06:29:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPGskpVirI8XyVxfxlAH1i9dBAoHA8YDWcFOsNNMi2vRqQHUZE1EbK6vou26NNGCX4WuJG6g==
X-Received: by 2002:a5d:598b:0:b0:33a:ff6f:608e with SMTP id n11-20020a5d598b000000b0033aff6f608emr1538682wri.39.1706711388493;
        Wed, 31 Jan 2024 06:29:48 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b0040d4e1393dcsm1765374wmj.20.2024.01.31.06.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 06:29:48 -0800 (PST)
Message-ID: <74333154-a99b-4bad-81f4-bee02ba05e91@redhat.com>
Date: Wed, 31 Jan 2024 15:29:46 +0100
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
 <a1a0e9b3-dae2-418f-bd63-50e65f471728@redhat.com>
 <57eb82c7-4816-42a2-b5ab-cc221e289b21@arm.com>
 <e6eaba5b-f290-4d1f-990b-a47d89f56ee4@redhat.com>
 <714d0930-2202-48b6-9728-d248f820325e@arm.com>
 <dcaa20c4-bd1f-4f15-bb0a-3a790808937d@arm.com>
 <30718fc8-15cf-41e4-922c-5cdbf00a0840@redhat.com>
 <de975655-8f8f-40dc-b281-75c40dd1e2c1@arm.com>
 <c63870b0-690a-4051-b4f5-296cf3b73be2@redhat.com>
 <a0cdeb7c-dec8-4971-8b54-e6f65ea48ade@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a0cdeb7c-dec8-4971-8b54-e6f65ea48ade@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Note that regarding NUMA effects, I mean when some memory access within the same
>> socket is faster/slower even with only a single node. On AMD EPYC that's
>> possible, depending on which core you are running and on which memory controller
>> the memory you want to access is located. If both are in different quadrants
>> IIUC, the access latency will be different.
> 
> I've configured the NUMA to only bring the RAM and CPUs for a single socket
> online, so I shouldn't be seeing any of these effects. Anyway, I've been using
> the Altra as a secondary because its so much slower than the M2. Let me move
> over to it and see if everything looks more straightforward there.

Better use a system where people will actually run Linux production 
workloads on, even if it is slower :)

[...]

>>>
>>> I'll continue to mess around with it until the end of the day. But I'm not
>>> making any headway, then I'll change tack; I'll just measure the performance of
>>> my contpte changes using your fork/zap stuff as the baseline and post based on
>>> that.
>>
>> You should likely not focus on M2 results. Just pick a representative bare metal
>> machine where you get consistent, explainable results.
>>
>> Nothing in the code is fine-tuned for a particular architecture so far, only
>> order-0 handling is kept separate.
>>
>> BTW: I see the exact same speedups for dontneed that I see for munmap. For
>> example, for order-9, it goes from 0.023412s -> 0.009785, so -58%. So I'm
>> curious why you see a speedup for munmap but not for dontneed.
> 
> Ugh... ok, coming up.

Hopefully you were just staring at the wrong numbers (e.g., only with 
fork patches). Because both (munmap/pte-dontneed) are using the exact 
same code path.

-- 
Cheers,

David / dhildenb


