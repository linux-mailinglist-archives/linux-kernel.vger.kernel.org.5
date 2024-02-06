Return-Path: <linux-kernel+bounces-55094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88184B7A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06511C222F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A5132470;
	Tue,  6 Feb 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W38Z4H0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFB131E44;
	Tue,  6 Feb 2024 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229181; cv=none; b=ndKk16MNrPiw0vLWF4p7w8dXVoq6Js/SH34tPIGwd+xkDk4wT+ygkRSG7+HhA15GvGO6SdiufTQ+8o8dmSHH9ZdctA/RVaKMjNsIumBVyX0lbjDAwr/zSOzhoBI8Mpa/k86vHase6L88cs5fMzWUFRtT32yFs2xr+zF8BYOwoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229181; c=relaxed/simple;
	bh=1MnTEbxeUsGA7HMcn2eRPHhXYWih9ZllJehloa4wpsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S52rviG5FewOV0w2x8v3Rpx0LCna1+d58BnHpcVAL3a8sKm5bsu3hdhjDCdFkPzJDImAExN4rvAE1bvvpJcp4fK+PInTayzuBQACEOeoXOV7gvr4a4i3nogcnqWqqF5yD1eK/jbRbyz7VzqEpzWD5qlqH5MVH91MLzQqNk9c3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W38Z4H0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C92C433C7;
	Tue,  6 Feb 2024 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229181;
	bh=1MnTEbxeUsGA7HMcn2eRPHhXYWih9ZllJehloa4wpsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W38Z4H0qdYqSxhn84T7haOHArqaXgeHjfaoKy44OX19ZDhSftyULq0r/FMg70Ayyg
	 e7xwz0dqu7rFdptm5oHyeXQbqIlKCTw2IHPb8ifn0IWhpuVUdjUtd1/vqHYHiskKus
	 emdg0gItkGetPQPwjMbX3W3fHloS4plorEAOZb4jp8m6WWubTwO7C7KUNEfmuWtWJd
	 zDY6/0HI6/GQqpBuO8do0WL0/4o+XXYwSsg8BKoJsCU5N+SjQ257MPnim1lXkUHSj8
	 ZK/ph766zwqJpWxF6v4UD+bEzWaUrTNjU17rOna6yYGAL3WbiXN7oAf1vGxX8Vd7MR
	 Shtxv60zYzbrg==
Date: Tue, 6 Feb 2024 14:19:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Message-ID: <20240206-parole-cinnamon-2fe369f6ca74@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
 <20240122-cruelly-dainty-002081f0beb2@spud>
 <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>
 <20240122-uncoated-cherub-a29cba1c0035@spud>
 <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>
 <20240130-narrow-lyricism-8b25baac7bb2@wendy>
 <20240130-fragrance-disinfect-22cc1911bf48-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5oAuP6RxMdm00jg7"
Content-Disposition: inline
In-Reply-To: <20240130-fragrance-disinfect-22cc1911bf48-mkl@pengutronix.de>


--5oAuP6RxMdm00jg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 02:01:09PM +0100, Marc Kleine-Budde wrote:
> On 30.01.2024 12:11:44, Conor Dooley wrote:
> > On Mon, Jan 22, 2024 at 04:31:32PM +0100, Marc Kleine-Budde wrote:
> > > On 22.01.2024 14:56:09, Conor Dooley wrote:
> >=20
> > > > I think we already had this discussion on v1, where I said that the
> > > > binding requires the clocks to be in that order, regardless of whet=
her
> > > > or not clock-names is provided. You feel more strongly about it tha=
n I
> > > > do, so I will add them when I get around to sending a v3.
> > >=20
> > > Yes, this discussion sounded very familiar to me, never mind. Keep it=
 as
> > > is, and let's get this binding and the CAN driver upstream!
> >=20
> > BTW, I didn't see an ack on this nor do I see it in linux-next (yet).
> > Are you expecting the patch to go with the rest via the clock tree,
> > via the DT tree or will you be taking it with CAN stuff via netdev?
> >=20
> > I can resend this one patch with a netdev appropriate subject prefix
> > if you like.
>=20
> Feel free to take the whole series via the clock tree.

Okay, I've gone and applied all of the binding and driver patches to the
branch we will send to Stephen. Thanks!



--5oAuP6RxMdm00jg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcI/9gAKCRB4tDGHoIJi
0kHUAP0e+rt2LDSpTC952WOfj4vXNDY3wh2XgO1MsZQXw131LQEA1UPbV0N5gf+J
ALoxbvkmhHo0E10iiUy+SgrU+qL5yAM=
=rlvY
-----END PGP SIGNATURE-----

--5oAuP6RxMdm00jg7--

