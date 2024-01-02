Return-Path: <linux-kernel+bounces-14793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8473F822269
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362FE1F23761
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60F16409;
	Tue,  2 Jan 2024 20:07:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EC16403
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 20:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCCDC433C8;
	Tue,  2 Jan 2024 20:07:55 +0000 (UTC)
Date: Tue, 2 Jan 2024 20:07:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Chris von Recklinghausen <crecklin@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't record leak information on allocations done
 between kmemleak_init and kmemleak_late_init
Message-ID: <ZZRtGC9ZPVR5uCqu@arm.com>
References: <20240102153428.139984-1-crecklin@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102153428.139984-1-crecklin@redhat.com>

On Tue, Jan 02, 2024 at 10:34:28AM -0500, Chris von Recklinghausen wrote:
> If an object is allocated after kmemleak_init is called but before
> kmemleak_late_init is called, calls to kmemleak_not_leak or
> kmemleak_ignore on the object don't prevent a scan from reporting the
> object as a leak.

This may be true but what is the reason for this? Can you give some
example of false positives you get?

> Avoid this situation by only registering objects in kmemleak_alloc when
> kmemleak_initialized is set.

I wouldn't do this, kmemleak needs to track all the early allocations,
otherwise it will lead to lots of false positives. However, looking at
your patch, it looks like it doesn't touch kmemleak_alloc() at all and
it does something completely different.

> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 5501363d6b31..0c8a5f456874 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1117,7 +1117,8 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
>  {
>  	pr_debug("%s(0x%px)\n", __func__, ptr);
>  
> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> +	if (kmemleak_enabled && kmemleak_late_initialized && ptr &&
> +		!IS_ERR(ptr))
>  		delete_object_part((unsigned long)ptr, size, false);
>  }

This leaves some memory to still be tracked by kmemleak when it was
actually freed. Later when it is reallocated, you'll get some errors and
kmemleak will disable itself.

>  EXPORT_SYMBOL_GPL(kmemleak_free_part);
> @@ -1135,7 +1136,8 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
>  
>  	pr_debug("%s(0x%px)\n", __func__, ptr);
>  
> -	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
> +	if (kmemleak_free_enabled && kmemleak_late_initialized && ptr &&
> +		!IS_ERR(ptr))
>  		for_each_possible_cpu(cpu)
>  			delete_object_full((unsigned long)per_cpu_ptr(ptr,
>  								      cpu));

Same here.

> @@ -1189,7 +1191,8 @@ void __ref kmemleak_not_leak(const void *ptr)
>  {
>  	pr_debug("%s(0x%px)\n", __func__, ptr);
>  
> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> +	if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
                                 ^^^
I guess you haven't compiled this patch. Does it actually fix the
problem you are reporting?

> +		!IS_ERR(ptr))
>  		make_gray_object((unsigned long)ptr);
>  }

This change doesn't help at all with your problem statement.

>  EXPORT_SYMBOL(kmemleak_not_leak);
> @@ -1207,7 +1210,8 @@ void __ref kmemleak_ignore(const void *ptr)
>  {
>  	pr_debug("%s(0x%px)\n", __func__, ptr);
>  
> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> +	if (kmemleak_enabled && kmamleak_late_initialized && ptr &&
> +		!IS_ERR(ptr))
>  		make_black_object((unsigned long)ptr, false);
>  }
>  EXPORT_SYMBOL(kmemleak_ignore);

Neither does this.

Also if you re-post, please cc linux-mm as well. Andrew Morton tends to
pick up the kmemleak patches (once acked).

-- 
Catalin

