Return-Path: <linux-kernel+bounces-124217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDFD8913F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FC5B22D94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698633FE2B;
	Fri, 29 Mar 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPeog6it"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F293FB8C;
	Fri, 29 Mar 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695471; cv=none; b=P44/vE3hjlBgAUKwqwCsCYC6kmX55WBd3RtvwgNhCe/lwVIovBSOVWqVVSNZqbz+lYrvxM0o/wB1pzbSRKKeKW0+454reCzv2ra+7U4Uq1GP2a4B38iTslF53WSn9JZ7q8uQDfn6xX4VZzDHatm55/dk0vz+Rom+U5eBvRjKCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695471; c=relaxed/simple;
	bh=3tp0OjNh8FoNAxu2MnETSB9plHBlxQ/kYzlSx8y1UpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyteSu2uykixX1DVdkIx/2rBSWRwB62rtmQzPSXSnEefnfcBJOnmMG1dKfz6xiomo2rGPp3LUPymIwoJ8U8WJoXsf5BJPNz4ofACp4hYnY38i2QbRyxvqAeyJVdPC5d6mP7foeAhflCZlu0GvjANLDrswb7+3GRfVlLaCtE6lHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPeog6it; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711695470; x=1743231470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tp0OjNh8FoNAxu2MnETSB9plHBlxQ/kYzlSx8y1UpU=;
  b=RPeog6itdr8XcKWKrmQNUQYPfkYt/pQ0yJ5HsnRnfRWG+72H7uAXjtBy
   7dPHRIvrEg2u3pS9+J8aImXKCwXoeF8JXSzv+kSDCudzj47gxdsSxWasa
   bq/mWvG3UIkYJmFm7EoPQIfNrOj0LMnhYLPzAEeb+u0y47XI4adcq6EKL
   Kxoc6FXctL/kGVxb+JxUhMITgXzxGJeN/kZlUdsm7J0COYofjWQy08Vzb
   65IcXd7WhXZYgye2gwUyk0qC2EmCPmD6bDsr4lIfR/Z2IDHe0WyivA84+
   MWXuUqJzROS34qTYqiv/ntsIO4VHtQTEVvJfuhnivg34Fta5Jw5jZKOqQ
   Q==;
X-CSE-ConnectionGUID: Vr6mqM4oQ1aS2gFIn90QCw==
X-CSE-MsgGUID: eK9qESqfTnWfuHLKAK91ag==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="18027410"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="18027410"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 23:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="54351691"
Received: from atanneer-mobl.amr.corp.intel.com (HELO desk) ([10.209.84.81])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 23:57:49 -0700
Date: Thu, 28 Mar 2024 23:57:42 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	dm-devel@redhat.com, ebiggers@kernel.org, luto@kernel.org,
	dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
	ardb@kernel.org, elliott@hpe.com, dan.j.williams@intel.com,
	bernie.keany@intel.com, charishma1.gairuboyina@intel.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v9 10/14] x86/cpu/keylocker: Check Gather Data Sampling
 mitigation
Message-ID: <20240329065742.fc5of75e776y2g4b@desk>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
 <20240329015346.635933-11-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329015346.635933-11-chang.seok.bae@intel.com>

On Thu, Mar 28, 2024 at 06:53:42PM -0700, Chang S. Bae wrote:
> +/*
> + * The mitigation is implemented at a microcode level. Ensure that the
> + * microcode update is applied and the mitigation is locked.
> + */
> +static bool __init have_gds_mitigation(void)
> +{
> +	u64 mcu_ctrl;
> +
> +	/* GDS_CTRL is set if new microcode is loaded. */
> +	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL))
> +		goto vulnerable;
> +
> +	/* If GDS_MITG_LOCKED is set, GDS_MITG_DIS is forced to 0. */
> +	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
> +	if (mcu_ctrl & GDS_MITG_LOCKED)
> +		return true;

Similar to RFDS, above checks can be simplified to:

	if (gds_mitigation == GDS_MITIGATION_FULL_LOCKED)
		return true;
> +
> +vulnerable:
> +	pr_warn("x86/keylocker: Susceptible to the GDS vulnerability.\n");
> +	return false;
> +}

