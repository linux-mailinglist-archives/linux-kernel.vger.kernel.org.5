Return-Path: <linux-kernel+bounces-9698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600281C9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EF91F230B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666318050;
	Fri, 22 Dec 2023 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCHkJWRO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC918026;
	Fri, 22 Dec 2023 12:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7788CC433C7;
	Fri, 22 Dec 2023 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703247847;
	bh=5JEbd/0MfkqBn9EcZaazmNPVjZ1aK33sdc1b4Cp4oj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCHkJWROWNx4DEjAnaNatwrpAXjQFrlSUJOrOs2KHXBXLKWYRH1h4a/WbuvA4d09+
	 QyVFjAe0veZUhZ1mgjFItkQM2fXXhvyhfnBenMXLZvf7KG8hwZuq7YzVWpQ0soxSPa
	 wgwNheuAlzRsJ4yay9zocZWfjEbXFZ53Xam8QcHGFwj8Ozb+7KDHdAyzBtBqIzUQvw
	 lnGj0noKdGZyqecQpEPH94H4CphrJegrhDdhrZRnu7sQjqMqN49I9JOkb9VvgOJNPC
	 f/eVscRrHDb8ZPS4Ff1JtE8xPxyxQDHVhtJW/UN8svHbA8LueZrE7cG1oF6F4ztMKY
	 uifkqV0LImykg==
Date: Fri, 22 Dec 2023 12:24:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: lgirdwood@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] regulator: pwm-regulator: Fix continuous
 get_voltage for disabled PWM
Message-ID: <9bea64d5-8689-48f0-a081-5da60434e6c0@sirena.org.uk>
References: <20231221211222.1380658-1-martin.blumenstingl@googlemail.com>
 <0c99b575-5cf2-4bd6-8cfd-af19f5fd58da@sirena.org.uk>
 <CAFBinCDJnVzE2sMwu52MQGTKW7dtCuUoj63ZZHhJPJO0+dZDkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="juKFXjvLaxOmiLZO"
Content-Disposition: inline
In-Reply-To: <CAFBinCDJnVzE2sMwu52MQGTKW7dtCuUoj63ZZHhJPJO0+dZDkg@mail.gmail.com>
X-Cookie: Familiarity breeds attempt.


--juKFXjvLaxOmiLZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2023 at 11:42:29PM +0100, Martin Blumenstingl wrote:

> The vendor BSP includes a custom u-boot with lots of relevant
> information for which there's seemingly no documentation.
> It seems that 1.1V is what should be used during normal operation.
> 0.86V is what can be used during system suspend (when power to the
> Cortex-A5 cores is turned off and an integrated ARC core is taking
> over for wakeup purposes).
> Hence the supported voltage range of 0.86..1.1V

That sounds like the constraints are wrong actually, if 0.86V can only
be used during system suspend then it shouldn't be in the valid voltage
range - the suspend voltage doesn't need to be in the range used during
normal operation.  If we might use it during runtime suspend then it
does need to be there though.

--juKFXjvLaxOmiLZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWFf+AACgkQJNaLcl1U
h9DTWgf/fUEmRlyJxxj7iLDuRYL+wIRD8ml/KWBIrzLV0ywoeLasM4HG3AgPcOlo
gk4P9Zo3xCf2smtb/Dqal7hjM6i/DvKFNN/u4aQiVZdBA9v1LL+Qtd+ZSfs4/f49
/l8mGJn5/S9FDZroHkIaVVyJMIucUua3dLfGdFA0Wpmcufd+W6TYYCuy1nx4zF+8
d++E/GpQY6O/sZdb5McjKcN/17ylJo29NgyTRRtT6lwua+jTeDzEv0iOSEENwjUl
Wws4Vg79aFs0amAtbLjuKKPQEEgQWNcpRB2Ge52JsFT/69ol9mBeAozdCTgFbP5j
Dr3W71uo+hsk9kjSnL/ZmcjRnmjCog==
=ijuO
-----END PGP SIGNATURE-----

--juKFXjvLaxOmiLZO--

