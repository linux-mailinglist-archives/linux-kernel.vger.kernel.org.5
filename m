Return-Path: <linux-kernel+bounces-42132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E399A83FCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF95AB21C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DE10962;
	Mon, 29 Jan 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hz5p9NOd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C78F9E0;
	Mon, 29 Jan 2024 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499389; cv=none; b=j6kd8mCC3lKNysyvqaKpAuW13a5KqaoIUZXulXbhlPpKSfSlJl4CtvbYjbN3NptpOqByk9/Tntk3CDxld8ibaoG/tqtEeUiQuto+L87rmVcTT3Fv3oGWZixbtuVTO9Bba2DnX0+O6TLVFac50cEhVlV+I1NkQSaYQ5TOTLcGBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499389; c=relaxed/simple;
	bh=DTK+Uv/HINzvJpySwWLfjp2M9gYLySqkKhOfo+5AGpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxjC2TL+BVb+2H6AHo2gjM+hrb8lQu5z0fdX5W/98aELxF+N2eeCsmK8rBoZ2oTh3/9QfsvYQjiC2/qWV8RBmt9NeGaq9hO4KMOaWoIai7QBF5SslaIYljXKjWfCZtFoGc8pSdjlxaMZtqQ1HJHUtLNhTpMgeDzkj1/JFy0h4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hz5p9NOd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706499387; x=1738035387;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=DTK+Uv/HINzvJpySwWLfjp2M9gYLySqkKhOfo+5AGpI=;
  b=hz5p9NOdza5VM0skTy65E+sqBFhG6PrO24ISS6TNmo1x0s8hk9Jke+WX
   kXoFbY93c66f0BEFwxVDJaaTkGPaymlQpjuDJnIrCfI6K+XkKxD0uMEO9
   4oaQFV5+ZmrZdc9YIn9rA6ZnwiQYxKNJ0WehC9B5WF+a1i4VBsGQDnwhS
   8L9J8g4YEXAzHuRgqu5kxcV2NcRXDfC9g94ndEqOGF8dQwtvJwz47/g65
   2bmpZuzet5I/JuPnh+xJFEKiv7CioUS9WYOBoatXcQvmx99GnnGW0Moyr
   6reOedTibMG91vIv9EIMjC+vMYXLFLfcn9KmgeE+GBT75izjOoq/zRmq6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9952025"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="asc'?scan'208";a="9952025"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="737252624"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="asc'?scan'208";a="737252624"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.160.45])
  by orsmga003.jf.intel.com with ESMTP; 28 Jan 2024 19:36:23 -0800
Date: Mon, 29 Jan 2024 11:37:12 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Fix uninitialized variable in handle_mmio()
Message-ID: <ZbcdaBVJeKLqaKNR@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <11957c20-b178-4027-9b0a-e32e9591dd7c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fFznBIJrCBlpQLxV"
Content-Disposition: inline
In-Reply-To: <11957c20-b178-4027-9b0a-e32e9591dd7c@moroto.mountain>


--fFznBIJrCBlpQLxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024.01.26 11:41:47 +0300, Dan Carpenter wrote:
> This code prints the wrong variable in the warning message.  It should
> print "i" instead of "info->offset".  On the first iteration "info" is
> uninitialized leading to a crash and on subsequent iterations it prints
> the previous offset instead of the current one.
>=20
> Fixes: e0f74ed4634d ("i915/gvt: Separate the MMIO tracking table from GVT=
-g")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/i915/gvt/handlers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/g=
vt/handlers.c
> index 90f6c1ece57d..efcb00472be2 100644
> --- a/drivers/gpu/drm/i915/gvt/handlers.c
> +++ b/drivers/gpu/drm/i915/gvt/handlers.c
> @@ -2849,8 +2849,7 @@ static int handle_mmio(struct intel_gvt_mmio_table_=
iter *iter, u32 offset,
>  	for (i =3D start; i < end; i +=3D 4) {
>  		p =3D intel_gvt_find_mmio_info(gvt, i);
>  		if (p) {
> -			WARN(1, "dup mmio definition offset %x\n",
> -				info->offset);
> +			WARN(1, "dup mmio definition offset %x\n", i);
> =20
>  			/* We return -EEXIST here to make GVT-g load fail.
>  			 * So duplicated MMIO can be found as soon as
> --=20
> 2.43.0
>

Thanks for the fix.

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>


--fFznBIJrCBlpQLxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCZbcdZAAKCRCxBBozTXgY
J2ggAKCd25TTBDuQLbVH3Z0bjmgfKdx2/ACdGvx9Npm4P2p4XDkYtaiqEkyy4Zk=
=/6Nx
-----END PGP SIGNATURE-----

--fFznBIJrCBlpQLxV--

