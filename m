Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5367C4D94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjJKItj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJKIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD394
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697014128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KC8w0Fq0raXD6liRw4fjPK1Tcvy7e0RKiaMGufrFBog=;
        b=inrc2iGGMdZg4V4L0pRlF7rgM474lxBEHMY9QXA8ttO7PtFCVLVz5Sl/aV72/4lGae+ScF
        3lo3mkBgZ/ixEhSxVtXv5LoCffphIGu/7WtuhF0zouxorrC7KjAXL4+WyRj4u65Ie+mZX8
        pLMAKP8u6no5x1n0pbcfIC4O1OthBPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-o6WpC8slOES3rEI3zzFwBQ-1; Wed, 11 Oct 2023 04:48:41 -0400
X-MC-Unique: o6WpC8slOES3rEI3zzFwBQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32d58708cd5so833459f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014120; x=1697618920;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KC8w0Fq0raXD6liRw4fjPK1Tcvy7e0RKiaMGufrFBog=;
        b=XUHWvNJAbU4TLzBuLI5VKu9sV/9tMhf/l/DWz10889xvZEfBGvRnuHKX+qfpZw1exP
         D9y9PV+IBkw8R4edVKWD9x4cIlyi9yJF7mJJicSc23AwrM6FjCfewu2guJf2p5IN8du9
         TBoo0NGMY4Df4JmwUgIT+ZGJSEq21ZzVhXoxrIOZ7/qyHaT5+ToYs2e8LMGLKh90DCNF
         FD6JiroQUlOGlVCP2tfcPkbHV7q2lcWiQ5m5plWW7WGzL3Q8cz8pdkjGAdeGgh8VcO19
         kOfo0XWISh8jCgws92QX10jIeUjeg8EbY8BO4zL9dwBCkku+gqnhRwvodelXQ0LDytDN
         sHSw==
X-Gm-Message-State: AOJu0YyO+hKnQl4vxh7FXxpKHz+wllRkqvY1EzwutwExWzhEYnHkQvu3
        T4xbkDp7B6vEkp1ES02g9xv7iHDP0u3FGGuaK/Brgape2bVer5jOSJZobEqZEEPTnirBV5OOJMD
        s5HyaQ9HNzCb3lvt6T88ehfTO
X-Received: by 2002:a5d:4fd2:0:b0:314:15a8:7879 with SMTP id h18-20020a5d4fd2000000b0031415a87879mr16709910wrw.34.1697014120690;
        Wed, 11 Oct 2023 01:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu7Ki2HA96j+VxEN6W2qlhAocs8VRGy4ACvoVY0BEVlpMah6SSArUaqxvpmFWqRt/6v3MMRg==
X-Received: by 2002:a5d:4fd2:0:b0:314:15a8:7879 with SMTP id h18-20020a5d4fd2000000b0031415a87879mr16709893wrw.34.1697014120369;
        Wed, 11 Oct 2023 01:48:40 -0700 (PDT)
Received: from localhost ([185.124.31.160])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm14702622wru.16.2023.10.11.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:48:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/8] drm/ssd13xx: Add a per controller family functions
 table
In-Reply-To: <CAMuHMdX0gvW4Y5ppWi=qF6mZF00m4G-fP1-Wg+sKW43Ku5fz9A@mail.gmail.com>
References: <20231009183522.543918-1-javierm@redhat.com>
 <20231009183522.543918-6-javierm@redhat.com>
 <CAMuHMdX0gvW4Y5ppWi=qF6mZF00m4G-fP1-Wg+sKW43Ku5fz9A@mail.gmail.com>
Date:   Wed, 11 Oct 2023 10:48:38 +0200
Message-ID: <87jzrtsfx5.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Javier,
>
> On Mon, Oct 9, 2023 at 8:36=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> To allow the driver to decouple the common logic in the function callbac=
ks
>> from the behaviour that is specific of a given Solomon controller family.
>>
>> For this, include a chip family to the device info and add fields to the
>> driver-private device struct, to store the hardware buffer maximum size,
>> the intermediate buffer maximum size and pixel format, and a set of per
>> chip family function handlers.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> Thanks for your patch!
>
>> --- a/drivers/gpu/drm/solomon/ssd13xx.c
>> +++ b/drivers/gpu/drm/solomon/ssd13xx.c
>> @@ -104,6 +104,7 @@ const struct ssd13xx_deviceinfo ssd13xx_variants[] =
=3D {
>>                 .default_width =3D 132,
>>                 .default_height =3D 64,
>>                 .page_mode_only =3D 1,
>> +               .family_id =3D SSD130X_FAMILY,
>
> Why not store &ssd13xx_family_funcs[SSD130X_FAMILY]?
>

I could do that, yeah. Originally thought that could be useful besides the
per chip functions, but I don't think that it's used for anything else...

[...]

>> +       switch (family_id) {
>> +       case SSD130X_FAMILY:
>> +               unsigned int pages =3D DIV_ROUND_UP(ssd13xx->height, SSD=
130X_PAGE_HEIGHT);
>> +
>> +               ssd13xx->data_array_size =3D ssd13xx->width * pages;
>> +
>> +               fi =3D drm_format_info(DRM_FORMAT_R1);
>> +               break;
>> +       }
>
> Please don't mix ssd13xx_funcs[family_id] and switch (family_id).
> The switch() could be replaced by an extra function pointer in
> ssd13xx_funcs, and by storing fi in ssd13xx_funcs, too.
>

Yes, I didn't want to store the format info in struct ssd13xx_funcs
because the idea was for that struct to only have chip operations.

But could do that. I wonder if should rename that struct thought? to
something that better denotes is more than function handlers.

> Note that you don't really need the full drm_format_info, the number
> of bits per pixel is sufficient.  But having the drm_format_info is
> nice, as fmt_convert() will need it later when adding support for
> fbdev emulation using R1 or R4 ;-)
>

Exactly, thinking in your patches is why I stored the full format info :)

> Gr{oetje,eeting}s,

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

