Return-Path: <linux-kernel+bounces-161693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FE8B4FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F9A280E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B238F5D;
	Mon, 29 Apr 2024 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OFvPKKzx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABF8479;
	Mon, 29 Apr 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714360375; cv=none; b=sXhcXeL2vEOz3xEY8+PF+o/YreLCY8uK1dQX/STp6cZFWrc5lH/S+c/8Fc3xgD/c9Y2EnTdEHsI+7ZrdDcKLfBOQOZU8V59J3FX7B8+AB/ggFABQ/E5DUmzWHgtPSNgJTZ/jrUP9ZeLk1MSJPLmGwK+T9HWtWhH1hzMuKz4zyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714360375; c=relaxed/simple;
	bh=dHhlMceTSxg5KPIsE2YuvweDSt8KUh06RZaKKN1O6No=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ULwvLmFT3T1aJET8CxMXP8q1Wkbiwp04/dLKgZsaXLWHTqWg6JkZPmdK/JW1fE57pBoC6Ofahdwp2qnSMAJgM/tcU8btT4IzJj2cCaWl1fauJ125f92b0naDLVn7t88bLxcAYomBg+Vug/DgMk5vLcQjgiNi9tMy5ndrjjOelts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=OFvPKKzx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714360368;
	bh=2FzFPUX3bLG3faCR0xhttaBk0b99Aw0RFjXJ8hQd4cE=;
	h=Date:From:To:Cc:Subject:From;
	b=OFvPKKzx+stCGjTBRA6T6BVN2JBAFtMIHeJ2LrLdz24W3pcCvyT+NhtlM2+fp2ovp
	 R/n8rCWQjTO+AZMIo+xgVyvs6YoH4/SEc/sIV2jQwvEQt30XEMvxfJahRUHAGKw2GM
	 tOXnaR2DVaeQuayNfDIfGnK14X0KbsMZxDCkdoKEhQhlCHJiQ6jpTWndc2E8GrhWp+
	 D0YFgPlc6T2EFgYopHh4mUiKTYCpwl3T7Er+1417aD/aPUJaU3rWgSQavcXBVz96zJ
	 nfpCl8V+vSpA2ohTfNfmEdoADJ8ePER4zeqeXrAUJ86Gq+ru/zMn33buuCyT4TXGwW
	 lUuvDcyrVpkEg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VST0b4VLWz4wyp;
	Mon, 29 Apr 2024 13:12:47 +1000 (AEST)
Date: Mon, 29 Apr 2024 13:12:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, DRM XE List
 <intel-xe@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-xe tree with the drm tree
Message-ID: <20240429131245.5d4fcc37@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O.2GsTH7sUrY0rG9nG7feeQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/O.2GsTH7sUrY0rG9nG7feeQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-xe tree got a conflict in:

  drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h

between commit:

  cb4046d289bd ("drm/i915: Drop dead code for xehpsdv")

from the drm tree and commit:

  6a2a90cba12b ("drm/xe/display: Fix ADL-N detection")

from the drm-xe tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
index ffaa4d2f1eed,9ee694bf331f..000000000000
--- a/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
+++ b/drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h
@@@ -78,8 -84,11 +78,9 @@@ static inline struct drm_i915_private *
  #define IS_ROCKETLAKE(dev_priv)	IS_PLATFORM(dev_priv, XE_ROCKETLAKE)
  #define IS_DG1(dev_priv)        IS_PLATFORM(dev_priv, XE_DG1)
  #define IS_ALDERLAKE_S(dev_priv) IS_PLATFORM(dev_priv, XE_ALDERLAKE_S)
- #define IS_ALDERLAKE_P(dev_priv) IS_PLATFORM(dev_priv, XE_ALDERLAKE_P)
+ #define IS_ALDERLAKE_P(dev_priv) (IS_PLATFORM(dev_priv, XE_ALDERLAKE_P) |=
| \
+ 				  IS_PLATFORM(dev_priv, XE_ALDERLAKE_N))
 -#define IS_XEHPSDV(dev_priv) (dev_priv && 0)
  #define IS_DG2(dev_priv)	IS_PLATFORM(dev_priv, XE_DG2)
 -#define IS_PONTEVECCHIO(dev_priv) IS_PLATFORM(dev_priv, XE_PVC)
  #define IS_METEORLAKE(dev_priv) IS_PLATFORM(dev_priv, XE_METEORLAKE)
  #define IS_LUNARLAKE(dev_priv) IS_PLATFORM(dev_priv, XE_LUNARLAKE)
  #define IS_BATTLEMAGE(dev_priv)  IS_PLATFORM(dev_priv, XE_BATTLEMAGE)

--Sig_/O.2GsTH7sUrY0rG9nG7feeQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYvEC0ACgkQAVBC80lX
0GxeEwf+JyDY0T+hn6eCyOuA9aEMlFHOEU4DvYaWY8f0W/5gqxkXzIHajzcPIFJ7
U66qycz4Jubk+RmfA4MEwHzAZjE2p51RKiE/UuastXFQppA6rAwvyCOZkStTl79N
PdU0/lTq/N4OKdLyVm7W09FdN7y6PZxX/gH1ykqAWaJLEoUBsNPu9Hh4jOTVdGmO
dVcZcS8/xwgbXBdYQzuVb776ty0tNnRVSTDJyTbMlh5ioEynjbHbMjYGtSSA6fYM
JYGH7NZzpc1t+UG1kWrhdSfiWIb04GfWU03vw0t1U9F+Eo6Cf70cbZMiYbdUaSbU
LD0KSF1hvIBhpTRS+PJh0GziFSC9ug==
=SlGa
-----END PGP SIGNATURE-----

--Sig_/O.2GsTH7sUrY0rG9nG7feeQ--

