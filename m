Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F3755F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGQJnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGQJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E138A4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689586943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceQGhU3Q6lPXE1UkwKN4clGf/gwccYZAeCnjr8dMuvU=;
        b=gP/5HLz5kSJtiaAVzYzBWwD6usPtC5FC7PqSYIr8AQKyYNnfbtVQ9QZbsnD0YgW46sgsCK
        apm/YlNGdgRPMr32WF0GYl9OAPqGpzp9yVyMwZ9eszJIG1x9KbIBXLk3QeqzEPNb3wGfWL
        MYJP4wjHxqMYiQEyWsxKJT9fE2ApMrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-oKbGejfEMXeXGBRIL83CxA-1; Mon, 17 Jul 2023 05:42:21 -0400
X-MC-Unique: oKbGejfEMXeXGBRIL83CxA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbe590234aso24597985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586940; x=1692178940;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceQGhU3Q6lPXE1UkwKN4clGf/gwccYZAeCnjr8dMuvU=;
        b=aGyEEkt/AHOOusxhKYTbKNcUdXjb8XqsiHaM9lrqm6E+Ae9I2qYouRCzMuGU27IP1s
         8SXfZHYl1xI1mT5ouNl32OHmvKUgIi2V01YlEZVWg6oRJnCZt4Hqg7HCYrIzJgVoEodR
         5mkheyvzXxSc6tNCQ1kJ5TLh+LLpAowUgqiOSS9nzi4V9K+U4xLJM5g5jM6iu7XZDc9n
         qrAIJL4RogVgN5RtPe9crAcTNnr+4wgrk17YdrcEb1X0bps0e6+KxCDa/3gnaahbRWy6
         ogn0FH5o6DhgjJlmGv5mH4BggInEq1kPE3wXLoQu8mi4bfBK/DDMQhOg0ZrOtRzAIZ9d
         KX5Q==
X-Gm-Message-State: ABy/qLby+rrUBApdx4D4X46YHs9vLUibqHPYJ0ztoINTVd1KPgxgR2xx
        d9oPjcmUYbCRzFi/iPq7YE4kTjBpFj6veZv2lT624isTW4LV5U1r1WTN0kW9/3gJRxMvKgQhA6j
        lUKAJB0y0IDUXAP3mD9CszUJG
X-Received: by 2002:a05:600c:28c:b0:3fb:ff8f:2db0 with SMTP id 12-20020a05600c028c00b003fbff8f2db0mr10562564wmk.39.1689586940620;
        Mon, 17 Jul 2023 02:42:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTJJG5upVMicqzpVz8fvJdGooqvgGRv53FMhG+ent1E5fHJyLuOsJImrX+EIolD7UCawPm2Q==
X-Received: by 2002:a05:600c:28c:b0:3fb:ff8f:2db0 with SMTP id 12-20020a05600c028c00b003fbff8f2db0mr10562552wmk.39.1689586940260;
        Mon, 17 Jul 2023 02:42:20 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 2-20020a05600c248200b003faef96ee78sm7662349wms.33.2023.07.17.02.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:42:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ssd130x: Fix an oops when attempting to update a
 disabled plane
In-Reply-To: <CAMuHMdVuLBTBymfEXDgHsDVavH6Ggq53fPep0T=dEWbztBWkjw@mail.gmail.com>
References: <20230713163213.1028952-1-javierm@redhat.com>
 <bbbb18e0-5de1-5155-c6b2-52a2b1d75898@suse.de>
 <CAMuHMdVuLBTBymfEXDgHsDVavH6Ggq53fPep0T=dEWbztBWkjw@mail.gmail.com>
Date:   Mon, 17 Jul 2023 11:42:19 +0200
Message-ID: <87h6q2kh6s.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert and Thomas,

> Hi Thomas,
>
> On Mon, Jul 17, 2023 at 10:48=E2=80=AFAM Thomas Zimmermann <tzimmermann@s=
use.de> wrote:

[...]

>>
>> After some discussion on IRC, I'd suggest to allocate the buffer
>> somewhere within probe. So it will always be there when the plane code r=
uns.
>>
>> A full fix would be to allocate the buffer memory as part of the plane
>> state and/or the plane's atomic_check. That's a bit more complicated if
>> you want to shared the buffer memory across plane updates.
>
> Note that actually two buffers are involved: data_array (monochrome,
> needed for each update), and buffer (R8, only needed when converting
> from XR24 to R1).
>
> For the former, I agree, as it's always needed.
> For the latter, I'm afraid it would set a bad example: while allocating
> a possibly-unused buffer doesn't hurt for small displays, it would
> mean wasting 1 MiB in e.g. the repaper driver (once it has gained
> support for R1 ;^).
>

Maybe another option is to allocate on the struct drm_mode_config_funcs
.fb_create callback? That way, we can get the mode_cmd->pixel_format and
determine if only "data_array" buffer must be allocated or also "buffer".

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

