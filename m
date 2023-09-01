Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EA78FD17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbjIAMWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjIAMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE5E10CC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693570923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuVMQGitnRMOFdKeQWzhxvFVnOWUCQhBHlm5pT/bNEg=;
        b=GaMqUGCrUB4gN7qaBaTEEv1z4/1hFPuWYPmkr3t0a4LfhB+11AsLF8pa+byNIEpxFl+xdN
        P93FVUmGNsZm0hqosgh6O5YaApPMt8sR97toDtzoGaMne3jlRAqNhX91oUVb6uCFPIc+xQ
        fdMNa8gli96KnhxYjI+LD4GkkMelvGU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Z89wceQ5MnqFBGjX1vzvjw-1; Fri, 01 Sep 2023 08:21:59 -0400
X-MC-Unique: Z89wceQ5MnqFBGjX1vzvjw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso14378305e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693570918; x=1694175718;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuVMQGitnRMOFdKeQWzhxvFVnOWUCQhBHlm5pT/bNEg=;
        b=OVWiIdO+/GmavYOFq5Tryxlxnl5BefZkDf8cjE59jQmywtkVnSDDeOjUvdBC+ULXtK
         pwEoV7WxLTRSYs4F6J/By+sD5v5Bu9DB9vb0u5R1r7HNIOZT/EVp9LSyITH4sKFbA/Zx
         85oH8xmBIuLVdejDnBKZ6gwUx9EZY2bEN7CGE33uUVhYvCcQoZRRGiZDzZORZGJCUI/x
         1qO4aNc5X9qFbVlmpGjOfLLMjhsmG6JzebIJ9gnUgueYVS+w6PkSqBp/KuxlhTxhoG0Z
         3UBtzqrhHlPid1HAhn31JyvTVQvHcZ3OpuJR6lxiAMRBYsjLSjdNCsKi+9r9irSnGyxI
         cjdQ==
X-Gm-Message-State: AOJu0YwS/p/WsfHVVsL3XG/fLPvkZCsL7MYs10L2IVfBwCSd+Y1iQ+p2
        qD/HJmZL6Jg23dKOA6lRg66KQlS4ztSwizww++qhEAb6UYu3KybalqxfMaosSCMy6bwUzG9oETJ
        V42wqJdQUrHY+e/PIEKtp/DMuunzduI1K
X-Received: by 2002:a05:600c:2981:b0:3fe:1db2:5179 with SMTP id r1-20020a05600c298100b003fe1db25179mr1723391wmd.19.1693570918503;
        Fri, 01 Sep 2023 05:21:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhRyQ5uHC3rJdp17mvtaP+nozvBE/5uYrDo16bs6zus7ETbY2L1dk3O+ZbcLVoFD9boPm7QA==
X-Received: by 2002:a05:600c:2981:b0:3fe:1db2:5179 with SMTP id r1-20020a05600c298100b003fe1db25179mr1723373wmd.19.1693570918117;
        Fri, 01 Sep 2023 05:21:58 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b00401b242e2e6sm7889960wme.47.2023.09.01.05.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:21:57 -0700 (PDT)
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
In-Reply-To: <CAMuHMdV_775mPbTgWmzCo4mKCd3kqL=vfVFrt2W=bR3uveNW_Q@mail.gmail.com>
References: <20230830062546.720679-1-javierm@redhat.com>
 <zitno3p7tbnld5auedkx5g4wey2csng4ncmtdhzinbuhblunyk@chnwsnsgq36v>
 <CAMuHMdWv_QSatDgihr8=2SXHhvp=icNxumZcZOPwT9Q_QiogNQ@mail.gmail.com>
 <4zfgmvfstyjfo5slggfmfuvnirrhrq773el52gkav2r6jxliub@7qjbyy7rkj3g>
 <CAMuHMdV_775mPbTgWmzCo4mKCd3kqL=vfVFrt2W=bR3uveNW_Q@mail.gmail.com>
Date:   Fri, 01 Sep 2023 14:21:56 +0200
Message-ID: <87a5u65biz.fsf@minerva.mail-host-address-is-not-set>
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

Hello Geert,

> Hi Maxime,
>
> On Fri, Sep 1, 2023 at 2:00=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
>> On Fri, Sep 01, 2023 at 10:36:17AM +0200, Geert Uytterhoeven wrote:
>> > On Fri, Sep 1, 2023 at 10:22=E2=80=AFAM Maxime Ripard <mripard@kernel.=
org> wrote:
>> > > On Wed, Aug 30, 2023 at 08:25:08AM +0200, Javier Martinez Canillas w=
rote:
>> > > > The commit 45b58669e532 ("drm/ssd130x: Allocate buffer in the plan=
e's
>> > > > .atomic_check() callback") moved the allocation of the intermediat=
e and
>> > > > HW buffers from the encoder's .atomic_enable callback to primary p=
lane's
>> > > > .atomic_check callback.
>> > > >
>> > > > This was suggested by Maxime Ripard because drivers aren't allowed=
 to fail
>> > > > after drm_atomic_helper_swap_state() has been called, and the enco=
der's
>> > > > .atomic_enable happens after the new atomic state has been swapped.
>> > > >
>> > > > But that change caused a performance regression in very slow platf=
orms,
>> > > > since now the allocation happens for every plane's atomic state co=
mmit.
>> > > > For example, Geert Uytterhoeven reports that is the case on a VexR=
iscV
>> > > > softcore (RISC-V CPU implementation on an FPGA).
>> > >
>> > > I'd like to have numbers on that. It's a bit surprising to me that,
>> > > given how many objects we already allocate during a commit, two small
>> > > additional allocations affect performances so dramatically, even on a
>> > > slow platform.
>> >
>> > To be fair, I didn't benchmark that.  Perhaps it's just too slow due to
>> > all these other allocations (and whatever else happens).
>> >
>> > I just find it extremely silly to allocate a buffer over and over agai=
n,
>> > while we know that buffer is needed for each and every display update.
>>
>> Maybe it's silly, but I guess it depends on what you want to optimize
>> for. You won't know the size of that buffer before you're in
>> atomic_check. So it's a different trade-off than you would like, but I
>> wouldn't call it extremely silly.
>
> The size of ssd130x_plane_state.data_array[] is fixed, and depends
> on the actual display connected.

Agreed.

> The size of ssd130x_plane_state.buffer[]  is also fixed, and depends
> on the plane's size (which is currently fixed to the display size).
>

Well, one could say that also depends on the format chosen. That is, if
XRGB8888 is used then its size should be the fixed display size but if R1
is used its size could be 0 (since the shadow plane will already store the
pixels in R1 format).

> Gr{oetje,eeting}s,
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

