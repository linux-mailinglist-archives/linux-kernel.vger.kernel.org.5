Return-Path: <linux-kernel+bounces-145586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283E8A5820
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD51F21CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A88248E;
	Mon, 15 Apr 2024 16:50:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F57823B5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199817; cv=none; b=U1Nl6SJOx8DGS9NURgIMsQ4R7RuhneMq5gMaEnTyO5alf8dX1qOzusTzOdFuJgUPCquL+JLZQubjLtlkJv0q7GLTSutqWlssKjKFP4X/JfOIwRAE2NZUAPxzH7niYWvJfU/wYM+uRC+tglKn6A0GCJobsJw8NpW7e8gCQjP2Jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199817; c=relaxed/simple;
	bh=HLZhuGcBM5C+fwuEEhkhLoU2r5F1x5SzjVb5yqG/7cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kak/8O5qkelC5nlQO339UA/eYxImkXHeEkSn2yjGR/TjTz6ccvCez3WJXVqE7uW5YUXMeuWiTyDYJgoMY4nD+vJge9h+p+pOpzsJBDMx6AWvtHqPkiJVfnuHdj3Pd59Cjygo703IVl//6Y5ovOGVTHR0KDB5hrBLbHU4lMz3TAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70D6C113CC;
	Mon, 15 Apr 2024 16:50:14 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH V2] arm64/hugetlb: Fix page table walk in huge_pte_alloc()
Date: Mon, 15 Apr 2024 17:50:12 +0100
Message-Id: <171319980749.132738.11475383267559280969.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240415094003.1812018-1-anshuman.khandual@arm.com>
References: <20240415094003.1812018-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Apr 2024 15:10:03 +0530, Anshuman Khandual wrote:
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
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/hugetlb: Fix page table walk in huge_pte_alloc()
      https://git.kernel.org/arm64/c/015a12a4a670

-- 
Catalin


