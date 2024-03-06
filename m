Return-Path: <linux-kernel+bounces-94590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBED8741CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7DE287443
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB911B947;
	Wed,  6 Mar 2024 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IBpvo54l"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE51AACB;
	Wed,  6 Mar 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759796; cv=none; b=ZI0S/xocZHgzaKMUSDsaQBqml7cznk2lA31d0uqd4Wa0P1S6cMXlGJwwCYF7LAerwI21tLHTm3vGkccbkpkKhEFjz/AbBE0Q4MxazD2278aczX5ILlTo+r/aP9y6rQQ/TGqeWVewdzOHk9y8JxfDL0h24X/vZlpqIHbF4RDAQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759796; c=relaxed/simple;
	bh=L8HLwdL9FxOw1tWcD1FOkZhzrSdoCI1fpuME/eWRLuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g2b0HViwJaO8bC8dPvcgbGwf7Pp31f/JiRQeJYN0SZjY3ghH99B1DJ0/bdBcCr6IgYH1Wq1yuu8wwtQ7M8PBzhSJBTgYS1Qd/AuLCxNiBh46gP6NzqYpjn6Pk1z55A7+5L0YEI4dMuUpQAE0JLS+9Yn8mK4lqBFDicZ6LZqt/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IBpvo54l; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709759790;
	bh=5P6VdPeDKS+M+YrQSjKLl0oDFkBUutI9/B35RLH5oXs=;
	h=Date:From:To:Cc:Subject:From;
	b=IBpvo54lFxzi7ht8/bGkLtVHnJD1zpUlwAQKQiMxspBAvGbExRUlhlOp1hXs8zXtN
	 +cAiFhKjwyVokL5M52LD4BXnrdqfxXab/9URNWLrnSycH+m0O/3PT195wtPsVBSPMV
	 WtX3o8y5yHaGY2/w+ZwbPKNUhVT/WyIRzg8Gm6hg716YDXne7s8hyFMS/emRQYRFdn
	 MXUqAcdksC22yjc4sW7YEe2FPOfqlh+3XXaRzO/o0Z65TleiT2b0nqJ4srWWGzIcpF
	 Gv/spLXJl3p9WT10GU+cngklf4VkJE1bjOa3i2SL5NBvLQEQFIIMJ9t6iY6at6lLUl
	 UyO/etrD7E2Ew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqlbx672bz4wc7;
	Thu,  7 Mar 2024 08:16:29 +1100 (AEDT)
Date: Thu, 7 Mar 2024 08:16:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <xiang@kernel.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the erofs-fixes tree
Message-ID: <20240307081628.6a9e9b65@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_joZs96ihu4+U_1KhsSU=vJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_joZs96ihu4+U_1KhsSU=vJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f531a3c17e7a ("erofs: apply proper VMA alignment for memory mapped files =
on THP")

Fixes tag

  Fixes: be62c5198861 ("erofs: enable large folios for fscache mode")

has these problem(s):

  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

So:

Fixes: be62c5198861 ("erofs: support large folios for fscache mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/_joZs96ihu4+U_1KhsSU=vJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo3SwACgkQAVBC80lX
0GwpUgf/djH5h11Cry6zwug6JbzxkpKEBMwxMHhugaR/ENtPVV5QzoRxeAT4KklK
RfbqL2vUP52F5i1Sizw3vGv+8C2R4Vh9GWQaQs577Bxb2CTGoTZ60w4M+Ff1XEYp
0Xc5k8/0sz9/ThmV5cTaG3qVx1Q9k6GAb9E/X+IC40ss5UMLBjHJon7Tz4GiwbuN
825IpUrUZIQv+//XB2F4+D4yr0eIJKXJ49HNyiKSkJWMTMx4buUssaV3dpPsvGRp
19x8F1r5DoYP9GXfyqiLf83sTS/hPsr2qY64VDocWtGt88poQECEkqKl3hvQ8e0w
DHUwaUgzd3z209yz3ICfM/VgWgx2CA==
=umlf
-----END PGP SIGNATURE-----

--Sig_/_joZs96ihu4+U_1KhsSU=vJ--

