Return-Path: <linux-kernel+bounces-104544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF02F87CF84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2EA283570
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CDB3C68A;
	Fri, 15 Mar 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJf9ywlx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9E3B783;
	Fri, 15 Mar 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514496; cv=none; b=Uj5qw8fRyTJpqxaOMm9fSB84N7tqHdTtbI2N3rgv8zpmoWNE/dlcwGAY1Fa1BHR4gPu2ePYzPfRp6EONvyAh6iePOs4FDXUIHMH7X/kQ5YIO6psWJBNWA9EQPapf38jMeuOJ+clHdylfA28BD2XwOISO9aoEUv7jQQ7NCK0UKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514496; c=relaxed/simple;
	bh=wpqIUwnNLWbIy1Zvw8blSo1JlKbndzcJuNOieCu2HqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZPpKcoXkomC+KNeRK1beGoMs8rMLbWfB9gozUVer5ElgTKnl4MxdVRAX9vW4Brlr5uvxry/WNx0iTP89+RTc4PbdxLvRw2gyC31CzdQeKcOLpHOFjPQQFW5Hwe91GknNt9oD3+xfhNLLvHX1Yt96yEx2tJcoEe5pnEPFHAQgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJf9ywlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4979C433F1;
	Fri, 15 Mar 2024 14:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710514496;
	bh=wpqIUwnNLWbIy1Zvw8blSo1JlKbndzcJuNOieCu2HqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJf9ywlxeebUGm5lGowLDQIprnpa21rM3k9zG//vZtyYRSfB12aid3EbbaKNikdWU
	 suAfBiOrvPAUV5fJUGyOYhuTW2JvvaxXO2GQ77MheCnaDoT2ma0zyXXObXaql4jmsb
	 Tqip77HGMgvF1isYlmA/yPck4M0NyBZ6ZsWp2FpleUs4B4QxlxC6eAQn5672rThdEn
	 fjy7KIEzadIzf+GtGeelzqslmpmgbTIl8gBsohHeEsCtkI+AWLxc/0PzE0ryShaSVH
	 LLgRjlyZKxusS0VD5yXJcu5E0iGvfPFw09Y1jpnI0BeT7jN/vQ4WheUxLvSOVU0C/R
	 ngIYI8uCVlwTw==
Date: Fri, 15 Mar 2024 14:54:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame
 pulses detection
Message-ID: <9b3091e7-53ea-46f8-9dbc-a3896e920a97@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-10-bastien.curutchet@bootlin.com>
 <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
 <13faa6c8-ad4f-4f81-935a-5ea74621d373@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2KhnnhvxjBoPFAUT"
Content-Disposition: inline
In-Reply-To: <13faa6c8-ad4f-4f81-935a-5ea74621d373@bootlin.com>
X-Cookie: A well-known friend is a treasure.


--2KhnnhvxjBoPFAUT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 03:45:24PM +0100, Bastien Curutchet wrote:
> On 3/15/24 15:09, Mark Brown wrote:
> > On Fri, Mar 15, 2024 at 12:27:41PM +0100, Bastien Curutchet wrote:

> > > McBSP can generate an SYNCERR when unexpected frame pulses are
> > > detected. The driver always disables this feature and ignore the
> > > unexpected frame pulses.

> > What does "unexpected" mean?

> Unexpected frame sync pulse is defined in datasheet as a sync pulse that
> occurs <N> bit clocks earlier than the last transmitted bit of the previous
> frame. The <N> can be configured through registers.

> > > Enable the generation of SYNCERR by the McBSP according to the
> > > 'ti,enable-sync-err' device-tree property.

> > Why would this be optional, and how is this reported - I'm not seeing
> > any interrupt handling updates?

> It is possible to deliberately ignore them and that is what is done today in
> the driver.
> This is reported as a status bit in a register. An interrupt can indeed be
> generated from this but I'm not using it (now at least).
> I use the fact that McBSP automatically drops previous element and starts a
> new reception when an unexpected frame pulse occurs.

That sounds like a very standard behaviour for incorrect clocking.  I
don't think this needs configuration at all, just enable this mode.

--2KhnnhvxjBoPFAUT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0YToACgkQJNaLcl1U
h9DXzQf/SiZqlmZT6xmjS1bCVvJ6Goxl8aWHFYwkoXqqlqIa3nAeHYUUyXV05kI3
Q9wNkk5YWPwDi4hHCkO8/XTvDtnobNBT51YqIWsgLquWdHyHehjGdvhqMkxN/eGi
vJ2v+789u9CPM5hry0dMXgBTxlDG5G1b5GWoGe7rjYEdoCDDTNJo56JRpCk3T/GX
g001ZFQgk2tZUyaGgBEjF1cFzWY2WocYH5l5nhhALRHQ+H0zP75++neQ19ydZkC0
Y4R+CzYDoWn/jvgrf5ng/n+o66WW97stC12kMTjiodnTpaCWSF7Bk+qk1WqLoWAJ
uu2o1O7QEGyyJWz+4GuiRyuMupFGbw==
=aZq6
-----END PGP SIGNATURE-----

--2KhnnhvxjBoPFAUT--

