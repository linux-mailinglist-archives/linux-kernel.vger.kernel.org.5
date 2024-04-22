Return-Path: <linux-kernel+bounces-153520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603668ACF16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BD91C20EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1401509AF;
	Mon, 22 Apr 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0fQQOul"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813D13F45F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795193; cv=none; b=F8sw0iVFoWGfag5ACTqwz6oJ5g72XzgOsU6VrSIh4V62T8JVIBx8s+nsfgr4H7e1TmEbbjaE6PprCPDZI2xaO/IwJ1h0zb0gkpM1GrS0dJAyemB0ks3rcHiJ6xZXfjv4wdcklzi3I9Ef5+B096JNB5KqnsuxShOyAjR42C2Wfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795193; c=relaxed/simple;
	bh=3VH0wPSYjbxLBOo5XQYtJGrCcBkZEO/wQnEkLB2vOfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNMgq9+jT0MsEou00tC/oC49KYwXWLa15hiBE497UC9Kk5ZiOrUCOnpwuD7V2+YxUpXXN6Kvs/8h0Q8IUSHJ1rht7gB3zCEH8lN35Ms89Q6NeAoaaXQ9CUmgsCLzKmEukvdvnHU5B6Xx5dSI2kOcH4eJ6ukGzdzNHV3BwwLmNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0fQQOul; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713795191; x=1745331191;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3VH0wPSYjbxLBOo5XQYtJGrCcBkZEO/wQnEkLB2vOfM=;
  b=Q0fQQOul6eC5pgxhGd4ywkU2obOnR26h8f645DdQTe+cwcZ1vl80TLnT
   lKn4MMKcOx79cKm01qEjYMAWP+Kn2Afqam95ufyqF+BJkvPb8Uj8zLXaI
   1efqpS/1NIoV/ffgqPPP7RfnzUNfB+f2kYnefBMhvnJbwN2aTmvJUq9Of
   fOZWWnmNtpfGSGY2lLcRpMMZjj/okFbctxjINHLzzGtYiDcIhYtboLHIj
   VPNZaMoyqwqnfabUAPjJY/sIT/UaaRAkxJ7y0Ogx98OF33Yo7gIKox6xG
   MwvGnLvD6s8OSgQeXEN4QTk1EwtiPaq970uYDg/s+toWKcq55sGx6p9T9
   w==;
X-CSE-ConnectionGUID: S9uoe7uURzatZ4PDRkVm1w==
X-CSE-MsgGUID: TVfiqroZTGeQ9NZ7DiAd/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="19941199"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="19941199"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:13:09 -0700
X-CSE-ConnectionGUID: DZsqbfzjR8OdPfj3CGCp5w==
X-CSE-MsgGUID: SRZKEL0xRoiveeHtQ3FgsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28810038"
Received: from ralbanes-mobl.ger.corp.intel.com (HELO localhost) ([10.252.63.128])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:13:04 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Michael Olbrich <m.olbrich@pengutronix.de>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: graphics@pengutronix.de
Subject: Re: Reliably selecting non-CEA modes on Intel graphics (and maybe
 others)
In-Reply-To: <ZiZs94-ZP1n98RZu@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ZiZs94-ZP1n98RZu@pengutronix.de>
Date: Mon, 22 Apr 2024 17:13:00 +0300
Message-ID: <8734rdtrir.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 22 Apr 2024, Michael Olbrich <m.olbrich@pengutronix.de> wrote:
> Hi,
>
> In short: I have a HDMI monitor attached to Intel graphics. I'm trying to
> set a non-CEA mode but the driver always maps it to the corresponding CEA
> mode.

Please file a bug as described at [1], and attach dmesg with debugs
enabled, so we can see what's going on and what kernel and hardware
you're using exactly, and so on.

BR,
Jani.



[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


>
> More specifically, the monitor has two 1920x1080@60 modes in the EDID:
> 1. The CEA mode with VIC 16
> 2. A custom DTD mode with exactly the same timings (this is the preferred
>    mode).
>
> From a userspace perspective, the two modes are mostly identical, except
> for the 16:9 aspect ratio flag in the CEA mode and the preferred type in
> the other.
>
> I want to select the second (preferred) mode, but that does not seem
> possible:
> intel_hdmi_compute_avi_infoframe() tries to determine which VIC should be
> added to the avi infoframe and if limited or full range is used.
> It uses various DRM helpers here but in the end drm_match_cea_mode() is
> called. And here lies the problem:
> The mode provided by the userspace has explicitly no aspect ratio. But
> here, it is interpreted as "the aspect ration is undefined". So matching
> ignored the aspect ratio and the CEA mode with VIC 16 is found and limited
> range is used.
>
> The commit that introduces this fuzzy matching
> 357768cc9e3fdacf6551da0ae1483bc87dbcb4e8 ("drm/edid: Fix cea mode aspect
> ratio handling") made sense at the time. The capability
> DRM_CLIENT_CAP_ASPECT_RATIO that exposes aspect ratios to userspace was
> introduced later in the same merge request, from what I can tell
> 7595bda2fb4378ccbb8db1d0e8de56d15ea7f7fa ("drm: Add DRM client cap for
> aspect-ratio").
>
> Am I missing something here, or is it just not possible to select the
> non-CEA mode right now? In my specific example, the selected CEA mode is
> actually supported by the monitor, but as far as I can tell, the CEA mode
> is used even if the monitor does not support it at all.
>
> I've only tested this on Intel, but I assume that other drivers that use
> the same helpers have the same problem.
>
> So how can this be fixed? I've considered matching the aspect ratio based
> on the DRM_CLIENT_CAP_ASPECT_RATIO capability, but I'm not sure if that is
> valid. The documentation is limited and I found nothing that describes what
> the userspace should do here.
> Or would a new capability make sense here? Or something entirely different?
> I'm not sure how I should proceed here. Any help would be appreciated.
>
> Regards,
> Michael

-- 
Jani Nikula, Intel

