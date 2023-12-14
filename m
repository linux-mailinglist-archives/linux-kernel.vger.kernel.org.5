Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B0E8129C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjLNH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjLNH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:56:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256CB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1F3C433C8;
        Thu, 14 Dec 2023 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702540593;
        bh=GYohYaQkBJpAai27f5S7MwTGcNP4zAZuDnDW4xihkPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uowK/QL/FkkxE5NB64tUf0DVzc4N6MUTuJQF606GCL/VcAsOId9mQ0m4fWxzGfazt
         qHcm7bIS5x8Dq6UiU57YEPp7O9Iy95cu9z13GwrEoDuNAl/QlMCv0FjABfjopPXQ08
         9ctRxUDqO12iD6kYv43QC1FSdDZIkGZVFbFw+Mw7rHYD9af5nrsFvrQuEKz1/9nVN2
         bn/sRJhTU0Zik2EzgvH7izTeJOqxFCAPZ+MWXD58NIM/ziiGkf+UAK55tcKj9k3puY
         IhisxNTQcLRwyQX2UvFgVqNGA4b3HxIuSHlLBR90g2hZpo+cpkBWltHiNdMUkjnSx7
         MHTst425A2IQQ==
Date:   Thu, 14 Dec 2023 08:56:30 +0100
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
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI
 quantization range
Message-ID: <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-5-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itw4ikaomo7ux2j5"
Content-Disposition: inline
In-Reply-To: <20231213195125.212923-5-knaerzche@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itw4ikaomo7ux2j5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Thanks for working on this!

On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
> The display controller will always give full range RGB regardless of the
> mode set, but HDMI requires certain modes to be transmitted in limited
> range RGB. This is especially required for HDMI sinks which do not support
> non-standard quantization ranges.
>=20
> This enables color space conversion for those modes and sets the
> quantization range accordingly in the AVI infoframe.
>=20
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockc=
hip/inno_hdmi.c
> index 345253e033c5..32626a75723c 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -33,6 +33,7 @@ struct hdmi_data_info {
>  	unsigned int enc_in_format;
>  	unsigned int enc_out_format;
>  	unsigned int colorimetry;
> +	bool rgb_limited_range;
>  };
> =20
>  struct inno_hdmi_i2c {
> @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hd=
mi *hdmi,
>  	else
>  		frame.avi.colorspace =3D HDMI_COLORSPACE_RGB;
> =20
> +	if (hdmi->hdmi_data.enc_out_format =3D=3D HDMI_COLORSPACE_RGB) {
> +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
> +						   &hdmi->connector, mode,
> +						   hdmi->hdmi_data.rgb_limited_range ?
> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
> +						   HDMI_QUANTIZATION_RANGE_FULL);
> +	} else {
> +		frame.avi.quantization_range =3D HDMI_QUANTIZATION_RANGE_DEFAULT;
> +		frame.avi.ycc_quantization_range =3D
> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> +	}
> +
>  	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
>  }
> =20
> @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_h=
dmi *hdmi)
>  	if (data->enc_in_format =3D=3D data->enc_out_format) {
>  		if ((data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB) ||
>  		    (data->enc_in_format >=3D HDMI_COLORSPACE_YUV444)) {
> -			value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> -
> -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> -			return 0;
> +			if (data->enc_in_format =3D=3D HDMI_COLORSPACE_RGB &&
> +			    data->enc_out_format =3D=3D HDMI_COLORSPACE_RGB &&
> +			    hdmi->hdmi_data.rgb_limited_range) {
> +				csc_mode =3D CSC_RGB_0_255_TO_RGB_16_235_8BIT;
> +				auto_csc =3D AUTO_CSC_DISABLE;
> +				c0_c2_change =3D C0_C2_CHANGE_DISABLE;
> +				csc_enable =3D v_CSC_ENABLE;
> +			} else {
> +				value =3D v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> +				return 0;
> +			}
>  		}
>  	}
> =20
> @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  	else
>  		hdmi->hdmi_data.colorimetry =3D HDMI_COLORIMETRY_ITU_709;
> =20
> +	hdmi->hdmi_data.rgb_limited_range =3D
> +		drm_default_rgb_quant_range(mode) =3D=3D HDMI_QUANTIZATION_RANGE_LIMIT=
ED;
> +

This patch conflicts heavily with my inno_hdmi patches here (patches 22 to =
38):
https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-65=
38e19d634d@kernel.org/

I would appreciate if you could test and merge them into your series.

In particular, there's no need to store the range here: enc_out_format
is always RGB, so you'll always end up calling
drm_hdmi_avi_infoframe_quant_range(), and you'll always have the same csc v=
alues.

Maxime

--itw4ikaomo7ux2j5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZXq1LgAKCRDj7w1vZxhR
xedRAQCky8rnjv5SW+uCycoYjs8EQF9UmdfoKp6IC/V0MmQyIwD+L0A/RR8/pzVb
fQgZ59YS2O+f5TpHQ/8+FtU01s5a3go=
=AiiD
-----END PGP SIGNATURE-----

--itw4ikaomo7ux2j5--
