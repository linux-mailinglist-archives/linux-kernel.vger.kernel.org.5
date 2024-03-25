Return-Path: <linux-kernel+bounces-116505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BC6889FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3719E297138
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631A6BB5D;
	Mon, 25 Mar 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLZ0+5fM"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A18513D293;
	Mon, 25 Mar 2024 03:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339090; cv=none; b=RwLKJxFu7/I/MJotUcVIASb34cimukt0eeBelp7Sz2Terq6OKnWNJdPgCP63Xq/zXGiRVGWStbPVi9b/bqqNMOcrNGQ69wv4JgOqGF6avsPM0ns2vVNir7hU/WVHL7WcOC18wvdJYxHvP/xD7bKS4s0RZ6qFttu5ILLsLw8fUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339090; c=relaxed/simple;
	bh=XoKAYNsC1LVnrTCTGFxIaUDAokxixDcHSSYKtvErfVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETAMPZWp4svOckATao/dvnLFuS76IKmFyuwPQBSvoG3uoyWfcMo4vfpg375uLTfbOeI0Pwy4BVFGh1UTnLYHvjlJ3bGbPbe9VSu86mgYYuBmf1V7mOwuoKq/FvyhabBDMn3klghtsWMsZfy5RiX8QK/nrQkhHOpbX2GR2hlvzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLZ0+5fM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e74aa08d15so2584403b3a.1;
        Sun, 24 Mar 2024 20:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711339087; x=1711943887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KalME2BOqp46/4QX2VDjgLSuU8wEdEBuuG4+sv8satg=;
        b=XLZ0+5fMuIiJCNPSoFHMOriLZXkrfTJlJzSLrYinnghnIlkkFFekX19zT19kVMI9qD
         qicTGJ41KsmAyyNEFDYz7/yA765S1Z117pLK5jPiObfYqa85beSitqYqZa5seOwkTY94
         7WeDEgBbbJiFsjOiiI0i2rw0UV+dZzEHyxV56d5DExM2yd8zRF4QmPzaG9qKSVNLbh0q
         swKdXkXQ1qSoszB4PICU1EFkvl1UcjhG3smW68WdJVE4X0MWvBGIKIbGHjpvXHNXlVi4
         psHcMUaS2WEQ6Bjdhdtz1iNDUZQQqJ7yl+W38W5j1gxaPsECLr27Wd8b9IjcaEaaSY+z
         86+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711339087; x=1711943887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KalME2BOqp46/4QX2VDjgLSuU8wEdEBuuG4+sv8satg=;
        b=kY2x/WDELsxeBE426ciHocel69WgNtsHPJw4fcz5EgelzPt364StV6FcOQN0mdJbZ+
         y8NOLbRNJk04UNAFf3+DZVK2H8Tn3T6sViJgah4BBgKINQFZ083vY1xnEFb3kctbIZzU
         D1DYFlbIsKS/9on5J69b7d0uPSOzjB2u/9Jd+e2c1vmqbIUXngicYQmBLC38uk24SIz/
         JjnGy19CtF9FIkvOB50xgu3YssGIPpnijp9PpjREIrGSF5jyH4ClGGgUf1cPLvHUgNaK
         dC/ht0Bl72KeqKr3dLEER2R/jIGJjfkchvFRoR4VYcfmwsb4XSqUSp5Q+Lb5YlgX4rOh
         R7ug==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4j9N1FGTZGu5Dg5oskK/u5msMQ+z/wZ6kuuAqoC4ge046rlTZT4opOnA4qlkCMf7x5aALljnCmPzQOMRr4AOH1IL4ozvm/doDdkwzCfYKXly/TfbJt3lOv1rZIoAJf5zeuzNmd8YL8U8tGaqidmM
X-Gm-Message-State: AOJu0YxnKaBdBqSpucdRVGzv11sbK4OHj72pdr+8z89J18jcUhTIyTmU
	26L+SsGPRAOFoKF9Rf31+2izwQIDq4EZJxrOLGYDLj94ZvGXkXji
X-Google-Smtp-Source: AGHT+IFuN3B7OZrsz6SyABbiSwEZqZ066gXiGsPmjmZNsHzxn/nrOavL6XyJXXD0z6FV0aYaeCeBow==
X-Received: by 2002:a05:6a20:6a2a:b0:1a3:c3a9:53b8 with SMTP id p42-20020a056a206a2a00b001a3c3a953b8mr3516193pzk.46.1711339087508;
        Sun, 24 Mar 2024 20:58:07 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([192.184.165.229])
        by smtp.gmail.com with ESMTPSA id c21-20020a170902c1d500b001ddddc8c41fsm3805760plc.157.2024.03.24.20.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 20:58:06 -0700 (PDT)
Date: Sun, 24 Mar 2024 20:58:04 -0700
From: Calvin Owens <jcalvinowens@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch/riscv: Enable kprobes when CONFIG_MODULES=n
Message-ID: <ZgD2TD3NYl8D-Uim@debian-BULLSEYE-live-builder-AMD64>
References: <20240323232908.13261-1-jarkko@kernel.org>
 <20240325115632.04e37297491cadfbbf382767@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325115632.04e37297491cadfbbf382767@kernel.org>

On Monday 03/25 at 11:56 +0900, Masami Hiramatsu wrote:
> Hi Jarkko,
> 
> On Sun, 24 Mar 2024 01:29:08 +0200
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Tracing with kprobes while running a monolithic kernel is currently
> > impossible due the kernel module allocator dependency.
> > 
> > Address the issue by allowing architectures to implement module_alloc()
> > and module_memfree() independent of the module subsystem. An arch tree
> > can signal this by setting HAVE_KPROBES_ALLOC in its Kconfig file.
> > 
> > Realize the feature on RISC-V by separating allocator to module_alloc.c
> > and implementing module_memfree().
> 
> Even though, this involves changes in arch-independent part. So it should
> be solved by generic way. Did you checked Calvin's thread?
> 
> https://lore.kernel.org/all/cover.1709676663.git.jcalvinowens@gmail.com/

FYI, I should have v2 of that series out later this week.

Thanks,
Calvin

> I think, we'd better to introduce `alloc_execmem()`,
> CONFIG_HAVE_ALLOC_EXECMEM and CONFIG_ALLOC_EXECMEM at first
> 
>   config HAVE_ALLOC_EXECMEM
> 	bool
> 
>   config ALLOC_EXECMEM
> 	bool "Executable trampline memory allocation"
> 	depends on MODULES || HAVE_ALLOC_EXECMEM
> 
> And define fallback macro to module_alloc() like this.
> 
> #ifndef CONFIG_HAVE_ALLOC_EXECMEM
> #define alloc_execmem(size, gfp)	module_alloc(size)
> #endif
> 
> Then, introduce a new dependency to kprobes
> 
>   config KPROBES
>   	bool "Kprobes"
> 	select ALLOC_EXECMEM
> 
> and update kprobes to use alloc_execmem and remove module related
> code from it.
> 
> You also should consider using IS_ENABLED(CONFIG_MODULE) in the code to
> avoid using #ifdefs.
> 
> Finally, you can add RISCV implementation patch of HAVE_ALLOC_EXECMEM in the
> next patch.
> 
> Thank you,
> 
> 
> > 
> > Link: https://www.sochub.fi # for power on testing new SoC's with a minimal stack
> > Link: https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/ # continuation
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Better late than never right? :-)
> > - Focus only to RISC-V for now to make the patch more digestable. This
> >   is the arch where I use the patch on a daily basis to help with QA.
> > - Introduce HAVE_KPROBES_ALLOC flag to help with more gradual migration.
> > ---
> >  arch/Kconfig                     |  8 +++++++-
> >  arch/riscv/Kconfig               |  1 +
> >  arch/riscv/kernel/Makefile       |  5 +++++
> >  arch/riscv/kernel/module.c       | 11 -----------
> >  arch/riscv/kernel/module_alloc.c | 28 ++++++++++++++++++++++++++++
> >  kernel/kprobes.c                 | 10 ++++++++++
> >  kernel/trace/trace_kprobe.c      | 18 ++++++++++++++++--
> >  7 files changed, 67 insertions(+), 14 deletions(-)
> >  create mode 100644 arch/riscv/kernel/module_alloc.c
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index a5af0edd3eb8..c931f1de98a7 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -52,7 +52,7 @@ config GENERIC_ENTRY
> >  
> >  config KPROBES
> >  	bool "Kprobes"
> > -	depends on MODULES
> > +	depends on MODULES || HAVE_KPROBES_ALLOC
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> >  	select TASKS_RCU if PREEMPTION
> > @@ -215,6 +215,12 @@ config HAVE_OPTPROBES
> >  config HAVE_KPROBES_ON_FTRACE
> >  	bool
> >  
> > +config HAVE_KPROBES_ALLOC
> > +	bool
> > +	help
> > +	  Architectures that select this option are capable of allocating memory
> > +	  for kprobes withou the kernel module allocator.
> > +
> >  config ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> >  	bool
> >  	help
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e3142ce531a0..4f1b925e83d8 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -132,6 +132,7 @@ config RISCV
> >  	select HAVE_KPROBES if !XIP_KERNEL
> >  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> >  	select HAVE_KRETPROBES if !XIP_KERNEL
> > +	select HAVE_KPROBES_ALLOC if !XIP_KERNEL
> >  	# https://github.com/ClangBuiltLinux/linux/issues/1881
> >  	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> >  	select HAVE_MOVE_PMD
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 604d6bf7e476..46318194bce1 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -73,6 +73,11 @@ obj-$(CONFIG_SMP)		+= cpu_ops.o
> >  
> >  obj-$(CONFIG_RISCV_BOOT_SPINWAIT) += cpu_ops_spinwait.o
> >  obj-$(CONFIG_MODULES)		+= module.o
> > +ifeq ($(CONFIG_MODULES),y)
> > +obj-y				+= module_alloc.o
> > +else
> > +obj-$(CONFIG_KPROBES)		+= module_alloc.o
> > +endif
> >  obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
> >  
> >  obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
> > diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> > index 5e5a82644451..cc324b450f2e 100644
> > --- a/arch/riscv/kernel/module.c
> > +++ b/arch/riscv/kernel/module.c
> > @@ -905,17 +905,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> >  	return 0;
> >  }
> >  
> > -#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > -void *module_alloc(unsigned long size)
> > -{
> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> > -				    MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL, VM_FLUSH_RESET_PERMS,
> > -				    NUMA_NO_NODE,
> > -				    __builtin_return_address(0));
> > -}
> > -#endif
> > -
> >  int module_finalize(const Elf_Ehdr *hdr,
> >  		    const Elf_Shdr *sechdrs,
> >  		    struct module *me)
> > diff --git a/arch/riscv/kernel/module_alloc.c b/arch/riscv/kernel/module_alloc.c
> > new file mode 100644
> > index 000000000000..3d9aa8dbca8a
> > --- /dev/null
> > +++ b/arch/riscv/kernel/module_alloc.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  Copyright (c) 2017 Zihao Yu
> > + *  Copyright (c) 2024 Jarkko Sakkinen
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/moduleloader.h>
> > +#include <linux/vmalloc.h>
> > +#include <asm/sections.h>
> > +
> > +#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
> > +void *module_alloc(unsigned long size)
> > +{
> > +	return __vmalloc_node_range(size, 1, MODULES_VADDR,
> > +				    MODULES_END, GFP_KERNEL,
> > +				    PAGE_KERNEL, 0, NUMA_NO_NODE,
> > +				    __builtin_return_address(0));
> > +}
> > +
> > +void module_memfree(void *module_region)
> > +{
> > +	if (in_interrupt())
> > +		pr_warn("In interrupt context: vmalloc may not work.\n");
> > +
> > +	vfree(module_region);
> > +}
> > +#endif
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 9d9095e81792..2c583ab6efc4 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1580,6 +1580,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  		goto out;
> >  	}
> >  
> > +#ifdef CONFIG_MODULES
> >  	/* Check if 'p' is probing a module. */
> >  	*probed_mod = __module_text_address((unsigned long) p->addr);
> >  	if (*probed_mod) {
> > @@ -1603,6 +1604,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
> >  			ret = -ENOENT;
> >  		}
> >  	}
> > +#endif
> > +
> >  out:
> >  	preempt_enable();
> >  	jump_label_unlock();
> > @@ -2482,6 +2485,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  /* Remove all symbols in given area from kprobe blacklist */
> >  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
> >  {
> > @@ -2499,6 +2503,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
> >  {
> >  	kprobe_remove_area_blacklist(entry, entry + 1);
> >  }
> > +#endif /* CONFIG_MODULES */
> >  
> >  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
> >  				   char *type, char *sym)
> > @@ -2564,6 +2569,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
> >  	return ret ? : arch_populate_kprobe_blacklist();
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  static void add_module_kprobe_blacklist(struct module *mod)
> >  {
> >  	unsigned long start, end;
> > @@ -2665,6 +2671,7 @@ static struct notifier_block kprobe_module_nb = {
> >  	.notifier_call = kprobes_module_callback,
> >  	.priority = 0
> >  };
> > +#endif /* CONFIG_MODULES */
> >  
> >  void kprobe_free_init_mem(void)
> >  {
> > @@ -2724,8 +2731,11 @@ static int __init init_kprobes(void)
> >  	err = arch_init_kprobes();
> >  	if (!err)
> >  		err = register_die_notifier(&kprobe_exceptions_nb);
> > +
> > +#ifdef CONFIG_MODULES
> >  	if (!err)
> >  		err = register_module_notifier(&kprobe_module_nb);
> > +#endif
> >  
> >  	kprobes_initialized = (err == 0);
> >  	kprobe_sysctls_init();
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index c4c6e0e0068b..f8fbd5e76dda 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -111,6 +111,7 @@ static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
> >  	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  {
> >  	char *p;
> > @@ -129,6 +130,7 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> >  
> >  	return ret;
> >  }
> > +#endif /* CONFIG_MODULES */
> >  
> >  static bool trace_kprobe_is_busy(struct dyn_event *ev)
> >  {
> > @@ -608,7 +610,11 @@ static int append_trace_kprobe(struct trace_kprobe *tk, struct trace_kprobe *to)
> >  
> >  	/* Register k*probe */
> >  	ret = __register_trace_kprobe(tk);
> > -	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
> > +#ifdef CONFIG_MODULES
> > +	if (ret == -ENOENT && trace_kprobe_module_exist(tk))
> > +		ret = 0;
> > +#endif /* CONFIG_MODULES */
> > +	if (ret == -ENOENT) {
> >  		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
> >  		ret = 0;
> >  	}
> > @@ -655,7 +661,11 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> >  
> >  	/* Register k*probe */
> >  	ret = __register_trace_kprobe(tk);
> > -	if (ret == -ENOENT && !trace_kprobe_module_exist(tk)) {
> > +#ifdef CONFIG_MODULES
> > +	if (ret == -ENOENT && trace_kprobe_module_exist(tk))
> > +		ret = 0;
> > +#endif /* CONFIG_MODULES */
> > +	if (ret == -ENOENT) {
> >  		pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
> >  		ret = 0;
> >  	}
> > @@ -670,6 +680,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_MODULES
> >  /* Module notifier call back, checking event on the module */
> >  static int trace_kprobe_module_callback(struct notifier_block *nb,
> >  				       unsigned long val, void *data)
> > @@ -704,6 +715,7 @@ static struct notifier_block trace_kprobe_module_nb = {
> >  	.notifier_call = trace_kprobe_module_callback,
> >  	.priority = 1	/* Invoked after kprobe module callback */
> >  };
> > +#endif /* CONFIG_MODULES */
> >  
> >  static int count_symbols(void *data, unsigned long unused)
> >  {
> > @@ -1897,8 +1909,10 @@ static __init int init_kprobe_trace_early(void)
> >  	if (ret)
> >  		return ret;
> >  
> > +#ifdef CONFIG_MODULES
> >  	if (register_module_notifier(&trace_kprobe_module_nb))
> >  		return -EINVAL;
> > +#endif /* CONFIG_MODULES */
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.44.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

