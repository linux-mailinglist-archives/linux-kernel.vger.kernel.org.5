Return-Path: <linux-kernel+bounces-120258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6788D4FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E841C23EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8203F224DC;
	Wed, 27 Mar 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIPDlqEf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8E25630
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509857; cv=none; b=WoV373TKPkjpgYOew5sPI7PdxfB/+5wcYEkV6fnEF3aS7xtEXJz0y/GZIMEI5p/LvvmLlxKHbnbIxA/SmafC8s+tTczVbDXw09259PnPfte/EzYhV3LpLaW81X9pZv9m0xhWaabm+uPjhS2kh0sdlSbB3CIv85cslKgG1CYZcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509857; c=relaxed/simple;
	bh=tF4G76ep62WwlIntxiYUQoDxB6A1X3zOfyn27uQCUwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXBNCjO3e+FKfYeG/ywmh3ReKgX8bAvD/8ZuVif3S9OgZcjh6SCZeVIYr6xlvnCSmdhNYeCac2smCHfceIbFZPwpUL53I6fjw9zS2+eDDbl9ygWSVJ87258dt4RwUvK2UpyjCieHaxiQHlDZfv6QjnYYHWA1Bg2Vttml9wOtn9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIPDlqEf; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711509855; x=1743045855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tF4G76ep62WwlIntxiYUQoDxB6A1X3zOfyn27uQCUwk=;
  b=KIPDlqEfmLjOWGyn4TpGQ+fQPgfiEEm+MfJl+A68c3+TsFOBDT3UAEkK
   vKVXDWVmLK7Eef6IZfxZdHnuaXCLsM3i25ehyCh5xx7RTEGi4gFWWjCTK
   o9GQ7jCWIU3VQ8rbv91ztCfX3eKyB2w7KDwlH/daaK2lwzFfpDM+QcT73
   8hpc9fYAHZ23aeqQsH6WH5llX0QWH62HKfrKtyeTULvEPLj6ytMbbJXB2
   3CwVtkdcaTM9UCQxzTczv/yIhiEm9DWpRTNw3b6B81kHK15eB8fL3xPKb
   H+kIvviqyrV9P+/I0Ar++SP5IIVj5VorMlLZ2saAEOjipKecUqHMHsSEc
   Q==;
X-CSE-ConnectionGUID: +q/6HnspS2+evLwa4sxl3Q==
X-CSE-MsgGUID: CmGxPzUYRSO3pqJP0+Gd/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="7193244"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="7193244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="47343095"
Received: from shyammoh-mobl1.amr.corp.intel.com (HELO desk) ([10.209.17.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:24:13 -0700
Date: Tue, 26 Mar 2024 20:24:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Message-ID: <20240327032403.llcp3rj4glf7if75@desk>
References: <20240326163027.16591-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326163027.16591-1-xry111@xry111.site>

On Wed, Mar 27, 2024 at 12:30:27AM +0800, Xi Ruoyao wrote:
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
> 
> So don't disable INVLPG if the microcode is new enough.  The precise
> minimum microcode revision fixing the issue is provided by engineer from
> Intel.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
> Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
> Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
> Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
> Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/x86/mm/init.c | 39 +++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..475b2d728acc 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,33 +261,48 @@ static void __init probe_page_size_mask(void)
>  	}
>  }
>  
> -#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
> -			      .family  = 6,			\
> -			      .model = _model,			\
> -			    }
> +#define INTEL_MATCH(_model, _fixed_microcode)	\
> +	{					\
> +	  .vendor	= X86_VENDOR_INTEL,	\
> +	  .family	= 6,			\
> +	  .model	= _model,		\
> +	  .driver_data	= _fixed_microcode,	\
> +	}
> +
>  /*
>   * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * on these CPUs when PCIDs are enabled and the
> + * microcode is not updated to fix the issue.
>   */
>  static const struct x86_cpu_id invlpg_miss_ids[] = {
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
> +	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x118),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4117),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x2e),
>  	{}
>  };
>  
>  static void setup_pcid(void)
>  {
> +	const struct x86_cpu_id *invlpg_miss_match;
> +
>  	if (!IS_ENABLED(CONFIG_X86_64))
>  		return;
>  
>  	if (!boot_cpu_has(X86_FEATURE_PCID))
>  		return;
>  
> -	if (x86_match_cpu(invlpg_miss_ids)) {
> +	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
> +
> +	/*
> +	 * The hypervisor may lie about the microcode revision, conservatively
> +	 * consider the microcode not updated.
> +	 */
> +	if (invlpg_miss_match &&
> +	    (boot_cpu_has(X86_FEATURE_HYPERVISOR) ||
> +	     invlpg_miss_match->driver_data > boot_cpu_data.microcode)) {

Nit, I think below reads better:

	     boot_cpu_data.microcode < invlpg_miss_match->driver_data)) {

>  		pr_info("Incomplete global flushes, disabling PCID");
>  		setup_clear_cpu_cap(X86_FEATURE_PCID);
>  		return;

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

