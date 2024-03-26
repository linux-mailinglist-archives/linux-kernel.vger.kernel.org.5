Return-Path: <linux-kernel+bounces-119602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B388CAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762631C656C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269B1D545;
	Tue, 26 Mar 2024 17:32:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530651CD2D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474361; cv=none; b=qU4NjwkC8MZr78IFOjfrewXvMPNDK0EIncu5z5Iiv/vu7ouG5evkWCNMcSVRGnTpzD/bXumBdvjjJb8184RuqsWraoMwQz4kJFpTmfkgDGHr8ElPBQQZL2USKjarDm324+Kk64bwQyBby8MzZGsguMqLeIjaxMa+60bcY/b6U88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474361; c=relaxed/simple;
	bh=vOF9mPa+/P1UOv/ObCzlRrx/mZT31F+P8zDSgXc7/IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pry2jBsW1ZLodjf4mRN4yFf/CGMCwe9SH2alXdHSi7dClNsjnincqam6PaT4FWDr660mO2H0Yd34udTmZlinEWy4t3NR9jLwwjj7MrFFyxbAuR7MQudJL8+5ohMIG4hQ/7Wj4wPU5Ul/kvmfCaDyyXhEqZGLCTtIjpzVz9FfhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622C22F4;
	Tue, 26 Mar 2024 10:33:12 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B53323F64C;
	Tue, 26 Mar 2024 10:32:36 -0700 (PDT)
Message-ID: <a41b0534-b841-42c2-8c06-41337c35347d@arm.com>
Date: Tue, 26 Mar 2024 17:32:35 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c1218cdb-905b-4896-8e17-109700577cec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 17:04, David Hildenbrand wrote:
>>>>>
>>>>> Likely, we just want to read "the real deal" on both sides of the pte_same()
>>>>> handling.
>>>>
>>>> Sorry I'm not sure I understand? You mean read the full pte including
>>>> access/dirty? That's the same as dropping the patch, right? Of course if we do
>>>> that, we still have to keep pte_get_lockless() around for this case. In an
>>>> ideal
>>>> world we would convert everything over to ptep_get_lockless_norecency() and
>>>> delete ptep_get_lockless() to remove the ugliness from arm64.
>>>
>>> Yes, agreed. Patch #3 does not look too crazy and it wouldn't really affect any
>>> architecture.
>>>
>>> I do wonder if pte_same_norecency() should be defined per architecture and the
>>> default would be pte_same(). So we could avoid the mkold etc on all other
>>> architectures.
>>
>> Wouldn't that break it's semantics? The "norecency" of
>> ptep_get_lockless_norecency() means "recency information in the returned pte may
>> be incorrect". But the "norecency" of pte_same_norecency() means "ignore the
>> access and dirty bits when you do the comparison".
> 
> My idea was that ptep_get_lockless_norecency() would return the actual result on
> these architectures. So e.g., on x86, there would be no actual change in
> generated code.

I think this is a bad plan... You'll end up with subtle differences between
architectures.

> 
> But yes, the documentation of these functions would have to be improved.
> 
> Now I wonder if ptep_get_lockless_norecency() should actively clear
> dirty/accessed bits to more easily find any actual issues where the bits still
> matter ...

I did a version that took that approach. Decided it was not as good as this way
though. Now for the life of me, I can't remember my reasoning.

> 
>>
>> I think you could only do the optimization you describe if you required that
>> pte_same_norecency() would only be given values returned by
>> ptep_get_lockless_norecency() (or ptep_get_norecency()). Even then, its not
>> quite the same; if a page is accessed between gets one will return true and the
>> other false.
> 
> Right.
> 


