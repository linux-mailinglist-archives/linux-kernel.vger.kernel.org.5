Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB877021D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjHDNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjHDNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E0D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691156650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tpOIG5n3MxbFIH92Jg66Rf7F45WxAwd2M2vqn7RHptk=;
        b=bdtdQB8SmcozPiPBAEhAyv5Ycug5lI4MMh3FdwM5VQhMTlQ1jWnXAUksSlngPwExMk1FCo
        zegEoki1PxZH7joaIkX1+qnQ/v8n7IjF9KAuQX2Ts/Z9i4gB7of8KNoqwCnXrfhN+V2Hde
        6Ef9ej0jOMKgIMtLnO3yR5kuhy40/94=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-uTZFuh4oN4CI5jEimDenkg-1; Fri, 04 Aug 2023 09:44:01 -0400
X-MC-Unique: uTZFuh4oN4CI5jEimDenkg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe2f3cd8caso2518319e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156637; x=1691761437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpOIG5n3MxbFIH92Jg66Rf7F45WxAwd2M2vqn7RHptk=;
        b=goUS4PVQsYJSlVuybu4x/lKY1gUSG0EX3IKJyZiAKVlwjkXyHwOgQXScJDXiuI+DE+
         +1OzG2dKpUd+SmXdKae2lXNpNbxpUB9KAD4pdz2cCSphI1Tlbf+EV7y3zKN+OvTK0a16
         6ivL+LCTnVjEbIKGTbgl1UXHjijVz6DVozDTa1GpEjGDu+GIUeZI/e4UbxpB2pEipzC7
         Eogj1vqT9ukQKvCNTln07Qm7HglOpplPF7JPmFYKAdCOz5+XOnlVLHsNrMvE9l01Dcyx
         txc1Dlz25YY6xaLJedJgZxHENoRvhqo98gHPznWo3ZRYDU/cOipGSJ0hfWcGd+JhKPD5
         /Zyw==
X-Gm-Message-State: AOJu0YzhC0aY9qX6BEufDYxR6qdEFuaJA30YTMg6tAzKdARf12IG977W
        jDWc0cMtNax/jVxknt7jiJONkfpvWSv7EpMDCg42FZA7PTMUzamwPavuedz4LYV+pAGi7xyJxZi
        xzcwKD1o6fRE6nQQBJOnDFdX07bH1auutyykicTm5
X-Received: by 2002:a05:6512:2821:b0:4fb:bef0:948e with SMTP id cf33-20020a056512282100b004fbbef0948emr1624363lfb.5.1691156636882;
        Fri, 04 Aug 2023 06:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4TC7gMZF2ei8j5FBv3RQrBOVNN/MDvRv3kcEy9bNjf6yT6T+EyfwKjB1EnVg7s3ShGDE6vL7iyVUjtK3tb6k=
X-Received: by 2002:a05:6512:2821:b0:4fb:bef0:948e with SMTP id
 cf33-20020a056512282100b004fbbef0948emr1624343lfb.5.1691156636477; Fri, 04
 Aug 2023 06:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com> <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
In-Reply-To: <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
From:   Sebastian Wick <sebastian.wick@redhat.com>
Date:   Fri, 4 Aug 2023 15:43:45 +0200
Message-ID: <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 3:27=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quicinc.com> w=
rote:
> >
> > Document and add support for solid_fill property to drm_plane. In
> > addition, add support for setting and getting the values for solid_fill=
.
> >
> > To enable solid fill planes, userspace must assign a property blob to
> > the "solid_fill" plane property containing the following information:
> >
> > struct drm_mode_solid_fill {
> >         u32 version;
> >         u32 r, g, b;
> > };
> >
> > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > ---
> >  drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
> >  drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++++=
++++++++
> >  drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
> >  include/drm/drm_blend.h                   |  1 +
> >  include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
> >  include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
> >  6 files changed, 154 insertions(+)
> >
>
> [skipped most of the patch]
>
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index 43691058d28f..53c8efa5ad7f 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
> >         char name[DRM_DISPLAY_MODE_LEN];
> >  };
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
> > +       __u32 version;
> > +       __u32 r;
> > +       __u32 g;
> > +       __u32 b;
>
> Another thought about the drm_mode_solid_fill uABI. I still think we
> should add alpha here. The reason is the following:
>
> It is true that we have  drm_plane_state::alpha and the plane's
> "alpha" property. However it is documented as "the plane-wide opacity
> [...] It can be combined with pixel alpha. The pixel values in the
> framebuffers are expected to not be pre-multiplied by the global alpha
> associated to the plane.".
>
> I can imagine a use case, when a user might want to enable plane-wide
> opacity, set "pixel blend mode" to "Coverage" and then switch between
> partially opaque framebuffer and partially opaque solid-fill without
> touching the plane's alpha value.

The only reason I see against this is that there might be some
hardware which supports only RGB but not alpha on planes and they
could then not use this property. Maybe another COLOR_FILL enum value
with alpha might be better? Maybe just doing the alpha via the alpha
property is good enough.

>
> --
> With best wishes
> Dmitry
>

