Return-Path: <linux-kernel+bounces-116754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA41C88A360
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DA129737D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35CB179959;
	Mon, 25 Mar 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+2UaVEp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE715921A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359481; cv=none; b=YBUro0sXUKq8bWKwB41AikFyD9LtrBedpJIkNa4/L0T2e6QCjE+ZCI1AAc0NN42uqmDVZdNO0ioRJGkPI4K9J1+7SRGO1khIfFvspqOYb87UwD1o1+BU2EtebC42HJ82aBfFi7YSSe08m9hCkX8XEdwPxa6pezxbPNnu160dxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359481; c=relaxed/simple;
	bh=QaGi9XSCWyWq9VYorwrDRda/uu9IGtHakNHSEgBV6ow=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GnRUfgUKGQfqbdCS3KGXfbpPbQ7z/IpairBAG8A/6OYl/B/Ar7sU8czWtq0tCJQ8XvE/7ZmIVbQ9aNNbv8zgdEWWWqa1qY+yB5AIYhQTWn1UeB2l4BXZpUVm05R+Cu7Xli8wVaQH7Pl1rercdloRE9Jp+SEHO2+aKFPm9v1VLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+2UaVEp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711359479; x=1742895479;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=QaGi9XSCWyWq9VYorwrDRda/uu9IGtHakNHSEgBV6ow=;
  b=M+2UaVEpj+RohrEG1aVQzTilZgJ5Pos4IlztFtM5OfHUsDPNH46plpg+
   HEwMpBYjX2j+sCmLxS2ueqtAuU1cZnKi5JmILW9gpB1nd++BNJnIfaew8
   CizMM9IyfooBDGxZ46iPhQX9zHxRmbG4EnF/MAyHLeezuK4bzMy30M26q
   qqp0DLTvj1nGQHPW3x0YD5jljyDFer3ljbUKNUNxt7jr0ImOKEv8I5uki
   p6i6ZEBdwh7Un8N1s93JYjQaS8QSxx/rjO2/zr9ubeH6i20ALoee4Pbpd
   2zEdvxIWwcNILH/m+FOpnXi43gwJEOB7Q10CYDrNI8dQ45tod5mfWzGrA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="31788172"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="31788172"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15588924"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:37:56 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Emilio Mendoza Reyes <emendoz@g.clemson.edu>, neil.armstrong@linaro.org,
 dianders@chromium.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/panel: Promote warn_dev to WARN for invalid
 calls in drm_panel.c
In-Reply-To: <2388112.ElGaqSPkdT@mephi-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <2388112.ElGaqSPkdT@mephi-laptop>
Date: Mon, 25 Mar 2024 11:37:52 +0200
Message-ID: <87jzlqk5xr.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 23 Mar 2024, Emilio Mendoza Reyes <emendoz@g.clemson.edu> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512

Please use git format-patch and/or send-email to send patches, without
the inline PGP.

>
> From: Emilio Mendoza Reyes <emendoz@clemson.edu>
>
> This patch is the second of a set of two.
>
> In the kernel docs there is a todo:
> Link: https://www.kernel.org/doc/html/v6.8/gpu/todo.html#clean-up-checks-for-already-prepared-enabled-in-panels
>
> The first patch addresses removing the duplicated code. This second
> patch addresses promoting instances of dev_warn to WARN as it is an
> error in other code for these functions to be called in the invalid
> state that triggers the checks.

The commit message for each patch should describe what that patch alone
does, independent of anything else. If you need to describe what the
series does, please use a cover letter.

Please do not refer to "this patch". Just use the imperative mood,
i.e. "Fix stuff" instead of "This patch fixes stuff".

> Signed-off-by: Emilio Mendoza Reyes <emendoz@clemson.edu>
> - ---
>  drivers/gpu/drm/drm_panel.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index cfbe020de54e..0b7602c8b387 100644
> - --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -114,7 +114,9 @@ int drm_panel_prepare(struct drm_panel *panel)
>  		return -EINVAL;
>  
>  	if (panel->prepared) {
> - -		dev_warn(panel->dev, "Skipping prepare of already prepared panel\n");
> +		const char *name = dev_name(panel->dev);
> +
> +		WARN(1, "Unexpected attempt to prepare an already prepared panel by %s\n", name);
>  		return 0;
>  	}
>  
> @@ -162,7 +164,9 @@ int drm_panel_unprepare(struct drm_panel *panel)
>  		return -EINVAL;
>  
>  	if (!panel->prepared) {
> - -		dev_warn(panel->dev, "Skipping unprepare of already unprepared panel\n");
> +		const char *name = dev_name(panel->dev);
> +
> +		WARN(1, "Unexpected attempt to unprepare an already unprepared panel by %s\n", name);

Please use dev_WARN() which will handle the device specific warns for
you, including dev_name().

BR,
Jani.

>  		return 0;
>  	}
>  
> @@ -208,7 +212,9 @@ int drm_panel_enable(struct drm_panel *panel)
>  		return -EINVAL;
>  
>  	if (panel->enabled) {
> - -		dev_warn(panel->dev, "Skipping enable of already enabled panel\n");
> +		const char *name = dev_name(panel->dev);
> +
> +		WARN(1, "Unexpected attempt to enable an already enabled panel by %s\n", name);
>  		return 0;
>  	}
>  
> @@ -246,7 +252,9 @@ int drm_panel_disable(struct drm_panel *panel)
>  		return -EINVAL;
>  
>  	if (!panel->enabled) {
> - -		dev_warn(panel->dev, "Skipping disable of already disabled panel\n");
> +		const char *name = dev_name(panel->dev);
> +
> +		WARN(1, "Unexpected attempt to disable an already disabled panel by %s\n", name);
>  		return 0;
>  	}
>  
> - -- 
> 2.44.0
>
> -----BEGIN PGP SIGNATURE-----
>
> iHUEARYKAB0WIQTcaZbABwnECYA0cZI0LAN3EqikFgUCZf+KPwAKCRA0LAN3Eqik
> FgImAQCqtDgta8+cyU8aAaWN2QTflyiHrNWqB1YmPkVggV1xSwEAx6Ge9YOH7vNL
> hmew94ipW21OuQzIeHtSjLpqJ5Creww=
> =aLEl
> -----END PGP SIGNATURE-----
>
>
>

-- 
Jani Nikula, Intel

