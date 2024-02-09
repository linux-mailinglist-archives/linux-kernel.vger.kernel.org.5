Return-Path: <linux-kernel+bounces-59505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAC384F821
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFF1C212FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DA6D1CC;
	Fri,  9 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikePjpCI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B782D2E3F9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491222; cv=none; b=DHTwKVdB5d05F4lO+YIpggslhtWpZxlLvO3KJzn2EZHgER6gnoMYiHhS09Jzy2nh9Z3/09YuI0redFSuAWLFx0eRN6aXrLgpbHKwWbNd3/54imKGUmgHojNOuO1KKKkh7P/QBLRy845SEeBmIiNRsYYQMcThgt/ja4siqzBdll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491222; c=relaxed/simple;
	bh=yepMO4u59E++4QW9Rxe1Tub7oqWimXxD0lt0roVEjXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CTDKAYq9eR4vW6OGemC8KEWDgUcdp2U2dMXQgRVK6nJmgWNoFFOei7dFPnsFWC904aT4F9EQGtL3pjHusNnSklDf9aPcJ78jOVg0sDDC34hkehFePkVnqmFO/IrYXDl3qihlIT8YRPlP2PZPEpxP3ONCqVgi6mlZf71kHA5BV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikePjpCI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707491221; x=1739027221;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=yepMO4u59E++4QW9Rxe1Tub7oqWimXxD0lt0roVEjXE=;
  b=ikePjpCILbXKTbIkEwGNuE3zSi6fTG+ioVHPHuFX+Ktqs7LS5X6jQ1Dl
   iy/G+3RCTQhync2DXKAU87QsEhJXWPJdQ7ZNgGDOwRWg1InTk9F0l8l4h
   qMiNcC8pvLM/OfJPbq2qg+y3MYJECG4lj7xODYUk5aUxWWECu1W/mifbX
   p7maRYSvI3+mj9c0D752QhuPmJhC8C6jEf+EpQJjzdHnCGwg7YtVRHOvm
   qB+X9PwtJDPh6U+EGSJtgJao/rm9lHTfdDU/UKrs3vvqrSerTMrCwMq+j
   JkaipY6G2+a6hWc7qe/Bame/nnUay5NcX9TNZQRzFZAiRFXMn7f/kvnQY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1595451"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1595451"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1956543"
Received: from dfischbe-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.64])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:06:56 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Luca Coelho
 <luciano.coelho@intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH] drm/tests: mm: Convert to drm_dbg_printer
In-Reply-To: <20240209140818.106685-1-michal.winiarski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240209140818.106685-1-michal.winiarski@intel.com>
Date: Fri, 09 Feb 2024 17:06:53 +0200
Message-ID: <87o7cpad82.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Feb 2024, Micha=C5=82 Winiarski <michal.winiarski@intel.com> wro=
te:
> Fix one of the tests in drm_mm that was not converted prior to
> drm_debug_printer removal, causing tests build failure.

My bad, thanks for fixing this.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

For one thing, I must not have git grep'd for new drm_debug_printer()
additions since I wrote the patch.

For another, I'm missing some kernel config, because I built the changes
on x86, arm and arm64 before pushing. In particular the arm and arm64
configs I just recently added from drm-rerere repo. Those defconfigs
should probably be updated. They don't have CONFIG_DRM_XE=3Dm either.

BR,
Jani.

>
> Fixes: e154c4fc7bf2d ("drm: remove drm_debug_printer in favor of drm_dbg_=
printer")
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/gpu/drm/tests/drm_mm_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/=
drm_mm_test.c
> index 1eb0c304f9607..3488d930e3a38 100644
> --- a/drivers/gpu/drm/tests/drm_mm_test.c
> +++ b/drivers/gpu/drm/tests/drm_mm_test.c
> @@ -188,7 +188,7 @@ static void drm_test_mm_init(struct kunit *test)
>=20=20
>  static void drm_test_mm_debug(struct kunit *test)
>  {
> -	struct drm_printer p =3D drm_debug_printer(test->name);
> +	struct drm_printer p =3D drm_dbg_printer(NULL, DRM_UT_CORE, test->name);
>  	struct drm_mm mm;
>  	struct drm_mm_node nodes[2];

--=20
Jani Nikula, Intel

