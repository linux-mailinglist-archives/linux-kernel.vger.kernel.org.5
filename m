Return-Path: <linux-kernel+bounces-109326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CEC88179B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7731F23016
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533D8562E;
	Wed, 20 Mar 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="c732I0DS"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2685291
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961181; cv=none; b=d5G+Vk3Bo6lhW6j9NNHe8+hXQk6fH5fGiejFUb8/jnMOqJ5wsfjZUh6kC8qcOo9RDW5U3f80YvKAa0zafa9tCKuGIBoBixdk6hXyv5vwDmH5DDaQqhe6SCV2oZIEuHSi8y6xNGvVp6Qs1Tn01Ma88QMKT7epAbbqLKw/EwKT1cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961181; c=relaxed/simple;
	bh=RbZrfg2enwvomoRc2bu6a3WxV/74o7lRtsEbX7U9R6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuCN9ltADDmSV/ut2pq1MKLa/yYBvZtaD0Alh8rNwBGBvJbKRdAnB0WNXS8uw85ztdar0G1tZt3qmRgrKrzryDQHUC2ML9LvOQoFbANoKBMkUSHeQr3nD81sK/9hOL7e4VD9XzC40UQr6qQsPIeszHEiVkwz9f6sL5VDVX2PShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=c732I0DS; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C3B71C007F; Wed, 20 Mar 2024 19:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710961175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OR/WXQvDApRGoduyJZRKiARfSeeGYfAfVOZRHxcAXMs=;
	b=c732I0DSTVxrrt4fXjYUwxa2dWiGnoL6N44Yhcndm131wyMqFmG1qCZrNiUvR64YugOxbI
	iq/zgXewzGdVgP6MlnxRIsewYut+zD39LPLwCup0zIpwZ7vvw7TrZnDt7g5kyQpcjuvDSF
	Q0n2ms0mzTETHPt6qGrKxZwiIIQ56IE=
Date: Wed, 20 Mar 2024 19:59:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Jones <lee@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>,
	Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <ZfsyFm46YM2cbqDR@duo.ucw.cz>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
 <20240312154910.GC1522089@google.com>
 <ZfCZGevmDe149QeX@bombadil.infradead.org>
 <202403121431.55E67E201@keescook>
 <20240313080132.GD1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/sz2lbjHdt9EdnG"
Content-Disposition: inline
In-Reply-To: <20240313080132.GD1522089@google.com>


--I/sz2lbjHdt9EdnG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I have tried to argue before that it's up to the core kernel code to Do
> > The Right Thing, even in the face of crappy out-of-tree code, so to me,
> > since this is a (very very very limited) weakness in the core kernel
> > code, give it a CVE.
> >=20
> > My attempt at a CVSS for it yields a 3.4 overall:
> > AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X
> > https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=3DAV:L/AC:H=
/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X&version=3D3.1
>=20
> Thank you Luis and Kees for your input.  Your efforts are very much
> appreciated.  I have read and digested everyone's points.
>=20
> Since no one (including myself) is willing to conclude that this
> represents _zero_ risk, the allocation will not be rescinded.  In our

Well, if you insist this is real risk (it is not) would you be so kind
at at least fix the "vulnerability" description?

"Module can trigger BUG_ON in kernel" would be suitable, according to
the discussion. Current description is copy/paste nonsense :-(.

Best regards,
								Pavel

https://nvd.nist.gov/vuln/detail/CVE-2023-52596
Description
In the Linux kernel, the following vulnerability has been resolved:
sysctl: Fix out of bounds access for empty sysctl registers When
registering tables to the sysctl subsystem there is a check to see if
header is a permanently empty directory (used for mounts). This check
evaluates the first element of the ctl_table. This results in an out
of bounds evaluation when registering empty directories. The function
register_sysctl_mount_point now passes a ctl_table of size 1 instead
of size 0. It now relies solely on the type to identify a permanently
empty register. Make sure that the ctl_table has at least one element
before testing for permanent emptiness.


--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--I/sz2lbjHdt9EdnG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfsyFgAKCRAw5/Bqldv6
8rlMAJ9zwEI6Bq3CaVa2JWurCHbkDkaa/QCfZVlLm3F+LvACRfwV8gjBUUT3hjo=
=988t
-----END PGP SIGNATURE-----

--I/sz2lbjHdt9EdnG--

