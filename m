Return-Path: <linux-kernel+bounces-145585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A28A581F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867781C22266
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDE82869;
	Mon, 15 Apr 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkq37PVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAC8062B;
	Mon, 15 Apr 2024 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199764; cv=none; b=rhrAYHP83G0aRn3Z+m/ps7hNFt+bK4Z+Cmz/vGlc9UrWD82oKJSptntj8UZfgBh33VNfdtviefiMbdnK4TIGtiMC5tnf4d0ndcJdfiwYFYd/ho0cvrCxWkOIFZrVPCjET4jjcUuwnWVlIXAK4I7o1cVMTVRbhiYQL54TCV1APgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199764; c=relaxed/simple;
	bh=RYfH+7ZQ4l/9ir2s0AEiPjXAp7Fgy5zVdlnNIhbS92Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiDoJbsDGEfszmeWGyc8qo1DV0TKjYlPDkFv4imCICplXS4KY2E3iwfgQBc9ohm+IxQrMvXvjgDs39iGrhnY/cr2m1q2JuQzpIsef+e0DURRi/PILJjC7lXkzDSpv73KrYGXS87ucsF2m/3+FpeoYJWVM1bl03nunMZ43aaKyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkq37PVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178CCC113CC;
	Mon, 15 Apr 2024 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713199763;
	bh=RYfH+7ZQ4l/9ir2s0AEiPjXAp7Fgy5zVdlnNIhbS92Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkq37PVTha1wyuQ8mceDo7VTFsmsrTSje0u2cTa2sRZDSuf33u8kaLFuyn1bx4Wpg
	 pnuJ4f+mN3naVtbvRd/iiaaN6re72FK338JeFhBb9Ztn8uwSHmCNS/OQ3Q21g8s0o8
	 pMtCfndf8GvB3LcEA6Qay9m2utxPbNnTNfd116BCDWjk0wBW7kieoLWsl9mQbOiVyt
	 0jKGRs+5gsvAaIe0iQ6mE4BbovTIflhEQ31uAp+93ZOn1CatAPw3N7ytcMHUMpkDtE
	 PHciRv4Qk7MQ0tx7EomBy0AvLcp8oQpFCO20h7L+GrAKWpxAkiQrZdaFQQ94T5TXRb
	 bpaAv94r0yomA==
Date: Mon, 15 Apr 2024 17:49:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/2] media: =?utf-8?Q?dt-bin?=
 =?utf-8?Q?ding=3A_media=3A_Document_rk3588=E2=80=99s?= VEPU121
Message-ID: <20240415-spearhead-brunch-147840bf414d@spud>
References: <20240412151515.837824-1-linkmauve@linkmauve.fr>
 <20240412151515.837824-2-linkmauve@linkmauve.fr>
 <d0839eec-7a92-4834-b47a-be0ba1908c1a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x+2TvZJhub2l4MoK"
Content-Disposition: inline
In-Reply-To: <d0839eec-7a92-4834-b47a-be0ba1908c1a@linaro.org>


--x+2TvZJhub2l4MoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 11:22:51PM +0200, Krzysztof Kozlowski wrote:
> On 12/04/2024 17:15, Emmanuel Gil Peyrot wrote:
> > This encoder-only device is present four times on this SoC, and should
> > support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> > encoding).
> >=20
> > According to the TRM[1], there is also the VEPU580 encoder which
> > supports H.264 and H.265, and various VDPU* decoders, of which only the
> > VDPU981 is currently supported.  This patch describes only the VEPU121.
> >=20
> > [1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet
> >=20
> > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
>=20
> So you ignored all the tags? No one will pick up your patch if you are
> going to keep ignoring them...

If Nicolas's concern about breakage due to exposing multiple video
devices was addressed:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--x+2TvZJhub2l4MoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1ajAAKCRB4tDGHoIJi
0uWHAP0V4L26Wkt/mEwBdE+9v4pr7VmPuKSeVQT0+VkpQKe5owEA8AAkkF/B2tbt
HrAuTsrzjcijRfU5yoQ6z7q/P4Z5Qws=
=3+LB
-----END PGP SIGNATURE-----

--x+2TvZJhub2l4MoK--

