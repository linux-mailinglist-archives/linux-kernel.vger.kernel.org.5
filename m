Return-Path: <linux-kernel+bounces-33623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3063F836C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B821F26BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A460B90;
	Mon, 22 Jan 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu5qJG7R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07122487AC;
	Mon, 22 Jan 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938431; cv=none; b=Kq9GZcIWcEEihMYmyXr6a4V2ssSqibDasTkZN9oUht3/qefhZ81V55p7QVKF65USCiY8dmad7SHZ7NikgjyvUiMLvWdvTyTOfVqOKGmvzrq4YRxg033GyYLHYwWUdhWhEiYMn3/bYsy9FW9vb7ajXMscEzDoQakV5UVKmjZ4snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938431; c=relaxed/simple;
	bh=MeeGlkv76uplWomLg9ocLHv3pnCOcFvMEIpYsPtsuKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff+cJ1jD+dphummLsMBjhywVh3YGumIoHrZqxKhkIm0iUyjARHFuPcxy+G5kNvqy3bL3+CKKzEzXp2eWgoqs1HfM2BFV7F+xEKhwdQs2Igm/eR6VXi5umAeonLQrFh9q1khebXEtKelbnUZRgWVEFo7LIFx/xFnWXW/jaA1DGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu5qJG7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB36C43390;
	Mon, 22 Jan 2024 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705938430;
	bh=MeeGlkv76uplWomLg9ocLHv3pnCOcFvMEIpYsPtsuKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fu5qJG7RkhmQ6jgIor5MANwY+t4GvT6yVQsN1DGTMGXKHe9StM1utWQISbbVvd4ac
	 B1juEMTY3B1GRWCbOe25U9Rr5uCnTDL1xmJ/yWTVXfPM0zCCKa3j9/sQiZCxGooeM9
	 iMjZ65xo3ahoMRi85ydV+lr0KflLGBU98Ga5NC+ueAdxgXb5eMu34ild0NwwsR7sf0
	 oAueXHeCXhks5ui/INetc73O1gkav8kikNXkXqCDAmWWe8iNDwYl1KfxKfVoez11Mq
	 HXJlAKaAHDgVSvShgmDTArxM1ApWambu8Ki5e2/6suTJWJNyQAGcsC93zGNmh4aeJ/
	 PeL9/w6ECTJwg==
Date: Mon, 22 Jan 2024 15:47:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
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
Message-ID: <20240122-duplicate-nutrient-0edf5dfc9c93@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
 <20240122-breeder-lying-0d3668d98886@spud>
 <20240122-surely-crimp-ba4a8c55106d-mkl@pengutronix.de>
 <20240122-cruelly-dainty-002081f0beb2@spud>
 <20240122-smokeless-ion-63e4148c22e5-mkl@pengutronix.de>
 <20240122-uncoated-cherub-a29cba1c0035@spud>
 <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZlbIajEJ0GsLUYlg"
Content-Disposition: inline
In-Reply-To: <20240122-pogo-reputable-b1d06ae1f1f1-mkl@pengutronix.de>


--ZlbIajEJ0GsLUYlg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 04:31:32PM +0100, Marc Kleine-Budde wrote:
> let's get this binding and the CAN driver upstream!

FWIW, the driver seems to be in a good state (or as good as it can to
someone unaware of the goings on of CAN). Hopefully the author gets
a chance to send it out soon.

Cheers,
Conor.


--ZlbIajEJ0GsLUYlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6N+AAKCRB4tDGHoIJi
0h2VAP4w9AGyt9LMjr1fxyGbb5m1B484LsXBg9uqxe4Tx/FZsQD9GwDu25MWq/sI
nV0HlY2+IRQ8+nMMpcWLtXqwCGwB0w4=
=MXC9
-----END PGP SIGNATURE-----

--ZlbIajEJ0GsLUYlg--

