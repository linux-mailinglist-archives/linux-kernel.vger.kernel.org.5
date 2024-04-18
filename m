Return-Path: <linux-kernel+bounces-150075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144C8A9A01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925B61C2171E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B638382;
	Thu, 18 Apr 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtC7KXLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCE1E4AD;
	Thu, 18 Apr 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444102; cv=none; b=qJvUWt5goFbSCtKFfQbfy1+AnWgmqChWh0w4ayEkn0X7+qsKUYkd+Y43FMawsPUo0doOClQE7kK2saNKk5S+riSSn6NtikNAhIhYl1fnFdRiThdxiDH+6F98fK/GRpfvoERu7y1mwhZFofVajYrAQFS8cRdzqINfuw7joBEPu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444102; c=relaxed/simple;
	bh=5Gg1cGKKy8xUY1IPDW6LNh+LEVolae4Ho+4aUJeL+nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sknevSAibGndXyA/tUPkNGGIjEoM4LhR+bIT6247szwS9KKirAo/CZ234m/21eFJonXNQoP/G0VMMMT6FBv53llBz3p8q+ofX7GErqezYN9fQQZV+orPjkqu500yxtUZwrW5lsWgGrJ9hEdJCgn01KuR5Y6LXzkSGbU60yjrUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtC7KXLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F318C113CC;
	Thu, 18 Apr 2024 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713444101;
	bh=5Gg1cGKKy8xUY1IPDW6LNh+LEVolae4Ho+4aUJeL+nE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BtC7KXLlU2MWKMuknCac4v0q0WkuRC0gLCVBTgCsJvlKLj0Q1BcuZPTIrz/vGSb6t
	 Ya/T3ZkMMJYdY0GVTm0WxUZ0pVNKW9Wu689lsPx7voDaaT1OsHF5xAvu7F/LS27XkG
	 h9bLsT36smOCiRuXbWqlsw2sdS/xPxU75bdG3xfcHp2hP+0m5qWpQuJqksXq+TeS0U
	 Wdwb2T8r/Y8/7EaWiJCU2ESE1WIVb5YWurFDwZ8az/hmSaPmgIRf3HJMRwKJeEl7xr
	 Tq8bH12Zr+B0O1zxoe4UG9dCavvht3yNO8Hm9QQIG/OlHLYJu7UsCv9eNM3ordhePo
	 yVAiYovW2QLhw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Nam Cao <namcao@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Andreas
 Dilger <adilger@dilger.ca>, linux-riscv@lists.infradead.org, Thomas
 Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "ndesaulniers @ google . com" <ndesaulniers@google.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
In-Reply-To: <20240418131238.636bee2c@namcao>
References: <20240418102943.180510-1-namcao@linutronix.de>
 <20240418131238.636bee2c@namcao>
Date: Thu, 18 Apr 2024 14:41:38 +0200
Message-ID: <87edb2sv0d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nam Cao <namcao@linutronix.de> writes:

> On 2024-04-18 Nam Cao wrote:
>> There is nothing preventing kernel memory allocators from allocating a
>> page that overlaps with PTR_ERR(), except for architecture-specific
>> code that setup memblock.
>>=20
>> It was discovered that RISCV architecture doesn't setup memblock
>> corectly, leading to a page overlapping with PTR_ERR() being allocated,
>> and subsequently crashing the kernel (link in Close: )
>>=20
>> The reported crash has nothing to do with PTR_ERR(): the last page
>> (at address 0xfffff000) being allocated leads to an unexpected
>> arithmetic overflow in ext4; but still, this page shouldn't be
>> allocated in the first place.
>>=20
>> Because PTR_ERR() is an architecture-independent thing, we shouldn't
>> ask every single architecture to set this up. There may be other
>> architectures beside RISCV that have the same problem.
>>=20
>> Fix this one and for all by reserving the physical memory page that
>> may be mapped to the last virtual memory page as part of low memory.
>>=20
>> Unfortunately, this means if there is actual memory at this reserved
>> location, that memory will become inaccessible. However, if this page
>> is not reserved, it can only be accessed as high memory, so this
>> doesn't matter if high memory is not supported. Even if high memory is
>> supported, it is still only one page.
>>=20
>> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base=
are.belong.to.us
>> Signed-off-by: Nam Cao <namcao@linutronix.de>
>> Cc: <stable@vger.kernel.org> # all versions
>
> Sorry, forgot to add:
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Hmm, can't we get rid of the whole check in arch/riscv/mm/init.c for
32b?

--8<--
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe8e159394d8..1e91d5728887 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -196,7 +196,6 @@ early_param("mem", early_mem);
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
-	phys_addr_t max_mapped_addr;
 	phys_addr_t phys_ram_end, vmlinux_start;
=20
 	if (IS_ENABLED(CONFIG_XIP_KERNEL))
@@ -234,21 +233,6 @@ static void __init setup_bootmem(void)
 	if (IS_ENABLED(CONFIG_64BIT))
 		kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
=20
-	/*
-	 * memblock allocator is not aware of the fact that last 4K bytes of
-	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-	 * macro. Make sure that last 4k bytes are not usable by memblock
-	 * if end of dram is equal to maximum addressable memory.  For 64-bit
-	 * kernel, this problem can't happen here as the end of the virtual
-	 * address space is occupied by the kernel mapping then this check must
-	 * be done as soon as the kernel mapping base address is determined.
-	 */
-	if (!IS_ENABLED(CONFIG_64BIT)) {
-		max_mapped_addr =3D __pa(~(ulong)0);
-		if (max_mapped_addr =3D=3D (phys_ram_end - 1))
-			memblock_set_current_limit(max_mapped_addr - 4096);
-	}
-
 	min_low_pfn =3D PFN_UP(phys_ram_base);
 	max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
 	high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
--8<--

Mike hints that's *not* the case
(https://lore.kernel.org/linux-riscv/ZiAkRMUfiPDUGPdL@kernel.org/).
memblock_reserve() should disallow allocation as well, no?

Thanks, and FWIW:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


