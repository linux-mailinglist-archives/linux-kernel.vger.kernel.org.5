Return-Path: <linux-kernel+bounces-48681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39538845FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA74728E564
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B212FB21;
	Thu,  1 Feb 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3VdfipO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8373674297;
	Thu,  1 Feb 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811620; cv=none; b=qvIUv8jpDiWDPBp+z2bYdB+Ws9nuJKGjtSMMqRJASdz6OmCyNKEW0gOBY85ybgV5u0wo7cnyYhA3J2Ya7MoNkm6cnsxPzuBZyp9ieZUTyiEugPEa2sKukscBREPGcyHN5qnbvegVKZEUJzmeA7FKwUQXOy5LAyeJxwnj0p2CmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811620; c=relaxed/simple;
	bh=hPlLDcArSF1cBikO4rFTlnRitwqEi0aGbatvchQYh/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biu+m8mUXBEfAIFkiBY1iOnaoGc2XlHWxBhutFUv0q2+qvVXhyA8gXyjNiGTY/Z7fvlMug3YjXF7BVRtn+tQhMPTEivDLqBNcypOWuGhdLHu7siYUKX9nD56UAzJeY4DfrvohpYWrB8TuCIfhINcuvFPH9Hrzf9lgZD1Glz4g0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3VdfipO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75700C433F1;
	Thu,  1 Feb 2024 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811619;
	bh=hPlLDcArSF1cBikO4rFTlnRitwqEi0aGbatvchQYh/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3VdfipOeSEOruQUNgkJ5igtoy9AihiH0Mmm8DX8nTYaEmEEAWEuJcAxlzC42rjxx
	 hDU5Oanbc112HkwOM7gmMxyEsVNZS14RtqJ8LWx+ezMoSZT61ESQHfDoOwuSuC8pzn
	 NKyJ8HCEBRpk8uijKMuApf7/Z6Lum3LE4eEcgpVj8Gpw/lPHn+eBO/qf5b68lPdTOF
	 EHE0RalG/5HjrfQS0bH4gWJCUE++eg9T0hYYHFDCrKGH/bBfafXShd9YVjKgp0cwgA
	 kKsNg0QK4updSpPjtzmGxj5jgBc8+QOCuzp68E06AXd3rhLobvNkxNK/p7KLlUQQcy
	 CY1KJgASLARTw==
Date: Thu, 1 Feb 2024 18:20:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <linux@fw-web.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: Aw: Re:  Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add
 MT7988 reset IDs
Message-ID: <20240201-gutless-rising-692b7fa45f65@spud>
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
 <20240118-calcium-krypton-3c787b8d1912@spud>
 <trinity-afc4f48e-65e1-46ee-a78b-1d670cc0f310-1705615200900@3c-app-gmx-bap21>
 <43f946cc-07e1-48c5-9b31-40fc9bc93037@collabora.com>
 <20240119-dupe-obligate-707b3a01b356@spud>
 <0EA6A126-DDC0-4E9F-BEBC-FD018B08CA84@public-files.de>
 <20240201-goes-passable-0ba841d36bc3@wendy>
 <trinity-2aef55db-42e0-4f58-9c43-696311a96eb8-1706797383340@3c-app-gmx-bap28>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W2Ee5I31/3TVyJ4S"
Content-Disposition: inline
In-Reply-To: <trinity-2aef55db-42e0-4f58-9c43-696311a96eb8-1706797383340@3c-app-gmx-bap28>


--W2Ee5I31/3TVyJ4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 03:23:03PM +0100, Frank Wunderlich wrote:
> > Gesendet: Donnerstag, 01. Februar 2024 um 14:11 Uhr
> > Von: "Conor Dooley" <conor.dooley@microchip.com>
> > I suspect I was asking for a commit message that explains why these
> > numbers don't continue in sequence. With that,
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Cheers,
> > Conor.
>=20
> OK, i would add this to commit message:
>=20
> "Value is starting again from 0 because resets are used in another driver
> than existing constants."

s/driver/device/ and sure.

--W2Ee5I31/3TVyJ4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvg3gAKCRB4tDGHoIJi
0neOAP41G78/o62ed4G9kWo32xu5055qvUh0jEZVW3ivqp4iXwD/dXNffyuUL2Et
q3Abdf9njDBMF+vEwjQbZoOQo11BgAs=
=3tdX
-----END PGP SIGNATURE-----

--W2Ee5I31/3TVyJ4S--

