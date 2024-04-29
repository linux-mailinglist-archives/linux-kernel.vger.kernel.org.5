Return-Path: <linux-kernel+bounces-161783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A48B5129
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E371C21393
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2711CB4;
	Mon, 29 Apr 2024 06:17:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D7E1118A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371478; cv=none; b=hbPWpQG3zo+SJcndOa4aRUjRF4r1FQvqVL0r5WU0kg+vaRKPDhgCl497DRbX9OhBtSCNBEp7GcInWUUvvEiGzndiZuMs9KXgDZh6367ArdlXjAkJ3/ddYXM54BvWrtZOHhBBQyMuDOdgHInrTxCCIQY7GkKjWvBxWhweyllHr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371478; c=relaxed/simple;
	bh=IpaISpLW2ulbyhGxhHwGJXKFLfxjRakpfAu4ofDUPG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhvUsjyf81LLeB5Kl0ElAobmpU+9RfpiBeIADpIoUj2vCw3ORCKTogZoQSNVfVzgv5XdMivhnuwgdLTXp00ITzzEgCpdX2FsgFM/UDpJhmWm8JNIa/vbH6HQAgSnQb4YAGA458neAFnDOe1kGw1H/6ZZzm01Hg7pSCwHiw8h1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A95D2F4;
	Sun, 28 Apr 2024 23:18:22 -0700 (PDT)
Received: from [10.162.42.72] (a077893.blr.arm.com [10.162.42.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2BE23F793;
	Sun, 28 Apr 2024 23:17:52 -0700 (PDT)
Message-ID: <45d59bbe-b8ec-4725-8a4d-c715130036a3@arm.com>
Date: Mon, 29 Apr 2024 11:47:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <E18F9D0B-C855-4252-BEEB-F8B1FA5BCE9E@nvidia.com>
 <4E0ACD41-970E-4EAF-84D7-FFDB5CD49B3E@nvidia.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <4E0ACD41-970E-4EAF-84D7-FFDB5CD49B3E@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/24 02:18, Zi Yan wrote:
> On 27 Apr 2024, at 16:45, Zi Yan wrote:
> 
>> On 27 Apr 2024, at 15:11, John Hubbard wrote:
>>
>>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>>> unconditionally on the pmdp and only determines if it is present or not
>>>>>> based on the returned old pmd. This is a problem for the migration entry
>>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>>>>> called for a present pmd.
>>>>>>
>>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>>>> future call to pmd_present() will return true. And therefore any
>>>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>>>> and start interpretting the fields as if it were present, leading to
>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>>>> I suspect the same is possible on other architectures.
>>>>>>
>>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>>>>> Yes, this seems like a good design decision (after reading through the
>>>>> discussion that you all had in the other threads).
>>>> This will only be good for arm64 and does not prevent other arch developers
>>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can turn
>>>> a swap entry to a pmd_present() entry.
>>> Well, let's characterize it in a bit more detail, then:
>>>
>>> 1) This patch will make things better for arm64. That's important!
>>>
>>> 2) Equally important, this patch does not make anything worse for
>>>    other CPU arches.
>>>
>>> 3) This patch represents a new design constraint on the CPU arch
>>>    layer, and thus requires documentation and whatever enforcement
>>>    we can provide, in order to keep future code out of trouble.
>>>
>>> 3.a) See the VM_WARN_ON() hunks below.
>>>
>>> 3.b) I like the new design constraint, because it is reasonable and
>>>      clearly understandable: don't invalidate a non-present page
>>>      table entry.
>>>
>>> I do wonder if there is somewhere else that this should be documented?
> In terms of documentation, at least in Documentation/mm/arch_pgtable_helpers.rst,
> pmd_mkinvalid() entry needs to add "do not call on an invalid entry as
> it breaks arm64"

s/invalid/non-present ?					^^^^^^^^^^^^^

But validation via mm/debug_vm_pgtable.c would require a predictable return
value from pmd_mkinvalid() e.g return old pmd when the entry is not present.

	ASSERT(pmd = pmd_mkinvalid(pmd)) - when pmd is not present

Otherwise, wondering how the semantics could be validated in the test.

