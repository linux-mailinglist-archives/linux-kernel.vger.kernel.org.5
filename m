Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527FC78484C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjHVRQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHVRQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:16:10 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE046AF;
        Tue, 22 Aug 2023 10:16:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so5719346a12.0;
        Tue, 22 Aug 2023 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692724565; x=1693329365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n40OSQ1aOHwb0xjPdR9jQ6wxnoOkYuHmQ4PP3H0EIQU=;
        b=lySY5a8lyrGGnlYYXmf1l1ocOBL9p7YeIXrDkyjNrsw/anYfz+6MrKn1NRW7rt0Ny1
         KihWqC/l79F/2GTS93KM2VYg0m+/U4ZVc6uNlRpIjmnSZ0Sut5sNdvCRogdQcnP1Jwjc
         HaVZ93SoZcSeQMmHWgJdoPfeVJAbkvtXKctBEytkDo8/yyOSFyWLNukLQCZ22UcVLcw9
         S9oIJ8C5urTiccIpXY4yjOWXK/FgflI2yb/rxybAUkaM2Tg4mU0dn4uJ8eecyyW0k7N1
         QTNad9C61A1jPmghWekm/9TE/GUQZqqUJr/zFssq50uYC8EQlJ98t5Se/kpQvL2a3A9J
         5AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724565; x=1693329365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n40OSQ1aOHwb0xjPdR9jQ6wxnoOkYuHmQ4PP3H0EIQU=;
        b=CatTWPdtfQMVp1tFMthbG7vKLKtV0bzHgaPyVh+VVphq9W/V/DTPXxVimwpSWu5giw
         qPCUhq9jk1PaRcTig3Bxa5Ifp3zFJGqQDZZ93HbgM3IG2goKJ2cC9eeOWIYlalCbvYX0
         u4VmxcOXcN99U9Z+kFb6ITgYWni0Xe8O92gYBOUfOpazbRkE5BqekXEXvMncuQ7vcxP7
         yJ6clgdHCp53wOPOEMFGctrrt4heND/dUhHR7SOrmPYJ86ZBssPSNoTlXqI+JKMznDbB
         2pbwDXOGB8kLjcs5tIRjmTWsZExLFPsYgCBoUbEclKpb8LyxTTnJ1MMiwEGgW+JIy9/w
         DNPw==
X-Gm-Message-State: AOJu0YyCJcd6ffBv00Z1ccVYgnjnhVzUJFm0EX4pkPTK2M2DE+tSAvxU
        0hNVrx8FgVcmAEfGkcJQBGlwFfjeeEYPg2WV/+Q=
X-Google-Smtp-Source: AGHT+IFI95FHGpr6x2Y7yipCMx8Cu+PjNr67/q+7Cwc3a0nItV0XK4fS+gMtRy1kJ5SZXKsg6cGwBCClIR0xrahkDBI=
X-Received: by 2002:a17:906:28d:b0:99c:3b4:940f with SMTP id
 13-20020a170906028d00b0099c03b4940fmr8855243ejf.27.1692724564539; Tue, 22 Aug
 2023 10:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230818145939.39697-1-robdclark@gmail.com> <a05e0c2e-fd62-4a8e-9fa4-dffaf86f7730@gmail.com>
In-Reply-To: <a05e0c2e-fd62-4a8e-9fa4-dffaf86f7730@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 22 Aug 2023 10:15:52 -0700
Message-ID: <CAF6AEGs+6cveKbv=onEJSZJERk8m56YJzza6A2+eLd3+6MuWMg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v2] dma-buf/sw_sync: Avoid recursive lock
 during fence signal
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 6:01=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 18.08.23 um 16:59 schrieb Rob Clark:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > If a signal callback releases the sw_sync fence, that will trigger a
> > deadlock as the timeline_fence_release recurses onto the fence->lock
> > (used both for signaling and the the timeline tree).
> >
> > To avoid that, temporarily hold an extra reference to the signalled
> > fences until after we drop the lock.
> >
> > (This is an alternative implementation of https://patchwork.kernel.org/=
patch/11664717/
> > which avoids some potential UAF issues with the original patch.)
> >
> > v2: Remove now obsolete comment, use list_move_tail() and
> >      list_del_init()
> >
> > Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Fixes: d3c6dd1fb30d ("dma-buf/sw_sync: Synchronize signal vs syncpt fre=
e")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Thanks, any chance you could take this via drm-misc?

BR,
-R

>
> > ---
> >   drivers/dma-buf/sw_sync.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> > index 63f0aeb66db6..f0a35277fd84 100644
> > --- a/drivers/dma-buf/sw_sync.c
> > +++ b/drivers/dma-buf/sw_sync.c
> > @@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_op=
s =3D {
> >    */
> >   static void sync_timeline_signal(struct sync_timeline *obj, unsigned =
int inc)
> >   {
> > +     LIST_HEAD(signalled);
> >       struct sync_pt *pt, *next;
> >
> >       trace_sync_timeline(obj);
> > @@ -203,21 +204,20 @@ static void sync_timeline_signal(struct sync_time=
line *obj, unsigned int inc)
> >               if (!timeline_fence_signaled(&pt->base))
> >                       break;
> >
> > -             list_del_init(&pt->link);
> > +             dma_fence_get(&pt->base);
> > +
> > +             list_move_tail(&pt->link, &signalled);
> >               rb_erase(&pt->node, &obj->pt_tree);
> >
> > -             /*
> > -              * A signal callback may release the last reference to th=
is
> > -              * fence, causing it to be freed. That operation has to b=
e
> > -              * last to avoid a use after free inside this loop, and m=
ust
> > -              * be after we remove the fence from the timeline in orde=
r to
> > -              * prevent deadlocking on timeline->lock inside
> > -              * timeline_fence_release().
> > -              */
> >               dma_fence_signal_locked(&pt->base);
> >       }
> >
> >       spin_unlock_irq(&obj->lock);
> > +
> > +     list_for_each_entry_safe(pt, next, &signalled, link) {
> > +             list_del_init(&pt->link);
> > +             dma_fence_put(&pt->base);
> > +     }
> >   }
> >
> >   /**
>
