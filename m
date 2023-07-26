Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B32763696
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjGZMo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjGZMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:44:26 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AFE131
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:44:25 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58419517920so27717257b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690375464; x=1690980264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtIDsZqYigjrBkutXnBexqF8pwlusTK64WVbpCDs+BA=;
        b=cmO5ERwyIz65LBTtTC6tqFOjuGxjgP7lpH2io/Hkpz19Hk234OFU1wFJMzw7rGdufu
         +QWa6/JxpuxI5yGUg+I/3mNtRugGWLzM+HbzadRxdZUBjKvsgsJptZbwAN0b3LTK4ODj
         zQeJi/MmHr5aJzYjtqiWmeloiLV4CBaMAyk8e0Ux5Vy5kr6jafRaF9/1j8t4j5AMje45
         iUWY7zZa3ENt/GaFiv6OyjO1Ni4c1n0ryq0aVKOKDrQ/VgL5WI0MVoZxAH7GOzOBe/wK
         AVmo5YTzaKNthuePBJtNJ+Z/gKqqTt8ii22rW0N9w6dID/d8dEbjSqXVM9xaFudanXuB
         w1pQ==
X-Gm-Message-State: ABy/qLb9JwMZa9Eh9G6RN4bpbxUcFQjwMSUSplYymkOzzBPswojLx/ln
        2lhlnnCjWgmV7uxKUuCJ56CBiuVij9ebMQ==
X-Google-Smtp-Source: APBJJlGY9VqgZg5GQ4ukm/v/5iPtf7/4plSsDRQPX5lRB9EBHXBjcyhPnvajl8iNnHcvTCuo2XWEEQ==
X-Received: by 2002:a0d:d045:0:b0:583:e577:3e0a with SMTP id s66-20020a0dd045000000b00583e5773e0amr1765451ywd.50.1690375464257;
        Wed, 26 Jul 2023 05:44:24 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id z84-20020a816557000000b00576e67820f3sm4088212ywb.66.2023.07.26.05.44.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 05:44:23 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d18566dc0c1so1949086276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:44:22 -0700 (PDT)
X-Received: by 2002:a25:804f:0:b0:cb4:469e:3308 with SMTP id
 a15-20020a25804f000000b00cb4469e3308mr1498688ybn.6.1690375462709; Wed, 26 Jul
 2023 05:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105433.389740-1-javierm@redhat.com>
In-Reply-To: <20230726105433.389740-1-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jul 2023 14:44:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbOJ5_iEcV=G9ogZJ36T2qj8=tnutXcVZ=Sn-0=dqGug@mail.gmail.com>
Message-ID: <CAMuHMdUbOJ5_iEcV=G9ogZJ36T2qj8=tnutXcVZ=Sn-0=dqGug@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] drm/ssd130x: Inline the ssd130x_buf_{alloc,free}()
 function helpers
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
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

On Wed, Jul 26, 2023 at 12:55 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> There is only a single caller for both helper functions and these don't do
> much other than allocate and free two buffers, so let's just inline them.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
