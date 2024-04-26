Return-Path: <linux-kernel+bounces-159717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D948B330E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5C22860E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9BF13C9B3;
	Fri, 26 Apr 2024 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="r1+96Ook"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847176026;
	Fri, 26 Apr 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120448; cv=none; b=mh+vi8SPfhhijcASN0TyKunV8EZlSZss5mkA8bYtbLsrKvvXmHOidtRuLxl1vZP4oyfb//N3mapLr75ztO5tgtJXbxdPbnGjAPpLCHh8k/xe9Oh0bryMCHmznup3udIF/1gTwe13adZNI3CehqImyKRxiJrtfsf6jT4Yu3eCiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120448; c=relaxed/simple;
	bh=yCu8QgIgIudWIoFUBIgiPgM1UQ4NtIrnev8l9GHrxR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFyAG2VQoln5DQnXnYO355//rmTsyGL7pvqnxAIt35uoeZ+I4nRi/Yc2UHWDFXkyfaoAczxJaaHjpvvPVQcV3wyIuoXUuFFUAJ695omzX8z5WErZnWqMUN5AuELf6blZSFtnkXbS2rJwOTiE2XCLuK0fXVHqk77qif2v7YGVe04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=r1+96Ook; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0EC6F1C0081; Fri, 26 Apr 2024 10:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1714120444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvibUhHYADzPBz5EC0L11wDXL1jTgRw8iSeBq8eHVAM=;
	b=r1+96OokA5XnKcE0vuf1HJX1Ft1NJRMVXB5Y6SoF6NZ+LhN73MJbxf6L6vZMvey5Kjcj0e
	9cOjaBw82DXwSN7HFQyB9TyKY1Q/O16uAIueJST+3SO64nnoP8t+r5PZ+EVeT1RVPuI9a7
	2Vj+jc1gpnbG7eTWMr9PAYK0TEF4RsA=
Date: Fri, 26 Apr 2024 10:34:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <Zitm+xB1zFmqVQiC@duo.ucw.cz>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
 <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
 <202404251740.81F21E54@keescook>
 <qzi5ss4h4ou6yfbzadoamqocvvzviuh3eeefpv5qfkcvrrejfo@qptmu2y6u7qj>
 <ZisetKVI2Lnzucm9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hfd8D8Tcgbk/y9Re"
Content-Disposition: inline
In-Reply-To: <ZisetKVI2Lnzucm9@casper.infradead.org>


--Hfd8D8Tcgbk/y9Re
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2024-04-26 04:25:40, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 08:58:34PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 25, 2024 at 05:43:33PM -0700, Kees Cook wrote:
> > > All this said, I'm still not excited about any of these files living
> > > in /proc at all -- we were supposed to use /sys for this kind of thin=
g,
> > > but its interface wasn't great for this kind of more "free-form" data,
> > > and debugfs isn't good for production interfaces. /proc really should
> > > only have pid information -- we end up exposing these top-level files=
 to
> > > every mount namespace with a /proc mount. :( But that's a yet-to-be-s=
olved
> > > problem...
> >=20
> > It really wouldn't be that hard to relax the 4k file limit in sysfs.
>=20
> It's a lot harder to relax the GregKH opposition to multiple values per
> file in sysfs.

With all the "vulnerability" files including multiple-files with
english text, you may be able to renegotiate that :-).

Joking, really the vulnerability files should be fixed.

									Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Hfd8D8Tcgbk/y9Re
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZitm+wAKCRAw5/Bqldv6
8ll4AJ9jdqA72f4HoYEdP44jUJtvFz4NiwCfS7dHjbTz44v8yKIi6pQk9qVCu6s=
=C7Pf
-----END PGP SIGNATURE-----

--Hfd8D8Tcgbk/y9Re--

