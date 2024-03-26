Return-Path: <linux-kernel+bounces-119875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112588CE04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A211F1C66A11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F7313D250;
	Tue, 26 Mar 2024 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5dHHv1Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0013D504
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484041; cv=none; b=BW383NJNaibKxhgkydpdD4+abu7sVINx7xEnbSWktc/O6HTPrGpz2EBRSjb7sTAy4r/LKgjRAWvp2MlnY5jR9Nnde1mhyNULduAMuH16mlH2RXiFOVA1m/Pq7jKb+pqQKHzp+9UeML6h3FOzEgMMhjkr6fZw4sZ1+NSb0zz3RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484041; c=relaxed/simple;
	bh=2ZigpZne1OgZ3Y2jvwTGcmJst0jBDyRxvyWL9zm2dC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qew9FtjKDhUPkBbUPQUunc8gmJtSsnw9wQTUbEilr7pTlqxkpR9s4ovBF599Gv+vw+5XWpVpNYQdzj2oTQ6BhkeD51SwSAiVyyT98DqBcytFQY1MLB0K/72s8Wj6MhN6WKFrirmH1oe43ooSRbEib9qt0BoLsZ7KyXrJ8Hcc1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5dHHv1Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484039; x=1743020039;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2ZigpZne1OgZ3Y2jvwTGcmJst0jBDyRxvyWL9zm2dC4=;
  b=O5dHHv1YuR+d6EVkNcZE70vE+lML979DXBp8mLvgsSk3DoysgO9jHQdu
   mKZrX0o1gH647B/fpeCxsT4py6NJkB+1TSJ21nDzH1s6Xsw/7t29bqiD/
   PBV3yZdEtHcuHt68BOMuZ7gNsKFY1xzwQdpftBIcjeBkpvNIeQNphGmYD
   LXQCuydZilctqwk0jL/0B6KiVjpzkjzwWIY6q4zzzcF8X5DjN665e1CZr
   zU8yrgeika3IwLu+SzUeX6XTc92uhvJjyYHkCOmC8rd72e8ndO5312zfb
   Hs21cOXtvTOgFHg2jRo9ocxX6pIHfRKO0AAMRfKZSSdFoS+TUBW7qXcRw
   Q==;
X-CSE-ConnectionGUID: rK5JHyHNTbi6habI9cxqMg==
X-CSE-MsgGUID: 6fE119c1R3eqQrKdBdneQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6676552"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6676552"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16026031"
Received: from eldobson-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.55.140])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:13:54 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Javier
 Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] drm: DRM_WERROR should depend on DRM
In-Reply-To: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <631a1f4c066181b54617bfe2f38b0bd0ac865b68.1711474200.git.geert+renesas@glider.be>
Date: Tue, 26 Mar 2024 22:13:51 +0200
Message-ID: <87msqkhhts.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 26 Mar 2024, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> There is no point in asking the user about enforcing the DRM compiler
> warning policy when configuring a kernel without DRM support.
>
> Fixes: f89632a9e5fa6c47 ("drm: Add CONFIG_DRM_WERROR")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

D'oh! My bad.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f2bcf5504aa77679..2e1b23ccf30423a9 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -423,7 +423,7 @@ config DRM_PRIVACY_SCREEN
>  
>  config DRM_WERROR
>  	bool "Compile the drm subsystem with warnings as errors"
> -	depends on EXPERT
> +	depends on DRM && EXPERT
>  	default n
>  	help
>  	  A kernel build should not cause any compiler warnings, and this

-- 
Jani Nikula, Intel

