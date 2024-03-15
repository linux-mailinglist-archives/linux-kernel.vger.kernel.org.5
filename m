Return-Path: <linux-kernel+bounces-104513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58A87CEF4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A5028436F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52141481DE;
	Fri, 15 Mar 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGoVIVh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FA04654E;
	Fri, 15 Mar 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513012; cv=none; b=cpVH86hydWdJ4Qzpoq98V6cuN56v29ytcRJbXje4FqW1AhjdMmFg5Gkfmv9HWDA+sLKD0JIesMoYA5ZoOvsrxhLplWZIvwvEhjMlLqLIdcmVsGKRIAwhhikJwKnH9lv4MUocuhr7whCFLKXKxSkIEgaz9N2VYQuXEK1OPQTVE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513012; c=relaxed/simple;
	bh=y9UTrQR60pzrt4WbzQGYuGVl4ayHy9bpcn+b1iICLzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR9sVnvUujKClsb4V7dv/waop4p4//JjtRvBkhblkYEnM8FGEh0EZ6hanhYz5u5U5XWzQu7iw9JYPN+LpRH3RHBRmyNtmZUIqm+MawkhRroa4+d36EoXgSebrUOZwStbVAfv5DgJK6QiX1OD1KRmxcmOVU9EsRWnqMMrG30qiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGoVIVh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094F5C433F1;
	Fri, 15 Mar 2024 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513012;
	bh=y9UTrQR60pzrt4WbzQGYuGVl4ayHy9bpcn+b1iICLzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGoVIVh0xKRjHYfUEkZgVdUX4aDhwpU4ARn/sMVBEI1COT2p7VK3grcrtYC4rTTjJ
	 ufBJJQYQ6fgBenIL7SI5Vtyg+3H6cblDWDmW/KjsYbU92qjg0vuLKDdgHEqabV3fqZ
	 QubJ4yaoz7eJ1YEnlTsz6HB7evsn2U31Qv5q3FLzFNJyCd8UDg9nclG+ZRnBnmQ5iV
	 XypU7z9D2SLN6njnByNBVNOgwth6Korsr2Zz/bfQuEL8b9G6O6d1Gf7hOFk61HFFH1
	 wY37D4Gq8RO5xPn/7OMApVE+XjQSIigrDkQZbIrErOAO1yhsQUS16ir+kCudsiDvZC
	 fcwNBMRsCKuCw==
Date: Fri, 15 Mar 2024 14:30:02 +0000
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
	Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH 12/18] ASoC: codecs: mt6357: add MT6357 codec
Message-ID: <0d31ffb2-9df5-4c3e-a728-902b71a1a713@sirena.org.uk>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
 <c441a132-b16b-4244-a712-8971c902d4d7@baylibre.com>
 <ff3d2db1-697b-42c6-a0f2-74276e9fc098@sirena.org.uk>
 <dda0e6ba-4538-47a0-95e9-6adcfd4169a7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K7ZVz5OiwuIdg9jd"
Content-Disposition: inline
In-Reply-To: <dda0e6ba-4538-47a0-95e9-6adcfd4169a7@baylibre.com>
X-Cookie: A well-known friend is a treasure.


--K7ZVz5OiwuIdg9jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 12:01:12PM +0100, Alexandre Mergnat wrote:
> On 13/03/2024 18:23, Mark Brown wrote:
> > On Tue, Mar 12, 2024 at 07:03:25PM +0100, Alexandre Mergnat wrote:

> > > Actually you must save the values because the gain selected by the user will
> > > be override to do a ramp => volume_ramp(.....):
> > > - When you switch on the HP, you start from gain=-40db to final_gain
> > > (selected by user).
> > > - When you switch off the HP, you start from final_gain (selected by user)
> > > to gain=-40db.

> > You can just read the value back when you need to do a ramp?

> You can't. Because you will read -40db when HP isn't playing sound. That is
> why the gain is saved into the struct.

> Let me know, when you change de gain to do a ramp down (start from user gain
> to gain=-40db), next time for the ramp up, how/where do you find the user
> gain ?

In the register.  You only need to reset the gain to -40dB at the start
of the ramp.

> > > Also, the microphone's gain change when it's enabled/disabled.

> > I don't understand what this means?

> When microphone isn't capturing, the gain read back from the register is
> 0dB. I've put some logs in my code and do capture to show how it works:

Is this a property of the hardware or a property of your driver?

> > > > > +	/* ul channel swap */
> > > > > +	SOC_SINGLE("UL LR Swap", MT6357_AFE_UL_DL_CON0, AFE_UL_LR_SWAP_SFT, 1, 0),

> > > > On/off controls should end in Switch.

> > > Sorry, I don't understand your comment. Can you reword it please ?

> > See control-names.rst.  Run mixer-test on a card with this driver and
> > fix all the issues it reports.

> Ok the name is the issue for you AFAII.
> This control isn't for on/off but swap Left and Right.
> From the codec documentation:
> "Swaps audio UL L/R channel before UL SRC"
> This control is overkill, I will remove it

This is turning the swapping on and off.

--K7ZVz5OiwuIdg9jd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0W2oACgkQJNaLcl1U
h9Crogf9HxYF3MaL/A3dUDm+Alxsez+w+9hdE05vA2xnAX7B+y66KyZ57bCm9SK1
IfemHS3DsYz5DdY34Hgti1XBNCkxr4eo+QuYp5LlAht11IR9r2kxbjI9GOgW9KQt
9b79rtSUodUf75NWoUdTJdR3XUeZaPfpNyY2JAYAKtb/NYF7wZ+2qY4H0Ghh9qQL
zNno8ER/qk2DHIlyp8Io/7INq46g9k/XLKciK1nNFvwDhilREphfN6W7q/WD+9Dq
b91sqdSD7ssMFD0b/KEMDBV7AoIiQv+2OaVSUB1SrD1N2E1GZiEFdpASy0ehuSOc
/RK5R2ZA3NuKgt42DmLEW1b+Gn9Zlw==
=TlBs
-----END PGP SIGNATURE-----

--K7ZVz5OiwuIdg9jd--

