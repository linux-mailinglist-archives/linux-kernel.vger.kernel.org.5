Return-Path: <linux-kernel+bounces-33279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E678367E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5309F1F23916
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC65A783;
	Mon, 22 Jan 2024 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="e25liS0B"
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE455A7A4;
	Mon, 22 Jan 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935591; cv=none; b=sIdaC9OjomMKnTs3UIZzyP90jAgH+offTOSZDsH+NM27O9Far+Cirs33sxRIlsiTFJzlTMnipncZjIBMkeDlHuzha2uNqQUocYH4SIaRtv50fGdidw7rzRGn22yzUWBm70V8n2SgmqNXcsc4f7DHtb5T/2re7O8V5ZYlsxB63HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935591; c=relaxed/simple;
	bh=iZ+Iu2pChYgh9YzjA7aD5HcSr1Qpkml4SPwC7povsjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8n8F6ULMehcgjcHpN1RLXNMadxPqwnVH2DftYJYQjhqo6RTfvROdWIFwyKbCXeQCNuZklMjcWqjTJgZMwmnhlfHcZagMKlVUf9yU32P0OiKkf0QAEQTny4XLBDfdgan6Cx4tCYbm6iHBs7XrjjhATXkiNiKDlyTGXyRWUIhQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=e25liS0B; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1705935580; bh=iZ+Iu2pChYgh9YzjA7aD5HcSr1Qpkml4SPwC7povsjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e25liS0BORpBZo+Ha9eU0ylakpuDPJTVs/+9XZPXgdHqDwjGvkkD/fKmX6Lh06sBG
	 VAGDON0rlmFRjZZcAecLYsApLQiupxkVM0nncJ2/wXukHha2LHFIoMA9/ymZSwTE0E
	 /PFf9NODSup4m793jrdUCGZesTbVhkCeQJII9QT0=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 22 Jan 2024 15:59:40 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 06292800EC;
	Mon, 22 Jan 2024 15:59:40 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id EE3FD180F5A; Mon, 22 Jan 2024 15:59:39 +0100 (CET)
Date: Mon, 22 Jan 2024 15:59:37 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly
Message-ID: <Za6C2w0QIZDayA48@buildd.core.avm.de>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231215160637.842748-1-masahiroy@kernel.org>
 <20240122141203.CWe3n5rG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+Z3urJkjmGAoQ8z"
Content-Disposition: inline
In-Reply-To: <20240122141203.CWe3n5rG@linutronix.de>
Organization: AVM GmbH
X-purgate-ID: 149429::1705935580-41F1F6D9-60525429/0/0
X-purgate-type: clean
X-purgate-size: 2698
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean


--M+Z3urJkjmGAoQ8z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 15:59:37 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly

On Mon, Jan 22, 2024 at 03:12:03PM +0100, Sebastian Andrzej Siewior wrote:
> On 2023-12-16 01:06:37 [+0900], Masahiro Yamada wrote:
> =E2=80=A6
> > Using the physical directory structure for the O=3D option seems more
> > reasonable.
> >=20
> > The comment says "expand a shell special character '~'", but it has
> > already been expanded to the home directory in the command line.
>=20
> It might have been expanded, it might have not been expanded. Having a
> shell script:
> | #!/bin/sh
> |=20
> | exec make O=3D~/scratch/mk-check defconfig
>=20
> with bin/sh =3D dash results in:
>=20
> | make[1]: Entering directory '/home/bigeasy/linux/~/scratch/mk-check'
>=20
> while bin/sh =3D bash expands the ~ properly before for O=3D. Would it be
> too much to ask, to expand the ~?

Expanding tilde expandos is traditionally a shell feature, as you
already mentioned; and bash supports also expandos like '~+' and '~-'.
I think, we should leave the shell things in shells.

Thus, please update your shell scripts to be compliant to their
interpreting shell (e.g. use '$HOME' or switch the shell).

Kind regards,
Nicolas

--M+Z3urJkjmGAoQ8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmWugtkACgkQiMa8nIia
bbidNQ/+PChz3YchNvwJsNx1T31zdo9pMPxMfhQswSRBAXU1v6UVIogye14Tuee5
gyAZrEwjzyLMe1gt6EziHUGI46uampWwOKjYUV1I4FPXgROWjg3L8wUTzR1ntlde
Hj/c6QMJbfsYUopTaEg/wSfAdur5Jq8dPWi6H/MRgSfrv+/n2wqWhQAIV3uOskJT
UvmHeWdqeZcqQWnn+YJv1JIpkezfVObemJG5rYpNqZZ6LsGqm5CaGP1EpwJ+mTLn
5nKroGpTAAHDrvDCnAjrNeWaEEv3g1PAVCHYNFQkKqD+ajjUnVYmYaamR6RNVWcW
PnCHz6PWD7Kr3j7kV3GoEFsifTHPHazZkLS8fW/TpTbjrDxpgGyTVP4EEcjWejTh
Yog4is9E0KPXlCUCHTOB0Z6GKtKroMZAfwG3avXdyimx/XGzNkBR/vdZqhno3ARa
IClL/WnlK0vT89rnpLfd5aWfPtlSQi2Uyf2f2TNmQ/9gwUXIkBnQmpp3n0zsonYf
aed7eXPxPiAB9ISB1rFrY9KT/xGUGPjFVjK/vKzAJG6rGxoObuUlU3yE3/8MmhEV
bwbGnU/V4xGxcLLy8VFHD+9m8EEAR2XrhBr+pWqvSrxDZYApT6sv49wavXWLRi98
xTBjWToWSxEBFluzNYCIFeQuyWLatqEVEyEU2seUbIVafZ6PKK8=
=1xdJ
-----END PGP SIGNATURE-----

--M+Z3urJkjmGAoQ8z--

