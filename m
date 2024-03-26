Return-Path: <linux-kernel+bounces-119473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E224688C973
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116561C64FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440D212E75;
	Tue, 26 Mar 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYpX9JlE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A02848A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470891; cv=none; b=Bq+IU6mgUevKihOD7t0ZpMvMP8pjUDaKwZT9Rw2zTmU9lHFRjYq6t3VA8JuEaEFG8sTwhuM4oHV73v4QYr+NzE/wnVuvnHI+MBtjZpxBmLUeX1abHLDOI6/jkvngTOqe7C/JtFQovxGSKxQ72cWG8W+pPbqUl9a00aeFeiU2Zv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470891; c=relaxed/simple;
	bh=4lHc0zbePKfxatFWYGZUrzLrUWizTxqGPCD7t9DAIrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJTRPLKLVuXMZDpqbEkshehBnzCAkTm6NH4pOqVBBQMEi5c1JrlCr3F+sYlG4zSsKxsDGSHh05/nEaqvCIxZhfqkZR9ACiT8M/PNXOf4bfZO/SHS8IE+IN3mvrkJOCieGaLY//qPmp1PeF9G2SZ2Z7C/HHvhARUlHF2o9DTZIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYpX9JlE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711470888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8hsTu7BI+GVxETuGpfcNbQleSqduFWYENp1ZAznz/xA=;
	b=MYpX9JlEyBfg+F+D5ZeV/2aiLmtyw0VPL3fYaQ+NFLm9Bs04PYH6fYCUKOkqZJo/AMKEMZ
	ZPKRU7tnknfvpcYxHDHHJlFxX58bo/gSmrevYK5dCJX/wZdmNyEZshHX8M6erwhY6ivwhQ
	NbLQJKCbymZnwXgFTP7Qmb4e6HwvPhw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Vdhm3PdSNcq_Gurh3V7-eA-1; Tue, 26 Mar 2024 12:34:46 -0400
X-MC-Unique: Vdhm3PdSNcq_Gurh3V7-eA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56865619070so2527248a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470885; x=1712075685;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hsTu7BI+GVxETuGpfcNbQleSqduFWYENp1ZAznz/xA=;
        b=HJGvGSP7oeh2lrvY9CdiQNPbU3LpEy6uLBi1FrlFzJRkemy3zLRZrok1AMTf9nB5Ll
         P0RTmUK8edy1skgyRkpD7Rl6G/BgevJdRN/2SLT/qDm0muo4aJD+xdNmRcgfWaoWpKJz
         96H8/UNHffJw0hm5LgL7Guv0L/dHV/DaZMh90xbAwr+ikcEf8ciWLWI73svqfQizCbQI
         TUavDTI3+IfKDznSbhFgvWDuoBOM3G7KbM4Aerhkq7EVhK/p4OyUeWHJh6eAwRF9kGqJ
         xLft71AHXlqQUlKjOlq00bYJEGk6mj6p1w8F+SpJYyOqg2J9aVeekqqUxLxW4Zf4Z0iv
         WSqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/3WyL87z9z8627HDGfe1fv7ZOBUIwi/qTr4lTARgpstHrFUmheoEpgfQQHYRPNEcJFhafn+P3JHOtKtR4rlh6gLt1Zbh8yTELJi0c
X-Gm-Message-State: AOJu0YwnmO6i1ZxinmVzszHbIXFkGzeZsVPinLXGLzcCmz23XU9KnzQ0
	OiStrxHwYeaiZCqHfYZ8gHMXgjuus+roBqm1jrQv3M1TgQfA1YxqSONg7k8lyzNH1BXaexkzcT6
	PiliDWIhEVh8nDzLa4cIlzJC4BoqWtGUsCwRIKt9jGnJ4u1v0dPP5tQwsjgpuEQ==
X-Received: by 2002:a50:a41e:0:b0:56b:f5ae:c6b2 with SMTP id u30-20020a50a41e000000b0056bf5aec6b2mr248774edb.13.1711470885152;
        Tue, 26 Mar 2024 09:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg6j1ao3dRRimZ0HhaxuSAnghXXpv0SHWvI6J3p5H8mI3R81Ouh6HqDuYbmldI0BhCrgXdzA==
X-Received: by 2002:a50:a41e:0:b0:56b:f5ae:c6b2 with SMTP id u30-20020a50a41e000000b0056bf5aec6b2mr248736edb.13.1711470884643;
        Tue, 26 Mar 2024 09:34:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b0056be85c253fsm4470920edi.95.2024.03.26.09.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 09:34:44 -0700 (PDT)
Message-ID: <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
Date: Tue, 26 Mar 2024 17:34:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
 <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
 <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 17:31, Ryan Roberts wrote:
> On 26/03/2024 16:17, David Hildenbrand wrote:
>> On 15.02.24 13:17, Ryan Roberts wrote:
>>> This is an RFC for a series that aims to reduce the cost and complexity of
>>> ptep_get_lockless() for arm64 when supporting transparent contpte mappings [1].
>>> The approach came from discussion with Mark and David [2].
>>>
>>> It introduces a new helper, ptep_get_lockless_norecency(), which allows the
>>> access and dirty bits in the returned pte to be incorrect. This relaxation
>>> permits arm64's implementation to just read the single target pte, and avoids
>>> having to iterate over the full contpte block to gather the access and dirty
>>> bits, for the contpte case.
>>>
>>> It turns out that none of the call sites using ptep_get_lockless() require
>>> accurate access and dirty bit information, so we can also convert those sites.
>>> Although a couple of places need care (see patches 2 and 3).
>>>
>>> Arguably patch 3 is a bit fragile, given the wide accessibility of
>>> vmf->orig_pte. So it might make sense to drop this patch and stick to using
>>> ptep_get_lockless() in the page fault path. I'm keen to hear opinions.
>>
>> Yes. Especially as we have these pte_same() checks that might just fail now
>> because of wrong accessed/dirty bits?
> 
> Which pte_same() checks are you referring to? I've changed them all to
> pte_same_norecency() which ignores the access/dirty bits when doing the comparison.

I'm reading the patches just now. So I stumbled over that just after I 
wrote that, so I was missing that part from the description here.

> 
>>
>> Likely, we just want to read "the real deal" on both sides of the pte_same()
>> handling.
> 
> Sorry I'm not sure I understand? You mean read the full pte including
> access/dirty? That's the same as dropping the patch, right? Of course if we do
> that, we still have to keep pte_get_lockless() around for this case. In an ideal
> world we would convert everything over to ptep_get_lockless_norecency() and
> delete ptep_get_lockless() to remove the ugliness from arm64.

Yes, agreed. Patch #3 does not look too crazy and it wouldn't really 
affect any architecture.

I do wonder if pte_same_norecency() should be defined per architecture 
and the default would be pte_same(). So we could avoid the mkold etc on 
all other architectures.

-- 
Cheers,

David / dhildenb


