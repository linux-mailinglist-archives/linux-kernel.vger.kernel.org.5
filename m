Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065957A8A55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjITRMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjITRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:11:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D15DE46;
        Wed, 20 Sep 2023 10:11:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50336768615so172617e87.0;
        Wed, 20 Sep 2023 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695229876; x=1695834676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMbzTBynQLm6QZUqBpYodYKPLfnO9xB2mb7dINMr9fw=;
        b=aQuGIRdtaAuuOt4MYZm1h1mDpqNh+XA8lB3Z+utcax/F21w9fsArEEObRFl8SVpMDY
         /LqV+HoRHuYcnURYv59yziIQM3ivxNNERUWzLpbwOMS0Bk7hhkbG7WcTjBE4Zer98aC+
         ByDuQbNoW1Yyjy5xRY8ifzVZlTDnQYRni7x/N1pR9oLUNxGYjM3+WsjkmjxQRE1Y/EyP
         LWBo22J2vD8sZ8L3vp4W0NSQ5i6L41bBaFbO8rJi12waDmAu6KtfejnWIx2EL0OqDB7u
         e3srm+P1HW/BN+KWyRhZSlHp3s/ltOq73PJK/zlx/l//JhnAPhZ0TDv1qEdNLHEpOflk
         dpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695229876; x=1695834676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMbzTBynQLm6QZUqBpYodYKPLfnO9xB2mb7dINMr9fw=;
        b=UNCHJI5Xl1kH+m+2eT+dKaDtDNOa38lJcvvGhwpfNssKYcApOOvK2OgDzmq8QBkFKu
         ICxolqaENfvYK4+nvWgkNnYyN50MjB4/znulKt9qr8OhSo8tiCFAg6XM/FdERZZdQeyF
         1n1Cdb4D3U3rqC0sadNozqi5ugsiOCMVikNxV9HMCbGZ1YfZhVBL1b2G6BDRQA4gAeBu
         WLtDK/Xcq2CmY6P1CCJSYme7zgOwgJpz2yRlkyK2orCPAKf7/Q5Fmvoi6aUfJMpYRntD
         QHwrbaLiWkgscSmzhyiBaZlg+uJTw1Ijsw57sB5yS46FQYgO665iHI+YdL15rQDVZugQ
         yhYA==
X-Gm-Message-State: AOJu0YzilcL9f6R/3jT/PFrRKSeM4BjsJr2X9lJPqQJbjsj5vOEZ+gTC
        hz1VvMmojDEHmcGZlQzRDIM=
X-Google-Smtp-Source: AGHT+IGkNlNTw25WE3YbpOXK9z6tubyuim4aSXyqEaMrUJzqFux/FPmddT0539Wenok8Oy5/kYWbRQ==
X-Received: by 2002:a05:6512:32b1:b0:501:bdde:5a49 with SMTP id q17-20020a05651232b100b00501bdde5a49mr2716719lfe.15.1695229875653;
        Wed, 20 Sep 2023 10:11:15 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id dn22-20020a05640222f600b00532c1dfe8ecsm2502723edb.66.2023.09.20.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 10:11:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH RFC v2 11/37] drm/connector: hdmi: Add Infoframes generation
Date:   Wed, 20 Sep 2023 19:11:13 +0200
Message-ID: <5873114.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20230920-kms-hdmi-connector-state-v2-11-17932daddd7d@kernel.org>
References: <20230920-kms-hdmi-connector-state-v2-0-17932daddd7d@kernel.org>
 <20230920-kms-hdmi-connector-state-v2-11-17932daddd7d@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 20. september 2023 ob 16:35:26 CEST je Maxime Ripard napisal(a):
> Infoframes in KMS is usually handled by a bunch of low-level helpers
> that require quite some boilerplate for drivers. This leads to
> discrepancies with how drivers generate them, and which are actually
> sent.
> 
> Now that we have everything needed to generate them in the HDMI
> connector state, we can generate them in our common logic so that
> drivers can simply reuse what we precomputed.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig                   |   1 +
>  drivers/gpu/drm/drm_atomic_state_helper.c | 327 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c           |   9 +
>  include/drm/drm_atomic_state_helper.h     |   6 +
>  include/drm/drm_connector.h               | 131 ++++++++++++
>  5 files changed, 474 insertions(+)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index ab9ef1c20349..10caf2dcce93 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -99,6 +99,7 @@ config DRM_KUNIT_TEST
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_DISPLAY_HDMI_HELPER
>  	help
>  	  CRTC helpers for KMS drivers.
>  
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 2f85422cccd4..5bbdd2f7d306 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_writeback.h>
>  
> +#include <drm/display/drm_hdmi_helper.h>
> +
>  #include <linux/slab.h>
>  #include <linux/dma-fence.h>
>  
> @@ -839,6 +841,142 @@ hdmi_compute_config(const struct drm_connector *connector,
>  	return -EINVAL;
>  }
>  
> +static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
> +				       struct drm_connector_state *state)
> +{
> +	const struct drm_display_mode *mode =
> +		connector_state_get_adjusted_mode(state);
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&state->hdmi.infoframes.avi;
> +	struct hdmi_avi_infoframe *frame =
> +		&infoframe->data.avi;
> +	bool is_lim_range =
> +		drm_atomic_helper_connector_hdmi_is_full_range(connector,
> +							       state);
> +	enum hdmi_quantization_range rgb_quant_range =
> +		is_lim_range ? HDMI_QUANTIZATION_RANGE_FULL : HDMI_QUANTIZATION_RANGE_LIMITED;

While usage of is_lim_range is correct, its name is off. Replace lim with full.

Best regards,
Jernej

> +	int ret;
> +
> +	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
> +	if (ret)
> +		return ret;
> +
> +	frame->colorspace = state->hdmi.output_format;
> +
> +	drm_hdmi_avi_infoframe_quant_range(frame, connector, mode, rgb_quant_range);
> +	drm_hdmi_avi_infoframe_colorimetry(frame, state);
> +	drm_hdmi_avi_infoframe_bars(frame, state);
> +
> +	infoframe->set = true;
> +
> +	return 0;
> +}
> +
> +static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
> +				       struct drm_connector_state *state)
> +{
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&state->hdmi.infoframes.spd;
> +	struct hdmi_spd_infoframe *frame =
> +		&infoframe->data.spd;
> +	int ret;
> +
> +	ret = hdmi_spd_infoframe_init(frame,
> +				      connector->hdmi.vendor,
> +				      connector->hdmi.product);
> +	if (ret)
> +		return ret;
> +
> +	frame->sdi = HDMI_SPD_SDI_PC;
> +
> +	infoframe->set = true;
> +
> +	return 0;
> +}
> +
> +static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
> +				       struct drm_connector_state *state)
> +{
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&state->hdmi.infoframes.drm;
> +	struct hdmi_drm_infoframe *frame =
> +		&infoframe->data.drm;
> +	int ret;
> +
> +	if (connector->max_bpc < 10)
> +		return 0;
> +
> +	if (!state->hdr_output_metadata)
> +		return 0;
> +
> +	ret = drm_hdmi_infoframe_set_hdr_metadata(frame, state);
> +	if (ret)
> +		return ret;
> +
> +	infoframe->set = true;
> +
> +	return 0;
> +}
> +
> +static int hdmi_generate_vendor_infoframe(const struct drm_connector *connector,
> +					  struct drm_connector_state *state)
> +{
> +	const struct drm_display_mode *mode =
> +		connector_state_get_adjusted_mode(state);
> +	struct drm_connector_hdmi_infoframe *infoframe =
> +		&state->hdmi.infoframes.vendor;
> +	struct hdmi_vendor_infoframe *frame =
> +		&infoframe->data.vendor.hdmi;
> +	int ret;
> +
> +	ret = drm_hdmi_vendor_infoframe_from_display_mode(frame, connector, mode);
> +	if (ret == -EINVAL)
> +		return 0;
> +	else
> +		return ret;
> +
> +	infoframe->set = true;
> +
> +	return 0;
> +}
> +
> +static int
> +hdmi_generate_infoframes(const struct drm_connector *connector,
> +			 struct drm_connector_state *state)
> +{
> +	const struct drm_display_info *info = &connector->display_info;
> +	int ret;
> +
> +	if (!info->is_hdmi)
> +		return 0;
> +
> +	if (!info->has_hdmi_infoframe)
> +		return 0;
> +
> +	ret = hdmi_generate_avi_infoframe(connector, state);
> +	if (ret)
> +		return ret;
> +
> +	ret = hdmi_generate_spd_infoframe(connector, state);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Audio Infoframes will be generated by ALSA, and updated by
> +	 * drm_atomic_helper_connector_hdmi_update_audio_infoframe().
> +	 */
> +
> +	ret = hdmi_generate_hdr_infoframe(connector, state);
> +	if (ret)
> +		return ret;
> +
> +	ret = hdmi_generate_vendor_infoframe(connector, state);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /**
>   * drm_atomic_helper_connector_hdmi_check() - Helper to check HDMI connector atomic state
>   * @connector: DRM Connector
> @@ -866,6 +1004,10 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>  	if (!ret)
>  		return ret;
>  
> +	ret = hdmi_generate_infoframes(connector, new_state);
> +	if (ret)
> +		return ret;
> +
>  	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb ||
>  	    old_state->hdmi.output_bpc != new_state->hdmi.output_bpc ||
>  	    old_state->hdmi.output_format != new_state->hdmi.output_format) {
> @@ -912,6 +1054,191 @@ drm_atomic_helper_connector_hdmi_is_full_range(const struct drm_connector *conne
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_is_full_range);
>  
> +#define HDMI_MAX_INFOFRAME_SIZE		29
> +
> +static int clear_device_infoframe(struct drm_connector *connector,
> +				  enum hdmi_infoframe_type type)
> +{
> +	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
> +
> +	if (!funcs || !funcs->clear_infoframe)
> +		return 0;
> +
> +	return funcs->clear_infoframe(connector, type);
> +}
> +
> +static int clear_infoframe(struct drm_connector *connector,
> +			   struct drm_connector_hdmi_infoframe *conn_frame,
> +			   struct drm_connector_hdmi_infoframe *old_frame)
> +{
> +	int ret;
> +
> +	ret = clear_device_infoframe(connector, old_frame->data.any.type);
> +	if (ret)
> +		return ret;
> +
> +	memset(old_frame, 0, sizeof(*old_frame));
> +
> +	return 0;
> +}
> +
> +static int write_device_infoframe(struct drm_connector *connector,
> +				  union hdmi_infoframe *frame)
> +{
> +	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
> +	u8 buffer[HDMI_MAX_INFOFRAME_SIZE];
> +	int len;
> +
> +	if (!funcs || !funcs->write_infoframe)
> +		return -ENOSYS;
> +
> +	len = hdmi_infoframe_pack(frame, buffer, sizeof(buffer));
> +	if (len < 0)
> +		return len;
> +
> +	return funcs->write_infoframe(connector, frame->any.type, buffer, len);
> +}
> +
> +static int write_infoframe(struct drm_connector *connector,
> +			   struct drm_connector_hdmi_infoframe *conn_frame,
> +			   struct drm_connector_hdmi_infoframe *new_frame)
> +{
> +	int ret;
> +
> +	ret = write_device_infoframe(connector, &new_frame->data);
> +	if (ret)
> +		return ret;
> +
> +	if (conn_frame)
> +		memcpy(conn_frame, new_frame, sizeof(*conn_frame));
> +
> +	return 0;
> +}
> +
> +static int write_or_clear_infoframe(struct drm_connector *connector,
> +				    struct drm_connector_hdmi_infoframe *conn_frame,
> +				    struct drm_connector_hdmi_infoframe *old_frame,
> +				    struct drm_connector_hdmi_infoframe *new_frame)
> +{
> +	if (new_frame->set)
> +		return write_infoframe(connector, conn_frame, new_frame);
> +
> +	if (old_frame->set && !new_frame->set)
> +		return clear_infoframe(connector, conn_frame, old_frame);
> +
> +	return 0;
> +}
> +
> +#define UPDATE_INFOFRAME(c, os, ns, i)				\
> +	write_or_clear_infoframe(c,				\
> +				 &(c)->hdmi.infoframes.i,	\
> +				 &(os)->hdmi.infoframes.i,	\
> +				 &(ns)->hdmi.infoframes.i)
> +
> +/**
> + * drm_atomic_helper_connector_hdmi_update_infoframes - Update the Infoframes
> + * @connector: A pointer to the HDMI connector
> + * @state: The HDMI connector state to generate the infoframe from
> + *
> + * This function is meant for HDMI connector drivers to write their
> + * infoframes. It will typically be used in a
> + * @drm_connector_helper_funcs.atomic_enable implementation.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
> +						       struct drm_atomic_state *state)
> +{
> +	struct drm_connector_state *old_state =
> +		drm_atomic_get_old_connector_state(state, connector);
> +	struct drm_connector_state *new_state =
> +		drm_atomic_get_new_connector_state(state, connector);
> +	struct drm_display_info *info = &connector->display_info;
> +	int ret;
> +
> +	if (!info->is_hdmi)
> +		return 0;
> +
> +	if (!info->has_hdmi_infoframe)
> +		return 0;
> +
> +	mutex_lock(&connector->hdmi.infoframes.lock);
> +
> +	ret = UPDATE_INFOFRAME(connector, old_state, new_state, avi);
> +	if (ret)
> +		goto out;
> +
> +	if (connector->hdmi.infoframes.audio.set) {
> +		ret = write_infoframe(connector,
> +				      NULL,
> +				      &connector->hdmi.infoframes.audio);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret = UPDATE_INFOFRAME(connector, old_state, new_state, drm);
> +	if (ret)
> +		goto out;
> +
> +	ret = UPDATE_INFOFRAME(connector, old_state, new_state, spd);
> +	if (ret)
> +		goto out;
> +
> +	ret = UPDATE_INFOFRAME(connector, old_state, new_state, vendor);
> +	if (ret)
> +		goto out;
> +
> +out:
> +	mutex_unlock(&connector->hdmi.infoframes.lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_infoframes);
> +
> +#undef UPDATE_INFOFRAME
> +#undef UPDATE_INFOFRAME_TOGGLE
> +
> +/**
> + * drm_atomic_helper_connector_hdmi_update_audio_infoframe - Update the Audio Infoframe
> + * @connector: A pointer to the HDMI connector
> + * @frame: A pointer to the audio infoframe to write
> + *
> + * This function is meant for HDMI connector drivers to update their
> + * audio infoframe. It will typically be used in one of the ALSA hooks
> + * (most likely prepare).
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + */
> +int
> +drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,
> +							struct hdmi_audio_infoframe *frame)
> +{
> +	struct drm_connector_hdmi_infoframe infoframe = {};
> +	struct drm_display_info *info = &connector->display_info;
> +	int ret;
> +
> +	if (!info->is_hdmi)
> +		return 0;
> +
> +	if (!info->has_hdmi_infoframe)
> +		return 0;
> +
> +	memcpy(&infoframe.data, frame, sizeof(infoframe.data));
> +	infoframe.set = true;
> +
> +	mutex_lock(&connector->hdmi.infoframes.lock);
> +
> +	ret = write_infoframe(connector,
> +			      &connector->hdmi.infoframes.audio,
> +			      &infoframe);
> +
> +	mutex_unlock(&connector->hdmi.infoframes.lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_audio_infoframe);
> +
>  /**
>   * __drm_atomic_helper_connector_duplicate_state - copy atomic connector state
>   * @connector: connector object
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 2bc52465f940..a338552bab19 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -456,6 +456,8 @@ EXPORT_SYMBOL(drmm_connector_init);
>   * drmm_connector_hdmi_init - Init a preallocated HDMI connector
>   * @dev: DRM device
>   * @connector: A pointer to the HDMI connector to init
> + * @vendor: HDMI Controller Vendor name
> + * @product: HDMI Controller Product name
>   * @funcs: callbacks for this connector
>   * @hdmi_funcs: HDMI-related callbacks for this connector
>   * @connector_type: user visible type of the connector
> @@ -476,6 +478,7 @@ EXPORT_SYMBOL(drmm_connector_init);
>   */
>  int drmm_connector_hdmi_init(struct drm_device *dev,
>  			     struct drm_connector *connector,
> +			     const char *vendor, const char *product,
>  			     const struct drm_connector_funcs *funcs,
>  			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
>  			     int connector_type,
> @@ -494,6 +497,12 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>  		return ret;
>  
>  	connector->hdmi.supported_formats = supported_formats;
> +	strscpy(connector->hdmi.vendor, vendor, sizeof(connector->hdmi.vendor));
> +	strscpy(connector->hdmi.product, product, sizeof(connector->hdmi.product));
> +
> +	ret = drmm_mutex_init(dev, &connector->hdmi.infoframes.lock);
> +	if (ret)
> +		return ret;
>  
>  	if (max_bpc) {
>  		if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index c6d941b9e846..4d445ff907f0 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -40,6 +40,8 @@ struct drm_private_state;
>  struct drm_modeset_acquire_ctx;
>  struct drm_device;
>  
> +struct hdmi_audio_infoframe;
> +
>  void __drm_atomic_helper_crtc_state_reset(struct drm_crtc_state *state,
>  					  struct drm_crtc *crtc);
>  void __drm_atomic_helper_crtc_reset(struct drm_crtc *crtc,
> @@ -92,6 +94,10 @@ void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
>  bool
>  drm_atomic_helper_connector_hdmi_is_full_range(const struct drm_connector *connector,
>  					       const struct drm_connector_state *state);
> +int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,
> +							    struct hdmi_audio_infoframe *frame);
> +int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *connector,
> +						       struct drm_atomic_state *state);
>  
>  void __drm_atomic_helper_private_obj_duplicate_state(struct drm_private_obj *obj,
>  						     struct drm_private_state *state);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 468cae3cb739..b5c21e971439 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -908,6 +908,21 @@ struct drm_tv_connector_state {
>  	unsigned int hue;
>  };
>  
> +/**
> + * struct drm_connector_hdmi_infoframe - HDMI Infoframe container
> + */
> +struct drm_connector_hdmi_infoframe {
> +	/**
> +	 * @data: HDMI Infoframe structure
> +	 */
> +	union hdmi_infoframe data;
> +
> +	/**
> +	 * @set: Is the content of @data valid?
> +	 */
> +	bool set;
> +};
> +
>  /**
>   * struct drm_connector_state - mutable connector state
>   */
> @@ -1060,6 +1075,35 @@ struct drm_connector_state {
>  		 */
>  		enum drm_hdmi_broadcast_rgb broadcast_rgb;
>  
> +		/**
> +		 * @infoframes: HDMI Infoframes matching that state
> +		 */
> +		struct {
> +			/**
> +			 * @avi: AVI Infoframes structure matching our
> +			 * state.
> +			 */
> +			struct drm_connector_hdmi_infoframe avi;
> +
> +			/**
> +			 * @drm: DRM Infoframes structure matching our
> +			 * state.
> +			 */
> +			struct drm_connector_hdmi_infoframe drm;
> +
> +			/**
> +			 * @spd: SPD Infoframes structure matching our
> +			 * state.
> +			 */
> +			struct drm_connector_hdmi_infoframe spd;
> +
> +			/**
> +			 * @vendor: Vendor Infoframes structure matching
> +			 * our state.
> +			 */
> +			struct drm_connector_hdmi_infoframe vendor;
> +		} infoframes;
> +
>  		/**
>  		 * @output_bpc: Bits per character to output.
>  		 */
> @@ -1099,6 +1143,41 @@ struct drm_connector_hdmi_funcs {
>  	(*tmds_char_rate_valid)(const struct drm_connector *connector,
>  				const struct drm_display_mode *mode,
>  				unsigned long long tmds_rate);
> +
> +	/**
> +	 * @clear_infoframe:
> +	 *
> +	 * This callback is invoked through
> +	 * @drm_atomic_helper_hdmi_connector_update_infoframes during a
> +	 * commit to clear the infoframes into the hardware. It will be
> +	 * called multiple times, once for every disabled infoframe
> +	 * type.
> +	 *
> +	 * The @clear_infoframe callback is optional.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*clear_infoframe)(struct drm_connector *connector,
> +			       enum hdmi_infoframe_type type);
> +
> +	/**
> +	 * @write_infoframe:
> +	 *
> +	 * This callback is invoked through
> +	 * @drm_atomic_helper_hdmi_connector_update_infoframes during a
> +	 * commit to program the infoframes into the hardware. It will
> +	 * be called multiple times, once for every updated infoframe
> +	 * type.
> +	 *
> +	 * The @write_infoframe callback is mandatory.
> +	 *
> +	 * Returns:
> +	 * 0 on success, a negative error code otherwise
> +	 */
> +	int (*write_infoframe)(struct drm_connector *connector,
> +			       enum hdmi_infoframe_type type,
> +			       const u8 *buffer, size_t len);
>  };
>  
>  /**
> @@ -1966,6 +2045,16 @@ struct drm_connector {
>  	struct hdr_sink_metadata hdr_sink_metadata;
>  
>  	struct {
> +		/**
> +		 * @vendor: HDMI Controller Vendor Name
> +		 */
> +		char vendor[8];
> +
> +		/**
> +		 * @product: HDMI Controller Product Name
> +		 */
> +		char product[16];
> +
>  		/**
>  		 * @supported_formats: Bitmask of @hdmi_colorspace
>  		 * supported by the controller.
> @@ -1976,6 +2065,47 @@ struct drm_connector {
>  		 * @funcs: HDMI connector Control Functions
>  		 */
>  		const struct drm_connector_hdmi_funcs *funcs;
> +
> +		/**
> +		 * @infoframes: Current Infoframes output by the connector
> +		 */
> +		struct {
> +			/**
> +			 * @lock: Mutex protecting against concurrent access to
> +			 * the infoframes, most notably between KMS and ALSA.
> +			 */
> +			struct mutex lock;
> +
> +			/**
> +			 * @audio: Current Audio Infoframes structure. Protected
> +			 * by @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe audio;
> +
> +			/**
> +			 * @avi: Current AVI Infoframes structure. Protected by
> +			 * @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe avi;
> +
> +			/**
> +			 * @drm: Current DRM Infoframes structure. Protected by
> +			 * @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe drm;
> +
> +			/**
> +			 * @spd: Current SPD Infoframes structure. Protected by
> +			 * @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe spd;
> +
> +			/**
> +			 * @vendor: Current Vendor Infoframes structure.
> +			 * Protected by @lock.
> +			 */
> +			struct drm_connector_hdmi_infoframe vendor;
> +		} infoframes;
>  	} hdmi;
>  };
>  
> @@ -1997,6 +2127,7 @@ int drmm_connector_init(struct drm_device *dev,
>  			struct i2c_adapter *ddc);
>  int drmm_connector_hdmi_init(struct drm_device *dev,
>  			     struct drm_connector *connector,
> +			     const char *vendor, const char *product,
>  			     const struct drm_connector_funcs *funcs,
>  			     const struct drm_connector_hdmi_funcs *hdmi_funcs,
>  			     int connector_type,
> 
> 




