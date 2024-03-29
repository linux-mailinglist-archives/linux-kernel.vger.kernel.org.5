Return-Path: <linux-kernel+bounces-125076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1055E891FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E51F27DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C61384A3;
	Fri, 29 Mar 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lS36eUjZ"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04288468
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720134; cv=none; b=LPc8u8HNjV5szbESJdwoPf5483Yfk34klL7OrmzB17hMPu9117GxVVnNUMOQX8Gg8eXCVbHmhmzDwo42nBfjjf0c7JM6zX4inWjAMvXP0M7N0prr2ckngG01GlYvueAa3a3ghjPKnDlxyHdGfSKzoby5VSmjoP5VA0kKtDGvJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720134; c=relaxed/simple;
	bh=52dqCNI9p3eFaadsIeqWV2AssXHWOeb6nNHNaeqYjm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU9k6+EYeU2IRH0sirD+KkVRL/q1a3pU+xZznVPUG2rQhgcgk2xOqtanXIdrb7Eq6PxUXnQxKQ0pikdooCep1PeOETy27qxa4T/aYUUNRQbj3Llphv8OyU5DHvX8zy8p5GKDmpvB9ja5K3umk/hV07u0AY8ctTr+PNmm//lLuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lS36eUjZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 Mar 2024 06:48:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711720129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBD9yA2PcZQcS1CfmKPqxRlA80oGVgTIn7Autaav/oY=;
	b=lS36eUjZ+5rnv5gHfj/ZZttGv/BuIVys767edLhgh3OcPBXFK6YChfGozlDquF0Y/xXPo9
	mLzk7DrVslQuRFObOnhY/mkwbRVFQ2deBBsQAX904uoErgFftFU/6T9PA9iOzfrThPvvK+
	C0y8Bqi7u6ZlV61gT0asFDYTnU7SLOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
	David Reaver <me@davidreaver.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to
 smallest block
Message-ID: <ZgbGtpj5mStTkAkn@linux.dev>
References: <cover.1711649501.git.kjlx@templeofstupid.com>
 <ebf0fac84cb1d19bdc6e73576e3cc40a9cab0635.1711649501.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf0fac84cb1d19bdc6e73576e3cc40a9cab0635.1711649501.git.kjlx@templeofstupid.com>
X-Migadu-Flow: FLOW_OUT

Hi Krister,

On Thu, Mar 28, 2024 at 12:05:08PM -0700, Krister Johansen wrote:
> stage2_apply_range() for unmap operations can interfere with the
> performance of IO if the device's interrupts share the CPU where the
> unmap operation is occurring.  commit 5994bc9e05c2 ("KVM: arm64: Limit
> stage2_apply_range() batch size to largest block") improved this.  Prior
> to that commit, workloads that were unfortunate enough to have their IO
> interrupts pinned to the same CPU as the unmap operation would observe a
> complete stall.  With the switch to using the largest block size, it is
> possible for IO to make progress, albeit at a reduced speed.

Can you describe the workload a bit more? I'm having a hard time
understanding how you're unmapping that much memory on the fly in
your workload. Is guest memory getting swapped? Are VMs being torn
down?

Also, it seems a bit odd to steer interrupts *into* the workload you
care about...

> Further reducing the stage2_apply_range() batch size has substantial
> performance improvements for IO that share a CPU performing an unmap
> operation.  By switching to a 2mb chunk, IO performance regressions were
> no longer observed in this author's tests.  E.g. it was possible to
> obtain the advertised device throughput despite an unmap operation
> occurring on the CPU where the interrupt was running.  There is a
> tradeoff, however.  No changes were observed in per-operation timings
> when running the kvm_pagetable_test without an interrupt load.  However,
> with a 64gb VM, 1 vcpu, and 4k pages and a IO load, map times increased
> by about 15% and unmap times increased by about 58%.  In essence, this
> trades slower map/unmap times for improved IO throughput.

There are other users of the range-based operations, like
write-protection. Live migration is especially sensitive to the latency
of page table updates as it can affect the VMM's ability to converge
with the guest.

> Cc: <stable@vger.kernel.org> # 5.15.x: 3b5c082bbfa2: KVM: arm64: Work out supported block level at compile time
> Cc: <stable@vger.kernel.org> # 5.15.x: 5994bc9e05c2: KVM: arm64: Limit stage2_apply_range() batch size to largest block
> Cc: <stable@vger.kernel.org> # 5.15.x

This is a performance improvement, *not* a correctness fix. Please don't
cc stable for it.

> Suggested-by: Ali Saidi <alisaidi@amazon.com>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 4 ++++
>  arch/arm64/kvm/mmu.c                 | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 19278dfe7978..b0c4651a4d9a 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -19,11 +19,15 @@
>   *  - 4K (level 1):	1GB
>   *  - 16K (level 2):	32MB
>   *  - 64K (level 2):	512MB
> + *
> + *  The max block level is the _smallest_ supported block size for KVM.

This feels like a non sequitur given the old comment is left in place...

>   */
>  #ifdef CONFIG_ARM64_4K_PAGES
>  #define KVM_PGTABLE_MIN_BLOCK_LEVEL	1
> +#define KVM_PGTABLE_MAX_BLOCK_LEVEL	2
>  #else
>  #define KVM_PGTABLE_MIN_BLOCK_LEVEL	2
> +#define KVM_PGTABLE_MAX_BLOCK_LEVEL	KVM_PGTABLE_MIN_BLOCK_LEVEL
>  #endif
>  
>  #define kvm_lpa2_is_enabled()		system_supports_lpa2()
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index dc04bc767865..1e927b306aee 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -41,7 +41,7 @@ static phys_addr_t __stage2_range_addr_end(phys_addr_t addr, phys_addr_t end,
>  
>  static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
>  {
> -	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL);
> +	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MAX_BLOCK_LEVEL);
>  
>  	return __stage2_range_addr_end(addr, end, size);
>  }

This doesn't feel right to me. A property that we had before is that
leaf entries are visited at most once, since every mapping size was
evenly divisible into KVM_PGTABLE_MIN_BLOCK_LEVEL.

Seems like we could wind up visiting a PUD mapping 512 times, at least
for 4K pages.

-- 
Thanks,
Oliver

