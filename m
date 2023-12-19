Return-Path: <linux-kernel+bounces-4905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1685D8183A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB75AB22785
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73331134C7;
	Tue, 19 Dec 2023 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUgRiZk2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381612B92;
	Tue, 19 Dec 2023 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975448; x=1734511448;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=y23D3/S71Dkftkw0q5rEVVQsi0eBjpjp26UrTr3izLc=;
  b=KUgRiZk2w2f2BrKsq9pVDfkkhbb0GSbQ/1okg7oWT0p/kzrLHm7QxnXu
   8QpWPJXn3QS43bOWC1ny6szhZAI99vfqKLpoVN/CfUe0hWyUnJO5ufdNE
   iXh/WOcNays+DDeJ4HvS4OZ253+LyVZg61gtpc7YGlJ4KIwcLxV43uCoQ
   xVNkHthlsnpdO7Z0wvvtlCuwYrbpyB2sd+eKkGGrPt4F4x80SargGiMTZ
   KPMnLQhumSDI0rGsV3sh1p6Vs1Lnx/s0ZJtLSF4ctYRDyNP1Z6H+uq9pI
   PwJJpNTeNkHqQhWJd/WQkx/ERdJGO0WLn3b9g0T9w/8nSEngyIC8oRJb8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969797"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:44:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1107277246"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1107277246"
Received: from alexeyze-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.118])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:44:04 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, tzimmermann@suse.de, Ziqi Zhao
 <astrajoan@yahoo.com>, Maxime Ripard <mripard@kernel.org>,
 dri-devel@lists.freedesktop.org, Harshit Mogalapalli
 <harshit.m.mogalapalli@oracle.com>,
 syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
Subject: Re: [PATCH AUTOSEL 4.14 3/6] drm/crtc: Fix uninit-value bug in
 drm_mode_setcrtc
In-Reply-To: <20231218124725.1382738-3-sashal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231218124725.1382738-1-sashal@kernel.org>
 <20231218124725.1382738-3-sashal@kernel.org>
Date: Tue, 19 Dec 2023 10:44:02 +0200
Message-ID: <87bkamvay5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 18 Dec 2023, Sasha Levin <sashal@kernel.org> wrote:
> From: Ziqi Zhao <astrajoan@yahoo.com>
>
> [ Upstream commit 3823119b9c2b5f9e9b760336f75bc989b805cde6 ]
>
> The connector_set contains uninitialized values when allocated with
> kmalloc_array. However, in the "out" branch, the logic assumes that any
> element in connector_set would be equal to NULL if failed to
> initialize, which causes the bug reported by Syzbot. The fix is to use
> an extra variable to keep track of how many connectors are initialized
> indeed, and use that variable to decrease any refcounts in the "out"
> branch.
>
> Reported-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> Reported-and-tested-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
> Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Link: https://lore.kernel.org/r/20230721161446.8602-1-astrajoan@yahoo.com
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This commit fixes an uninitialized value, but introduces a new
one. Please backport 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable
use") from v6.7-rc6 to go with it.

Thanks,
Jani.

> ---
>  drivers/gpu/drm/drm_crtc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 5af25ce5bf7c2..5ae3adfbc5e80 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -556,8 +556,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	struct drm_mode_set set;
>  	uint32_t __user *set_connectors_ptr;
>  	struct drm_modeset_acquire_ctx ctx;
> -	int ret;
> -	int i;
> +	int ret, i, num_connectors;
>  
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EINVAL;
> @@ -672,6 +671,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  			goto out;
>  		}
>  
> +		num_connectors = 0;
>  		for (i = 0; i < crtc_req->count_connectors; i++) {
>  			connector_set[i] = NULL;
>  			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
> @@ -692,6 +692,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  					connector->name);
>  
>  			connector_set[i] = connector;
> +			num_connectors++;
>  		}
>  	}
>  
> @@ -700,7 +701,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  	set.y = crtc_req->y;
>  	set.mode = mode;
>  	set.connectors = connector_set;
> -	set.num_connectors = crtc_req->count_connectors;
> +	set.num_connectors = num_connectors;
>  	set.fb = fb;
>  	ret = __drm_mode_set_config_internal(&set, &ctx);
>  
> @@ -709,7 +710,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
>  		drm_framebuffer_put(fb);
>  
>  	if (connector_set) {
> -		for (i = 0; i < crtc_req->count_connectors; i++) {
> +		for (i = 0; i < num_connectors; i++) {
>  			if (connector_set[i])
>  				drm_connector_put(connector_set[i]);
>  		}

-- 
Jani Nikula, Intel

