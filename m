Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738027DF784
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjKBQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjKBQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:19:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B7D137;
        Thu,  2 Nov 2023 09:19:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9C4E2F4;
        Thu,  2 Nov 2023 09:19:51 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E5E73F738;
        Thu,  2 Nov 2023 09:19:07 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:19:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, catalin.marinas@arm.com,
        bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
Message-ID: <ZUPL-TeBpl1WEN7M@FVFF77S0Q05N.cambridge.arm.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-2-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908144320.2474-2-puranjay12@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Puranjay,

On Fri, Sep 08, 2023 at 02:43:18PM +0000, Puranjay Mohan wrote:
> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
> page, and thus allow multiple BPF programs sharing the a huge (2MB)
> page.
> 
> The bpf_prog_pack allocator that implements the above feature allocates
> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
> this function will be used to copy the code from RW to RX buffer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> Acked-by: Song Liu <song@kernel.org>
> ---
>  arch/arm64/include/asm/patching.h |  1 +
>  arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
> index 68908b82b168..f78a0409cbdb 100644
> --- a/arch/arm64/include/asm/patching.h
> +++ b/arch/arm64/include/asm/patching.h
> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>  int aarch64_insn_write(void *addr, u32 insn);
>  
>  int aarch64_insn_write_literal_u64(void *addr, u64 val);
> +void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>  
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index b4835f6d594b..243d6ae8d2d8 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>  	return ret;
>  }
>  
> +/**
> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
> + * @dst: address to modify
> + * @src: source of the copy
> + * @len: length to copy
> + *
> + * Useful for JITs to dump new code blocks into unused regions of RX memory.
> + */
> +noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
> +{
> +	unsigned long flags;
> +	size_t patched = 0;
> +	size_t size;
> +	void *waddr;
> +	void *ptr;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&patch_lock, flags);
> +
> +	while (patched < len) {
> +		ptr = dst + patched;
> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
> +			     len - patched);
> +
> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
> +		ret = copy_to_kernel_nofault(waddr, src + patched, size);
> +		patch_unmap(FIX_TEXT_POKE0);
> +
> +		if (ret < 0) {
> +			raw_spin_unlock_irqrestore(&patch_lock, flags);
> +			return NULL;
> +		}
> +		patched += size;
> +	}
> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
> +
> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);

As Xu mentioned, either this needs to use flush_icache_range() to IPI all CPUs
in the system, or we need to make it the caller's responsibility to do that.

Otherwise, I think this is functionally ok, but I'm not certain that it's good
for BPF to be using the FIX_TEXT_POKE0 slot as that will serialize all BPF
loading, ftrace, kprobes, etc against one another. Do we ever expect to load
multiple BPF programs in parallel, or is that serialized at a higher level?

Thanks,
Mark.
