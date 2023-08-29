Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12DE78C121
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjH2JVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjH2JUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:20:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F97212F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693300803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+has96YDsBU2Isc2Wi2Mx8jpqY6K0CoeNcnvCWbwfbg=;
        b=SXobm+p79DqAo76Q5RqvRdlojzrxZlMEl9ui+wh9IE7Qp5XNe5WQdCgARY7imybAJxO1dg
        MdANazEp0YC5Tu/L7UpjTqpZtH9eDRZP18nrZRqeAlpPQwubE3VCQhfwVJcyXjBJh21gLG
        /dMg8QmkSLg6UYAX+atF0EgXmrO0H7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-KI_oM01yP1WsFQzZtC0QYA-1; Tue, 29 Aug 2023 05:20:01 -0400
X-MC-Unique: KI_oM01yP1WsFQzZtC0QYA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-317d5b38194so2129216f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300800; x=1693905600;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+has96YDsBU2Isc2Wi2Mx8jpqY6K0CoeNcnvCWbwfbg=;
        b=ULLu6MUr4S3mL+qf8hZ3lNdwpNXTzgvYIY3y06oK7x5RucPhzCjOWz/VUyzXGAW2Mj
         gucrqWwyXdOYb73f/X3exqIualuNSWHQifqLub7uuoMxIgcqYeHHK1F6k51qID6jHPp8
         peLF0FYHno2FN1s0cwIbh+uj2r82mJjbSZYR9n3MTQ3P4E5M5YGkBSRtg29AAaOgjVld
         lupc/Y8nlycLG9XGVYRBfQ44rH1H6veh2IVvEG5Sybwlir3NlgDPYp+u7PJ5F0GMqJMn
         V54awYFAWVQpyt7JcsCxZxZ/uj05kqJuFQjwEuhRGS84KGiwSNh2gwlOtH9EvLTNTMZ9
         ZEpQ==
X-Gm-Message-State: AOJu0Yw2r7L0vjl9u4Kh4B55ucwNoYfMKD+OGsxPxaz7UUXF8pByECSn
        y6CsoTrWJByMBOqtP75u4MqRj+r+10r0SxvHmkYRlz+mDW/0aSkgH+JYpoAoA4QoPHNrxMxZwcu
        AQNskEp5f1+5FRU5AQcmvMg40
X-Received: by 2002:adf:e807:0:b0:317:417e:a467 with SMTP id o7-20020adfe807000000b00317417ea467mr1497043wrm.6.1693300800641;
        Tue, 29 Aug 2023 02:20:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqb8tzfm00AI0tzbfKt+pG/jWIzRAZ3dc7hHDt9sKQ62QtWRu7UWirAMyTtclkiGPEe9sLVA==
X-Received: by 2002:adf:e807:0:b0:317:417e:a467 with SMTP id o7-20020adfe807000000b00317417ea467mr1497027wrm.6.1693300800367;
        Tue, 29 Aug 2023 02:20:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x15-20020adfdd8f000000b003177074f830sm13191866wrl.59.2023.08.29.02.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:20:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/8] drm/client: Convert drm_client_buffer_addfb() to
 drm_mode_addfb2()
In-Reply-To: <CAMuHMdWyMNZJ3seWWHqigLfXwCnp47Xwzs1B6ixOyY+n7cir-A@mail.gmail.com>
References: <cover.1692888745.git.geert@linux-m68k.org>
 <50762fd1694d3b5f6df1bdfa482564adb2ee7f36.1692888745.git.geert@linux-m68k.org>
 <CAPj87rNr7PTcquaz+VzwmXh0mSWSSK25_Fa6uxC2VOfj=wMmcQ@mail.gmail.com>
 <CAMuHMdWyMNZJ3seWWHqigLfXwCnp47Xwzs1B6ixOyY+n7cir-A@mail.gmail.com>
Date:   Tue, 29 Aug 2023 11:19:58 +0200
Message-ID: <87r0nmtdc1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert and Daniel,

> Hi Daniel,
>
> On Thu, Aug 24, 2023 at 5:12=E2=80=AFPM Daniel Stone <daniel@fooishbar.or=
g> wrote:
>> On Thu, 24 Aug 2023 at 16:09, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>> >         struct drm_client_dev *client =3D buffer->client;
>> > -       struct drm_mode_fb_cmd fb_req =3D { };
>> > -       const struct drm_format_info *info;
>> > +       struct drm_mode_fb_cmd2 fb_req =3D { };
>> >         int ret;
>> >
>> > -       info =3D drm_format_info(format);
>> > -       fb_req.bpp =3D drm_format_info_bpp(info, 0);
>> > -       fb_req.depth =3D info->depth;
>> >         fb_req.width =3D width;
>> >         fb_req.height =3D height;
>> > -       fb_req.handle =3D handle;
>> > -       fb_req.pitch =3D buffer->pitch;
>> > +       fb_req.pixel_format =3D format;
>> > +       fb_req.handles[0] =3D handle;
>> > +       fb_req.pitches[0] =3D buffer->pitch;
>> >
>> > -       ret =3D drm_mode_addfb(client->dev, &fb_req, client->file);
>> > +       ret =3D drm_mode_addfb2(client->dev, &fb_req, client->file);
>> >         if (ret)
>> >                 return ret;
>>
>> This should explicitly set the LINEAR modifier (and the modifier flag)
>> if the driver supports modifiers.
>
> Thanks for your comment!
>
> I have no idea how to do that, and I do not know what the impact
> would be.  All I know is that the current implementation of
> drm_client_buffer_addfb() does not do that, so changing that in this
> patch would mean that this would no longer be a trivial conversion.
>

Agree with Geert, this patch basically just inlines the drm_mode_addfb()
implementation which already calls drm_mode_addfb2() but without setting
a struct drm_mode_fb_cmd2 .modifier field or anything modififers related.

So if that is wrong then it should be done as a follow-up patch (which
should also fix the drm_mode_addfb() helper implementation) ?

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

