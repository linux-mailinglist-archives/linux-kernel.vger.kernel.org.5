Return-Path: <linux-kernel+bounces-84848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71D86AC78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B11C217BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49212D766;
	Wed, 28 Feb 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYifyglH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047912BE86;
	Wed, 28 Feb 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118156; cv=none; b=eb1EVrFjUDX/goQt0CDJ6dwH1enUtAS8whE5KvzNLbPwKaik0/vZGMO3TuttoUlzXwy7bLDS6QIKThmJ/Ck+3HrsH/kO7iXXlXJNJZTTar7hR1hLfuBDwomqjdbSSxpY6F9TqiHCoKHl5zaYERGY5jDioqKbUC3aT9xXmNBbXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118156; c=relaxed/simple;
	bh=6qUCxmFbflDlJlXRfbHoHUwRdpCmzb5lDTHq3HFZwtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pC91yTPPSpyBYFchw3zRt+T39Bk2o1sArYsHHj2m3Ec+RBUTvS1GihAJsQvJQQ4rLbThwNoFjtVPWO4oQLtEXz55jbDcZAzgoaXNuVxtln8haqmPd+lcSO4rHIgiGevUClUmTs1qj4HLr2dU4SMA3GZUCo8berWtPMxOMZMqkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYifyglH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709118155; x=1740654155;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6qUCxmFbflDlJlXRfbHoHUwRdpCmzb5lDTHq3HFZwtU=;
  b=mYifyglH1Olp1V5IhE8SolIWM959Hd/pEteIYOKlNndxugEDrxVhZov1
   hfMGVsfjhGSDxAXvX4YSDYp3TZM2wUM3QnROSxlCUqDYTBQG24+0TYc2n
   qIAOoiNYGJnx5bwbI3LCZtaj+lOVSCw09bPQqAYzkIkuM4TbyGOs18wxO
   2e+IgbuCgf3ZEgBHG45FkNoEfPpBoNWJie+k21h+dOc3cLvL9rU1rcYiA
   nQTIp8iZnNcK3WUSYmMIFzKBTSYBJrsAnyR7SgrdMjvP4kob0Xt8GVony
   eJBQg70HVawZ86JH11WV6N+GSDT9Q0avYKKURDhk4mVeMw6QSOHuHhUaH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25976971"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="25976971"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:02:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7336043"
Received: from tmelzer-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.32.33])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 03:02:29 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/dp: Fix spelling mistake "redect" ->
 "reject"
In-Reply-To: <20240228092042.4125617-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240228092042.4125617-1-colin.i.king@gmail.com>
Date: Wed, 28 Feb 2024 13:02:26 +0200
Message-ID: <87bk80am2l.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 28 Feb 2024, Colin Ian King <colin.i.king@gmail.com> wrote:
> There is a spelling mistake in a drm_dbg_kms message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Pushed to drm-intel-next, thanks for the patch.

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_dp_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> index 75d76f91ecbd..6503abdc2b98 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
> @@ -348,7 +348,7 @@ void intel_dp_tunnel_resume(struct intel_dp *intel_dp,
>  
>  out_err:
>  	drm_dbg_kms(&i915->drm,
> -		    "[DPTUN %s][CONNECTOR:%d:%s][ENCODER:%d:%s] Tunnel can't be resumed, will drop and redect it (err %pe)\n",
> +		    "[DPTUN %s][CONNECTOR:%d:%s][ENCODER:%d:%s] Tunnel can't be resumed, will drop and reject it (err %pe)\n",
>  		    drm_dp_tunnel_name(intel_dp->tunnel),
>  		    connector->base.base.id, connector->base.name,
>  		    encoder->base.base.id, encoder->base.name,

-- 
Jani Nikula, Intel

