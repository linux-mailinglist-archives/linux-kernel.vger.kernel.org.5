Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79607DF79C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjKBQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:26:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5F7BE3;
        Thu,  2 Nov 2023 09:26:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5B402F4;
        Thu,  2 Nov 2023 09:27:20 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278723F738;
        Thu,  2 Nov 2023 09:26:37 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:26:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 2/3] arm64: patching: Add aarch64_insn_set()
Message-ID: <ZUPNuiYlgADjZMNa@FVFF77S0Q05N.cambridge.arm.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-3-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908144320.2474-3-puranjay12@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:43:19PM +0000, Puranjay Mohan wrote:
> The BPF JIT needs to write invalid instructions to RX regions of memory
> to invalidate removed BPF programs. This needs a function like memset()
> that can work with RX memory.
> 
> Implement aarch64_insn_set() which is similar to text_poke_set() of x86.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 40 +++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index f78a0409cbdb..551933338739 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>  
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +int aarch64_insn_set(void *dst, const u32 insn, size_t len);
>  void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>  
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 243d6ae8d2d8..63d9e0e77806 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -146,6 +146,46 @@ noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>  	return dst;
>  }
>  
> +/**
> + * aarch64_insn_set - memset for RX memory regions.
> + * @dst: address to modify
> + * @c: value to set
> + * @len: length of memory region.
> + *
> + * Useful for JITs to fill regions of RX memory with illegal instructions.
> + */
> +noinstr int aarch64_insn_set(void *dst, const u32 insn, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +
> +	/* A64 instructions must be word aligned */
> +	if ((uintptr_t)dst & 0x3)
> +		return -EINVAL;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		memset32(waddr, insn, size / 4);

Do we need to use a specific instruction passed by the caller, or can we
hard-code a trapping instruction here?

If we don't care about the specific instruction, it'd be best to memset this to
0, as 0x00000000 is UDF #0 (which will trap), and that way memset can use DC
ZVA to zero the memory, which is faster than 4 bytes at a time.

If we did that, we can rename this to something like:

	aarch64_insn_clear(void *dst, size_t len)

> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);

Assuming the point of this is to trap if/when we accidentally execute the freed
instructions, we need an IPI here, and so this should use flush_icache_range()
or make it the caller's responsibility to do so.

Mark.

> +
> +	return 0;
> +}
> +
>  int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>  {
>  	u32 *tp = addr;
> -- 
> 2.40.1
> 
> 
