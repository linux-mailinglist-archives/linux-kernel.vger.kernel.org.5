Return-Path: <linux-kernel+bounces-33820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA51836EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E91C2965E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C3657C7;
	Mon, 22 Jan 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMJTWOsG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBB46B99;
	Mon, 22 Jan 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944541; cv=none; b=vFN2kjXvT/lAm7BSGdmzv7afn+LwiRH1rL6RkV8DHPgt6BjDoGipIA3Jt74f7fFNRSDaC+0x71Gabl3QPnSZPC5eVer1T/rVilgLRYpwJPcxNGY0EicFDOCn6J3UvoJgrbhwQofpcVdUUp2KI7We4KTIQcryRn0XCt4X9Zj68Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944541; c=relaxed/simple;
	bh=6FeAIXLL4BMXxP3NQlpVvmV8ek7N+/33fe5B2RSSNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLEc/Hnw+hGbkgvfmKgxDroTfUcqXyrDgbgZg9gYUHVeoa3FZr2GcSwVm+YtMdzYHKMMrSgxD9RYP82fNai2Pdg6oRQLgRh6ECIJLSI7efle/V2wUVdeuWr/Kx36a7xwPw2jvc5fW3q39GwRspbLiWkIYYQqJULgGH+ze22qgA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMJTWOsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADACC43390;
	Mon, 22 Jan 2024 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705944540;
	bh=6FeAIXLL4BMXxP3NQlpVvmV8ek7N+/33fe5B2RSSNM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMJTWOsGivJR62sg5NtIpQ4+SkzwUTtajCJivqs3X5LFdwl1WJMKpC9/sPpycZ7RE
	 EMVL/5OB5lQHH2qXPZWRHyt9Z2IgGJB+gWzhEEVTd/XAC83KWiS45P087CIHvjBXMx
	 doyKBdZB9FWdUx53efJBAi/UpMov+/tW9Ysm4o9ZRzOsENuhC3PuDGm7MKF/9BeY4j
	 PnaV01wZHf/fxQLG5NQIEpUKVoNRzb1jarK1IBUSJsljfjam5k7Xcda5G/vWeCPvE8
	 sSwuyaHTRs/FpHfSkZte7dAYMmW7pAXzevefBWDpXkGwnu6igaTC0TyUN8yjFcVLB/
	 cMAsPztStzxaA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rRy6i-000000000rG-2U1d;
	Mon, 22 Jan 2024 18:29:12 +0100
Date: Mon, 22 Jan 2024 18:29:12 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <Za6l6EP7OqXPU9mj@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
 <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
 <Za4cR90XoAaATq8X@hovoldconsulting.com>
 <aca2b125-acf8-4791-a3eb-ea19826d3ee4@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zuPb1ptY6OeW5Twe"
Content-Disposition: inline
In-Reply-To: <aca2b125-acf8-4791-a3eb-ea19826d3ee4@sirena.org.uk>


--zuPb1ptY6OeW5Twe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:05:37PM +0000, Mark Brown wrote:
> On Mon, Jan 22, 2024 at 08:41:59AM +0100, Johan Hovold wrote:
> > On Mon, Jan 22, 2024 at 12:03:55AM +0000, Mark Brown wrote:
>=20
> > > This doesn't apply against current code, please check and resend.
>=20
> > These patches are based on Linus's tree after merging the sound updates
> > and I just verified that they apply cleanly to 6.8-rc1.
>=20
> > I couldn't find anything related in either linux-next or your ASoC tree
> > that should interfere.
>=20
> > Could you please try again or let me know which branch to rebase on?
>=20
> I was applying it against v6.8-rc1.

That's what I assumed, but I still don't understand why it doesn't apply
on your end:

	$ git checkout -b tmp v6.8-rc1
	$ b4 am 20240119112420.7446-1-johan+linaro@kernel.org
	...
 	$ git am ./v4_20240119_johan_linaro_asoc_qcom_volume_fixes_and_codec_clea=
nups.mbx
	Applying: ASoC: codecs: wsa883x: fix PA volume control
	Applying: ASoC: qcom: sc8280xp: limit speaker volumes
	Applying: ASoC: codecs: lpass-wsa-macro: fix compander volume hack
	Applying: ASoC: codecs: wcd9335: drop unused gain hack remnant

And if I generate patches from this branch, the diffs are identical to
the v4 patches I sent.

Could you please try again, and tell me which patch fails to apply and
how it fails?

Johan

--zuPb1ptY6OeW5Twe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZa6l5AAKCRALxc3C7H1l
CDS1AP9v09QUe0W/JBDJqz8b7Z8aLnAKxR6EToN186tpJEhmQQD/ZITVhd2YTnO0
WgezFd6GQaMqTSjOQhoI/Zrt8Qu8Vw8=
=IyN/
-----END PGP SIGNATURE-----

--zuPb1ptY6OeW5Twe--

