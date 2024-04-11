Return-Path: <linux-kernel+bounces-141677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583058A21E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654471C2340F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DD74654F;
	Thu, 11 Apr 2024 22:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mu2C0ZFK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB091862E;
	Thu, 11 Apr 2024 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875626; cv=none; b=MO5HEoqnjTFihCSX4NJpc/JU1G7OZiFxHZSxhEC+e/kp9+U/G+EzHPbzGDrl+woAr37Jwd05ykOkeWu9wCeiWDhfpdXQ7Blwt3GQPxMC9HRwOFXkbq+s/DNqYykFyefJo79X7q5alUW21dDKzEfAEcvpmnjKN88elTBcvh4Kxhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875626; c=relaxed/simple;
	bh=B7DFaexNp7uzlDwROoWiFKLN2RLvcdHIT/H/rvV1EmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haV6kISorct6ODq5wCTwVJ2CUlFcpyGpaBg1CfhK0yvkrUJEmpq5sDuOXoAW0Lvm9R5/MxuipV5L5TrTURdB637aoLlvUAwthxIyvgWEJ3/64O6OBC+yZIF1TcyS6ReSY53Bz8DSK/HDgs3wm3B9NOFBZh6FGeqaB0ObDuFH6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mu2C0ZFK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712875621;
	bh=lGwbAIqRRJJ+SVhlSB3z0aE44aqSlaaLALzt8XtjRSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mu2C0ZFKq1P+XtQ1/IUAuwHIqORcSwYCTB+sZ5ZDT9M9ZKaw23q7q30VN1mcCUBkq
	 JJU/Etke7XlsdTaiqRH5BPt4foFt5Y/7Qqm+Cmxs4/Md2IMbu3jAYB1z72n9ZGZ0Sv
	 BzFtZSfP0upeyWE3ioZO48UoxVAMKBxL7EbjdmvFVUP7zA/FOd60gvcftIBmqeDo8f
	 gQSpMFxYXzExTXkZbtV/v5EcXOiINjXCbbz4b0fg441i8Hvx+zZ7qSs5XwvZLRAYdA
	 HhF2zLhR8niSElBTEPZhxuahUxwEAJOiQVWonWR8rI+Jx2giqq4b1wTIIGYeFkHChJ
	 CLK0Fls0olwqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFvvn2tv9z4wnv;
	Fri, 12 Apr 2024 08:47:00 +1000 (AEST)
Date: Fri, 12 Apr 2024 08:47:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the loongarch tree
Message-ID: <20240412084700.21dae182@canb.auug.org.au>
In-Reply-To: <20240408101333.67a8bf17@canb.auug.org.au>
References: <20240408101333.67a8bf17@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p.bHwdmttzCEix88c8+OBoX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/p.bHwdmttzCEix88c8+OBoX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 8 Apr 2024 10:13:33 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> The following commit is also in the mm tree as a different commit (but
> the same patch):
>=20
>   27e361b5e171 ("LoongArch: Include linux/sizes.h in addrspace.h to preve=
nt build errors")

The above commit is now in Linus' tree.

> this is commit
>=20
>   5d90c9735da8 ("fix-missing-vmalloch-includes-fix-3")
>=20
> in the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/p.bHwdmttzCEix88c8+OBoX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYaGQACgkQAVBC80lX
0GxzHQf9HPmgoaG++65lAhpiMMQrOjmQ+K3zUAKy1n5xk8K/8wP1u0Jpm2fBHNu4
HWNOmGOCukvkrVR3u6s0XgzrnVYOdRvBlgdlj4YPJEdS8m9JSNUFBZJXcA8BgIoB
mHkjrtqo9Oaa5AH1cK/Tf2WEjwAZcjR/89LKMr8vbbdeE/r8qZBHrboA6KjNhzxV
DmLo/X4jPP3MPXSXvzcKftgmypBFf14QtZzQyVA1YcV989DdIACqx80JcdHj6t6D
arhp4WYWvwsSQrqplyuP96sky0SvmO2zR/jnFycKhKj/wq8GfSSPKt+pFDnKvHB9
jE9K3mrhartHbV+ygOh2AH8OdO9tBg==
=zSdO
-----END PGP SIGNATURE-----

--Sig_/p.bHwdmttzCEix88c8+OBoX--

