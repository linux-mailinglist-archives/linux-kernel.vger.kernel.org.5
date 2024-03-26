Return-Path: <linux-kernel+bounces-119102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D888C430
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C842EB23025
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C374E2E;
	Tue, 26 Mar 2024 13:57:56 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD67125C9;
	Tue, 26 Mar 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461476; cv=none; b=jYfZBrw7GOdi/BSxff686bO2GRCR9wxi0N3oRlvom1ahL0jsSMan25w59xjrzWqTUUD791idh3iaJJ4+6OmbKG63xPUuGnjW9kSInBdcQcgRNfq59CH67O8zGWQRJsJX6Agn1yDZu3sNiuciPOoNYX4uyvQc30vK8PKQmia6tW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461476; c=relaxed/simple;
	bh=CLFfLoPP9OaJ8wUgaocuHNJTFOcQ2uSgPXCCMz/0tII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4WC4fs5Mzaz3no3PyiKFqdcdv4vYOgFDD2OHxR5raM4wRAz1eRzcRdcvzq10MW7pudEvQ4V5zpY268laCR2XbgLdWvOiAaXOmMrmAYfamHdgatApyGMXiKEwBf+BL+kD+IKCYqenlVZxH6mK9+LytxiLFxsF7vZJpu8i16Dyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA3A1E000D;
	Tue, 26 Mar 2024 13:57:42 +0000 (UTC)
Message-ID: <474ed846-672a-4ff0-9d53-cbf8192fee5f@ghiti.fr>
Date: Tue, 26 Mar 2024 14:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 linux-modules@vger.kernel.org, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>
References: <20240325215502.660-1-jarkko@kernel.org>
 <20240325215502.660-2-jarkko@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240325215502.660-2-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jarkko,

On 25/03/2024 22:55, Jarkko Sakkinen wrote:
> Tacing with kprobes while running a monolithic kernel is currently
> impossible due the kernel module allocator dependency.
>
> Address the issue by implementing textmem API for RISC-V.
>
> Link: https://www.sochub.fi # for power on testing new SoC's with a minimal stack
> Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/ # continuation
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v5:
> - No changes, expect removing alloc_execmem() call which should have
>    been part of the previous patch.
> v4:
> - Include linux/execmem.h.
> v3:
> - Architecture independent parts have been split to separate patches.
> - Do not change arch/riscv/kernel/module.c as it is out of scope for
>    this patch set now.
> v2:
> - Better late than never right? :-)
> - Focus only to RISC-V for now to make the patch more digestable. This
>    is the arch where I use the patch on a daily basis to help with QA.
> - Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration.
> ---
>   arch/riscv/Kconfig          |  1 +
>   arch/riscv/kernel/Makefile  |  3 +++
>   arch/riscv/kernel/execmem.c | 22 ++++++++++++++++++++++
>   3 files changed, 26 insertions(+)
>   create mode 100644 arch/riscv/kernel/execmem.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e3142ce531a0..499512fb17ff 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -132,6 +132,7 @@ config RISCV
>   	select HAVE_KPROBES if !XIP_KERNEL
>   	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>   	select HAVE_KRETPROBES if !XIP_KERNEL
> +	select HAVE_ALLOC_EXECMEM if !XIP_KERNEL
>   	# https://github.com/ClangBuiltLinux/linux/issues/1881
>   	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
>   	select HAVE_MOVE_PMD
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 604d6bf7e476..337797f10d3e 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -73,6 +73,9 @@ obj-$(CONFIG_SMP)		+= cpu_ops.o
>   
>   obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
>   obj-$(CONFIG_MODULES)		+= module.o
> +ifeq ($(CONFIG_ALLOC_EXECMEM),y)
> +obj-y				+= execmem.o
> +endif
>   obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>   
>   obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> diff --git a/arch/riscv/kernel/execmem.c b/arch/riscv/kernel/execmem.c
> new file mode 100644
> index 000000000000..3e52522ead32
> --- /dev/null
> +++ b/arch/riscv/kernel/execmem.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/mm.h>
> +#include <linux/execmem.h>
> +#include <linux/vmalloc.h>
> +#include <asm/sections.h>
> +
> +void *alloc_execmem(unsigned long size, gfp_t /* gfp */)
> +{
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> +				    MODULES_END, GFP_KERNEL,
> +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
> +}


The __vmalloc_node_range() line ^^ must be from an old kernel since we 
added VM_FLUSH_RESET_PERMS in 6.8, see 749b94b08005 ("riscv: Fix 
module_alloc() that did not reset the linear mapping permissions").

In addition, I guess module_alloc() should now use alloc_execmem() right?


> +
> +void free_execmem(void *region)
> +{
> +	if (in_interrupt())
> +		pr_warn("In interrupt context: vmalloc may not work.\n");
> +
> +	vfree(region);
> +}


I remember Mike Rapoport sent a patchset to introduce an API for 
executable memory allocation 
(https://lore.kernel.org/linux-mm/20230918072955.2507221-1-rppt@kernel.org/), 
how does this intersect with your work? I don't know the status of his 
patchset though.

Thanks,

Alex


