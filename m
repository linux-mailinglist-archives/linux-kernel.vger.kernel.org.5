Return-Path: <linux-kernel+bounces-96460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A434B875C76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AAD1C20CC0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA302DF92;
	Fri,  8 Mar 2024 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoB4ofvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609B2E642;
	Fri,  8 Mar 2024 02:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865968; cv=none; b=E+qEPuqHLMCEdoma/t6PFwyOdwx4dZZvKDVPa2QSanQtcFoA+sw1ZwsDbwDhrOr/194Ah9S36xxVgzTJ5PSAJvtJ+jqxzQuy7BLBT7ln2yM6tlmUUEBMkoR9McxpIcW4UolfLHSCR9cC8yfXd7b5QXJrqiw0BkcferTWSXA0fAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865968; c=relaxed/simple;
	bh=8xrRZwXZcCuvmbC8TREQJ90MQaawTnhPh+5bykKMT4s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NLhw/vcfUPS5aKBLswON+rnKxEDnY38aKoDbWt+DKB19pUyo82zkGJMSaoVQzaOjNB3jiCsBz5YGtkgb/UHM6txgYZO5bN9OJnQITebKdt2VojKZnvspkRkyeU2RONHX9+YoUeDzjN7wxAFOHp3Elmcy2YCSEks8dgc6dXmZRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoB4ofvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C0BC43390;
	Fri,  8 Mar 2024 02:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709865968;
	bh=8xrRZwXZcCuvmbC8TREQJ90MQaawTnhPh+5bykKMT4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PoB4ofvK0pJw6o5nobGJf6x57aRoErEoJSsWC3MjNHbYAQy32GqJXAN56xAX5wcat
	 lhB9/6UnCah6TSrrdaw0FBEcTKqxNNu4wmjfURezpuTkx7wAHCpxWb534ERHcqLeVN
	 ME1grFJcV1ZedM3IiDpZoqUQEWbWwyZGvDpeityGO5zvJkdZz4oEtSOCvGCQ9d1qq8
	 lxj7eDm6IJwcol3JoDSgpc/WycAWn/lrm9D0rSfdWSh7HXZtSdONZ6PJIchllUYwGg
	 v9wr3BI4mdWmG/T4NrGmguYtyylR6DwiFqXzyBhtjqseHmIzYRoCQ6yFiV0kNdxgY4
	 rJUPf4/5bw6Jw==
Date: Fri, 8 Mar 2024 11:46:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Calvin Owens <jcalvinowens@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Naveen N Rao
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 3/4] kprobes: Allow kprobes with CONFIG_MODULES=n
Message-Id: <20240308114603.289720cf17ed75ba7bce8779@kernel.org>
In-Reply-To: <2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
	<2af01251ca21d79fa29092505d192f1f1b746cff.1709676663.git.jcalvinowens@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:05:10 -0800
Calvin Owens <jcalvinowens@gmail.com> wrote:

> If something like this is merged down the road, it can go in at leisure
> once the module_alloc change is in: it's a one-way dependency.
> 
> Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> ---
>  arch/Kconfig                |  2 +-
>  kernel/kprobes.c            | 22 ++++++++++++++++++++++
>  kernel/trace/trace_kprobe.c | 11 +++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index cfc24ced16dd..e60ce984d095 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,8 +52,8 @@ config GENERIC_ENTRY
>  
>  config KPROBES
>  	bool "Kprobes"
> -	depends on MODULES
>  	depends on HAVE_KPROBES
> +	select MODULE_ALLOC

OK, if we use EXEC_ALLOC,

config EXEC_ALLOC
	depends on HAVE_EXEC_ALLOC

And 

  config KPROBES
  	bool "Kprobes"
	depends on MODULES || EXEC_ALLOC
	select EXEC_ALLOC if HAVE_EXEC_ALLOC

then kprobes can be enabled either modules supported or exec_alloc is supported.
(new arch does not need to implement exec_alloc)

Maybe we also need something like

#ifdef CONFIG_EXEC_ALLOC
#define module_alloc(size) exec_alloc(size)
#endif

in kprobes.h, or just add `replacing module_alloc with exec_alloc` patch.

Thank you,

>  	select KALLSYMS
>  	select TASKS_RCU if PREEMPTION
>  	help
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e81792..194270e17d57 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1556,8 +1556,12 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
>  		str_has_prefix("__pfx_", symbuf);
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  static int check_kprobe_address_safe(struct kprobe *p,
>  				     struct module **probed_mod)
> +#else
> +static int check_kprobe_address_safe(struct kprobe *p)
> +#endif
>  {
>  	int ret;
>  
> @@ -1580,6 +1584,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		goto out;
>  	}
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  	/* Check if 'p' is probing a module. */
>  	*probed_mod = __module_text_address((unsigned long) p->addr);
>  	if (*probed_mod) {
> @@ -1603,6 +1608,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  			ret = -ENOENT;
>  		}
>  	}
> +#endif
> +
>  out:
>  	preempt_enable();
>  	jump_label_unlock();
> @@ -1614,7 +1621,9 @@ int register_kprobe(struct kprobe *p)
>  {
>  	int ret;
>  	struct kprobe *old_p;
> +#if IS_ENABLED(CONFIG_MODULES)
>  	struct module *probed_mod;
> +#endif
>  	kprobe_opcode_t *addr;
>  	bool on_func_entry;
>  
> @@ -1633,7 +1642,11 @@ int register_kprobe(struct kprobe *p)
>  	p->nmissed = 0;
>  	INIT_LIST_HEAD(&p->list);
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  	ret = check_kprobe_address_safe(p, &probed_mod);
> +#else
> +	ret = check_kprobe_address_safe(p);
> +#endif
>  	if (ret)
>  		return ret;
>  
> @@ -1676,8 +1689,10 @@ int register_kprobe(struct kprobe *p)
>  out:
>  	mutex_unlock(&kprobe_mutex);
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  	if (probed_mod)
>  		module_put(probed_mod);
> +#endif
>  
>  	return ret;
>  }
> @@ -2482,6 +2497,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  /* Remove all symbols in given area from kprobe blacklist */
>  static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
>  {
> @@ -2499,6 +2515,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
>  {
>  	kprobe_remove_area_blacklist(entry, entry + 1);
>  }
> +#endif
>  
>  int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
>  				   char *type, char *sym)
> @@ -2564,6 +2581,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
>  	return ret ? : arch_populate_kprobe_blacklist();
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  static void add_module_kprobe_blacklist(struct module *mod)
>  {
>  	unsigned long start, end;
> @@ -2665,6 +2683,7 @@ static struct notifier_block kprobe_module_nb = {
>  	.notifier_call = kprobes_module_callback,
>  	.priority = 0
>  };
> +#endif /* IS_ENABLED(CONFIG_MODULES) */
>  
>  void kprobe_free_init_mem(void)
>  {
> @@ -2724,8 +2743,11 @@ static int __init init_kprobes(void)
>  	err = arch_init_kprobes();
>  	if (!err)
>  		err = register_die_notifier(&kprobe_exceptions_nb);
> +
> +#if IS_ENABLED(CONFIG_MODULES)
>  	if (!err)
>  		err = register_module_notifier(&kprobe_module_nb);
> +#endif
>  
>  	kprobes_initialized = (err == 0);
>  	kprobe_sysctls_init();
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index c4c6e0e0068b..dd4598f775b9 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -102,6 +102,7 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
>  	return kprobe_gone(&tk->rp.kp);
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
>  						 struct module *mod)
>  {
> @@ -129,6 +130,12 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
>  
>  	return ret;
>  }
> +#else
> +static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
> +{
> +	return true;
> +}
> +#endif
>  
>  static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  {
> @@ -670,6 +677,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -704,6 +712,7 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.notifier_call = trace_kprobe_module_callback,
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
> +#endif /* IS_ENABLED(CONFIG_MODULES) */
>  
>  static int count_symbols(void *data, unsigned long unused)
>  {
> @@ -1897,8 +1906,10 @@ static __init int init_kprobe_trace_early(void)
>  	if (ret)
>  		return ret;
>  
> +#if IS_ENABLED(CONFIG_MODULES)
>  	if (register_module_notifier(&trace_kprobe_module_nb))
>  		return -EINVAL;
> +#endif
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

