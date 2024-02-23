Return-Path: <linux-kernel+bounces-79004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD7861C20
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECBDB24909
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA045143C7E;
	Fri, 23 Feb 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpP5gPFr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34213143C40;
	Fri, 23 Feb 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714033; cv=none; b=kxqOqrUVdi0MnrWwcASgGxib1Ru+4QlVe5OQeOz7xqIXFHmyZf7DbRu7/8m2/nbRk4ez62LGxde6mzHpXFjC01CLAgznaroIIY0YW6OPSqyXyt79eB8QORNfU5fvjkRvz5Pt51wZ3d4UfBz5yUT4iZRxczv+MtvvA2iVkYIdg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714033; c=relaxed/simple;
	bh=eVLWzS7gYaF42Hqu36RJiepcfVw/lg0keFM7RtUV0Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxGbPKQnciM4eYTY7MtSWUyR7G9cku+w2XyIg0S2+3P9LSk7AuCocFkwk/bKtYghgRu05lCdPzO6vJLlOeQDZ3zITZu9Y6yUZLd2mSBGm6HsNMk7h/+ifM2BvJve21Y25IRXJdNU4V+3yb5yFcZzlVoOU3galJHzomCRPgrg5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpP5gPFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989F7C433F1;
	Fri, 23 Feb 2024 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708714032;
	bh=eVLWzS7gYaF42Hqu36RJiepcfVw/lg0keFM7RtUV0Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpP5gPFr/wO3BW32q043WYJ8BndpF+5c5kvBbPcCvKFQoWIG8bQxVldGM5HF8/7Zn
	 19GFA+mY4vLTHE0QqgTa9TW1CDUBWJmW/1pGul98tVLPC8XRtgXruShuDyzrr63fXs
	 DKygP3MxjDZwjMsUSC+X4mGT+4U2lFBYh1lp9ar2DGTMGRX65f76HenH4YSxIJOk9T
	 ZcwrK3IKo534NeFkb3w7GCYemQapPnOc5B/4ZuEa6ymmiYltJbpQ9P/YZ7HUWmv3uM
	 geVSVjFUCQ1pyN6PLP716Z0ag8V5iEdv+Dpk+IL47x1wJozGWDpnWUL0uaAkPqH7/d
	 BEYm/83ZFsNuQ==
Date: Fri, 23 Feb 2024 18:47:06 +0000
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
Subject: Re: [PATCH v6 06/13] dt-bindings: mtd: brcmnand: Add ecc strap
 property
Message-ID: <20240223-revolver-astute-8fb3bdbb6b2e@spud>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
 <20240223034758.13753-7-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n37UuXkV/2mgwiHJ"
Content-Disposition: inline
In-Reply-To: <20240223034758.13753-7-william.zhang@broadcom.com>


--n37UuXkV/2mgwiHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 07:47:51PM -0800, William Zhang wrote:
> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> board boot strap for broadband board designs because they do not specify
> ecc setting in dts but rather using the strap setting.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--n37UuXkV/2mgwiHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjoKgAKCRB4tDGHoIJi
0oLTAQD6uuZ7A4FClI0rca2qTrbTuWwDulHcIMWL6jq5deCSoQEA4yGAktqwg9dD
8s+wtFRJwP+4UEJdvzAjCR2i8xbyHwE=
=0j/A
-----END PGP SIGNATURE-----

--n37UuXkV/2mgwiHJ--

