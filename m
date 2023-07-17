Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2FA755F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQJNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGQJNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D257C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689585184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keqI7eQeQialpYPZhV1gk9xVsIEgPh1j6VE155PsvVk=;
        b=D2y3o+Yu4ScEz/QdX/lpvltvTYAQCEKNdINs/B5dYthbYvu78D0O0tU9tYcoo2TgVzcAHR
        KCN6ZGtz2n39GV8IAUmwewbZs2UVosSR3XHNyK+bQQ7uEhLOlnpArZEw2u67DRduOT/LOC
        Xcf19jv3WTK7soefZJoy0bbSSk2Pf1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-VTo6reQPPtCMx-Rt6uFl1w-1; Mon, 17 Jul 2023 05:13:03 -0400
X-MC-Unique: VTo6reQPPtCMx-Rt6uFl1w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31429e93f26so2740193f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689585182; x=1692177182;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keqI7eQeQialpYPZhV1gk9xVsIEgPh1j6VE155PsvVk=;
        b=JFmM5MT7eR9CtxxwHvaqHoNbkl6dceZATs/aE/X26f+IiMKNa38+CJ0eico59QZYoC
         djEs4O9LjWlVMIckD/1mMmO4IlTpzRys/PMaLcThD0fbWs0/QEykZQlX8/mPMnT/PUYy
         w9nLN8XnXwGFe72Ee+wElowDziGscxBWxSLVBxml2ZTpxUOrJRYj284JowXF4AEoIz1p
         xqLFujX2chB2iqex4gztUcS1PE8K0dUUFkDIqz00QFqG6Sxplhczv7xY3SvxuHTBiw0O
         QFMNJhyvfswkCzavC4bYD9KCU/+BAvXKK32vLaEKq6j+0uE3vUTdcPHXDBiqejVVdx1h
         YF3Q==
X-Gm-Message-State: ABy/qLYLjcmFubOTG92b6iQoQvkCIpZAfAfHS3/5sd99KFmm/ZcHktd5
        qexYpr5SqPkeQyAvSReP+LqZC2/edBuiKOmWf1Hvs0gd6MDJMuG0WC7gPtE6gBdqHZ/Mu8doDHM
        ZpyckLgGKRYnHNPYYf7Kq6DVk
X-Received: by 2002:a5d:498d:0:b0:314:13d8:8ae7 with SMTP id r13-20020a5d498d000000b0031413d88ae7mr10466564wrq.26.1689585182187;
        Mon, 17 Jul 2023 02:13:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8lCDMio8tFul/5Qv25azDKCGZD8zr/blt36VIhUszZMLPmhAMnSvst/4EY9PYiW7tLIuHCQ==
X-Received: by 2002:a5d:498d:0:b0:314:13d8:8ae7 with SMTP id r13-20020a5d498d000000b0031413d88ae7mr10466547wrq.26.1689585181899;
        Mon, 17 Jul 2023 02:13:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e22-20020a5d5956000000b0031431fb40fasm8006314wri.89.2023.07.17.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:13:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] drm: fb-helper/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <87zg3w7zlz.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV_qNfytroBEfqDMe04POt27s9o=FevXht7N4YXRmBz8Q@mail.gmail.com>
Date:   Mon, 17 Jul 2023 11:13:00 +0200
Message-ID: <87o7kakijn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Javier,
>
> On Sun, Jul 16, 2023 at 3:30=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > The native display format of ssd1306 OLED displays is monochrome
>> > light-on-dark (R1).  This patch series adds support for the R1 buffer
>> > format to both the ssd130x DRM driver and the FB helpers, so monochrome
>> > applications (including fbdev emulation and the text console) can avoid
>> > the overhead of back-and-forth conversions between R1 and XR24.
>>
>> I've tested your series on a ssd1306 I2C OLED panel and fbcon did work f=
or
>> me, but had some issues when trying to run your fbtest suite. Because the
>
> Thanks, due to the limited userspace environment on my RV32 test system,
> I didn't run fbtest myself.
>

You are welcome.

>> test005 gets killed with a SIGSEGV.
>>
>> $ ./fbtest -d
>> fb_init()
>> fb_open()
>> fb_get_var()
>> fb_get_fix()
>> fb_map()
>> fb_start =3D 0, fb_offset =3D 0, fb_len =3D 1000
>
>    [...]
>
>> Running test test005
>> Caught signal 11. Exiting
>
> Strange.
>
>> Maybe more tests are missing the minimum num_colors requirement? Also, t=
he
>
> On monochrome, test005 should make the left half of the screen black,
> and the right half white.  It works on ARAnyM, and there don't seem
> to be off-by-one errors in the call to fill_rect().
> Can you please run this under gdb or valgrind?
>

Sure. I only spent my free time on these panels though so likely will do
during the week or more likely the weekend. I believe the bug is somewhere
in the test though and not in your kernel patches.

>> penguin in test004 is not displayed correctly. I was expecting that to be
>> working correctly since you mentioned to be using the Linux logo on boot.
>
> Linux has logos for displays using 2, 16, and 256 colors. Note that the
> default logos are 80x80, which is larger than your display, so no logo
> is drawn.
> Fbtest has only the full color logo, so it will look bad on a monochrome
> display.
>

I see. Should the test check for minimum num_colors and skip that test then?

>> Another question, do you know if is possible to change the default forma=
t?
>
> AFAIK DRM does not support that.
>
>> I believe that fbset won't work because the DRM fbdev emulation layer do=
es
>> not implement mode settings but I thought that changing the mode using t=
he
>
> Correct.
>

[...]

>> Maybe I'm doing something wrong or misunderstading about how should work?
>
> Do you need the "-d" option (drop master after mode set) of modetest?
> Still, that would only impact DRM.  The fbdev emulation on top of DRM has
> already been initialized before, and is never reinitialized.
>

Ah, that explains and makes sense now. I tested other user-space fbdev
programs that only support XRGB8888 and those were working correctly so I
guess that user-space that supports R1 be defaulted to that and not able
to change is an acceptable behaviour.

When you post v2, feel free to add:

Tested-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

