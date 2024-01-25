Return-Path: <linux-kernel+bounces-38093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F483BADE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC89B26C69
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599E17582;
	Thu, 25 Jan 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db10bK8Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B912E54;
	Thu, 25 Jan 2024 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706168441; cv=none; b=CLDxvBd2zhZ3bDzlvfv6nDIM22U2u8x6VGvQ5g/FQ2ctvDXuBXr1Plc7f7iACYYzz8ZOMp/QL5CTBHr0k3/K33UczZ0NshW7CMr9/UgQzt7h44MKY7/lHh9hW5tBwevFkCF95JSRSrQIctxxyijOR8wBGqBbUo72LPGm2gWVTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706168441; c=relaxed/simple;
	bh=DjqqEralO9zXx1N2wUxK/UMU/WyHK+u1IMpeXUrRQIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPaIlkZT0zOX3rFBhBV9kTShdzgsjLgTeYra5O3FiCLoIt8n6mlRhp0iQk00kFTRaOkmJN509LPtxhHzeXKc4bbKeD5Lt1oAYpt7njcYBBnhdZiHnQJy3+76LChu2B0T+2U79/h0cH02jh77tStBtPkq4mO7pdNybR39ecJbAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db10bK8Z; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706168439; x=1737704439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DjqqEralO9zXx1N2wUxK/UMU/WyHK+u1IMpeXUrRQIk=;
  b=db10bK8Zx/TPPuKX8garM+ybCPwSAy5YCg4L2P2ltA45+ae3YcxfPUFB
   V6uwW2RLxZTG/LD1yerxgibm0mpkAjE+t5TSdhB/tIS2mvsezQf5KdWpv
   pVb8bE7aXEbbqi+eEHWqnqM3wYSwJKjeQRU1SYIrvGAxs/+5io5mMAOtl
   mpfdm4BFoMs+cts0/dAI8Sacg8eVm1tJQDhv3JeboEpEsYb+NhL3mberE
   BkojQXgHlSRK5Gg3pZcc7MPTHsB43FkvGLAkZk2QAoVP0x3o3dIzrmvVv
   nctRU0TOBmfl8ptiMhxb1z8jJICmOtrrELz13+nsLZ0rNRa2rcIUZnK7K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399247853"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399247853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909917935"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909917935"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 23:40:36 -0800
Date: Thu, 25 Jan 2024 08:40:33 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 01/12] PM: sleep: Simplify dpm_suspended_list walk in
 dpm_resume()
Message-ID: <ZbIQcQBpy3Y8lWdH@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <4553341.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4553341.LvFx2qVVIh@kreacher>

On Mon, Jan 22, 2024 at 12:22:38PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that devices can be moved to dpm_prepared_list before running
> their resume callbacks, in analogy with dpm_noirq_resume_devices() and
> dpm_resume_early(), because doing so will not affect the final ordering
> of that list.
> 
> Namely, if a device is the first dpm_suspended_list entry while
> dpm_list_mtx is held, it has not been removed so far and it cannot be
> removed until dpm_list_mtx is released, so moving it to dpm_prepared_list
> at that point is valid.  If it is removed later, while its resume
> callback is running, it will be deleted from dpm_prepared_list without
> changing the ordering of the other devices in that list.
> 
> Accordingly, rearrange the while () loop in dpm_resume() to move
> devices to dpm_prepared_list before running their resume callbacks and
> implify the locking and device reference counting in it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/base/power/main.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1017,25 +1017,19 @@ void dpm_resume(pm_message_t state)
>  
>  	while (!list_empty(&dpm_suspended_list)) {
>  		dev = to_device(dpm_suspended_list.next);
> -
> -		get_device(dev);
> +		list_move_tail(&dev->power.entry, &dpm_prepared_list);
>  
>  		if (!dev->power.async_in_progress) {
> +			get_device(dev);
> +
>  			mutex_unlock(&dpm_list_mtx);
>  
>  			device_resume(dev, state, false);
>  
> +			put_device(dev);
> +
>  			mutex_lock(&dpm_list_mtx);
>  		}
> -
> -		if (!list_empty(&dev->power.entry))
> -			list_move_tail(&dev->power.entry, &dpm_prepared_list);
> -
> -		mutex_unlock(&dpm_list_mtx);
> -
> -		put_device(dev);
> -
> -		mutex_lock(&dpm_list_mtx);
>  	}
>  	mutex_unlock(&dpm_list_mtx);
>  	async_synchronize_full();
> 
> 
> 

