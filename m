Return-Path: <linux-kernel+bounces-18087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B88258A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5121B1F237BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D4321B7;
	Fri,  5 Jan 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V1xsG3UI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00C2E652
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A39CC433C8;
	Fri,  5 Jan 2024 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704473352;
	bh=yBEZyO9cmNSe7eUGAlx8l25OeQ5IowyYQAaA786v7DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V1xsG3UIbgoXH8eDWj0UWzj8HxHu9glJsfJhUA/h7oi4aOWcBX8ofZnDfKjidBT20
	 USkR2ADcNSIrzIq96ywDguXoKUKwlqsllKnlF1Jow00FtpsHPMMk4rv6e07aXhkMH6
	 mKSA0oyiUx6okJHDgZEPH0wiR/if98XH/hnqRMUY=
Date: Fri, 5 Jan 2024 08:49:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Youling Tang <tangyouling@kylinos.cn>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Defer the insertion of crashkernel resources
Message-Id: <20240105084911.b64f43b12b0c7e25436cb093@linux-foundation.org>
In-Reply-To: <20231229080213.2622204-1-chenhuacai@loongson.cn>
References: <20231229080213.2622204-1-chenhuacai@loongson.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Dec 2023 16:02:13 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:

> In /proc/iomem, sub-regions should be inserted after their parent,
> otherwise the insertion of parent resource fails. But after generic
> crashkernel reservation applied, in both RISC-V and ARM64 (LoongArch
> will also use generic reservation later on), crashkernel resources are
> inserted before their parent, which causes the parent disappear in
> /proc/iomem. So we defer the insertion of crashkernel resources to an
> early_initcall().
> 
> ...
>
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -377,7 +377,6 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
>  
>  	crashk_low_res.start = low_base;
>  	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
>  #endif
>  	return 0;
>  }
> @@ -459,8 +458,19 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
> -	insert_resource(&iomem_resource, &crashk_res);
>  }
> +
> +static __init int insert_crashkernel_resources(void)
> +{
> +	if (crashk_res.start < crashk_res.end)
> +		insert_resource(&iomem_resource, &crashk_res);
> +
> +	if (crashk_low_res.start < crashk_low_res.end)
> +		insert_resource(&iomem_resource, &crashk_low_res);
> +
> +	return 0;
> +}
> +early_initcall(insert_crashkernel_resources);
>  #endif
>  
>  int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,

I'm thinking 

Fixes: 0ab97169aa0 ("crash_core: add generic function to do reservation").

Also, is this a regression?  Were earlier kernels OK?

