Return-Path: <linux-kernel+bounces-109725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E1881CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A902B217AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166751C2C;
	Thu, 21 Mar 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HGvn1b/G"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E563A1DE;
	Thu, 21 Mar 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005432; cv=none; b=HkYzq/eMAKlN+azORVpTkyhmkavwV56qjE2HzBMsadHolQ1Aq9rKJfquqdfJguAkXYZDWUJ+VzqjrCBe3YzODL5Zle0ZV6f7vUno4MS1y667bbxkPPBw4xrAYoB0NlHTsNpsGb++Oh8Ut1cw8RZdw+ZdZU9HBFOQXdKqeeSbaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005432; c=relaxed/simple;
	bh=GzzWbNc0mT8vlM+yDeqE8rS78bXyatgD86F8aqGRPMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAAZ0jdsjDpDXWFfRfzJnK14dAhsimMUnH6aO5kdHBsqTdo/2FqxJfWKbPjSj/GCL3IHZU+AhYfQeahK3PUv56dxLSeHTi9J1EXcKshV9ax1hHRqI+VWB6QYZrQdfaDUo0FaIqJBfGvKz1wblW3eMnUgbvqBke8fCdzqx5pihGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HGvn1b/G; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3FAD1C0004;
	Thu, 21 Mar 2024 07:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711005427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnjl8NwZzgPwQjCkcjCjQ+FVN05+Q4op74BaS+FN5Yc=;
	b=HGvn1b/GVl4fpnbQxgNZ/Prs0NyYO5wc1PCRytrdhvGE2nXdpuQI3dkSeqmnisYBExgCTS
	csRHt58eh5FldcAX/GCpFttN4qAyIQlm406ZbwqkD2l/M7KVVTx7dEMo4cyjZAVkleNr3g
	41dkjnWhhz/Nx43/lC9sXuXoK8X5dKRALxgynzk1jYW48aQLc8M8J9/43S4q/0Gyl9p09U
	hJ1GkDbFTxj7wDjjFR8OYHn5DRCl8GUDRGmm9Diwh+iN5bK9fyg/AS0G7YEYel7516m8x0
	XoMw8qBq3BXhsreHvxtxXZKFDp6V2k2Vfi76eaHeuihaY7+tRPxWDaDlwZa4lg==
Date: Thu, 21 Mar 2024 08:17:05 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240321081705.597f72bf@xps-13>
In-Reply-To: <20240320162927.5015-1-ansuelsmth@gmail.com>
References: <20240320162927.5015-1-ansuelsmth@gmail.com>
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

ansuelsmth@gmail.com wrote on Wed, 20 Mar 2024 17:29:25 +0100:

> MTD OTP logic is very fragile and can be problematic with some specific
> kind of devices.
>=20
> NVMEM across the years had various iteration on how Cells could be
> declared in DT and MTD OTP probably was left behind and
> add_legacy_fixed_of_cells was enabled without thinking of the consequence=
s.
>=20
> That option enables NVMEM to scan the provided of_node and treat each
> child as a NVMEM Cell, this was to support legacy NVMEM implementation
> and don't cause regression.
>=20
> This is problematic if we have devices like Nand where the OTP is
> triggered by setting a special mode in the flash. In this context real
> partitions declared in the Nand node are registered as OTP Cells and
> this cause probe fail with -EINVAL error.
>=20
> This was never notice due to the fact that till now, no Nand supported
> the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> access for MX30LFxG18AC") this changed and coincidentally this Nand is
> used on an FritzBox 7530 supported on OpenWrt.
>=20
> Alternative and more robust way to declare OTP Cells are already
> prossible by using the fixed-layout node or by declaring a child node
> with the compatible set to "otp-user" or "otp-factory".
>=20
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable

The beauty of backward compatibility...

> add_legacy_fixed_of_cells if we have a node called nand since it's the
> standard property name to identify Nand devices attached to a Nand
> Controller.
>=20
> With the following logic, the OTP NVMEM entry is correctly created with
> no Cells and the MTD Nand is correctly probed and partitions are
> correctly exposed.

Thanks for the investigation and the fix. An implementation detail
below.

>=20
> Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old synta=
x fixed OF cells")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/mtdcore.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5887feb347a4..6872477a5129 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(st=
ruct mtd_info *mtd,
>  	config.name =3D compatible;
>  	config.id =3D NVMEM_DEVID_AUTO;
>  	config.owner =3D THIS_MODULE;
> -	config.add_legacy_fixed_of_cells =3D true;
> +	config.add_legacy_fixed_of_cells =3D !of_node_name_eq(mtd->dev.of_node,=
 "nand");

Could we use mtd_type_is_nand() instead?

>  	config.type =3D NVMEM_TYPE_OTP;
>  	config.root_only =3D true;
>  	config.ignore_wp =3D true;

Thanks,
Miqu=C3=A8l

