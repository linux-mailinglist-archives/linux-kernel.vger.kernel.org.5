Return-Path: <linux-kernel+bounces-135724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4986789CA62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7749B29D35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C60143867;
	Mon,  8 Apr 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQnKFwi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B563CB;
	Mon,  8 Apr 2024 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595956; cv=none; b=cjHJylW6yxErerPOCs9N4Z2R4x0N/FcL6+TAJuq57xiBLqpadG5ebO4C7neBA8XKM2v/6pEHMgf97XtRZ+8G3uxs8C/QLfB13mBAFUh4lThqmNDEyEeuL0mi7pYoL1Om+yU7W432QpUw705ivUKXooCOtybtuAy8Gmt6twX2L2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595956; c=relaxed/simple;
	bh=N9mKisc7kUAlfuj0tQyymnxAGu/44U+CyciFpi92qvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt6kPTFwfJwHd7x0LVV6ysmXO0/4YFNkk/XxQobnCC/9bbEOisZnLrAsJH6FlpDgiwuFuKgzAxYwjzQlg4kUEjGPynA8Acb1H7kFY+fTwWNKYNWhp1eKyMInPUVT1Ssle/rZVLn7qI0nFA0Lyo3OdNkYxUnceZk2q/KZy4k7w4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQnKFwi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58149C43394;
	Mon,  8 Apr 2024 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712595956;
	bh=N9mKisc7kUAlfuj0tQyymnxAGu/44U+CyciFpi92qvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQnKFwi/w1g3wdmNyQhIpuGFLXcUmr6oVZhG5pX06fCYUXGm42RPdOs3fIkTm9FJB
	 2oWpOlmpHd61jYuTxH90FtJvYt2ZY6GnJSYtMdrmmabJopcveQ/0QGAG4VSlDOUtiH
	 LTfRD+HKuLVDiQw13H2BdUbBVReV3ZojEeh4pY9ANGnzQBH9XkXBUcU0Ai1NiAnrmK
	 S7o2O5Dmj4vZuM9KoflqlL7b2KJ0tnAzevtzQQiAX2qmJr9Lq7gvjeK6/EhbJ3OuR0
	 87+IkiYe6wLYBwKmriNOgCo8r3he9usNatFiYjMwDmDxzczxwgTS4jlARt4FgKmTPX
	 28Jy7Df7xi3vg==
Date: Mon, 8 Apr 2024 18:05:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's code
 to separate module
Message-ID: <20240408-numerator-escargot-a642507a598e@spud>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
 <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com>
 <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org>
 <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de>
 <13617b7a892424d2b024c725505a6f4f.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NSVO+VttCpAhjGMi"
Content-Disposition: inline
In-Reply-To: <13617b7a892424d2b024c725505a6f4f.sboyd@kernel.org>


--NSVO+VttCpAhjGMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 02:52:37AM -0700, Stephen Boyd wrote:
> Quoting Philipp Zabel (2024-04-08 01:21:47)
> > On So, 2024-04-07 at 19:39 -0700, Stephen Boyd wrote:
> > > Quoting Jerome Brunet (2024-04-02 07:52:38)
> > > >=20
> > > > On Thu 28 Mar 2024 at 04:08, Jan Dakinevich <jan.dakinevich@saluted=
evices.com> wrote:
> > > >=20
> > > > > This code will by reused by A1 SoC.
> > > >=20
> > > > Could expand a bit please ?
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> > > >=20
> > > > In general, I like the idea.
> > > >=20
> > > > We do have a couple a reset registers lost in middle of clocks and =
this
> > > > change makes it possible to re-use the code instead duplicating it.
> > > >=20
> > > > The exported function would be used by audio clock controllers, but=
 the
> > > > module created would be purely about reset.
> > > >=20
> > > > One may wonder how it ended up in the clock tree, especially since =
the
> > > > kernel as a reset tree too.
> > > >=20
> > > > I'm not sure if this should move to the reset framework or if it wo=
uld
> > > > be an unnecessary churn. Stephen, Philipp, do you have an opinion on
> > > > this ?
> > > >=20
> > >=20
> > > I'd prefer it be made into an auxiliary device and the driver put in
> > > drivers/reset/ so we can keep reset code in the reset directory.
> >=20
> > Seconded, the clk-mpfs/reset-mpfs and clk-starfive-jh7110-sys/reset-
> > starfive-jh7110 drivers are examples of this.
> >=20
> > > The auxiliary device creation function can also be in the
> > > drivers/reset/ directory so that the clk driver calls some function
> > > to create and register the device.
> >=20
> > I'm undecided about this, do you think mpfs_reset_controller_register()
> > and jh7110_reset_controller_register() should rather live with the
> > reset aux drivers in drivers/reset/ ?
>=20
> Yes, and also mpfs_reset_read() and friends. We should pass the base
> iomem pointer and parent device to mpfs_reset_adev_alloc() instead and
> then move all that code into drivers/reset with some header file
> exported function to call. That way the clk driver hands over the data
> without having to implement half the implementation.

I'll todo list that :)

--NSVO+VttCpAhjGMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhQj7wAKCRB4tDGHoIJi
0gFIAQD54FHoGcK4A8nGbf3dqzWlaU2n5wMolumXHO/fSI4UwwEAk8OApAyTnQ1X
FyTcLhrKypXfSlUop6vr4TG64K+fwgY=
=6FkH
-----END PGP SIGNATURE-----

--NSVO+VttCpAhjGMi--

