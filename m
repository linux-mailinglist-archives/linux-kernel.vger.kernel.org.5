Return-Path: <linux-kernel+bounces-94084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8C88739B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF48D1F22659
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE5134406;
	Wed,  6 Mar 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXBlgeae"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E7BA55;
	Wed,  6 Mar 2024 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736496; cv=none; b=c2qtM+L8dYzUpTz0XlorgASIn8xRICymI6bhy+vJmIxfXDZxX+Szq8MU6DiZfvsj5DkkfZCjavITSKDqbPJg9ZczYH/kks6zjutR2NFulSGsDsFknT0wNEoqhpML7d4HmKqGEetdvptLKd0lJ3LK81HT3EhfBtO/kmCBH0rGq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736496; c=relaxed/simple;
	bh=LKxAHNk2aLDWzzV1w2tW3dpSb8kzakIi8zhJRlDYp30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc4A9wbwOIPN7xqv/qyhmtXjuogTpZesVeVJ99UIrF5bckjuqWEblgwPvQjC75gnPAa6DzdESiULcmddNkC/zZ2/adklp371/yR/r0xRR7UJXN8tu5sdQC1n+VGk2DR4Neb8ZYf58ONnEFwRW0ojwub1C+N7FwmXqY11S3jyBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXBlgeae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FFAC433F1;
	Wed,  6 Mar 2024 14:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709736495;
	bh=LKxAHNk2aLDWzzV1w2tW3dpSb8kzakIi8zhJRlDYp30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXBlgeaeEd838cjSpXB5fqRMp0JDlOUS2RNQONh2ebnE3caajbq4gcz5fgrUUrSyU
	 JDGeWAMG9Bd3x0Q0Zixif0b5VboyKVsI8uWeQeIvZPuadhN2GnG1MJasnaniRuvn/x
	 A8RtYP6ecWpHi87rDDNV4VrS9FhOIwMilZU1k03FhdKOZ8eXDrbJ5AdHY5yCNPPldE
	 hnxsilPlv7krDOXsoX6v5EEUo793kDnpUYR48kQKHhlrqJMcltGCEs5wkqN1KHlUnW
	 6kw8Bsa/Ah24iuGlq+MLiZgTuYSE7GBNJ3pm6O0Th8G+8NfhuQFFsJ+5VZJxmLi0KX
	 FslSnN+FajSng==
Date: Wed, 6 Mar 2024 15:48:13 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v15 2/8] phy: Add HDMI configuration options
Message-ID: <20240306-inquisitive-funny-bull-017550@houat>
References: <20240306101625.795732-1-alexander.stein@ew.tq-group.com>
 <20240306101625.795732-3-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wazjs4qrv6r7qq5x"
Content-Disposition: inline
In-Reply-To: <20240306101625.795732-3-alexander.stein@ew.tq-group.com>


--wazjs4qrv6r7qq5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Wed, Mar 06, 2024 at 11:16:19AM +0100, Alexander Stein wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
>=20
> Allow HDMI PHYs to be configured through the generic
> functions through a custom structure added to the generic union.
>=20
> The parameters added here are based on HDMI PHY
> implementation practices.  The current set of parameters
> should cover the potential users.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/phy/phy-hdmi.h | 24 ++++++++++++++++++++++++
>  include/linux/phy/phy.h      |  7 ++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/phy/phy-hdmi.h
>=20
> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
> new file mode 100644
> index 0000000000000..b7de88e9090f0
> --- /dev/null
> +++ b/include/linux/phy/phy-hdmi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#ifndef __PHY_HDMI_H_
> +#define __PHY_HDMI_H_
> +
> +#include <linux/hdmi.h>
> +/**
> + * struct phy_configure_opts_hdmi - HDMI configuration set
> + * @pixel_clk_rate: Pixel clock of video modes in KHz.
> + * @bpc: Maximum bits per color channel.
> + * @color_space: Colorspace in enum hdmi_colorspace.
> + *
> + * This structure is used to represent the configuration state of a HDMI=
 phy.
> + */
> +struct phy_configure_opts_hdmi {
> +	unsigned int pixel_clk_rate;
> +	unsigned int bpc;
> +	enum hdmi_colorspace color_space;
> +};

Does the PHY actually care about the pixel clock rate, color space and
formats, or does it only care about the character rate?

Also, how would you handle pixel doubling?

Maxime

--wazjs4qrv6r7qq5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeiCLAAKCRDj7w1vZxhR
xSnUAP41rpokDnniw6MdmXTRycs0PMI6TgR/87jmxzdVFERWKgEA/uUZeHTkC2sD
5V8zpf6ghz8P69W2+uKQN5GBGohZ5Ag=
=ozbL
-----END PGP SIGNATURE-----

--wazjs4qrv6r7qq5x--

