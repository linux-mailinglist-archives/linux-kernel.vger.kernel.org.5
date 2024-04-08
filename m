Return-Path: <linux-kernel+bounces-135835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D489CBE7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A5F1C20C27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39973143C4A;
	Mon,  8 Apr 2024 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YruXFHCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA35B04F;
	Mon,  8 Apr 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601908; cv=none; b=Nb7SQkeyBh7iHYbLtH13vvETOsoeqOfseAkqjPboT4ZzOa3JLF63iciOFSCPlWXOecOW1rZKN+ggzbqPmlfwVTo0pHsztsRVj40guCSLlPteZW1i55nqM+xe0AJ0Z7scQR6BLfzSBe/IkXh8OIpP8cKY08Zv5EugWui1tw+rW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601908; c=relaxed/simple;
	bh=35TiYD0o4V5XmB7Kubpn4Ak35k4hMXKysdwn6S4+n8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g26DpcokJ4933RQlCnAViQt0PAjywuvQkoIGHWxhlR2HY+a3EFWt0Oc0tL2yR4bYtcHt7mBR/ExxiCDXs2JPDn6dKZ0SnQWGjLY/O3JVajVpwP+p0C/50L5WoQG2EmJkhZKsY9SIZ8RDycQbaonLUylSiNNR7urTwUmgUycHOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YruXFHCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C936FC433C7;
	Mon,  8 Apr 2024 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712601908;
	bh=35TiYD0o4V5XmB7Kubpn4Ak35k4hMXKysdwn6S4+n8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YruXFHCGCe2L9NFXzofTdJeeYgSkoxt+klwsjqc+56eAPpBAjWLxYY2u8YV3z/ayo
	 J4HtKbF0zpRwe100lWIEVQmyUOudQlRNn3iR1vA6JIRzaYUUUvSiGzX1zMZPJeJTYt
	 qp3obg1qWikrI+HA15p51x84U91OXz6iVTs7+kcELzN3+r18N7049kTcxhz9C0tWRP
	 tAvW2sVGBK0CwOQynH3Hug9bDmGH2w64gh72PuRyxBZC6MhWgHqx5yQbztQJ7WRSUV
	 bpJM2OYcfW0YXxs3u/di2LNbRpruZfYEpN6Dm3YeCL2oFAywgAQ9ppG/DTL72ujx6m
	 HRQJ6rP4yJPrA==
Date: Mon, 8 Apr 2024 19:45:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org,
	lgirdwood@gmail.com, conor+dt@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
	khilman@baylibre.com, martin.blumenstingl@googlemail.com,
	kernel@salutedevices.com, rockosov@gmail.com,
	linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/2] ASoC: meson: implement link-name optional
 property in meson card utils
Message-ID: <51b39153-d1a4-4e7f-9b30-8c77fc4ee46f@sirena.org.uk>
References: <20240408164947.30717-1-ddrokosov@salutedevices.com>
 <20240408164947.30717-3-ddrokosov@salutedevices.com>
 <1j1q7fpv1n.fsf@starbuckisacylon.baylibre.com>
 <20240408184041.3jcav5tabxiblpn4@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HMiKwoGIkQvD3cpD"
Content-Disposition: inline
In-Reply-To: <20240408184041.3jcav5tabxiblpn4@CAB-WSD-L081021>
X-Cookie: Drive defensively.  Buy a tank.


--HMiKwoGIkQvD3cpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 08, 2024 at 09:40:41PM +0300, Dmitry Rokosov wrote:
> On Mon, Apr 08, 2024 at 08:15:54PM +0200, Jerome Brunet wrote:

> > Userspace pcm, otherwise known as DPCM frontend, are merely that:
> > frontends. What they do is entirely defined by the routing defined by
> > the userspace (amixer and friends)

> > So naming the interface in DT (the FW describing the HW) after what the
> > the userspace SW could possibly set later on is wrong.

> > Bottom line: I have mixed feeling about this change. It could allow all
> > sort of bad names to be set.

> > The only way it could make sense HW wise is if the only allowed names
> > where (fr|to)ddr_[abcd], which could help maps the interface and the
> > kcontrol.

> The link-name is an optional parameter. Yes, you are right, it can be
> routed in a way that it no longer functions as a speaker in most cases.
> However, if you plan to use your board's dt for common purposes, you
> should not change the common names for DAI links. But if you know that
> you have a static setup for speakers, microphones, loopback, or other
> references (you 100% know it, because you are HW developer of this
> board), why not help the user understand the PCM device assignment in
> the easiest way?

I would expect that the place to fix names based on the userspace
configuration is in whatever userspace is using to define it's
configurations, like a UCM config.

> Ultimately, it is the responsibility of the DT board developer to define
> specific DAIs and name them based on their own knowledge about HW and
> understanding of the board's usage purposes.

DT seems like the wrong abstraction layer here.

--HMiKwoGIkQvD3cpD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYUOywACgkQJNaLcl1U
h9CJAAf+NxTZb3cXYXbGTve/uEzcktraeaWPmfFUvb/1M7/+tCcBBz0yT9v7uXI4
C9xy3I9MIztGRHi9jO6p25fZLtP+ln+t7E0M5/ZZwq9Q05hriYlM6ymQPmaXkSB7
9T7DiddU6mESy1rS2BUxYYYJTBNEmDmFmjq2XA0bn3Mg/FfRVkfDdsZ3uXl5SHIi
UYkeAdeNkOtHqg64KTPIVZcfAYm12yUtZT4z86mWQ1CH+rb/EpuPTkzKwaq/QKhH
XAwPgTdo2kjLEj136u6vQ0blmTxYjaNsh8u+FbIKIc6AYtWAFfh+UXox9D36Tdlu
71tgaf6AzlkMjR4U+gGfe99OK8NETg==
=7H+m
-----END PGP SIGNATURE-----

--HMiKwoGIkQvD3cpD--

