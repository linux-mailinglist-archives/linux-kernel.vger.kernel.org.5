Return-Path: <linux-kernel+bounces-33790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794B836E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2301C28715
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841FB50275;
	Mon, 22 Jan 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsFeWbUb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA350272;
	Mon, 22 Jan 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944089; cv=none; b=ap1EZ3EBf6IQR7Gn8tXlfBqMbPnUgjxLXt8eDpQr9XzosMr/LNGdAFtCc0dlaAmtmHPE3rweA0IYOaFHIL2cN8nJCDPidubhKzrHUDoaE2Z2Bg+V3vcLM+mHcxGSXiliVHj1Cq2SLQByBBz1R8IihUyZbvUykk+PIB45tCKPx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944089; c=relaxed/simple;
	bh=kWQHfwN1yi0ttF4juKCo2E5MXvh0hWGgjbREXz8PJQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TxgTSzhuLQ8ctf80W4stJKwFKf8WY+OWOanK1zctt5Lnppewm23L2dDan/PW5mYASNOKq5PdZYU70DHxL7h6famGlS4Yw/saFtCaruecqVPtCL8N2NbL85aN5lHTyCMgSCnbxAHdrtPV6fv6wUgg3Yo6KFOVA+Mb+1dWEsnGK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsFeWbUb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705944088; x=1737480088;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kWQHfwN1yi0ttF4juKCo2E5MXvh0hWGgjbREXz8PJQ8=;
  b=RsFeWbUbhNB3At/N0BbsiOWjU6K+2pd0UHKJb/64yWe9qdCm2lkdDbcy
   ex0ZsBwUetpSl6CNzIznNmjRI1Y03FdDT+P6BhrA83ulHZaw1dsGue/u/
   Cn4Zof/T9QR1enh+Hnnn46VCe5ofGetfNLOIMPaJM+Q70ET39sVQzsO6C
   A1jtHNpVe1AqMZB4GoNFuaGoVTrpllNRx+UpMxvZzoyHGi1ce4j1rg0IC
   gqbfsU/HDnle1gh+63fnWl+VGhNdZ8nqJM3JOlXvTHvrYtctZLC5Tzk6o
   dWICnaeWtBHb/UBBK5093pcTj0JEPOLqhmZtQp4iwMWJ7DeXQHI9oPHzb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22750046"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22750046"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:21:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="27723905"
Received: from mshelego-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.40.242])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 09:21:22 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Linux Intel Graphics
 <intel-gfx@lists.freedesktop.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Lyude
 Paul <lyude@redhat.com>, Imre Deak <imre.deak@intel.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Maxime Ripard <mripard@kernel.org>, Ville
 =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm/dp_mst: Separate @failing_port list in
 drm_dp_mst_atomic_check_mgr() comment
In-Reply-To: <20231114081033.27343-1-bagasdotme@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231114081033.27343-1-bagasdotme@gmail.com>
Date: Mon, 22 Jan 2024 19:21:19 +0200
Message-ID: <87r0i9nv1s.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 14 Nov 2023, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> Stephen Rothwell reported htmldocs warnings when merging drm-intel
> tree:
>
> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5484: ERROR: Unexpected indentation.
> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5488: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Separate @failing_port return value list by surrounding it with a
> blank line to fix above warnings.
>
> Fixes: 1cd0a5ea427931 ("drm/dp_mst: Factor out a helper to check the atomic state of a topology manager")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20231114141715.6f435118@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks, pushed to drm-misc-fixes.

BR,
Jani.

> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 0854fe428f173a..b9a98587fbef7f 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -5479,6 +5479,7 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
>   *   - 0 if the new state is valid
>   *   - %-ENOSPC, if the new state is invalid, because of BW limitation
>   *         @failing_port is set to:
> + *
>   *         - The non-root port where a BW limit check failed
>   *           with all the ports downstream of @failing_port passing
>   *           the BW limit check.
> @@ -5487,6 +5488,7 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
>   *         - %NULL if the BW limit check failed at the root port
>   *           with all the ports downstream of the root port passing
>   *           the BW limit check.
> + *
>   *   - %-EINVAL, if the new state is invalid, because the root port has
>   *     too many payloads.
>   */
>
> base-commit: 59be90248b422f2924872de0be2867652214096a

-- 
Jani Nikula, Intel

