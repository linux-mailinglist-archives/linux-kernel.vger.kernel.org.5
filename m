Return-Path: <linux-kernel+bounces-85031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D186AF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA211F22C53
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD04148319;
	Wed, 28 Feb 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy0ISwLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763936129;
	Wed, 28 Feb 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709124388; cv=none; b=HwtkmkUZb/hXF6iV3bofnBoeWS1tN5xKVdtIDMGC84hlCv/XUM/p9lBb8TmjOAynLTY15JC+hQvYKxQc7/M6Ihzzglx5DlEKAx4cEJSX1nVhIVaEGQr6IGK68ie0fGyw34Mn9X6pl2StG2ec4/gQDfVLGxk8PzbcGErYOi9CwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709124388; c=relaxed/simple;
	bh=M20am1kduv663tpt9tdEQeWDmBa9M2AMDPXJdl+iQ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYjtyQhmCydlwtsF7LfqS/biY35gyUq3ZLpZgUxbs5iT10sHZX54bcRnM42Mn/GsRWRaFvbTSVDLMmX4jS/GtBAGmo3WfF/Vtc6BbpN28u5Xq14QFQ73TSDvfvjVebNJBmiCghZKjaS3WT+7e39CCo8Le5x0lqIeqiLGjqd8m6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy0ISwLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C2CC433C7;
	Wed, 28 Feb 2024 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709124387;
	bh=M20am1kduv663tpt9tdEQeWDmBa9M2AMDPXJdl+iQ3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vy0ISwLnlYogoSkPYwU3ed/ndkGi5MBrHuaAc8pqesZTnAXwF61c1+XXg+IiVZc9C
	 L1h14krLyFmUfhKwL2Hmz8c/udCtH4jUWe64Vkjagw3oWrYB1++hxVC8NF0ctPMSp3
	 wuODKANGth1c17I8prQq76lhsOyG5uF//6djRcMjgMh+2X/Qaj9cY6aLcVTHg0cndU
	 GHDqUTTIVxgluOorVAROLQ+ywEjRdr/T3Ckfb34zPhOTgEOIXxL2Lf5G+fNHbiB9NM
	 rSwLg6EAIAUifHTvW04TuRn7jaswTpG29nzNbSiNcNNT4ZnGae3VpgciErgixsoEcO
	 Om8jskK5H+uwQ==
Date: Wed, 28 Feb 2024 12:46:21 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 03/30] dt-bindings: gpio: nomadik: add
 mobileye,eyeq5-gpio compatible
Message-ID: <20240228-deceit-armful-c65cf1de2d08@spud>
References: <20240228-mbly-gpio-v2-0-3ba757474006@bootlin.com>
 <20240228-mbly-gpio-v2-3-3ba757474006@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6wolzmeLBE8o2PE"
Content-Disposition: inline
In-Reply-To: <20240228-mbly-gpio-v2-3-3ba757474006@bootlin.com>


--d6wolzmeLBE8o2PE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:28:01PM +0100, Th=E9o Lebrun wrote:
> This GPIO controller is used on the Mobileye EyeQ5 SoC. Add its
> compatible to the dt-bindings. One difference is that the block as
> integrated on EyeQ5 does not support sleep-mode.
>=20
> Signed-off-by: Th=E9o Lebrun <theo.lebrun@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--d6wolzmeLBE8o2PE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8rHQAKCRB4tDGHoIJi
0g+bAQCEs2L1Y2Fx8B+AwPbiqJF208UvKl0VmWyKqYjSUgFuigD+OoO7e9wTUXrV
QRZge4tRm1CvRUTf4uSGryWT2AO6aQE=
=tkM9
-----END PGP SIGNATURE-----

--d6wolzmeLBE8o2PE--

