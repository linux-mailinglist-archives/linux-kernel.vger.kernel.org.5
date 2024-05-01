Return-Path: <linux-kernel+bounces-165023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D58B86BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F131F23F02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCE4E1C8;
	Wed,  1 May 2024 08:05:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95D28DC7;
	Wed,  1 May 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550723; cv=none; b=NJLpnn+PWtbQpsLNhbJJc1BndKrtWoZiD1pM8dQCXJoZY0N6okw4Q8xLkUru1bXfnooT/PI4V9j0BdoKiuqPQiUAGcyxeIDS4oGpJ7hSWv86UMerEj1T8wc5dizDJbAhQg8ckTPAM5cTgCnDEJ7hwKlZ/IjPRPiQABXep3hcSic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550723; c=relaxed/simple;
	bh=2HevmY/Q4C4rLB+9s4SmfYOSFdV6Ae/J6fu9OaszjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYCMtWxzQORBTLOn3rRuBoPWRL9i6Aj9qgHsMBmtL5qQs19PaS45F4/IiGOscT4lI/27kZ4SGBze57SDubf9UX+fvFeJTrK3LOZZ4q0d4RyCZze0nOti8MFVPUCohTpcUje+JJAnCBAnj4BsbBEY5/ehzwDBFKYGpb8N5YkBLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D8B2F4;
	Wed,  1 May 2024 01:05:46 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9D663F793;
	Wed,  1 May 2024 01:05:18 -0700 (PDT)
Message-ID: <e0624ca9-b321-479e-9b64-59a4cd242f6d@arm.com>
Date: Wed, 1 May 2024 09:05:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <171449974870.639201.3165060270571039049.b4-ty@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <171449974870.639201.3165060270571039049.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 18:57, Catalin Marinas wrote:
> On Tue, 30 Apr 2024 14:31:38 +0100, Ryan Roberts wrote:
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or not
>> based on the returned old pmd.
>>
>> But arm64's pmd_mkinvalid(), called by pmdp_invalidate(),
>> unconditionally sets the PMD_PRESENT_INVALID flag, which causes future
>> pmd_present() calls to return true - even for a swap pmd. Therefore any
>> lockless pgtable walker could see the migration entry pmd in this state
>> and start interpretting the fields (e.g. pmd_pfn()) as if it were
>> present, leading to BadThings (TM). GUP-fast appears to be one such
>> lockless pgtable walker.
>>
>> [...]
> 
> Applied to arm64 (for-next/fixes), thanks! It should land in 6.9-rc7. I
> removed the debug/test code, please send it as a separate patch for
> 6.10.

Thanks Catalin! I'm guessing this will turn up in today's linux-next, so if I
send the tests today and Andrew puts them straight in mm-unstable (which will
goto linux-next) there is no risk that the tests are there without the fix? Or
do I need to hold off until the fix is in v6.9-rc7?

> 
> [1/1] arm64/mm: pmd_mkinvalid() must handle swap pmds
>       https://git.kernel.org/arm64/c/e783331c7720
> 


