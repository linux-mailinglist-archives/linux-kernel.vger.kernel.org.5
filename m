Return-Path: <linux-kernel+bounces-54151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FF84AB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA071F251AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA47139D;
	Tue,  6 Feb 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p3Xvi+hM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F242C1109;
	Tue,  6 Feb 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182911; cv=none; b=irpQVRRkL4H0YR5EHIuu0EbX27rs4nOJJVYeukTN3n/OSDPB28gGQW2o4Eu6ShbWKI4Z4PxYtJxV+MZNIqd6fL4AwLLXRmw9Me/80GD0mjDvQ9aGos4mlxjBJvPwY6sMnIza3tcLOxvDksMwW0NA0qjUARsu/W/YphE9KKH4+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182911; c=relaxed/simple;
	bh=FK0LAAXd0iQ5ZyxzXGxUaI+ge6k/xBudQVnCEI9DX5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ht1lzo7JDumPg0EUWtQ0c05G1yZAUZpn1PPpVY+6MF7n3YD7kV9V+XJZtCnZmT9DkaGovjWtTuNETY1axabaOnrAGquuBhSpFLLej6Mt5lHg99tW1Tc1BLUQiudEyxkq0pcZ3eluGFL/LDwvR/nNob5/DqijSHDrvQaIgRomWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=p3Xvi+hM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707182905;
	bh=zKY0CiN5eVCwjR4J5nAX4GlXw1p1JS0IYgVBmlyJXhU=;
	h=Date:From:To:Cc:Subject:From;
	b=p3Xvi+hMgs/tLQ65WhXY7emQZorkU4vGyAiUEQbvWBp1E981nzdmSgyKCCXXuf7Na
	 blaobyUTeSuF1zEg0PR5GrBjvuOgKjy+D+XB/AiawYhwC1Z6Z4DdVUJZezpvl/6OkZ
	 +xplFY/nIQV5Bfu0dUqTUlnEHdEAKoDBrpBC9lUCkRNrbZjuqDlDCrpfXj2Ir4BOLA
	 CkrTYUobEbgY0e7DYRsUUkc2xxG7MgDjbIP95NJsY8diIbX7AyAxgj5mMu86Ml/lv4
	 BWk5g1OMgbHjtRIuOAmzM14lqUw1KD6LP9KbDI8AT5ev+rJN9Fn+SxH5mk5RpQLEnw
	 fBfhei6CorH1w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTQcR1p92z4wcJ;
	Tue,  6 Feb 2024 12:28:23 +1100 (AEDT)
Date: Tue, 6 Feb 2024 12:28:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Somalapuram Amaranath
 <Amaranath.Somalapuram@amd.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240206122822.12a2df89@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qoofQSLe6__zbq+lF9FrpkO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qoofQSLe6__zbq+lF9FrpkO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:


Caused by commit

  a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")

interacting with commit

  dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

(and maybe others) from Linus' tree (v6.8-rc1).

I have applied the following merge fix patch for today.  This makes it buil=
d,
but more is likely needed ...

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 6 Feb 2024 12:21:07 +1100
Subject: [PATCH] fix up for "drm/ttm: replace busy placement with flags v6"

interacting with commit

  dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/xe/xe_bo.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 0b0e262e2166..280dbda8ae5a 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -38,8 +38,6 @@ static const struct ttm_place sys_placement_flags =3D {
 static struct ttm_placement sys_placement =3D {
 	.num_placement =3D 1,
 	.placement =3D &sys_placement_flags,
-	.num_busy_placement =3D 1,
-	.busy_placement =3D &sys_placement_flags,
 };
=20
 static const struct ttm_place tt_placement_flags =3D {
@@ -52,8 +50,6 @@ static const struct ttm_place tt_placement_flags =3D {
 static struct ttm_placement tt_placement =3D {
 	.num_placement =3D 1,
 	.placement =3D &tt_placement_flags,
-	.num_busy_placement =3D 1,
-	.busy_placement =3D &sys_placement_flags,
 };
=20
 bool mem_type_is_vram(u32 mem_type)
@@ -230,8 +226,6 @@ static int __xe_bo_placement_for_flags(struct xe_device=
 *xe, struct xe_bo *bo,
 	bo->placement =3D (struct ttm_placement) {
 		.num_placement =3D c,
 		.placement =3D bo->placements,
-		.num_busy_placement =3D c,
-		.busy_placement =3D bo->placements,
 	};
=20
 	return 0;
@@ -251,7 +245,6 @@ static void xe_evict_flags(struct ttm_buffer_object *tb=
o,
 		/* Don't handle scatter gather BOs */
 		if (tbo->type =3D=3D ttm_bo_type_sg) {
 			placement->num_placement =3D 0;
-			placement->num_busy_placement =3D 0;
 			return;
 		}
=20
@@ -1353,8 +1346,6 @@ static int __xe_bo_fixed_placement(struct xe_device *=
xe,
 	bo->placement =3D (struct ttm_placement) {
 		.num_placement =3D 1,
 		.placement =3D place,
-		.num_busy_placement =3D 1,
-		.busy_placement =3D place,
 	};
=20
 	return 0;
@@ -2112,9 +2103,7 @@ int xe_bo_migrate(struct xe_bo *bo, u32 mem_type)
=20
 	xe_place_from_ttm_type(mem_type, &requested);
 	placement.num_placement =3D 1;
-	placement.num_busy_placement =3D 1;
 	placement.placement =3D &requested;
-	placement.busy_placement =3D &requested;
=20
 	/*
 	 * Stolen needs to be handled like below VRAM handling if we ever need
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/qoofQSLe6__zbq+lF9FrpkO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBizYACgkQAVBC80lX
0GyAJgf9Hild1zSurCMflzSa/SDNJVx/KSmIxojPE0TyUGi7s03D5gM99mKXR30J
yRSZ1KM8B41FEGlmQRMoNHBnkUk8tYz7aajNjxnhIXXcIxU8xiGqgsjQ+bJ2kimg
+xkn/SB7HMKW761o4k3ETBJKDUmOw9lUEGW4KCpmzM446mxF8Lc2RoqHWWSzggfS
9nVAH9NcStDpFWT6vCYY19fmd1g8S+LSAYE0Z5wFu088tJd+8liM/8l/+NBihDRV
n0cR9Gec6OmN2YTozZrqRnVgRi/Cd90NzTdA9c2VHb2x4dK3/GlA3qZfnl1DEXjF
1Rg3OYiVjN3JObhHkODbJgQNsLJZDQ==
=xKqJ
-----END PGP SIGNATURE-----

--Sig_/qoofQSLe6__zbq+lF9FrpkO--

