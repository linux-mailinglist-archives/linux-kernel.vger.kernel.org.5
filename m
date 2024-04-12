Return-Path: <linux-kernel+bounces-143292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4E8A36E4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C7F1F25B01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727311514F4;
	Fri, 12 Apr 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9y+NxBu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F643AC1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953000; cv=none; b=nxVTFZYVeNbotra1KY+Dng7Sq7kUlvgqQoZaJgfOfwuwbPE+rqgBb6nCOuFWMH+uWZD8WvcoIOJeqL38JB1hLc9MyYcxClAGfaBFzanr7mI6etu4offVO2A7YAiLHXAFlU/UgJypGxCmwfiux4zlg1sAAZEEqhVwtyMv+iJ8czM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953000; c=relaxed/simple;
	bh=Svlt8fuBsrxZhO95FxYXzFmN/4bxERi6CSfq+ayTkNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gR+4ZqPUBmo8+Xqgm0XTtFegOhdXBh0ilyqLP0W7hXLIkV2n7GXLveay61BdBLCd4JwmjL8Z0w2wn/pe9dz0edQDpPPRKft1xLkD+yJc7wQ3OZeWzN6amNqlYBnnOKLC/cVucR3Kz2w6SrXCvmhDXTzZMMCUEccqtez1nE/vIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9y+NxBu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712952997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cc/PPKL5TIazlxmqlsjG+bL4tNA+7xzfInQzkErNbQM=;
	b=d9y+NxBu2kblDAKcsbRCRvFCnoRf8dIghfj0e1oCNY0XcYPFUwLG90j7HpX5iA84BoFqd2
	MbJVp01SSOi+toKMTHuICMe5JNBRZyqR6wvDxjHlDakcB4iWETgmW7RC8f1Px8jF/8Drm4
	xVTTUEXf0tS6LPRS9AjBAU2vcqdk5vU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-T_rFyp5ePLOMCjHF1jyAgQ-1; Fri, 12 Apr 2024 16:16:36 -0400
X-MC-Unique: T_rFyp5ePLOMCjHF1jyAgQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343c86edeb7so781882f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712952995; x=1713557795;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cc/PPKL5TIazlxmqlsjG+bL4tNA+7xzfInQzkErNbQM=;
        b=E8UO7P9hs4T89fTpzrv5FBf8h9tSOkoLrPbIDfDPZ6TwYSOhRJXNuqgnJOcdbg7Mmk
         NyJYwGHJBxOXU0wdU5R2psqrMdc6F3NkXFJYOW0mPx+HroOd8QTK46l9I6qFffzWRvF9
         E90mw9r/QpthAi6rSJie0svDb1qULhmdZhY49SIVbg2j+eOkAT0DG/B1B93vbE++7hVd
         XnrY+mMHDemXURPCeLDeO4fZUz0NwPDNW0sZWiFm4f2+tZQlGeuyOzXdos0cca3bxy+g
         WIOe8DduqRwfsGrahvqYhH761RbLrIru2kETwM+5WOu9Fo1WUhrCaQWVjjMdM9FSaQvV
         ouMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNjBeNAOL23vZnTUF2+V8mRzYTkUuyhlicplQgtbAsWau0qeZ1irmyOV+e/TEuKLPXTPZHULMGXFEAYyWUq+cNVaph0Uyg8ky6kFvL
X-Gm-Message-State: AOJu0YxhQzUwhQo7LRyJhaQzwmuSAzNftRJZM/ny/BaCP77w3phCiwj8
	EtZYQa+u6d0weGBQZewJnCrWLVmCXzZwtYo8DhZ6/iA90qaz30UYN+i9k+A0QlNNOQ+gXm/W9Bs
	Wli0ylPYoMpbEAmAsrJmC8mwdOpUQ1rZxFansE+WZMfhK8cHT3v0aLM0uG/0Ulg==
X-Received: by 2002:a05:6000:1ccd:b0:347:1c20:f262 with SMTP id bf13-20020a0560001ccd00b003471c20f262mr1475425wrb.16.1712952995000;
        Fri, 12 Apr 2024 13:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG38nlmhQW/trMKJw7fxeAEJ3OfIl1TZk5OsQL/BMrfltCuivUXxeLeG1RndVAoYqVSaDOgtg==
X-Received: by 2002:a05:6000:1ccd:b0:347:1c20:f262 with SMTP id bf13-20020a0560001ccd00b003471c20f262mr1475416wrb.16.1712952994560;
        Fri, 12 Apr 2024 13:16:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:f600:afa2:4e8a:448a:9831? (p200300cbc730f600afa24e8a448a9831.dip0.t-ipconnect.de. [2003:cb:c730:f600:afa2:4e8a:448a:9831])
        by smtp.gmail.com with ESMTPSA id cg14-20020a5d5cce000000b00346d91ddbe3sm3852185wrb.9.2024.04.12.13.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 13:16:34 -0700 (PDT)
Message-ID: <70a36403-aefd-4311-b612-84e602465689@redhat.com>
Date: Fri, 12 Apr 2024 22:16:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
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
 <de143212-49ce-4c30-8bfa-4c0ff613f107@redhat.com>
 <374d8500-4625-4bff-a934-77b5f34cf2ec@arm.com>
 <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
 <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
 <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
 <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
 <35236bbf-3d9a-40e9-84b5-e10e10295c0c@redhat.com>
 <dbc5083b-bf8c-4869-8dc7-5fbf2c88cce8@arm.com>
 <f2aad459-e19c-45e2-a7ab-35383e8c3ba5@redhat.com>
 <4fba71aa-8a63-4a27-8eaf-92a69b2cff0d@arm.com>
 <5a23518b-7974-4b03-bd6e-80ecf6c39484@redhat.com>
 <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <81aa23ca-18b1-4430-9ad1-00a2c5af8fc2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> Yes agreed - 2 types; "lockless walkers that later recheck under PTL" and
> "lockless walkers that never take the PTL".
> 
> Detail: the part about disabling interrupts and TLB flush syncing is
> arch-specifc. That's not how arm64 does it (the hw broadcasts the TLBIs). But
> you make that clear further down.

Yes, but disabling interrupts is also required for RCU-freeing of page 
tables such that they can be walked safely. The TLB flush IPI is 
arch-specific and indeed to sync against PTE invalidation (before 
generic GUP-fast).
[...]

>>>
>>> Could it be this easy? My head is hurting...
>>
>> I think what has to happen is:
>>
>> (1) pte_get_lockless() must return the same value as ptep_get() as long as there
>> are no races. No removal/addition of access/dirty bits etc.
> 
> Today's arm64 ptep_get() guarantees this.
> 
>>
>> (2) Lockless page table walkers that later verify under the PTL can handle
>> serious "garbage PTEs". This is our page fault handler.
> 
> This isn't really a property of a ptep_get_lockless(); its a statement about a
> class of users. I agree with the statement.

Yes. That's a requirement for the user of ptep_get_lockless(), such as 
page fault handlers. Well, mostly "not GUP".

> 
>>
>> (3) Lockless page table walkers that cannot verify under PTL cannot handle
>> arbitrary garbage PTEs. This is GUP-fast. Two options:
>>
>> (3a) pte_get_lockless() can atomically read the PTE: We re-check later if the
>> atomically-read PTE is still unchanged (without PTL). No IPI for TLB flushes
>> required. This is the common case. HW might concurrently set access/dirty bits,
>> so we can race with that. But we don't read garbage.
> 
> Today's arm64 ptep_get() cannot garantee that the access/dirty bits are
> consistent for contpte ptes. That's the bit that complicates the current
> ptep_get_lockless() implementation.
> 
> But the point I was trying to make is that GUP-fast does not actually care about
> *all* the fields being consistent (e.g. access/dirty). So we could spec
> pte_get_lockless() to say that "all fields in the returned pte are guarranteed
> to be self-consistent except for access and dirty information, which may be
> inconsistent if a racing modification occured".

We *might* have KVM in the future want to check that a PTE is dirty, 
such that we can only allow dirty PTEs to be writable in a secondary 
MMU. That's not there yet, but one thing I was discussing on the list 
recently. Burried in:

https://lkml.kernel.org/r/20240320005024.3216282-1-seanjc@google.com

We wouldn't care about racing modifications, as long as MMU notifiers 
will properly notify us when the PTE would lose its dirty bits.

But getting false-positive dirty bits would be problematic.

> 
> This could mean that the access/dirty state *does* change for a given page while
> GUP-fast is walking it, but GUP-fast *doesn't* detect that change. I *think*
> that failing to detect this is benign.

I mean, HW could just set the dirty/access bit immediately after the 
check. So if HW concurrently sets the bit and we don't observe that 
change when we recheck, I think that would be perfectly fine.

> 
> Aside: GUP-fast currently rechecks the pte originally obtained with
> ptep_get_lockless(), using ptep_get(). Is that correct? ptep_get() must conform
> to (1), so either it returns the same pte or it returns a different pte or
> garbage. But that garbage could just happen to be the same as the originally
> obtained pte. So in that case, it would have a false match. I think this needs
> to be changed to ptep_get_lockless()?

I *think* it's fine, because the case where it would make a difference 
(x86-PAE) still requires the TLB flush IPI to sync against PTE changes, 
and that check would likely be wrong in one way or the other. So for 
x86-pae, that check is just moot either way.

That my theory, at least.

(but this "let's fake-read atomically although we don't, but let's do 
like we could in some specific circumstances" is really hard to get)

I was wondering a while ago if we are missing a memory barrier before 
the checl, but I think the one from obtaining the page reference gets 
the job done (at least that's what I remember).

-- 
Cheers,

David / dhildenb


