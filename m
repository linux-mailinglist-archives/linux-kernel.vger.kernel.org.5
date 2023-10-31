Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2A7DCA42
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJaJ4d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Oct 2023 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjJaJ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:56:31 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A9E102
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:56:29 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a8ada42c2aso53216457b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746188; x=1699350988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNZBHyiLRY+gCpq29CudcvsFOdjkuZ4E9FiQic5rKGY=;
        b=iMbj29o96aJVutXNZinHF+4dq/nLf1DUY3jWUfSDWUjSy04xBX5Clb+LZvJumHkZN7
         /9O+E+TZvu5KimrXMJnDkhpyrr7+k8yvoNLQXav/jmL86iXRWHcPw/oDnvHemBrME5Tk
         kDSC8oITAIowk++pROraLOHO0JswBKWrj+wFOIoRtPbhmQ6EborEUq/wL24GD9LvGP2u
         nSpOK2bmzrGKBIDmigqGfJ4NOT7JYL8nT74/UTWVeVMFj7MJ5K4O3ymILdDcti0ZhNXj
         oa1ULOlw3C6/DfOKfTKghf5Gd1hWjpkx6LcVGTBUGxlreX4qw8Gb7Vv9JdJg98Crwy0h
         XGHg==
X-Gm-Message-State: AOJu0Yye8CviNrRU2kTlkI18mt1XeOOheEqRbULmkUfSbJPacul04BJo
        0UUQ95ScgBHyig+3huVU6jflVlWc4ox40A==
X-Google-Smtp-Source: AGHT+IG8fupv/Avrdzu9/SeZprqQkLtbWXITz8BtocIp9npR4isrpSGAj725cAFzQsK9xfHeqnSo8Q==
X-Received: by 2002:a0d:dd0e:0:b0:583:d8d4:7dfe with SMTP id g14-20020a0ddd0e000000b00583d8d47dfemr12381042ywe.31.1698746188011;
        Tue, 31 Oct 2023 02:56:28 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id k186-20020a816fc3000000b0058427045833sm578890ywc.133.2023.10.31.02.56.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 02:56:27 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d84f18e908aso4855329276.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:56:27 -0700 (PDT)
X-Received: by 2002:a25:cb47:0:b0:d9a:6855:14cd with SMTP id
 b68-20020a25cb47000000b00d9a685514cdmr11085901ybg.39.1698746187360; Tue, 31
 Oct 2023 02:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231020225338.1686974-1-javierm@redhat.com> <b048247c-75e9-488e-a4f3-b227a38bca5e@redhat.com>
 <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87v8aso1ha.fsf@minerva.mail-host-address-is-not-set>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Oct 2023 10:56:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
Message-ID: <CAMuHMdVLf=H7QWaUXrN17ABw9eE1MjBdzFEM0AhMNj8_ULSz+Q@mail.gmail.com>
Subject: Re: [PATCH] drm/ssd130x: Fix possible uninitialized usage of
 crtc_state variable
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jocelyn Falempe <jfalempe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, Oct 27, 2023 at 11:33 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> Jocelyn Falempe <jfalempe@redhat.com> writes:
> > On 21/10/2023 00:52, Javier Martinez Canillas wrote:
> >> Avoid a possible uninitialized use of the crtc_state variable in function
> >> ssd132x_primary_plane_atomic_check() and avoid the following Smatch warn:
> >>
> >>      drivers/gpu/drm/solomon/ssd130x.c:921 ssd132x_primary_plane_atomic_check()
> >>      error: uninitialized symbol 'crtc_state'.
> >
> > That looks trivial, so you can add:
> >
> > Acked-by: Jocelyn Falempe <jfalempe@redhat.com>
> >
>
> Pushed to drm-misc (drm-misc-next). Thanks!

Looks like you introduced an unintended

    (cherry picked from commit 9e4db199e66d427c50458f4d72734cc4f0b92948)

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
