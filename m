Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A521578FAB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbjIAJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjIAJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BE710D7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693560197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JiqN1iSPyqNyznyXLs6ZwGpCEi8bweMuS3U8aoR6Xg=;
        b=WRlBLTIvGInmZst2vctVqQPG55lfvbD2fmy0iBzVwpBfe9KMoPCdlc5ksdODRlR9a/AuKB
        NnCwjYu2fvwK48zyNZfh6SmHQiw6f6jXENYHE3JQtg9C7DlNEh8+zzTTzByoz435NkY+jC
        uMFmegAcVeZDG1hq1wMKJ91L/eAm6AE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-sQ8S_eVRPjGg7G9nxF9_Qg-1; Fri, 01 Sep 2023 05:23:16 -0400
X-MC-Unique: sQ8S_eVRPjGg7G9nxF9_Qg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c554c8867so969765f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 02:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560195; x=1694164995;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JiqN1iSPyqNyznyXLs6ZwGpCEi8bweMuS3U8aoR6Xg=;
        b=QkmYKjrq74UYQ4VfD9BgPePbD/tb8BAYT5fJhE/prBzm8wcyDS0IDeVqGX8e5BW5LQ
         S7Z4ZSfqp8i29kgfrdrrmASqC0cIZJh48oOGytMlGmqysvi0XtVZHSE2hFF2hEsN5Nfq
         SHppetL47NBcaCcTSo9W58kCC/6+tUer4aWytVOkzhUpoEaxe9lGPlX6NlhXI9aTsKqx
         qyuB8X4goVsvWs1IYNUR5PkeV/nyy3oOycuPgjaB6lmwPU7Dmpv78KAM86Xycv5dFk0B
         GBE66cToGaCOOgOfDISlskwUzQjVeYoi9PIlJ1ZkKW9x/hnKqSuV+0HlShgI0CJ+IOBy
         hBnQ==
X-Gm-Message-State: AOJu0YxOPIietqDvjWEWV54oXVs8opPwRBdUXs1w3sFnLR7KRZxumOsp
        NnKdxje/tmznaSjOnHmQfAqbwVC85Rl6aAsqrHG298IQ/3sS04NCaQp4q2c5pzE1/3c1HM+MaUd
        5N8nVmtlV/gSHR8vQpsEbMyBgtDfcErBS
X-Received: by 2002:adf:e9cf:0:b0:31c:65aa:b15a with SMTP id l15-20020adfe9cf000000b0031c65aab15amr1248551wrn.65.1693560194868;
        Fri, 01 Sep 2023 02:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVXywsk9L8AfytnZixOeQ8XSkN487jgB7u3LA7+rTXed2ndu9kqHa49rXP5sHOxvFdS+u9Q==
X-Received: by 2002:adf:e9cf:0:b0:31c:65aa:b15a with SMTP id l15-20020adfe9cf000000b0031c65aab15amr1248534wrn.65.1693560194548;
        Fri, 01 Sep 2023 02:23:14 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m15-20020a056000180f00b003142ea7a661sm4629884wrh.21.2023.09.01.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:23:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] drm/ssd130x: Allocate buffer in the CRTC's
 .atomic_check() callback
In-Reply-To: <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
References: <20230830062546.720679-1-javierm@redhat.com>
 <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
 <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
Date:   Fri, 01 Sep 2023 11:23:13 +0200
Message-ID: <87h6oe5jsu.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Maxime,
>
> On Fri, Sep 1, 2023 at 10:22=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
>> On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas wrote:
>> > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plane's
>> > .atomic_check() callback") moved the allocation of the intermediate and
>> > HW buffers from the encoder's .atomic_enable callback to primary plane=
's
>> > .atomic_check callback.
>> >
>> > This was suggested by Maxime Ripard because drivers aren't allowed to =
fail
>> > after drm_atomic_helper_swap_state() has been called, and the encoder's
>> > .atomic_enable happens after the new atomic state has been swapped.
>> >
>> > But that change caused a performance regression in very slow platforms,
>> > since now the allocation happens for every plane's atomic state commit.
>> > For example, Geert Uytterhoeven reports that is the case on a VexRiscV
>> > softcore (RISC-V CPU implementation on an FPGA).
>>
>> I'd like to have numbers on that. It's a bit surprising to me that,
>> given how many objects we already allocate during a commit, two small
>> additional allocations affect performances so dramatically, even on a
>> slow platform.
>
> To be fair, I didn't benchmark that.  Perhaps it's just too slow due to
> all these other allocations (and whatever else happens).
>
> I just find it extremely silly to allocate a buffer over and over again,
> while we know that buffer is needed for each and every display update.
>

Is not efficient that's true, but on the other hand we have other objects
that are destroyed and created on each atomic update.

In the ssd1307fb driver, the buffer is allocated on ssd1307fb_update_rect()
(by calling the ssd1307fb_alloc_array() function), so it also happens for
every display update in the fbdev driver.

> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

