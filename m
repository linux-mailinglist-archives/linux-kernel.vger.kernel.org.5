Return-Path: <linux-kernel+bounces-83472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C18699E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3120C1C23081
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C601E149000;
	Tue, 27 Feb 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgLCqJl5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B0E1487EF;
	Tue, 27 Feb 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046422; cv=none; b=KGHQ4Phrgw7cjIyXxgaCLEIZVwssGKzgA9ozoGk+93rtJByD/tZDd2TBmnr81rAMCJB92erbWxibuRg3q/dS0IcDN/i53dTcAx/AwLLMLghBiKB4ODJ0FtvO8olwBgW+YaBoC1a40W5Zb/y9JP7bYkNxg4U5fhIY4ZZaoeS8Rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046422; c=relaxed/simple;
	bh=me+PaR02OqhyQDVfheZnctQBFyoYjMvRYEUCFZryMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIv3G5va8UhzNRQ+G/dWyoCYTUmhTvPa4nP4XNeCcBHO0yq+vc7VUkX/kVdKb62TXo+gUzj4pMgZvw2Ncbu9ZKUA5Kb9n83+918MaXebYMpixslmRBSsGAn1pLfopDqELLQp0Nvd+/49yKWOfM8NtvCeFjQrXH66PbEHkWS3fkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgLCqJl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE7EC433C7;
	Tue, 27 Feb 2024 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709046421;
	bh=me+PaR02OqhyQDVfheZnctQBFyoYjMvRYEUCFZryMNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgLCqJl5Tjup29jLQDrfmHzJGcqm6Vn0A8QXbh+nlYBzo2ztnaVO69jw/ROGGmueY
	 Q9CPhg0EF4DmsduPBINCvhKNEiGUEtH2sTIg7deV+MJ6/U8qYhCiUAdMgk8XbPVToj
	 9wtNHmraZWYT1fxgj94MCWn8gj21ORbqXgMnPCijB49ft1u4dQcyICfaz2g+vmNMMs
	 rZZsVNAfiQZ0jA3ObE7SKMxvTqvsNl4f5z1q0W1ZwJwQ5UCk+f8WCRJyArGfEyJdrh
	 OINmmHKU5aIdMSwoD6cUeaIBcBAd4w8YASgdaCcJMogfF+vg1YgDVX3fDIbOTvokyG
	 yiquWurwJIAEA==
Date: Tue, 27 Feb 2024 15:06:53 +0000
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
Message-ID: <4ffde184-cf68-4b71-b81d-9b5894529926@sirena.org.uk>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z6rJHLYKeV1xaopM"
Content-Disposition: inline
In-Reply-To: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
X-Cookie: Please go away.


--Z6rJHLYKeV1xaopM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 03:01:38PM +0100, Alexandre Mergnat wrote:
> This serie aim to add the following audio support for the Genio 350-evk:
> - Playback
>   - 2ch Headset Jack (Earphone)
>   - 1ch Line-out Jack (Speaker)
>   - 8ch HDMI Tx
> - Capture
>   - 1ch DMIC (On-board Digital Microphone)
>   - 1ch AMIC (On-board Analogic Microphone)
>   - 1ch Headset Jack (External Analogic Microphone)=20
>=20
> Of course, HDMI playback need the MT8365 display patches [1] and a DTS
> change documented in "mediatek,mt8365-mt6357.yaml".

Given the number of custom controls here could you please post the
output of mixer-test and pcm-test from a system with this driver running
next time you post, this will help with review since it checks a bunch
of things around the new controls.

--Z6rJHLYKeV1xaopM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd+o0ACgkQJNaLcl1U
h9D7bgf9HvLTv1/D7ibf9xpiO/7Y8mdR7blZxSERHC0VJyzegzQI6g+LO1qHYqc3
w9Kt0UwtxRgeVFwzBejVVYpZ72d9DoqN3nS4osApKoOChjapCsvasw+uqAodEk5j
he8RYvVZ5UJWO6P1D5+DkvesptWMDXHFbcoASdlGpEURjMBSLgIOZPnhsZumU0tf
AzDfDa1BwQwuIS/hg7ebHpzFlevB7SEUANSppMJ3Jp7/SbgTPt9w+/+lERnOiAh1
G86yCidp9TlgUpb92TVwFyOcdnXT13VmhCwZ/7xwye2IVNnv4CXmFgPk8C4TyNdW
s1HkIR6EuDYgEsxPOSQt7+eWhweHYg==
=/HK9
-----END PGP SIGNATURE-----

--Z6rJHLYKeV1xaopM--

