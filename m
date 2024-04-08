Return-Path: <linux-kernel+bounces-135331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52789BF1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B207A1F21A0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A96D1A9;
	Mon,  8 Apr 2024 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0xMeCRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A436A014;
	Mon,  8 Apr 2024 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580067; cv=none; b=Qh9zepN0+7kCmHrFbSanlMipaseF4IFT2t8185gTFYFyu/3mc8QxqpXhQuL+xgMT+9EFsT/qXr8HgX2/gSb3OWDY6GcqJ0YS8PaI+6wwyHg650XdTxPEaxxSIo4jTwqid14kN0ucR29HimvM72P6QtyUkSyfeHZQVdTx9lt6TZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580067; c=relaxed/simple;
	bh=uznQfg3AOHrzxljdeifxnUVqLDxe5aZvgkCnddzWjPI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GCe+OtQ3pJBpb9fQ7+3yHdyA0+9PqKjPtH96JIb8/D70pgIzGfXH2kjioA4hLLd37nO+5P0S40r9mKGUBs2UTGReyWYsNmjZ/0phHbA+cw0HIq5Xw8NdMKLru2tNZMKcb/CRUVloe4PKBUCkPADIw2wS4L9NS2v1hFaBoWNr53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0xMeCRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCAC433C7;
	Mon,  8 Apr 2024 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580066;
	bh=uznQfg3AOHrzxljdeifxnUVqLDxe5aZvgkCnddzWjPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0xMeCRG7CKo7TXZmry2s3woUlQ93apSYPU5CjKDJUjsUbdCCD2qeAj1KI8TOaB4Z
	 7HbwMBjnM9i2MUiF3IAQnSzZ/dLqkFT14hnC5ejJN0Lg7TWOTR/uqSm523aVq+wJCG
	 iux37RJFVsYacSU1l397/li8Ogz5SYj0H3dlLejRW1/K/eYtsh23ejlBw9nSyfavDo
	 D8GkKZK05hySKPpmFJTjCORgED2UkN4uc073Z2APkXAoJvvfvu3+9+3F+0hXwQqDDU
	 TlA4xV6RcKIBT0BBUmYDR7x8uPTEr2IgM1GasC1xfg+xZ2JpwT7zq+Xk7fCz0Gwg30
	 HY3itlSwYS9Ow==
Date: Mon, 8 Apr 2024 21:41:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kprobes: Avoid possible warn in
 __arm_kprobe_ftrace()
Message-Id: <20240408214102.be792c5cefd5ab757ef32a14@kernel.org>
In-Reply-To: <20240408083403.3302274-1-zhengyejian1@huawei.com>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
	<20240408083403.3302274-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Zheng,

On Mon, 8 Apr 2024 16:34:03 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> There is once warn in __arm_kprobe_ftrace() on:
> 
>  ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
>  if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
>    return ret;
> 
> This warning is generated because 'p->addr' is detected to be not a valid
> ftrace location in ftrace_set_filter_ip(). The ftrace address check is done
> by check_ftrace_location() at the beginning of check_kprobe_address_safe().
> At that point, ftrace_location(addr) == addr should return true if the
> module is loaded. Then the module is searched twice:
>   1. in is_module_text_address(), we find that 'p->addr' is in a module;
>   2. in __module_text_address(), we find the module;
> 
> If the module has just been unloaded before the second search, then
> '*probed_mod' is NULL and we would not go to get the module refcount,
> then the return value of check_kprobe_address_safe() would be 0, but
> actually we need to return -EINVAL.

OK, so you found a race window in check_kprobe_address_safe().

It does something like below.

check_kprobe_address_safe() {
	...

	/* Timing [A] */

	if (!(core_kernel_text(p->addr) ||
		is_module_text_address(p->addr)) ||
		...(other reserved address check)) {
		return -EINVAL;
	}

	/* Timing [B] */

	*probed_mod = __module_text_address(p->addr):
	if (*probe_mod) {
		if (!try_module_get(*probed_mod)) {
			return -ENOENT;
		}
		...	
	}
}

So, if p->addr is in a module which is alive at the timing [A], but
unloaded at timing [B], 'p->addr' is passed the
'is_module_text_address(p->addr)' check, but *probed_mod becomes NULL.
Thus the corresponding module is not referenced and kprobe_arm(p) will
access a wrong address (use after free).
This happens either kprobe on ftrace is enabled or not.

To fix this problem, we should move the mutex_lock(kprobe_mutex) before
check_kprobe_address_safe() because kprobe_module_callback() also lock it
so it can stop module unloading.

Can you ensure this will fix your problem?
I think your patch is just optimizing but not fixing the fundamental
problem, which is we don't have an atomic search symbol and get module
API. In that case, we should stop a whole module unloading system until
registering a new kprobe on a module. (After registering the kprobe,
the callback can mark it gone and disarm_kprobe does not work anymore.)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9d9095e81792..94eaefd1bc51 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1633,11 +1633,11 @@ int register_kprobe(struct kprobe *p)
 	p->nmissed = 0;
 	INIT_LIST_HEAD(&p->list);
 
+	mutex_lock(&kprobe_mutex);
+
 	ret = check_kprobe_address_safe(p, &probed_mod);
 	if (ret)
-		return ret;
-
-	mutex_lock(&kprobe_mutex);
+		goto out;
 
 	if (on_func_entry)
 		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;

----

Thank you,

> 
> To fix it, originally we can simply check 'p->addr' is out of text again,
> like below. But that would check twice respectively in kernel text and
> module text, so finally I reduce them to be once.
> 
>   if (!(core_kernel_text((unsigned long) p->addr) ||
>       is_module_text_address((unsigned long) p->addr)) || ...) {
> 	ret = -EINVAL;
> 	goto out;
>   }
>   ...
>   *probed_mod = __module_text_address((unsigned long) p->addr);
>   if (*probed_mod) {
> 	...
>   } else if (!core_kernel_text((unsigned long) p->addr)) { // check again!
> 	ret = -EINVAL;
> 	goto out;
>   }
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/kprobes.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> v2:
>  - Update commit messages and comments as suggested by Masami.
>    Link: https://lore.kernel.org/all/20240408115038.b0c85767bf1f249eccc32fff@kernel.org/
> 
> v1:
>  - Link: https://lore.kernel.org/all/20240407035904.2556645-1-zhengyejian1@huawei.com/
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e81792..65adc815fc6e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	jump_label_lock();
>  	preempt_disable();
>  
> -	/* Ensure it is not in reserved area nor out of text */
> -	if (!(core_kernel_text((unsigned long) p->addr) ||
> -	    is_module_text_address((unsigned long) p->addr)) ||
> -	    in_gate_area_no_mm((unsigned long) p->addr) ||
> +	/* Ensure the address is in a text area, and find a module if exists. */
> +	*probed_mod = NULL;
> +	if (!core_kernel_text((unsigned long) p->addr)) {
> +		*probed_mod = __module_text_address((unsigned long) p->addr);
> +		if (!(*probed_mod)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +	/* Ensure it is not in reserved area. */
> +	if (in_gate_area_no_mm((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    static_call_text_reserved(p->addr, p->addr) ||
> @@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		goto out;
>  	}
>  
> -	/* Check if 'p' is probing a module. */
> -	*probed_mod = __module_text_address((unsigned long) p->addr);
> +	/* Get module refcount and reject __init functions for loaded modules. */
>  	if (*probed_mod) {
>  		/*
>  		 * We must hold a refcount of the probed module while updating
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

