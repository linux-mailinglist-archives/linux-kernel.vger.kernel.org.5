Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47477638F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjGZOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjGZOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E3196
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690381372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyMSRcxy/2ogHzH4JMQXVtrL8+3uUTaWkvxjprHFoKs=;
        b=iG0MyWJyPbiWprMOiBLErMjqA24VEE7b5TEQRfwyldw7yXYBVfhtBznZ2GveypWVn31RWR
        mo0vzVpStnsNjf1OOfceG/0NnKG6Ze3LKS0vAQUUbB5KNu1btL8uytaOtlzuUZDSKIuP/A
        hDLyM726FUNrED798HkGvWw2w5tayKk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-S2f4KJudMTiFxMWaIXogrw-1; Wed, 26 Jul 2023 10:22:48 -0400
X-MC-Unique: S2f4KJudMTiFxMWaIXogrw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so40397955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381367; x=1690986167;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyMSRcxy/2ogHzH4JMQXVtrL8+3uUTaWkvxjprHFoKs=;
        b=grglc1e+JuY4rhpw99co7ZdxWt51W3gSgijSGN3mpappYC+nlInKhlDH+TLxTa/M/A
         aPaytZdeb1FOeIxFyKoqFGfvYMRCeaCHCGNd0hTscyBksqRovrZo0tYtz6v2iZBqz1LM
         rMrxVAf4CaVYw0oplBStUW8xKNKfXZvJRU35ZinQiIU3/iWap/4Ah4jZZfDON6wB9RvV
         gH4oJLjcgmyyf0o9zQ8Bz1wFinsQEL1Rog9F5iCq+4yLxadPaqV3cJuF61GGqFsQuhS5
         /BUzyMcqfsmDlFhc8Ai5SLb2XsNsBCMuYZANRSfcc8RXfRcY0FD2s32yHSBc/eGe2bIp
         Ef7w==
X-Gm-Message-State: ABy/qLZUwwXaKZBmkd9hHiv81gww9J53Wm0P39avQFraFUB7qet42FyH
        1DehoBbf13ssdAzev6SnVlykBKjvNP+yyFo0srLj/3/EFs00C/rfmZInHANzf9brhNz9mRj4zTX
        eByiPgEjmmxYvahc5XkOPea2O
X-Received: by 2002:a05:600c:2103:b0:3fb:424b:ef6e with SMTP id u3-20020a05600c210300b003fb424bef6emr1545558wml.23.1690381367204;
        Wed, 26 Jul 2023 07:22:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwlkw4QFA8DVFagB6nk6sE5O9bwZ9pUqXtBRJxlocFY1P40URvBe2tyo6KMa3n5l0r5SfjRw==
X-Received: by 2002:a05:600c:2103:b0:3fb:424b:ef6e with SMTP id u3-20020a05600c210300b003fb424bef6emr1545539wml.23.1690381366875;
        Wed, 26 Jul 2023 07:22:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a1ce908000000b003fba6709c68sm2174121wmc.47.2023.07.26.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:22:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4] drm/ssd130x: Allocate buffers in the plane's
 .atomic_check callback
In-Reply-To: <CAMuHMdX54sYfv2HJQZxMD_O2XT_nmuoQEE2iTbWkJ9-QvfAWYQ@mail.gmail.com>
References: <20230721070955.1170974-1-javierm@redhat.com>
 <CAMuHMdVxF80mdTaiXA6Y8Gd59Z7pxkoEphB4ohpVcK1q-+Yy=g@mail.gmail.com>
 <n4fmda4zw4vuezvwva35tgma3yqhdvb253q2tfdyauoxbfqshx@s6fsa7de6g5s>
 <CAMuHMdXtOozswqujA1h2spL8J86n65Q6=+z=5Jbb0nSXaBwqzA@mail.gmail.com>
 <874jlqlv5v.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdX+J848ckG2JqsuDkRcWzRypw_Kv=0G+Hc329xstu_nqQ@mail.gmail.com>
 <g6bu3b26evk464x4cn77xnzjiuotsq7pfvyakfvwnir5e3ihnk@2jh4dd56fsza>
 <CAMuHMdX54sYfv2HJQZxMD_O2XT_nmuoQEE2iTbWkJ9-QvfAWYQ@mail.gmail.com>
Date:   Wed, 26 Jul 2023 16:22:45 +0200
Message-ID: <87cz0e4uru.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert,

> Hi Maxime,
>
> On Wed, Jul 26, 2023 at 3:54=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
>> On Wed, Jul 26, 2023 at 02:33:06PM +0200, Geert Uytterhoeven wrote:
>> > > >> Also, Javier pointed me to a discussion you had on IRC about usin=
g devm
>> > > >> allocation here. We can't really do that. KMS devices are only fr=
eed
>> > > >> once the last userspace application closes its fd to the device f=
ile, so
>> > > >> you have an unbounded window during which the driver is still cal=
lable
>> > > >> by userspace (and thus can still trigger an atomic commit) but the
>> > > >> buffer would have been freed for a while.
>> > > >
>> > > > It should still be safe for (at least) the data_array buffer. That
>> > > > buffer is only used to store pixels in hardware format, and immedi=
ately
>> > > > send them to the hardware.  If this can be called that late, it wi=
ll
>> > > > fail horribly, as you can no longer talk to the hardware at that p=
oint
>> > > > (as ssd130x is an i2c driver, it might actually work; but a DRM dr=
iver
>> > > >  that calls devm_platform_ioremap_resource() will crash when writi=
ng
>> > > >  to its MMIO registers)?!?
>> > >
>> > > At the very least the SPI driver will fail since the GPIO that is us=
ed to
>> > > toggle the D/C pin is allocated with devm_gpiod_get_optional(), but =
also
>> > > the regulator, backlight device, etc.
>> > >
>> > > But in any case, as mentioned it is only relevant if the data_array =
buffer
>> > > is allocated at probe time, and from Maxime's explanation is more co=
rrect
>> > > to do it in the .atomic_check handler.
>> >
>> > You need (at least) data_array for clear_screen, too, which is called
>> > from .atomic_disable().
>>
>> I'm not sure I get what your concern is?
>>
>> Even if we entirely disable the plane, the state will not have been
>> destroyed yet so you still have at least access to the data_array from
>> the old state.
>
> Currently, clearing the screen is done from the plane's .atomic_disable()
> callback, so the plane's state should be fine.
>
> But IIUIC, DRM allows the user to enable/disable the display without
> creating any plane first, so clearing should be handled in the CRTC's

But it's needed to be clared in this case? Currently the power on/off
is done in the encoder's .atomic_{en,dis}able() but the actual panel
clear is only done for the plane disable as you mentioned.

> .atomic_disable() callback instead? Then, would we still have access
> to valid plane state?
>

If the clear has to be moved to the CRTC atomic enable/disable, then
the driver should be reworked to not use the data_array and instead
just allocate a zero'ed buffer and pass that as you proposed.

But again that's something that could be done later as another patch.

> Thanks!
>
> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

