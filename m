Return-Path: <linux-kernel+bounces-64129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A2853A76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BA71F246B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE31D69B;
	Tue, 13 Feb 2024 19:02:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541D10796;
	Tue, 13 Feb 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850922; cv=none; b=n0di4JOs4S+KErgHh6fURPcdnbaC4Sp79F2MAB6Xs40/9EJcHw+eLfvKsvAzjzlYcNETQDT4fdsE4AC3u04TU9AsAgyCqshR27Hn+DKCB73PxQhqXUZXfo5d2g64X86rbVkI/bNRTyl4lIiyIRgVxF8sJ+uaORnb+iUQzE4hK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850922; c=relaxed/simple;
	bh=3tNonKfBBFuXoYeTWvX8IDZRQ9mkZTw6tQXwn8u+Hvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQ6H1Rbog+pbsPv0S6DkvvrXdSTIT0OWjHGRZuPiSwY24jL6TGNPAxOt/zCW7mLVng7QQ4vzuitxVpevbAzJaymv15GAlcYPW4/2pXFJCudbPbYSGTc5hCj1ht/2neCfYc7AUjTJkHG5gGNd94frC6rxPABWfTqCskf5/7y/kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZy2H-00088l-Vd; Tue, 13 Feb 2024 20:01:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
 Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Maxime Ripard <mripard@kernel.org>
Subject:
 Re: [PATCH v6 31/36] drm/rockchip: inno_hdmi: Switch to HDMI connector
Date: Tue, 13 Feb 2024 20:01:40 +0100
Message-ID: <1852174.atdPhlSkOF@phil>
In-Reply-To: <20240212-kms-hdmi-connector-state-v6-31-f4bcdc979e6f@kernel.org>
References:
 <20240212-kms-hdmi-connector-state-v6-0-f4bcdc979e6f@kernel.org>
 <20240212-kms-hdmi-connector-state-v6-31-f4bcdc979e6f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 12. Februar 2024, 14:13:14 CET schrieb Maxime Ripard:
> The new HDMI connector infrastructure allows to remove some boilerplate,
> especially to generate infoframes. Let's switch to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 123 ++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> index 1d2261643743..d59947679042 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -67,9 +67,7 @@ struct inno_hdmi {
>  
>  struct inno_hdmi_connector_state {
>  	struct drm_connector_state	base;
> -	unsigned int			enc_out_format;
>  	unsigned int			colorimetry;
> -	bool				rgb_limited_range;
>  };
>  
>  static struct inno_hdmi *encoder_to_inno_hdmi(struct drm_encoder *encoder)
> @@ -257,26 +255,29 @@ static void inno_hdmi_reset(struct inno_hdmi *hdmi)
>  	inno_hdmi_standby(hdmi);
>  }
>  
> -static void inno_hdmi_disable_frame(struct inno_hdmi *hdmi,
> -				    enum hdmi_infoframe_type type)
> +static int inno_hdmi_disable_frame(struct drm_connector *connector,
> +				   enum hdmi_infoframe_type type)
>  {
> -	struct drm_connector *connector = &hdmi->connector;
> +	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
>  
>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
>  		drm_err(connector->dev,
>  			"Unsupported infoframe type: %u\n", type);
> -		return;
> +		return 0;
>  	}
>  
>  	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_AVI);
> +
> +	return 0;
>  }
>  
> -static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
> -				  union hdmi_infoframe *frame, enum hdmi_infoframe_type type)
> +static int inno_hdmi_upload_frame(struct drm_connector *connector,
> +				  enum hdmi_infoframe_type type,
> +				  const u8 *buffer, size_t len)
>  {
> -	struct drm_connector *connector = &hdmi->connector;
> +	struct inno_hdmi *hdmi = connector_to_inno_hdmi(connector);
>  	u8 packed_frame[HDMI_MAXIMUM_INFO_FRAME_SIZE];
> -	ssize_t rc, i;
> +	ssize_t i;
>  
>  	if (type != HDMI_INFOFRAME_TYPE_AVI) {
>  		drm_err(connector->dev,
> @@ -284,59 +285,19 @@ static int inno_hdmi_upload_frame(struct inno_hdmi *hdmi,
>  		return 0;
>  	}
>  
> -	inno_hdmi_disable_frame(hdmi, type);
> +	inno_hdmi_disable_frame(connector, type);
>  
> -	rc = hdmi_infoframe_pack(frame, packed_frame,
> -				 sizeof(packed_frame));
> -	if (rc < 0)
> -		return rc;
> -
> -	for (i = 0; i < rc; i++)
> +	for (i = 0; i < len; i++)
>  		hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_ADDR + i,
>  			    packed_frame[i]);
>  
>  	return 0;
>  }
>  
> -static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
> -				      struct drm_display_mode *mode)
> -{
> -	struct drm_connector *connector = &hdmi->connector;
> -	struct drm_connector_state *conn_state = connector->state;
> -	struct inno_hdmi_connector_state *inno_conn_state =
> -					to_inno_hdmi_conn_state(conn_state);
> -	union hdmi_infoframe frame;
> -	int rc;
> -
> -	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
> -						      &hdmi->connector,
> -						      mode);
> -	if (rc) {
> -		inno_hdmi_disable_frame(hdmi, HDMI_INFOFRAME_TYPE_AVI);
> -		return rc;
> -	}
> -
> -	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444)
> -		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
> -	else if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV422)
> -		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
> -	else
> -		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
> -
> -	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_RGB) {
> -		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
> -						   connector, mode,
> -						   inno_conn_state->rgb_limited_range ?
> -						   HDMI_QUANTIZATION_RANGE_LIMITED :
> -						   HDMI_QUANTIZATION_RANGE_FULL);
> -	} else {
> -		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
> -		frame.avi.ycc_quantization_range =
> -			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> -	}
> -
> -	return inno_hdmi_upload_frame(hdmi, &frame, HDMI_INFOFRAME_TYPE_AVI);
> -}
> +static const struct drm_connector_hdmi_funcs inno_hdmi_hdmi_connector_funcs = {
> +	.clear_infoframe	= inno_hdmi_disable_frame,
> +	.write_infoframe	= inno_hdmi_upload_frame,
> +};
>  
>  static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>  {
> @@ -361,8 +322,8 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>  		v_VIDEO_INPUT_CSP(0);
>  	hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL2, value);
>  
> -	if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_RGB) {
> -		if (inno_conn_state->rgb_limited_range) {
> +	if (conn_state->hdmi.output_format == HDMI_COLORSPACE_RGB) {
> +		if (!conn_state->hdmi.is_full_range) {
>  			csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
>  			auto_csc = AUTO_CSC_DISABLE;
>  			c0_c2_change = C0_C2_CHANGE_DISABLE;
> @@ -380,14 +341,14 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>  		}
>  	} else {
>  		if (inno_conn_state->colorimetry == HDMI_COLORIMETRY_ITU_601) {
> -			if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
> +			if (conn_state->hdmi.output_format == HDMI_COLORSPACE_YUV444) {
>  				csc_mode = CSC_RGB_0_255_TO_ITU601_16_235_8BIT;
>  				auto_csc = AUTO_CSC_DISABLE;
>  				c0_c2_change = C0_C2_CHANGE_DISABLE;
>  				csc_enable = v_CSC_ENABLE;
>  			}
>  		} else {
> -			if (inno_conn_state->enc_out_format == HDMI_COLORSPACE_YUV444) {
> +			if (conn_state->hdmi.output_format == HDMI_COLORSPACE_YUV444) {
>  				csc_mode = CSC_RGB_0_255_TO_ITU709_16_235_8BIT;
>  				auto_csc = AUTO_CSC_DISABLE;
>  				c0_c2_change = C0_C2_CHANGE_DISABLE;
> @@ -462,10 +423,12 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
>  }
>  
>  static int inno_hdmi_setup(struct inno_hdmi *hdmi,
> -			   struct drm_display_mode *mode)
> +			   struct drm_crtc_state *new_crtc_state,
> +			   struct drm_connector_state *new_conn_state)
>  {
> -	struct drm_display_info *display = &hdmi->connector.display_info;
> -	unsigned long mpixelclock = mode->clock * 1000;
> +	struct drm_connector *connector = &hdmi->connector;
> +	struct drm_display_info *display = &connector->display_info;
> +	struct drm_display_mode *mode = &new_crtc_state->adjusted_mode;
>  
>  	/* Mute video and audio output */
>  	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
> @@ -479,8 +442,8 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  
>  	inno_hdmi_config_video_csc(hdmi);
>  
> -	if (display->is_hdmi)
> -		inno_hdmi_config_video_avi(hdmi, mode);
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector,
> +							   new_conn_state->state);
>  
>  	/*
>  	 * When IP controller have configured to an accurate video
> @@ -488,13 +451,13 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>  	 * DCLK_LCDC, so we need to init the TMDS rate to mode pixel
>  	 * clock rate, and reconfigure the DDC clock.
>  	 */
> -	inno_hdmi_i2c_init(hdmi, mpixelclock);
> +	inno_hdmi_i2c_init(hdmi, new_conn_state->hdmi.tmds_char_rate);
>  
>  	/* Unmute video and audio output */
>  	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
>  		  v_AUDIO_MUTE(0) | v_VIDEO_MUTE(0));
>  
> -	inno_hdmi_power_up(hdmi, mpixelclock);
> +	inno_hdmi_power_up(hdmi, new_conn_state->hdmi.tmds_char_rate);
>  
>  	return 0;
>  }
> @@ -546,7 +509,7 @@ static void inno_hdmi_encoder_enable(struct drm_encoder *encoder,
>  	if (WARN_ON(!crtc_state))
>  		return;
>  
> -	inno_hdmi_setup(hdmi, &crtc_state->adjusted_mode);
> +	inno_hdmi_setup(hdmi, crtc_state, conn_state);
>  }
>  
>  static void inno_hdmi_encoder_disable(struct drm_encoder *encoder,
> @@ -563,7 +526,6 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
>  			       struct drm_connector_state *conn_state)
>  {
>  	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
> -	struct inno_hdmi *hdmi = encoder_to_inno_hdmi(encoder);
>  	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
>  	u8 vic = drm_match_cea_mode(mode);
>  	struct inno_hdmi_connector_state *inno_conn_state =
> @@ -580,12 +542,7 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
>  	else
>  		inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
>  
> -	inno_conn_state->enc_out_format = HDMI_COLORSPACE_RGB;
> -	inno_conn_state->rgb_limited_range =
> -		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
> -
> -	return  inno_hdmi_display_mode_valid(hdmi,
> -				&crtc_state->adjusted_mode) == MODE_OK ? 0 : -EINVAL;
> +	return 0;
>  }
>  
>  static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
> @@ -662,10 +619,9 @@ static void inno_hdmi_connector_reset(struct drm_connector *connector)
>  		return;
>  
>  	__drm_atomic_helper_connector_reset(connector, &inno_conn_state->base);
> +	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
>  
>  	inno_conn_state->colorimetry = HDMI_COLORIMETRY_ITU_709;
> -	inno_conn_state->enc_out_format = HDMI_COLORSPACE_RGB;
> -	inno_conn_state->rgb_limited_range = false;
>  }
>  
>  static struct drm_connector_state *
> @@ -698,6 +654,7 @@ static const struct drm_connector_funcs inno_hdmi_connector_funcs = {
>  };
>  
>  static struct drm_connector_helper_funcs inno_hdmi_connector_helper_funcs = {
> +	.atomic_check = drm_atomic_helper_connector_hdmi_check,
>  	.get_modes = inno_hdmi_connector_get_modes,
>  	.mode_valid = inno_hdmi_connector_mode_valid,
>  };
> @@ -725,10 +682,14 @@ static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
>  
>  	drm_connector_helper_add(&hdmi->connector,
>  				 &inno_hdmi_connector_helper_funcs);
> -	drm_connector_init_with_ddc(drm, &hdmi->connector,
> -				    &inno_hdmi_connector_funcs,
> -				    DRM_MODE_CONNECTOR_HDMIA,
> -				    hdmi->ddc);
> +	drmm_connector_hdmi_init(drm, &hdmi->connector,
> +				 "Rockchip", "Inno HDMI",
> +				 &inno_hdmi_connector_funcs,
> +				 &inno_hdmi_hdmi_connector_funcs,
> +				 DRM_MODE_CONNECTOR_HDMIA,
> +				 hdmi->ddc,
> +				 BIT(HDMI_COLORSPACE_RGB),
> +				 8);
>  
>  	drm_connector_attach_encoder(&hdmi->connector, encoder);
>  
> 
> 





