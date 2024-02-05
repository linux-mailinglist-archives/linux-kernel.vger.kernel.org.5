Return-Path: <linux-kernel+bounces-52074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E98493D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0504EB22F19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B7DBE7D;
	Mon,  5 Feb 2024 06:22:11 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C49BA45
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707114131; cv=none; b=q9WOCbT288NbdI7Xx19oYj0EBqKVTQE7O+s7CaIBiBxn+ykhrq+mMd54Ql0u9s5rD/itRLn9p7w6FwcmHhxd69sYh9lOyjrQWFtELgm5CZhmH3bcjVVe6HSKWa5AyKD7GDmSgLtwNLbZopqko7SufAPxsoKjh9Ph2DgXpxeMaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707114131; c=relaxed/simple;
	bh=n1E9SAggeIq8He3CCq0IU2a7Ti6Dtrns+nYyMulBAeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2PPwbkjIQlqOo1a1WJbvLsKdvwatE8i3xQXH2kqZYhIN9iZn9REnkaEut8DkNN6am/Rn1n++nrh5+4mVh9rDK0bVW183gcJfE9RLcVzuWbjFtROLnf9CtHrbTyRshwt4i/Z0NW/yXv9zMYkPp97LkbzeVlILTiDHRWFBjD9Y8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0F701C0004;
	Mon,  5 Feb 2024 06:22:04 +0000 (UTC)
Message-ID: <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr>
Date: Mon, 5 Feb 2024 07:22:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240205042955.833752-1-apatel@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240205042955.833752-1-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Anup,

On 05/02/2024 05:29, Anup Patel wrote:
> If some of the HARTs are parked by stop machine then IPI-based
> flushing in flush_icache_all() will hang. This hang is observed
> when text patching is invoked by various debug and BPF features.
>
> To avoid this hang, we force use of SBI-based icache flushing
> when patching text.
>
> Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when possible")
> Reported-by: Bjorn Topel <bjorn@kernel.org>
> Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d22501
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/include/asm/cacheflush.h | 7 ++++---
>   arch/riscv/kernel/hibernate.c       | 2 +-
>   arch/riscv/kernel/patch.c           | 4 ++--
>   arch/riscv/mm/cacheflush.c          | 7 ++++---
>   4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index a129dac4521d..561e079f34af 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page *page)
>    * RISC-V doesn't have an instruction to flush parts of the instruction cache,
>    * so instead we just flush the whole thing.
>    */
> -#define flush_icache_range(start, end) flush_icache_all()
> +#define flush_icache_range(start, end) flush_icache_all(true)
> +#define flush_icache_patch_range(start, end) flush_icache_all(false)
>   #define flush_icache_user_page(vma, pg, addr, len) \
>   	flush_icache_mm(vma->vm_mm, 0)
>   
> @@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct page *page)
>   
>   #ifndef CONFIG_SMP
>   
> -#define flush_icache_all() local_flush_icache_all()
> +#define flush_icache_all(want_ipi) local_flush_icache_all()
>   #define flush_icache_mm(mm, local) flush_icache_all()
>   
>   #else /* CONFIG_SMP */
>   
> -void flush_icache_all(void);
> +void flush_icache_all(bool want_ipi);
>   void flush_icache_mm(struct mm_struct *mm, bool local);
>   
>   #endif /* CONFIG_SMP */
> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
> index 671b686c0158..388f10e187ba 100644
> --- a/arch/riscv/kernel/hibernate.c
> +++ b/arch/riscv/kernel/hibernate.c
> @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
>   	} else {
>   		suspend_restore_csrs(hibernate_cpu_context);
>   		flush_tlb_all();
> -		flush_icache_all();
> +		flush_icache_all(true);
>   
>   		/*
>   		 * Tell the hibernation core that we've just restored the memory.
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 37e87fdcf6a0..721e144a7847 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>   	ret = patch_insn_set(tp, c, len);
>   
>   	if (!ret)
> -		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> +		flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp + len);
>   
>   	return ret;
>   }
> @@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>   	ret = patch_insn_write(tp, insns, len);
>   
>   	if (!ret)
> -		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> +		flush_icache_patch_range((uintptr_t) tp, (uintptr_t) tp + len);
>   
>   	return ret;
>   }
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 55a34f2020a8..03cd3d4831ef 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
>   	return local_flush_icache_all();
>   }
>   
> -void flush_icache_all(void)
> +void flush_icache_all(bool want_ipi)
>   {
>   	local_flush_icache_all();
>   
> -	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> +	if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> +	    (!want_ipi || !riscv_use_ipi_for_rfence()))
>   		sbi_remote_fence_i(NULL);
>   	else
>   		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> @@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
>   	struct folio *folio = page_folio(pte_page(pte));
>   
>   	if (!test_bit(PG_dcache_clean, &folio->flags)) {
> -		flush_icache_all();
> +		flush_icache_all(true);
>   		set_bit(PG_dcache_clean, &folio->flags);
>   	}
>   }


Since patch_text_cb() is run on all cpus, couldn't we completely avoid 
any remote icache flush by slightly changing patch_text_cb() instead as 
follows?

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..075c376ed528 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -232,8 +232,8 @@ static int patch_text_cb(void *data)
         if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
                 for (i = 0; ret == 0 && i < patch->ninsns; i++) {
                         len = GET_INSN_LENGTH(patch->insns[i]);
-                       ret = patch_text_nosync(patch->addr + i * len,
- &patch->insns[i], len);
+                       ret = patch_insn_write((u32 *)(patch->addr + i * 
len),
+ &patch->insns[i], len);
                 }
                 atomic_inc(&patch->cpu_count);
         } else {
@@ -242,6 +242,8 @@ static int patch_text_cb(void *data)
                 smp_mb();
         }

+       local_flush_icache_all();
+
         return ret;
  }
  NOKPROBE_SYMBOL(patch_text_cb);




