Return-Path: <linux-kernel+bounces-92879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD6872768
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE5D1F25458
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3F250F4;
	Tue,  5 Mar 2024 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hcl428/B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF122F0C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666346; cv=none; b=sRu5EO2u+7UM5xAH0ikFdDs1z/ytyYtOLanVYoscHvgEGfOiEq2qr/N0tgr0Xjj46vw8w2PgC3Fr+LEXHLcgxq69r9Ns/V6JZ0ERo60WRerxmFmiImQU1l9EKfrvxxf9br4l0+9hBo1HwFAUAnTaLeGnOE2J3qY0Ts+kOruoSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666346; c=relaxed/simple;
	bh=2pqmwWhbDFE9fj+oSo/K14hkY0EiMePV9mlnbLNSnOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B++fzvFn1Dz3f0R6SQfeXlwxbdRa7O3Ooc1/dXy6sydBgUryY22SvkLt0MHgIXCejT6u5g8hsSkEIDrrMlngqyoxYyu8VWdof9dLdG2ZvBBLOiSmJslPgi9mhRLfkxtY5DKli8heT/1jPapJcEfh24cMb9oGfw0K0KD+7rnrER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hcl428/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB75C433F1;
	Tue,  5 Mar 2024 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709666346;
	bh=2pqmwWhbDFE9fj+oSo/K14hkY0EiMePV9mlnbLNSnOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hcl428/BsZzuIg6UQk4pgNZoTOJsi1mRK4HHj1BB72P80J1S4WoU54FXPGT/hUR8w
	 o7ALKyUyMbgaIzXBN/KrlHXa/USc/TpK7udlPk4btiJrhwV/3YC/aJ8nFKO4aWYyiL
	 JWznQa825tVcNxzL5b19Zh3cSczptdWhVpG28JmCIBhDpyLJVcvEzDhlgY/SBA77oW
	 60PCN8zQJfV14lJGYpRR1onn++/9jU6rR8Wp3ysOJjmSMBS+NY9rSuWosCZHZtUs//
	 89i2G290+/R1JCUAYu+yywH9CrtX6zgBdKLU1f3rJmkoZH2ihTKPrZDYIYVx5ucBBy
	 jMFUsejn6VUqw==
Date: Tue, 5 Mar 2024 19:18:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	mengdong.lin@intel.com, yung-chuan.liao@linux.intel.com,
	baojun.xu@ti.com, kevin-lu@ti.com, tiwai@suse.de, soyer@irl.hu,
	Baojun.Xu@fpt.com, navada@ti.com
Subject: Re: [PATCH v10] The tas2783 is a smart audio amplifier with
 integrated MIPI SoundWire interface (Version 1.2.1 compliant), I2C, and
 I2S/TDM interfaces designed for portable applications. An on-chip DSP
 supports Texas Instruments SmartAmp speaker protection algorithm. The
 integrated speaker voltage and current sense provides for real-time
 monitoring of loudspeakers.
Message-ID: <5637d141-d619-4910-bbe7-b30d3a7e7b97@sirena.org.uk>
References: <20240305084336.606-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKtf0G+iFmy3C6u7"
Content-Disposition: inline
In-Reply-To: <20240305084336.606-1-shenghao-ding@ti.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.


--oKtf0G+iFmy3C6u7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 05, 2024 at 04:43:35PM +0800, Shenghao Ding wrote:
> The ASoC component provides the majority of the functionality of the
> device, all the audio functions.

> +static const struct reg_default tas2783_reg_defaults[] = {
> +	/* Default values for ROM mode. Activated. */
> +	{ 0x8002, 0x1a },	/* AMP inactive. */
> +	{ 0x8097, 0xc8 },
> +	{ 0x80b5, 0x74 },
> +	{ 0x8099, 0x20 },
> +	{ 0xfe8d, 0x0d },
> +	{ 0xfebe, 0x4a },
> +	{ 0x8230, 0x00 },
> +	{ 0x8231, 0x00 },
> +	{ 0x8232, 0x00 },
> +	{ 0x8233, 0x01 },
> +	{ 0x8418, 0x00 },	/* Set volume to 0 dB. */
> +	{ 0x8419, 0x00 },
> +	{ 0x841a, 0x00 },
> +	{ 0x841b, 0x00 },
> +	{ 0x8428, 0x40 },	/* Unmute channel */
> +	{ 0x8429, 0x00 },
> +	{ 0x842a, 0x00 },
> +	{ 0x842b, 0x00 },
> +	{ 0x8548, 0x00 },	/* Set volume to 0 dB. */
> +	{ 0x8549, 0x00 },
> +	{ 0x854a, 0x00 },
> +	{ 0x854b, 0x00 },
> +	{ 0x8558, 0x40 },	/* Unmute channel */
> +	{ 0x8559, 0x00 },
> +	{ 0x855a, 0x00 },
> +	{ 0x855b, 0x00 },
> +	{ 0x800a, 0x3a },	/* Enable both channel */

These comments sound like this register default table is not actually
the physical default register values that the chip has...

> +static const struct regmap_config tasdevice_regmap = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.readable_reg = tas2783_readable_register,
> +	.volatile_reg = tas2783_volatile_register,
> +	.max_register = 0x44ffffff,
> +	.reg_defaults = tas2783_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_defaults),

..but this is set as the register defaults.  This will cause problems
with things like cache sync where we don't write values out if they're
not the defaults.  We also try to keep default settings from the silicon
except in the most obvious cases, it avoids issues with trying to work
out what to set and accomodate different use cases for different systems.

If you do need to set non-default values then either just regular writes
during probe or a regmap patch would do it.

> +	.cache_type = REGCACHE_RBTREE,
> +	.use_single_read = true,
> +	.use_single_write = true,

REGCACHE_MAPLE is generally the most sensible choice for modern devices
- it's a newer and fancier data structure underlying it and there's only
a few cases with low end devices, mostly doing block I/O which this
doesn't support, where the RBTREE cache is still better.

> +	u16 dev_info;
> +	int ret;
> +
> +	if (!tas_dev->sdw_peripheral) {
> +		dev_err(tas_dev->dev, "%s: peripheral doesn't exist.\n",
> +			__func__);
> +		return;
> +	}
> +
> +	dev_info = tas_dev->sdw_peripheral->bus->link_id |
> +		tas_dev->sdw_peripheral->id.unique_id << 16;

I'm kind of surprised dev_info works as a variable name without
something getting upset that it aliases the function of the same name.

--oKtf0G+iFmy3C6u7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXncCIACgkQJNaLcl1U
h9DlHwf/Xq+Guwgm78pQq6+8ERCajDkI2IbMJmvrL73zEB29/YvshNpE1wFd0VXZ
VVcz2IWrVhrBlaxUiDv+ByHSJp/jndWlYys6LwuczhXIXsWtV4v17ugHUYjBTXaP
W9mSGzcNFIO0IJmupeEuwjWD1ijHBwuc+fDROf2q+gS+NfVLO/S3h7M0TmyqneLE
k5GM4ZnNFPxNE2F6gDo4gs6PbQFomynEOFDDAtJGAoh1lFhc1RX13+1mDwwE8bYj
NTYBv7aMWKcgAcyxY6jIShRnm/zQgz8QmPNN6qNVdU80fc74WfOffCQea6zGs6It
As0BsfHOKypJ30EMKGyJ6f948zbXFA==
=WXwt
-----END PGP SIGNATURE-----

--oKtf0G+iFmy3C6u7--

