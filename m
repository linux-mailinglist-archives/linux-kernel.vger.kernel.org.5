Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63D8129F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443382AbjLNIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbjLNIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:05:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01AC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:06:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1301C433C7;
        Thu, 14 Dec 2023 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702541161;
        bh=sYEhTF8PFiCP41kQDsfl473xLEZ+XXLgBpyKrt1TpZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LY2zHWvRamfUM7o1LtV8JnaxofEdItKMw+27NQM3lch6E+1MGPOJA2pCQIWppcvMG
         641jfW0dbA4X9MXirOWme2ggJCA0rQ8mmNvRy0jcsT8DzQOPDSqbSQmt3B33vsLAtA
         dkC7IR5y7QsI/N95hOp6G+IN+NT0puCHHp7TKCZX07X6qCjfIKq4NAKG75MJjS51RL
         iJgrkK5kDLyFe33Hu2/pDXFAYwhf47d15DvnU2B2+f8FYqzMluDW5k4XZPqK4U8RK4
         8ZEM+z10IqeH9ge1ozkfw6/noYBww1USJSTWzRMaZdVCLzwZnhZsAbqMeU6kS+NE0y
         3qE2qdKH84cDA==
Date:   Thu, 14 Dec 2023 09:05:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] drm/rockchip: inno_hdmi: Add basic mode validation
Message-ID: <wz4e43ateg3gb7745mz22wwyruwavevvpfbqsdxeynejcjxhzn@qbqldsnkktei>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-8-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b7pooqjn5gbbri2j"
Content-Disposition: inline
In-Reply-To: <20231213195125.212923-8-knaerzche@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b7pooqjn5gbbri2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2023 at 08:51:21PM +0100, Alex Bee wrote:
> As per TRM this controller supports pixelclocks starting from 25 MHz. The
> maximum supported pixelclocks are defined by the phy configurations we
> have. Also it can't support modes that require doubled clocks.
> If there is a phy reference clock we can additionally validate against
> VESA DMT's recommendations.
> Those checks are added to the mode_valid hook of the connector and
> encoder's mode_fixup hook.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 38 ++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockc=
hip/inno_hdmi.c
> index f7f0bec725f9..2f839ff31c1c 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -38,6 +38,8 @@ struct inno_hdmi_variant {
>  	struct inno_hdmi_phy_config *default_phy_config;
>  };
> =20
> +#define INNO_HDMI_MIN_TMDS_CLOCK  25000000U
> +
>  struct hdmi_data_info {
>  	int vic;
>  	bool sink_has_audio;
> @@ -572,6 +574,34 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  	return 0;
>  }
> =20
> +static enum drm_mode_status inno_hdmi_mode_valid(struct inno_hdmi *hdmi,
> +						 struct drm_display_mode *mode)
> +{

So, mode_valid is only called to filter out the modes retrieved by
get_modes, but it won't be called when userspace programs a mode. That's
atomic_check's job.

So you probably want to create a shared function between atomic_check
and mode_valid, and call it from both places (or call mode_valid from
atomic_check).

> +	/* No support for double-clock modes */
> +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> +		return MODE_BAD;
> +
> +	unsigned int mpixelclk =3D mode->clock * 1000;

Variables should be declared at the top of the function.

> +	if (mpixelclk < INNO_HDMI_MIN_TMDS_CLOCK)
> +		return MODE_CLOCK_LOW;

You probably want to check the max TMDS clock too?

> +	if (inno_hdmi_find_phy_config(hdmi, mpixelclk) < 0)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (hdmi->refclk) {
> +		long refclk =3D clk_round_rate(hdmi->refclk, mpixelclk);
> +		unsigned int max_tolerance =3D mpixelclk / 5000;
> +
> +		/* Vesa DMT standard mentions +/- 0.5% max tolerance */
> +		if (abs(refclk - mpixelclk) > max_tolerance ||
> +		    mpixelclk - refclk > max_tolerance;
> +			return MODE_NOCLOCK;

You should use abs_diff here. abs() will get confused by the unsigned vs
signed comparison.

> +	}
> +
> +	return MODE_OK;
> +}
> +
>  static void inno_hdmi_encoder_mode_set(struct drm_encoder *encoder,
>  				       struct drm_display_mode *mode,
>  				       struct drm_display_mode *adj_mode)
> @@ -602,7 +632,9 @@ static bool inno_hdmi_encoder_mode_fixup(struct drm_e=
ncoder *encoder,
>  					 const struct drm_display_mode *mode,
>  					 struct drm_display_mode *adj_mode)
>  {
> -	return true;
> +	struct inno_hdmi *hdmi =3D encoder_to_inno_hdmi(encoder);
> +
> +	return inno_hdmi_mode_valid(hdmi, adj_mode) =3D=3D MODE_OK;
>  }

Why do you call mode_valid in mode_fixup?

Maxime

--b7pooqjn5gbbri2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXq3ZgAKCRDj7w1vZxhR
xaVDAP9cv6mFeTDpg7RgRea+Sf7bjeLk6ZsJ3l3oNXqnHls6gAD/cxaEFtITXR/A
ujMQfG/WE5YLTNoxJiT+lbA9A4vu3QA=
=ufKw
-----END PGP SIGNATURE-----

--b7pooqjn5gbbri2j--
