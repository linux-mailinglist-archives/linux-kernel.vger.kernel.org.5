Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001B379C8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjILH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjILH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433D5E78
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694505325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6EtKeJ8Fl2CPlsqoDZCiTeQu7RXnApXQXlT1M5EOII=;
        b=J5nmL6V/hmGD0bKhyRfqDeMcmPRAIheD9EPRrWXCz7V95RXjmzszmecTuYaNW+qXAG7Tk2
        qgfC6aT1vmXCFmXGZVYB3HjYj1v/is3AT03VPatbslCmISl5Evbexz/hxJ74rTVNxZko88
        Nj6gvmed23frS8jgNhIDlpW+dqIZhA8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-YiahR5arM3uPX45f55VVsQ-1; Tue, 12 Sep 2023 03:55:24 -0400
X-MC-Unique: YiahR5arM3uPX45f55VVsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-402493d2997so38335475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505323; x=1695110123;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6EtKeJ8Fl2CPlsqoDZCiTeQu7RXnApXQXlT1M5EOII=;
        b=VyyfeIblZ9b5/4ABvKlyaPDclSNg6UNDpVxJSeJgR5gVFGxZy5g0jfZNM5p5/Gxh9c
         VJTeHUEXs5cMttijMP3Tok+6fa0b4TO2QkpoSslwGdqVpDBbxZTUNn61qvonVu3Ubss7
         bSg6m55UHiWr8cMzPcXwNYApVNGyAbuk3TQrN8nAoL1H8y8fcXDQV7nRK8s+bLlIFr5b
         zAqlHf3HYgdhZGDFyjHstd6XhKz/+ZYFeM5VLdDQ1Zrob1vaeJl6H/L8y2wOQUHY/ibv
         EO9kOX4a3rYs2YhmNVwlVlbxRDlOYe7tzz1vlK2D1FKBsb95eHvtVc5wPvAh8d6ZuCJO
         fRYQ==
X-Gm-Message-State: AOJu0YxXFCXmY75uHRghpm1i5WVkaPfyM84nBb/M08DRYyH3GG/Xv3mb
        TwjMIelWVdAUlvhLB5lwbxEbl7v8e4odlVhAYVFDRdz1wsoD+U/cyYUl94u51EXbDix5jLdx7zg
        5J1f0SWeYQwNv4TSTT54a7GOG
X-Received: by 2002:a05:600c:2946:b0:3f9:c82e:9d87 with SMTP id n6-20020a05600c294600b003f9c82e9d87mr10082569wmd.13.1694505322760;
        Tue, 12 Sep 2023 00:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOUg/kbhGPkutoeBzAtzcpRlHWaTol5oRJ7Xvs/ofz8ZLVGBogom5lBgebkgCOX/YfVw74sw==
X-Received: by 2002:a05:600c:2946:b0:3f9:c82e:9d87 with SMTP id n6-20020a05600c294600b003f9c82e9d87mr10082545wmd.13.1694505322409;
        Tue, 12 Sep 2023 00:55:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003ff013a4fd9sm12173082wmc.7.2023.09.12.00.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:55:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] drm: fix up fbdev Kconfig defaults
In-Reply-To: <aa935abe-2ccf-4889-a717-4efecc13d48b@app.fastmail.com>
References: <20230911205338.2385278-1-arnd@kernel.org>
 <CAMuHMdWizKkuLEcv8sFFOWPib-0e1onCRuQEZm6OhV592VWUKQ@mail.gmail.com>
 <aa935abe-2ccf-4889-a717-4efecc13d48b@app.fastmail.com>
Date:   Tue, 12 Sep 2023 09:55:21 +0200
Message-ID: <877cov3jx2.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Tue, Sep 12, 2023, at 09:14, Geert Uytterhoeven wrote:
>> On Mon, Sep 11, 2023 at 10:53=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:

[...]

>
> The only alternative I can think of would be to default-enable
> or force-enable FRAMEBUFFER_CONSOLE for any config that includes
> both VT_CONSOLE and FB_CORE. This would increase defconfig
> builds for systems that currently only want CONFIG_FB for
> either FB_DEVICE or LOGO but don't care about
> FRAMEBUFFER_CONSOLE. I have no idea who uses such a config,
> but I think Javier previously said this was an important
> use case.
>

Yes, IMO that should be a possible combination.

>>> diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/cor=
e/Kconfig
>>> index 114cb8aa6c8fd..804c2bec9b43c 100644
>>> --- a/drivers/video/fbdev/core/Kconfig
>>> +++ b/drivers/video/fbdev/core/Kconfig
>>> @@ -28,7 +28,7 @@ config FIRMWARE_EDID
>>>  config FB_DEVICE
>>>         bool "Provide legacy /dev/fb* device"
>>>         depends on FB_CORE
>>> -       default y
>>> +       default FB
>>
>> Changing this means possibly causing regressions on systems running
>> an fbdev userspace.
>
> How? FB_DEVICE is a new config that was just split out from
> CONFIG_FB in 6.6-rc1, so nobody should have any defconfig
> that disables CONFIG_FB but relies on the FB_DEVICE default yet.
>

Ah, scratch my previous comment about making this default 'y' then. For
some reasons I thought that FB_DEVICE was added in v6.5 but see now that
commit 701d2054fa31 ("fbdev: Make support for userspace interfaces
configurable") landed in v6.6-rc1:

$ git tag --contains 701d2054fa31 | tail -1
v6.6-rc1

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

