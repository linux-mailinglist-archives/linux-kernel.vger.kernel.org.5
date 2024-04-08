Return-Path: <linux-kernel+bounces-135417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37D89C171
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F79B21D91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8581C12A173;
	Mon,  8 Apr 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SbAvpY6G"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316457F7F4;
	Mon,  8 Apr 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581983; cv=none; b=j4qVs8meEzXJyYEc5yugwfh8AQgbi6/9iqPzFUaoObN1BAiiDEMcpQP7aDhFCkxf3XJRpXwQQdTrrs4dasIyM9Nf1s3E+aVFA/t8miUevvRLFFyobcBPA/jgINs7sKgt8G3+VoI7n6B2yJ8o34HsT0Bft21GCetXUFhJmAjbAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581983; c=relaxed/simple;
	bh=7RkPM/B3kyuIbM7d4ylNyUS9GTpKxgWSh/D/2nwJB98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De8ISP9uhO9YbY0kGI8pbiIs7t+kEUhLv5vpRN638TCEmPcvjBBEkOEfDouKoDyt//RhiZ/TsEeFiBa9NVw0CvYulwUCbFQI6/Lf7vm8ixiwf9Pa77Mt4ubyNiQdkqFpn8vpoYiTmk1A1x/UPR1sy9hV/pBE46tMtwccjpGuS9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SbAvpY6G; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 387722000E;
	Mon,  8 Apr 2024 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712581979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4sGAvmu2WBKS9a+UuFTscURHh9GQY36xbMpg8VE/qc=;
	b=SbAvpY6GdmVqtZm5zIx/MJnsKYTBK80BbSFPrRKsf8rOFXc1oMQNf57pDfMHtnvpglsmUV
	inR/QwyzN/FYbONPm7jSXTf2+r/LcJ5/FJxPEBDHvsj/c3TUv6678/svHAzhs/U/MtWm+p
	67kv5aYW+6m3QoUEZcFP70nABj61YgnlecopboIetW6NIYdPBvjlzTpgEgcX44shEbiHE9
	zWZHpyRJQ/wRrx+Ov2BCWV7XuZ6SS1/xomPw1cwqUkswa3azEdI0sfrrm6dMxmUxPQNrQS
	3dulRr1e59hbrVyUzJlH8x/nmH495ChGooqWHSEu4/ZIpLAy18tx7kke1MAA5A==
Date: Mon, 8 Apr 2024 15:12:56 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240408151256.11d4e69c@xps-13>
In-Reply-To: <20240402212331.27328-1-ansuelsmth@gmail.com>
References: <20240402212331.27328-1-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christian,

ansuelsmth@gmail.com wrote on Tue,  2 Apr 2024 23:23:19 +0200:

> MTD OTP logic is very fragile on parsing NVMEM Cell and can be
> problematic with some specific kind of devices.
>=20
> The problem was discovered by e87161321a40 ("mtd: rawnand: macronix:
> OTP access for MX30LFxG18AC") where OTP support was added to a NAND
> device. With the case of NAND devices, it does require a node where ECC
> info are declared and all the fixed partitions, and this cause the OTP
> codepath to parse this node as OTP NVMEM Cells, making probe fail and
> the NAND device registration fail.
>=20
> MTD OTP parsing should have been limited to always using compatible to
> prevent this error by using node with compatible "otp-user" or
> "otp-factory".
>=20
> NVMEM across the years had various iteration on how Cells could be
> declared in DT, in some old implementation, no_of_node should have been
> enabled but now add_legacy_fixed_of_cells should be used to disable
> NVMEM to parse child node as NVMEM Cell.
>=20
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable
> add_legacy_fixed_of_cells if we detect the MTD type is Nand.
>=20
> With the following logic, the OTP NVMEM entry is correctly created with
> no Cells and the MTD Nand is correctly probed and partitions are
> correctly exposed.
>=20
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Feels okay to me, but I'd like to get validation from Rafa=C5=82 as well who
extensively worked on this aspect and must have a sharpened eyed for
this kind of issue :-)

> ---
>=20
> To backport this to v6.6 and previous,
>=20
> config.no_of_node =3D mtd_type_is_nand(mtd);
>=20
> should be used as it does pose the same usage of
> add_legacy_fixed_of_cells.
>=20
> Changes v4:
> - Add info on how to backport this to previous kernel
> - Fix Fixes tag
> - Reformat commit description as it was unprecise and
>   had false statement
> Changes v3:
> - Fix commit description
> Changes v2:
> - Use mtd_type_is_nand instead of node name check
>=20
>  drivers/mtd/mtdcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5887feb347a4..0de87bc63840 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -900,7 +900,7 @@ static struct nvmem_device
> *mtd_otp_nvmem_register(struct mtd_info *mtd, config.name =3D
> compatible; config.id =3D NVMEM_DEVID_AUTO;
>  	config.owner =3D THIS_MODULE;
> -	config.add_legacy_fixed_of_cells =3D true;
> +	config.add_legacy_fixed_of_cells =3D !mtd_type_is_nand(mtd);
>  	config.type =3D NVMEM_TYPE_OTP;
>  	config.root_only =3D true;
>  	config.ignore_wp =3D true;


Thanks,
Miqu=C3=A8l

