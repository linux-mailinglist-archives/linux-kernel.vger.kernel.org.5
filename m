Return-Path: <linux-kernel+bounces-119467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217888C95C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25081C2969F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11B1CAA0;
	Tue, 26 Mar 2024 16:31:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A71BF50
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470673; cv=none; b=C3jqsQYDiiWt3fiNyMnH5/dYVqRewpOT+BAa+sYKjX4GYQmZPjH87mPPPbhFtJtHw3z7G6EAV09x2FA87sRPgcNlxE9QqYRyr5TPeglVv1pwOa0gyxjxhzJi7ktMYr8L5ZZhYObAQPfmvM9DyUEuDq71ZZLPVzkvqOi/n7dmdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470673; c=relaxed/simple;
	bh=2f5C4tkfzTlJ21a42KuXQI/22TYKmp8GXHmBCycaH2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQr/ddU8yfQ5ea5GLMHkgwZo64FcisHMx0GusYUT+lhKOBmHMI90hfTJnrsQZCi/AY8Zvo0Cdp5Zp/QrDKYSk8xJuDk2uD80JTlTIaFlwxt64tPnX36kgXEUV2SXxYgTBPM1XDUuOiFtdr0tR4+qVW8Lop6P5b9q1ARBm1Ydplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFD242F4;
	Tue, 26 Mar 2024 09:31:44 -0700 (PDT)
Received: from [10.1.29.179] (XHFQ2J9959.cambridge.arm.com [10.1.29.179])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683FA3F694;
	Tue, 26 Mar 2024 09:31:09 -0700 (PDT)
Message-ID: <d8b3bcf2-495f-42bd-b114-6e3a010644d8@arm.com>
Date: Tue, 26 Mar 2024 16:31:07 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0ae22147-e1a1-4bcb-8a4c-f900f3f8c39e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 16:17, David Hildenbrand wrote:
> On 15.02.24 13:17, Ryan Roberts wrote:
>> This is an RFC for a series that aims to reduce the cost and complexity of
>> ptep_get_lockless() for arm64 when supporting transparent contpte mappings [1].
>> The approach came from discussion with Mark and David [2].
>>
>> It introduces a new helper, ptep_get_lockless_norecency(), which allows the
>> access and dirty bits in the returned pte to be incorrect. This relaxation
>> permits arm64's implementation to just read the single target pte, and avoids
>> having to iterate over the full contpte block to gather the access and dirty
>> bits, for the contpte case.
>>
>> It turns out that none of the call sites using ptep_get_lockless() require
>> accurate access and dirty bit information, so we can also convert those sites.
>> Although a couple of places need care (see patches 2 and 3).
>>
>> Arguably patch 3 is a bit fragile, given the wide accessibility of
>> vmf->orig_pte. So it might make sense to drop this patch and stick to using
>> ptep_get_lockless() in the page fault path. I'm keen to hear opinions.
> 
> Yes. Especially as we have these pte_same() checks that might just fail now
> because of wrong accessed/dirty bits?

Which pte_same() checks are you referring to? I've changed them all to
pte_same_norecency() which ignores the access/dirty bits when doing the comparison.

> 
> Likely, we just want to read "the real deal" on both sides of the pte_same()
> handling.

Sorry I'm not sure I understand? You mean read the full pte including
access/dirty? That's the same as dropping the patch, right? Of course if we do
that, we still have to keep pte_get_lockless() around for this case. In an ideal
world we would convert everything over to ptep_get_lockless_norecency() and
delete ptep_get_lockless() to remove the ugliness from arm64.

> 
>>
>> I've chosen the name "recency" because it's shortish and somewhat descriptive,
>> and is alredy used in a couple of places to mean similar things (see mglru and
>> damon). I'm open to other names if anyone has better ideas.
> 
> Not a native speaker; works for me.
> 
>>
>> If concensus is that this approach is generally acceptable, I intend to create a
>> series in future to do a similar thing with ptep_get() -> ptep_get_norecency().
> 
> Yes, sounds good to me.
> 


