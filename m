Return-Path: <linux-kernel+bounces-51125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75C78486D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CBE1F22583
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B75EE8E;
	Sat,  3 Feb 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyU/GFd+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237F5D47E;
	Sat,  3 Feb 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971868; cv=none; b=Yi5x2jryCNkZnugc1usdnfPEuIOf7t4X6fy8BIyhBNvMPFM6gp9NDE7UHSssrvqiPLVwnWardSMwwVjzwZAEyv8FJl9g54I9Uq6mS98s5IoDmpS3VBUhsvRzz3NPfOAxUmNnuMkurHZ5GXiMgZwRereS9JxoCirBi8yx6Fnji+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971868; c=relaxed/simple;
	bh=kZrg3ai602uwcG9r7fcunazV+Lut/tm/tBOnYvdvVwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC49ZwPaURnZWjsWbIRdaFSDvmB0Eif0RPn9pIf5/OA0WdsjxypjpOHK9kdpAbqfnbhwFe6oY+Ka9zsFaNFVuV4WUZqM41PcQd3ycKKE3aShe1n4kwaZIamaZcrwzO01fHzYLbTw2PewIjRSubxgIn2hkTS5JOWRt1cXm/GjYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyU/GFd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB0C433C7;
	Sat,  3 Feb 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706971867;
	bh=kZrg3ai602uwcG9r7fcunazV+Lut/tm/tBOnYvdvVwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyU/GFd+9pKR7Kt/css9MJdmrcVnZ31dprRIGBrXJASerebXa55nK2X+PPYZ2+Kby
	 jYc4JUwHZeOn7OozmHC3BHF0mOaSCRiCEr3y60yFSoyFvtLCeLcVZuvQtiSQDBtKV2
	 0cVHAOMes0FI5vc0pf1SsLRzj5yf2xA/FycdT4GZGLAZPlYFgMWf4GK12E3gSPfiWm
	 e4qx9TuXucn0q3Trv0+QSgEgyq+BhvdGeQNR9ztU29Y2KhWGtc37brmKRfWAvbylpL
	 YUiPCCfpu2yfCgFSptOr9qtgLJIhSYg3zY/sFBXAbxymoKdmlXMLDG4mEnK91AJmTd
	 0trNq/P0TLk6A==
Date: Sat, 3 Feb 2024 14:51:01 +0000
From: Conor Dooley <conor@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	f.fainelli@gmail.com, kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
	kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 02/12] dt-bindings: mtd: brcmnand: Add WP pin
 connection property
Message-ID: <20240203-unselfish-rewire-78cc0d3db0db@spud>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-3-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qrjKC5ASGNxluNoU"
Content-Disposition: inline
In-Reply-To: <20240203002834.171462-3-william.zhang@broadcom.com>


--qrjKC5ASGNxluNoU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 04:28:23PM -0800, William Zhang wrote:
> Add brcm,wp-not-connected property to have an option for disabling this
> feature on broadband board design that does not connect WP pin.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--qrjKC5ASGNxluNoU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb5S1QAKCRB4tDGHoIJi
0mOCAP9+H/eJznyn7suY07Ew8Ml+xZ9vSfwBboku/7M35uHXvgD/aybKwovhGgVC
4DhLtmNGAk2tCCNzRnIEcGoX8bHOmwA=
=E5iS
-----END PGP SIGNATURE-----

--qrjKC5ASGNxluNoU--

