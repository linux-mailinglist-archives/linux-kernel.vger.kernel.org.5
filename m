Return-Path: <linux-kernel+bounces-38302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9983BD9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037091C2531B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8421CD05;
	Thu, 25 Jan 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgAzILgj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C21CAA1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175710; cv=none; b=IqTuilKYxnpVpEE/SBfLDrbZ7RsXlRiDy8u7CutHO5BKuwMD6cx4ht5gZH/loFpOZt+LueLUhO7wryOsNFu33uKHRojqwZAsXq4/uzfZgFETbPhbgzeCzCdLnvMCpBl7tL2J/hHrIo6LW0O9sQEr9kFqZmdi1zVVctTR69HKtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175710; c=relaxed/simple;
	bh=WeBZw7CQQ/b0Kuc3VgepmfjtbEo4oCwHmiOwv7/FBic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GOB59X6CztC9LkZOn5lqkJtYw7BbL7Hdyp9Ut5CsRqnK36TR9v9QE7hp6rgpV5wih6FQF+Cu1lnZzFMWfGsRcS5PyS64TUpbyiMiFWt045tCvXJkVHMoe2QUcsPFynC3tD9RxnwlSuIhfFSSvvAiEGgixwQ0eVXIsByA9+wAWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgAzILgj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706175709; x=1737711709;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WeBZw7CQQ/b0Kuc3VgepmfjtbEo4oCwHmiOwv7/FBic=;
  b=bgAzILgjHtU/QDu5b6EHx7oVirh9vfHb5CCh4r3VTJCcQDr+X51Xky2v
   6SBgdZyM9CIy/6matOWw2+F5IDzaKIZdjBVZKHN+0/y1zynE6mwrR0vm7
   JcOTMOuZI3t0lB/YvrEgYozlEUCp8Mp/yxVoI0H8q/wRu3RHMzY2Nr5Zg
   I4rcf4AiUc4Al2gRvpQqdyOcQ1/uifai+tG9zw0IjE5t8S9+J4BW8FGjz
   ACYMUdLXLWyWv3kuQdzN5bbaI5p22noQauqFsD+WViF60onpppus60stJ
   KYjMJcf8SI47JEUwdX8+kIUsEGpXW2VDIvcGZRe99JYP3WI/0cNJODpn3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20662385"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20662385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959789568"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959789568"
Received: from cyrillet-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.252])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:41:43 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: wangxiaoming321 <xiaoming.wang@intel.com>, lucas.demarchi@intel.com,
 ogabbay@kernel.org, thomas.hellstrom@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: wangxiaoming321 <xiaoming.wang@intel.com>
Subject: Re: [PATCH] drm/xe/display: Fix memleak in display initialization
In-Reply-To: <20240125063633.989944-1-xiaoming.wang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240125063633.989944-1-xiaoming.wang@intel.com>
Date: Thu, 25 Jan 2024 11:41:40 +0200
Message-ID: <87bk99lpgr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 25 Jan 2024, wangxiaoming321 <xiaoming.wang@intel.com> wrote:
> In the call stack xe_device_probe ->  xe_display_init_nommio -> intel_power_domains_init
> Power_domains  hasn't been cleaned up if return error,
> which has do the clean in i915_driver_late_release call from i915_driver_probe.

This has nothing to do with i915_*.

If intel_power_domains_init() returns an error, it should have cleaned
up after itself, not force its caller to do that. If there's an issue,
please fix it in intel_power_domains_init().

BR,
Jani.


>
> unreferenced object 0xffff88811150ee00 (size 512):
>   comm "systemd-udevd", pid 506, jiffies 4294674198 (age 3605.560s)
>   hex dump (first 32 bytes):
>     10 b4 9d a0 ff ff ff ff ff ff ff ff ff ff ff ff  ................
>     ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff8134b901>] __kmem_cache_alloc_node+0x1c1/0x2b0
>     [<ffffffff812c98b2>] __kmalloc+0x52/0x150
>     [<ffffffffa08b0033>] __set_power_wells+0xc3/0x360 [xe]
>     [<ffffffffa08562fc>] xe_display_init_nommio+0x4c/0x70 [xe]
>     [<ffffffffa07f0d1c>] xe_device_probe+0x3c/0x5a0 [xe]
>     [<ffffffffa082e48f>] xe_pci_probe+0x33f/0x5a0 [xe]
>     [<ffffffff817f2187>] local_pci_probe+0x47/0xa0
>     [<ffffffff817f3db3>] pci_device_probe+0xc3/0x1f0
>     [<ffffffff8192f2a2>] really_probe+0x1a2/0x410
>     [<ffffffff8192f598>] __driver_probe_device+0x78/0x160
>     [<ffffffff8192f6ae>] driver_probe_device+0x1e/0x90
>     [<ffffffff8192f92a>] __driver_attach+0xda/0x1d0
>     [<ffffffff8192c95c>] bus_for_each_dev+0x7c/0xd0
>     [<ffffffff8192e159>] bus_add_driver+0x119/0x220
>     [<ffffffff81930d00>] driver_register+0x60/0x120
>     [<ffffffffa05e50a0>] 0xffffffffa05e50a0
>
> Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_display.c b/drivers/gpu/drm/xe/xe_display.c
> index 74391d9b11ae..2725afba4afb 100644
> --- a/drivers/gpu/drm/xe/xe_display.c
> +++ b/drivers/gpu/drm/xe/xe_display.c
> @@ -146,8 +146,10 @@ int xe_display_init_nommio(struct xe_device *xe)
>  	intel_detect_pch(xe);
>  
>  	err = intel_power_domains_init(xe);
> -	if (err)
> +	if (err) {
> +		intel_power_domains_cleanup(xe);
>  		return err;
> +	}
>  
>  	return drmm_add_action_or_reset(&xe->drm, xe_display_fini_nommio, xe);
>  }

-- 
Jani Nikula, Intel

