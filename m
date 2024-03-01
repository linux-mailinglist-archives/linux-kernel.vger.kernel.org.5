Return-Path: <linux-kernel+bounces-88280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6586DF90
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A230F287AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CA96CDB7;
	Fri,  1 Mar 2024 10:45:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345886BFDD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289936; cv=none; b=F3mNmi9zL5fJkiZga3D4PtFnPB2mS7z/Y6rXroG21GolXkCJcDYTcfuMMg8GXBPN0O8753sBJP/hwGPBLfLIc6JdZWspm3OR8dRjMDbSywBh9+Y8x+KyiY9Z0IVuKm3Cq3YT01mFqrj3+Cc3AZ/0cRK5EA0H2037S6IQre0B8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289936; c=relaxed/simple;
	bh=5lvb/vRt2LO7ejrakonBysU24XtvxyoAwDsSHY5s5c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n/NPnrIUvvPt04EP3IPHAl19HS+OGyRdRJCkNRBXWFpGG2TubRc+bsR9OSM/l7suc3rl6+KoPKIgAkSoIWGfpJk5BMosba11uoiclvcBlfuzIMoyc7KVP5gi0P4AuQsZZWz4xrp5/7o7s1Pi1btwTvPtDRniB3JvKbeoaINRpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C3E211FB;
	Fri,  1 Mar 2024 02:46:11 -0800 (PST)
Received: from [10.57.68.58] (unknown [10.57.68.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191AD3F762;
	Fri,  1 Mar 2024 02:45:30 -0800 (PST)
Message-ID: <b99f47f9-18d0-4619-aae7-19274197b85e@arm.com>
Date: Fri, 1 Mar 2024 10:45:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Merge arm64/riscv hugetlbfs contpte support
Content-Language: en-GB
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mm@kvack.org
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexandre,

I confess I haven't looked at the patches yet, but this cover letter raises a
few quesions for me. I'll aim to look at the actual patches in due course.

On 01/03/2024 09:14, Alexandre Ghiti wrote:
> This patchset intends to merge the contiguous ptes hugetlbfs implementation
> of arm64 and riscv.
> 
> Both arm64 and riscv support the use of contiguous ptes to map pages that
> are larger than the default page table size, respectively called contpte
> and svnapot.
> 
> The riscv implementation differs from the arm64's in that the LSBs of the
> pfn of a svnapot pte are used to store the size of the mapping, allowing
> for future sizes to be added (for now only 64KB is supported). That's an
> issue for the core mm code which expects to find the *real* pfn a pte points
> to. Patch 1 fixes that by always returning svnapot ptes with the real pfn
> and restores the size of the mapping when it is written to a page table.

Yes that makes sense to me. The intention for mTHP (!hugetlb) is to fully
encapsulate PTEs beind set_ptes(), ptep_get() and friends, so what's actually
written to the pgtable is arch-specific and well abstracted.

> 
> The following patches are just merges of the 2 different implementations
> that currently exist in arm64 and riscv which are very similar. It paves
> the way to the reuse of the recent contpte THP work by Ryan [1] to avoid
> reimplementing the same in riscv.

You seem to be talking about both hugetlb (which uses the "huge" pte helpers)
and contpte for THP (i.e. mTHP, which uses the regular pte helpers). They are
pretty separate in my mind, so not sure why you would be modifying them both in
the same series?

Thanks,
Ryan

> 
> This patchset was tested by running the libhugetlbfs testsuite with 64KB
> and 2MB pages on both architectures (on a 4KB base page size arm64 kernel).
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-ryan.roberts@arm.com/
> 
> Alexandre Ghiti (9):
>   riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
>   riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
>   mm: Use common huge_ptep_get() function for riscv/arm64
>   mm: Use common set_huge_pte_at() function for riscv/arm64
>   mm: Use common huge_pte_clear() function for riscv/arm64
>   mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
>   mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
>   mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
>   mm: Use common huge_ptep_clear_flush() function for riscv/arm64
> 
>  arch/arm64/Kconfig                  |   1 +
>  arch/arm64/include/asm/pgtable.h    |  59 +++++-
>  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
>  arch/riscv/Kconfig                  |   1 +
>  arch/riscv/include/asm/hugetlb.h    |   2 +-
>  arch/riscv/include/asm/pgtable-64.h |  11 ++
>  arch/riscv/include/asm/pgtable.h    | 120 +++++++++++-
>  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
>  mm/Kconfig                          |   3 +
>  mm/Makefile                         |   1 +
>  mm/contpte.c                        | 268 +++++++++++++++++++++++++
>  11 files changed, 456 insertions(+), 528 deletions(-)
>  create mode 100644 mm/contpte.c
> 


