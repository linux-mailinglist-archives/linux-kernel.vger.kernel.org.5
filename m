Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C48763642
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjGZM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjGZM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2453619AD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690374319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RxjFPJ8KobiqywJVUesvkSeJiYPkEsnFPZn7dC9KfSE=;
        b=f5XTr3KE8Hiu2BEKCYRsVDCaDlOfWGxLkS0DVi/GiIzUJRKdalKMPfyvvePFF2ZtnWSbGk
        HmD9tw4QEg9vKo7YVJV5iGAzilM0mSi5wK2q0En9j1ENMc9CiKLgsGuBDWuLeU5GR6giQr
        IfEE9WQHTAcDQASsAlByEQn3dN4Xubk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-JCbSs8KhOimNbiOtHQ2FyQ-1; Wed, 26 Jul 2023 08:25:18 -0400
X-MC-Unique: JCbSs8KhOimNbiOtHQ2FyQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143ac4a562so3259849f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374317; x=1690979117;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxjFPJ8KobiqywJVUesvkSeJiYPkEsnFPZn7dC9KfSE=;
        b=kYOUmuu2M+5XeOuFfMDN7I3Zf4NOsBsoaLA7f6AvFnnci9uFTW5mvs9qSiOoYm4cNF
         d2gX4dOJ2yc1Ki6mm5O1DcUWcNKi3lvpXdy2TIWXgivAtdi97uSKRN8OZfbzq10juDgm
         zgVoHVlVpXrMo71+KGhBBXUpntNT5u49PxwhQ6hd5fVdiRGyOpeC8uONf7aRrKUYKcWI
         qoCZ+rK5SUF2r5uWBfIBSHSlYqWlNTSzIoXPRyHfgz0OSYySWDk0b1G5OroEjH5foxbq
         hSZ22VUXehymRz192VYdhqlcH6GPQke5eYUkjrhyYdBRnQ9FAW4PneVW+GCGGGDwFT08
         axxw==
X-Gm-Message-State: ABy/qLY0Bxu4oYb47rs40sA5PwsciNIsQJGwNfi+Qr8yROSuD6muPH2i
        DcT06ZEolkfdKcKEW8TRyr+IIrakzug2+PJvBpYzaLq++Qjxv3XkN6vJVRVr2KpHpO53++FR/LF
        Rl+C8FNczP+ng+duPYgDnyqnr5uwGX5uu
X-Received: by 2002:adf:d0c9:0:b0:317:6314:96e2 with SMTP id z9-20020adfd0c9000000b00317631496e2mr1427857wrh.14.1690374316976;
        Wed, 26 Jul 2023 05:25:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHv7Azp7OdeZjTccYCPfcmAWx+6/xgx8t09mmpf7aV1keH33FUtz2Yvu6bEVJhWhn2+zeVUZA==
X-Received: by 2002:adf:d0c9:0:b0:317:6314:96e2 with SMTP id z9-20020adfd0c9000000b00317631496e2mr1427839wrh.14.1690374316665;
        Wed, 26 Jul 2023 05:25:16 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b003141f3843e6sm19551465wrs.90.2023.07.26.05.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:25:16 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 2/2] drm/ssd130x: Allocate buffer in the plane's
 .atomic_check() callback
In-Reply-To: <CAMuHMdX1ECG44BMOb5zK_N1cZCpjoKmms2p_80+_F72HH0NBEA@mail.gmail.com>
References: <20230726105433.389740-1-javierm@redhat.com>
 <20230726105433.389740-2-javierm@redhat.com>
 <CAMuHMdX1ECG44BMOb5zK_N1cZCpjoKmms2p_80+_F72HH0NBEA@mail.gmail.com>
Date:   Wed, 26 Jul 2023 14:25:15 +0200
Message-ID: <871qgulv10.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Wed, Jul 26, 2023 at 12:55=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Drivers are not allowed to fail after drm_atomic_helper_swap_state() has
>> been called and the new atomic state is stored into the current sw state.
>>
>> Since the struct ssd130x_device .data_array is allocated in the encoder's
>> .atomic_enable callback, the operation can fail and this is after the new
>> state has been stored. So it can break an atomic mode settings assumptio=
n.
>>
>> Fix this by having custom helpers to allocate, duplicate and destroy the
>> plane state, that will take care of allocating and freeing these buffers.
>>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>>
>> Changes in v5:
>> - Add collected tags from Maxime and Geert.
>> - Update commit message to not mention the kernel oops (Geert Uytterhoev=
en).
>> - Drop Reported-by and Fixes tags (Geert Uytterhoeven).
>> - Update comment about buffer and data_array fields (Geert Uytterhoeven).
>> - Remove superfluous NULL check in ssd130x_fb_blit_rect() (Geert Uytterh=
oeven).
>> - Reset .buffer to NULL if .data_array allocation fails (Geert Uytterhoe=
ven).
>> - Inline buffer alloc/free helper functions (Geert Uytterhoeven).
>
> Thanks for the update!
>

You are welcome, and thanks for the review!

>> --- a/drivers/gpu/drm/solomon/ssd130x.c
>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>
>> @@ -535,7 +550,8 @@ static int ssd130x_update_rect(struct ssd130x_device=
 *ssd130x, struct drm_rect *
>>         return ret;
>>  }
>>
>> -static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
>> +static void ssd130x_clear_screen(struct ssd130x_device *ssd130x,
>> +                                struct ssd130x_plane_state *ssd130x_sta=
te)
>>  {
>>         struct drm_rect fullscreen =3D {
>>                 .x1 =3D 0,
>> @@ -544,21 +560,21 @@ static void ssd130x_clear_screen(struct ssd130x_de=
vice *ssd130x)
>>                 .y2 =3D ssd130x->height,
>>         };
>>
>> -       ssd130x_update_rect(ssd130x, &fullscreen);
>> +       ssd130x_update_rect(ssd130x, ssd130x_state, &fullscreen);
>
> I've just realized another issue: since 49d7d581ceaf4cf8 ("drm/ssd130x:
> Don't allocate buffers on each plane update"). this no longer
> clears the screens, but just updates the hardware with the data in
> ssd130x_device.buffer, i.e. with the last image shown.
> So this should at least clear all of ssd130x_device.buffer before
> calling ssd130x_update_rect().
>

Oh, you are right. I missed that.

> As it's a bit pointless to transpose a black image, a better fix would
> be to just clear ssd130x.data_array, and call the low-level hardware
> functions like ssd130x_update_rect() does.
>

Yeah, this is a left over when we used to allocate a buffer here and I
agree with you that calling ssd130x_update_rect() is a pointless.

We can fix this as a separate follow-up patch though if you agree.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

