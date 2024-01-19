Return-Path: <linux-kernel+bounces-31606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E455C8330B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4221C21CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66258AC3;
	Fri, 19 Jan 2024 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZkWJbbu6"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892138E;
	Fri, 19 Jan 2024 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705702479; cv=none; b=LgeM9pZAEtlMglXhSwWlHlLfKDvoLcqQsEkVdNf6VA5HEdmj4wIMUvkKh8FUAYeqdly2e01x+3o+85g+8zLR99UmngpAfu4cJX4Xq2bZj/zygiojEUtGYscd8gUqnrN+8VgxFsKRvz2oR5pngXheW8r4ZdjxrHNIZYHO0Co+g4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705702479; c=relaxed/simple;
	bh=tqcp8VLJ1hG12jEXoG9yMajUiGJVBaapL4MrZ2B3TzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmLD3jQQ+FwaD1vNuG76C6RQumOxuyBqtusytyLhP4LA2HKPXZRu+letcnCie2fXRBMNvzo0Opk2GLpGCFDfHPM/9b5DdTaHFZnTD422MjIq/TLL6yJBQiG1roBuKEy4N2n90o8EK2LKmrwp9HC8NcBSCq9L4MCdWjolwSbQ/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZkWJbbu6; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 71B101C0076; Fri, 19 Jan 2024 23:14:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705702474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yAQCch9K+HPJYF16tFEjwN6QYUkinUbXhmOFLhotBI=;
	b=ZkWJbbu6TKig1IocluCVEyg6kj+m+tZwkENyUlGH4CSe7/ntSE6hzdUcJ6O+723NpRry/D
	dNJmeDFBdh77cqwXzf2/WCzSsUmB7xeAapG2mSz4ZLs5DUj1Yy8RHnwSPyvtizlnqxCUGP
	qmAYFH635gIQl7JDji5A7BBK/dQ7Mbo=
Date: Fri, 19 Jan 2024 23:14:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Werner Sembach <wse@tuxedocomputers.com>, jikos@kernel.org,
	Jelle van der Waa <jelle@vdwaa.nl>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linux-input@vger.kernel.org, ojeda@kernel.org,
	linux-leds@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Implement per-key keyboard backlight as auxdisplay?
Message-ID: <Zar0MFelV4gY50La@duo.ucw.cz>
References: <ZVvHG/Q+V6kCnfKZ@duo.ucw.cz>
 <f4137e34-c7fb-4f21-bc93-1496cbf61fdf@tuxedocomputers.com>
 <8096a042-83bd-4b9f-b633-79e86995c9b8@redhat.com>
 <f416fbca-589b-4f6a-aad6-323b66398273@tuxedocomputers.com>
 <4222268b-ff44-4b7d-bf11-e350594bbe24@redhat.com>
 <ac02143c-d417-49e5-9c6e-150cbda71ba7@tuxedocomputers.com>
 <ZaljwLe7P+dXHEHb@duo.ucw.cz>
 <6bbfdd62-e663-4a45-82f4-445069a8d690@redhat.com>
 <87bk9hppee.fsf@intel.com>
 <ZarAfg2_5ocfKAWo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqqzmPOTbqCBp9No"
Content-Disposition: inline
In-Reply-To: <ZarAfg2_5ocfKAWo@google.com>


--DqqzmPOTbqCBp9No
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > And while I would personally hate it, you can imagine a use case where
> > you'd like a keypress to have a visual effect around the key you
> > pressed. A kind of force feedback, if you will. I don't actually know,
> > and correct me if I'm wrong, but feels like implementing that outside of
> > the input subsystem would be non-trivial.
>=20
> Actually I think it does not belong to the input subsystem as it is,
> where the goal is to deliver keystrokes and gestures to userspace.  The
> "force feedback" kind of fits, but not really practical, again because
> of lack of geometry info. It is also not really essential to be fully
> and automatically handled by the kernel. So I think the best way is
> > to

So that's actually big question.

If the common usage is "run bad apple demo on keyboard" than pretty
clearly it should be display.

If the common usage is "computer is asking yes/no question, so
highlight yes and no buttons", then there are good arguments why input
should handle that (as it does capslock led, for example).

Actually I could imagine "real" use when shift / control /alt
backlight would indicate sticky-shift keys for handicapped.

It seems they are making mice with backlit buttons. If the main use is
highlight this key whereever it is, then it should be input.

But I suspect may use is just fancy colors and it should be display.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--DqqzmPOTbqCBp9No
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZar0MAAKCRAw5/Bqldv6
8nOZAJ4+IFE/M4uAdwtp+rAqwXiKQFW5AwCfc7V3dsFCCcUTbiKDtFNWrSxtK3s=
=uMxc
-----END PGP SIGNATURE-----

--DqqzmPOTbqCBp9No--

