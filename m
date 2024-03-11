Return-Path: <linux-kernel+bounces-99617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D683878ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1EA8B21843
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C958129;
	Mon, 11 Mar 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XVzYb4Sg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102A3FE28;
	Mon, 11 Mar 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196561; cv=none; b=Qf4ZnBSD4/ruEEhBVMSSwghIQ9lmT9AETy+Ayl5/rIIdLlHbeOeMAfaxK7oZ29uXRfguZuUlICwkLYEu6YrAWvbT+s69DHtyfbFPhq9DCuUcO3BAHLJy5bMSx65LUcv8Wc3PMbktBJBpoxvjTMz379x3GWAnMipmI2FPo8hCzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196561; c=relaxed/simple;
	bh=xIdn64NHzht9Ci697Kv/d4xkhLv74ka85vfHlGkKIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/Y3lk0ZwV2sDfYbD7RSWWWiQoWaswhY5kNUbwuM8Hmb+zI+VQLvfW8xzQ6+eZFC4cAsaJJh3d4ycCK99AT/HS4Rmk6Ywigf+YCClnp2E3lTHlx1xJQ/QVO0+HA5eXYUBiN0kzqY+4Mc3A/2HEFcS/dFenKGmKsQfuExvojqvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=XVzYb4Sg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710196555;
	bh=zvqPT2sSVSNky2dcurfWLdLkzbyf1h8Wl1OaRcXTHX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVzYb4SglUKx5TV0nbMzM9R15DHmxv+lExk18wg8ezKFQ5r256GkofNnM2DoaWmg1
	 ib4btue3qZP79T4yeViOjLoFC1ovDcFExnB8cA5m/NJNB8TXq+tiuVl+Z4P28Fw4+x
	 bGSNnqOVtuPmrJ7VcSeCKj01I90sot3YweCc6hxxTj5A9qa/h/Fq2l6G4nBo6g9PFZ
	 +DfXQTiRtbcVkQW3ruxAWvLbDDO8IMKTK4AmYuXgln/1QxVf+UxHsMjaRfOC6bbPYI
	 D8Hr8pwrKSg0pzxXtn1jgowIQdXroZMdk0wIpwJROK3IAInOS1j+RirGvMy/8WSOGE
	 E3Uyf6XqLCNPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tts7H1y61z4wyt;
	Tue, 12 Mar 2024 09:35:55 +1100 (AEDT)
Date: Tue, 12 Mar 2024 09:35:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jamie Cunliffe
 <Jamie.Cunliffe@arm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rust tree with the arm64 tree
Message-ID: <20240312093554.757be026@canb.auug.org.au>
In-Reply-To: <20240301153807.796a3a28@canb.auug.org.au>
References: <20240301153807.796a3a28@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q0Isj19=L7oicB0XWpoYZzw";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Q0Isj19=L7oicB0XWpoYZzw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 1 Mar 2024 15:38:07 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>=20
>   rust/Makefile
>=20
> between commit:
>=20
>   f82811e22b48 ("rust: Refactor the build target to allow the use of buil=
tin targets")
>=20
> from the arm64 tree and commit:
>=20
>   ecab4115c44c ("kbuild: mark `rustc` (and others) invocations as recursi=
ve")
>=20
> from the rust tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc rust/Makefile
> index fe045dbc701e,a78fcf4004b0..000000000000
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@@ -435,11 -434,8 +435,11 @@@ $(obj)/core.o: private skip_clippy =3D=20
>   $(obj)/core.o: private skip_flags =3D -Dunreachable_pub
>   $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intri=
nsics),--redefine-sym $(sym)=3D__rust$(sym))
>   $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
>  -$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
>  +$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
> - 	$(call if_changed_dep,rustc_library)
> + 	+$(call if_changed_dep,rustc_library)
>  +ifneq ($(or $(CONFIG_X86_64),$(CONFIG_LOONGARCH)),)
>  +$(obj)/core.o: scripts/target.json
>  +endif
>  =20
>   $(obj)/compiler_builtins.o: private rustc_objcopy =3D -w -W '__*'
>   $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o F=
ORCE

This is now a conflict between the arm64 tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q0Isj19=L7oicB0XWpoYZzw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvh0oACgkQAVBC80lX
0GwcDwf/bMJz7vItRV2Jj0m6wXuP0h3a74+UhMSDaEXhx4qTGmCCYuldk0HNr0rl
u10DAaf4E7McOQXIZAXUyEm0x9M+0aF9DadaUf1+yV7/Q3Yq+hUp/RyKzWtyBCPe
WTzKeihWYMROHqAR2pksZ/1B3TlYhxXmGiyqoFVaQ4H1dnn7TDxeZf6giK6IHntl
omG2g3mePQsESPSKH0tg2AMWnWtnVNbuDzqReTNTb/b6swgaTyUOlkuRuqYWM6hS
zVh/N+u6vQUHro1Hw/pgktK7iTUMI0CGaQ/rOajt63/CBuH+WS117lUrxOpW4sys
gk/ghPZWOcZcguVdWLXDjIRfwSGmyA==
=lt8A
-----END PGP SIGNATURE-----

--Sig_/Q0Isj19=L7oicB0XWpoYZzw--

