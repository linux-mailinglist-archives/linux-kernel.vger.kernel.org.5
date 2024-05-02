Return-Path: <linux-kernel+bounces-166523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8718B9BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088B9B21C34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF813C678;
	Thu,  2 May 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V84SIw7B"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB54776E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657539; cv=none; b=St2MspdPYse/fnN+TZZqi86TzevL0Ug+mI/v838gUIAVrL/HNBj9Kq+d8xoAUcFEkA7QK4KPZ67srUVsvNwOmjP9JcEXH36c+Y1GeoTBs6S0nKekrrXx2dU9Utr/9HqqlsTGo07GHp1+yoEKnjLA9HRdkjj9dnarjgXbqgHf2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657539; c=relaxed/simple;
	bh=4nW/JQpWRYhBtEJDs9LnrKJQzMp++18EyyLpp8dASfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBKmB0Wek7mUkBgGxsQ9zg7MGIHAERCBaSLTU5J0wVZ0SbWPo+h1ve5YDpL3r9d0sX5yQIskNeD7ktiDy4jblHtbQeiF9obvIcDnmN5AvG8KSExDX25INY1zui6Se8Khzo+TMotS1hnVEJBvDr+oMkLVGHxiS/mhgYpuZk3zoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V84SIw7B; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 057F340E01F6;
	Thu,  2 May 2024 13:45:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CAz-p8QlU9Cc; Thu,  2 May 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714657530; bh=zji4T/QOtMf3/iGCx7QJQsPxQclDFcQuEmKgqQq8AF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V84SIw7BNHOpaaG9srJty4nxAGa7z6IwwnF1aYgwWBno4+HM1G0Ibaf+WlhT3cux3
	 7HjhIqCzCa7iNZ8xeKtlu74butBVoVNviPqTfcaHroMl9pOgZEF63s9R9p61FZ9Di3
	 bY5oM6P0PQyicVh+ZOT0hQek9ATNtnOfrbWwB+OG/qgecjtY7wVilcaStYpby8gnVM
	 X9PB4q1J6+ysjYZsSvIjqJHBN4YymhUrqXLMqyaBCZZY9t2oyccXEUAg6vhobnspPF
	 YRTTLldxlsLSdEJoR/CHNSe2G62NDENeL8SEykkftszQc3dyVt9wrnTJZKtRJRhkFs
	 8zUPmWrldXD3Wwl1RBXsQcEy65LZvb+iy0rM/BJsOctVNbkcb98z9lCKm8YXsHz87q
	 iSL4Yjy8OL8NalVsFhgarLEXcdHGazqOvndvgMMOD8NKXH3D0JrH2QgQRZhviRg+OA
	 06h+TD5pND2cyOmma6JT3I+JuMA7Qz69XI3LReUu2e+04N1IjED+dyuqa/ON4q7RY0
	 aCsLR46rK4vBGuWzkDWJvBoBGiWcagr/boxQk+kR5CbMTghAt+OLO3b8jYXqCwHMxs
	 K7xzgJYWvgYw3LZ3tzJrwa5rRKshkCTdOR6HAGKWVM5soMCL/uECUSCDWczLf+x8Gm
	 RNyPyBcef/WZbC18oW/fJMEA=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F11ED40E01E8;
	Thu,  2 May 2024 13:45:07 +0000 (UTC)
Date: Thu, 2 May 2024 15:45:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: adrian.hunter@intel.com, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	jun.nakajima@intel.com, kai.huang@intel.com,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com,
	nik.borisov@suse.com, peterz@infradead.org, rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted
 memory for kexec
Message-ID: <20240502134506.GDZjOY4guvlKH9-73J@fat_crate.local>
References: <20240427164747.GCZi0sM6HBCBYtgWqF@fat_crate.local>
 <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240427170634.2397725-1-kirill.shutemov@linux.intel.com>

On Sat, Apr 27, 2024 at 08:06:34PM +0300, Kirill A. Shutemov wrote:

> Subject: Re: [PATCHv10.1 09/18] x86/mm: Adding callbacks to prepare encrypted memory for kexec

s/Adding/Add/

> AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
> This is done by allocating pages normally from the buddy allocator and
> then converting them to shared using set_memory_decrypted().
> 
> On kexec, the second kernel is unaware of which memory has been
> converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
> memory as private is fatal.
> 
> Therefore, the memory state must be reset to its original state before
> starting the new kernel with kexec.
> 
> The process of converting shared memory back to private occurs in two
> steps:
> 
> - enc_kexec_stop_conversion() stops new conversions.
> 
> - enc_kexec_unshare_mem() unshares all existing shared memory, reverting
>   it back to private.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>x
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Tao Liu <ltao@redhat.com>
> ---
>  arch/x86/include/asm/x86_init.h |  2 ++
>  arch/x86/kernel/crash.c         |  4 ++++
>  arch/x86/kernel/reboot.c        | 12 ++++++++++++
>  arch/x86/kernel/x86_init.c      |  4 ++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index 28ac3cb9b987..c731e6bc4343 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -155,6 +155,8 @@ struct x86_guest {
>  	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
>  	bool (*enc_tlb_flush_required)(bool enc);
>  	bool (*enc_cache_flush_required)(void);
> +	void (*enc_kexec_stop_conversion)(bool crash);
> +	void (*enc_kexec_unshare_mem)(void);

This is all fine and dandy but those functions need documentation in the
kernel doc above it.

And if there's a "stop_conversion" function, then I'd expect there to be
a "start conversion" one.

I think you need to give those two better names to denote that they're
related, the order in which they should be called and why they're
separate.

>  };
>  
>  /**
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index e74d0c4286c1..f1b261be78b4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -128,6 +128,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>  #ifdef CONFIG_HPET_TIMER
>  	hpet_disable();
>  #endif
> +
> +	x86_platform.guest.enc_kexec_stop_conversion(true);
> +	x86_platform.guest.enc_kexec_unshare_mem();
> +

You call them here back-to-back...

>  	crash_save_cpu(regs, safe_smp_processor_id());
>  }
>  
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index f3130f762784..c1920ec34f0c 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -12,6 +12,7 @@
>  #include <linux/delay.h>
>  #include <linux/objtool.h>
>  #include <linux/pgtable.h>
> +#include <linux/kexec.h>
>  #include <acpi/reboot.h>
>  #include <asm/io.h>
>  #include <asm/apic.h>
> @@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
>  
>  void native_machine_shutdown(void)
>  {
> +	/*
> +	 * Call enc_kexec_stop_conversion() while all CPUs are still active and
> +	 * interrupts are enabled. This will allow all in-flight memory
> +	 * conversions to finish cleanly.
> +	 */
> +	if (kexec_in_progress)
> +		x86_platform.guest.enc_kexec_stop_conversion(false);
> +
>  	/* Stop the cpus and apics */
>  #ifdef CONFIG_X86_IO_APIC
>  	/*
> @@ -752,6 +761,9 @@ void native_machine_shutdown(void)
>  #ifdef CONFIG_X86_64
>  	x86_platform.iommu_shutdown();
>  #endif
> +
> +	if (kexec_in_progress)
> +		x86_platform.guest.enc_kexec_unshare_mem();

.. but they're split here.

And I don't know why and nothing tells me...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

