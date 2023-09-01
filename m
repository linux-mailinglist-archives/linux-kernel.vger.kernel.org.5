Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112D78FA05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348602AbjIAIgd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIAIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:36:32 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A81E54
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:36:30 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-44d4c3fa6a6so835604137.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 01:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693557389; x=1694162189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9In4nrX/GR/RCCX5fOoCIkv3k2tP/MwKkhXoJjcyrpw=;
        b=bN/s+UXRsId9yX9bGQJH6uRXtYKLSss20Su4sdWrUyajSAmPQqUVZKTgOvJ4DXF30p
         6/JlMuus3RgXlJEvEEafxPgkFLeOz1nTDdoOe7hFST7utX7J1feKijAyah3vX/RhMQuW
         W9Jup1EfaSQP/wcLT19EyrKjGMapsvrQISlHQYG8Bg7Cs2aeILj+IgNieQgzna2AaOxq
         DSSSDrGy8nA7YNweUA0heNM+wQYTygS3mTwwXc+Z452j71KuwAjOZyFDo7viazq5Ljt/
         gT1te7KXRXE/mA6u+gcqxzICKixgg0jEQ+CIrtIoC65xH6kKY4AVr3E68QqH8nS/LCeH
         ET1Q==
X-Gm-Message-State: AOJu0YyUnxyhiu0Y8ekjk2g3+iQUSwKjsZWO7yGidKM8gnHCgStWTJ5/
        N4IzCk3XZjEoIZsOhi3nZKPGHBYn9S/nWA==
X-Google-Smtp-Source: AGHT+IHNk8mPr7+JiuLOJLsK89RFCANlyk/VTAEbi7vEFAp/yWOdNgivRNjNtAcD+0XFjfi8AZ8QEg==
X-Received: by 2002:a67:f807:0:b0:44d:6320:f0c8 with SMTP id l7-20020a67f807000000b0044d6320f0c8mr2422553vso.15.1693557389175;
        Fri, 01 Sep 2023 01:36:29 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id n9-20020a67d609000000b0044d5a4890b6sm525516vsj.17.2023.09.01.01.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 01:36:29 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-44e2bd06230so826562137.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 01:36:28 -0700 (PDT)
X-Received: by 2002:a67:e951:0:b0:44d:4aa1:9d3a with SMTP id
 p17-20020a67e951000000b0044d4aa19d3amr2382924vso.32.1693557388788; Fri, 01
 Sep 2023 01:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230830062546.720679-1-javierm@redhat.com> <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
In-Reply-To: <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 10:36:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
Message-ID: <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
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

Hi Maxime,

On Fri, Sep 1, 2023 at 10:22 AM Maxime Ripard <mripard@kernel.org> wrote:
> On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas wrote:
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
>
> I'd like to have numbers on that. It's a bit surprising to me that,
> given how many objects we already allocate during a commit, two small
> additional allocations affect performances so dramatically, even on a
> slow platform.

To be fair, I didn't benchmark that.  Perhaps it's just too slow due to
all these other allocations (and whatever else happens).

I just find it extremely silly to allocate a buffer over and over again,
while we know that buffer is needed for each and every display update.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
