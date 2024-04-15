Return-Path: <linux-kernel+bounces-144770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5DE8A4A80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD28A1C21591
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2537038389;
	Mon, 15 Apr 2024 08:38:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DDF2CCA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170284; cv=none; b=Tbwuk4Ij5QMro68dZp0Tz3tzYrfISF5+CdnZMBe3rHun2WMtJiYTX/cPIYgPrw3/Zk/lHq3IIfPM9t5dWxYJaYzsP14uD5GglhH5L0vmplfkSDbCBXt239fzNCUTwfXO0GZvWc2Wt8cofytYrWuaaxeq17xHIcQf9c3PDr4tNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170284; c=relaxed/simple;
	bh=OEMJOSvaLxBLKUtAscMEZKqapXHaM5BTNd042hSgfGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvg9Sd4l4wgHRXcb9ihVQf5PN+qm+6SByK39sW5OoX2DnT1fecxJHpq3D65/JCN0XMPMU1E65sJfLL8RkgysUxQFPrsbITELKE1O+jI77v6vFpxhn0ArlsyAEdxDX0NBxd6uJfsop7Afm41TUEooo8jU6ikzwYXseMsVKUKf4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F31E02F;
	Mon, 15 Apr 2024 01:38:30 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A683F64C;
	Mon, 15 Apr 2024 01:38:01 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:37:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] arm64/hugetlb: Fix page table walk in huge_pte_alloc()
Message-ID: <ZhznZiHTAljB8a6U@FVFF77S0Q05N>
References: <20240415063110.1795707-1-anshuman.khandual@arm.com>
 <CAMj1kXFS+9ErLn5VyEFLzqwPBgiZBPLjv2OgsAFQPSN=jPWm+A@mail.gmail.com>
 <5a6cdb94-3849-44bb-81d1-40c9c66852ed@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a6cdb94-3849-44bb-81d1-40c9c66852ed@arm.com>

On Mon, Apr 15, 2024 at 12:22:40PM +0530, Anshuman Khandual wrote:
> 
> 
> On 4/15/24 12:08, Ard Biesheuvel wrote:
> > Hello Anshuman,
> > 
> > On Mon, 15 Apr 2024 at 08:31, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Currently normal HugeTLB fault ends up crashing the kernel, as p4dp derived
> >> from p4d_offset() is an invalid address when PGTABLE_LEVEL = 5. A p4d level
> >> entry needs to be allocated when not available while walking the page table
> >> during HugeTLB faults. Let's call p4d_alloc() to allocate such entries when
> >> required instead of current p4d_offset().
> >>
> >>  Unable to handle kernel paging request at virtual address ffffffff80000000
> >>  Mem abort info:
> >>    ESR = 0x0000000096000005
> >>    EC = 0x25: DABT (current EL), IL = 32 bits
> >>    SET = 0, FnV = 0
> >>    EA = 0, S1PTW = 0
> >>    FSC = 0x05: level 1 translation fault
> >>  Data abort info:
> >>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
> >>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >>  swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000081da9000
> >>  [ffffffff80000000] pgd=1000000082cec003, p4d=0000000082c32003, pud=0000000000000000
> >>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> >>  Modules linked in:
> >>  CPU: 1 PID: 108 Comm: high_addr_hugep Not tainted 6.9.0-rc4 #48
> >>  Hardware name: Foundation-v8A (DT)
> >>  pstate: 01402005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> >>  pc : huge_pte_alloc+0xd4/0x334
> >>  lr : hugetlb_fault+0x1b8/0xc68
> >>  sp : ffff8000833bbc20
> >>  x29: ffff8000833bbc20 x28: fff000080080cb58 x27: ffff800082a7cc58
> >>  x26: 0000000000000000 x25: fff0000800378e40 x24: fff00008008d6c60
> >>  x23: 00000000de9dbf07 x22: fff0000800378e40 x21: 0004000000000000
> >>  x20: 0004000000000000 x19: ffffffff80000000 x18: 1ffe00010011d7a1
> >>  x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000001
> >>  x14: 0000000000000000 x13: ffff8000816120d0 x12: ffffffffffffffff
> >>  x11: 0000000000000000 x10: fff00008008ebd0c x9 : 0004000000000000
> >>  x8 : 0000000000001255 x7 : fff00008003e2000 x6 : 00000000061d54b0
> >>  x5 : 0000000000001000 x4 : ffffffff80000000 x3 : 0000000000200000
> >>  x2 : 0000000000000004 x1 : 0000000080000000 x0 : 0000000000000000
> >>  Call trace:
> >>  huge_pte_alloc+0xd4/0x334
> >>  hugetlb_fault+0x1b8/0xc68
> >>  handle_mm_fault+0x260/0x29c
> >>  do_page_fault+0xfc/0x47c
> >>  do_translation_fault+0x68/0x74
> >>  do_mem_abort+0x44/0x94
> >>  el0_da+0x2c/0x9c
> >>  el0t_64_sync_handler+0x70/0xc4
> >>  el0t_64_sync+0x190/0x194
> >>  Code: aa000084 cb010084 b24c2c84 8b130c93 (f9400260)
> >>  ---[ end trace 0000000000000000 ]---
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Fixes: a6bbf5d4d9d1 ("arm64: mm: Add definitions to support 5 levels of paging")
> >> Reported-by: Dev Jain <dev.jain@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This patch applies on v6.9-rc4
> >>
> >>  arch/arm64/mm/hugetlbpage.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> > 
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > 
> > Thanks for fixing this. One question below.
> > 
> > 
> >> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >> index 0f0e10bb0a95..5c819459555a 100644
> >> --- a/arch/arm64/mm/hugetlbpage.c
> >> +++ b/arch/arm64/mm/hugetlbpage.c
> >> @@ -276,7 +276,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
> >>         pte_t *ptep = NULL;
> >>
> >>         pgdp = pgd_offset(mm, addr);
> >> -       p4dp = p4d_offset(pgdp, addr);
> >> +       p4dp = p4d_alloc(mm, pgdp, addr);
> > 
> > Shouldn't we check p4dp for NULL here?
> 
> Sure, makes sense. I will add a check for p4dp, just like pudp below.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> > 
> >>         pudp = pud_alloc(mm, p4dp, addr);
> >>         if (!pudp)
> >>                 return NULL;
> >> --
> >> 2.25.1
> >>

