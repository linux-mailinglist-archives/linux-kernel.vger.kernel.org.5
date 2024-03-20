Return-Path: <linux-kernel+bounces-108325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8DB880930
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF761F23D30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4E17BB2;
	Wed, 20 Mar 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MD+Xc+HP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A014007;
	Wed, 20 Mar 2024 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898938; cv=none; b=g7wCkwKa9C/1Pwuql11kluU2axsIfDGM7bpKsVYeqLZOudwBf4cMaToeEK8LDxTk3xsyoL3OoD6j9LFKhCQy6MF1VclcAUpuxqPlyuRrCwTIpjCRJuIeBh2AadXK3KosDhnNT6XLGb/PtPB48oPXwY65I/0kHyHZl1hSgSK9/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898938; c=relaxed/simple;
	bh=/2XYlF5kyE/AAC5Pi62lNWT/Gf4vDUrDtW5KcwDeAiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn/nnd+ycUEVSrrFKUf677CwbvMftsbSpLpWwvgeGf/t6AOyqjUk7bPVJw45e5CICnQUmLLDDUQAlkkWLUGDtoEfifTsHIX/A/OMpH7jOX8a5mXMwVCEmbzzupapEjU+bW5O30ANugj2v5w+HLTPcq8cc3pdoLzqIBnJjeMS3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MD+Xc+HP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710898931;
	bh=TcLFT4aoOXhTVYvmBbmI8xRkFP/l1aVedP8j396fnzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MD+Xc+HPeZU6P7JAv6LtglocVphjBDfcwOu9F1jNGYNd37c8erO7eLugKKY6u7/Gx
	 2odg+cIy5VvSIjo1WJeQvNu0KFbuggO8QsKcsZeVEoVnNkNpS/IXwOJSYqa7fkFRT9
	 Nmk3U2YO4sD6TPRGsro3cxLs5V+H9MNAoUHUOHX9Jb+nkyUvJiXWmRAvKyoMG/yY35
	 WMiFb+/i6IJBNpg3HtEz4+1Ln0oQBrYPXkviYELw3PMsOUH79oz/I8KtbOaZ5yPyCe
	 3EnssZPAg9iQtuAnVSAGcK2Z3nKOzJ8mPvKCWbd+e8E5899WrXyIQ0xRKmIG4Bwbey
	 /I7+8vW9SiryQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TzrtS4dYsz4wcb;
	Wed, 20 Mar 2024 12:42:08 +1100 (AEDT)
Date: Wed, 20 Mar 2024 12:42:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Andrew
 Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Huacai
 Chen <chenhuacai@loongson.cn>, Herbert Xu <herbert@gondor.apana.org.au>,
 Guenter Roeck <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros
 to evaluate parameters
Message-ID: <20240320124207.0c127947@canb.auug.org.au>
In-Reply-To: <20240320001656.10075-1-21cnbao@gmail.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1UAWAGbxRtmYwKPckeB.frs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1UAWAGbxRtmYwKPckeB.frs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Barry,

On Wed, 20 Mar 2024 13:16:56 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/proce=
ss/coding-style.rst
> index 9c7cf7347394..8065747fddff 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed i=
n a do - while block:
>  				do_this(b, c);		\
>  		} while (0)
> =20
> +Function-like macros should evaluate their parameters, for unused parame=
ters,
> +cast them to void:
> +
> +.. code-block:: c
> +
> +	#define macrofun(a) do { (void) (a); } while (0)
> +

Maybe add some comment about using a static inline function for these
simple versions instead, if at all possible, (it is suggested just
above this section) since that will still type check arguments.

--=20
Cheers,
Stephen Rothwell

--Sig_/1UAWAGbxRtmYwKPckeB.frs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX6Pu8ACgkQAVBC80lX
0GyEpwf/aSL+18yEkUBFWP3AATiTQvd1wmQOKwRks0Qwr95WDjRjbN/jicgyZmQ5
ZQffIXV5H8Otk5NnJHeIJ8sBu8vCnWydBwmhRpepb3rDsAB3CdccBVhMqlWznsWs
aZlcEIHYD2CJbLl56wkKd45KDGr0XjL1qVVwi3mg5wScFUtqaUDj9/v2LYVeAR2u
EtR3uTxYjfJt/dGDsIyuAvQ+8lsCFiB0z8HeUf0slh1LWfm4ZVac+wBMOAbsGpO2
kLrRGJ1fHgZR8amEdQPz1ZOHitAf6KBldPltgcF8KScD95Iz+b6tVjBkJ/bvyPbq
BpWwNvvF4gMwMciooe1yViONfXNgoA==
=U3iC
-----END PGP SIGNATURE-----

--Sig_/1UAWAGbxRtmYwKPckeB.frs--

