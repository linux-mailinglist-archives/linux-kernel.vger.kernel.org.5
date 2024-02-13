Return-Path: <linux-kernel+bounces-64224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2604853C39
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD172875BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724B60BAA;
	Tue, 13 Feb 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPFkxYPR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8E1097D;
	Tue, 13 Feb 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856023; cv=none; b=W44FPD8nVvRomyLSYWa/sAXRLj9b3M38FXp7DeTOwmNN+up397WCkB5zsuxrGrOL+3IloghQiDwSs4IuZ45o0v61VBXQVFA2cd7Jgo+aovy9475BDCocGk3wi5SWCLxMRbJiTbAghqF2sRFaPBEQR9OT+ik4Zyw5Gd05Q+6ip9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856023; c=relaxed/simple;
	bh=wr2SPv5Ld/DSkoS5vcAzZJ9Df9CxqcjpNgsKUEXsmMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlJplD7J9TgmdqwIxGJcBQAJy0AOrIxN5j2YL98JZ9YGQJMVH8qNdxPhXgGUQy0gRvceaicH3Y8UIrQRAj2oXmo54V0yRS7maLxq2djwO29QmcHqjeTlPqyGs2lN9pK6AmF2fgT5O3wo7NANmMSHS1LXjNoTMgQMVpviUKC0SWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPFkxYPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEE0C433F1;
	Tue, 13 Feb 2024 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707856023;
	bh=wr2SPv5Ld/DSkoS5vcAzZJ9Df9CxqcjpNgsKUEXsmMg=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
	b=lPFkxYPR0J3NXG1zdBfo423wECnKhWMgXPxCg52F3jS4QKKMEyqjBhXaUGKE3tgG6
	 37ZF1eFh/KlF2KXEvZh8+5akK0hqsrS1FZnabOENmkW6SqKVRepSFJf7g6xxh7ojEV
	 jnkdi6FQUiy1uKshzEZhLb5yve1bg3+EMiWyulcWid6e7LMamsxlhTvq2275lGDRVd
	 PYq1svZG2Lc2X9dtgFRoH1KjCqQDhIoYjVbGHKXP+VJjE7rPkT9HdKzpsCs5RzEGYP
	 ef1gd/J3wmRP/+qW2yBa+bsr9UVpRx1oatwybDxzT9Hk3Wx4NArI6+dQLf7ihqU6h7
	 NgaQAYTbgz0rQ==
Date: Tue, 13 Feb 2024 20:26:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	Tony Lindgren <tony@atomide.com>, Chanho Min <chanho.min@lge.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/6] dts: Fix dtc interrupt warnings
Message-ID: <20240213-wafer-garnish-88287bc5d4a5@spud>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4XczAmSSxV0XIpGO"
Content-Disposition: inline
In-Reply-To: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>


--4XczAmSSxV0XIpGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 01:34:24PM -0600, Rob Herring wrote:
> I had a branch with most of these changes sitting in my tree for some=20
> time. Geert's asking about some errors not getting found prompted me to=
=20
> clean it up and send it out. This series fixes all* interrupt related=20
> warnings and enables the check by default.=20
>=20
> SoC maintainers, Can you please take this series directly.=20
>=20
> Rob
>=20
> *There's a few Renesas warnings still Geert said he would fix.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Rob Herring (6):
>       arm64: dts: freescale: Disable interrupt_map check
>       arm: dts: Fix dtc interrupt_provider warnings
>       arm64: dts: Fix dtc interrupt_provider warnings
>       arm: dts: Fix dtc interrupt_map warnings
>       arm64: dts: qcom: Fix interrupt-map cell sizes
>       dtc: Enable dtc interrupt_provider check

Only fixing it for arm, Sadge.

Co-incidentally I noticed there was one for riscv while looking at
Krzysztof's underscore in node name patch earlier, so I'd already
written a patch to fix it :)

--4XczAmSSxV0XIpGO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcvQiwAKCRB4tDGHoIJi
0iKoAP9EkRpfMdcQD2Rxy6EyQrFHOf9aK1XBqWvwsM+uYWZVZAD9El92XfSbd1tC
IcCJORhtpqwWl2bRDhMSRtSpWpqRygA=
=9Yjc
-----END PGP SIGNATURE-----

--4XczAmSSxV0XIpGO--

