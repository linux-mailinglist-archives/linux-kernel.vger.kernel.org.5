Return-Path: <linux-kernel+bounces-154530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3B8ADD29
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ABC1C21ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF122611;
	Tue, 23 Apr 2024 05:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dS3qlHCB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75C208A0;
	Tue, 23 Apr 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713850400; cv=none; b=XSmBL3ZhjuupGLnkQh0qVD3uhfYKetoSIvX6oDcZzS9EjaOjY9qCQotyNCckT18WklcoiLITS1TTVRY1exnbhLG8JKdh2Nm6ytjxI0PBZ7Dm5VwvxJXQLytGkCK9QyIhWlvzyCie/bcM0ydV1FX8OJBHskHkhcW5h3QM15Bl6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713850400; c=relaxed/simple;
	bh=zEogd6obGKCj1wI8vY87B5g4GlNmcx47Ub4SIxdywdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=brE54IMaplGS2LVTtLYMoZcGd2bL2AfcLl5P4rMd9U2aHB/vIh2jWH7CjTAqnUjCUsPxYjCDNIQHy//UgcGMH7KOlXGT7ifZ8yYO5jzntnYHPYwWyxX03Ov+/rttGJHXg8eCmRSDYbTcno+rN8tA2oEGRwb7wpDaA6AMpJ3ud0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=dS3qlHCB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713850393;
	bh=dP5BWkKu6CZlkYIJk5vA8JCOTxwXlOrwHIcJXys/LEA=;
	h=Date:From:To:Cc:Subject:From;
	b=dS3qlHCBqR8Qs9PvW63vVzpiNYtLlaFL9WxJTcnTwGy6In0QtombBONDb5Grzo8Fw
	 bLtB+wcLpb8Rr4kWLK9xTBQXyNhNNz5jM18oOTw69TH5QD2Qctt9aDpjQ8g9RIQljl
	 VM+Ih+iKgFBPsTHJ/99ccDYt6XIHt7GsRQkqLO8h7K9NDTEI4MOL833aREWkwidVcV
	 RXNM7Xq23LG+LEMZQgP92nx9eADLlT4dTC/N63AMBE4q3TvqWoZv6BodknTtKjkDZk
	 BHq3Byuns/CJ3rd+jz3LW5YV96uyn/BxUWAYUM51u68MBX32AYcu49dbQZ2fq/JwyQ
	 Zw7+oCe8kd8CQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNrPN5sKPz4wb2;
	Tue, 23 Apr 2024 15:33:12 +1000 (AEST)
Date: Tue, 23 Apr 2024 15:33:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael S. Tsirkin" <mst@redhat.com>, Greg KH <greg@kroah.com>, Arnd
 Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the vhost tree
Message-ID: <20240423153312.6fb2dfa5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oHtvu8ZM/pFv+qEdRxAmrI.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oHtvu8ZM/pFv+qEdRxAmrI.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc tree as different
commits (but the same patches):

  6ee63c01e1a2 ("misc/pvpanic: add shutdown event definition")
  718330fcd40b ("misc/pvpanic: use bit macros")

These are commits

  ad76f3e8f57c ("misc/pvpanic: add shutdown event definition")
  043327875298 ("misc/pvpanic: use bit macros")

in the char-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oHtvu8ZM/pFv+qEdRxAmrI.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYnSBgACgkQAVBC80lX
0GzlMwf+OGWcHcy32pkIE0Qbr7wZTMgE5rhS7zkEsruwHPkSM/kxvraJaq8YbexM
1/DvxCxJSYiUceKK6+AockQUxovmpmqM4BA46rsJkC0GeQMYlshkato0qxlKGpod
Pjjosb8VCvZI/eu7+KlcdwrQiY9qF2JGOXaB7/DBkFUMfOifNZFRtQEIzzdsQLRo
xWnQ93BgSRRE+Gxn3WpkUrpBlN5d5p+SrQJreyg1jx9uqKIynikoyR1xJXXLxlub
1GAEk80dENNr+nLhlvjh5CJwJIFzf7lIM7EhqSgErq39kc4J7lkm8eG0aPOhwmqX
RXSRuz0cvv8BevI1bK9LdfYQfnhU3g==
=5Es1
-----END PGP SIGNATURE-----

--Sig_/oHtvu8ZM/pFv+qEdRxAmrI.--

