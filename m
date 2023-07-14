Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE2753B16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjGNMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjGNMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B733E68
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689338113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4YYFQeFF+tmW56W+2YbpK+12pRE5g3fji817lOXKvo=;
        b=FE+4Xny7KnU8gv1pk7lgRkmgzV//gHe554TL9AMhShfqlo/AI4CJ5HkKO9UYfAOtDGzUVg
        +HygDI+eKbtvlLPUhD7JSO1Nymhm75EIqkRBJ15gLghkj1HNG+umNTBe+Y82qaTBCrtjKC
        KXRchci/8reNgXDmySW68dB4GLrSHRw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-TUcYZ-AqMPuDjZTscpsMYg-1; Fri, 14 Jul 2023 08:35:12 -0400
X-MC-Unique: TUcYZ-AqMPuDjZTscpsMYg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fc08035926so12753265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338111; x=1691930111;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4YYFQeFF+tmW56W+2YbpK+12pRE5g3fji817lOXKvo=;
        b=WqXrxjAIDKdaSLK1OXP3afNJhzNReXyyhFTZYTW7wkJ7bbmA+PLeEZSUEIX9Uq6ndM
         1c9k4Lmtc4dse+B4kEbz44PXgrOhTnBF6ZTRCXcHUk9wOo3q5p49RyD10FYK6eTlruVa
         43W5VZNedYMh2EkkP0fTEJsoUsiHBAIdwUChryY2j7rGX6sjtx/W4ku3Le0gtLyOu/du
         DBKUxn5CBNM7eZHAlh1WbbfAk41Y67qRVZxvoJ/J7sZlWXv2DZcMSrx0dwM/v0OrUOan
         gVgcdIUWR95QaxvgeEhwhtjp1m1zQUTqUeUqyMBgKcdfmd7LqVr/qFDdWrRt4cIhg/Jb
         IaJw==
X-Gm-Message-State: ABy/qLZGJBFNo6y5FRJ4WC+79nr5Y8UbupvC9+AlCGMDyNd9c7g6yH6X
        kaIjej1eQ18SIpK9mc3Mi7SiL8+OrbV7z6qYFhtEJkjS8IeLYtijYhiwb363tWBoXnmTD3t5OiZ
        UrVaBb3knW1yGNguOVRDyCQ/g
X-Received: by 2002:a05:600c:3c82:b0:3fa:821e:1fb5 with SMTP id bg2-20020a05600c3c8200b003fa821e1fb5mr2350934wmb.5.1689338111127;
        Fri, 14 Jul 2023 05:35:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9jx6L5IrTf9LzMzlaRmSACtru8z+t6WqE3jtnwWMGELxmr4yY71Dv3BxD0LDKeBPRdZryjQ==
X-Received: by 2002:a05:600c:3c82:b0:3fa:821e:1fb5 with SMTP id bg2-20020a05600c3c8200b003fa821e1fb5mr2350920wmb.5.1689338110820;
        Fri, 14 Jul 2023 05:35:10 -0700 (PDT)
Received: from localhost (208.red-88-2-40.staticip.rima-tde.net. [88.2.40.208])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fb225d414fsm1326015wmi.21.2023.07.14.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:35:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/ssd130x: Add support for DRM_FORMAT_R1
In-Reply-To: <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
References: <cover.1689252746.git.geert@linux-m68k.org>
 <72746f6d9c47f09fc057ad7a4bbb3b7f423af803.1689252746.git.geert@linux-m68k.org>
 <87ilamu7e3.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdV1MXexXuRuvW2ap5KA51q_3h9X8jXdYXtFb2RF-BBLnw@mail.gmail.com>
Date:   Fri, 14 Jul 2023 14:35:09 +0200
Message-ID: <875y6macxu.fsf@minerva.mail-host-address-is-not-set>
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
> On Fri, Jul 14, 2023 at 12:14=E2=80=AFPM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Thanks a lot for your patch, this has been on my TODO for some time!
>>
>> > The native display format is monochrome light-on-dark (R1).
>> > Hence add support for R1, so monochrome applications can avoid the
>> > overhead of back-and-forth conversions between R1 and XR24.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> > ---
>> > This work interfered with commit 49d7d581ceaf4cf8 ("drm/ssd130x: Don't
>> > allocate buffers on each plane update") in drm-misc/for-linux-next,
>> > which always allocates the buffer upfront, while it is no longer needed
>> > when never using XR24.
>>
>> you mean R1 here, right ?
>
> I did mean R1. I think you missed the double negation.
>

I did indeed. As a non-native english speaker, I find it very hard to
parse double negations :)

>> It's still used in ssd130x_clear_screen() though.
>
> I guess it became worthwhile to make ssd130x_clear_screen()
> do memset(data_array, 0, ...) and call ssd130x_write_data() directly,
> avoiding the pointless reshuffling of black pixels in
> ssd130x_update_rect()?
>

I think so, yeah.

>> > Probably ssd130x->buffer should be allocated on first use.
>>
>> Yes, that makes sense.
>>
>> > And why not allocate the buffers using devm_kcalloc()?
>>
>> I think there are some lifetimes discrepancies between struct device and
>> struct drm_device objects. But we could use drm_device managed resources
>> helpers, i.e: drmm_kzalloc().
>
> The display should not be updated after .remove(), so I think plain
> devm_kcalloc() should be fine.
>

That was precisely my point, that there could be atomic commits even after
the driver has been removed (e.g: if using DRM fbdev emulation, user-space
can keep the /dev/fb0 opened and continue updating the framebuffer. That's
not released until the fd is closed and struct fb_ops .fb_destroy called.

But that's a general rule in DRM, any user-visible resource must not be
allocated using device managed resources and instead use the drm_device
managed resources helpers. To make sure that are not released until the
last call to drm_dev_put():

https://docs.kernel.org/gpu/drm-internals.html#device-instance-and-driver-h=
andling

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

