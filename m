Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB8F753710
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjGNJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjGNJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1530C5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689328118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z97MyfIRibDWN3rLru1qWEoPopdMmVgdKe32TsvDViA=;
        b=eJaT95ayOIAEI7n/JVF5JZAiVFi7w/cF4Vz+QBfAASHVp9uGKsMD78VAn857GHhPJNSm0v
        EEGksbZwN6LMtkxqqEn7Z0CnDnnYP+1kwSz1EbPMFwCIjXtkY3jr/Z62mS4SRqhpP3/JnQ
        rtzWooAA3iSp0XHY8niFyVaXTeXeW20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-hBRFV0bkPP-mj81xvxsfmQ-1; Fri, 14 Jul 2023 05:48:37 -0400
X-MC-Unique: hBRFV0bkPP-mj81xvxsfmQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315a03cae87so1153813f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328116; x=1691920116;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z97MyfIRibDWN3rLru1qWEoPopdMmVgdKe32TsvDViA=;
        b=J6IPfBbN2vlcLisjD/jiIIMgb+G/GL6b6w6D15ymThxSUNjFa8MbyMwBj0i5s4bc4N
         Bj5jZoeknbeDWZE7tK2EtxGA3aC8DnH4T6xVStm/VsUR6OIMomkIem4idTXhNY+VdyVX
         yuMlaBEnOS3rqM1ygEjy+gfWyA019d8EQHgD2LLU/aXYhAX4OWSfmjG5OE0UU7mYWvs4
         cZYOijFydgeFQD9/hxyZnxA6+q6YBFpGHMqQIaT8Bl/B26t+Tyki5cLd0VU5edtAQgZN
         rsF0ugmoWVr1xhZU2O06N3P4FvrpPefz2ObQfgJcX1blKx6qGNE6ephQe6qL07JkGCTb
         vcFw==
X-Gm-Message-State: ABy/qLZ9nSlTxXLJVaOPBOkOJTviBar4oCbZ5HZ5/6xSoEViZCCbuGOe
        OCFbtFmJIpCgL1DjyyFLP5D9f9Pjo7+hkyFxcm8nTVczUUUSuRKcASsahJUxPmwa6lwZf8wyf6o
        hWlbrIN3ujDdNytYjL5oHG/7x
X-Received: by 2002:a05:600c:4f46:b0:3fa:125c:8d65 with SMTP id m6-20020a05600c4f4600b003fa125c8d65mr1901783wmq.3.1689328116106;
        Fri, 14 Jul 2023 02:48:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWfZIJyNMIOBOjrpSYm8OGTuUPCpFBy2GQgf6h3deOqmpOOP4cjW8gyAPZVAGHfk4rYWHYVQ==
X-Received: by 2002:a05:600c:4f46:b0:3fa:125c:8d65 with SMTP id m6-20020a05600c4f4600b003fa125c8d65mr1901768wmq.3.1689328115848;
        Fri, 14 Jul 2023 02:48:35 -0700 (PDT)
Received: from localhost ([91.126.32.244])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b003fb41491670sm1013494wmj.24.2023.07.14.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 02:48:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/ssd130x: Fix pitch calculation in
 ssd130x_fb_blit_rect()
In-Reply-To: <CAMuHMdVAXPqjSNGMrZQ2g8FNNL4f7PbdoUCi17g9YOdoqmjFpQ@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <54deec2ec533e90544faa8c60a0c2518c58f3e9c.1689252746.git.geert@linux-m68k.org>
 <87r0pau99o.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdVAXPqjSNGMrZQ2g8FNNL4f7PbdoUCi17g9YOdoqmjFpQ@mail.gmail.com>
Date:   Fri, 14 Jul 2023 11:48:34 +0200
Message-ID: <874jm69631.fsf@minerva.mail-host-address-is-not-set>
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
> On Fri, Jul 14, 2023 at 11:34=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > The page height must be taken into account only for vertical coordinat=
es
>> > and heights, not for horizontal coordinates and widths.
>> >
>> > Fixes: 179a790aaf2a0127 ("drm/ssd130x: Set the page height value in th=
e device info data")
>> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
>> > --- a/drivers/gpu/drm/solomon/ssd130x.c
>> > +++ b/drivers/gpu/drm/solomon/ssd130x.c
>> > @@ -596,7 +596,7 @@ static int ssd130x_fb_blit_rect(struct drm_framebu=
ffer *fb, const struct iosys_m
>> >       rect->y1 =3D round_down(rect->y1, page_height);
>> >       rect->y2 =3D min_t(unsigned int, round_up(rect->y2, page_height)=
, ssd130x->height);
>> >
>> > -     dst_pitch =3D DIV_ROUND_UP(drm_rect_width(rect), page_height);
>> > +     dst_pitch =3D DIV_ROUND_UP(drm_rect_width(rect), 8);
>> >
>>
>> That's true for ssd130x controllers that use R1, but when doing that
>> change one of my goals was to prepare the driver for supporting the
>> ssd132x family that use a 16-grayscale pixel format (R4).
>>
>> For those controllers, the pixels are encoded in 4-bit and each page
>> has two pixels. So for those controllers the dst_pitch will need to
>> be DIV_ROUND_UP(drm_rect_width(rect), 2) instead since the width is
>> not 8 in that case.
>>
>> So I would prefer to skip this patch from your set, because otherwise
>> we will need to revert it when adding support for SSD132x controllers.
>
> My point is that the 8 as used here is related to the number of bits per =
pixel,
> not to the page height.  The page height might also be impacted by the
> number of bits per pixel, but that is orthogonal.
>

Ah, I see what you mean. Yes, you are right. We can later add a
different variable when adding support for controllers using R4.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

