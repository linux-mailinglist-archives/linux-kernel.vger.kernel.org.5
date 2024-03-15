Return-Path: <linux-kernel+bounces-104520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A607D87CF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4674CB236E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B93A1D1;
	Fri, 15 Mar 2024 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfLF0Y3A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C31CA9C;
	Fri, 15 Mar 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513525; cv=none; b=bOXexNR1JbkyVzypQO4b02OIVLiVxMLj+Xx16gInpgSFOxoN9ZP7R5SCq8DaKemxtfHduyW22s8z+kadIBIcttmibWB0A4gKfdeFfr4P3GLtQgtXzSY4TtYgs5nrP8R6VFiPVKhQ0Yx7vj0ZPiyFKbdq/Y+IQrhLH6jd5ydleP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513525; c=relaxed/simple;
	bh=LWOPGxaWjPP8E3hvpb0v/9QUSjPMu3aHfXD/4e34bMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpcFp2rHkB65tXt1Mv34ewvyFxRr9QarR6tZRuKfDMvjWOZimwINXu9Al0stEifl2PxTtLes24JYOHimnka3+ukeLxCE0x5KTnUd9efr91zKoXfcFpSEZUxA6iTj2bsnlTpnmJd0slgX84koxkfxLCflVU0/ldcP0RJbIcaQ7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfLF0Y3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37258C433C7;
	Fri, 15 Mar 2024 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513524;
	bh=LWOPGxaWjPP8E3hvpb0v/9QUSjPMu3aHfXD/4e34bMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfLF0Y3Aw17VSoUcFU9nXUe7DJBTJnsvXRSp5JM2LcK8rgXc6Uqcotv7Rmcu/5y0r
	 /k6jI4bvcl7jt+qndKxRPxKCuZU89MT7ts52FJGGSvHCZWLkGEMpmCxiaerdnhxlP4
	 eca3MDnsqT6qnrh/36IIbVKpEABMWOLcMD840rxSlrl3WJKTxBSuQiGU2islj0xuUz
	 VXPkRyigmU8/GmAk0LgZFCWSwIVB7rmY+yJiXtDISqyjOeYDHvGXasd3yu4D+lLUKl
	 bbYt5HZZ/xwVfB+zMv4jDhP1WyyDmY5pb+X7Fmh9+K/LpfAq+PwR3Wf4s4A1UU0UjJ
	 J5HVGG/SCVpew==
Date: Fri, 15 Mar 2024 14:38:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nicolas Belin <nbelin@baylibre.com>,
	Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 00/18] Add audio support for the MediaTek Genio 350-evk
 board
Message-ID: <bf418207-7f13-4ced-8c21-2824dd07fab5@sirena.org.uk>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <4ffde184-cf68-4b71-b81d-9b5894529926@sirena.org.uk>
 <7ddad394-e880-4ef8-8591-cb803a2086ae@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y91BRilVEGdxtZCJ"
Content-Disposition: inline
In-Reply-To: <7ddad394-e880-4ef8-8591-cb803a2086ae@baylibre.com>
X-Cookie: If rash develops, discontinue use.


--Y91BRilVEGdxtZCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 09:58:05AM +0100, Alexandre Mergnat wrote:

> I'm a bit lost for mixer-test and pcm-test.
> Currently, I cross-compile the alsa lib project to be able to build the
> tests and put it on my board.

> I can execute it, but I still have 2 issues:

> 1) I've a lot of missing module in my environment (Encode.so, Encode.pm,
> Symbol.pm, IO/Handle.pm, ...). AFAII, I've to cross compile the missing perl
> modules and install them in the rootfs

These tests are both simple C programs...

> 2) I don't know how to configure pcm-test.conf &
> Lenovo_ThinkPad_P1_Gen2.conf (or new file to match with my board).

The configuration is optional.

> My test cmd:
> ./run_kselftest.sh -c alsa

Just run the programs directly.  I'm only asking for the output from two
of them anyway.

--Y91BRilVEGdxtZCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0XWwACgkQJNaLcl1U
h9BnLAf/e1vJ3Zr2d9fJBV1LV7sal34lcNVLD3JRrMKuk6bdnA2S2RYAgOf0UJwl
cRuGTcq2lBneNaYnb9jgaf1C7i5kuXvnMG0IJuqVBrTZwiN5SbGhpmdvZj6HLwPu
a8Q5MEwz/DrIXqjghxcXr5bjKi6XJ/9RRB1QpfxQFIwAOYQPNAG2F0j4SrD8zcbA
O2dO4KRIjYUBBnpP5maQh3R3yr+TEEdolkib2FyoHL2jo2Vv1zOiTK2382kuTnKA
y+GgUm8tQ4HiGZdAJqZAPh+Of86A9Rwl2133Tp1dxkFWlOamtyhfYbPESyNchUrV
qduBr5NQ0tnTuAoEKttdYckFHYq6Bg==
=FScF
-----END PGP SIGNATURE-----

--Y91BRilVEGdxtZCJ--

