Return-Path: <linux-kernel+bounces-124192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3491E8913AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920C0B21D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189284085F;
	Fri, 29 Mar 2024 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7S3itFP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852E405CD;
	Fri, 29 Mar 2024 06:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693273; cv=none; b=RmOxJrdeb5sgde4WBm62G0yGDmVQpxkml7FaTm4vS8ot37OGFXQPKVT9mWuJX6ZPC8NFVr22+vO5DiZsxUu/vSAsq28esux5dHzOqnd5qt4nx+w6K6WCWekosh8IGNt04041sAusWVuk+gGlkQXbI4Usv+FT6j/w9NDof+BUpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693273; c=relaxed/simple;
	bh=XAon6PIxrB7cKNkpAhmsMNJQkw7dDWRR/eySmWT1XdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz+uekNIcOtIVa2hGo+Dd/6Y4O/z9aCe5Ni5ZH+sq+Qnxx4GF7yqBZIWCOtRnqHIrYFh4ohWuJJflLcRSKtjkxKXgw0zlip3QjFQLRnX3I6KG0CMJkukM/QQvOQdu8tgWLJ4DtIkpiLt2rZl9jkaepj9sYXokFslDJac68Ahmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7S3itFP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711693272; x=1743229272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XAon6PIxrB7cKNkpAhmsMNJQkw7dDWRR/eySmWT1XdQ=;
  b=W7S3itFPrxnYVIGxTk/94gUMIOifcMEaCoOrQDpOrrrOFA4ZvDaLkhIY
   cfZFVtkbkMiIeNP8J2APuZMymkXQ9Sk7aP+t30kHi/9tz1/od3eG2JkMk
   yyt606DXmcV78cv/V7ZNe+WFVf+bqLCyXBAFusocM+SFbTXH0zcIt2Oix
   tp/xUCunQV81iyVaps8rp9dAzdX0zNMXJXvX2yMfCjFgRIPoG2gO5mHkw
   jElETKG7qa+OOfj+Ppbb+Zqgjh6OoIZHvTHXTnKmjW22HjeySO2ebQvfj
   EcH2RX3I3voWJ/E7dWrovy1L1gBbb3+jHyCbPyC0IHyqvor5AKkTcQqeI
   Q==;
X-CSE-ConnectionGUID: Ht358FN/QlWaEHDG3gcX9w==
X-CSE-MsgGUID: lUN1QM6AQJakQIUkAaVlSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17599904"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17599904"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 23:21:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="21393903"
Received: from atanneer-mobl.amr.corp.intel.com (HELO desk) ([10.209.84.81])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 23:21:09 -0700
Date: Thu, 28 Mar 2024 23:20:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dm-devel@redhat.com, ebiggers@kernel.org, luto@kernel.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
	ardb@kernel.org, elliott@hpe.com, dan.j.williams@intel.com,
	bernie.keany@intel.com, charishma1.gairuboyina@intel.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v9 11/14] x86/cpu/keylocker: Check Register File Data
 Sampling mitigation
Message-ID: <20240329062057.kt5dkoffbkkxdt7x@desk>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <20240329015346.635933-12-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329015346.635933-12-chang.seok.bae@intel.com>

On Thu, Mar 28, 2024 at 06:53:43PM -0700, Chang S. Bae wrote:
> The Register File Data Sampling vulnerability may allow malicious
> userspace programs to infer stale kernel register data, potentially
> exposing sensitive key values, including AES keys.
> 
> To address this vulnerability, a microcode update needs to be applied to
> the CPU, which modifies the VERW instruction to flush the affected CPU
> buffers.
> 
> The kernel already has a facility to flush CPU buffers before returning
> to userspace, which is indicated by the X86_FEATURE_CLEAR_CPU_BUF flag.
> 
> Ensure the mitigation before enabling Key Locker. Do not enable the
> feature on CPUs affected by the vulnerability but lacks mitigation.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
> Change from v8:
> * Add as a new patch.
> 
> Note that the code change follows the mitigation guidance [1]:
>   "Software loading Key Locker keys using LOADIWKEY should execute a VERW
>    to clear registers before transitioning to untrusted code to prevent
>    later software from inferring the loaded key."
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/register-file-data-sampling.html
> ---
>  arch/x86/kernel/keylocker.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
> index d4f3aa65ea8a..6e805c4da76d 100644
> --- a/arch/x86/kernel/keylocker.c
> +++ b/arch/x86/kernel/keylocker.c
> @@ -135,12 +135,29 @@ static bool __init have_gds_mitigation(void)
>  	return false;
>  }
>  
> +/*
> + * IA32_ARCH_CAPABILITIES MSR is retrieved during the setting of
> + * X86_BUG_RFDS. Ensure that the mitigation is applied to flush CPU
> + * buffers by checking the flag.
> + */
> +static bool __init have_rfds_mitigation(void)
> +{
> +	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
> +		return true;

X86_FEATURE_CLEAR_CPU_BUF is also set by other VERW based mitigations
like MDS. The feature flag does not guarantee that the microcode
required to mitigate RFDS is loaded.

A more robust check would be:

	if (rfds_mitigation == RFDS_MITIGATION_VERW)
		return true;

And it would be apt to move this function to arch/x86/kernel/cpu/bugs.c

> +
> +	pr_warn("x86/keylocker: Susceptible to the RFDS vulnerability.\n");
> +	return false;
> +}
> +
>  /* Check if Key Locker is secure enough to be used. */
>  static bool __init secure_keylocker(void)
>  {
>  	if (boot_cpu_has_bug(X86_BUG_GDS) && !have_gds_mitigation())
>  		return false;
>  
> +	if (boot_cpu_has_bug(X86_BUG_RFDS) && !have_rfds_mitigation())
> +		return false;
> +
>  	return true;
>  }

