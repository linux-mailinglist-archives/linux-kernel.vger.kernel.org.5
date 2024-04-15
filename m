Return-Path: <linux-kernel+bounces-145404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B34A8A55C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECE41C225B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8741574C02;
	Mon, 15 Apr 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C84mWOEe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669D60EF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193129; cv=none; b=XmoEqjeJiWKHAcDYXclHM0j8oBfHlQF38J7Hw7ALO7clrk60gmKlk7vdTL/4Y6vtuhozEs5lJjFAqJZdI16E91lDWJvyJpPzZRjq3C/cdGrm0f7R7evMwhY4TCqkbw5WgGK58r7j7AJdk/dgQAOQtMeY4nlyvyue7oa+Y4hEpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193129; c=relaxed/simple;
	bh=rKrEKZ8BvpoLO6DHAqow8DeAKQF/vh9S6XGT5IRvE+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFUf46UdZ4p19BN35vrasQQQBvoPZJPhImyjha08kqyJdfL6wRwzpDbTpZufjVBXI5TxMm07f7dW5NZP93t0IEywlEHHBMYgf27/N2MpwbeJvkml1KAg7iwyHLXy7jOrfUCUP9VoltxbDrg9K3zCW1RF1bXOInnlmuPfvt6b+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C84mWOEe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XR6bfGt5nwAAveLt+vXF9nePixU+6Vt49K5aFsP/vSI=;
	b=C84mWOEenKLRcJA0ZAgla/C4W6A6sPD05STBN7PaLK/bg+FequFPPv5xbg7zl0FhPl+ff2
	qF3zfMXWyY+epx9eoBe37zmGxkoqQIOIN/4Xr1LkVCkSHmBSZ9F2D/FhGs9uSYrXJHPfKP
	16lDKF9ho9vGeXhQ61YbX01JAQLK61U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-sAeui6fbNXyAwicb4QEBJQ-1; Mon, 15 Apr 2024 10:58:43 -0400
X-MC-Unique: sAeui6fbNXyAwicb4QEBJQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3455cbdea2cso1911569f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193122; x=1713797922;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XR6bfGt5nwAAveLt+vXF9nePixU+6Vt49K5aFsP/vSI=;
        b=Bu44l6V9lDF8mLGJw7pJReHYg8MszhB+0dTz5L3LnfzJFqCLhOBZaIVeEAgjEAO6/r
         NHriZHXv7JFoCONVFMHQI0y3WyfGVkWb8kUgMzB5lJYUyulzuzghBOskAv7lYa76lvGr
         0n6PNxvgNsywD4MbeyV54MBl9mRzTso8c5ZkI37JifmwtaAE5EEDzKkDJEY07B6AqMMe
         vN+QyOJPgSk7Tk4JDCGG/o1DfnXPtHRD5d82ycU16mEzDH95ccbH9BWnyWaeY6Nd3j+L
         5uf/TSxe5jn2C9wC91tzXQdGLe/2Y1mnjYkX7DCYZ/+tBFnUe6wEj6qQyFpiCMVxi+tA
         EUQg==
X-Forwarded-Encrypted: i=1; AJvYcCWmCisjNVCzA6g1a5EGk0iNrhpfhS1geJNp6lqb2/Aj9a8UaCCMNTkYY+6nXltz6ITaCqMiwM4n4Nhz6ym6vRmGM1KEzT+kRISnyYC2
X-Gm-Message-State: AOJu0Yy0OO1RkiqR8WN3s6YrwcZu1ap4nrhy4CznnhvhYW/+GHodh8fG
	I1XPbL2jvVQEhRU9kd1C98ob9C2101M6NK7gu+fi6bBboEUY3QVXM7W00nZZ8qzNwBmoLRsqDj7
	vpc12lBMNPQ71TW93nLmocIiaKq2ubZF9yAIKRrv7Uvan7B0ZBdKPjcZY/ZblIw==
X-Received: by 2002:a05:6000:1841:b0:345:811b:466e with SMTP id c1-20020a056000184100b00345811b466emr8950300wri.26.1713193122514;
        Mon, 15 Apr 2024 07:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7EnFTJwMV4yknQcrF7a652CoJ4BGsKN1Xq47fxDc/COqwUBRpSRdK3QG/bNekSvn6HOhS0w==
X-Received: by 2002:a05:6000:1841:b0:345:811b:466e with SMTP id c1-20020a056000184100b00345811b466emr8950275wri.26.1713193122063;
        Mon, 15 Apr 2024 07:58:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d6991000000b0034615862c64sm12342114wru.110.2024.04.15.07.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 07:58:41 -0700 (PDT)
Message-ID: <11b1c25b-3e20-4acf-9be5-57b508266c5b@redhat.com>
Date: Mon, 15 Apr 2024 16:58:40 +0200
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
 <70a36403-aefd-4311-b612-84e602465689@redhat.com>
 <f13d1e4d-1eea-4379-b683-4d736ad99c2c@arm.com>
 <3e50030d-2289-4470-a727-a293baa21618@redhat.com>
 <772de69a-27fa-4d39-a75d-54600d767ad1@arm.com>
 <969dc6c3-2764-4a35-9fa6-7596832fb2a3@redhat.com>
 <e0b34a1f-ef2e-484e-8d56-4901101dbdbf@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e0b34a1f-ef2e-484e-8d56-4901101dbdbf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.04.24 16:34, Ryan Roberts wrote:
> On 15/04/2024 15:23, David Hildenbrand wrote:
>> On 15.04.24 15:30, Ryan Roberts wrote:
>>> On 15/04/2024 11:57, David Hildenbrand wrote:
>>>> On 15.04.24 11:28, Ryan Roberts wrote:
>>>>> On 12/04/2024 21:16, David Hildenbrand wrote:
>>>>>>>
>>>>>>> Yes agreed - 2 types; "lockless walkers that later recheck under PTL" and
>>>>>>> "lockless walkers that never take the PTL".
>>>>>>>
>>>>>>> Detail: the part about disabling interrupts and TLB flush syncing is
>>>>>>> arch-specifc. That's not how arm64 does it (the hw broadcasts the TLBIs). But
>>>>>>> you make that clear further down.
>>>>>>
>>>>>> Yes, but disabling interrupts is also required for RCU-freeing of page tables
>>>>>> such that they can be walked safely. The TLB flush IPI is arch-specific and
>>>>>> indeed to sync against PTE invalidation (before generic GUP-fast).
>>>>>> [...]
>>>>>>
>>>>>>>>>
>>>>>>>>> Could it be this easy? My head is hurting...
>>>>>>>>
>>>>>>>> I think what has to happen is:
>>>>>>>>
>>>>>>>> (1) pte_get_lockless() must return the same value as ptep_get() as long as
>>>>>>>> there
>>>>>>>> are no races. No removal/addition of access/dirty bits etc.
>>>>>>>
>>>>>>> Today's arm64 ptep_get() guarantees this.
>>>>>>>
>>>>>>>>
>>>>>>>> (2) Lockless page table walkers that later verify under the PTL can handle
>>>>>>>> serious "garbage PTEs". This is our page fault handler.
>>>>>>>
>>>>>>> This isn't really a property of a ptep_get_lockless(); its a statement
>>>>>>> about a
>>>>>>> class of users. I agree with the statement.
>>>>>>
>>>>>> Yes. That's a requirement for the user of ptep_get_lockless(), such as page
>>>>>> fault handlers. Well, mostly "not GUP".
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> (3) Lockless page table walkers that cannot verify under PTL cannot handle
>>>>>>>> arbitrary garbage PTEs. This is GUP-fast. Two options:
>>>>>>>>
>>>>>>>> (3a) pte_get_lockless() can atomically read the PTE: We re-check later if
>>>>>>>> the
>>>>>>>> atomically-read PTE is still unchanged (without PTL). No IPI for TLB flushes
>>>>>>>> required. This is the common case. HW might concurrently set access/dirty
>>>>>>>> bits,
>>>>>>>> so we can race with that. But we don't read garbage.
>>>>>>>
>>>>>>> Today's arm64 ptep_get() cannot garantee that the access/dirty bits are
>>>>>>> consistent for contpte ptes. That's the bit that complicates the current
>>>>>>> ptep_get_lockless() implementation.
>>>>>>>
>>>>>>> But the point I was trying to make is that GUP-fast does not actually care
>>>>>>> about
>>>>>>> *all* the fields being consistent (e.g. access/dirty). So we could spec
>>>>>>> pte_get_lockless() to say that "all fields in the returned pte are
>>>>>>> guarranteed
>>>>>>> to be self-consistent except for access and dirty information, which may be
>>>>>>> inconsistent if a racing modification occured".
>>>>>>
>>>>>> We *might* have KVM in the future want to check that a PTE is dirty, such that
>>>>>> we can only allow dirty PTEs to be writable in a secondary MMU. That's not
>>>>>> there
>>>>>> yet, but one thing I was discussing on the list recently. Burried in:
>>>>>>
>>>>>> https://lkml.kernel.org/r/20240320005024.3216282-1-seanjc@google.com
>>>>>>
>>>>>> We wouldn't care about racing modifications, as long as MMU notifiers will
>>>>>> properly notify us when the PTE would lose its dirty bits.
>>>>>>
>>>>>> But getting false-positive dirty bits would be problematic.
>>>>>>
>>>>>>>
>>>>>>> This could mean that the access/dirty state *does* change for a given page
>>>>>>> while
>>>>>>> GUP-fast is walking it, but GUP-fast *doesn't* detect that change. I *think*
>>>>>>> that failing to detect this is benign.
>>>>>>
>>>>>> I mean, HW could just set the dirty/access bit immediately after the check. So
>>>>>> if HW concurrently sets the bit and we don't observe that change when we
>>>>>> recheck, I think that would be perfectly fine.
>>>>>
>>>>> Yes indeed; that's my point - GUP-fast doesn't care about access/dirty (or
>>>>> soft-dirty or uffd-wp).
>>>>>
>>>>> But if you don't want to change the ptep_get_lockless() spec to explicitly
>>>>> allow
>>>>> this (because you have the KVM use case where false-positive dirty is
>>>>> problematic), then I think we are stuck with ptep_get_lockless() as implemented
>>>>> for arm64 today.
>>>>
>>>> At least regarding the dirty bit, we'd have to guarantee that if
>>>> ptep_get_lockless() returns a false-positive dirty bit, that the PTE recheck
>>>> would be able to catch that.
>>>>
>>>> Would that be possible?
>>>
>>> Hmm maybe. My head hurts. Let me try to work through some examples...
>>>
>>>
>>> Let's imagine for this example, a contpte block is 4 PTEs. Lat's say PTEs 0, 1,
>>> 2 and 3 initially contpte-map order-2 mTHP, FolioA. The dirty state is stored in
>>> PTE0 for the contpte block, and it is dirty.
>>>
>>> Now let's say there are 2 racing threads:
>>>
>>>     - ThreadA is doing a GUP-fast for PTE3
>>>     - ThreadB is remapping order-0 FolioB at PTE0
>>>
>>> (ptep_get_lockless() below is actaully arm64's ptep_get() for the sake of the
>>> example - today's arm64 ptep_get_lockless() can handle the below correctly).
>>>
>>> ThreadA                    ThreadB
>>> =======                    =======
>>>
>>> gup_pte_range()
>>>     pte1 = ptep_get_lockless(PTE3)
>>>       READ_ONCE(PTE3)
>>>                      mmap(PTE0)
>>>                        clear_pte(PTE0)
>>>                          unfold(PTE0 - PTE3)
>>>                            WRITE_ONCE(PTE0, 0)
>>>                            WRITE_ONCE(PTE1, 0)
>>>                            WRITE_ONCE(PTE2, 0)
>>>       READ_ONCE(PTE0) (for a/d) << CLEAN!!
>>>       READ_ONCE(PTE1) (for a/d)
>>>       READ_ONCE(PTE2) (for a/d)
>>>       READ_ONCE(PTE3) (for a/d)
>>>     <do speculative work with pte1 content>
>>>     pte2 = ptep_get_lockless(PTE3)
>>>       READ_ONCE(PTE3)
>>>       READ_ONCE(PTE0) (for a/d)
>>>       READ_ONCE(PTE1) (for a/d)
>>>       READ_ONCE(PTE2) (for a/d)
>>>       READ_ONCE(PTE3) (for a/d)
>>>     true = pte_same(pte1, pte2)
>>>                            WRITE_ONCE(PTE3, 0)
>>>                            TLBI
>>>                            WRITE_ONCE(PTE0, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE1, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE2, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE3, <orig & ~CONT>)
>>>                          WRITE_ONCE(PTE0, 0)
>>>                        set_pte_at(PTE0, <new>)
>>>
>>> This example shows how a *false-negative* can be returned for the dirty state,
>>> which isn't detected by the check.
>>>
>>> I've been unable to come up with an example where a *false-positive* can be
>>> returned for dirty state without the second ptep_get_lockless() noticing. In
>>> this second example, let's assume everything is the same execpt FolioA is
>>> initially clean:
>>>
>>> ThreadA                    ThreadB
>>> =======                    =======
>>>
>>> gup_pte_range()
>>>     pte1 = ptep_get_lockless(PTE3)
>>>       READ_ONCE(PTE3)
>>>                      mmap(PTE0)
>>>                        clear_pte(PTE0)
>>>                          unfold(PTE0 - PTE3)
>>>                            WRITE_ONCE(PTE0, 0)
>>>                            WRITE_ONCE(PTE1, 0)
>>>                            WRITE_ONCE(PTE2, 0)
>>>                            WRITE_ONCE(PTE3, 0)
>>>                            TLBI
>>>                            WRITE_ONCE(PTE0, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE1, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE2, <orig & ~CONT>)
>>>                            WRITE_ONCE(PTE3, <orig & ~CONT>)
>>>                          WRITE_ONCE(PTE0, 0)
>>>                        set_pte_at(PTE0, <new>)
>>>                      write to FolioB - HW sets PTE0's dirty
>>>       READ_ONCE(PTE0) (for a/d) << DIRTY!!
>>>       READ_ONCE(PTE1) (for a/d)
>>>       READ_ONCE(PTE2) (for a/d)
>>>       READ_ONCE(PTE3) (for a/d)
>>>     <do speculative work with pte1 content>
>>>     pte2 = ptep_get_lockless(PTE3)
>>>       READ_ONCE(PTE3)           << BUT THIS IS FOR FolioB
>>>       READ_ONCE(PTE0) (for a/d)
>>>       READ_ONCE(PTE1) (for a/d)
>>>       READ_ONCE(PTE2) (for a/d)
>>>       READ_ONCE(PTE3) (for a/d)
>>>     false = pte_same(pte1, pte2) << So this fails
>>>
>>> The only way I can see false-positive not being caught in the second example is
>>> if ThreadB subseuently remaps the original folio, so you have an ABA scenario.
>>> But these lockless table walkers are already suseptible to that.
>>>
>>> I think all the same arguments can be extended to the access bit.
>>>
>>>
>>> For me this is all getting rather subtle and difficult to reason about and even
>>> harder to spec in a comprehensible way. The best I could come up with is:
>>>
>>> "All fields in the returned pte are guarranteed to be self-consistent except for
>>> access and dirty information, which may be inconsistent if a racing modification
>>> occured. Additionally it is guranteed that false-positive access and/or dirty
>>> information is not possible if 2 calls are made and both ptes are the same. Only
>>> false-negative access and/or dirty information is possible in this scenario."
>>>
>>> which is starting to sound bonkers. Personally I think we are better off at this
>>> point, just keeping today's arm64 ptep_get_lockless().
>>
>> Remind me again, does arm64 perform an IPI broadcast during a TLB flush that
>> would sync against GUP-fast?
> 
> No, the broadcast is in HW. There is no IPI.

Okay ...

I agree that the semantics are a bit weird, but if we could get rid of 
ptep_get_lockless() on arm64, that would also be nice.


Something I've been thinking of ... just to share what I've had in mind. 
The two types of users we currently have are:

(1) ptep_get_lockless() followed by ptep_get() check under PTL.

(2) ptep_get_lockless() followed by ptep_get() check without PTL.

What if we had the following instead:

(1) ptep_get_lockless() followed by ptep_get() check under PTL.

(2) ptep_get_gup_fast() followed by ptep_get_gup_fast() check without
     PTL.

And on arm64 let

(1) ptep_get_lockless() be ptep_get()

(2) ptep_get_gup_fast() be __ptep_get().

That would mean, that (2) would not care if another cont-pte is dirty, 
because we don't collect access+dirty bits. That way, we avoid any races 
with concurrent unfolding etc. The only "problamtic" thing is that 
pte_mkdirty() -> set_ptes() would have to set all cont-PTEs dirty, even 
if any of these already is dirty.

-- 
Cheers,

David / dhildenb


