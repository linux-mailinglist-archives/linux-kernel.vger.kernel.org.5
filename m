Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92BD7FD1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjK2JNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2JNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372985
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701249225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIYj+dPIHz9wh4jZWRbFtDazrWkkAFhwhKwEoYrxKL0=;
        b=fVxcvR3G5Y01GBHhAULWe+YxBzEgc39GrghUZAFsqGblhhoIUO6Q1mNzUzcJuEAPZO3SP+
        TPFxlgefO0XYqJ0xJogZusR3QVupcx2VMT5eJYJ2xjZnzeOetYcaXf2ehIgIHXXpVLLpuM
        4xSElSE+oHFOxfOH+MK0Zv+1xKSKEls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-XwlJfhJIOFqqPQqohMtd1A-1; Wed, 29 Nov 2023 04:13:44 -0500
X-MC-Unique: XwlJfhJIOFqqPQqohMtd1A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-332fcd4b871so481147f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249223; x=1701854023;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIYj+dPIHz9wh4jZWRbFtDazrWkkAFhwhKwEoYrxKL0=;
        b=GuRTY4ehM1p9nwM/oND3FttXUaFmW6TRlgDSDO1017l/2+OBXaaUVUgYgJBqbVFz42
         RpwFumT+XODnSzKonjLw/VJ3M8jJoK2ZqYgOHlNGBs8m/AEwr4LfQD2Xe/7fnsAhtFfi
         aakOiNK0+7Chq8fP+knoI0I3KyFIKDGCxl+it8/nnjmshD7A+Va2+AlmYnVI7JvoVTXI
         Ba90Dcf7FwvAHzB55ThGvW1jNP8v0t7d76NL93ch5y47qaqBsnNQzMqntrkhTO+Z3AXA
         ylNKPj7oDN3XSMvJ/2/w5Ak4aCoGwnUU3lCgGRLsIQaysRabcIaulyUbu8aiE2bIwxXl
         OYrg==
X-Gm-Message-State: AOJu0YwNfjt62IM+VmiiWG1itySW73AVBh4TcrO4WzPeBIMmXM26xhbx
        ag+sFsvGTTAFJpVslmXudC/Y2cDixNGETq1zQpcyEAymbSYALsOuHI1DZrJnyYCi3sbUSRWTs76
        ZEULQXYHy9k6IskPXAZFAxUZw
X-Received: by 2002:adf:ea8e:0:b0:332:e697:3a71 with SMTP id s14-20020adfea8e000000b00332e6973a71mr13333899wrm.6.1701249223137;
        Wed, 29 Nov 2023 01:13:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvyYHuJQs5X4V3XyuYjwI49kog32cJUAVoY1DIBgpPDUYBZhyF5OcuS+STu+1xnZIf6CDspg==
X-Received: by 2002:adf:ea8e:0:b0:332:e697:3a71 with SMTP id s14-20020adfea8e000000b00332e6973a71mr13333879wrm.6.1701249222789;
        Wed, 29 Nov 2023 01:13:42 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r5-20020a5d6c65000000b00332f6202b82sm11783958wrz.9.2023.11.29.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:13:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/imagination: DRM_POWERVR should depend on ARCH_K3
In-Reply-To: <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
 <CAMuHMdVTZ8LT1yU3e1bbJODecy96TaMX1hq_swqmT6L+mbH3aQ@mail.gmail.com>
Date:   Wed, 29 Nov 2023 10:13:41 +0100
Message-ID: <87cyvsc46y.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert,

> Hi Maxime,
>
> On Wed, Nov 29, 2023 at 9:35=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
>> On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
>> > On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canillas
>> > <javierm@redhat.com> wrote:
>> > > Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > > > The Imagination Technologies PowerVR Series 6 GPU is currently only
>> > > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a depende=
ncy on
>> > > > ARCH_K3, to prevent asking the user about this driver when configu=
ring a
>> > > > kernel without Texas Instruments K3 Multicore SoC support.
>> > > >
>> > > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR dr=
iver")
>> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> > > In any case, I agree with you that restricting to only K3 makes sens=
e.
>> >
>> > I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
>> > eventually ;-)
>>
>> I disagree. This is to handle a generic IP, just like panfrost, lima, or
>> etnaviv, and we certaintly don't want to maintain the Kconfig list of
>> every possible architecture and SoC family it might or might not be
>> found.
>
> While PowerVR is a generic IP, I believe it needs a non-generic
> firmware, which is currently only available for AM62x SoCs.
> Once it becomes truly generic, I'm happy to drop all platform
> dependencies.  Until then, there is no point in asking everyone who
> configures an arm64 kernel about this driver, unless they also enabled
> K3 support.
>

That's true but it will require a Kconfig patch every time that there is a
design with a different SoC using this generic IP.

So when should be added? Once there's an upstream DTS that has a GPU device?
Once there's a firmware for it in linux-firmware?

I like the guideline of not having a depends on for generic IP and only have
for IP that can only be used in designs with a SoC from the same vendor.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

