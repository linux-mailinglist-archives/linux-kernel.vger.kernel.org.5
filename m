Return-Path: <linux-kernel+bounces-57664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDC584DBF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1BC1F2203E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AD6F077;
	Thu,  8 Feb 2024 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cC08pJx+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774F6EB5B;
	Thu,  8 Feb 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382159; cv=none; b=PSiaG6c0TNsCrNEczlpD0/nRLQifbkRluxcIX/ehQdT2s+6PIfKy7WJJH+9gMWCXFROTq7KM7SfXCW65j7sg3HPEGdcPhmkK+hvb0lwNFmDoaRg4vIFpubP4QtJXuagquSH2Bba1RnZlKqQsUjA9cBobqohBmtfd41X54ye0HOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382159; c=relaxed/simple;
	bh=IJLtddHK7syBOJK/ZgKwSd4O3Qu/43q6Jg6D0Bzd2zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKYl71QoXGcCNgDcm9qvX7U3xwkVNLNL4GjdRxPF6N6EPJwiA1y42HZDYE25mI0aRf5uJ0YH7rWBPhnIeHNjtZ0I9nXYQepR6f5PVI05EmWGj65NRAf6EuLoojNFowdnmTn2TBVRfYeSw+8YXLPMkiLAmymyj0RxluYhgBPZfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cC08pJx+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707382158; x=1738918158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJLtddHK7syBOJK/ZgKwSd4O3Qu/43q6Jg6D0Bzd2zs=;
  b=cC08pJx+Ko9UXqkE9MAxsL1SNyRAPRZzSgZkCjtE8CcKzMzrTbVWkqRG
   cOnwoJdMn3WOFegG/EHyj8TUTgv15WjxSaX8Mz+ZAdGXofbchu0OZzNWy
   cvp7oGtqodSdYVf6/LElHVSZIDZNe3NlpGInmHhz6XlCW1ZPSReS2HKp9
   RbTm5q2mZKJOoupsLplWM3TFzvjv02yjCsrhW626+dI/vaubvT7FBdpIl
   UFp+z8ssZq3SHrFuaLvitMzTQ37PNbQ8IAPsePrp8pTeEByMploqQucUg
   u6pyAHcEoYCOZDYhNkKhjrB+tvAsYl5nCgwU15zawAVIt/k3iNCwbxiGU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1328314"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1328314"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1588199"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:49:13 -0800
Date: Thu, 8 Feb 2024 09:49:11 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 5/6] thermal: ACPI: Constify acpi_thermal_zone_ops
Message-ID: <ZcSVh87SbdPCdxBY@linux.intel.com>
References: <2728491.mvXUDI8C0e@kreacher>
 <13456661.uLZWGnKmhe@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13456661.uLZWGnKmhe@kreacher>

On Mon, Feb 05, 2024 at 10:18:50PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, acpi_thermal_zone_ops need not be modified by
> the thermal core and so it can be const.
> 
> Adjust the code accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/acpi/thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -620,7 +620,7 @@ acpi_thermal_unbind_cooling_device(struc
>  	return acpi_thermal_bind_unbind_cdev(thermal, cdev, false);
>  }
>  
> -static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
> +static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>  	.bind = acpi_thermal_bind_cooling_device,
>  	.unbind	= acpi_thermal_unbind_cooling_device,
>  	.get_temp = thermal_get_temp,
> 
> 
> 
> 

