Return-Path: <linux-kernel+bounces-47858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C958453C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A850E28F22D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311115B96E;
	Thu,  1 Feb 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivdaHqKn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95D15CD59
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779346; cv=none; b=llzdMc1kyPl5w4m63BzYrTFjIzUMBiFWjUz+jdq8kMz3ru9+mCVscOmWcFq+IR0gQaCbNJ98Yv20FQrn8Bnxb8i5Khbu7hsefCtuEVvVQdI9Ww2hQA5U/K2avwPwx8XKVVmXF2c+efVltHnt/2w9lXVTU/VMS2JK4pDnN9PADkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779346; c=relaxed/simple;
	bh=m/uKLiUM+HFN71t8qYSGfgHAqnpAxXuR7KnjoXsP0JQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qG+QHoEwOvFqUYzNMHViRYZ37K8eqx+HvT36HqXhdHlzCJmtQIRFRs9DIveP04o0pSLCTmr56In2OTV7EnEV+ip+TmVdItjvDEdpNpRl6pgxd5j/LKZA2DL91X46XCpIRVMiEvL3JpvKfd8qD28Xg0OmB/vDcx71h7mwe94Q9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivdaHqKn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706779344; x=1738315344;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=m/uKLiUM+HFN71t8qYSGfgHAqnpAxXuR7KnjoXsP0JQ=;
  b=ivdaHqKnNd3wmav0fYDuwf++fU51Ql9dZKKlPP0B3A2Vfmq/WKFfFTE3
   h4ZMhezwXusnUKqDGHlvIBrCKGLsTlMB5iHqR3qswyl78ODdOz1X+MMIZ
   wgBX/KYBBTZ/jrrxjoaxgxB3SEJZ3ubQatx6leCQsTAeqZPHWDLmskALC
   hH24kQLd+AUzTj8fxxfw8mca/c0BIPgNScqHEurQbMGRlWIHbesGJRTS0
   j2Tdjn771VJwUQKyCeZPUXDjNafUQmsX9jOwWXtddxZ31k1xeHveoE42i
   CNxUd9M5JG/01ELVbwA2Gy0hYHFmfM0ZhzkPLafAH8kZpdBmzdlT2fSl0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22352779"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22352779"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="24198"
Received: from aragners-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.111])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:22:20 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Paz Zcharya <pazz@chromium.org>, Jouni =?utf-8?Q?H=C3=B6gander?=
 <jouni.hogander@intel.com>, Luca Coelho <luciano.coelho@intel.com>
Cc: Subrata Banik <subratabanik@google.com>, Manasi Navare
 <navaremanasi@chromium.org>, Drew Davenport <ddavenport@chromium.org>,
 Sean Paul <seanpaul@chromium.org>, Marcin Wojtas <mwojtas@chromium.org>,
 khaled.almahallawy@intel.com, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Paz Zcharya
 <pazz@chromium.org>
Subject: Re: [PATCH] drm/i915/display: Include debugfs.h in
 intel_display_debugfs_params.c
In-Reply-To: <20240131204658.795278-1-pazz@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240131204658.795278-1-pazz@chromium.org>
Date: Thu, 01 Feb 2024 11:22:16 +0200
Message-ID: <87o7d0h73r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024, Paz Zcharya <pazz@chromium.org> wrote:
> Commit 8015bee0bfec ("drm/i915/display: Add framework to add parameters
> specific to display") added the file intel_display_debugfs_params.c,
> which calls the functions "debugfs_create_{bool, ulong, str}" -- all of
> which are defined in <linux/debugfs.h>. The missing inclusion of this
> header file is breaking the ChromeOS build -- add an explicit include
> to fix that.
>

Thanks for the patch, apparently in our configs some paths lead to
debugfs.h. Just goes on to show how interdependent the kernel headers
are.

Out of curiousity, what value do you have for CONFIG_DEBUG_FS kconfig?

Fixes: 8015bee0bfec ("drm/i915/display: Add framework to add parameters spe=
cific to display")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>

BR,
Jani.


> Signed-off-by: Paz Zcharya <pazz@chromium.org>
> ---
>  drivers/gpu/drm/i915/display/intel_display_debugfs_params.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c =
b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> index b7e68eb62452..f35718748555 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
> @@ -3,6 +3,7 @@
>   * Copyright =C2=A9 2023 Intel Corporation
>   */
>=20=20
> +#include <linux/debugfs.h>
>  #include <linux/kernel.h>
>=20=20
>  #include <drm/drm_drv.h>

--=20
Jani Nikula, Intel

