Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2A78C8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjH2Poc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjH2PoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729ACEC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693323769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6sDIU3K4vYx0nS6YYLcsSqypEnaVcZpJGHz3tdgGMc=;
        b=CJvCt50fqCMAh9COza3e0t/bdXTWQcGT8SnEnOeawlDYM/O5H0tQcxEp3cEjfGURpd8IMy
        PYCkMlGPfQMb4GE7SwP1N3TRSHTNH5li1P8MMezr7OheBxLJjCfdZdUB47o660BC3Fl4La
        l7qkjfRsZuBUeiYg0EwHLavF9qc3ADY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-c9C89v_EMgKqXF1vgkSCBQ-1; Tue, 29 Aug 2023 11:42:47 -0400
X-MC-Unique: c9C89v_EMgKqXF1vgkSCBQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso32448875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693323767; x=1693928567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6sDIU3K4vYx0nS6YYLcsSqypEnaVcZpJGHz3tdgGMc=;
        b=X8fTRNcMB0BMRoxEXIpt4mbCtBohms8fwha0l7TwYhDqoYAW0GwEWiiWo2VM49lF2F
         5zAQ50K3okiI2SOlpwexp6/mH8ljZLVc1KG1pzMJmZ0BeuOmXw7mUdXbaNYZ0Ao0uSOb
         m6tGi5wneb/nZdHpgfox/SGaswzDQvHgEjLEFzK/VkOIXOZkr6PBhPmX52Jwkna1kkAA
         FQnUaqQC0gOST030Qg5uQwB7RGuG9ZMjZLnkQpwhPA/zEQwkOiT0MxLkJB3v4p+Lcn8R
         e4jTI17c9Jgoqr/CamziwL7lrvlQFOjnV47qn5Tv2wTK8lZ09R0OLcL9h0/o8WjUxmwY
         wQJw==
X-Gm-Message-State: AOJu0YzUPZARHGfz8juzM8AbB8AwYwVg6V8vGv5w5Zj3MRS6qqCDczx4
        5r5v7AsVHP+dxvVRsnmzWg8utVLBqxBKPxhPVwEH0ZkgUYF8P8/4P6qO2TdsX8XoJ0LXpjeZnk1
        UmFNzKalFd+KnDH1TNRD9YclK
X-Received: by 2002:a05:6000:98c:b0:31d:caae:982c with SMTP id by12-20020a056000098c00b0031dcaae982cmr5603159wrb.47.1693323766839;
        Tue, 29 Aug 2023 08:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE68Tjgg1iNWjdiPHoiTE7fPT5ClNu+9OggcScdoXXlRdgxO5W4SL2VyHLt3ahqOCnHuM4ilw==
X-Received: by 2002:a05:6000:98c:b0:31d:caae:982c with SMTP id by12-20020a056000098c00b0031dcaae982cmr5603141wrb.47.1693323766510;
        Tue, 29 Aug 2023 08:42:46 -0700 (PDT)
Received: from toolbox ([2001:9e8:898c:cd00:3d7e:40e1:d773:8f52])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003fefcbe7fa8sm14264216wmc.28.2023.08.29.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 08:42:46 -0700 (PDT)
Date:   Tue, 29 Aug 2023 17:42:44 +0200
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
Subject: Re: [PATCH RFC v6 00/10] Support for Solid Fill Planes
Message-ID: <20230829154244.GA260653@toolbox>
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:05:06PM -0700, Jessica Zhang wrote:
> Some drivers support hardware that have optimizations for solid fill
> planes. This series aims to expose these capabilities to userspace as
> some compositors have a solid fill flag (ex. SOLID_COLOR in the Android
> hardware composer HAL) that can be set by apps like the Android Gears
> app.
> 
> In order to expose this capability to userspace, this series will:
> 
> - Introduce solid_fill and pixel_source properties to allow userspace to
>   toggle between FB and solid fill sources
> - Loosen NULL FB checks within the DRM atomic commit callstack to allow
>   for NULL FB when solid fill is enabled.
> - Add NULL FB checks in methods where FB was previously assumed to be
>   non-NULL
> - Have MSM DPU driver use drm_plane_state.solid_fill instead of
>   dpu_plane_state.color_fill
> 
> Note: The solid fill planes feature depends on both the solid_fill *and*
> pixel_source properties.
> 
> To use this feature, userspace can set the solid_fill property to a blob
> containing the appropriate version number and solid fill color (in
> RGB323232 format) and and setting the pixel_source property to
> DRM_PLANE_PIXEL_SOURCE_COLOR. This will disable memory fetch and the
> resulting plane will display the color specified by the solid_fill blob.
> 
> Currently, there's only one version of the solid_fill blob property.
> However if other drivers want to support a similar feature, but require
> more than just the solid fill color, they can extend this feature by
> creating additional versions of the drm_solid_fill struct.
> 
> This 2 property approach was chosen because passing in a special 1x1 FB
> with the necessary color information would have unecessary overhead that
> does not reflect the behavior of the solid fill feature. In addition,
> assigning the solid fill blob to FB_ID would require loosening some core
> drm_property checks that might cause unwanted side effects elsewhere.

The cover letter is a bit outdated by now. Anyway, with Pekkas issues
addressed the core drm parts are

Acked-by: Sebastian Wick <sebastian@sebastianwick.net>
 
> ---
> Changes in v6:
> - Have _dpu_plane_color_fill() take in a single ABGR8888 color instead
>   of having separate alpha and BGR color parameters (Dmitry)
> - Drop plane->state->pixel_source != DRM_PLANE_PIXEL_SOURCE_FB check
>   in SetPlane ioctl (Dmitry)
> - Add DRM_PLANE_PIXEL_SOURCE_NONE as a default pixel source (Sebastian)
> - Dropped versioning from solid fill property blob (Dmitry)
> - Use DRM_ENUM_NAME_FN (Dmitry)
> - Use drm_atomic_replace_property_blob_from_id() (Dmitry)
> - drm_atomic_check_fb -> drm_atomic_plane_check_fb (Dmitry)
> - Group redundant NULL FB checks (Dmitry)
> - Squashed drm_plane_needs_disable() implementation with 
>   DRM_PLANE_PIXEL_SOURCE_NONE declaration (Sebastian)
> - Add comment to support RGBA solid fill color in the future (Dmitry)
> - Link to v5: https://lore.kernel.org/r/20230728-solid-fill-v5-0-053dbefa909c@quicinc.com
> 
> Changes in v5:
> - Added support for PIXEL_SOURCE_NONE (Sebastian)
> - Added WARN_ON() in drm_plane_has_visible_data() if pixel_source isn't
>   set (Dmitry)
> - Added debugfs support for both properties (Dmitry)
> - Corrected u32 to u8 conversion (Pekka)
> - Moved drm_solid_fill_info struct and related documentation to
>   include/uapi (Pekka)
> - Changed drm_solid_fill_info.version to __u32 for data alignment (Pekka)
> - Added more detailed UAPI and kernel documentation (Pekka)
> - Reordered patch series so that the pixel_source property is introduced
>   before solid_fill (Dmitry)
> - Fixed inconsistent ABGR8888/RGBA8888 format declaration (Pekka)
> - Reset pixel_source to FB in drm_mode_setplane() (Dmitry)
> - Rename supported_sources to extra_sources (Dmitry)
> - Only destroy old solid_fill blob state if new state is valid (Pekka)
> - Link to v4: https://lore.kernel.org/r/20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com
> 
> Changes in v4:
> - Rebased onto latest kernel
> - Reworded cover letter for clarity (Dmitry)
> - Reworded commit messages for clarity
> - Split existing changes into smaller commits
> - Added pixel_source enum property (Dmitry, Pekka, Ville)
> - Updated drm-kms comment docs with pixel_source and solid_fill
>   properties (Dmitry)
> - Inlined drm_atomic_convert_solid_fill_info() (Dmitry)
> - Passed in plane state alpha value to _dpu_plane_color_fill_pipe()
> - Link to v3: https://lore.kernel.org/r/20230104234036.636-1-quic_jesszhan@quicinc.com
> 
> Changes in v3:
> - Fixed some logic errors in atomic checks (Dmitry)
> - Introduced drm_plane_has_visible_data() and drm_atomic_check_fb() helper
>   methods (Dmitry)
> - Fixed typo in drm_solid_fill struct documentation
> - Created drm_plane_has_visible_data() helper and corrected CRTC and FB
>   NULL-check logic (Dmitry)
> - Merged `if (fb)` blocks in drm_atomic_plane_check() and abstracted
>   them into helper method (Dmitry)
> - Inverted `if (solid_fill_enabled) else if (fb)` check order (Dmitry)
> - Fixed indentation (Dmitry)
> 
> Changes in v2:
> - Dropped SOLID_FILL_FORMAT property (Simon)
> - Switched to implementing solid_fill property as a blob (Simon, Dmitry)
> - Added drm_solid_fill and drm_solid_fill_info structs (Simon)
> - Changed to checks for if solid_fill_blob is set (Dmitry)
> - Abstracted (plane_state && !solid_fill_blob) checks to helper method
>   (Dmitry)
> - Removed DPU_PLANE_COLOR_FILL_FLAG
> - Fixed whitespace and indentation issues (Dmitry)
> - Changed to checks for if solid_fill_blob is set (Dmitry)
> - Abstracted (plane_state && !solid_fill_blob) checks to helper method
>   (Dmitry)
> - Fixed dropped 'const' warning
> - Added helper to convert color fill to BGR888 (Rob)
> - Fixed indentation issue (Dmitry)
> - Added support for solid fill on planes of varying sizes
> 
> ---
> Jessica Zhang (10):
>       drm: Introduce pixel_source DRM plane property
>       drm: Introduce solid fill DRM plane property
>       drm: Add solid fill pixel source
>       drm/atomic: Add pixel source to plane state dump
>       drm/atomic: Add solid fill data to plane state dump
>       drm/atomic: Move framebuffer checks to helper
>       drm/atomic: Loosen FB atomic checks
>       drm/msm/dpu: Allow NULL FBs in atomic commit
>       drm/msm/dpu: Use DRM solid_fill property
>       drm/msm/dpu: Add solid fill and pixel source properties
> 
>  drivers/gpu/drm/drm_atomic.c              | 147 +++++++++++++++++-------------
>  drivers/gpu/drm/drm_atomic_helper.c       |  36 ++++----
>  drivers/gpu/drm/drm_atomic_state_helper.c |  10 ++
>  drivers/gpu/drm/drm_atomic_uapi.c         |  30 ++++++
>  drivers/gpu/drm/drm_blend.c               | 129 ++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_crtc_internal.h       |   1 +
>  drivers/gpu/drm/drm_plane.c               |  27 +++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |   9 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c |  80 ++++++++++------
>  include/drm/drm_atomic_helper.h           |   4 +-
>  include/drm/drm_blend.h                   |   3 +
>  include/drm/drm_plane.h                   |  90 ++++++++++++++++++
>  include/uapi/drm/drm_mode.h               |  24 +++++
>  13 files changed, 478 insertions(+), 112 deletions(-)
> ---
> base-commit: 00ee72279c963989ab435b0bc90b5dc05a9aab79
> change-id: 20230404-solid-fill-05016175db36
> 
> Best regards,
> -- 
> Jessica Zhang <quic_jesszhan@quicinc.com>
> 

