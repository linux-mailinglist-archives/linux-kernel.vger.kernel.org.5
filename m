Return-Path: <linux-kernel+bounces-142007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538E8A260A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EE01C21280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF71CD00;
	Fri, 12 Apr 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IGAPl25N"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720B168DE;
	Fri, 12 Apr 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901352; cv=none; b=FuXRB8JKfY/HJpaoBIr0g3U3F/eJJohb6jAyl7bTpQGjIpgpxdeO0DpZt92SmXjEo9WNzFAiO4FS+c+zJ2A/UEA/cyKm4yZ+0p1n0agmAG3IPKC1VcAl0wjh4Rnfk7F5THBPFjsnIhx2NKJwBsxrD9VrgLmPRHYOnojmDLV6/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901352; c=relaxed/simple;
	bh=4Djlf1oRlTR02Bx7PA2kazYcrd2LVrRQ+JBpAn9dsII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TOLQJmCEZG+EoAJOt/UeBtP1armKHEMIK1PalQaI4rLW1zst2FtTlMsOaWsaK6ZMNJJiOXaASl7JHFx9ApkEJfCCHFuAm/oXlgNYQPHD1TtavzR044SkQ7nMskwrVNfrKrb80/zg/y/5zTzraT8FSHPIUwz6TIarkQW+lyz4TaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IGAPl25N; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712901347;
	bh=l1nXej2xIOp5iLyN1wuFB5bgBTopoVfUsY7BuLnhp3I=;
	h=Date:From:To:Cc:Subject:From;
	b=IGAPl25NKe92LhURgO6occqYjTBW1uSuVgxWp4Slp7Ga91WlWsmthai1GqjBqanqh
	 7YOSiHljZF1EvNigtyP8GzSdw4gd293OyUezSu69fOT3uJtcn9wNtxUL3tgO4SjndM
	 4ixTOkBmtlIaP7FvF/VHYppaNrw2U0sFSqk30JJ5H7VpBGk1CjkhUotkMX3GIaPty0
	 ZHoeVKtHnAEa2ml1ZLDP3WeePDTNzsAq9/pUS00GKNsnXWNMJM43AH8ZEGRkrSq6pL
	 5AA79ZsPYKoOhiyQOB8gNLmAXaaKSUWTWVdGkhxFMSnZ61gHSrnviLo+NMoV44m+xv
	 YnpnLn+rzq4eQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG5QV3pMQz4wd7;
	Fri, 12 Apr 2024 15:55:46 +1000 (AEST)
Date: Fri, 12 Apr 2024 15:55:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the kselftest tree with the tip tree
Message-ID: <20240412155545.7b8ad20b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O51+wFtQh==g8tFwDdgrZ1/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/O51+wFtQh==g8tFwDdgrZ1/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/timers/valid-adjtimex.c

between commit:

  076361362122 ("selftests: timers: Fix valid-adjtimex signed left-shift un=
defined behavior")

from the tip tree and commit:

  8e222dcf92a8 ("selftests: timers: Fix valid-adjtimex signed left-shift un=
defined behavior")

from the kselftest tree.

Slightly different versions of the same patch (whitespace differences).

I fixed it up (I (arbitrarily) used the former version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/O51+wFtQh==g8tFwDdgrZ1/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYzOEACgkQAVBC80lX
0GxGJwf/RzCNeJhTlwetyQGgWpU7cSjVplAae34XRwZ8IQ/bP1ZLrKuvFINbK95e
ZousWFtyI6eiNasFmiEsQyHpVDV3mApcYAopfh2vdrj/44N18nJYypCTHOxzZqXn
cDgU/yOPOVFw5amTwfcEJPGirSXVvLQMXiF/g4IMqBFP4EIGpP8rLZRbtirwlDaA
tSOlNrd4vvKX6Prc7d67oWpE03BSfjvi5aBX6Ahc0JEXqI/oyo2+s8SXu/0H4ew3
GDwVLM1NsGySFsxQjFwhUPNqo0LN7D27uWuRWVZmEZkoEOFq91+DDVQXqJdWFPYx
vpgrqe0vaEuCxDCi7ZXdtY3lc0hwWQ==
=dJcT
-----END PGP SIGNATURE-----

--Sig_/O51+wFtQh==g8tFwDdgrZ1/--

