Return-Path: <linux-kernel+bounces-116369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1B88995F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5D3B35FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58471272DF;
	Mon, 25 Mar 2024 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C7DNQ9+c"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE491465AB;
	Mon, 25 Mar 2024 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329775; cv=none; b=EMzXJO0KW9qJuOmOnNPFN7pGJB1Xe0jfUXLjT5JI2TEksT0KJ6PcIyA/qNAUgSS0H2PWx0YeIJkI30ueuMzu+7hmLrC7tap84R0rQj2mTnTYwdtiUom/FNPlUnAvgvZSUBhS/eA56KazPHhzygZxVBrYbA9uJNHPPmSQYLev0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329775; c=relaxed/simple;
	bh=OhgPEu1ikVJU0bOgdFj4LD3ggtZPGnznD9STHC5Hshc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TJng2sXEZnPsOagnuU9QqPw09/kUaYx6Oo5Ov4e9dd4KwcTj+uGe4uhuLDjLlOQyLT9ARR0glDJg9aQsMcL0snjmInJnL+3Gp99x6kPuD3mjV+tqL4y6Iy8HTMv1oyJ7zEHLyBjOaFB/N75D6wgSRx1t8blF/QI7yxzgwwt500g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=C7DNQ9+c; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711329771;
	bh=KGhRR3d7HTaNO6qiMTkkvyMr8nO/s1ud2W28JFa3Rhw=;
	h=Date:From:To:Cc:Subject:From;
	b=C7DNQ9+c5TyMvwie1F1sNC8yBPcXT1gjQgIeJaq5dM1pDowJxDhQ9azcJny7/eeJR
	 KhE3Ek737c26U7GAkqKh/SSxS9ZlR4/cdQ0niqMJGQngcbKNtwromxl6BsIulKtQIt
	 nnqRhK+jmq2I9lHKquwE/H+n7VEB/jjVgrfwFMoImwuUM3vZjY3F14bRKIt440jZyi
	 toXTiYb6MtSs0CcIzlNMIUPLXbhURHt1w8bTYfGlqd4smor66WhWH7/Y3ReB4UksJr
	 yVgwPLTfbqiOr/z/KrS8B+2W9otFeNPJ1FWQnHAjUHdnfp1EDfURoTpLtJ1H78SvnP
	 p0GnZNc4LXurw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2wCv2QzQz4wZx;
	Mon, 25 Mar 2024 12:22:51 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:22:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20240325122250.48128d5a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t_adaSFf1b8IxyEkHQ2=feO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/t_adaSFf1b8IxyEkHQ2=feO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/core-api/mm-api:112: include/linux/mm.h:2187: ERROR: Unexpect=
ed indentation.
Documentation/core-api/mm-api:112: include/linux/mm.h:2189: WARNING: Block =
quote ends without a blank line; unexpected unindent.
Documentation/core-api/mm-api:112: include/linux/mm.h:2199: ERROR: Unexpect=
ed indentation.
Documentation/core-api/mm-api:112: include/linux/mm.h:2200: WARNING: Block =
quote ends without a blank line; unexpected unindent.

Introduced by commit

  08ec651d776e ("mm: convert folio_estimated_sharers() to folio_likely_mapp=
ed_shared()")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/t_adaSFf1b8IxyEkHQ2=feO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA0eoACgkQAVBC80lX
0GypYAf/fkFL29Z6Rel5fqfIvPwM3uUJugdCo0cZl+Spu04+gA0tb8aPH92QkU9m
BA60TtpB/ZuTaLH9Irz1/IAFaANhopKN5tOEYFplrby7fEvgLc7m6ZUbAm8juI1z
SpfH+UTrVClS2fXgvWawBhfEwCt2AqH8pMooasDjhWK5JsfxeB1bYUTVvWwat74N
cG5LKg2PvtiwTn0W3g/7+el6yiQ5Sj45x9mSyKWPyF03nZycshMJf/qs6eBhYtyX
hPaImH4hwzwXTYXW9Zefz1k+VXsLiDWBYGcAhwwoCOqJRHU8t41E6DLPa/PqdbYe
ToMwLeOMr2x8JAXoFq2d1tSRc7IdyA==
=H1RI
-----END PGP SIGNATURE-----

--Sig_/t_adaSFf1b8IxyEkHQ2=feO--

