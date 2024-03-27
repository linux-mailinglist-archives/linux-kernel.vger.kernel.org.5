Return-Path: <linux-kernel+bounces-121690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C61E88EC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED87BB22892
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711514D441;
	Wed, 27 Mar 2024 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkImE1FJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5946714D6EA;
	Wed, 27 Mar 2024 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560107; cv=none; b=oHbOXtvyV6IDcHPuif7Ot/bVzbKoO5FgWdA9lyrTarKv0N8LZEaROxzCzlCOwA+R4LEAGOtot1dq/hZQD8h2agpcgjQl/ilo7c6BM9T7vKTA0vWZQ4oNA/sxn3k9+JpTiHriB3i9KUSqIz50EEbtQN2BbMW8/74wZFGGfC2hlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560107; c=relaxed/simple;
	bh=xROqHGua4j6HcszJt7ZG/hqG8TaOs2PmwN195yXx6hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgyUwuXRnQalIp5/T1gteLpD3WrBWYT/hyuSigeJ6zT3KaPAtNW59gHmOFF5mdAMXvggWfGiCGub205k6ei5y0qlX9FX0uQ7yvKi7qSDiOfzObrOL6Ep7Hd0pBlc8J9QJEdelyVVf6rydJ0SLqGBUf6ctDg+J2wJ43GkuUCYsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkImE1FJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB83C433F1;
	Wed, 27 Mar 2024 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560106;
	bh=xROqHGua4j6HcszJt7ZG/hqG8TaOs2PmwN195yXx6hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkImE1FJHLz0Xv9jw+4vLwPD8Oq+E3m9s1Im/KSpkWfV5O3b3fs1Wx2oQmZ8jY7SM
	 vOPzxfL5oLH4VnEC9nvuwnjMM/3vkesrI9CxY2eJkgSbsmwVcuBzwBV2gY0D0WNE4T
	 9/AtNS0r+mJhHpMjMKxAqxBOplYBMo7+NcpOCZQbVCEXHB+lQZPCr7S5a31aB1bEVH
	 Pb6sNCHY9W2OhkVIP5svVIa40CCJXyb+3KXjJi9WEzLQMv63gDNV36olH6RKwwkXvg
	 fw79W+Ko4rNsLJ6hqCA/6agFzRl4EVzUiZJbkNxCVTBmGaSTV1RAxQ4CaezxEHa5J8
	 fllbgdiEyUiAw==
Date: Wed, 27 Mar 2024 17:21:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Dragan Simic <dsimic@manjaro.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	Alban Browaeys <alban.browaeys@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
Message-ID: <20240327-reopen-subsoil-4b8434cbb41e@spud>
References: <20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
 <20240326-tactical-onlooker-3df8d2352dc2@spud>
 <436f78a981ecba441a0636912ddd1cf2@manjaro.org>
 <D04O57YQHYI4.1QNGSVKVT44CS@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BktBpU3GHnzCWrgO"
Content-Disposition: inline
In-Reply-To: <D04O57YQHYI4.1QNGSVKVT44CS@folker-schwesinger.de>


--BktBpU3GHnzCWrgO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 04:21:45PM +0000, Folker Schwesinger wrote:
> Hi Conor and Dragan,
>=20
> thanks for your feedback!
>=20
> On Tue Mar 26, 2024 at 8:55 PM CET, Dragan Simic wrote:
> > On 2024-03-26 20:46, Conor Dooley wrote:
> > > On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4
> > > Relay wrote:
> > >> From: Folker Schwesinger <dev@folker-schwesinger.de>
> > >>
> > >> Restore the behavior of the Rockchip kernel that undconditionally
> > >> enables the internal strobe pulldown.
> > >
> > > What do you mean "restore the behaviour of the rockchip kernel"? Did
> > > mainline behave the same as the rockchip kernel previously? If not,
> > > using "restore" here is misleading. "Unconditionally" is also
> > > incorrect,
> > > because you have a property that disables it.
>=20
> Apologizes for the misleading commit message. Prior to 5.11 the Linux
> kernel did not touch the pull-down registers. However, it seems the
> register's (factory?) default was set to enable the pull-down. As it
> was mentioned elsewhere that was the configuration recommended by
> Rockchip. The 4.4 vendor (Rockchip) kernel reflects that by enabling the
> pull-down in its kernel.

Yeah, seems like a bit of a sticky situation. Probably the wrong
polarity was chosen when the property was implemented and the property
should have been the one you wanted to switch to given the default
before it existed was the factory defaults.

> Of course, this has nothing to do with the Linux kernel, so "restore"
> was a bad choice here.
>
> I previously had split the driver patch into two separate patches, one
> for changing the default (unconditionally at that point), the other for
> adding the disable property. As both changes were minimal I decided to
> squash the commits. I updated the cover letter, but forgot to update the
> commit message. Sorry.

No worries. Squashing them was probably the right thing to do anyway.

--BktBpU3GHnzCWrgO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRVowAKCRB4tDGHoIJi
0vZBAQCa7Y4ALYnndw09ojj/rscvv2/ascq71lwrZORFc7LgWwEA2fBPIlz+6yb+
Su6b6pt5k4wywnxerLOAC3N/zmJbEwY=
=lcb4
-----END PGP SIGNATURE-----

--BktBpU3GHnzCWrgO--

