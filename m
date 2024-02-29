Return-Path: <linux-kernel+bounces-86509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDA86C65C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E1B28240
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C063501;
	Thu, 29 Feb 2024 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="J7ys5Cg1"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4367C7B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201014; cv=none; b=CmohpyNDsa0uupOG3FL4jC8Om75sZxrxeD+tfuFvTzhkBbfE4kU0SCLHZR0C3DZHhZCcH/XQr6AFzsyPtAi/9O+rezOeJ/eJLRO31wwQu/95JaLAgz4cjPi/q0UThyPQkpjkDnAgZmskaMnwjtUn2fi/TFCrr3+bgiD3rdMD2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201014; c=relaxed/simple;
	bh=rSH0d6zWPJytEOsKlLvgp1AY6v9GhVoFa6M9ZJvqvIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCcluf+mS3Nt0bBOY1dGq/nqlgHGU/qefDoUqn7fJs/R+Kpp56jcSO3fdf1Sr2B/S5oqUo9ceUlB1OVJ2uOwH5f4rdWNaFLpv4NPjH1Dh3NuFXx6pruIUaoOXk2tw/IwsMae75RUeVmCr5ArCX8EXXWAHMpTxHrvDTNNynW2/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=J7ys5Cg1; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 759581C0071; Thu, 29 Feb 2024 11:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1709201009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ao+TgHUmYIZPruHwTWaSp0gqdF1hMMpqCF/XlSbQdTM=;
	b=J7ys5Cg1/8k5404jABVl7pP6LNeFWFyOjK4EeP0r95Kvy63zGJwcU6+a1+9dmtDIv7pedM
	Mz5utZFleK8gtnL6FONYcXsuJMwAiM3XhKJipwgm7xlF5rdxdoBKh2czfY1zjfSeTvCqkq
	Fszoo8qAAUB7shHHJmBE5H9eLMYHY20=
Date: Thu, 29 Feb 2024 11:03:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Kees Cook <keescook@chromium.org>,
	cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <ZeBWcDEECqbDMqsb@duo.ucw.cz>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="589ZECv5K4/DtYSN"
Content-Disposition: inline
In-Reply-To: <2024022915-dissuade-grandson-ebd4@gregkh>


--589ZECv5K4/DtYSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2024-02-29 09:35:28, Greg Kroah-Hartman wrote:
> On Thu, Feb 29, 2024 at 09:22:51AM +0100, Michal Hocko wrote:
> > On Wed 28-02-24 09:12:15, Kees Cook wrote:
> > > On Wed, Feb 28, 2024 at 01:04:14PM +0100, Michal Hocko wrote:
> > > > On Tue 27-02-24 10:35:40, Kees Cook wrote:
> > > > > On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> > > > [...]
> > > > > > Does that mean that any potentially incorrect input provided by=
 an admin is
> > > > > > considered CVE now?
> > > > >=20
> > > > > Yes. Have you seen what USER_NS does? There isn't a way to know h=
ow
> > > > > deployments are using Linux, and this is clearly a "weakness" as =
defined
> > > > > by CVE. It is better to be over zealous than miss things.
> > > >=20
> > > > If we are over zealous to the point when almost any fix is marked C=
VE
> > > > then the special marking simply stops making any sense IMHO.
> > >=20
> > > Perhaps, but the volume of fixes is high, and I think it's better to
> > > over estimate than under estimate -- the work needed to actually
> > > evaluate all these changes is huge: it's better to take everything fr=
om
> > > -stable.
> >=20
> > This is simply not feasible for many downstream kernels and reasons have
> > been discussed many times.
>=20
> How does taking 10 patches differ from taking 200 patches?  Your
> testing/infrastructure issues should be the same, right?

It is more work to review 200 patches than to review 10. As you would
know if you actually reviewed -stable patches or at least AUTOSEL
ones.

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--589ZECv5K4/DtYSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeBWcAAKCRAw5/Bqldv6
8uazAJwNkS7DKDojDXHxbjiWob0iiRvr7gCffQwppbhkk0+4GAih54Ow1rkZhyM=
=1Ya4
-----END PGP SIGNATURE-----

--589ZECv5K4/DtYSN--

