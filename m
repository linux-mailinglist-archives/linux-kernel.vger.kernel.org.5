Return-Path: <linux-kernel+bounces-59491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAC84F7E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4308B1C227B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4956BB2F;
	Fri,  9 Feb 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xba1DbnX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1037145;
	Fri,  9 Feb 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490202; cv=none; b=LHnWLG0r7aciOsNDoNY2M7GP07jyAomzz7VPke2WRAKSerE9Fi11RJ3HHcZdtMSFpE+y/ImwdGquFXIk3s84/fZs5fqZPfDugYvj2n2PeVpRFKJM0ZeVMvlDI6PTGwepj5FwmgjQEY4uTRbMetl0lnOBc1xGlvzF9hl34Yme4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490202; c=relaxed/simple;
	bh=BKZ2mtO8cS0Ik5dmaQV6ifo7dNShLGEHdT1wapWSz8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlGOSgQt5h56j4DoVSPScfLQw7vplYpkaF8NLVi5tIyeuk3HZ7FBY3Q1/DOIII7kGgD9dVyUnbvvTJ3Pl/KFi40732xANnUFmJhElQfVp6Zpxu6zIxTCGQWJjSYJpzhJsYNXZRkly5y0Ncahtj2xImjfzNrAI6EZXNvqpVpAnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xba1DbnX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707490201; x=1739026201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKZ2mtO8cS0Ik5dmaQV6ifo7dNShLGEHdT1wapWSz8M=;
  b=Xba1DbnXMnOwY7vxa+JxDvLFth77t3bFqcpyZcXR9znBRGEKkx9OTjrV
   3Ubof3meJc3b37drBKBT0MMVuiPK5v5Q+WaVK1PS5gDGJNeU+PqGkC2mT
   3sebE3uHJsSh7cIQbhSgb7+90/XAlPcOyfhQxEEDRkKmADRulK9pdp30i
   9StDVcXuZOw/TIuLS8I85qS2dJlOnq/n5imAcMWI7fdbEDb/5qCxVjyUy
   4pt7UM1ni2xiL/OlHOHpsF8Jxa6SaF9i0vHSipVb09hgK9Ze7OLXyE6L+
   4mZfo4Vs7+bi8N4rhPLDRcJuGKw0p8OvbO0oLUWuh3ERt/XKHkVGMe9cB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12810651"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12810651"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:50:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="825157463"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="825157463"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:49:53 -0800
Date: Fri, 9 Feb 2024 15:49:51 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH v1 6/9] iwlwifi: mvm: Set THERMAL_TRIP_WRITABLE_TEMP
 directly
Message-ID: <ZcY7jyyFJq1yfOCj@linux.intel.com>
References: <3232442.5fSG56mABF@kreacher>
 <3757041.MHq7AAxBmi@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3757041.MHq7AAxBmi@kreacher>

On Fri, Feb 09, 2024 at 03:10:24PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the iwlwifi code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch obviously depends on
> 
> https://patchwork.kernel.org/project/linux-pm/patch/8346768.T7Z3S40VBb@kreacher/
> 
> which has been queued up for 6.9 already.
> 
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> ===================================================================
> --- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> +++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
> @@ -667,9 +667,6 @@ static  struct thermal_zone_device_ops t
>  	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
>  };
>  
> -/* make all trips writable */
> -#define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
> -
>  static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
>  {
>  	int i, ret;
> @@ -692,11 +689,12 @@ static void iwl_mvm_thermal_zone_registe
>  	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
>  		mvm->tz_device.trips[i].temperature = THERMAL_TEMP_INVALID;
>  		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
> +		mvm->tz_device.trips[i].type = THERMAL_TRIP_WRITABLE_TEMP;

		mvm->tz_device.trips[i].flags = THERMAL_TRIP_WRITABLE_TEMP;

Consider using diffrent prefix for constants to diffrenciate flags and types.

Regards
Stanislaw

>  	}
>  	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
>  							mvm->tz_device.trips,
>  							IWL_MAX_DTS_TRIPS,
> -							IWL_WRITABLE_TRIPS_MSK,
> +							0,
>  							mvm, &tzone_ops,
>  							NULL, 0, 0);
>  	if (IS_ERR(mvm->tz_device.tzone)) {
> 
> 
> 

