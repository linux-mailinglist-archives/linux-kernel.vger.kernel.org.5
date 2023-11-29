Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D527FD145
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjK2Ips (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjK2Ipp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C901BC1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701247550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b7oAAA15rOVCfVDFVia+LTQgyeo/WyMzRo1xULkvSRA=;
        b=W+wDBrtSuZadNO1A6TbS3E+6Zn4ia3qKWDRCtLLczq10mzsCoJaXj5sYJfXBYBZapOVCHN
        5ReDsGTyy0R/8RaKCTG5IlRBt4yulEKFhCjZamqzlLk70VubMrk58o0HjDmIGbW65BaV46
        gquQOZGsOA0L8jBOFj6/6FmReAAlD9w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ygFOMhOGMleLtt4A6dfQlg-1; Wed, 29 Nov 2023 03:45:48 -0500
X-MC-Unique: ygFOMhOGMleLtt4A6dfQlg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3d4d6417so28079325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701247547; x=1701852347;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7oAAA15rOVCfVDFVia+LTQgyeo/WyMzRo1xULkvSRA=;
        b=vC5kpnJtk8aG70qU9vgrFCI8u5r9nxH3K9orUZILBhqDRm4K9sb98M3MNsdEd2xRFx
         tTZCU3BF/pGZGmJICTBhDZlJ99x9tGYogBSOu+6fAp4XPQlnzjipvzYzXNb5+kbE3YuQ
         HLa2QRd07/CM1HXbYYDA2vKiSPCdOCF2Ra6Rjxo/PT/VeBw8veIAe9Sj5oudquFhdtnf
         frIoMREFORQtWPczGa53x9PKWEFVWylDiapbOFIaGWvWBZGQUz6LvSe+OFyw5iJAvdn8
         CG4MyXHj7uvuMaHDim3pwB4Th307rrdeKHaJBnEFXGYu4+uAgTbwsPLi9iV/XnGitrP+
         ut+w==
X-Gm-Message-State: AOJu0YxAPmq4Zf41Xe64rB5FZsOQpYsacm/VLjrhIuHi1AryEV9DUgrX
        HmV7Xw09Z72HjhYkIMcSmAijSGj3cTMXz5PMUuSz0W69Q+J3UDgVzzXDY2kcKmmivqznT4n5mi+
        kZwFIwP0AUF47vOaGOmpG45/y
X-Received: by 2002:a05:600c:4ec7:b0:40b:4b2d:8d0f with SMTP id g7-20020a05600c4ec700b0040b4b2d8d0fmr3468031wmq.31.1701247547354;
        Wed, 29 Nov 2023 00:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUZa9CF5ktLhl2smtnYSsgYgs9e/fhsqdBDOEDAnezf8nhgh6VesIGyD9zauK/BmCgBx8Ohg==
X-Received: by 2002:a05:600c:4ec7:b0:40b:4b2d:8d0f with SMTP id g7-20020a05600c4ec700b0040b4b2d8d0fmr3468008wmq.31.1701247546986;
        Wed, 29 Nov 2023 00:45:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i5-20020adfe485000000b0033300a0b444sm8028033wrm.66.2023.11.29.00.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 00:45:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
In-Reply-To: <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
References: <b9360c2044a1001b9a5bcb5914611711d040d4fe.1701196029.git.geert+renesas@glider.be>
 <87o7fdbszs.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdUhuO++ZSxh+_TX_6DHHxjPYY20jTppbNZ4FnuBvxxinQ@mail.gmail.com>
 <7hee65pmdl5pajm2kgqld22xfi4iox4s2psswu2mdlfk6u6f7x@w4ecogdx6uj6>
Date:   Wed, 29 Nov 2023 09:45:45 +0100
Message-ID: <87fs0paqx2.fsf@minerva.mail-host-address-is-not-set>
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

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> Hi,
>
> On Tue, Nov 28, 2023 at 08:16:18PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Nov 28, 2023 at 8:03=E2=80=AFPM Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>> > Geert Uytterhoeven <geert+renesas@glider.be> writes:
>> > > The Imagination Technologies PowerVR Series 6 GPU is currently only
>> > > supported on Texas Instruments K3 AM62x SoCs.  Hence add a dependenc=
y on
>> > > ARCH_K3, to prevent asking the user about this driver when configuri=
ng a
>> > > kernel without Texas Instruments K3 Multicore SoC support.
>> > >
>> > > Fixes: 4babef0708656c54 ("drm/imagination: Add skeleton PowerVR driv=
er")
>> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > > ---
>> >
>> > Indeed. Although I wonder what is the supposed policy since for example
>> > the DRM_PANFROST symbol only depends on ARM || ARM64 and others such as
>>=20
>> I think ARM Mali is sufficiently ubiquitous on ARM/ARM64 systems to
>> have just an ARM/ARM64 dependency...
>>=20
>> > DRM_ETNAVIV don't even have an SoC or architecture dependency.
>>=20
>> Vivante GPUs are found in DTS files on at least 4 architectures.
>> Might be worthwhile to add some dependencies, though...
>>=20
>> > In any case, I agree with you that restricting to only K3 makes sense.
>>=20
>> I am looking forward to adding || SOC_AM33XX || ARCH_RENESAS || ...,
>> eventually ;-)
>
> I disagree. This is to handle a generic IP, just like panfrost, lima, or
> etnaviv, and we certaintly don't want to maintain the Kconfig list of
> every possible architecture and SoC family it might or might not be
> found.
>

Thanks for the clarification. Then the policy is to have a depends on
ARCH_$FOO if the IP block is tied to a particular SoC or SoC family ?

For example, DRM_V3D has:

depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST

If the IP block is generic and could be integrated with any SoC, then it
should not have a dependency as you said.

> GPUs supposed to be handled are spread across 4 architectures (x86,
> riscv, arm, arm64, mips?), and in arm/arm64 alone we have at least 5
> platforms that might use it (allwinner, ti, mediatek, renesas, rockchip)
>
> It didn't make sense for panfrost, or etnaviv. It doesn't make sense for
> that driver either. Especially for something that olddefconfig can
> handle just fine.
>

I think then that we should drop the arch and SoC dependency for these GPU
drivers and just leave the symbols they really depend on (e.g: DRM, MMU) ?

> Maxime

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

