Return-Path: <linux-kernel+bounces-86703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4AB86C944
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7564128A8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A25FEE1;
	Thu, 29 Feb 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/fCB2+f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7210185B;
	Thu, 29 Feb 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209988; cv=none; b=ofn35LBW4jBw4oNyTz1BIltj0TvTD2lA3GE7Y2/fpwaAG6S9R52zTJ2aTuhAfAOFUlEhjlfxnf+N89b8EKrHRAenlgJxJaW0ILORvKKjD/vnd46YY7shKUR+KL2hEd+IJDfPD9xKjMCljNxx0oa4bXltNoX7suzjHFfm8I3vU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209988; c=relaxed/simple;
	bh=ZKlZMmZXcw2fZf045p5kABlG1+alTG4gOk2aY7Bv/KU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=plZAJhEV8BQ1x6lM62NBAaekxj3jkDZGQlRAESc7U6GmrGHpHiTi23Ris2iRRQnrNuZGtp5EXFWLcjVC2a368k/Xu3Cq/Uw2fwdsrxVYyieaoU6PnH4CG4uHI2vK5DRlzj8URzF2HOCNAI2rtvXRidl0sXrFn1piGkJnEVAgEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/fCB2+f; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709209987; x=1740745987;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZKlZMmZXcw2fZf045p5kABlG1+alTG4gOk2aY7Bv/KU=;
  b=T/fCB2+fiv53Mzs5C/2Xff3CnMMCaINrAmcUOkzjh10Q/89kHRAQow8v
   9+Ii+Zh3iXl+KoUstcxWNvwcRgURSFdJ1WNO9P1qrFssI/U82A1+ZByaH
   Kchi2qJsOsUyepGsTtZS0wZYIKWfttvjcJZOdNtEU1uN0BYzyN7yfnrB8
   JqbBzvUofArFFB2tOywtQsadKwU+2b1M3QzwZgFag1bhYtA/1E0B+1VuA
   +YunkXU9R/MfDHegxLQIXn0Nsb8u1TBcnctqEvMHxt1+Kr6SAe4ceoHJw
   g4W+WtUaL2kIjEenlkZuPHHXw8w9feMdt4cIaAzE5PCp7K9RPg0uf1RRV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3520378"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3520378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7766258"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.250])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:32:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Feb 2024 14:32:50 +0200 (EET)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ISST: Allow reading core-power state on
 HWP disabled systems
In-Reply-To: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <23b62f29-902c-800a-1cd4-6e24d70abd86@linux.intel.com>
References: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Feb 2024, Srinivas Pandruvada wrote:

> When HWP (Hardware P-states) is disabled, dynamic SST features are
> disabled. But user should still be able to read the current core-power
> state, with legacy P-states. This will allow users to read current
> configuration with static SST enabled from BIOS.
> 
> To address this, do not call disable_dynamic_sst_features() when the
> request is for reading the state.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Is this a fix? (It's lacking the tag if it is).

-- 
 i.

> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 2662fbbddf0c..1d918000d72b 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -462,10 +462,10 @@ static long isst_if_core_power_state(void __user *argp)
>  	struct tpmi_per_power_domain_info *power_domain_info;
>  	struct isst_core_power core_power;
>  
> -	if (disable_dynamic_sst_features())
> +	if (copy_from_user(&core_power, argp, sizeof(core_power)))
>  		return -EFAULT;
>  
> -	if (copy_from_user(&core_power, argp, sizeof(core_power)))
> +	if (core_power.get_set && disable_dynamic_sst_features())
>  		return -EFAULT;
>  
>  	power_domain_info = get_instance(core_power.socket_id, core_power.power_domain_id);
> 


