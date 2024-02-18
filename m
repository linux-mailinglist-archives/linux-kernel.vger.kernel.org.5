Return-Path: <linux-kernel+bounces-70445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9E8597EB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA02B20E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555B66EB5A;
	Sun, 18 Feb 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC+7Iss1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AF6DCEA;
	Sun, 18 Feb 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275771; cv=none; b=W/8ZSninMuriS/pfhGEQD80y9ok1GHDX32qemSL8Ne9DIquiTgY/4mg5bnlP+roCoR7Uez1q1aFK7uZdMTGKEdGy+o6576+IX+00ZcSuzgFanFy6LWAhE2PX7+Xr7QjD67I5SfWpNuFQo2QqKxZblALxGIUvkutu3eNN/IhIPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275771; c=relaxed/simple;
	bh=qWyNRiG421dAjYKLRLROwxCibjuXvtznm1WgYeNyacQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjd8GE0/CnxFVEZLlyq0w1bQ6oZXAC4IpzYIvRxUmTf4aUBAuDfFtQjWXzAfFuBUNGaTRSbnPyVGCscmbFDY7JuE1d/ur7oyZhQR/VmqNPV8tK5JN5n7ZMDYFgDEv7qmGNd+CruuMqgIc7mOmRhZj/gdqxQozeGUXZurfc45u3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC+7Iss1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5215FC433F1;
	Sun, 18 Feb 2024 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708275771;
	bh=qWyNRiG421dAjYKLRLROwxCibjuXvtznm1WgYeNyacQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qC+7Iss1WVr/u4uGeMhyAxUJ47KbW7ZzWrqCCepfOj9Oo2GRarYn0G9V1CHzoRrOT
	 XxJuCN7blczYmeYaDnkSsEN8s82n5GW4SGQ9gXzvKfG6rYbRtbwYZCv+2QJyheSWLl
	 IPdlv2Ck3ZRFplhYfoJeDPihp5wrJ6c6JUg3v0IRw0eyAC6+z/uFrybRN221zg6vob
	 Thmylje/yFGHCWDHZ47cFrmJNj3ByHz9ssbkkgiMGDGaPNKAPWtTFn6jt/rxd08YB8
	 sVvQRhT7whg+lB0DOeMOHwXtXDQbMxxW+7pM6mxIVSjA546WBKuxMN0BwdTGdEd/4d
	 7o0IDykUZ0g7g==
Date: Sun, 18 Feb 2024 17:02:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Stefan O'Rear <sorear@fastmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm
 and Ss
Message-ID: <20240218-rotunda-discover-d6d84709807e@spud>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-dangle-taco-2742f6087a3e@spud>
 <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
 <b7ad2bd4-a19e-486e-8be2-3b56f288d5d0@app.fastmail.com>
 <20240213-earflap-easing-370492840507@spud>
 <90a7443c-feca-4fbb-8c2e-fa050c0e6141@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r0a/WySfeyXRLwE+"
Content-Disposition: inline
In-Reply-To: <90a7443c-feca-4fbb-8c2e-fa050c0e6141@sifive.com>


--r0a/WySfeyXRLwE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 09:00:14AM -0600, Samuel Holland wrote:
> >>>> Or maybe we can still with the properties you have, but instead of
> >>>> treating them like any other extension, handle these separately,
> >>>> focusing on the numbering, so that only having the exact version
> >>>> supported by a cpu is possible.
> >>>
> >>> Maybe I'm misunderstanding what you're saying here, but it is already=
 the case
> >>> that the DT for a CPU would only contain the exact version of the pri=
vileged ISA
> >>> supported by that CPU.
> >>
> >> If privileged spec versions are boolean extensions, then you would say=
 "ss1p11",
> >> "ss1p12", "ss1p13" as separate/simultaneous extensions.
> >=20
> >> This is needed in order
> >> to allow simple support checks as described in the riscv,isa-extension=
s cover
> >> letter.
> >=20
> > Yes, it is explicitly a goal of riscv,isa-extensions that you can look
> > for a specific extension in the list if that is all you care about. If
> > you go and drop ss1p11 because you support ss1p12 it defeats that.
>=20
> Okay, that makes sense, but that is not how the parsing code works right =
now,
> which is probably what led me down the wrong path. :)
>=20
> To have the intended semantics, we cannot parse _anything_ in
> riscv,isa-extensions as a "bundled" or "superset" extension.

That's not true I don't think. You can parse as a "bundle" but...

> Because to
> accomplish your goal, each extension in the bundle must be listed explici=
tly, in
> case the consumer only cares about that one extension.

=2E..as you note here, the extensions also have to be listed explicitly so
that they can be detected in isolation if that is all that a consumer
does.

> So it sounds like
> riscv_fill_hwcap_from_ext_list() needs to ignore subset_ext_size/subset_e=
xt_ids.

Do you mean this:
if (ext->subset_ext_size) {
	for (int j =3D 0; j < ext->subset_ext_size; j++) {
		if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
			set_bit(ext->subset_ext_ids[j], isainfo->isa);
	}
}

I think that is fine? If you find the "superset" you can enable the
individual elements. The problem would just be if someone put only the
superset in a DT (or ACPI tables) and the software looked for the
individual element only, but IIRC the kernel currently checks both the
superset and individual elements.
It would be possible to check a bundle and then skip looking for the
individual elements if the bundle was already found if the parsing is
wont to be sped up.

I think all we need to do is enforce that all individual elements are
present on a schema validation level (I have no clue what we can do
for ACPI) and no change is required in the kernel.

Am I misunderstanding what you think is the problem here?

> > I don't know off the top of my head how to enforce ss1p12 requiring ss1=
p11
> > in json schema, but I do have an idea of where to start...
>=20
> Yeah, this is different from normal "dependencies:" because it is a strin=
g list.

I think it is actually doable, just will look sorta clunky. I meant to
go and do it this weekend, but I've been rather sick unfortunately.
Something similar is definitely doable for compatibles, so either it'll
"just work" or I may have to extend the validation tooling.

Cheers,
Conor.

--r0a/WySfeyXRLwE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdI3+gAKCRB4tDGHoIJi
0op+AQD+yswfcNC39kGvy+5LlZblpT5uVA4VMEPH51eOdf6opgEA64Aq9nCRWaUY
XrJa2JzMMscuYkn0xKBnFl5H5ed3sAs=
=oPKw
-----END PGP SIGNATURE-----

--r0a/WySfeyXRLwE+--

