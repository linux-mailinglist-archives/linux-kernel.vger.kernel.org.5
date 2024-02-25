Return-Path: <linux-kernel+bounces-80303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82368862D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC65B20DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA621B950;
	Sun, 25 Feb 2024 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hkntkPn5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59BD299;
	Sun, 25 Feb 2024 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895923; cv=none; b=MYSPg8Erl6s+VqM3QpyJ7a9Tu63WNj6+RervFef2YcmqpAq8PDQ5NC/aKQkDAYOXFMGEx91Rbm0rm+brrLHLgijMri4S1/BgqVumb25c+bGKDKPiyhz9UPdkBKBuVMxkJNiv9tSm28O7lNjSgtEknA7yJ3sgctom0vHKHI//tsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895923; c=relaxed/simple;
	bh=KlqWvT0xNpANMAv5s+GpglNFYoG6SHiWsYY3r/aF8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pvxj2cjou88hHAo9bS+XhOpFAweR2DCVUeUmsLHxSJXSNyMRg017zx9l29oGUvKUEVU5j/2E42qAsTJ8/FF2+zj6PqolbF4SIJmcVPW9v+01xD/MaGV4WMHOrbpdBE4eQjFdFgHkWswz8Fr2hZdT6NZ+hJK/gSc5IT5Icy/5S+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=hkntkPn5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708895917;
	bh=YIVU+Y8WDR0DNBeMHgQ4G4j6nZGmy7xzVkqAnM2ocII=;
	h=Date:From:To:Cc:Subject:From;
	b=hkntkPn5WMBIZOPEIGS/7ueG5tLb+FcdhgM2YR7pdb2z/0BEDByK62ATGqu9K0188
	 GVvfqUwCPq6ZT2MVAZd+vHG4ePXMN9SSadfWasFeCg2f+vUlbJc7Nr6Z4mmC696nW3
	 JOv0RzqYFZn1UzOnza+UHrEBbeT9ne0DwcF+dtXUFWjDwlfCzuM3Qqrnu6kPMcWZwC
	 kkRZ2DknYB9hI5bx/0gAshUZkFyMEBVh1tk0N23XhbSJmCtTjSQz2X0ypoqX3H3QIf
	 F1BNePMd2J4Kw9shBpaHNPLpEjpbJhjusQQFz69xqyjIhTVHdbA8jSl6EynOEEVjPF
	 NO/38nv+AOqEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjc714K6cz4wbQ;
	Mon, 26 Feb 2024 08:18:37 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:18:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20240226081836.0a9f8bcd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R81WpB0ba.88cAjd/gmB=d4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R81WpB0ba.88cAjd/gmB=d4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  67a2a6472632 ("x86/mm: further clarify switch_mm_irqs_off() documentation=
")

from the mm-unstable branch of the mm tree, Fixes tag

  Fixes: accf6b23d1e5 ("x86/mm: clarify "prev" usage in switch_mm_irqs_off(=
)")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 3cfd6625a6cf ("x86/mm: clarify "prev" usage in switch_mm_irqs_off()")

(from the mm-stable branch of the mm tree)

--=20
Cheers,
Stephen Rothwell

--Sig_/R81WpB0ba.88cAjd/gmB=d4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbrqwACgkQAVBC80lX
0GzvLAf+KOiBE/M6Vp0R7VPJ8/YdXHb7+E6KLZixuk41ym47tweeycgRyayt9pIh
epVsEC6SJI5Q9PIHFPnmBtlvvewBJ5BnSwdZSnDGB+N6nuIdB6AVkBVTVWUDlVJU
u26efEQIbvAuXcpCCNIDJ20roCHeBCNJ3WXAj9Z2qAeTthwqP3aAMu3KrLwsWMrf
DdU5u1v8QYHNEW7wvQAzPtyDtuz7cdT+QNqsNHgOUlpccXWDzubt0k4fUve/LyVN
J+6yYPBJUgOrQBD+FA6MPc9p0lzzMzkxMxJSXrEDC26zLVAZVESJed7zJU9Z2aL0
EVYd53Kxwl3+bDYWv/7DIJK5UfLROQ==
=3LCI
-----END PGP SIGNATURE-----

--Sig_/R81WpB0ba.88cAjd/gmB=d4--

