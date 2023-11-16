Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AE7EE313
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344615AbjKPOk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKPOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:40:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18F181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7D0AcpsS9Uv2SNG5VR/PuBu6Vv17rtl3JFWSaBIyyw=;
        b=YFVzOAaPDnH1XuCOXxyTLFhWrgNdP1J14YQNjYSuOrTMKnxRhWlXU+pbSsgzt+1qJy2IU3
        jL9NncfBxfHbhTJyW/VoQkYHNT9ymeAoPwN6n468L24bO+szMb+KszYPZUIoP+zP1jdDhL
        1V9KY9HNrDy7dDQVRTmdMkvK9Bzavwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-wmI4VXE4N-SSWldWG2fNNA-1; Thu, 16 Nov 2023 09:40:18 -0500
X-MC-Unique: wmI4VXE4N-SSWldWG2fNNA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40839252e81so4983025e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700145618; x=1700750418;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7D0AcpsS9Uv2SNG5VR/PuBu6Vv17rtl3JFWSaBIyyw=;
        b=vY428agDK7+Y7C+717pK+D6zN53BwF7BIQ5r+DsBSBzn3XDoF51hotaLvtZubu1nRO
         XZ2cKmGv9nvz1GeExhE1jSBDO5qK/YeW//9sfcJD3hU7SE3i7O/H5XQuDQCyZ74urtoZ
         hVHcmfjBRoRkRiE1spXTz+1YQ5mytvocVKtkKJy4bLJVjNUQR58JWlGrDa4hWy9nVYzL
         rPxT6T/oVRd7tLnoHF88rrSp4a/pWauSx5GkhBpwfd5/HwL0xzKTQz9cD0WOPq0SCtR2
         AvA/Z8nY4Bw5GYpOCDTg7DSkbmfnU1GzjCNQOXMR24j7L+X23WQ50z0GX5TOjHi5hPNP
         79qQ==
X-Gm-Message-State: AOJu0Yz0E/8tGTY4PJmHJl3y/g1jS5AKImayI11mSDcC+vZpXrXXc9Ar
        17Lz+nDi/Z71ipEY7VBSt+2qsUvUS2EajIV3rNi28yHm+zD/MHYlcfV/L2tUkOHQYCXSGynOIck
        weuCLChxpZ5926nnhepvG9SAL
X-Received: by 2002:a05:600c:45cb:b0:407:4944:76d1 with SMTP id s11-20020a05600c45cb00b00407494476d1mr14152435wmo.17.1700145617769;
        Thu, 16 Nov 2023 06:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Rh8dw2fcZL0K82vhYxadq8V4csNqH6IfNjG3OoldQslRz9TvV/kE57Gz/UgC84cOs3jVNg==
X-Received: by 2002:a05:600c:45cb:b0:407:4944:76d1 with SMTP id s11-20020a05600c45cb00b00407494476d1mr14152411wmo.17.1700145617390;
        Thu, 16 Nov 2023 06:40:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040588d85b3asm3908881wmq.15.2023.11.16.06.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:40:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Andrew Worsley <amworsley@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sergio Lopez <slp@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH] of/platform: Disable sysfb if a simple-framebuffer
 node is found
In-Reply-To: <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
References: <20231113085305.1823455-1-javierm@redhat.com>
 <CAL_JsqKHTN5hfd4qpg5RXbmQLKZNVywDkSj9mxvfGmjrcChQQg@mail.gmail.com>
 <87jzqi59bt.fsf@minerva.mail-host-address-is-not-set>
 <CAL_JsqJM9+cbNviwuKGB5+3YbyAP3UH+TxCxsU5nUtX-iRGP2w@mail.gmail.com>
Date:   Thu, 16 Nov 2023 15:40:16 +0100
Message-ID: <87pm09223z.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> On Thu, Nov 16, 2023 at 3:36=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[...]

>> >
>> > This is the opposite of what we do for memory and memory reservations.
>> > EFI is the source of truth for those.
>> >
>> > This could also lead to an interesting scenario. As simple-framebuffer
>> > can define its memory in a /reserved-memory node, but that is ignored
>> > in EFI boot. Probably would work, but only because EFI probably
>> > generates its memory map table from the /reserved-memory nodes.
>> >
>>
>> I see. So what would be the solution then? Ignoring creating a platform
>> device for "simple-framebuffer" if booted using EFI and have an EFI-GOP?
>
> Shrug. I don't really know anything more about EFI FB, but I would
> guess it can't support handling resources like clocks, power domains,
> regulators, etc. that simple-fb can. So if a platform needs those, do

That's correct, and the reason why I thought that the DTB would be the
single source of truth for the firmware provided framebuffer.

For example, in some arm platforms that u-boot does provide an EFI-GOP,
you need to boot with clk_ignore_unused or the system framebuffer just
goes away once the unused clocks are gated. Same for PD, regulators, etc.

> we say they should not setup EFI-GOP? Or is there a use case for
> having both? Clients that don't muck with resources can use EFI-GOP
> and those that do use simple-fb. For example, does/can grub use
> EFI-GOP, but not simple-fb?
>

I don't think grub can use the simple-fb, it can use the EFI-GOP if is
available though. And things work because of course grub won't try to
disable unused resources like Linux does.

> Rob
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

