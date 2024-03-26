Return-Path: <linux-kernel+bounces-119632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98488CB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4299B22CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1280050;
	Tue, 26 Mar 2024 17:51:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D624C63A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475486; cv=none; b=jKnYwD6/a+PIutBO06LscbZpVz97QdqDnj4MnsVjzrNU1bax3l4RE4eszlJpLGqLb3/jSvCdNxKXLlGjlSwNWrWAH//5jZFzjL2idgKXaAzI9ptkpl/RzV1O/S427iMGxY9I7gM7H4QszYmdXkH0foThXRIJ5LvhW+9tAEYKPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475486; c=relaxed/simple;
	bh=YrPfWSL4xn801DAkCxDSBoiiI04n2EnnxgVLYlrdwqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQMBl0DDnZpDcaMNNPMBHoeAqecp9sH+VlgMwC2T/mWk0aZBtM8zOEvNMGGRyAzDqn58O6LGaNx5cm/nlXxepFN9ztgPoWiKMCaltTaDSg9nPC4X9t7ziLXFoNlsDaU++MYwOCGiHvm6tnzvyMmcQwcOt6hbBH726aCGUOtxW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732322F4;
	Tue, 26 Mar 2024 10:51:58 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF1E43F64C;
	Tue, 26 Mar 2024 10:51:22 -0700 (PDT)
Message-ID: <86680856-2532-495b-951a-ea7b2b93872f@arm.com>
Date: Tue, 26 Mar 2024 17:51:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] Reduce cost of ptep_get_lockless on arm64
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8bd9e136-8575-4c40-bae2-9b015d823916@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 17:39, David Hildenbrand wrote:
> On 26.03.24 18:32, Ryan Roberts wrote:
>> On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>>>
>>>>>>> Likely, we just want to read "the real deal" on both sides of the pte_same()
>>>>>>> handling.
>>>>>>
>>>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>>>> access/dirty? That's the same as dropping the patch, right? Of course if
>>>>>> we do
>>>>>> that, we still have to keep pte_get_lockless() around for this case. In an
>>>>>> ideal
>>>>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>>>
>>>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect
>>>>> any
>>>>> architecture.
>>>>>
>>>>> I do wonder if pte_same_norecency() should be defined per architecture and the
>>>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>>>> architectures.
>>>>
>>>> Wouldn't that break it's semantics? The "norecency" of
>>>> ptep_get_lockless_norecency() means "recency information in the returned pte
>>>> may
>>>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
>>>> access and dirty bits when you do the comparison".
>>>
>>> My idea was that ptep_get_lockless_norecency() would return the actual result on
>>> these architectures. So e.g., on x86, there would be no actual change in
>>> generated code.
>>
>> I think this is a bad plan... You'll end up with subtle differences between
>> architectures.
>>
>>>
>>> But yes, the documentation of these functions would have to be improved.
>>>
>>> Now I wonder if ptep_get_lockless_norecency() should actively clear
>>> dirty/accessed bits to more easily find any actual issues where the bits still
>>> matter ...
>>
>> I did a version that took that approach. Decided it was not as good as this way
>> though. Now for the life of me, I can't remember my reasoning.
> 
> Maybe because there are some code paths that check accessed/dirty without
> "correctness" implications? For example, if the PTE is already dirty, no need to
> set it dirty etc?

I think I decided I was penalizing the architectures that don't care because all
their ptep_get_norecency() and ptep_get_lockless_norecency() need to explicitly
clear access/dirty. And I would have needed ptep_get_norecency() from day 1 so
that I could feed its result into pte_same().


