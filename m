Return-Path: <linux-kernel+bounces-40647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68A83E39A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6181C22BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAB24219;
	Fri, 26 Jan 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJnBLjFi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA017BCC;
	Fri, 26 Jan 2024 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303112; cv=none; b=QF+J1XWU7CZUKFhdvpkm1jePbp5ypDQ05Y9qtX3khIEVY635S5c5j1iXVIT87New7amFcvHGaamaZEHYJPDA78iw8TB1pb5wDUbtP7o2YM3nVSlu1vkOZyAY1J+Ld+RPXgiNykuiwhjyUVuOYAw4EY79uSUOqakx79P32SUfzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303112; c=relaxed/simple;
	bh=D6TN0ph7simZRtQn/9n/ECn1Cli8KS1dvnZhjYqIRsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjKtHBIS9CB4o1TsWuJ/YVTPcmYtXFWW8W99QKC5DDT3/bnjc4u6xrIkwncy9JOUqltt7u59MvtotAGW0OuQbDr2bHBaT7ZJnIAT2dCXo+29Npp9yhIjk2RCX6AZDDgvX7xhEN92l38IMNSxA6Rg8U0D7DaVonj1iv0Bbfb4xgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJnBLjFi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEDAC433F1;
	Fri, 26 Jan 2024 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706303111;
	bh=D6TN0ph7simZRtQn/9n/ECn1Cli8KS1dvnZhjYqIRsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJnBLjFiv0ZZ9w1YfnJNh/w9sPS+Om2XiWO0XI5w5WUQoCExWuDBBvU4IEwYFnceI
	 zxReKXCNUErdfsc5UCnl0WuESEfbbY/p4KysyTEZRHa3FS7Kwnzx1Ww9d9Vzol03tf
	 MrMNFFbE2xbio6KHM4rkSiJbKcBffaLHKbbHMlxNXhqWky1ZOXH9eaY269MvEdjKjK
	 l++ni2vQu09irNzor2Ib+vZ9lEMfKUa6g0wcYqFdg/obsw3Su7aDjHFPabdXuI4wlv
	 0DXAzSqOcq5QP81T4P95kge+dteXdWcU8MiSZope6JBCYZj9SJ9VjaDrMyiKca83Vj
	 hR32nPoYswLBQ==
Date: Fri, 26 Jan 2024 14:05:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	maz@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: irq/core] genirq/irq_sim: Shrink code by using cleanup
 helpers
Message-ID: <20240126210509.GA1212219@dev-arch.thelio-3990X>
References: <20240122124243.44002-5-brgl@bgdev.pl>
 <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>

On Fri, Jan 26, 2024 at 12:53:36PM -0000, tip-bot2 for Bartosz Golaszewski wrote:
> The following commit has been merged into the irq/core branch of tip:
> 
> Commit-ID:     590610d72a790458431cbbebc71ee24521533b5e
> Gitweb:        https://git.kernel.org/tip/590610d72a790458431cbbebc71ee24521533b5e
> Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> AuthorDate:    Mon, 22 Jan 2024 13:42:43 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00
> 
> genirq/irq_sim: Shrink code by using cleanup helpers
> 
> Use the new __free() mechanism to remove all gotos and simplify the error
> paths.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl
> 
> ---
>  kernel/irq/irq_sim.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index b0d50b4..fe8fd30 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irq_sim.h>
> @@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
>  struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
>  					 unsigned int num_irqs)
>  {
> -	struct irq_sim_work_ctx *work_ctx;
> +	struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
> +	unsigned long *pending;
>  
> -	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
>  	if (!work_ctx)
> -		goto err_out;
> +		return ERR_PTR(-ENOMEM);
>  
> -	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
> -	if (!work_ctx->pending)
> -		goto err_free_work_ctx;
> +	pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);

Apologies if this has already been reported elsewhere. This does not
match what was sent and it causes the build to break with both GCC:

  In file included from include/linux/compiler_types.h:89,
                   from <command-line>:
  kernel/irq/irq_sim.c: In function 'irq_domain_create_sim':
  include/linux/compiler_attributes.h:76:41: error: expected expression before '__attribute__'
     76 | #define __cleanup(func)                 __attribute__((__cleanup__(func)))
        |                                         ^~~~~~~~~~~~~
  include/linux/cleanup.h:64:25: note: in expansion of macro '__cleanup'
     64 | #define __free(_name)   __cleanup(__free_##_name)
        |                         ^~~~~~~~~
  kernel/irq/irq_sim.c:173:19: note: in expansion of macro '__free'
    173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
        |                   ^~~~~~

and Clang:

  kernel/irq/irq_sim.c:173:12: error: expected expression
    173 |         pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
        |                   ^
  include/linux/cleanup.h:64:23: note: expanded from macro '__free'
     64 | #define __free(_name)   __cleanup(__free_##_name)
        |                         ^
  include/linux/compiler-clang.h:15:25: note: expanded from macro '__cleanup'
     15 | #define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
        |                         ^
  include/linux/compiler_attributes.h:344:41: note: expanded from macro '__maybe_unused'
    344 | #define __maybe_unused                  __attribute__((__unused__))
        |                                         ^
  1 error generated.

This was initially noticed by our CI:

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/7671789235/job/20915505965
https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2bVGKZUmat8fRr582Nh8hNA6FXD/build.log

Cheers,
Nathan

> +	if (!pending)
> +		return ERR_PTR(-ENOMEM);
>  
>  	work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
>  						    &irq_sim_domain_ops,
>  						    work_ctx);
>  	if (!work_ctx->domain)
> -		goto err_free_bitmap;
> +		return ERR_PTR(-ENOMEM);
>  
>  	work_ctx->irq_count = num_irqs;
>  	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
> +	work_ctx->pending = no_free_ptr(pending);
>  
> -	return work_ctx->domain;
> -
> -err_free_bitmap:
> -	bitmap_free(work_ctx->pending);
> -err_free_work_ctx:
> -	kfree(work_ctx);
> -err_out:
> -	return ERR_PTR(-ENOMEM);
> +	return no_free_ptr(work_ctx)->domain;
>  }
>  EXPORT_SYMBOL_GPL(irq_domain_create_sim);
>  

