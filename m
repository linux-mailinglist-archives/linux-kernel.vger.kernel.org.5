Return-Path: <linux-kernel+bounces-40222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9774D83DCAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CB22827EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF611D530;
	Fri, 26 Jan 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQKmbnMh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2571CFBB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280300; cv=none; b=MU7JlGaE9h6ZhZ2iLuKTqHB0avdmPbx02AhE3LnvpcVQTg/ovUGVqf9Cdn7NbXox3HYg6W/MGO3fOXfDtJyjBqf/3Zmm64kZH+e9Ini+lEeOrSzvqJcV5d6XF6eG/xgQ0jX3fU7Plh1xz2UnXF4coMsGu7cBAuY1xxS2QgRBgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280300; c=relaxed/simple;
	bh=bym/ajJOjcQl8LKnRUAO/z1T8s/laBYaWYjbSMZv0tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETb59M4Cw176o3dQvvZaXmZPTNX2JR6uRMlCGy4kr6U0rBqgulBu9zLLKais/ZwCrKs8Sl7QSUnSLO5a1VcUEAn2/nKOtVjOxobFw8rRT/eLmTs8or4iHXh2npCdosilZXztuNHhu7Tn/55PPrNQh+BA8Hjg2rTz+wrCY8xGzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQKmbnMh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706280299; x=1737816299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bym/ajJOjcQl8LKnRUAO/z1T8s/laBYaWYjbSMZv0tE=;
  b=nQKmbnMhRtA1aq2I7/9AyObPl03r8xvWETYYcABh72eR9oOvJQ6P4Ndk
   FqpD7ody29G2dAGuBM6X/S2Xh5/7JcYxKQBZ35Xm+vKIdg5AzSFlPEzgC
   5XeKoFQ/EKBLW2VT0JSjVJK2J2V+lAh/fz4PiUV5aqmJ9bAVgkEzOA0uu
   OkDavpDnJeZKtM50MBhiwFbMkxEJYi5F/AfHG8Nb3zpRHhrNLMnnFfjHh
   XZufoliYz8gI1VSwb40Iyvlvo/LM/NdxAkJS4R0SEUXDM2Pw0UhU7jOVQ
   hv8iHsTF4nJZj/f5KsfoivaMqNsJjImtKAovpZ1/VxSbej545orywFciY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2371526"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2371526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 06:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821159831"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821159831"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 26 Jan 2024 06:44:54 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 26 Jan 2024 16:44:53 +0200
Date: Fri, 26 Jan 2024 16:44:53 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: wangxiaoming321 <xiaoming.wang@intel.com>
Cc: lucas.demarchi@intel.com, ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe/display: Fix memleak in display initialization
Message-ID: <ZbPFZVdToW389mj_@intel.com>
References: <20240125063633.989944-1-xiaoming.wang@intel.com>
 <20240126143433.997078-1-xiaoming.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240126143433.997078-1-xiaoming.wang@intel.com>
X-Patchwork-Hint: comment

On Fri, Jan 26, 2024 at 10:34:33PM +0800, wangxiaoming321 wrote:
> intel_power_domains_init has been called twice in xe_device_probe:
> xe_device_probe -> xe_display_init_nommio -> intel_power_domains_init(xe)
> xe_device_probe -> xe_display_init_noirq -> intel_display_driver_probe_noirq
> -> intel_power_domains_init(i915)

Why are you calling it twice?

> 
> It needs add a flag to avoid power_domains->power_wells double malloc.
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
>  drivers/gpu/drm/i915/display/intel_display_power.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
> index bf9685acf75a..3b48a1cb7c54 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_power.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_power.c
> @@ -36,6 +36,8 @@
>  	for_each_power_well_reverse(__dev_priv, __power_well)		        \
>  		for_each_if(test_bit((__domain), (__power_well)->domains.bits))
>  
> +static int intel_power_domains_init_flag = 0;
> +
>  const char *
>  intel_display_power_domain_str(enum intel_display_power_domain domain)
>  {
> @@ -1016,6 +1018,11 @@ int intel_power_domains_init(struct drm_i915_private *dev_priv)
>  {
>  	struct i915_power_domains *power_domains = &dev_priv->display.power.domains;
>  
> +	if(intel_power_domains_init_flag == 1)
> +		return 0;
> +
> +	intel_power_domains_init_flag++;

Consider what happens when you have multiple Intel GPUs in the system...

> +
>  	dev_priv->display.params.disable_power_well =
>  		sanitize_disable_power_well_option(dev_priv,
>  						   dev_priv->display.params.disable_power_well);
> @@ -1041,6 +1048,7 @@ int intel_power_domains_init(struct drm_i915_private *dev_priv)
>   */
>  void intel_power_domains_cleanup(struct drm_i915_private *dev_priv)
>  {
> +	intel_power_domains_init_flag = 0;
>  	intel_display_power_map_cleanup(&dev_priv->display.power.domains);
>  }
>  
> -- 
> 2.25.1

-- 
Ville Syrjälä
Intel

