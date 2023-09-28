Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9D7B2165
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjI1PcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 11:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1PcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:32:21 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4BB7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:32:19 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f82ad1e09so100256457b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915138; x=1696519938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8psAnvOZtbpDP4SLRmyJgzcjZciiw8nZc/0KRaOzIg=;
        b=ZHbT6UWoFyLPcLf8Q6gVail7CU+EclyBEGCVkuQNrxHljXHasbFk3boCiKCpxTmD2o
         i9cVHxBILUdTjHoNlm/S9ebYFtBjCNWTwbT8wCgS33keE/AofM0MlWBs3+pvJQymu61j
         ZAJd4CYikojmiRTAN5xFDUPtr4APXQ6gNUFfh0D8oTkJWmrC8ZS0hWyRix1XEcbtZL59
         cjBi4S+bKBR5PDF/Tjn5qexVsmj1Tjp2vbkbItIchh7vCZiCx+7TIibr9mfTVpLp1WiU
         CO8tRgiVMNbC0ykbbdrlAe+MC7QiuRDEfyBQ+ncTZc3rsfg1VSXhwh01FJprjmJ+ktUF
         2tgQ==
X-Gm-Message-State: AOJu0YzdLXZiTRhSN+Hp2CqFZ1T7L5N+q2JZ0uhniqr4q+IJgiLR1OK7
        MqEZaPLdznXwkMlgkoqH4ZOZlIBL3RnDoVKe
X-Google-Smtp-Source: AGHT+IEpPwbmsnMBm8Km6k2eNNiYXoX+AV6B56BLnCfARPdH+h0vSND/iBjqueObcyAkC/FRR8mIgQ==
X-Received: by 2002:a0d:df82:0:b0:59a:b7b2:5f02 with SMTP id i124-20020a0ddf82000000b0059ab7b25f02mr1691034ywe.18.1695915138564;
        Thu, 28 Sep 2023 08:32:18 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x187-20020a81a0c4000000b0058c55d40765sm4609709ywg.106.2023.09.28.08.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 08:32:17 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59f6e6b206fso111172467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:32:17 -0700 (PDT)
X-Received: by 2002:a0d:d68e:0:b0:59b:f152:8997 with SMTP id
 y136-20020a0dd68e000000b0059bf1528997mr1733560ywd.0.1695915136921; Thu, 28
 Sep 2023 08:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695903065.git.geert+renesas@glider.be> <0f0eae276da4f8ed44cd1a15ffa138879d27b148.1695903065.git.geert+renesas@glider.be>
 <d9020d20-f512-42e6-8259-a7377c3d0d58@suse.de>
In-Reply-To: <d9020d20-f512-42e6-8259-a7377c3d0d58@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 17:32:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUXnT61Hj8JwPenD+x_0-k_wU3bUtj8k9wh7Dd+kN4_Dw@mail.gmail.com>
Message-ID: <CAMuHMdUXnT61Hj8JwPenD+x_0-k_wU3bUtj8k9wh7Dd+kN4_Dw@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] drm: Split drm_modeset_helper_vtables.h
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Sep 28, 2023 at 3:59 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 28.09.23 um 14:16 schrieb Geert Uytterhoeven:
> > <drm/drm_modeset_helper_vtables.h> is the second largest header file in
> > the DRM subsystem, and declares helpers vtables for various DRM
> > components.  Several vtables contain methods with the same name, and all
> > but one vtable do not fit on the screen, making it hard to navigate to
> > the actual method one is interested in.
> >
> > Make it easier for the casual reviewer to keep track by splitting
> > <drm/drm_modeset_helper_vtables.h> in multiple header files, one per DRM
> > component.
>
> I never liked this header either, but do we need new header files? Each
> struct could be appended to the end of the regular header: struct
> drm_plane_helper_funcs to drm_plane.h, drm_connector_helper_func to
> drm_connector.h and so on.

That would work for me, too.  But perhaps we want to maintain a clear
separation between core and helpers?

Note that moving the contents to *_helper.h would be another option,
drm_crtc_helper.h and drm_plane_helper.h already exist.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > RFC, a future patch could replace inclusion of
> > <drm/drm_modeset_helper_vtables.h> by inclusion of one or more of the
> > new files, and reduce compilation time.
> > ---
> >   include/drm/drm_connector_helper_vtable.h   |  364 +++++
> >   include/drm/drm_crtc_helper_vtable.h        |  483 ++++++
> >   include/drm/drm_encoder_helper_vtable.h     |  381 +++++
> >   include/drm/drm_mode_config_helper_vtable.h |   97 ++
> >   include/drm/drm_modeset_helper_vtables.h    | 1466 +------------------
> >   include/drm/drm_plane_helper_vtable.h       |  297 ++++
> >   6 files changed, 1627 insertions(+), 1461 deletions(-)
> >   create mode 100644 include/drm/drm_connector_helper_vtable.h
> >   create mode 100644 include/drm/drm_crtc_helper_vtable.h
> >   create mode 100644 include/drm/drm_encoder_helper_vtable.h
> >   create mode 100644 include/drm/drm_mode_config_helper_vtable.h
> >   create mode 100644 include/drm/drm_plane_helper_vtable.h

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
