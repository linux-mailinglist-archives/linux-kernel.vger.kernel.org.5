Return-Path: <linux-kernel+bounces-6090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69C819486
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A221C24698
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B63DB99;
	Tue, 19 Dec 2023 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgIdbIZ7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F33D0CA;
	Tue, 19 Dec 2023 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703028212; x=1734564212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vS5AE7N9nQ3SlnVS08m4qPs43i9JpvyT0LdsYgBIZjI=;
  b=lgIdbIZ7ew6czjd6kxX4fknJ0sYdBUk5SZu5eacEcjDShbkQd8L5aYGJ
   k+LHxwz2cHuZZU3GbyRzPcyeNs/1XZ9/Ny/mdQzC06gOqbwPH7qEpMFHK
   KG7hn9ntEsGbYtXqQ6R5mF3Eqi5a06E1CbBe474Vza+H42fzHVDkH8RCn
   x3AyWVG1DgMAIRnsuW7yTBfbQ3jdMHji/uPrhTb/70Dc85QEoOQQUgFrC
   yAcU+F+EKknS2khAsjqzB4xNdhKTA9JFhPEsXUJQ4m04ra3IeIw2s7Wwh
   oujEbJYCY20N19eqjj3fjWntqAvC51FECYT9zGJbArHjglRY3keCfXaEh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="9196787"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="9196787"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="10561229"
Received: from lveltman-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 15:23:26 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 1DC2210A43B; Wed, 20 Dec 2023 02:23:23 +0300 (+03)
Date: Wed, 20 Dec 2023 02:23:23 +0300
From: kirill.shutemov@linux.intel.com
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
	netdev@vger.kernel.org, richardcochran@gmail.com,
	linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
	zackr@vmware.com, linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
	akaher@vmware.com, jsipek@vmware.com,
	dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, horms@kernel.org
Subject: Re: [PATCH v3 6/6] x86/vmware: Add TDX hypercall support
Message-ID: <20231219232323.euweerulgsgbodx5@box.shutemov.name>
References: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
 <20231219215751.9445-7-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219215751.9445-7-alexey.makhalov@broadcom.com>

On Tue, Dec 19, 2023 at 01:57:51PM -0800, Alexey Makhalov wrote:
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 3aa1adaed18f..ef07ab7a07e1 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -428,6 +428,30 @@ static bool __init vmware_legacy_x2apic_available(void)
>  		(eax & BIT(VCPU_LEGACY_X2APIC));
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
> +				   struct tdx_module_args *args)
> +{
> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
> +		return 0;
> +
> +	if (cmd & ~VMWARE_CMD_MASK) {
> +		pr_warn("Out of range command %x\n", cmd);
> +		return 0;

Is zero success? Shouldn't it be an error?

> +	}
> +
> +	args->r10 = VMWARE_TDX_VENDOR_LEAF;
> +	args->r11 = VMWARE_TDX_HCALL_FUNC;
> +	args->r12 = VMWARE_HYPERVISOR_MAGIC;
> +	args->r13 = cmd;
> +
> +	__tdx_hypercall(args);
> +
> +	return args->r12;
> +}
> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
> +#endif
> +
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  static void vmware_sev_es_hcall_prepare(struct ghcb *ghcb,
>  					struct pt_regs *regs)
> -- 
> 2.39.0
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

