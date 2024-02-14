Return-Path: <linux-kernel+bounces-65025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CE8546DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7131F24741
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3D2179B5;
	Wed, 14 Feb 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBnR3UI0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F4168DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905442; cv=none; b=KIxYvuQh3UAJMtQjpWNam9V0GzpTs1nkKZfdEdzuYZXL76DKTL8QIRUiN3scMpe9nEWtursl8JIj4Z6iXA/vbW0D9ESf93OSiT20F3QOjZM+mEZwCahxJbdFOlVZDH4KT0lz09fNFibOcMRGyUHC+zJ/DBCQsa3CWNZRQY5i/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905442; c=relaxed/simple;
	bh=NE5tzEFVtlvXw7ZnuqvaSDoPoYH8LaRLru5KtOL3d4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGN7ImhLhAVEPur8sY6GTiag4WbDNH11CHVlTmwhnq87u0P24SA7Pe8uQHCCwBaUOACSgKFi3Qy+Knxi67HtDtmHKyDi6+9DJBlVtryQtGkMRzXa8hDtojorLWvB75LIKSvX/JWa3XjwUtJHaPVX4uEKCdo313Kx6Pz/C0YqfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBnR3UI0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707905440; x=1739441440;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NE5tzEFVtlvXw7ZnuqvaSDoPoYH8LaRLru5KtOL3d4I=;
  b=oBnR3UI0qxTvlTExHSOOAqJ5pyS+3uDTgJg3m5YlqRZ+dfhBMfRriuez
   YplDf8eG0gTj9hp1XCeOKolj5gTdCnIuMcxF+O1TAuakYftv/8XktmIXO
   DUumybIQ6DvMcOW85prNa2vnkr9wvHYKxgSCFgoFbK0+IgYkSIubepgBN
   NnrSVz2KEhujpM42e01G7o3zCKuCK9560dBxTtxA2NLER9FbJki/7QXkE
   ClIWH5WEXzaev9A0st5WDqn3K7hje/5U4gJB9W+xlr64A3oRTJF3idBP+
   D4fkwUJfpKQpiTnm7WbeyaDDEE6do6tLnqeKqxD9dWQLrm6q+BlNr75o2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2065371"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2065371"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7806813"
Received: from binm223x-mobl2.gar.corp.intel.com (HELO [10.249.254.154]) ([10.249.254.154])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 02:10:35 -0800
Message-ID: <f0b2b4dda91ef1342fc38540bf3d453366b943e9.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: avoid function cast warnings
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>,  Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date: Wed, 14 Feb 2024 11:10:31 +0100
In-Reply-To: <20240213095719.454865-1-arnd@kernel.org>
References: <20240213095719.454865-1-arnd@kernel.org>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2024-02-13 at 10:56 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> clang-16 warns about a cast between incompatible function types:
>=20
> drivers/gpu/drm/xe/xe_range_fence.c:155:10: error: cast from 'void
> (*)(const void *)' to 'void (*)(struct xe_range_fence *)' converts to
> incompatible function type [-Werror,-Wcast-function-type-strict]
> =C2=A0 155 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .free =3D (v=
oid (*)(struct xe_range_fence *rfence))
> kfree,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Avoid this with a trivial helper function that calls kfree() here.
>=20
> Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_range_fence.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_range_fence.c
> b/drivers/gpu/drm/xe/xe_range_fence.c
> index d35d9ec58e86..8510be4466eb 100644
> --- a/drivers/gpu/drm/xe/xe_range_fence.c
> +++ b/drivers/gpu/drm/xe/xe_range_fence.c
> @@ -151,6 +151,11 @@ xe_range_fence_tree_next(struct xe_range_fence
> *rfence, u64 start, u64 last)
> =C2=A0	return xe_range_fence_tree_iter_next(rfence, start, last);
> =C2=A0}
> =C2=A0
> +static void xe_range_fence_free(struct xe_range_fence * rfence)

There's a checkpatch.pl style error above: s/* rfence/*rfence/. I can
fix that up when pushing if it's ok with you.

/Thomas


> +{
> +	kfree(rfence);
> +}
> +
> =C2=A0const struct xe_range_fence_ops xe_range_fence_kfree_ops =3D {
> -	.free =3D (void (*)(struct xe_range_fence *rfence)) kfree,
> +	.free =3D xe_range_fence_free,
> =C2=A0};


