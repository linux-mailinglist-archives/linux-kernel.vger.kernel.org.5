Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB47623EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjGYUu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGYUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75F1B0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690318176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeONIz/Q4uQt+4XkSXhcxSe2PuQ/hyoDF1WmXfyyucM=;
        b=d8bOxlp2dH/3NOuBPUlzHzI60I//3hRnjzVDDMfhzb9RAmBxHDE8EmdzqVkBDlptpTVF5n
        ZaB4EBXlwiKn5knoqAr+sWESLpS2x79P4iI/Pv5pqDn1iL9o39UmzYsd+klBB4ql85yt4j
        6U6nEv6zfb3MsJVsY87VaDjPa/aNMNw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-8uXYEa6aMoe5XXWrNu6UnA-1; Tue, 25 Jul 2023 16:49:34 -0400
X-MC-Unique: 8uXYEa6aMoe5XXWrNu6UnA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3113da8b778so2828050f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318173; x=1690922973;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeONIz/Q4uQt+4XkSXhcxSe2PuQ/hyoDF1WmXfyyucM=;
        b=KnAaIkMN6qCzyRXBQ+O35n8r76Yqr2batxhNqLcW1advYjIMnXmKSioWNzhduZ776h
         kFxI8fu3rSWEUBCNflnwgidmJ7KxoYTmH633xfs1sfNSjsfdDNT93mqwq6rBKaVtAZfr
         neOAJmNI76qLAA8v7ROceX6Av7VZvykofmU18ejYEJblyTrs5phfAYmrq/4EsAIyBgWH
         YHZQJqSynyhN9UeOzjRgb1rSNWr+WVNpP2NXGtEdsHOGx4CXF3URKI59KSpfX2nt6drO
         UCERH69A/b1reH8khooYWa1LmFpLL90dyuCjR5NV0WoplOe/bW67I3Hqc/nT6UQXyVm+
         EIJQ==
X-Gm-Message-State: ABy/qLbbOVT+5BpHMX3hzbyowyqE5UbKDTq38IFVaqrXPfNOK3EY7C4B
        YnAzGbba/br/EOHhmPSiH+lA1Pg18DIMeWIymiIfEF7vlH1JkmmxZc7RvgpSRcCF1wj6azUsVYW
        jsalg5Mh2+eeDCUAvXkWOum40
X-Received: by 2002:adf:fec8:0:b0:313:f86f:2851 with SMTP id q8-20020adffec8000000b00313f86f2851mr11511699wrs.3.1690318173121;
        Tue, 25 Jul 2023 13:49:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7aHh/EHl2VpFeDBeaNz+w7LOEj3C2tIPTs6riDSwNDLpSDNQOzmSMzvJj9B29oNH8XF3gGA==
X-Received: by 2002:adf:fec8:0:b0:313:f86f:2851 with SMTP id q8-20020adffec8000000b00313f86f2851mr11511692wrs.3.1690318172663;
        Tue, 25 Jul 2023 13:49:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b00314417f5272sm17436732wrq.64.2023.07.25.13.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:49:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
In-Reply-To: <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
References: <20230721070955.1170974-1-javierm@redhat.com>
 <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
Date:   Tue, 25 Jul 2023 22:49:31 +0200
Message-ID: <871qgvk97o.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> Thanks for your patch!
>

Thanks a lot for your feedabck.

> On Fri, Jul 21, 2023 at 9:10=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert reports that the following NULL pointer dereference happens for him

[...]

>
>> Since the primary plane buffer is allocated in the encoder .atomic_enable
>> callback, this happens after that initial modeset commit and leads to the
>> mentioned NULL pointer dereference.
>
> Upon further investigation, the NULL pointer dereference does not
> happen with the current and accepted code (only with my patches to
> add support for R1), because of the "superfluous" NULL buffer check
> in ssd130x_fb_blit_rect():
> https://cgit.freedesktop.org/drm-misc/tree/drivers/gpu/drm/solomon/ssd130=
x.c#n592
>
> So you probably want to drop the crash report...
>
>> Fix this by having custom helpers to allocate, duplicate and destroy the
>> plane state, that will take care of allocating and freeing these buffers.
>>
>> Instead of doing it in the encoder atomic enabled and disabled callbacks,
>> since allocations must not be done in an .atomic_enable handler. Because
>> drivers are not allowed to fail after drm_atomic_helper_swap_state() has
>> been called and the new atomic state is stored into the current sw state.
>>
>> Fixes: 49d7d581ceaf ("drm/ssd130x: Don't allocate buffers on each plane =
update")
>
> ... and the Fixes tag.
>

Ah, I see. Thanks a lot for that information.

>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Will drop your Reported-by tag too then.

>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Regardless, avoiding calls to ssd130x_fb_blit_rect() when the buffer
> is not yet allocated is worthwhile.  And this patch achieves that.
>

Agreed, and as Maxime mentioned is the correct thing to do.

> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Thanks for testing!

> Still, some comments below.
>
>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> @@ -141,12 +141,26 @@ const struct ssd130x_deviceinfo ssd130x_variants[]=
 =3D {
>>  };
>>  EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
>>
>> +struct ssd130x_plane_state {
>> +       struct drm_plane_state base;
>> +       /* Intermediate buffer to convert pixels from XRGB8888 to R1 */
>> +       u8 *buffer;
>> +       /* Buffer that contains R1 pixels to be written to the panel */
>> +       u8 *data_array;
>
> The second buffer actually contains pixels in hardware format.
> For now that is a transposed buffer of R1 pixels, but that will change
> when you will add support for greyscale displays.
>
> So I'd write "hardware format" instead of R1 for both.
>

Agreed.

> BTW, I still think data_array should be allocated during probing,
> as it is related to the hardware, not to a plane.
>

Ack. I'll do that as a separate patch on v5.

>> +};
>
>> @@ -159,23 +173,23 @@ static int ssd130x_buf_alloc(struct ssd130x_device=
 *ssd130x)
>>
>>         pitch =3D drm_format_info_min_pitch(fi, 0, ssd130x->width);
>>
>> -       ssd130x->buffer =3D kcalloc(pitch, ssd130x->height, GFP_KERNEL);
>> -       if (!ssd130x->buffer)
>> +       ssd130x_state->buffer =3D kcalloc(pitch, ssd130x->height, GFP_KE=
RNEL);
>> +       if (!ssd130x_state->buffer)
>>                 return -ENOMEM;
>>
>> -       ssd130x->data_array =3D kcalloc(ssd130x->width, pages, GFP_KERNE=
L);
>> -       if (!ssd130x->data_array) {
>> -               kfree(ssd130x->buffer);
>> +       ssd130x_state->data_array =3D kcalloc(ssd130x->width, pages, GFP=
_KERNEL);
>> +       if (!ssd130x_state->data_array) {
>> +               kfree(ssd130x_state->buffer);
>
> Should ssd130x_state->buffer be reset to NULL here?
> I.e. if .atomic_check() fails, will .atomic_destroy_state() be called,
> leading to a double free?
>

Yeah. I'll add it.

>>                 return -ENOMEM;
>>         }
>>
>>         return 0;
>>  }
>
>> @@ -576,18 +593,21 @@ static void ssd130x_clear_screen(struct ssd130x_de=
vice *ssd130x)
>>                 .y2 =3D ssd130x->height,
>>         };
>>
>> -       ssd130x_update_rect(ssd130x, &fullscreen);
>> +       ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);
>>  }
>>
>> -static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struc=
t iosys_map *vmap,
>> +static int ssd130x_fb_blit_rect(struct drm_plane_state *state,
>> +                               const struct iosys_map *vmap,
>>                                 struct drm_rect *rect)
>>  {
>> +       struct drm_framebuffer *fb =3D state->fb;
>>         struct ssd130x_device *ssd130x =3D drm_to_ssd130x(fb->dev);
>> +       struct ssd130x_plane_state *ssd130x_state =3D to_ssd130x_plane_s=
tate(state);
>>         unsigned int page_height =3D ssd130x->device_info->page_height;
>>         struct iosys_map dst;
>>         unsigned int dst_pitch;
>>         int ret =3D 0;
>> -       u8 *buf =3D ssd130x->buffer;
>> +       u8 *buf =3D ssd130x_state->buffer;
>>
>>         if (!buf)
>
> This check should no longer be needed (and prevented you from seeing
> the issue before).
>

Ack.

>>                 return 0;

[...]

>> +static int ssd130x_primary_plane_helper_atomic_check(struct drm_plane *=
plane,
>> +                                                    struct drm_atomic_s=
tate *state)
>> +{
>> +       struct drm_device *drm =3D plane->dev;
>> +       struct ssd130x_device *ssd130x =3D drm_to_ssd130x(drm);
>> +       struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane=
_state(state, plane);
>> +       struct ssd130x_plane_state *ssd130x_state =3D to_ssd130x_plane_s=
tate(plane_state);
>> +       int ret;
>> +
>> +       ret =3D drm_plane_helper_atomic_check(plane, state);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return ssd130x_buf_alloc(ssd130x, ssd130x_state);
>
> I think the code would become easier to read by inlining
> ssd130x_buf_alloc() here.
>

Agreed. I'll do that.

>> +}
>> +
>
>> +static struct drm_plane_state *ssd130x_primary_plane_duplicate_state(st=
ruct drm_plane *plane)
>> +{
>> +       struct ssd130x_plane_state *old_ssd130x_state;
>> +       struct ssd130x_plane_state *ssd130x_state;
>> +
>> +       if (WARN_ON(!plane->state))
>> +               return NULL;
>> +
>> +       old_ssd130x_state =3D to_ssd130x_plane_state(plane->state);
>> +       ssd130x_state =3D kmemdup(old_ssd130x_state, sizeof(*ssd130x_sta=
te), GFP_KERNEL);
>
> I know this is the standard pattern, but the "dup" part is a bit
> silly here:
>   - The ssd130x-specific parts in ssd130x_plane_state are zeroed below,
>   - The base part is copied again in
>     __drm_atomic_helper_plane_duplicate_state).
> So (for now) you might as well just call kzalloc() ;-)
>

Indeed. You are correct.

>> +       if (!ssd130x_state)
>> +               return NULL;
>> +
>> +       /* The buffers are not duplicated and are allocated in .atomic_c=
heck */
>> +       ssd130x_state->buffer =3D NULL;
>> +       ssd130x_state->data_array =3D NULL;
>> +
>> +       __drm_atomic_helper_plane_duplicate_state(plane, &ssd130x_state-=
>base);
>> +
>> +       return &ssd130x_state->base;
>> +}
>> +
>> +static void ssd130x_primary_plane_destroy_state(struct drm_plane *plane,
>> +                                               struct drm_plane_state *=
state)
>> +{
>> +       struct ssd130x_plane_state *ssd130x_state =3D to_ssd130x_plane_s=
tate(state);
>> +
>> +       ssd130x_buf_free(ssd130x_state);
>
> I think the code would become easier to read by inlining
> ssd130x_buf_free() here.
>

Ack.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

