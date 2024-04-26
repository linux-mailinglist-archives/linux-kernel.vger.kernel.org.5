Return-Path: <linux-kernel+bounces-159715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534988B3307
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095011F211BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6013FD69;
	Fri, 26 Apr 2024 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="b7ZatGXx"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8B21379;
	Fri, 26 Apr 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120359; cv=none; b=XkiC70+udWbPx1TdHkiXZ5Gl85enj1IED1xmY1XRLem+UmVcNvSTvPbDClX3Zhpe+oy/Zq+8OqNgIzSiWUKutUjsM9VLf0IVzClGY6xV534Q0a6oZvgou4wTNG/DDcTMHbc4DoQGAaa98PFhDz7jKDEe/sIpbvzraQvP1da7UiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120359; c=relaxed/simple;
	bh=JPzmIyrTXDfjqDAST+PV0hnEHHxODh7jJkm7vCutels=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUmrTHcvubFmjPw+9FA3RDuovt7w9P5Jf3ouB19yQtno2WW2dTWgeK6pMBiJIXZbBq4b9JEYSzJxC+SBxJKCiE6aQ/3KNioI+5ukatzoTBQpbcqvPZfO6Id7wpBD4u1gPPHEx/G1lBG/7vNOnWnL6YFqsyi6luvzOjWP5cw9/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=b7ZatGXx; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 776511C0080; Fri, 26 Apr 2024 10:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1714120348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0dysf36aM5avB8c3yAupwYZYTudX4kjUfayQHr8SSA=;
	b=b7ZatGXxsSYhR8l8hZJRyGFW+LOr6qOGfutf+6Zm1P93RkDEUXMhKbTq6Vb+4x8qd1/MSK
	vozQMYgkGMFXitwkhVsSrNpvzMaOIobS45adwv4yKpTz8zordqplMkYEwt7hX30h5lSRJ6
	F1ESRL67V725AzzD/gtl2JuSFrK6Uz4=
Date: Fri, 26 Apr 2024 10:32:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <Zitmm2SWucJA1Bdb@duo.ucw.cz>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b3R0spGM4QxycKkW"
Content-Disposition: inline
In-Reply-To: <CAJuCfpGiRFAOp-aqpVk6GRpG=4LEF3XyuV_LijzwDYRHKqHWWg@mail.gmail.com>


--b3R0spGM4QxycKkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > The /proc/allocinfo file exposes a tremendous about of informatio=
n about
> > > > > kernel build details, memory allocations (obviously), and potenti=
ally
> > > > > even image layout (due to ordering). As this is intended to be co=
nsumed
> > > > > by system owners (like /proc/slabinfo), use the same file permiss=
ions as
> > > > > there: 0400.
> > > >
> > > > Err...
> > > >
> > > > The side effect of locking down more and more reporting interfaces =
is
> > > > that programs that consume those interfaces now have to run as root.
> > >
> > > sudo cat /proc/allocinfo | analyse-that-fie
> >
> > Even that is still an annoyance, but I'm thinking more about a future
> > daemon to collect this every n seconds - that really shouldn't need to
> > be root.
>=20
> Yeah, that would preclude some nice usecases. Could we maybe use
> CAP_SYS_ADMIN checks instead? That way we can still use it from a
> non-root process?

CAP_SYS_ADMIN is really not suitable, as it can do changes to the
system. On working system, allocinfo is really not dangerous, it just
may make exploits harder. CAP_KERNEL_OBSERVER or something...

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--b3R0spGM4QxycKkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZitmmwAKCRAw5/Bqldv6
8iSqAKCKKro6xd8WHDcLsDlqyKCPFqd44gCfZhN+HF+SZvKopvK94yJ3xCHoKGY=
=VeNA
-----END PGP SIGNATURE-----

--b3R0spGM4QxycKkW--

