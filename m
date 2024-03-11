Return-Path: <linux-kernel+bounces-98977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB68781C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7790AB23CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855541232;
	Mon, 11 Mar 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4cR6e9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E040BEB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167907; cv=none; b=HZNOrwLDc56E/VSuTS/RtDrniW2LmWYsDjmerqAEQ8tpP11nv//1NIYZ6atkJ/pJnH6DVKCfRdSJ1JvAkyE2YXaqKezwSmw2aC040x7jeBmEok/vb5ab0bIk/000Ii/KWpx9WLfUi02bEMP3KvX2d4fb++Z3OCbkGPVb3oUu11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167907; c=relaxed/simple;
	bh=ikG1QQ6Ft/EuPBNRvKuFA2EUFI7GLaO5HRAitUly3CQ=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=C99aql9mOua0OMnZflllDQv5lMqyWVbh5r8wE9KRhYNLV0Kf/E3GK6L1HRWydZDt9nnZ0eWlQ96ueS5HAIE0ZHE1c2iCxcGKFmwIFUZMZAVdQm12UE4ErQ0zYBJ0nwodvHyRnepWN4o/Kkv1opbfbdLP5xr8PHiD5P9YMrBvkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4cR6e9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5702EC433C7;
	Mon, 11 Mar 2024 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710167905;
	bh=ikG1QQ6Ft/EuPBNRvKuFA2EUFI7GLaO5HRAitUly3CQ=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=N4cR6e9QRDrGNAQ621FMoQQTlT4j45Gs0eckfvY/M7lYe3RJPP9cqw4gTdvhWrIQs
	 YgUCH/ufRSS7UTVj75iR4J3usZFQg/+ihEAuav2/1GsLYx/p15WkJlphSKT+VyvlaL
	 88Rw7kepSg7vzTJmrgPWImKZNbroOxc02gA3vxwviR3YU+nYvoS/R6CyS3pe95P9m7
	 ee0zJ4OEDuZ14nW+8bmQyAOYz4vC7+FDykLmGphbSUTaePAdSv9EPCyh1vUizWXpjj
	 PaQhqCO7jRz4QSozttnWsSz9U/Twjt/+zx/nn67Xk/L6T56U+rCqZZqqUVUdxsFh6j
	 f/7lKfBY4EZsg==
Content-Type: multipart/signed;
 boundary=45ed013812313c157f704b5e662bd3e921269c7d51848b7e818b5055826c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 11 Mar 2024 15:38:17 +0100
Message-Id: <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>
Subject: Re: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register()
 if OTP is unsupported
Cc: "Mika Westerberg" <mika.westerberg@linux.intel.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Aapo Vienamo" <aapo.vienamo@linux.intel.com>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--45ed013812313c157f704b5e662bd3e921269c7d51848b7e818b5055826c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Mar 7, 2024 at 2:04 PM CET, Aapo Vienamo wrote:
> Handle the case where -EOPNOTSUPP is returned from OTP driver.
>
> This addresses an issue that occurs with the Intel SPI flash controller,
> which has a limited supported opcode set. Whilst the OTP functionality
> is not available due to this restriction, other parts of the MTD
> functionality of the device are intact. This change allows the driver
> to gracefully handle the restriction by allowing the supported
> functionality to remain available instead of failing the probe
> altogether.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> ---
>  drivers/mtd/mtdcore.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index c365c97e7232..1cfc8bb5187d 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1054,8 +1054,14 @@ int mtd_device_parse_register(struct mtd_info *mtd=
, const char * const *types,
> =20
>  	mtd_set_dev_defaults(mtd);
> =20
> +	/*
> +	 * Don't abort MTD init if OTP functionality is unsupported. The
> +	 * cleanup of the OTP init is contained within mtd_otp_nvmem_add().
> +	 * Omitting goto out here is safe since the cleanup code there
> +	 * should be no-ops.
> +	 */

Only if that's true for both the factory and user OTP area.
Also, you'll print an error message for EOPNOTSUPP, although that is
not really an error. Is that intended?=20

>  	ret =3D mtd_otp_nvmem_add(mtd);
> -	if (ret)
> +	if (ret && ret !=3D -EOPNOTSUPP)

Maybe there is a better way to handle this, like controller
capabilities instead of putting these EOPNOTSUPP checks
everywhere? I'm not sure.

-michael
>  		goto out;
> =20
>  	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {


--45ed013812313c157f704b5e662bd3e921269c7d51848b7e818b5055826c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIgEABYIADAWIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZe8XWRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQzcodo7VsRvumBgD+Ne3GfSC1vSlxnEWI5Pw4YrWak8YHEpYq
E3KnfeyJR+wBALR/9/FAxfZci7xN2e0x1qQlGlpXIJeJiyCZctoKq7oO
=B1CF
-----END PGP SIGNATURE-----

--45ed013812313c157f704b5e662bd3e921269c7d51848b7e818b5055826c--

