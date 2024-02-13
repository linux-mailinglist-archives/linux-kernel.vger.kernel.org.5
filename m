Return-Path: <linux-kernel+bounces-63301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A6852D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E7228528E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA70250F4;
	Tue, 13 Feb 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUMnIGZT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEE24B24
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818672; cv=none; b=tmXtPgbZc8OLEqldbPCocnMuAOID8LMR/AXuqfhAvipff4HwHxF3mQuAFqCFD3ABgY47CF1sPMvXl2l8iCEIGPENcs75/jNDMsx+p/sFYzitRrz+eZ0HtzINAkwfNwTEYtvTbYYvjYlbiPCNxsomwl8Q3XbTteAdcD+Gtb6k5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818672; c=relaxed/simple;
	bh=J7i4hg0ziGrlmf3vTFEfUk1q2oL5XXsskSRGKTloeXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fg3936LHhlmawcCLPZcYmEXuiH7GCWJrdXxvAnETWPbPAFQuGaAZbGwjuQdwhfE2+2dxUFiqAbd+Jey4oYq198v15e5z55xsp/TH7EDqUmpmn+wqQY1y+8vgOm4JCezKCal/Ov0mhech2bfYNYlD7m7XbuTy5GpQI3h7LvkpW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUMnIGZT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707818671; x=1739354671;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J7i4hg0ziGrlmf3vTFEfUk1q2oL5XXsskSRGKTloeXQ=;
  b=KUMnIGZT9MdwV1OaeB1zmIQ2UTf4HLO4sFBXPs0ovsT9xyHiSaLKBE2L
   t/G99Ddrt5s68TbDI60qZ5hUjVzuabN9BS2HPAJ3NU2cDShq8ZhD6j/1V
   BxTQc/dA+Rp+40ufGKMsVjrIPr+Zcc+1ubTUeQSFpVWpxe6CC9zGlEnj2
   jVVSV7Ax+WPBiAWFgxVubJlJ3oIx0uJsn2fiL+8/ErFBG3m8LJvN5wp7G
   yUWdJpOpbuXY1gJJKC5HTON/xBeDDtw+cC4Os9qCuK5vv7EAgFSsk2fmR
   7T/0HIBy8T075NXcoCEzVTsI1XwtWNjgnF9xo/QQpjyiaWuI5ZwRDw9/O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1940297"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="1940297"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2826055"
Received: from dstacken-mobl1.ger.corp.intel.com (HELO [10.249.254.89]) ([10.249.254.89])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 02:04:27 -0800
Message-ID: <4ebd085d9c2100e0709c9ee7fb9685f58810c937.camel@linux.intel.com>
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
Date: Tue, 13 Feb 2024 11:04:23 +0100
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

Thanks, will push as soon as it passes CI.

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
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
> +{
> +	kfree(rfence);
> +}
> +
> =C2=A0const struct xe_range_fence_ops xe_range_fence_kfree_ops =3D {
> -	.free =3D (void (*)(struct xe_range_fence *rfence)) kfree,
> +	.free =3D xe_range_fence_free,
> =C2=A0};


