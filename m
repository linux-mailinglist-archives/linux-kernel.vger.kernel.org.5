Return-Path: <linux-kernel+bounces-138717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27789F97E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9961C27968
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A516F842;
	Wed, 10 Apr 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLywsviC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C716F90A;
	Wed, 10 Apr 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757820; cv=none; b=kb5z7MGo37t2hpluFgC+SQzM9m4Pl7kRnLEt69h/xPM+qdMAELipKANvlW9GwZ8i1CrolaXSW30K3+cH5y104BgtybPPHp6V+fqcK7CPOqfbGLvWvlEheaWWgJKGl8wE4yYOyrZCpMI1PbgW/Lw3/hwhvJEeZEFr2WBGfchyjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757820; c=relaxed/simple;
	bh=YJVg15asCDUWzkyyR8ToaYmqFAys5qM4yXSLrQA/+80=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rIp1/YhvoCkHDG32oMHEbf0c2yWIj8Mwywg9TtV4ZK08VMfDdLwPOvmmkGy78wmfZwutYBfreZS7ZJNPEbGdHYK2k2LGCxEP7h7ijvLWjsb/6KuKJzT96dK1gu33T35lziKuOhG6SEIaI+CUE+RGPmK5bGGGUWzQA78b3KaixwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLywsviC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61829C433F1;
	Wed, 10 Apr 2024 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757820;
	bh=YJVg15asCDUWzkyyR8ToaYmqFAys5qM4yXSLrQA/+80=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLywsviC5iixRQ/Vh5FfpPD5jeOMgc2lbpP/jYlJPAq0j76LZP9AwOuf3RqEWWpII
	 2/sUR/JppzslVYvydEw3/QLOs5KW35efGANvBEVeEs0thqCAHwLsGGrczjq2tVrykV
	 H44pZxwY1qvvtnnkKuxrEYfYkp83dLSa7CHJo6MifOJLbZBaq28eWcJgHwFsW8eYGC
	 YnxHE2aSa6vhwul8EwFqski13lt7FWUsQG1m4+NEYYyYaN5RjKCBkvuVd0fR/L5t56
	 AkmRE7KPX4IO36/MzikgjhBJLFAF9+rGKVgl+Er4RqGd0cw3daxZa1pHi1r/sQdn0b
	 Lf7PmRXCybBdg==
Date: Wed, 10 Apr 2024 23:03:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
 <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] kprobes: Fix possible use-after-free issue on kprobe
 registration
Message-Id: <20240410230336.8ef84251c45ef363f3f1ff6f@kernel.org>
In-Reply-To: <20240410015802.265220-1-zhengyejian1@huawei.com>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
	<20240410015802.265220-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 09:58:02 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> When unloading a module, its state is changing MODULE_STATE_LIVE ->
>  MODULE_STATE_GOING -> MODULE_STATE_UNFORMED. Each change will take
> a time. `is_module_text_address()` and `__module_text_address()`
> works with MODULE_STATE_LIVE and MODULE_STATE_GOING.
> If we use `is_module_text_address()` and `__module_text_address()`
> separately, there is a chance that the first one is succeeded but the
> next one is failed because module->state becomes MODULE_STATE_UNFORMED
> between those operations.
> 
> In `check_kprobe_address_safe()`, if the second `__module_text_address()`
> is failed, that is ignored because it expected a kernel_text address.
> But it may have failed simply because module->state has been changed
> to MODULE_STATE_UNFORMED. In this case, arm_kprobe() will try to modify
> non-exist module text address (use-after-free).
> 
> To fix this problem, we should not use separated `is_module_text_address()`
> and `__module_text_address()`, but use only `__module_text_address()`
> once and do `try_module_get(module)` which is only available with
> MODULE_STATE_LIVE.
> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>

Looks good to me. Let me pick this version, and it should be a bugfix.

Fixes: 28f6c37a2910 ("kprobes: Forbid probing on trampoline and BPF code areas")
Cc: stable@vger.kernel.org

Thank you!

> ---
>  kernel/kprobes.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> v3:
>  - Update commit messages as suggested by Masami.
>    Link: https://lore.kernel.org/all/20240409224922.5f192e8ace5f7a90937bfa69@kernel.org/
>  - Also change to a more appropriate title.
> 
> v2:
>  - Update commit messages and comments as suggested by Masami.
>    Link: https://lore.kernel.org/all/20240408115038.b0c85767bf1f249eccc32fff@kernel.org/
>  - Link: https://lore.kernel.org/all/20240408083403.3302274-1-zhengyejian1@huawei.com/
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

