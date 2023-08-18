Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77326780E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377882AbjHROqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjHROp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:45:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDDA13D;
        Fri, 18 Aug 2023 07:45:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c136ee106so127622266b.1;
        Fri, 18 Aug 2023 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692369953; x=1692974753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oUM9/mBxM/fM3PWNRCfa8g7S6tbN21j4///WI8j9MA=;
        b=XUGggOyAVqYBg+LKTIOOoLrvqedtadFT9Wxpp8uGtRFYgF9inZ9wwKPs06WRsw8mL1
         D9wAXq3yz+iL/pGpyNTTUBlkVsbOtWnBISvfW2xGMyUIBCxbXQtKfUuGgT5zeuw0NykK
         Ep7lMLYvKDimIUFTLTY3llQA0eS6bI9aRahqSOBogCaeRgb4zZL6KxoVERCXWUbfjpPY
         lDPpqxFxIPcyRTCgZ012DxS1tUauC6AHgaHtFj3B4mWmVLHsdROM+DlRR4L4zPWIRPJz
         ghWXvanXke4z1+Pzrr5O2suyj6jNq1NuRG7dPSTu3Mb3QfrjzlsRa34MswmktumK2KfV
         n7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369953; x=1692974753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oUM9/mBxM/fM3PWNRCfa8g7S6tbN21j4///WI8j9MA=;
        b=gJUuAtXBaa7WTQ6BMUqp9wRCHDM2p7S0BQ2kcCwtUkxS970iMBvHN5PGzyW5HxflBA
         nOQxQ9ZsIWQMj/fJJCqTK9w1iQulrkpvxRMT1DcmCiFg7B+3O5393h9C7iNZkJwGSdw3
         N8HytL+JfbAA0u0U2sRRJzDj+OsN4hTR6w9WlOyWQLrmIE0Vvzxs9VMoMXJGWlMUJ7MQ
         5cN6WLG6li5jTTfEthfmiKyLhCthrM6R958StpWHScGGDpYTakbQyrrclNZt2A9KQohS
         4QxLMAl1MnsEV4JSYS5J4U0iMCgv57OiuoppC85f4W51vVoaOvQGZBKfHm0puuMlpRLP
         5SWg==
X-Gm-Message-State: AOJu0YzZgottO4PApk8POvwaPbEDeXO3qGOzht8Bxse0IKo39Nkq41US
        7hwKFhclJubJhjUN66hGXyQip95wW9pgqlIDikw=
X-Google-Smtp-Source: AGHT+IHQicJnj+KzstlocxgU0S0SH4NUFafCvFaQE46hysnluGxLLtzMIAhK6qT5mNxk3Mz55kg2ixMzO/vTb2wjhqM=
X-Received: by 2002:a17:907:2c6a:b0:99b:cfda:eded with SMTP id
 ib10-20020a1709072c6a00b0099bcfdaededmr2389993ejc.52.1692369953290; Fri, 18
 Aug 2023 07:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230817213729.110087-1-robdclark@gmail.com> <647d3838-0d9a-d9d0-b057-87cb4b0f9c16@amd.com>
In-Reply-To: <647d3838-0d9a-d9d0-b057-87cb4b0f9c16@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 18 Aug 2023 07:45:41 -0700
Message-ID: <CAF6AEGuW7thT9qvWwapPcgDUbCKiWOigMMS3Bj5EMAZZyT0enQ@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH] dma-buf/sw_sync: Avoid recursive lock
 during fence signal
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org,
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

On Fri, Aug 18, 2023 at 2:09=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.08.23 um 23:37 schrieb Rob Clark:
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
> > Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Fixes: d3c6dd1fb30d ("dma-buf/sw_sync: Synchronize signal vs syncpt fre=
e")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >   drivers/dma-buf/sw_sync.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> > index 63f0aeb66db6..ceb6a0408624 100644
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
> > @@ -203,9 +204,13 @@ static void sync_timeline_signal(struct sync_timel=
ine *obj, unsigned int inc)
> >               if (!timeline_fence_signaled(&pt->base))
> >                       break;
> >
> > +             dma_fence_get(&pt->base);
>
> Question is why don't have the fences a reference on the list in the
> first place?

As best I can tell, it is because the fences hold a reference to the
timeline, so a reference in the other direction would cause a loop.

BR,
-R

> > +
> >               list_del_init(&pt->link);
> >               rb_erase(&pt->node, &obj->pt_tree);
> >
> > +             list_add_tail(&pt->link, &signalled);
>
> Instead of list_del()/list_add_tail() you could also use
> list_move_tail() here.
>
> > +
> >               /*
> >                * A signal callback may release the last reference to th=
is
> >                * fence, causing it to be freed. That operation has to b=
e
> > @@ -218,6 +223,11 @@ static void sync_timeline_signal(struct sync_timel=
ine *obj, unsigned int inc)
> >       }
> >
> >       spin_unlock_irq(&obj->lock);
> > +
> > +     list_for_each_entry_safe(pt, next, &signalled, link) {
> > +             list_del(&pt->link);
>
> You must use list_del_init() here or otherwise the pt->link will keep
> pointing to the prev/next entries and the list_empty() check in
> timeline_fence_release() will fail and potentially corrupt things.
>
> Regards,
> Christian.
>
> > +             dma_fence_put(&pt->base);
> > +     }
> >   }
> >
> >   /**
>
