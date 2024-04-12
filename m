Return-Path: <linux-kernel+bounces-142100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785088A2787
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176701F22059
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94D487BE;
	Fri, 12 Apr 2024 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="F0NQ07yx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B44085A;
	Fri, 12 Apr 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905117; cv=none; b=nS+vfFAcbZlhe65UakqEH2s9W6NW8clVWGIHhdTPsYqqX9YG21BAp6u4HlAR2jVmSZovfV003olIarTZ3jcOfVMKopuUz7Y1ZM1I8LaSpB9oIkzBMaoqi0JK5VZMMWCSpFQMfuJhLkCRwfLF+3NsyXhaqN+y4HyVU+QdV2WCVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905117; c=relaxed/simple;
	bh=aLPpNHCNWD9rfHxTwQaRkbMXIHU3eQsEjGW4vcaQCsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=e1ThHMZyeleYoLEHn6iFOgMQYEeZg7oK2PPxv8SzRKk9ffq5ZCwkd3H8sMFyb4FBuYKye1xIGbqE5UyNQY770MFpqkpnfOkFqCJxKYQCX3y1mD7R8bxJsiMK2nSEHyO9VQb94V9I9ieP8bCR7iLu7LwhykVJjex+M1NXMpsx0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=F0NQ07yx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712905110;
	bh=qXSRgwoI/Lc9R2Wx9BxMG9QfSE0orexma7cEd5RYRAk=;
	h=Date:From:To:Cc:Subject:From;
	b=F0NQ07yxUDHk8ejDl6Hu4pSWsASLwOESvCqEbqHaeJg2AVACBchMQMMcOt+rrG+Y3
	 vU1i+LfAvwYGr3lypr3AIjxIwlVH1gXXrcXcMQ/Pexf38EHf1mwd5zWUUPGFkopKnq
	 kEqsxmyCCNi+z0SQjOZDaZZX5Yq6/+aggK6L8qm1fEK0PNa42kJTy7JZj5fC9YmZXy
	 XVfDWGTRUFEfITY/xQ3WbmWNHNjKiImNTIa7RQHvbYtuBYwfQRUEcMYDI7qQbplV0S
	 DKRjWGL+EuuqLQDHvH+nva3J+MnXQ7lAPdQtSpiXoHm1wuiJjblJ/OYYetfYtIFduU
	 XAPPceEPGYbAg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG6ps5WJZz4wcq;
	Fri, 12 Apr 2024 16:58:29 +1000 (AEST)
Date: Fri, 12 Apr 2024 16:58:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Intel
 Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20240412165826.18e8a5f4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tY2.spB_SgTGSLvvWZ5aIrw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/tY2.spB_SgTGSLvvWZ5aIrw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/drm_plane.c:1767: warning: expecting prototype for drm_plan=
e_add_size_hint_property(). Prototype was for drm_plane_add_size_hints_prop=
erty() instead

Introduced by commit

  9677547d8362 ("drm: Introduce plane SIZE_HINTS property")

--=20
Cheers,
Stephen Rothwell

--Sig_/tY2.spB_SgTGSLvvWZ5aIrw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYY25IACgkQAVBC80lX
0Gwd9Qf+LqI+LoYIwM7wXCo30NPlBxhqrTCnOoVXI8AG1EDedhQdCRns05uUJVjq
C0h94TCqjEahbCB5t1ea/brXblcFQYj7KCT/+WHNscJ+TW7sXav9pFpkkbGpZGpm
Wvgduf3Fo7MHqTTagqZmUnllaazVPBvrwkEapkD+0k5kBkAIIsDT5g4EdsZB10HN
FMJYCv5FaBjWpWkum44wxL5oOIWg4s9taeFTC4l8HVmCU009+HFlrEM2Aio8iPG6
xsg6FSGSf7PxuAkzrekjsORkWt8pMsYjrYLmXqWrjTGO5Bcm74uBxhxBlCw9lC0K
Gm5fraODpN/mcY5BczkNwyNj4HrPXA==
=H44g
-----END PGP SIGNATURE-----

--Sig_/tY2.spB_SgTGSLvvWZ5aIrw--

