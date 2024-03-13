Return-Path: <linux-kernel+bounces-102260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05F87AFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76375289E86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FC629E6;
	Wed, 13 Mar 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4QWTDLS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4826280B;
	Wed, 13 Mar 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350671; cv=none; b=N0DY0lvt8HhNSfI7mfR/yZ/QdjORlacLZ5at2VktSJEo198kxrRiEF7LiBTkk50WEHpGMgdRFYGq6n7kKVKd7KtLsW2VPDDK6L6CLnAlqxxFzp7kDbBC+AkzdGnOJZhcGxQ3MCKM+eOl7+E4+LN626bLfo9ya6pkzUJqsvwvZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350671; c=relaxed/simple;
	bh=0G6tQ6qb1wy4fRsOONK7qWXg2LzQwXihYTJ0PSj1DRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucJr34oyOjpdeygpQKm5Hkpo82yvd8UhIWhhq7BG8cFYF+OYZwdE7guHr25S4RCgmQ5IbbpxTWtNzbij4NhAsQD8FMvzPVUx9aoCYfX2iZusYyMQmlPTX72Pgse1FeXvLmdgMc+jC5J09ohB6DPMGTRwyMxgvY8t7A2ZRQxFIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4QWTDLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68B9C433C7;
	Wed, 13 Mar 2024 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710350670;
	bh=0G6tQ6qb1wy4fRsOONK7qWXg2LzQwXihYTJ0PSj1DRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4QWTDLStOQw4Goek0IKIpEdeUGflrD6+Ri9QAQ2sG2QdJWl50JmaF48yg2y4GUU8
	 a5hlJmNEKLjSQ8eISp9Pt7Qe71uB/WBHh/mz8rlP8NbTdA0BExiLykWkzPriuBuHC5
	 N6welpQ79LSTFw+yy/99QS8iG2tIfT5FVkkfVEYSaAH9rw16kknZeW3PXfdvMcCXY3
	 WcLxnJaleA2GDiUycERB+HA/spu9dw3DryEPtizlnV+GqhxGET6yz7r/EFUmTrYRV+
	 yzfJLVs1jAornCo+Rn9Bf4BfgUuvCtqArlWCgADoAPQCIruW8/8XwuYZUOmKb+nJAH
	 qW9NuL0kb39eQ==
Date: Wed, 13 Mar 2024 17:24:22 +0000
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
Message-ID: <594cff80-9cd8-45cc-939b-532f9402940c@sirena.org.uk>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <9891855d-2284-42e4-9d3a-35ba406540e8@sirena.org.uk>
 <ef4da1f6-d3c5-4484-8df5-1a04df4453a0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n0CJkGczErMrH2GD"
Content-Disposition: inline
In-Reply-To: <ef4da1f6-d3c5-4484-8df5-1a04df4453a0@baylibre.com>
X-Cookie: It's later than you think.


--n0CJkGczErMrH2GD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2024 at 06:11:50PM +0100, Alexandre Mergnat wrote:
> On 26/02/2024 17:09, Mark Brown wrote:
> > > index 000000000000..13e95c227114
> > > --- /dev/null
> > > +++ b/sound/soc/codecs/mt6357.c
> > > @@ -0,0 +1,1805 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * MT6357 ALSA SoC audio codec driver

> > Please use a C++ comment for the whole comment to make it clearer that
> > this is intentional.

> If I do that, the checkpatch raise a warning:

> WARNING: Improper SPDX comment style for
> 'sound/soc/mediatek/mt8365/mt8365-afe-clk.c', please use '//' instead
> #22: FILE: sound/soc/mediatek/mt8365/mt8365-afe-clk.c:1:
> +/* SPDX-License-Identifier: GPL-2.0

That's not a C++ comment so checkpatch is correctly warning?

--n0CJkGczErMrH2GD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXx4UYACgkQJNaLcl1U
h9CP8Af+KlLX2plI/F5rZJ9p1uJukH33qkBAEGAHtzF9F3uGHLiua+/rxebEzeC1
ZzIbUyRn+EDtKLerG/GM9tMrlGZgdnENt4T7jnE3Hw0hU+aQJ0IUtB6WnRpyjsON
MFroY93dAi8Yyn1mt0uFzgYEIbBje/+TBiUxqyVzrzIWq1OH/OBN4NmNqPVv3H2p
QttacOYxX77On2LGDbnqRcfv30n8mvJgrYBwy9OsvutAJ8nllaYgzQDrME0N9JpY
0lWOXhg99Mcmx0/SGmfuaNISBhwlwWvcKQ0Iq20Q+AiguyJmPt+kpNTm4Eh7kh+7
9KdkRUEMFfJezI6fB13+outzifLipg==
=yFuP
-----END PGP SIGNATURE-----

--n0CJkGczErMrH2GD--

