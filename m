Return-Path: <linux-kernel+bounces-101611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF987A957
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F611C219E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2C44652F;
	Wed, 13 Mar 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lSSQi3xc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566C41A80;
	Wed, 13 Mar 2024 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339434; cv=none; b=jwLOQq6SNtPJmH1mt4/p6QpcI//tsEQqUuewT67SenjCRvBQ8tbJcFVPd/Ky3DnO8iMqa2hd5+u3wk9lsifbC1j3Ukj2uBt8i0dRoIBEXKa457EnCet4sOnb4C7zHfF+m5fgxaSkS0WLYrggYOtvvydEGJsVnJKsD+7HqJblQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339434; c=relaxed/simple;
	bh=7LeOG2wNuxDjCRbEa+kiNhbHeBP3r4A3vvB0gv+OL1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icaIFBTIbQqZG8qJIpZcW+Rgo+eGs5/p6BPM3zpHGeW1Vmg2n6gmSCPKgEDOoovq9MRDk0KZYg72LqZ25yVBbjFCcGx+NugaCrdAx65gXb/Iq47NtE7dhm4TU59Cu2FpCvV2eUaqM/3r54ki6YtJrR4F858pnNbjpJ0WE9qd0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lSSQi3xc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710339431;
	bh=7LeOG2wNuxDjCRbEa+kiNhbHeBP3r4A3vvB0gv+OL1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSSQi3xcCksgyjMDBukyOvFXAqcj6zABeVftEMLPXBvAz3ZUF9aONImTVbkJL4mFq
	 fSz1SeNylIwugM4ZgfGQ6o6/yFsnXJVIanSABL1R4XAGkfX0NCA99H4rZqBxQe2W6F
	 ei7OplwH9OSwGDXVKvzzel5+BiJyICrp8R205slhxuB8xAfeqsV/0LrjEhiHMAIwNE
	 VRaWQ+R+8W8oyfgNGlCFUjLtusKYFKcGmBPsfdkh/fehr1wfpplv7a6HBqan5n/u5i
	 D8I8dmYOGAS2kG0swlvF7SXCxCYtgkoybq58Df8L6tUIK0YK0S9UL0HATzOgu8vO0S
	 6REnjOzPiBQiA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 820EE37820D4;
	Wed, 13 Mar 2024 14:17:11 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 13DD81061C35; Wed, 13 Mar 2024 15:17:11 +0100 (CET)
Date: Wed, 13 Mar 2024 15:17:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-rk: Remove unused of_gpio.h
Message-ID: <mz55sv7refxxpf7krrbbu4etnim6z7kv4ksovg2vsoi5dzymub@hsi3qgqnzm3k>
References: <20240313140057.2088667-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4m5pnqu3w2utz3e"
Content-Disposition: inline
In-Reply-To: <20240313140057.2088667-1-andriy.shevchenko@linux.intel.com>


--s4m5pnqu3w2utz3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 13, 2024 at 04:00:57PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net=
/ethernet/stmicro/stmmac/dwmac-rk.c
> index 382e8de1255d..7ae04d8d291c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -12,10 +12,8 @@
>  #include <linux/clk.h>
>  #include <linux/phy.h>
>  #include <linux/of_net.h>
> -#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/delay.h>
> --=20
> 2.43.0.rc1.1.gbec44491f096
>=20

--s4m5pnqu3w2utz3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXxtV4ACgkQ2O7X88g7
+ppV1A//fyQqXP+7uaMBcWR9nRq+3t4g6Z61t1qGl8setP/+tyCbdYlUZ7CWSBAq
Kk/fxK5Jh9ChrPByBz8/kNmub2Qj/x0iHKyabQYcH9p0Ifon98pP+D/Cw5olXAIf
e4uq/bKHwSPe8XnB9YSgseVci5CSqBzwoc+1pZkhi2zZwTskKq6jFar/KWDE6GiL
1QdlO5JOojO6Iv+cJKtqSmZ0ebc6WvhDb25Kcz0bkNy2znTy0XZlpVZrHCFV0SXf
6lDxoBN6vba7rVq+2RFnT6ieam+5L8unJGn0cnePHoWQX9yekrrZNMfdYDBZxIfj
PdB4vVt8aQohtGRU0m36RfKiQEDGim61oji9NiHhLPt8yhWSK0kWPy5An5LfnyvS
0HGkd5lKGYSlfTM71bt7YkAL1ixgJZ3iOzfe/J2KlpyarZMCskh2ycB+4vl0XJkS
rC5OwSXtLF+/34mHJblKiMaKcIxrLX5Pssa/d+6EE8lfVTqlkZdPRipyPZUbdZ7r
J+JibT3Yv5coDWAnkBBeB+P9rKj9CUXK2NHA9exN/3cKnYglBn2T8BC8XiaSVOWd
ITDvFSs3fQjLjXtOB1UbA2nJHl8kVtifdQDTd0oXVnR6FuBp+I2lG2nLVhzeQ4NA
+8ZdWZIhI0lxvN9xMHLS17MpnvBh/0iEUtPAlkN6/Z3kM1IAfk8=
=bv+r
-----END PGP SIGNATURE-----

--s4m5pnqu3w2utz3e--

