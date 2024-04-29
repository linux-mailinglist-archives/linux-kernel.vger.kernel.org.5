Return-Path: <linux-kernel+bounces-162468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728F8B5BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C121C211BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299E7F487;
	Mon, 29 Apr 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un7qa4q1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0A745C5;
	Mon, 29 Apr 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401854; cv=none; b=Ap5SmytI9+2VlB77C+By00g0qmp9nq24SrLmKdFO9tqn6vRFPmMUOLEyPnnGZ/bujBcDsPkRG9WR41AdnG8yReBQ5yvJawmMz1qwNDO4iEGz6wou65M9vTUVYz14rtKS+/B+XuXXk+YyNOjJLrlJ+JC8dTPzIUk/uzBZ2GTH300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401854; c=relaxed/simple;
	bh=OJZ8QasGzmijXQVkG9V9fKJa/f1XqrNRU4PDTZrp2Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enLhwMWtDh2OI2tSJaW+skMgVDmrWMlrWMcvIc2rMH+YEtugHojo3N+hDDCHg02H/A5dabnAU0Yp0F/cJIG1vSnH8LNsf8wz+NQB0UcRHeHqgaaZQXoGik9kZ0tXxlh2gdfn96J+A36+TEND2v7/oPeDxAdhcJv6IB50JBdwrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un7qa4q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331BFC113CD;
	Mon, 29 Apr 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401853;
	bh=OJZ8QasGzmijXQVkG9V9fKJa/f1XqrNRU4PDTZrp2Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un7qa4q1crb9OyUCdLgWWFuWgrAJiyu10NlOIPbgqHlSAu5OabyJzuympIYoUdPs6
	 ZOpE/xD0zuKphaxaryHG5bX1bslKr9WWvdK7Qpo3CePYkL5edQ6vIMaDCCeuKMaJdG
	 Unr+BrxRThdxZ9xwq3c70enLrL+2Z6xLcLI/4VOVQ39KBlwa/j7No45GvCubpp0ET3
	 0JFK/No4MqUSECJUFjAqu4Ok8TM2rPhxD3StLSH56Ij34VDbWB68a5+JgJWsQcdk6l
	 tP21IlUe9bKrXVI6yJuibFAAzun3HDtIbtNAN9RGOUgLXlMeq2k7kEvKuOPQI3i4QZ
	 T5cyBQycWYnnQ==
Date: Mon, 29 Apr 2024 23:44:11 +0900
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
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 05/16] SoC: mediatek: mt8365: support audio clock
 control
Message-ID: <Zi-yOzFhgKQXx9tk@finisterre.sirena.org.uk>
References: <20240226-audio-i350-v4-0-082b22186d4c@baylibre.com>
 <20240226-audio-i350-v4-5-082b22186d4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LT6g6VETYU3X2f5e"
Content-Disposition: inline
In-Reply-To: <20240226-audio-i350-v4-5-082b22186d4c@baylibre.com>
X-Cookie: TANSTAAFL


--LT6g6VETYU3X2f5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2024 at 07:22:34PM +0200, Alexandre Mergnat wrote:
> Add audio clock wrapper and audio tuner control.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--LT6g6VETYU3X2f5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvsjoACgkQJNaLcl1U
h9CAlAf7BkKtB98FNb4ZDCugUcYlYByugcjzPafZiPbUVpmYfmvJYoiOrSDEXePb
NRZWBGpWUDpa1l+TOGWwcOQegbbwV48nDMyJnQn+CXRUvUg0dePpRmUSLsXCwB0+
X6Z+EJ9hoQ3OrqBmt1mTld6Uk5GoZWkhoJ+OcEKXoLtQJcfUUL8uCqjciW9ySs+g
ibgnMTOqccfOfUoZNYTGIKKYypfUnQHFcKV5Lk03UtWeatQXk5SUe131QsK2w5xB
8uFXF4PuB9RiX0OQEtKgENtVVwajA3M6z3euJ2RkXwqtR+klGzgUJFFnJKjJQmye
wr8Eom+wgxxY7GyPGD3aRCnBuFDyHg==
=ccn2
-----END PGP SIGNATURE-----

--LT6g6VETYU3X2f5e--

