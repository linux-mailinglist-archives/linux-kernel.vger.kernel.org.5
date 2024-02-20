Return-Path: <linux-kernel+bounces-72831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F885B91A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2011F272AC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED62612FE;
	Tue, 20 Feb 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv53lCXn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54766374C6;
	Tue, 20 Feb 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425042; cv=none; b=svf13cZ485JEfvox6Sty/jtMQTJpnJk6ReTvvXJrK3nsrWEgBkRrVATbVSylltki3e4W4EZgbXilHdtcmSRpcy6Hi3K88FE6qYhlOt4xuEdbsmMHecVrlXjU/t90iv+uVDm1DepL2px1YZTIjU191VvGs7gIJ+TNjRhJK1dFins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425042; c=relaxed/simple;
	bh=rDg/9pQz+JjJErUCeBdP4AE5y1aHUaEqxtVxVjDTBi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjwdvPULu7F8IMtSDbol9PWhciFkrJydt7NfJ3e687331IHvAWflQaO1+zAttu42S6r0HE6heVJ8p/m5KqPpIs8xQ+QPHJGFZn7PQQDy0QK6ux1nDFcsBpN9szyg4D3O+U8x+3OcGrQQA81mTNy6bji0cxX41LIu8A8cawYiPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv53lCXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29965C433F1;
	Tue, 20 Feb 2024 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708425041;
	bh=rDg/9pQz+JjJErUCeBdP4AE5y1aHUaEqxtVxVjDTBi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv53lCXnUxAP5BUjIySykbuaNTQICqKsTGSDQF5bW3u7Cr+yRuZcvocze4Ikb9735
	 OmZ7vuyGPLaOIK9URG/85iZrOPUHhu441cQBZ4LYqviNRoFjJY4A1UvToClldVWpdZ
	 WgUaGuvfKPRL0ZXOQB/sa/C4QRbrlUX5zGSVPsU3+38Q+XNke9VSAYAt/TPV5GELzn
	 L/ju7NOORRvHekikdXfgrCAPpVRFbL0OcFUt+669NBF0PJv7dffBQun7e0a1rxMuZ2
	 OOadaojb0lQUEj7e19sUrNYpqbH75wyAbt18H1D12MTzaSXyN82rpvaYpqFs+fWFsQ
	 qZPHw3iW0X/3Q==
Date: Tue, 20 Feb 2024 12:30:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 09/17] x86: Add KHO support
Message-ID: <ZdR_KQSIrPuEh5G5@kernel.org>
References: <20240117144704.602-1-graf@amazon.com>
 <20240117144704.602-10-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117144704.602-10-graf@amazon.com>

Hi Alex,

On Wed, Jan 17, 2024 at 02:46:56PM +0000, Alexander Graf wrote:
> We now have all bits in place to support KHO kexecs. This patch adds
> awareness of KHO in the kexec file as well as boot path for x86 and
> adds the respective kconfig option to the architecture so that it can
> use KHO successfully.
> 
> In addition, it enlightens it decompression code with KHO so that its
> KASLR location finder only considers memory regions that are not already
> occupied by KHO memory.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v1 -> v2:
> 
>   - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
>   - s/kho_reserve_mem/kho_reserve_previous_mem/g
>   - s/kho_reserve/kho_reserve_scratch/g
> ---
>  arch/x86/Kconfig                      |  3 ++
>  arch/x86/boot/compressed/kaslr.c      | 55 +++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/bootparam.h | 15 +++++++-
>  arch/x86/kernel/e820.c                |  9 +++++
>  arch/x86/kernel/kexec-bzimage64.c     | 39 +++++++++++++++++++
>  arch/x86/kernel/setup.c               | 46 ++++++++++++++++++++++
>  arch/x86/mm/init_32.c                 |  7 ++++
>  arch/x86/mm/init_64.c                 |  7 ++++
>  8 files changed, 180 insertions(+), 1 deletion(-)

..

> @@ -987,8 +1013,26 @@ void __init setup_arch(char **cmdline_p)
>  	cleanup_highmap();
>  
>  	memblock_set_current_limit(ISA_END_ADDRESS);
> +
>  	e820__memblock_setup();
>  
> +	/*
> +	 * We can resize memblocks at this point, let's dump all KHO
> +	 * reservations in and switch from scratch-only to normal allocations
> +	 */
> +	kho_reserve_previous_mem();
> +
> +	/* Allocations now skip scratch mem, return low 1M to the pool */
> +	if (is_kho_boot()) {
> +		u64 i;
> +		phys_addr_t base, end;
> +
> +		__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
> +				     MEMBLOCK_SCRATCH, &base, &end, NULL)
> +			if (end <= ISA_END_ADDRESS)
> +				memblock_clear_scratch(base, end - base);
> +	}

You had to mark lower 16M as MEMBLOCK_SCRATCH because at this point the
mapping of the physical memory is not ready yet and page tables only cover
lower 16M and the memory mapped in kexec::init_pgtable(). Hence the call
for memblock_set_current_limit(ISA_END_ADDRESS) slightly above, which
essentially makes scratch mem reserved by KHO unusable for allocations.

I'd suggest to move kho_reserve_previous_mem() earlier, probably even right
next to kho_populate().
kho_populate() already does memblock_add(scratch) and at that point it's
the only physical memory that memblock knows of, so if it'll have to
allocate, the allocations will end up there.

Also, there are no kernel allocations before e820__memblock_setup(), so the
only memory that might need to be allocated is for memblock_double_array()
and that will be discarded later anyway.

With this, it seems that MEMBLOCK_SCRATCH is not needed, as the scratch
memory is anyway the only usable memory up to e820__memblock_setup().

>  	/*
>  	 * Needs to run after memblock setup because it needs the physical
>  	 * memory size.
> @@ -1104,6 +1148,8 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	arch_reserve_crashkernel();
>  
> +	kho_reserve_scratch();
> +
>  	memblock_find_dma_reserve();
>  
>  	if (!early_xdbc_setup_hardware())
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index b63403d7179d..6c3810afed04 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -20,6 +20,7 @@
>  #include <linux/smp.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
> +#include <linux/kexec.h>
>  #include <linux/pagemap.h>
>  #include <linux/pci.h>
>  #include <linux/pfn.h>
> @@ -738,6 +739,12 @@ void __init mem_init(void)
>  	after_bootmem = 1;
>  	x86_init.hyper.init_after_bootmem();
>  
> +	/*
> +	 * Now that all KHO pages are marked as reserved, let's flip them back
> +	 * to normal pages with accurate refcount.
> +	 */
> +	kho_populate_refcount();

This should go to mm_core_init(), there's nothing architecture specific
there.

> +
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can
>  	 * be detected at build time already.

-- 
Sincerely yours,
Mike.

