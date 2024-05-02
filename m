Return-Path: <linux-kernel+bounces-166528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB448B9BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2DC1C20C61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6913C67F;
	Thu,  2 May 2024 13:47:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6412DDBF;
	Thu,  2 May 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657634; cv=none; b=et6hXQxDb1yaYh9tTgqc1GuE0QX5x46S+Y1lT13bohDSwnukCYMEl9+rKldu+OuYGJLmhi14BSKdKgDhEg1Ar53y69g7c7HX5a8afk8LSrjkKv/+n7ywt++nVh8F13lN8Fqx7BbDiEt9Lb79BJ5qNXAMxmHP6lEm2p1HpkUT2BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657634; c=relaxed/simple;
	bh=fBzUvqjwf3rMXOX/TEUF7dBRHEWsyfdKpPRDIqtC7V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tlyo8JZXEWknXybs4HLUW86+4IqDFe+cEh9qRw5hVEHeHyFBpj6W7cHt7vWh7w0x6Y8gpkG02haWNc2pCM0t9M3X0SdhmSrSc+dhUUleJF5Pu3OQORHbljqTCThkXkZCRMbBUdfAQdVtJMfy7a0/pZgIdycU1dTq4zAE1VcOGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48D92F4;
	Thu,  2 May 2024 06:47:36 -0700 (PDT)
Received: from [10.1.37.181] (XHFQ2J9959.cambridge.arm.com [10.1.37.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11C9D3F73F;
	Thu,  2 May 2024 06:47:06 -0700 (PDT)
Message-ID: <60739cf6-42ff-44c7-8e33-6c42eed71a66@arm.com>
Date: Thu, 2 May 2024 14:47:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Zi Yan
 <zi.yan@cs.rutgers.edu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
 <3d88297b-ce6f-4b97-8a25-75f0987af6fd@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <3d88297b-ce6f-4b97-8a25-75f0987af6fd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 14:08, David Hildenbrand wrote:
> On 01.05.24 16:33, Ryan Roberts wrote:
>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>> (non-present) migration entry. It calls pmdp_invalidate()
>> unconditionally on the pmdp and only determines if it is present or not
>> based on the returned old pmd. This is a problem for the migration entry
>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>> called for a present pmd.
>>
>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>> future call to pmd_present() will return true. And therefore any
>> lockless pgtable walker could see the migration entry pmd in this state
>> and start interpretting the fields as if it were present, leading to
>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>
>> x86 does not suffer the above problem, but instead pmd_mkinvalid() will
>> corrupt the offset field of the swap entry within the swap pte. See link
>> below for discussion of that problem.
> 
> Could that explain:
> 
> https://lore.kernel.org/all/YjoGbhreg8lGCGIJ@linutronix.de/
> 
> Where the PFN of a migration entry might have been corrupted?

Ahh interesting! Yes, it seems to fit...

> 
> Ccing Felix

Are you able to reliably reproduce the bug, Felix? If so, would you mind trying
with this patch to see if it goes away?

> 
> 
> Patch itself looks good to me
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!


