Return-Path: <linux-kernel+bounces-149229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC48A8D60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526102868BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D414AEE1;
	Wed, 17 Apr 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8mlIz8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B104AEED;
	Wed, 17 Apr 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387444; cv=none; b=M+YU3n/GIzBta1J3Pno/aEC4xebINVo64Vo1Y6JyGA449/weVvwe08VbABNKb+SeyALAn0E/1q3OK0s0CLpAgPX1XmqRgB2tI8xauBo7rgvG3zwF5nvNX2WOIuQ3evFA5gyXkkn1MiNBBimaLg2TCjfzR6771csdApd6W1mZc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387444; c=relaxed/simple;
	bh=VcB6i6Ur1pta/CV6umrp4BehU8p1LKSfcdMlGVuoIPQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lqhjn5YFJPXZhQ9isCkxutL/P90OMqidCW3kjH0bWwYTJukSCxn8eZWuoTb8EJ2LwA9qknYPBW0g5qlHUn5zZjiZ5vrv3DMSrYIzavYzoB3rLhhDdxaj5ZOP+WbUOwjj4dUVK54A6xkYOZ0IR9kbbqEbHGtHNvCS9PoAARy6nFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8mlIz8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D748BC2BD11;
	Wed, 17 Apr 2024 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713387444;
	bh=VcB6i6Ur1pta/CV6umrp4BehU8p1LKSfcdMlGVuoIPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L8mlIz8QZ3ZJlvpDn6fBWS/hJtaWoyLtjZxN+O6z1UCJEwm1a8AEJrXpzUvx+F6Qy
	 ZcFZQij1AKdwegs36KrD+mYrec/OapmZc3OaAttBaGHkJlU/gKlVB+pJp8tucgzUAm
	 HfwzRD4oKYECXxdz0MfjK16WWg/UaBTRby0ZwS90ix7RFLzboB2JsgqoZ+ATYUTOHO
	 f7jHZUgbMUWzeg1noZlT1ZstQYgX1k9TvzWlJxUUpXTXkqB4PaXLdCgFZecfa1oM2/
	 qp+RY1rrNH/Jt5FPODNp47uaJQHAQBlbqWWEmCalCpkulcW6uw6ELXiYvoK4tNmJkw
	 YZv16qFvUDCog==
Date: Thu, 18 Apr 2024 05:57:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Francis Laniel
 <flaniel@linux.microsoft.com>
Subject: Re: [PATCH for-next v2] tracing/kprobes: Add symbol counting check
 when module loads
Message-Id: <20240418055720.6226987c7e5cb1e2d8984942@kernel.org>
In-Reply-To: <171338679446.616570.14456856697191949345.stgit@devnote2>
References: <171338679446.616570.14456856697191949345.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry, this is actually v3. (miss-configured...)

Thanks,

On Thu, 18 Apr 2024 05:46:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Currently, kprobe event checks whether the target symbol name is unique
> or not, so that it does not put a probe on an unexpected place. But this
> skips the check if the target is on a module because the module may not
> be loaded.
> 
> To fix this issue, this patch checks the number of probe target symbols
> in a target module when the module is loaded. If the probe is not on the
> unique name symbols in the module, it will be rejected at that point.
> 
> Note that the symbol which has a unique name in the target module,
> it will be accepted even if there are same-name symbols in the
> kernel or other modules,
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Update the patch description.
>  Updated from last October post, which was dropped by test failure:
>     https://lore.kernel.org/linux-trace-kernel/169854904604.132316.12500381416261460174.stgit@devnote2/
>  Changes in v2:
>   - Fix to skip checking uniqueness if the target module is not loaded.
>   - Fix register_module_trace_kprobe() to pass correct symbol name.
>   - Fix to call __register_trace_kprobe() from module callback.
> ---
>  kernel/trace/trace_kprobe.c |  125 ++++++++++++++++++++++++++++---------------
>  1 file changed, 81 insertions(+), 44 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index c68d4e830fbe..0113afe2662d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -670,6 +670,21 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
>  	return ret;
>  }
>  
> +static int validate_module_probe_symbol(const char *modname, const char *symbol);
> +
> +static int register_module_trace_kprobe(struct module *mod, struct trace_kprobe *tk)
> +{
> +	const char *p;
> +	int ret = 0;
> +
> +	p = strchr(trace_kprobe_symbol(tk), ':');
> +	if (p)
> +		ret = validate_module_probe_symbol(module_name(mod), p + 1);
> +	if (!ret)
> +		ret = __register_trace_kprobe(tk);
> +	return ret;
> +}
> +
>  /* Module notifier call back, checking event on the module */
>  static int trace_kprobe_module_callback(struct notifier_block *nb,
>  				       unsigned long val, void *data)
> @@ -688,7 +703,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
>  		if (trace_kprobe_within_module(tk, mod)) {
>  			/* Don't need to check busy - this should have gone. */
>  			__unregister_trace_kprobe(tk);
> -			ret = __register_trace_kprobe(tk);
> +			ret = register_module_trace_kprobe(mod, tk);
>  			if (ret)
>  				pr_warn("Failed to re-register probe %s on %s: %d\n",
>  					trace_probe_name(&tk->tp),
> @@ -729,17 +744,68 @@ static int count_mod_symbols(void *data, const char *name, unsigned long unused)
>  	return 0;
>  }
>  
> -static unsigned int number_of_same_symbols(char *func_name)
> +static unsigned int number_of_same_symbols(const char *mod, const char *func_name)
>  {
>  	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
>  
> -	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
> +	if (!mod)
> +		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
>  
> -	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
> +	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
>  
>  	return ctx.count;
>  }
>  
> +static int validate_module_probe_symbol(const char *modname, const char *symbol)
> +{
> +	unsigned int count = number_of_same_symbols(modname, symbol);
> +
> +	if (count > 1) {
> +		/*
> +		 * Users should use ADDR to remove the ambiguity of
> +		 * using KSYM only.
> +		 */
> +		return -EADDRNOTAVAIL;
> +	} else if (count == 0) {
> +		/*
> +		 * We can return ENOENT earlier than when register the
> +		 * kprobe.
> +		 */
> +		return -ENOENT;
> +	}
> +	return 0;
> +}
> +
> +static int validate_probe_symbol(char *symbol)
> +{
> +	struct module *mod = NULL;
> +	char *modname = NULL, *p;
> +	int ret = 0;
> +
> +	p = strchr(symbol, ':');
> +	if (p) {
> +		modname = symbol;
> +		symbol = p + 1;
> +		*p = '\0';
> +		/* Return 0 (defer) if the module does not exist yet. */
> +		rcu_read_lock_sched();
> +		mod = find_module(modname);
> +		if (mod && !try_module_get(mod))
> +			mod = NULL;
> +		rcu_read_unlock_sched();
> +		if (!mod)
> +			goto out;
> +	}
> +
> +	ret = validate_module_probe_symbol(modname, symbol);
> +out:
> +	if (p)
> +		*p = ':';
> +	if (mod)
> +		module_put(mod);
> +	return ret;
> +}
> +
>  static int trace_kprobe_entry_handler(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs);
>  
> @@ -863,6 +929,14 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  			trace_probe_log_err(0, BAD_PROBE_ADDR);
>  			goto parse_error;
>  		}
> +		ret = validate_probe_symbol(symbol);
> +		if (ret) {
> +			if (ret == -EADDRNOTAVAIL)
> +				trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> +			else
> +				trace_probe_log_err(0, BAD_PROBE_ADDR);
> +			goto parse_error;
> +		}
>  		if (is_return)
>  			ctx.flags |= TPARG_FL_RETURN;
>  		ret = kprobe_on_func_entry(NULL, symbol, offset);
> @@ -875,31 +949,6 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>  		}
>  	}
>  
> -	if (symbol && !strchr(symbol, ':')) {
> -		unsigned int count;
> -
> -		count = number_of_same_symbols(symbol);
> -		if (count > 1) {
> -			/*
> -			 * Users should use ADDR to remove the ambiguity of
> -			 * using KSYM only.
> -			 */
> -			trace_probe_log_err(0, NON_UNIQ_SYMBOL);
> -			ret = -EADDRNOTAVAIL;
> -
> -			goto error;
> -		} else if (count == 0) {
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			trace_probe_log_err(0, BAD_PROBE_ADDR);
> -			ret = -ENOENT;
> -
> -			goto error;
> -		}
> -	}
> -
>  	trace_probe_log_set_index(0);
>  	if (event) {
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
> @@ -1817,21 +1866,9 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	char *event;
>  
>  	if (func) {
> -		unsigned int count;
> -
> -		count = number_of_same_symbols(func);
> -		if (count > 1)
> -			/*
> -			 * Users should use addr to remove the ambiguity of
> -			 * using func only.
> -			 */
> -			return ERR_PTR(-EADDRNOTAVAIL);
> -		else if (count == 0)
> -			/*
> -			 * We can return ENOENT earlier than when register the
> -			 * kprobe.
> -			 */
> -			return ERR_PTR(-ENOENT);
> +		ret = validate_probe_symbol(func);
> +		if (ret)
> +			return ERR_PTR(ret);
>  	}
>  
>  	/*
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

