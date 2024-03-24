Return-Path: <linux-kernel+bounces-112865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE6887F34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79DD1C210ED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E291CF87;
	Sun, 24 Mar 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DE/d3Shl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE0DF78;
	Sun, 24 Mar 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316146; cv=none; b=vAI/zU+9dIKeNBc6CR/kD/H+Ni/DpjLVBYqLr/LHG19AqLEvKlMo9LT2SIIu7+auL8iP6qShi71b1QJHaBPVfD2JeAy7IXC25JbvG4U1ygGcvK0zXuyWjxAQfoT5zMeDNvEHnoh+i2dIFAg5eORZlYap4YhdBkiKnVUXHX2EZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316146; c=relaxed/simple;
	bh=8VK5MAL1Y2pBiI1ogdpkEIrQoqmkK6MUPC790OBfci0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C2Kn8rfPNmN1dsa1yJ6oScC3c+S3JYOhNvtatZedFD9wRqImUmYbckEpaGN5oQdSxPZlMT6xoQLSEoFGro0tMyLgarFuPMCya9uvBq28djWQANMrupAJn8Z83D4rWuQwsBYtE6bX4xMaVv9Ov/4NI7BdeRkxRNhWSH52DnrpYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DE/d3Shl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711316132;
	bh=ulW3Cqm8/uV68AdhJwzVhvDjYc3Mc32LlRTTtsYRRrg=;
	h=Date:From:To:Cc:Subject:From;
	b=DE/d3ShlekHMObGGTslu2yeTYgkVALoKey4N2vsNMzy3osc9SwvZXbiVzQ7+P0ymB
	 JnlLdtNotLgzfEeR2vurldW5z+rJAGorQM/YhFi5iavYw2PInujo/rxf07sxbrE9+D
	 LgvRxF3GhZl9YpaabeFY06wJB+0MNfrZaqlvXgsQnTSGXuS4RUfiiW9+smprjzTUlS
	 pM7eu6EEqI0TiY/tweZFKYIL36bPtQ/9nwvzSN7CnIRLMs/tL/N86reU9nDkklh6XR
	 Q33xumIFoee/oVQvhDoK1nHhjr6Zw1ARWLxrf+HXpNYxt718zR7tqBQn84FgaO7aFd
	 +iJ82FKWbsT5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2q9Z6J5fz4wcv;
	Mon, 25 Mar 2024 08:35:30 +1100 (AEDT)
Date: Mon, 25 Mar 2024 08:34:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: fetch warning for the drm-intel tree
Message-ID: <20240325083435.4f970eec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UGcDP=zHKknV.w3ZXcL/qbe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UGcDP=zHKknV.w3ZXcL/qbe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

fetching the drm-intel tree produced this warning:

Commit

  326e30e4624c ("drm/i915: Drop dead code for pvc")

added this unexpected file:

  drivers/gpu/drm/i915/gt/intel_workarounds.c.rej

--=20
Cheers,
Stephen Rothwell

--Sig_/UGcDP=zHKknV.w3ZXcL/qbe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYAnGsACgkQAVBC80lX
0Gxo8AgAmqbGXsK/2qwAmioQ+KoJpnbquSXlo91O7wkT9mnhzfKnXScsS6L/SDen
II6GsCtREg48Wno0CC2Cdh5AOVAcmbeZW5fwIv1c9ESQSsIzaXARn3yllQnK2TNQ
N/8j/N+Y1u1Tuig6W5pF8C5orCb3dgTmpwA2dGhj4BC9pRUYMvjbH67hHSdFZbRj
BkPucMX8DUq/5zNZ6wK7Y5PcAqxzZwfCDzd5O7ze0EPXB7tJ3yoaPX+IgV8elULP
kqoWs3jADnijg6PUUYCblfuC4u1xqf8RKbKKWdd1e5gxfs8p3VZDArD1mlfZrn9i
A9AXoiUiomFeoMpEb/6YclMRtlFIxg==
=DpOw
-----END PGP SIGNATURE-----

--Sig_/UGcDP=zHKknV.w3ZXcL/qbe--

