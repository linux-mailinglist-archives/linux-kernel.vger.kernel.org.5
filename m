Return-Path: <linux-kernel+bounces-83958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F286A096
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EB4B2632B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3A14A085;
	Tue, 27 Feb 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEug2JYq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF76A010;
	Tue, 27 Feb 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063654; cv=none; b=Q74xLKDUYbHcffj74oOfyndGr/m6zAAfrOeAf3ZWeJGPHbNZfYSvzyERBxJ9YvlHn1eYBGB5roOTuqh6OVTlwYFxenSfqRpR8S8W4UvMX+SEtsFodSXp8gHg4VQf/W9SwQlyup91fd6DuXKxP5gOXfcEeCLxujjnq8Mabd1LjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063654; c=relaxed/simple;
	bh=IhmLuGfw0M7Nt6pVWN2a2iLmgt3/E24V7TPiIkAcoJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gJqtAmiCB6j2k5+mk+RxOiwfpQrgXXgjb1uyhNha30XOFtOS0ei4Tzse/czuRMbwgy7EC3QZmcrNweVlwuZvJi7CQgN+10Frj6xl907+nR98h9bPbm2xDF6E3rFnTBn9DcwND5013897ZOpnDeTVcpPVA13Vm+vuEaL+35pt+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEug2JYq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709063652; x=1740599652;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IhmLuGfw0M7Nt6pVWN2a2iLmgt3/E24V7TPiIkAcoJ0=;
  b=YEug2JYqoZzoP/Jp7Fl2zXV7bSylMJ/x2QSkJRhy6HGqnNOJxoiJLB2/
   PUb1tlywT6W0blS1+TyVtOSoMRA4Ta1FfP+pVxxWaN8GlcTDxODzN/GYJ
   rMO8NFmI4HwkYgXuAH+xvmH8yyiBKQZ0UiU69ssp1qzinecPRroART7AB
   syaIaVJWuUKG4yVXa+OWcy06goPRLyp1fNyV/87G0FzJYIJO+g0o2GdaC
   BdiI15mfu8CeSaccDDSlyZ04wEB9Uowq1DMMdINBYbHFl7hZoGOnPValT
   b6O3aNYwGNaGKJ2EEsBHNy9IABb7awJZrEw8h8D7qvFabTzHvFw69Q3ii
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14582330"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14582330"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:54:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="11754828"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:54:11 -0800
Message-ID: <beb6d2e6-9442-4a23-99d6-4357cc112961@linux.intel.com>
Date: Tue, 27 Feb 2024 11:54:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240227190134.1592072-1-david.e.box@linux.intel.com>
 <20240227190134.1592072-3-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240227190134.1592072-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/27/24 11:01 AM, David E. Box wrote:
> As is the case on Meteor Lake, the Gaussian & Neural Accelerator (GNA)
> device is powered by BIOS to D0 by default. If no driver is loaded, this
> will cause the Package C state to be limited to PC2, leading to
> significant power consumption and decrease in batter life.  Put the GNA
> device in D3 by default if no driver is loaded for it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>
> V2 - Better explain the issue in the changelog and spell out GNA.
>
>  drivers/platform/x86/intel/pmc/arl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 683ae828276b..34b4cd23bfe5 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] = {
>  };
>  
>  #define ARL_NPU_PCI_DEV			0xad1d
> +#define ARL_GNA_PCI_DEV			0xae4c
>  /*
>   * Set power state of select devices that do not have drivers to D3
>   * so that they do not block Package C entry.
> @@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] = {
>  static void arl_d3_fixup(void)
>  {
>  	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
> +	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
>  }
>  
>  static int arl_resume(struct pmc_dev *pmcdev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


