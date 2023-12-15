Return-Path: <linux-kernel+bounces-1665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376168151DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E19286DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089549F61;
	Fri, 15 Dec 2023 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GChepM/d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D33495E1;
	Fri, 15 Dec 2023 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702675024; x=1734211024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2+i7SehULhdMeNNvXfQ4W2QO4fq12pE9TACQPTaBSk=;
  b=GChepM/dYLFP9+eKZC7dmKjnXPFS+IV5zbPogiU0T67MjtrbSDwvlSwY
   waOswDrZd6J0CS+COfB8pZLutc2gZ6bXbKwpHPQOwik3xrtXEJfouk3s5
   qZ+sbCsPDTJ9ISwSkjtb6nW3uCINL8r+O1NzlcUAAuGCcpGnWFoIp+hMb
   xJFL1bCJ9NVTfhnri/w9PG0WhEKqmCow63Z500kfP/eUQVYPbYNHjx8jp
   s2EHeN6YBJt7axYU4TLCluh26i0zw+ENpON78pRX4efSqoXaQ09lJ4Vdw
   7WJWHF5jKyZp5gPNZm0wz7NwU7ayW7vS4d54pTg0iyQ2zlNo/q7VDcXeV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2151943"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2151943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="803841033"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="803841033"
Received: from jwaxmons-hp.amr.corp.intel.com (HELO [10.212.150.221]) ([10.212.150.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:17:01 -0800
Message-ID: <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
Date: Fri, 15 Dec 2023 13:17:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: allocate kernel above bzImage's pref_address
Content-Language: en-US
To: Chris Koch <chrisko@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Cloud Hsu <cloudhsu@google.com>
References: <20231215190521.3796022-1-chrisko@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20231215190521.3796022-1-chrisko@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/23 11:05, Chris Koch wrote:
> A relocatable kernel will relocate itself to pref_address if it is
> loaded below pref_address. This means a booted kernel may be relocating
> itself to an area with reserved memory on modern systems, potentially
> clobbering arbitrary data that may be important to the system.
> 
> This is often the case, as the default value of PHYSICAL_START is
> 0x1000000 and kernels are typically loaded at 0x100000 or above by
> bootloaders like iPXE or kexec. GRUB behaves like this patch does.
> 
> Also fixes the documentation around pref_address and PHYSICAL_START to
> be accurate.

Are you reporting a bug and is this a bug fix?  It's not super clear
from the changelog.


> diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
> index 22cc7a040dae..49bea8986620 100644
> --- a/Documentation/arch/x86/boot.rst
> +++ b/Documentation/arch/x86/boot.rst
> @@ -878,7 +878,8 @@ Protocol:	2.10+
>    address if possible.
>  
>    A non-relocatable kernel will unconditionally move itself and to run
> -  at this address.
> +  at this address. A relocatable kernel will move itself to this address if it
> +  loaded below this address.

I think we should avoid saying the same things over and over again in
different spots.

Here, it doesn't really help to enumerate the different interpretations
of 'pref_address'.  All that matters is that the bootloader can avoid
the overhead of a later copy if it can place the kernel at
'pref_address'.  The exact reasons that various kernels might decide to
relocate are unimportant here.

>  ============	=======
>  Field name:	init_size
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..1370f43328d7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2109,11 +2109,11 @@ config PHYSICAL_START
>  	help
>  	  This gives the physical address where the kernel is loaded.
>  
> -	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
> -	  bzImage will decompress itself to above physical address and
> -	  run from there. Otherwise, bzImage will run from the address where
> -	  it has been loaded by the boot loader and will ignore above physical
> -	  address.
> +	  If the kernel is not relocatable (CONFIG_RELOCATABLE=n) then bzImage
> +	  will decompress itself to above physical address and run from there.
> +	  Otherwise, bzImage will run from the address where it has been loaded
> +	  by the boot loader. The only exception is if it is loaded below the
> +	  above physical address, in which case it will relocate itself there.

I kinda dislike how this is written.  It's written almost like code
where you're spelling out the conditions.  I prefer something much
higher-level.

	This gives a minimum physical address at which the kernel can be
	loaded.

	CONFIG_RELOCATABLE=n kernels will be decompressed to and must
	run at PHYSICAL_START exactly.

	CONFIG_RELOCATABLE=y kernels can run at any address above
	PHYSICAL_START.  If a kernel is loaded below PHYSICAL_START, it
	will relocate itself to PHYSICAL_START.

>  	  In normal kdump cases one does not have to set/change this option
>  	  as now bzImage can be compiled as a completely relocatable image
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index a61c12c01270..5dcd232d58bf 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  	kbuf.bufsz =  kernel_len - kern16_size;
>  	kbuf.memsz = PAGE_ALIGN(header->init_size);
>  	kbuf.buf_align = header->kernel_alignment;
> -	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
> +	if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
> +		kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
> +	else
> +		kbuf.buf_min = header->pref_address;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret)

Comment, please.

It isn't clear from this hunk why or how this fixes the bug.  How does
this manage to avoid clobbering reserved areas?

