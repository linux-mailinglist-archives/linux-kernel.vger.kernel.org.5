Return-Path: <linux-kernel+bounces-125775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4E892BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F61A1F21E39
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615853B79F;
	Sat, 30 Mar 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m5yyjZZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632128467;
	Sat, 30 Mar 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815142; cv=none; b=Gtg6dPScUZXoP6ABT/VPJ9ZMj+42YNSdiWJpRD65Lv0Uv4af+0zziNhZKUVxqmi+H+I9j3JeLiITN/LUbaGIiKafYB2qs786NUD7Cjmma/MLItz7rGFTYVl3FDQZ88TybXpXy+WaFU060PAJn8yMmiuNDPNN/k1ypirzkbbSjhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815142; c=relaxed/simple;
	bh=7DJY80SqsN2zeO08mKaZocYC36hJgIIyI/nQTHv2yrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ8dIDYk+3RGNmKnN0spStMzc4+ILXegENLk63pSOJOLI9TgKj3lX2yCGC6qiMw+1j4tS0CpkF2GaKFyt5lg1Z0QUbsdgNbGRVdqQhaU++4iWBBBVd5PWWigLaJAqB5CRAxPSukA/kHibpWvt2VNq1DcAA8PlYLRvKHuRT8bUIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m5yyjZZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F7DC433F1;
	Sat, 30 Mar 2024 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711815142;
	bh=7DJY80SqsN2zeO08mKaZocYC36hJgIIyI/nQTHv2yrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5yyjZZxH/klvWCBqIoRuOHkVpGXYh6HA/sHEABnoAgryF8I8SAM+MGoRMAK/g3wa
	 VWWANrzP0+SrtPxZLoSYHQv8bDh4Vrjh+L2kYzartfBynhg7AtgOr+N9D32OoW54PM
	 875jr+Sl46wU5PJ7IIT3IogAgVhpDkaHF968PPPo=
Date: Sat, 30 Mar 2024 17:12:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Use kmem for landlock_object
Message-ID: <2024033030-tutu-dynamite-47c9@gregkh>
References: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZggZi/EFICvb4xTU@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Sat, Mar 30, 2024 at 07:24:19PM +0530, Ayush Tiwari wrote:
> Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> struct landlock_object and update the related dependencies to improve
> memory allocation and deallocation performance.

So it's faster?  Great, what are the measurements?

> This patch does not
> change kfree() and kfree_rcu() calls because according to kernel commit
> ae65a5211d90("mm/slab: document kfree() as allowed for
> kmem_cache_alloc() objects"), starting from kernel 6.4 with
> CONFIG_SLOB, kfree() is safe to use for such objects.

There is no CONFIG_SLOB anymore so why mention it?




> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> 
> Changes in v2: Used clang-format and corrected the removal of kfree_rcu.
> Tried to use KMEM macro but due to lack of cache pointer in that macro,
> had to explicitly define landlock_object_cache, as done in security.c.
> 
>  security/landlock/object.c | 12 +++++++++++-
>  security/landlock/object.h |  2 ++
>  security/landlock/setup.c  |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/object.c b/security/landlock/object.c
> index 1f50612f0185..cfc367725624 100644
> --- a/security/landlock/object.c
> +++ b/security/landlock/object.c
> @@ -17,6 +17,15 @@
>  
>  #include "object.h"
>  
> +static struct kmem_cache *landlock_object_cache;
> +
> +void __init landlock_object_cache_init(void)
> +{
> +	landlock_object_cache = kmem_cache_create(
> +		"landlock_object_cache", sizeof(struct landlock_object), 0,
> +		SLAB_PANIC, NULL);

You really want SLAB_PANIC?  Why?

> +}
> +
>  struct landlock_object *
>  landlock_create_object(const struct landlock_object_underops *const underops,
>  		       void *const underobj)
> @@ -25,7 +34,8 @@ landlock_create_object(const struct landlock_object_underops *const underops,
>  
>  	if (WARN_ON_ONCE(!underops || !underobj))
>  		return ERR_PTR(-ENOENT);
> -	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
> +	new_object =
> +		kmem_cache_zalloc(landlock_object_cache, GFP_KERNEL_ACCOUNT);

Odd indentation, why?

thanks,

greg k-h

