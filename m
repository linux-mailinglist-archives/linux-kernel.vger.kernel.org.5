Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD12078DF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbjH3TXC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Aug 2023 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbjH3Hku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:40:50 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A4CD8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:40:45 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5925e580e87so56660597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381244; x=1693986044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjN8oiyAeak2OCfDHumBNxolaRdlghFzEQTJLAyrIjM=;
        b=S9CMgwD1NwIgmZ42vkxtRf2Y3lpZqf7FdhbXnrGg2K/F6Naqm08T9uUiErakzkwIyX
         BY2+jE5/Mqb903NnU+D1sgmBdG4+9iAXfUUj2u5/ikjyohWJS5cAooH7TO6EVRNSqS9g
         IHzV5Asw5OHAcgVrTJWzaxNuiI/MwqRmQPIqQzUeH6N4SqLBrDBWVrnLv8q2G+hrIi7M
         TUlrEfU2UAVDLjFd3zfsg6hW7vtl8ocv97RSFwlYbAo/lXW5g4TxZ85/pv75rUkfPa7P
         xvxJVfW3DQwY0n8YxLn7XG4PqkRJau10pnbeTHzzNFz4CccNXJLegEyVvE4KfnHzS1Uf
         b1Pg==
X-Gm-Message-State: AOJu0YyrOWVcS0hCINQdsWkTgP8wH1qG6lTe+8hEgEAWvFd9ydwmkc8K
        HL4S35pwKqKmzF6zyc2Bog2RQvhfazNl7Q==
X-Google-Smtp-Source: AGHT+IE83n4p0zbREzILH+c70fqixaq7YE7gxjjyVVpXDaBZcO0nxmUQc5xQjC/oMdCdDSjy11EV3A==
X-Received: by 2002:a81:6f89:0:b0:594:1be1:7d33 with SMTP id k131-20020a816f89000000b005941be17d33mr1360177ywc.28.1693381244249;
        Wed, 30 Aug 2023 00:40:44 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id o204-20020a0dccd5000000b00586a09026casm3188763ywd.34.2023.08.30.00.40.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:40:43 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d73c595b558so5254479276.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:40:43 -0700 (PDT)
X-Received: by 2002:a25:e90f:0:b0:d7b:89af:d3d4 with SMTP id
 n15-20020a25e90f000000b00d7b89afd3d4mr1349702ybd.10.1693381243566; Wed, 30
 Aug 2023 00:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830062546.720679-1-javierm@redhat.com> <6a43a18a-bdef-5595-e9f4-38f2d1eac12e@suse.de>
In-Reply-To: <6a43a18a-bdef-5595-e9f4-38f2d1eac12e@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Aug 2023 09:40:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVpC6YajGOf7XzkFfs618-WyeMNdpmpDjGrSpG7egSW6Q@mail.gmail.com>
Message-ID: <CAMuHMdVpC6YajGOf7XzkFfs618-WyeMNdpmpDjGrSpG7egSW6Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Aug 30, 2023 at 9:08 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 30.08.23 um 08:25 schrieb Javier Martinez Canillas:
> > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
> > .atomic_check() callback") moved the allocation of the intermediate and
> > HW buffers from the encoder's .atomic_enable callback to primary plane's
> > .atomic_check callback.
> >
> > This was suggested by Maxime Ripard because drivers aren't allowed to fail
> > after drm_atomic_helper_swap_state() has been called, and the encoder's
> > .atomic_enable happens after the new atomic state has been swapped.
> >
> > But that change caused a performance regression in very slow platforms,
> > since now the allocation happens for every plane's atomic state commit.
> > For example, Geert Uytterhoeven reports that is the case on a VexRiscV
> > softcore (RISC-V CPU implementation on an FPGA).
> >
> > To prevent that, move the move the buffers' allocation and free to the
>
> Double 'move the'
>
> And maybe buffer's rather than buffers'
>
> > CRTC's .atomic_check and .atomic_destroy_state callbacks, so that only
> > happens on a modeset. Since the intermediate buffer is only needed when
> > not using the controller native format (R1), doing the buffer allocation
> > at that CRTC's .atomic_check time would be enough.
> >
> > Fixes: 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's .atomic_check() callback")
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Javier: thanks for your patch!

> Besides the pointers, the CRTC state can also store the primary plane
> format, which you update from the plane's atomic check. By doing so, you
> wont need to refer to the plane state from the CRTC's atomic_check. The
> plane's atomic_check runs before the CRTC's atomic_check. [1]

I haven't tested Javier's patch yet, but does this mean that his patch
won't help?

The problem I saw was that these buffers were allocated and freed
over and over again on each flash of the cursor of the text console
on top of the emulated frame buffer device.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
