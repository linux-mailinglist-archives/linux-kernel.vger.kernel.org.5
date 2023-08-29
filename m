Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA9578C88E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbjH2PZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbjH2PZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932481B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693322657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FoaczId3AvxtRQ59qXDITQKv68yeRo4BI+wVycOHI1I=;
        b=doXCxi4LYacCPjZ/LPE+CkEyvn7eEJ8S1FNjD+gnRjSCc97FCIYvI6LDhG7Ibz4qTzvm6A
        J+Oo2VuMxlDBrxifD+P4k2iCXF2ShF+XktfBOAhl6dkqFCrSnXYc1PHdQ+/TQvuxGISikp
        wWzi7YNml7Kb1qEgUylRiaCjYWSHuJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-0M6cnihwNvSvV1A-BDFvqg-1; Tue, 29 Aug 2023 11:24:01 -0400
X-MC-Unique: 0M6cnihwNvSvV1A-BDFvqg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3172a94b274so3121079f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693322640; x=1693927440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoaczId3AvxtRQ59qXDITQKv68yeRo4BI+wVycOHI1I=;
        b=SNcur9USNwoiHKugEh02a6kMQspLA6HZwdOEPLYeh+aqHOPv9GXscs9rxj8Dq9jW6i
         GFPVWh+RWVvPiL6ABLrGPuvYV8KbFCTNz8NERS8CNoM/EFpi7Ur1XvbMnJ1TdGhLrE/G
         J645aTyWkv8hmDRlQG2ukvSRBGmHZit6tSi45VuJzBhd3fMU1O3aKMfIGDyoqHNWmuB9
         AdV0JqhuEsY+TijzgvyhwMwB6IpXC3ZcOcEU4yoACqJ/8ddbeD8sgB4TkCtOYqd36JSg
         Qe9okp8MvKkHPOqFoKbmK3+2oLh3hoUQ3oEYDg80eAHXfPY9+C4lKJwtU7Z9OjRWSb+a
         h20Q==
X-Gm-Message-State: AOJu0YzH2R54TxcDR/1O/Ysw4bziCYZs0nYxVkiihXqmD2PbYtGDhiqi
        Ci0EtMj8p1S4eJA5IDD0tab1Eou0eWE/I4McjM/y3j/kAUtioQpi32vuGwGloZHl2Y1Q8os919x
        dt8nNimvnf/+9J0ria4JId9DP
X-Received: by 2002:a5d:6382:0:b0:319:8bd0:d18c with SMTP id p2-20020a5d6382000000b003198bd0d18cmr20827084wru.52.1693322639817;
        Tue, 29 Aug 2023 08:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKM/5RUEdU2op+akf1dybSWYcX+o2Dy79eBZvWDH3TVPUJBRVekfDfrKKa2F8dNkARcvLkrQ==
X-Received: by 2002:a5d:6382:0:b0:319:8bd0:d18c with SMTP id p2-20020a5d6382000000b003198bd0d18cmr20827053wru.52.1693322639416;
        Tue, 29 Aug 2023 08:23:59 -0700 (PDT)
Received: from toolbox ([2001:9e8:898c:cd00:3d7e:40e1:d773:8f52])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b00316eb7770b8sm14208017wrt.5.2023.08.29.08.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:23:59 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:23:57 +0200
From:   Sebastian Wick <sebastian.wick@redhat.com>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC v6 02/10] drm: Introduce solid fill DRM plane property
Message-ID: <20230829152250.GA258687@toolbox>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
 <20230828-solid-fill-v6-2-a820efcce852@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-solid-fill-v6-2-a820efcce852@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:05:08PM -0700, Jessica Zhang wrote:
> Document and add support for solid_fill property to drm_plane. In
> addition, add support for setting and getting the values for solid_fill.
> 
> To enable solid fill planes, userspace must assign a property blob to
> the "solid_fill" plane property containing the following information:
> 
> struct drm_mode_solid_fill {
> 	u32 r, g, b;
> };
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c |  9 ++++++++
>  drivers/gpu/drm/drm_atomic_uapi.c         | 26 ++++++++++++++++++++++
>  drivers/gpu/drm/drm_blend.c               | 30 ++++++++++++++++++++++++++
>  include/drm/drm_blend.h                   |  1 +
>  include/drm/drm_plane.h                   | 36 +++++++++++++++++++++++++++++++
>  include/uapi/drm/drm_mode.h               | 24 +++++++++++++++++++++
>  6 files changed, 126 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 01638c51ce0a..86fb876efbe6 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -254,6 +254,11 @@ void __drm_atomic_helper_plane_state_reset(struct drm_plane_state *plane_state,
>  	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>  	plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
>  
> +	if (plane_state->solid_fill_blob) {
> +		drm_property_blob_put(plane_state->solid_fill_blob);
> +		plane_state->solid_fill_blob = NULL;
> +	}
> +
>  	if (plane->color_encoding_property) {
>  		if (!drm_object_property_get_default_value(&plane->base,
>  							   plane->color_encoding_property,
> @@ -336,6 +341,9 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>  	if (state->fb)
>  		drm_framebuffer_get(state->fb);
>  
> +	if (state->solid_fill_blob)
> +		drm_property_blob_get(state->solid_fill_blob);
> +
>  	state->fence = NULL;
>  	state->commit = NULL;
>  	state->fb_damage_clips = NULL;
> @@ -385,6 +393,7 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
>  		drm_crtc_commit_put(state->commit);
>  
>  	drm_property_blob_put(state->fb_damage_clips);
> +	drm_property_blob_put(state->solid_fill_blob);
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
>  
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 454f980e16c9..1cae596ab693 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -316,6 +316,20 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>  }
>  EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
>  
> +static void drm_atomic_set_solid_fill_prop(struct drm_plane_state *state)
> +{
> +	struct drm_mode_solid_fill *user_info;
> +
> +	if (!state->solid_fill_blob)
> +		return;
> +
> +	user_info = (struct drm_mode_solid_fill *)state->solid_fill_blob->data;
> +
> +	state->solid_fill.r = user_info->r;
> +	state->solid_fill.g = user_info->g;
> +	state->solid_fill.b = user_info->b;
> +}
> +
>  static void set_out_fence_for_crtc(struct drm_atomic_state *state,
>  				   struct drm_crtc *crtc, s32 __user *fence_ptr)
>  {
> @@ -546,6 +560,15 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>  		state->src_h = val;
>  	} else if (property == plane->pixel_source_property) {
>  		state->pixel_source = val;
> +	} else if (property == plane->solid_fill_property) {
> +		ret = drm_atomic_replace_property_blob_from_id(dev,
> +				&state->solid_fill_blob,
> +				val, sizeof(struct drm_mode_solid_fill),
> +				-1, &replaced);
> +		if (ret)
> +			return ret;
> +
> +		drm_atomic_set_solid_fill_prop(state);
>  	} else if (property == plane->alpha_property) {
>  		state->alpha = val;
>  	} else if (property == plane->blend_mode_property) {
> @@ -620,6 +643,9 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>  		*val = state->src_h;
>  	} else if (property == plane->pixel_source_property) {
>  		*val = state->pixel_source;
> +	} else if (property == plane->solid_fill_property) {
> +		*val = state->solid_fill_blob ?
> +			state->solid_fill_blob->base.id : 0;
>  	} else if (property == plane->alpha_property) {
>  		*val = state->alpha;
>  	} else if (property == plane->blend_mode_property) {
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index c3c57bae06b7..273021cc21c8 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -200,6 +200,10 @@
>   *	"FB":
>   *		Framebuffer source set by the "FB_ID" property.
>   *
> + * solid_fill:
> + *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
> + *	contains pixel data that drivers can use to fill a plane.
> + *
>   * Note that all the property extensions described here apply either to the
>   * plane or the CRTC (e.g. for the background color, which currently is not
>   * exposed and assumed to be black).
> @@ -705,3 +709,29 @@ int drm_plane_create_pixel_source_property(struct drm_plane *plane,
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
> +
> +/**
> + * drm_plane_create_solid_fill_property - create a new solid_fill property
> + * @plane: drm plane
> + *
> + * This creates a new property blob that holds pixel data for solid fill planes.
> + * The property is exposed to userspace as a property blob called "solid_fill".
> + *
> + * For information on what the blob contains, see `drm_mode_solid_fill`.
> + */
> +int drm_plane_create_solid_fill_property(struct drm_plane *plane)
> +{
> +	struct drm_property *prop;
> +
> +	prop = drm_property_create(plane->dev,
> +			DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_BLOB,
> +			"solid_fill", 0);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&plane->base, prop, 0);
> +	plane->solid_fill_property = prop;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index 122bbfbaae33..e7158fbee389 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -60,4 +60,5 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>  					 unsigned int supported_modes);
>  int drm_plane_create_pixel_source_property(struct drm_plane *plane,
>  					   unsigned long extra_sources);
> +int drm_plane_create_solid_fill_property(struct drm_plane *plane);
>  #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 89508b4dea4a..a38e18bfb43e 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -46,6 +46,18 @@ enum drm_plane_pixel_source {
>  	DRM_PLANE_PIXEL_SOURCE_MAX
>  };
>  
> +/**
> + * struct solid_fill_property - RGB values for solid fill plane
> + *
> + * TODO: Add solid fill source and corresponding pixel source
> + *       that supports RGBA color
> + */
> +struct drm_solid_fill {
> +	uint32_t r;
> +	uint32_t g;
> +	uint32_t b;
> +};
> +
>  /**
>   * struct drm_plane_state - mutable plane state
>   *
> @@ -130,6 +142,23 @@ struct drm_plane_state {
>  	 */
>  	enum drm_plane_pixel_source pixel_source;
>  
> +	/**
> +	 * @solid_fill_blob:
> +	 *
> +	 * Blob containing relevant information for a solid fill plane
> +	 * including pixel format and data. See

Pixel format is not part of the blob anymore.

> +	 * drm_plane_create_solid_fill_property() for more details.
> +	 */
> +	struct drm_property_blob *solid_fill_blob;
> +
> +	/**
> +	 * @solid_fill:
> +	 *
> +	 * Pixel data for solid fill planes. See
> +	 * drm_plane_create_solid_fill_property() for more details.
> +	 */
> +	struct drm_solid_fill solid_fill;
> +
>  	/**
>  	 * @alpha:
>  	 * Opacity of the plane with 0 as completely transparent and 0xffff as
> @@ -720,6 +749,13 @@ struct drm_plane {
>  	 */
>  	struct drm_property *pixel_source_property;
>  
> +	/**
> +	 * @solid_fill_property:
> +	 * Optional solid_fill property for this plane. See
> +	 * drm_plane_create_solid_fill_property().
> +	 */
> +	struct drm_property *solid_fill_property;
> +
>  	/**
>  	 * @alpha_property:
>  	 * Optional alpha property for this plane. See
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 43691058d28f..1fd92886d66c 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>  	char name[DRM_DISPLAY_MODE_LEN];
>  };
>  
> +/**
> + * struct drm_mode_solid_fill - User info for solid fill planes
> + *
> + * This is the userspace API solid fill information structure.
> + *
> + * Userspace can enable solid fill planes by assigning the plane "solid_fill"
> + * property to a blob containing a single drm_mode_solid_fill struct populated with an RGB323232
> + * color and setting the pixel source to "SOLID_FILL".
> + *
> + * For information on the plane property, see drm_plane_create_solid_fill_property()
> + *
> + * @r: Red color value of single pixel
> + * @g: Green color value of single pixel
> + * @b: Blue color value of single pixel
> + * @pad: padding
> + */
> +struct drm_mode_solid_fill {
> +	__u32 r;
> +	__u32 g;
> +	__u32 b;
> +	__u32 pad;
> +};
> +
> +
>  struct drm_mode_card_res {
>  	__u64 fb_id_ptr;
>  	__u64 crtc_id_ptr;
> 
> -- 
> 2.42.0
> 

