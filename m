Return-Path: <linux-kernel+bounces-43197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E08410B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF671C2333A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349ED15AAC6;
	Mon, 29 Jan 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVENRRMp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713D6166D;
	Mon, 29 Jan 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548933; cv=none; b=ALUr1ofmz5KMRk+CV1rjND7kvR8mZF//EL8BBM0fg6uCt6yisuBeEaUvpePX6oQAK8U+qz0NAyflGqPklnN9d+8VdCc3kAywlonccbgwu6OePhAOs7xeML7FM6C5pXG/gdBETTMZ+J4ThhbbqmnJBW5s01IEoIvxPQWgh8rf944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548933; c=relaxed/simple;
	bh=SIkxvn58cFSwkfs8vCGtPLxhrtNc6Ue9Ey24VfzwgfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2rNLF9RrQ1vMxkkemP2ei1f4XKo+KaKUDBzUBfdqXK2BPtUSTWoKtNlX6pE3+N4hbkY47jnTvQmvHWW19XmhPPM7N5UgbhD3nu25Sv3DDI5ytwOFYakb9L46hC2gBsWeRI7zJro3HErOd37LLh3ZH5kViW50EGaUnQpSaAP35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVENRRMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F206CC433C7;
	Mon, 29 Jan 2024 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706548933;
	bh=SIkxvn58cFSwkfs8vCGtPLxhrtNc6Ue9Ey24VfzwgfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVENRRMpfoGyLQ+YOTFshGOj5XxCpLZQGIehYB35ZQkC3ZrP7PZaDmimeUEA5TuJW
	 BPgnbSU3uNxAw+2416gvXtIx3ObUlk1xz0cYHNuUdC8tIC3r/qTsKBAr37U6T5GRSC
	 4LPvjc013T6P63HbptHK9Xu3w+6RdFKjUnmnZbLyhN77DH05CCM57l6c8uv+ENpUJ4
	 Nt2A5fApwfvoDb6EnSTy5Ah6Y8isNveLs7+XjWWzM3jQna8+jMw8ngy9fd6s2X6o2T
	 MO/q4rG20K7+/8zNiipDx0VdOf4A+FYHubI5MtC+y+EyzwI5jXqdsF9eErKuAvoCQi
	 wcXpvmwvqG5hQ==
Date: Mon, 29 Jan 2024 17:22:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Message-ID: <20240129-vagrantly-unaired-4224a5febb01@spud>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
 <20240126-dev-rx-enable-v4-3-45aaf4d96328@theobroma-systems.com>
 <20240128-vagabond-mutilator-cf8dc6ac8a41@spud>
 <da864300-ae0a-43fc-84bd-94e985d8ac73@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IBCjK9MpjSUCbqHB"
Content-Disposition: inline
In-Reply-To: <da864300-ae0a-43fc-84bd-94e985d8ac73@theobroma-systems.com>


--IBCjK9MpjSUCbqHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 01:26:51PM +0100, Quentin Schulz wrote:
> Hi Conor,
>=20
> On 1/28/24 18:38, Conor Dooley wrote:
> > On Fri, Jan 26, 2024 at 03:55:12PM +0100, Farouk Bouabid wrote:
> > > RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is
> > > enabled, this gpio, if provided, must be driven active while receivin=
g.
> > > However when RS485 is disabled this gpio should not have an undefined
> > > state. In that case, as DE and RE pins can be connected both to this =
gpio,
> > > if its state is not properly defined, can cause unexpected transceiver
> > > behavior.
> > > This binding depend on rx-enable-gpios to be implemented.
> >=20
> > Why do you need a dedicated property for this when there exists a device
> > specific compatible for the uart on both of the affected rockchip
> > systems?
> >=20
>=20
> This has nothing to do with Rockchip's IP but the HW design of our
> carrierboard, so using the "rockchip,px30-uart" for that (which I assume =
is
> what was suggested here?) is incorrect since it'll also apply to PX30,
> RK3399 and RK3588-based Q7 SoCs we manufacture.
>=20
> Did I understand the suggestion correctly?

Yes you did. That explanation for not being able to use the compatibles
makes sense. However, I can't give you an ack, because reading the
commit message gives me the same feeling as looking at this photo:
https://www.reddit.com/r/pics/comments/f8jyuz/nothing_in_this_image_is_iden=
tifiable/

Sorry,
Conor.

--IBCjK9MpjSUCbqHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfevwAKCRB4tDGHoIJi
0pCUAP9U44UkidVfIFyP9IjWHAPwttaCmGToXZjCv2rwlhJiVwEA1GULoLBIRwGa
1D79uhaA8T7azreJ91+tdhZ26EA4TQQ=
=Ye3s
-----END PGP SIGNATURE-----

--IBCjK9MpjSUCbqHB--

