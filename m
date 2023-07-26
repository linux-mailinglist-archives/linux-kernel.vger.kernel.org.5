Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6E97638E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGZOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjGZOSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA14C2B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690381021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAuL4+5YqPsFeyK6NrPI2uxMlBvc8rq3rozZsgkt4vE=;
        b=Fb2gYuoeVQaOkucEaUHXFAfRpXVrZU+ynOYNiERJ0UxLs8lRkZbrjNy1Q+Nr13Oa5ZBO8+
        PTX0+Tb6Vx6DuLARnCSPXC21+Pz/KPrDydNUr5Thusf29jodlP032Sh+oEaSk3ncvldRz0
        5dP3iz/td1u/MtW03rXClBlpfdgjHiU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-eVaSMDuJMmWWQgc2tkJyuA-1; Wed, 26 Jul 2023 10:17:00 -0400
X-MC-Unique: eVaSMDuJMmWWQgc2tkJyuA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-314326f6e23so3259814f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381019; x=1690985819;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAuL4+5YqPsFeyK6NrPI2uxMlBvc8rq3rozZsgkt4vE=;
        b=TsBMDp7+Z6GysjtqwB5Bsb04pMj1209561Kyy/ylmH1XekfUFRvq6sQtzrEBrsw3kQ
         +l+y5fK2lnh5KcymW/jox8YOxKvui/rW9CLFmcHMarDMopLEitxXCLsZjKkr9+jxPEhL
         E+DK/JnPvGr3f4BftH3dW5jI+7ta4X31FHytPT9Sd2uY0MtYrCKkPY2FWPla+EIJxH+y
         8G48eIwN5FuBy0gfXhM6JJ9alX8cbtl31onIuKu1CR2vOBKE9KullzpZQWzfqVeu3vwM
         DAICleQhNjIfc352cBbT4z1xlrYLKHXForPQASSks4NSu8Lex2NzrowH1+zxH0bU1Rqp
         bBxA==
X-Gm-Message-State: ABy/qLZJt5jMuXffRvT+oi7lzMbsjkMgTil2KxhPPd6VFHeefZ+CqMrm
        D1wdS79KUpmPVx17+qaLrcr/dpmMLU8CIxkzxBKNC3ujzbYZqml7MKM+MZB06764NZ9DZxylwpS
        q2LX97wiD2umUpbL1w53yLtN0
X-Received: by 2002:adf:e4c1:0:b0:317:5d3d:d395 with SMTP id v1-20020adfe4c1000000b003175d3dd395mr1531992wrm.26.1690381019105;
        Wed, 26 Jul 2023 07:16:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGC4/vZeq1fYioQNnewgVjsHgmtCNZsgzPYmCt9bBJfSd8T5JFsElNilbxTC3B9mWVXtiASrQ==
X-Received: by 2002:adf:e4c1:0:b0:317:5d3d:d395 with SMTP id v1-20020adfe4c1000000b003175d3dd395mr1531971wrm.26.1690381018778;
        Wed, 26 Jul 2023 07:16:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b0031274a184d5sm19960687wrr.109.2023.07.26.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:16:58 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
In-Reply-To: <ciwm45vwqlzwfywzn55uitsbq4undb7xoau2rbaverra3gyfb3@khr2wdz67d74>
References: <20230721070955.1170974-1-javierm@redhat.com>
 <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
 <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
 <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com>
 <ciwm45vwqlzwfywzn55uitsbq4undb7xoau2rbaverra3gyfb3@khr2wdz67d74>
Date:   Wed, 26 Jul 2023 16:16:57 +0200
Message-ID: <87fs5a4v1i.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> Hi,
>
> On Wed, Jul 26, 2023 at 01:52:37PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Jul 26, 2023 at 12:00=E2=80=AFPM Maxime Ripard <mripard@kernel.o=
rg> wrote:
>> > On Tue, Jul 25, 2023 at 09:21:52PM +0200, Geert Uytterhoeven wrote:

[...]

>> The second buffer (containing the hardware format) has a size that
>> depends on the full screen size, not the current mode (I believe that's
>> also the size of the frame buffer backing the plane?).  So its size is
>> fixed.
>
> In KMS in general, no. For that particular case, yes.
>
> And about the framebuffer size =3D=3D full screen size, there's multiple
> sizes involved. I guess what you call full screen size is the CRTC size.
>
> You can't make the assumption in KMS that CRTC size =3D=3D (primary) plane
> size =3D=3D framebuffer size.
>
> If you're using scaling for example, you will have a framebuffer size
> smaller or larger than it plane size. If you're using cropping, then the
> plane size or framebuffer size will be different from the CRTC size.
> Some ways to work around overscan is also to have a smaller plane size
> than the CRTC size.
>
> You don't have to have the CRTC size =3D=3D primary plane size, and then =
you
> don't have to have plane size =3D=3D framebuffer size.
>
> you can't really make that assumption in the general case either:
> scaling or cropping will have a different framebuffer size than the CRTC
> primary plane size (which doesn't have to be "full screen" either).
>

Yes, this particular driver is using the drm_plane_helper_atomic_check()
as the primary plane .atomic_check and this function helper calls to:

drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
						   DRM_PLANE_NO_SCALING,
						   DRM_PLANE_NO_SCALING,
						   false, false);

so it does not support scaling nor positioning.

>> Given the allocations are now done based on plane state, I think the
>> first buffer should be sized according to the frame buffer backing
>> the plane? Currently it uses the full screen size, too (cfr. below).
>
> Yeah, probably.
>

Right, that could be fixed as another patch if anything to make it more
reable since it won't have any functional change.

>> > > > @@ -159,23 +173,23 @@ static int ssd130x_buf_alloc(struct ssd130x_=
device *ssd130x)
>> > > >
>> > > >         pitch =3D drm_format_info_min_pitch(fi, 0, ssd130x->width);
>> > > >
>> > > > -       ssd130x->buffer =3D kcalloc(pitch, ssd130x->height, GFP_KE=
RNEL);
>> > > > -       if (!ssd130x->buffer)
>> > > > +       ssd130x_state->buffer =3D kcalloc(pitch, ssd130x->height, =
GFP_KERNEL);
>>=20
>> Based on full screen width and height.
>>=20
>> > > > +       if (!ssd130x_state->buffer)
>> > > >                 return -ENOMEM;
>> > > >
>> > > > -       ssd130x->data_array =3D kcalloc(ssd130x->width, pages, GFP=
_KERNEL);
>> > > > -       if (!ssd130x->data_array) {
>> > > > -               kfree(ssd130x->buffer);
>> > > > +       ssd130x_state->data_array =3D kcalloc(ssd130x->width, page=
s, GFP_KERNEL);
>>=20
>> Based on full screen width and height (hardware page size).
>>=20
>> > > > +       if (!ssd130x_state->data_array) {
>> > > > +               kfree(ssd130x_state->buffer);
>> > >
>> > > Should ssd130x_state->buffer be reset to NULL here?
>> > > I.e. if .atomic_check() fails, will .atomic_destroy_state() be calle=
d,
>> > > leading to a double free?
>> >
>> > That's a good question.
>> >
>> > I never really thought of that, but yeah, AFAIK atomic_destroy_state()
>> > will be called when atomic_check() fails.
>> >
>> > Which means that it's probably broken in a lot of drivers.
>> >
>> > Also, Javier pointed me to a discussion you had on IRC about using devm
>> > allocation here. We can't really do that. KMS devices are only freed
>> > once the last userspace application closes its fd to the device file, =
so
>> > you have an unbounded window during which the driver is still callable
>> > by userspace (and thus can still trigger an atomic commit) but the
>> > buffer would have been freed for a while.
>>=20
>> It should still be safe for (at least) the data_array buffer. That
>> buffer is only used to store pixels in hardware format, and immediately
>> send them to the hardware.  If this can be called that late, it will
>> fail horribly, as you can no longer talk to the hardware at that point
>> (as ssd130x is an i2c driver, it might actually work; but a DRM driver
>>  that calls devm_platform_ioremap_resource() will crash when writing
>>  to its MMIO registers)?!?
>
> Yep, that's exactly why we have drm_dev_enter/drm_dev_exit :)
>

Thanks. As a follow-up I can also do that in another patch.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

