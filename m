Return-Path: <linux-kernel+bounces-134731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD589B617
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CE71F21796
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E1184D;
	Mon,  8 Apr 2024 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owowCrq2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384AEDF;
	Mon,  8 Apr 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712544642; cv=none; b=HriD94tJC4DGe2jNjlBVJOmtoV+mmP9sIg0uS3+h9Wu7vhv4CO0x10zKurzJ4n1AkHLYjqh0CQ+LZty2NWnTLLkn4U+inKRRFfHgl5NpXa5ymSzjZwTzHyAzOf3cN2vGJd5SWvY/UfvOq2G/G7gqpHPWjIxK+uVZQ9zXxZNpPgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712544642; c=relaxed/simple;
	bh=09KpA1PzryBcQ7Vz+5NdiCGj4r5ml+5yka4hoPNR+eg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EH32+tmKwym1e+kTUIS28NAXa4tKYz+alYIhiFTV0qI9vPfF+GmWSeDw9/sJFNJpYBupTv+wgxD5Jy8llAT22AUE1euhXRSHUUx98UAIeaPf3U2xqv3nkPMmmkIpZXm4AMNPqMwVddVMhqRYlTOBOb4o/rugr8LvybWdD/Rv4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owowCrq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36112C433C7;
	Mon,  8 Apr 2024 02:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712544641;
	bh=09KpA1PzryBcQ7Vz+5NdiCGj4r5ml+5yka4hoPNR+eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=owowCrq28PiI61ex81LrhSq7vcjQjvac81F9JFRGeVqo2cmd7s5fHpGiESEGKsOR6
	 bFKqzrCD7fmPbbYoTneCtw5g6NwATKj0OxrgwZNVWXg9AmjBsQmQ1u0RRDci4Rr7e5
	 lPHHN3jXAZYpy0M3FOXEJGLE6MoXqBoOd1EcJdud69V/8EHo9FHZRfcilp3AzeqvmT
	 YEZqNmVbhjq1SnajkBw/VzH07Wq7K9paIIbc5yIRLzxnjlBSwi1UjwzvU7z6Wzi3ma
	 hi6hBmMqsoTlYS0Au3a1WB/idmT2Vh5XTICii6ryL9lzUg0keZLK+P8b/4tjfep1PK
	 wzQobv3OvQOzw==
Date: Mon, 8 Apr 2024 11:50:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobes: Fix possible warn in __arm_kprobe_ftrace()
Message-Id: <20240408115038.b0c85767bf1f249eccc32fff@kernel.org>
In-Reply-To: <20240407035904.2556645-1-zhengyejian1@huawei.com>
References: <20240407035904.2556645-1-zhengyejian1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Apr 2024 11:59:04 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> There is once warn in __arm_kprobe_ftrace() on:
> 
>  ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 0, 0);
>  if (WARN_ONCE(..., "Failed to arm kprobe-ftrace at %pS (error %d)\n", ...)
>    return ret;
> 
> This warning is due to 'p->addr' is not a valid ftrace_location and
> that invalid 'p->addr' was bypassed in check_kprobe_address_safe():

Ah, this is a guard warning to detect changes on ftrace_set_filter() and/or
preparation steps. (A kind of debug message.)
The ftrace address check is done by check_ftrace_location() at the beginning of
check_kprobe_address_safe(). At that point, ftrace_location(addr) == addr should
return true if the module is loaded. But there is a small window that we check
the ftrace_location() and get the module refcount, even if the "addr" was ftrace
location, the module is unloaded and failed to get the module refcount and fail
to register the kprobe.

>    check_kprobe_address_safe() {
>      ...
>      // 1. p->addr is in some module, this check passed
>      is_module_text_address((unsigned long) p->addr)
>      ...
>      // 2. If the moudle is removed, the *probed_mod is NULL, but then
>      //    the return value would still be 0 !!!
>      *probed_mod = __module_text_address((unsigned long) p->addr);
>      ...
>    }
> 
> So adjust the module text check to fix it.

This seems just optimizing code (skip the 2nd module search), right?
Also some comments needs to be updated.

> 
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/kprobes.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9d9095e81792..e0612cc3e2a3 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1567,10 +1567,16 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	jump_label_lock();
>  	preempt_disable();
>

	/* Ensure the address is in a text area, and find a module if exists. */
  
> +	*probed_mod = NULL;
> +	if (!core_kernel_text((unsigned long) p->addr)) {
> +		*probed_mod = __module_text_address((unsigned long) p->addr);
> +		if (!(*probed_mod)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}

nit: this should get the module refcount soon after getting probed_mod.
(I think this should be an atomic operation, but we don't have such interface.)

> +	}

>  	/* Ensure it is not in reserved area nor out of text */

	/* Ensure it is not in reserved area. */

> -	if (!(core_kernel_text((unsigned long) p->addr) ||
> -	    is_module_text_address((unsigned long) p->addr)) ||

Note that this part is doing same thing. If the probe address is !kernel_text
and !module_text, it will be rejected.

> -	    in_gate_area_no_mm((unsigned long) p->addr) ||
> +	if (in_gate_area_no_mm((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
>  	    jump_label_text_reserved(p->addr, p->addr) ||
>  	    static_call_text_reserved(p->addr, p->addr) ||
> @@ -1581,7 +1587,6 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	}
>  
>  	/* Check if 'p' is probing a module. */

	/* Get module refcount and reject __init functions for loaded modules. */

> -	*probed_mod = __module_text_address((unsigned long) p->addr);
>  	if (*probed_mod) {
>  		/*
>  		 * We must hold a refcount of the probed module while updating
> -- 
> 2.25.1
> 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

