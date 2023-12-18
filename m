Return-Path: <linux-kernel+bounces-3829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC59817377
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FF1F23E76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05037897;
	Mon, 18 Dec 2023 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LpWZMhU+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEE37868;
	Mon, 18 Dec 2023 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40F0E240002;
	Mon, 18 Dec 2023 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702909278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcFINdpUM3413RjJFum1h+gsTWlsCTgB3Zco0HFf37w=;
	b=LpWZMhU+/FlDz/l6g9cAsHmsE93Bhq4Id8XqSYWOsaMalk5GcvOUsDi//RUZIFy+2Q+nKp
	r0Ue5TYs8IiSKetzoBq1URx/7EQWB342qgDX9X4FQkp3TvAfan3jwJ/jm+EMzOscAy6PJt
	z1av9pI3PSW8EUlbraBlXyEOr+LrwjXs4Fm5641BoWxtj/ZC1A/Qt4/8tguLpW2jCJi9YY
	N4d1OHK+l82zLAWuHEjEGFXpbIQFgiGXVdCq4bJhDwmJDqIhJTzoOkQFokmWPmv+8OtQ/M
	XljLCSnzggt7fIDqzF58t8GnU7eBiYK4OrDKmG307kg9prYOyXR/b0+KZOspMA==
Date: Mon, 18 Dec 2023 15:21:16 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Walle
 <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de, =?UTF-8?B?UmFmYcWC?=
 =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
Message-ID: <20231218152116.59d59bad@xps-13>
In-Reply-To: <20231218133722.16150-4-zajec5@gmail.com>
References: <20231218133722.16150-1-zajec5@gmail.com>
	<20231218133722.16150-4-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:22 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> This patch moves all generic (NVMEM devices independent) code from NVMEM
> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
> code on top of it.
>=20
> Thanks to proper layout it's possible to support U-Boot env data stored
> on any kind of NVMEM device.
>=20
> For backward compatibility with old DT bindings we need to keep old
> NVMEM device driver functional. To avoid code duplication a parsing
> function is exported and reused in it.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---

I have a couple of comments about the original driver which gets
copy-pasted in the new layout driver, maybe you could clean these
(the memory leak should be fixed before the migration so it can be
backported easily, the others are just style so it can be done after, I
don't mind).

...

> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
> +		     enum u_boot_env_format format)
> +{
> +	size_t crc32_data_offset;
> +	size_t crc32_data_len;
> +	size_t crc32_offset;
> +	size_t data_offset;
> +	size_t data_len;
> +	size_t dev_size;
> +	uint32_t crc32;
> +	uint32_t calc;
> +	uint8_t *buf;
> +	int bytes;
> +	int err;
> +
> +	dev_size =3D nvmem_dev_size(nvmem);
> +
> +	buf =3D kcalloc(1, dev_size, GFP_KERNEL);

Out of curiosity, why kcalloc(1,...) rather than kzalloc() ?

> +	if (!buf) {
> +		err =3D -ENOMEM;
> +		goto err_out;

We could directly return ENOMEM here I guess.

> +	}
> +
> +	bytes =3D nvmem_device_read(nvmem, 0, dev_size, buf);
> +	if (bytes < 0)
> +		return bytes;
> +	else if (bytes !=3D dev_size)
> +		return -EIO;

Don't we need to free buf in the above cases?

> +	switch (format) {
> +	case U_BOOT_FORMAT_SINGLE:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_single, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_single, data);
> +		data_offset =3D offsetof(struct u_boot_env_image_single, data);
> +		break;
> +	case U_BOOT_FORMAT_REDUNDANT:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_redundant, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_redundant, data=
);
> +		data_offset =3D offsetof(struct u_boot_env_image_redundant, data);
> +		break;
> +	case U_BOOT_FORMAT_BROADCOM:
> +		crc32_offset =3D offsetof(struct u_boot_env_image_broadcom, crc32);
> +		crc32_data_offset =3D offsetof(struct u_boot_env_image_broadcom, data);
> +		data_offset =3D offsetof(struct u_boot_env_image_broadcom, data);
> +		break;
> +	}
> +	crc32 =3D le32_to_cpu(*(__le32 *)(buf + crc32_offset));

Looks a bit convoluted, any chances we can use intermediate variables
to help decipher this?

> +	crc32_data_len =3D dev_size - crc32_data_offset;
> +	data_len =3D dev_size - data_offset;
> +
> +	calc =3D crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
> +	if (calc !=3D crc32) {
> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", =
calc, crc32);
> +		err =3D -EINVAL;
> +		goto err_kfree;
> +	}
> +
> +	buf[dev_size - 1] =3D '\0';
> +	err =3D u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
> +	if (err)
> +		dev_err(dev, "Failed to add cells: %d\n", err);

Please drop this error message, the only reason for which the function
call would fail is apparently an ENOMEM case.

> +
> +err_kfree:
> +	kfree(buf);
> +err_out:
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
> +
> +static int u_boot_env_add_cells(struct device *dev, struct nvmem_device =
*nvmem)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *layout_np;
> +	enum u_boot_env_format format;
> +
> +	layout_np =3D of_nvmem_layout_get_container(nvmem);
> +	if (!layout_np)
> +		return -ENOENT;
> +
> +	match =3D of_match_node(u_boot_env_of_match_table, layout_np);
> +	if (!match)
> +		return -ENOENT;
> +
> +	format =3D (uintptr_t)match->data;

In the core there is currently an unused helper called
nvmem_layout_get_match_data() which does that. I think the original
intent of this function was to be used in this driver, so depending on
your preference, can you please either use it or remove it?

> +
> +	of_node_put(layout_np);
> +
> +	return u_boot_env_parse(dev, nvmem, format);
> +}

Thanks,
Miqu=C3=A8l

