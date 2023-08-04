Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C4477020D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHDNmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjHDNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76365D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691156463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tlOjcpvzyvdUZX6WQcYQRud6QY78+2LarUcSa9ov2A=;
        b=iNS8WnSebJ3KUY531b4MWaW8oqXgSmBsBW2wmL7rQ1UIBRdgULBwEK8Vqz4dpsC74G/MBe
        P4rJ80pUXJ3iVEvmo0hsI7mdcxAjXHRsmYifmsQC1X+qDN5SckWK8O3/DRbhkUVlKoG7v3
        5gPN4XMQQTcCtvQInH3BYKBOytQx3pE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-VsjaMp76NCSI4KGnGera3w-1; Fri, 04 Aug 2023 09:41:01 -0400
X-MC-Unique: VsjaMp76NCSI4KGnGera3w-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fe0e1dfdbaso2147640e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156458; x=1691761258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tlOjcpvzyvdUZX6WQcYQRud6QY78+2LarUcSa9ov2A=;
        b=YLO0UECA4LfzYSMlr1acOfB8wUt+WbR+7wbI6wKCsoCPBTs8PobU69FiwzaMNaxRCS
         BMi5NtC+dGkN0O7Mc3L3VncTQgZEY1nnu3gfpNXTisu9kMBlGTPb2X7U+ZZA9r8vbiSC
         +qbpyIkwfTXT7QvzUNK1f+cYCm9N4qq36xuV43GRgs9UzxyuRFaKHXdN/8yTXowUQpa3
         Spidu06UvtxhNl9R3VaKhUNhNW+r6PZjSWSRg5l2kiMxjmbBQ01R2p9anK3Hn7B6q81a
         CqMv5ElUEpfjuT2AYZg0TsODtBeZ+S2Gh5MOd6Fomaui8rDXx8h8WpPv23keEskiBU+T
         b6yw==
X-Gm-Message-State: AOJu0YwmlJ3+3mam0S8fwTplxY2hSvg75OpqqGA+RmVtV286j7hxeawN
        9mRkSAt1YXnv5926P4RDrHVFCCAD5dJbL6A/DOfB8Xgi0cl9pPd1EHOXL/D+gKdnqxR58Zo1GIv
        AMkz6omEgiTv0Jnyl0BG12vFtVLn+V0SiFRibPi0b
X-Received: by 2002:a05:6512:3b9d:b0:4f8:4512:c844 with SMTP id g29-20020a0565123b9d00b004f84512c844mr1874694lfv.48.1691156458009;
        Fri, 04 Aug 2023 06:40:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLNWSneEILM7HUCpaT16wE5JuYtHyHgBpp+t4lYBLHLFeTEOTo/2oy63+9NJ1J+zqMwXF34uZs79rrgjthmS4=
X-Received: by 2002:a05:6512:3b9d:b0:4f8:4512:c844 with SMTP id
 g29-20020a0565123b9d00b004f84512c844mr1874655lfv.48.1691156457497; Fri, 04
 Aug 2023 06:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com> <de8388d2-5625-2737-3997-4fa23baa3693@linaro.org>
In-Reply-To: <de8388d2-5625-2737-3997-4fa23baa3693@linaro.org>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Fri, 4 Aug 2023 15:40:46 +0200
Message-ID: <CA+hFU4xgtJ2HrBMYWsbvL9LA546+v+-s=XQnsSr1vehJ36L-Kw@mail.gmail.com>
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        ville.syrjala@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 6:01=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 28/07/2023 20:02, Jessica Zhang wrote:
> > Document and add support for solid_fill property to drm_plane. In
> > addition, add support for setting and getting the values for solid_fill=
.
> >
> > To enable solid fill planes, userspace must assign a property blob to
> > the "solid_fill" plane property containing the following information:
> >
> > struct drm_mode_solid_fill {
> >       u32 version;
> >       u32 r, g, b;
> > };
> >
> > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> >   drivers/gpu/drm/drm_atomic_uapi.c         | 55 ++++++++++++++++++++++=
+++++++++
> >   drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
> >   include/drm/drm_blend.h                   |  1 +
> >   include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
> >   include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> >   6 files changed, 154 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index 01638c51ce0a..86fb876efbe6 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -254,6 +254,11 @@ void __drm_atomic_helper_plane_state_reset(struct =
drm_plane_state *plane_state,
> >       plane_state->pixel_blend_mode =3D DRM_MODE_BLEND_PREMULTI;
> >       plane_state->pixel_source =3D DRM_PLANE_PIXEL_SOURCE_FB;
> >
> > +     if (plane_state->solid_fill_blob) {
> > +             drm_property_blob_put(plane_state->solid_fill_blob);
> > +             plane_state->solid_fill_blob =3D NULL;
> > +     }
> > +
> >       if (plane->color_encoding_property) {
> >               if (!drm_object_property_get_default_value(&plane->base,
> >                                                          plane->color_e=
ncoding_property,
> > @@ -336,6 +341,9 @@ void __drm_atomic_helper_plane_duplicate_state(stru=
ct drm_plane *plane,
> >       if (state->fb)
> >               drm_framebuffer_get(state->fb);
> >
> > +     if (state->solid_fill_blob)
> > +             drm_property_blob_get(state->solid_fill_blob);
> > +
> >       state->fence =3D NULL;
> >       state->commit =3D NULL;
> >       state->fb_damage_clips =3D NULL;
> > @@ -385,6 +393,7 @@ void __drm_atomic_helper_plane_destroy_state(struct=
 drm_plane_state *state)
> >               drm_crtc_commit_put(state->commit);
> >
> >       drm_property_blob_put(state->fb_damage_clips);
> > +     drm_property_blob_put(state->solid_fill_blob);
> >   }
> >   EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
> >
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_at=
omic_uapi.c
> > index 454f980e16c9..039686c78c2a 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -316,6 +316,51 @@ drm_atomic_set_crtc_for_connector(struct drm_conne=
ctor_state *conn_state,
> >   }
> >   EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
> >
> > +static int drm_atomic_set_solid_fill_prop(struct drm_plane_state *stat=
e,
> > +             struct drm_property_blob *blob)
> > +{
> > +     int blob_version;
> > +
> > +     if (blob =3D=3D state->solid_fill_blob)
> > +             return 0;
> > +
> > +     if (blob) {
> > +             struct drm_mode_solid_fill *user_info =3D (struct drm_mod=
e_solid_fill *)blob->data;
> > +
> > +             if (blob->length !=3D sizeof(struct drm_mode_solid_fill))=
 {
> > +                     drm_dbg_atomic(state->plane->dev,
> > +                                    "[PLANE:%d:%s] bad solid fill blob=
 length: %zu\n",
> > +                                    state->plane->base.id, state->plan=
e->name,
> > +                                    blob->length);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             blob_version =3D user_info->version;
>
> I remember that we had versioning for quite some time. However it stroke
> me while reviewing that we do not a way to negotiate supported
> SOLID_FILL versions. However as we now have support for different
> pixel_source properties, maybe we can drop version completely. If at
> some point a driver needs to support different kind of SOLID_FILL
> property (consider v2), we can add new pixel source to the enum.

Agreed. Let's drop the versioning.

>
> > +
> > +             /* Add more versions if necessary */
> > +             if (blob_version =3D=3D 1) {
> > +                     state->solid_fill.r =3D user_info->r;
> > +                     state->solid_fill.g =3D user_info->g;
> > +                     state->solid_fill.b =3D user_info->b;
> > +             } else {
> > +                     drm_dbg_atomic(state->plane->dev,
> > +                                    "[PLANE:%d:%s] unsupported solid f=
ill version (version=3D%d)\n",
> > +                                    state->plane->base.id, state->plan=
e->name,
> > +                                    blob_version);
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     drm_property_blob_put(state->solid_fill_blob);
> > +
> > +     if (blob)
> > +             state->solid_fill_blob =3D drm_property_blob_get(blob);
> > +     else
> > +             state->solid_fill_blob =3D NULL;
> > +
> > +     return 0;
> > +}
> > +
> >   static void set_out_fence_for_crtc(struct drm_atomic_state *state,
> >                                  struct drm_crtc *crtc, s32 __user *fen=
ce_ptr)
> >   {
> > @@ -546,6 +591,13 @@ static int drm_atomic_plane_set_property(struct dr=
m_plane *plane,
> >               state->src_h =3D val;
> >       } else if (property =3D=3D plane->pixel_source_property) {
> >               state->pixel_source =3D val;
> > +     } else if (property =3D=3D plane->solid_fill_property) {
> > +             struct drm_property_blob *solid_fill =3D drm_property_loo=
kup_blob(dev, val);
> > +
> > +             ret =3D drm_atomic_set_solid_fill_prop(state, solid_fill)=
;
> > +             drm_property_blob_put(solid_fill);
> > +
> > +             return ret;
>
> Bonus point: dropping version from SOLID_FILL would allow us to use
> drm_atomic_replace_property_blob_from_id() here.
>
> >       } else if (property =3D=3D plane->alpha_property) {
> >               state->alpha =3D val;
> >       } else if (property =3D=3D plane->blend_mode_property) {
> > @@ -620,6 +672,9 @@ drm_atomic_plane_get_property(struct drm_plane *pla=
ne,
> >               *val =3D state->src_h;
> >       } else if (property =3D=3D plane->pixel_source_property) {
> >               *val =3D state->pixel_source;
> > +     } else if (property =3D=3D plane->solid_fill_property) {
> > +             *val =3D state->solid_fill_blob ?
> > +                     state->solid_fill_blob->base.id : 0;
> >       } else if (property =3D=3D plane->alpha_property) {
> >               *val =3D state->alpha;
> >       } else if (property =3D=3D plane->blend_mode_property) {
> > diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> > index c500310a3d09..c632dfcd8a9b 100644
> > --- a/drivers/gpu/drm/drm_blend.c
> > +++ b/drivers/gpu/drm/drm_blend.c
> > @@ -200,6 +200,10 @@
> >    *  "FB":
> >    *          Framebuffer source set by the "FB_ID" property.
> >    *
> > + * solid_fill:
> > + *   solid_fill is set up with drm_plane_create_solid_fill_property().=
 It
> > + *   contains pixel data that drivers can use to fill a plane.
> > + *
> >    * Note that all the property extensions described here apply either =
to the
> >    * plane or the CRTC (e.g. for the background color, which currently =
is not
> >    * exposed and assumed to be black).
> > @@ -700,3 +704,29 @@ int drm_plane_create_pixel_source_property(struct =
drm_plane *plane,
> >       return 0;
> >   }
> >   EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
> > +
> > +/**
> > + * drm_plane_create_solid_fill_property - create a new solid_fill prop=
erty
> > + * @plane: drm plane
> > + *
> > + * This creates a new property blob that holds pixel data for solid fi=
ll planes.
> > + * The property is exposed to userspace as a property blob called "sol=
id_fill".
> > + *
> > + * For information on what the blob contains, see `drm_mode_solid_fill=
`.
> > + */
> > +int drm_plane_create_solid_fill_property(struct drm_plane *plane)
> > +{
> > +     struct drm_property *prop;
> > +
> > +     prop =3D drm_property_create(plane->dev,
> > +                     DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_BLOB,
> > +                     "solid_fill", 0);
> > +     if (!prop)
> > +             return -ENOMEM;
> > +
> > +     drm_object_attach_property(&plane->base, prop, 0);
> > +     plane->solid_fill_property =3D prop;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
> > diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> > index 122bbfbaae33..e7158fbee389 100644
> > --- a/include/drm/drm_blend.h
> > +++ b/include/drm/drm_blend.h
> > @@ -60,4 +60,5 @@ int drm_plane_create_blend_mode_property(struct drm_p=
lane *plane,
> >                                        unsigned int supported_modes);
> >   int drm_plane_create_pixel_source_property(struct drm_plane *plane,
> >                                          unsigned long extra_sources);
> > +int drm_plane_create_solid_fill_property(struct drm_plane *plane);
> >   #endif
> > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > index 89508b4dea4a..abf1458fa099 100644
> > --- a/include/drm/drm_plane.h
> > +++ b/include/drm/drm_plane.h
> > @@ -46,6 +46,17 @@ enum drm_plane_pixel_source {
> >       DRM_PLANE_PIXEL_SOURCE_MAX
> >   };
> >
> > +/**
> > + * struct solid_fill_property - RGB values for solid fill plane
> > + *
> > + * Note: This is the V1 for this feature
> > + */
> > +struct drm_solid_fill {
> > +     uint32_t r;
> > +     uint32_t g;
> > +     uint32_t b;
> > +};
> > +
> >   /**
> >    * struct drm_plane_state - mutable plane state
> >    *
> > @@ -130,6 +141,23 @@ struct drm_plane_state {
> >        */
> >       enum drm_plane_pixel_source pixel_source;
> >
> > +     /**
> > +      * @solid_fill_blob:
> > +      *
> > +      * Blob containing relevant information for a solid fill plane
> > +      * including pixel format and data. See
> > +      * drm_plane_create_solid_fill_property() for more details.
> > +      */
> > +     struct drm_property_blob *solid_fill_blob;
> > +
> > +     /**
> > +      * @solid_fill:
> > +      *
> > +      * Pixel data for solid fill planes. See
> > +      * drm_plane_create_solid_fill_property() for more details.
> > +      */
> > +     struct drm_solid_fill solid_fill;
> > +
> >       /**
> >        * @alpha:
> >        * Opacity of the plane with 0 as completely transparent and 0xff=
ff as
> > @@ -720,6 +748,13 @@ struct drm_plane {
> >        */
> >       struct drm_property *pixel_source_property;
> >
> > +     /**
> > +      * @solid_fill_property:
> > +      * Optional solid_fill property for this plane. See
> > +      * drm_plane_create_solid_fill_property().
> > +      */
> > +     struct drm_property *solid_fill_property;
> > +
> >       /**
> >        * @alpha_property:
> >        * Optional alpha property for this plane. See
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 43691058d28f..53c8efa5ad7f 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
> >       char name[DRM_DISPLAY_MODE_LEN];
> >   };
> >
> > +/**
> > + * struct drm_mode_solid_fill - User info for solid fill planes
> > + *
> > + * This is the userspace API solid fill information structure.
> > + *
> > + * Userspace can enable solid fill planes by assigning the plane "soli=
d_fill"
> > + * property to a blob containing a single drm_mode_solid_fill struct p=
opulated with an RGB323232
> > + * color and setting the pixel source to "SOLID_FILL".
> > + *
> > + * For information on the plane property, see drm_plane_create_solid_f=
ill_property()
> > + *
> > + * @version: Version of the blob. Currently, there is only support for=
 version =3D=3D 1
> > + * @r: Red color value of single pixel
> > + * @g: Green color value of single pixel
> > + * @b: Blue color value of single pixel
> > + */
> > +struct drm_mode_solid_fill {
> > +     __u32 version;
> > +     __u32 r;
> > +     __u32 g;
> > +     __u32 b;
> > +};
> > +
> > +
> >   struct drm_mode_card_res {
> >       __u64 fb_id_ptr;
> >       __u64 crtc_id_ptr;
> >
>
> --
> With best wishes
> Dmitry
>

