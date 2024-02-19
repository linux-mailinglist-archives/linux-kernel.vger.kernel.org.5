Return-Path: <linux-kernel+bounces-70732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C7859BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389F21F22255
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9D200BE;
	Mon, 19 Feb 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ajimO8V5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F36C200A5;
	Mon, 19 Feb 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319876; cv=none; b=LsuXOWUu1YC6P8Dbx44kpv+Txo0AkOesk/Sys1acda21Muoe9LQ5vE8BV+mfkKOEPF1nNsr4MWFC8gmph+QCRuGchnt+IuuH7HbIpTCoy+LqUUSpDdz7P+uXUQuq1eUJUQS7cqwvfP2oAQ2AwnOs2sJX3vEdU3LhdjTLwQH52co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319876; c=relaxed/simple;
	bh=MLALHvMYrNAME5JoShokM3tOa4pEwZh56aR8W8tm2WE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uG4lQkWLre9vWouk4zKa9LDi8EXPMctpAuPuXM+gYe9g8NeutzzyGH+I9rlwLHZW2T5LgpDgP+bMAu2bVhWAFctyc9Fm67jYXmUYX1yVGN2dIneiNddTvcKeY7NRhl5bK8xnA/zUg1d5VmZVMHNf83NtOLLbIV8Bi5Dr2bdqUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ajimO8V5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708319871;
	bh=DiLQ78DkSeB+VFr6W48xH7ZI1R4cqbqoXRlZF7XqOGI=;
	h=Date:From:To:Cc:Subject:From;
	b=ajimO8V5mB2EySBWaJuCyS2mWAzEr8NrmgxZqW7bR0YTNtyXSdwBpU/wSYJFRccYF
	 oW/nIupmIfD0FfF4xnyZuNd2dWGcWQ04h4Rjs3KdlAZXMiVj5uUebod+8FsvTp5L0K
	 VJZuh4VvRi5z0GG9Q8EGekJXxsjuCyVREUemxZfSo2I4zNpkqM82czLKdx8/eytkH/
	 vMQnB3TRG2TqhV2iwlC/r8v4vV3oM/wC9T4EquYRJw/6fTEIfx0m3QmStrAJVzNkzT
	 2rHTNWrlUkc0xJBEEonJYtbvGmIpUd18U8t5UuwLq36vz33Kw2HFID4q02M7pmurBv
	 NiAvFbs1ydx0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdW5941t2z4wd0;
	Mon, 19 Feb 2024 16:17:49 +1100 (AEDT)
Date: Mon, 19 Feb 2024 16:17:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Intel
 Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-intel tree
Message-ID: <20240219161747.0e867406@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y.AEXD9XRXmOD3_UAne7Cho";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/y.AEXD9XRXmOD3_UAne7Cho
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/gpu/i915:222: drivers/gpu/drm/i915/display/intel_cdclk.c:69: =
ERROR: Unexpected indentation.

Introduced by commit

  79e2ea2eaaa6 ("drm/i915/cdclk: Document CDCLK update methods")

--=20
Cheers,
Stephen Rothwell

--Sig_/y.AEXD9XRXmOD3_UAne7Cho
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXS5HsACgkQAVBC80lX
0GyrhAf+MQM/FkWhlVWtkovGLvV9ffn3n0kyMg09Nal+PDllXMNFipnuIquyTl5B
j+xkdITwjY8CtQZfKJjcxT8LrVu8A5WiAb4qRniJRQARIq9p9zxVTBghsKiisylZ
0IXHh4APrqWx+fuTEpamYOskLwbQwlD8hAp94jizHuIY571RrSAkfMcLhLvK18lW
5Usl8mUvXesTcoY4q/6xna7RW14Q5CmApw7ptCGH1pVvrlVN6ItDyZcdXl/QrCht
gDPZjXlELGLelxjfbg+pd3akx1TVZ0m+rzUIcindrb69gIXiNTgWJCQ2B57QrK+r
515zTyQjtLTOAwrxdvsXZaIdmZKc6w==
=/y9I
-----END PGP SIGNATURE-----

--Sig_/y.AEXD9XRXmOD3_UAne7Cho--

