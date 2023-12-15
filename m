Return-Path: <linux-kernel+bounces-692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE6C81449A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710671C2284B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C5182CA;
	Fri, 15 Dec 2023 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="AQ/Y4H9v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A318AF8;
	Fri, 15 Dec 2023 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 10:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1702632573; bh=SVfcatZDjI4tKNtOwP+bScaWGS92iMBU3r/Y+xnXlE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQ/Y4H9vLz4ek8Mm0S1niwIg4YZcp5ijojlBycMiOqNSaAOJpIb7H0kt5cQGLxxqQ
	 /LvjLBEQ2w82q6RAwOqjT5SJmXaspZfOIoxKDUp6/4IQCJsX7bh4i234MbU2E7iPPW
	 paXNPbHP6QorTJ6zVmqeyA743kWef0XkKqc+jbDo=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id A774F80693;
	Fri, 15 Dec 2023 10:29:33 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 9B293180E3C; Fri, 15 Dec 2023 10:29:33 +0100 (CET)
Date: Fri, 15 Dec 2023 10:29:30 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: resolve symlinks for O= properly
Message-ID: <ZXwcfSsuhzJYNAQh@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231214140305.531963-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SGxVEl732S1u5+et"
Content-Disposition: inline
In-Reply-To: <20231214140305.531963-1-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1702632573-03B3ADFE-30E86D20/0/0
X-purgate-type: clean
X-purgate-size: 4125
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean


--SGxVEl732S1u5+et
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2023 10:29:30 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: resolve symlinks for O= properly

On Thu, Dec 14, 2023 at 11:03:05PM +0900, Masahiro Yamada wrote:
> Currently, Kbuild follows the logical chain of directories for the O=3D
> option, just like 'cd' (or 'realpath --logical') does.
>=20
> Example:
>=20
>     $ mkdir -p /tmp/a /tmp/x/y
>     $ ln -s /tmp/x/y /tmp/a/b
>     $ realpath /tmp/a/b/..
>     /tmp/x
>     $ realpath --logical /tmp/a/b/..
>     /tmp/a
>     $ make O=3D/tmp/a/b/.. defconfig
>     make[1]: Entering directory '/tmp/a'
>       [snip]
>     make[1]: Leaving directory '/tmp/a'
>=20
> 'make O=3D/tmp/a/b/.. defconfig' creates the kernel configuration in
> /tmp/a instead of /tmp/x despite the directory path /tmp/a/b/..
> resolves to the physical directory path /tmp/x.
>=20
> This is because Kbuild internally uses the 'cd ... && pwd' for the
> path resolution, but this behavior is not predictable for users.
> Additionally, it is not consistent with how the Kbuild handles the
> M=3D option or GNU Make works with 'make -C /tmp/a/b/..'.
>=20
> Using the physical directory structure for the O=3D option seems more
> reasonable.
>=20
> The comment says "expand a shell special character '~'", but it has
> already been expanded to the home directory in the command line.

I minor change in behaviour is that 'make O=3D"~/..."' (=3Dquoted '~) will
not work any more.  But I think this actually the way it should be.
Thanks!

Reviewed-by: Nicolas Schier <n.schier@avm.de>


> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 24fac1889997..a05f0f7c99e0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -190,14 +190,11 @@ ifeq ("$(origin O)", "command line")
>  endif
> =20
>  ifneq ($(KBUILD_OUTPUT),)
> -# Make's built-in functions such as $(abspath ...), $(realpath ...) cann=
ot
> -# expand a shell special character '~'. We use a somewhat tedious way he=
re.
> -abs_objtree :=3D $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT=
) && pwd)
> -$(if $(abs_objtree),, \
> -     $(error failed to create output directory "$(KBUILD_OUTPUT)"))
> -
> +# $(realpath ...) gets empty if the path does not exist. Run 'mkdir -p' =
first.
> +$(shell mkdir -p $(KBUILD_OUTPUT))
>  # $(realpath ...) resolves symlinks
> -abs_objtree :=3D $(realpath $(abs_objtree))
> +abs_objtree :=3D $(realpath $(KBUILD_OUTPUT))
> +$(if $(abs_objtree),,$(error failed to create output directory "$(KBUILD=
_OUTPUT)"))
>  endif # ifneq ($(KBUILD_OUTPUT),)
> =20
>  ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
> --=20
> 2.40.1
>=20

--SGxVEl732S1u5+et
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmV8HHoACgkQiMa8nIia
bbjsNxAAnGBY21SiDOFDbMwlI4WDHTkl2Uc55xDeXhDRfO8icGU3AAyuJUE3p8x0
qCQ2rLFcfgOWqKb72jL5GQRcrqnOPHFLic96///UHNktu+Zu2lnQM3Zyh+XbTagI
AmlfCm46m0JfCrxQFThRv1wnTIh0OzJKiCRUplYoL6abci4h+cv3/e3A7UCdFUuO
qkifCfrXJlf6Kc1w26uPNPc4MPdiDLR0nJ30UGRgWvlw/ETkzGpCZU2zOB6We+P8
YSY+RfU+OwD6nhy8XZQYe5cvwW0pXVLI9qMlF5u7P2b2tDKc1DmKKkDccojFBP98
LqQBt0S4lGVbJCanQG3Rrc65Nb+G1VMGKjZChUZpdtrtbRCi1Kbd8Qh+lFVQ4tPJ
OY6K3a5BUgFjmsYit0NihEEFeKX4Oy45y8p3Pz95wPeNt8XF6ebuk2PzkDwWUAXM
6784bDCTbGu033QR0Ecp3Ll/2ip5HOgQXejqJAY8gmu4t3ri3+btF8+ky/mTet19
zPhQHe5nWXNYV2HHTqCi4RqAxIzpdj8uHspx5u13Cz6KREp5fFbUbh+jFBFDnf0t
HzvJqdv94Qw5y9PRMIxufJBQpn9X50InwkVklCg6j/xwhaEll3Sdc/MDDGkzUsgx
SVbKw47tV51YcA9dPuW9SlFDcSFG3PjmmywJrrDTg5K13a/ZktI=
=/i4F
-----END PGP SIGNATURE-----

--SGxVEl732S1u5+et--

