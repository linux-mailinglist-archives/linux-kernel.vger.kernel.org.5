Return-Path: <linux-kernel+bounces-144877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49F8A4C15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118D5286470
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE0545BE2;
	Mon, 15 Apr 2024 09:58:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD4D2E419
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175105; cv=none; b=bK+x5mwRZKg2fddXXaAXgN7T65znibjwKX/284NHWKqOeZg3rtAiSxeQv6GqBV8ckjNmzGr6Z72vDUcpIqjuFeluZjH2jsk5+8hMeiYwxr8WWmlZ0JROBvEInaK5ALMZSDvVKNzMlb45WCFTHtJdA7HupOO0DesH0Ao38Qsuujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175105; c=relaxed/simple;
	bh=3xDJfyq4svS7Sm0ef9dwg+/++P5TpTpmYYMOLO77S98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekYl+CpdQShEPBtvrzuinV07D1afyptHv+NiTgd7BH/akyYpudYWODDYnv92gdDN9BkQyG3wuw2GjPhGDDbBBDCyjpG5JRm7c/zwBk1OGBBRcChvFtRDQMmyZX3tV4SoosHvGH7icYqlFmht7Z1EQEv+NWeAXe3gubwppsHRfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBBA2F4;
	Mon, 15 Apr 2024 02:58:50 -0700 (PDT)
Received: from [10.57.75.121] (unknown [10.57.75.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A73F3F792;
	Mon, 15 Apr 2024 02:58:20 -0700 (PDT)
Message-ID: <6dd942e5-2f02-47ca-a348-29cf94decd83@arm.com>
Date: Mon, 15 Apr 2024 10:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64/hugetlb: Fix page table walk in huge_pte_alloc()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>
References: <20240415094003.1812018-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240415094003.1812018-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 10:40, Anshuman Khandual wrote:
> Currently normal HugeTLB fault ends up crashing the kernel, as p4dp derived
> from p4d_offset() is an invalid address when PGTABLE_LEVEL = 5. A p4d level
> entry needs to be allocated when not available while walking the page table
> during HugeTLB faults. Let's call p4d_alloc() to allocate such entries when
> required instead of current p4d_offset().
> 
>  Unable to handle kernel paging request at virtual address ffffffff80000000
>  Mem abort info:
>    ESR = 0x0000000096000005
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x05: level 1 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  swapper pgtable: 4k pages, 52-bit VAs, pgdp=0000000081da9000
>  [ffffffff80000000] pgd=1000000082cec003, p4d=0000000082c32003, pud=0000000000000000
>  Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 1 PID: 108 Comm: high_addr_hugep Not tainted 6.9.0-rc4 #48
>  Hardware name: Foundation-v8A (DT)
>  pstate: 01402005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>  pc : huge_pte_alloc+0xd4/0x334
>  lr : hugetlb_fault+0x1b8/0xc68
>  sp : ffff8000833bbc20
>  x29: ffff8000833bbc20 x28: fff000080080cb58 x27: ffff800082a7cc58
>  x26: 0000000000000000 x25: fff0000800378e40 x24: fff00008008d6c60
>  x23: 00000000de9dbf07 x22: fff0000800378e40 x21: 0004000000000000
>  x20: 0004000000000000 x19: ffffffff80000000 x18: 1ffe00010011d7a1
>  x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000001
>  x14: 0000000000000000 x13: ffff8000816120d0 x12: ffffffffffffffff
>  x11: 0000000000000000 x10: fff00008008ebd0c x9 : 0004000000000000
>  x8 : 0000000000001255 x7 : fff00008003e2000 x6 : 00000000061d54b0
>  x5 : 0000000000001000 x4 : ffffffff80000000 x3 : 0000000000200000
>  x2 : 0000000000000004 x1 : 0000000080000000 x0 : 0000000000000000
>  Call trace:
>  huge_pte_alloc+0xd4/0x334
>  hugetlb_fault+0x1b8/0xc68
>  handle_mm_fault+0x260/0x29c
>  do_page_fault+0xfc/0x47c
>  do_translation_fault+0x68/0x74
>  do_mem_abort+0x44/0x94
>  el0_da+0x2c/0x9c
>  el0t_64_sync_handler+0x70/0xc4
>  el0t_64_sync+0x190/0x194
>  Code: aa000084 cb010084 b24c2c84 8b130c93 (f9400260)
>  ---[ end trace 0000000000000000 ]---
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: a6bbf5d4d9d1 ("arm64: mm: Add definitions to support 5 levels of paging")
> Reported-by: Dev Jain <dev.jain@arm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This patch applies on v6.9-rc4
> 
> Changes in V2:
> 
> - Added NULL check for p4dp
> 
> V1: https://lore.kernel.org/all/20240415063110.1795707-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/mm/hugetlbpage.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0f0e10bb0a95..b872b003a55f 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -276,7 +276,10 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pte_t *ptep = NULL;
>  
>  	pgdp = pgd_offset(mm, addr);
> -	p4dp = p4d_offset(pgdp, addr);
> +	p4dp = p4d_alloc(mm, pgdp, addr);
> +	if (!p4dp)
> +		return NULL;
> +
>  	pudp = pud_alloc(mm, p4dp, addr);
>  	if (!pudp)
>  		return NULL;


