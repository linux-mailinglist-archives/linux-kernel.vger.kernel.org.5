Return-Path: <linux-kernel+bounces-47153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C98449E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A771F2571C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6503B796;
	Wed, 31 Jan 2024 21:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjiAThKt"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED43B794
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736104; cv=none; b=T14ZBte4Ke+swzM7fquSiLzstdQZKW5EXVw9XCebkBuVvDJMKb5Us6L3164lxfxSKux5ZJmie8QggsrjG9mOixtSUAPNJ/G/95QuDCIjqLUslNtZDgxDA17IrIrTE5omB7Joi//GtQAdZKJ+8ZCgVkcsWtSnhU4oMVNEDBKAip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736104; c=relaxed/simple;
	bh=jqS8r2wvYIL38y7Dy0Pm/H1J46jJhP1rOxljq+J2qp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rODqWfE0VnE6/oToy+lyJAXOBrKaKMx1W6CQXuRhttdJyM7j6zP6GIdGwuOvV976HyOKcAO6cSRFPTRzRd2UDaTjhCKXIvMjBLkp3bwlz/MgAbAz1IHneaOfCT3gIKE+JWIemE4TF//x272nEv03IjbtCA1ZYMEla2i7mlrCR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjiAThKt; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706736102; x=1738272102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jqS8r2wvYIL38y7Dy0Pm/H1J46jJhP1rOxljq+J2qp0=;
  b=hjiAThKtqswola2mfJTq5whmkeI4SbGTfLAho+5AQSaHy/O2+u1fXaWE
   OYWwZBX8mTID/btvolJsmkFDqqQWWV7EH6oGwaz7kBQ9b9PTDB7KfHePJ
   7B0XoYYEevVgtlrhH5yIG4xC36ME4Bhae2XLo8wUqOzIfacHtotgH7QKr
   lqVLQ2ysY0DoojvabIsJXcvfNoYY67Zvpjn3wPZfb5FVVJiVgj1ziHXZm
   gEMI7VOOlQhOvoGA8bimV1C9fhngLvynZjPaOoz8EGUnOaB8CNhqp7yi3
   51R1SPC6ApM7BzD1+nTrjFC1Y+wGMUggBiUt+AONa8PdwPp3bjKshR6d4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467964346"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="467964346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:21:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4209959"
Received: from dspeerx-mobl.amr.corp.intel.com (HELO [10.212.131.185]) ([10.212.131.185])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:21:41 -0800
Message-ID: <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
Date: Wed, 31 Jan 2024 13:21:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, kirill.shutemov@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, thomas.lendacky@amd.com, chao.gao@intel.com,
 bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/24 03:31, Huang, Kai wrote:
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -28,6 +28,7 @@
>  #include <asm/setup.h>
>  #include <asm/set_memory.h>
>  #include <asm/cpu.h>
> +#include <asm/tdx.h>
>  
>  #ifdef CONFIG_ACPI
>  /*
> @@ -298,9 +299,24 @@ void machine_kexec(struct kimage *image)
>  	void *control_page;
>  	int save_ftrace_enabled;
>  
> +	/*
> +	 * For platforms with TDX "partial write machine check" erratum,
> +	 * all TDX private pages need to be converted back to normal
> +	 * before booting to the new kernel, otherwise the new kernel
> +	 * may get unexpected machine check.
> +	 *
> +	 * But skip this when preserve_context is on.  The second kernel
> +	 * shouldn't write to the first kernel's memory anyway.  Skipping
> +	 * this also avoids killing TDX in the first kernel, which would
> +	 * require more complicated handling.
> +	 */

This is waaaaaaaaaaaaaaay too much information to stick in a generic
function.  Just call tdx_reset_memory() and make the argument about

>  #ifdef CONFIG_KEXEC_JUMP
>  	if (image->preserve_context)
>  		save_processor_state();
> +	else
> +		tdx_reset_memory();
> +#else
> +	tdx_reset_memory();
>  #endif

Wow, that's awfully hard to read.  I really wish folks' gag reflex would
kick in when they see stuff like this to get them to spend an additional
15 seconds to turn this into:

	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
		save_processor_state();
	else
		tdx_reset_memory();

>  	save_ftrace_enabled = __ftrace_enabled_save();
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 9f1fed458a32..0537b1b76c2b 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -28,6 +28,7 @@
>  #include <linux/acpi.h>
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
> +#include <linux/reboot.h>
>  #include <asm/page.h>
>  #include <asm/special_insns.h>
>  #include <asm/msr-index.h>
> @@ -54,6 +55,8 @@ static DEFINE_MUTEX(tdx_module_lock);
>  /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
>  static LIST_HEAD(tdx_memlist);
>  
> +static bool tdx_rebooting;
> +
>  typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
>  
>  static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
> @@ -1187,6 +1190,9 @@ static int __tdx_enable(void)
>  {
>  	int ret;
>  
> +	if (tdx_rebooting)
> +		return -EAGAIN;

This whole 'tdx_rebooting' deserves to at least be in its own patch.
Also -EAGAIN seems to be a really odd return code for a permanent failure.

>  	ret = init_tdx_module();
>  	if (ret) {
>  		pr_err("module initialization failed (%d)\n", ret);
> @@ -1420,6 +1426,90 @@ static struct notifier_block tdx_memory_nb = {
>  	.notifier_call = tdx_memory_notifier,
>  };
>  
> +/*
> + * Convert TDX private pages back to normal on platforms with
> + * "partial write machine check" erratum.
> + *
> + * Called from machine_kexec() before booting to the new kernel.
> + */
> +void tdx_reset_memory(void)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
> +		return;
> +
> +	/*
> +	 * Kernel read/write to TDX private memory doesn't
> +	 * cause machine check on hardware w/o this erratum.
> +	 */
> +	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
> +		return;
> +
> +	/* Called from kexec() when only rebooting cpu is alive */
> +	WARN_ON_ONCE(num_online_cpus() != 1);
> +
> +	/*
> +	 * tdx_reboot_notifier() waits until ongoing TDX module
> +	 * initialization to finish, and module initialization is
> +	 * rejected after that.  Therefore @tdx_module_status is
> +	 * stable here and can be read w/o holding lock.
> +	 */
> +	if (tdx_module_status != TDX_MODULE_INITIALIZED)
> +		return;

kexec() can't happen until after reboot notifiers are called.
tdx_reboot_notifier() makes 'tdx_module_status' stable, so no lock is
needed.

Right?

> +	/*
> +	 * Flush cache of all TDX private memory _before_ converting
> +	 * them back to avoid silent memory corruption.
> +	 */
> +	native_wbinvd();

Since this is single-threaded, it also needs to mention where all the
other CPU caches got flushed.

> +	/*
> +	 * Convert PAMTs back to normal.  All other cpus are already
> +	 * dead and TDMRs/PAMTs are stable.
> +	 *
> +	 * Ideally it's better to cover all types of TDX private pages
> +	 * here, but it's impractical:
> +	 *
> +	 *  - There's no existing infrastructure to tell whether a page
> +	 *    is TDX private memory or not.
> +	 *
> +	 *  - Using SEAMCALL to query TDX module isn't feasible either:
> +	 *    - VMX has been turned off by reaching here so SEAMCALL
> +	 *      cannot be made;
> +	 *    - Even SEAMCALL can be made the result from TDX module may

		    ^ if     ^ a          ^,

> +	 *      not be accurate (e.g., remote CPU can be stopped while
> +	 *      the kernel is in the middle of reclaiming TDX private
> +	 *      page and doing MOVDIR64B).
> +	 *
> +	 * One temporary solution could be just converting all memory
> +	 * pages, but it's problematic too, because not all pages are
> +	 * mapped as writable in direct mapping.  It can be done by
> +	 * switching to the identical mapping for kexec() or a new page
> +	 * table which maps all pages as writable, but the complexity is
> +	 * overkill.
> +	 *
> +	 * Thus instead of doing something dramatic to convert all pages,
> +	 * only convert PAMTs here.  Other kernel components which use
> +	 * TDX need to do the conversion on their own by intercepting the
> +	 * rebooting/shutdown notifier (KVM already does that).
> +	 */

I'd leave the extended alternatives discussion in the changelog, not here.

Focus on what _this_ is doing and why it is imperfect:

 1. Just reset the PAMDs
 2. This leaves A, B, and C undealt with
 3. The risk of leaving those is ...


> +	tdmrs_reset_pamt_all(&tdx_tdmr_list);
> +}
> +
> +static int tdx_reboot_notifier(struct notifier_block *nb, unsigned long mode,
> +			       void *unused)
> +{
> +	/* Wait ongoing TDX initialization to finish */
> +	mutex_lock(&tdx_module_lock);
> +	tdx_rebooting = true;
> +	mutex_unlock(&tdx_module_lock);
> +
> +	return NOTIFY_OK;
> +}

Why is 'tdx_rebooting' a new variable instead of a new state in
tdx_module_status?


