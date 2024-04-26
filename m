Return-Path: <linux-kernel+bounces-159529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6F8B2FCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCD31F23097
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48313A3EF;
	Fri, 26 Apr 2024 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="azpGOmXB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B56EBE;
	Fri, 26 Apr 2024 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110262; cv=none; b=t0kCPCW75ntuQKSmSP36FK99xLmoCQiK6guDUxRk32xUfZNciLXVSjdLRIet/jeIV8s0YIGE1en58brPDaOy9/EzdHUg20r1jQGsWPx6HGAUccLE3+saDd/MToutz8gX7MfI/ySEv2geu73l+xY371mJGHHhZt0Ng8nyzxziQWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110262; c=relaxed/simple;
	bh=Abu0/ojaMbUg2FpjsiGOh/uxA7kwE1EgtWjI7zxmMPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TrFi5fCZLbE+HHzZzgR6WO0CNwpmAV+8rrVmuvSGD9jmAa6qNJCA6nQh1au06HUCBj83vvfJsULN7GHEfvmCf4MPvjubtvzKXgQSE2uobeJ/UA8f1F2eS+oE4PYdnKrq2oNuUG4KrewONRJ0TXpXB+FKhlRd9+Nj23jfbnCx58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=azpGOmXB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714110257;
	bh=8EyYvnGVPYCJgqZf7ZjWYjkxUL6ZHttAg4LijMUXOP8=;
	h=Date:From:To:Cc:Subject:From;
	b=azpGOmXB9e/Ls6wSdtuT9xuKIzID1+rn4LSFAlDGTCPM/bbt/SJCKp/V6fei/nSw2
	 ka7Lzg13UwILeNFMgv3YkTnrcfn/dl9bNrEUgioELvn7U5mwtAoe8rVh2hiAi3u+Gm
	 A5hurOcVG6CIzT4X8uVzlOCqvZLNGERFA9UXdVJQ+dXVqs1v1sml3aFJ3NASj0ZxNc
	 pTFVm3GS67rusRcb+xaYeyYl/i6t2oLWgkuwJA+1qWLR5pnSA3yJn2warXKLvi6pwN
	 nefqVplaTM4e/3qf2Sg9PpHMLUH1VWi5c0LNLdM3VrdO/XWKPEaGmrfTm2sApTYxk5
	 zo6kqADv01kQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQhVl6Lzhz4wc8;
	Fri, 26 Apr 2024 15:44:15 +1000 (AEST)
Date: Fri, 26 Apr 2024 15:44:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the kselftest tree with the mm tree
Message-ID: <20240426154414.4d408fd7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EeBtq7l6S8Ch/R=C0dvmmOZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EeBtq7l6S8Ch/R=C0dvmmOZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/mm/soft-dirty.c

between commit:

  258ff696db6b ("selftests/mm: soft-dirty should fail if a testcase fails")

from the mm-unstable branch of the mm tree and commit:

  e6162a96c81d ("selftests/mm: ksft_exit functions do not return")

from the kselftest tree.

I fixed it up (I used the former) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/EeBtq7l6S8Ch/R=C0dvmmOZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrPy8ACgkQAVBC80lX
0Gy0bwf9EucG/9U4DSZMmQW7x5M5Wn2xYpQgAfbL7EOgzUBA5WRcD7A0QBt5EWG7
mrdltB9SVoKc36dTk1TmYWvQ1j01V3UR1adfLOH2k5OQoD1RTqQiyEMAKuOBMQon
bSQJlKdIeRwxz5FG8in6Fpgcj8TwRRV5vQb0bZdaSvChjMs6kCLtXdomtEZ9pl/l
oGHEbgNzFf2hYrX4WCg/uozF3MqpDgIkGb/SYHbI1qhPl9/CYMCysmaL0sRzhFC9
h0roVGBvz2ztN85NByUF9+6dG5og6kV5ea4evxF7aojSh9YY6QA6LH5QA6nKneoZ
t1NFj6uljMgUgY/d5PKvB9fxldK2uQ==
=oMTJ
-----END PGP SIGNATURE-----

--Sig_/EeBtq7l6S8Ch/R=C0dvmmOZ--

