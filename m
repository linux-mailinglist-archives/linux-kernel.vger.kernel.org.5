Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC278CFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbjH2Wr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjH2Wrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:47:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31C1BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:47:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcfe28909so636839666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693349247; x=1693954047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axePg6OltpBzlldE6xzN9mE4coBsCRQ/UJWjzrWAie8=;
        b=cIK1VEzYeRxsriKJKQRq5nPo/hg8mcLCJbkaJoWsoYX/wdnzwODW3G4E+fMLw82vpi
         nOKXmoyNlzBUAYm3v+MkKWpXyIY3VhGle03aJOEe7AtuyzPfG3KJkb5Qt8bMQv1dT9QC
         14RdLQFMh1dg9r7pXwVW24X2NSsxVy6U2vifaqLUTgLHwxfMEfS5OPBmeEVXf6tjadI4
         2CcIy46EyxKirWAJoziZGhIDq8LFsP5rgXv1eDAjGOEklOZi7ihEdU64oin0dsOYtb2R
         O9ocyXpygQqSVtktxSjUS7xGCbW3Gi3utaMQzKVOV2zy8UDo7EuMIZfONrVp6TEtRXv5
         G2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693349247; x=1693954047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axePg6OltpBzlldE6xzN9mE4coBsCRQ/UJWjzrWAie8=;
        b=QwDgHZuGRocxsDA4qIqN54TToHdipJ9GBncmBmlsZU1tFuurkhd8PFR1PxA73nZLQp
         VgvBCw5NGvlzT4hYDxhmdH80EcZW88fsi+8PMsn8q/MAoupGIHRcHJA/ZEAvK91lRNog
         YHN2kDT1LgOJINXziwHHR2fjjBCkjzDAAcVg1xUj1bQe4FDb2jXTdcbi6bWbeYhPN3hH
         X0PhfQRKnIJVX9jkbOUWRIounOGrfXlJSoDDycHMryecMsZsveGXB2FI/E9hdPnn9ICb
         qZeSSKAN/jChCn96GSMoGZEo/2oo2cIa1p/oIDUQrWsifZ/ynavgsgoQLaQAROcvvwWi
         l6RQ==
X-Gm-Message-State: AOJu0YxPIKttLMRf7taBDTBcbg7BQW9g5Fyq63XHS33ZE5Nw8jhbs9Cg
        uDBOId5izP3tRBPZWh0YyDaXxaK1i2NiBmfV7IU=
X-Google-Smtp-Source: AGHT+IG4d8Rv4xPV2FLskiKTOFdoL8tSwGQXKmN31UiJWE5muqNx03fD7LmLIkKuEja0bjrqjcPDbzakG1bI0bx0VYM=
X-Received: by 2002:a17:906:738d:b0:9a5:9f3c:9615 with SMTP id
 f13-20020a170906738d00b009a59f3c9615mr237447ejl.63.1693349246513; Tue, 29 Aug
 2023 15:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230829223847.4406-1-dakr@redhat.com>
In-Reply-To: <20230829223847.4406-1-dakr@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 30 Aug 2023 08:47:14 +1000
Message-ID: <CAPM=9twm=yvtMFFrkN_poZ_WdBYwAc+waTtEfM6TNehejpyFqg@mail.gmail.com>
Subject: Re: [PATCH drm-misc-next] drm/nouveau: fence: fix undefined fence
 state after emit
To:     Danilo Krummrich <dakr@redhat.com>
Cc:     kherbst@redhat.com, lyude@redhat.com,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023 at 08:38, Danilo Krummrich <dakr@redhat.com> wrote:
>
> nouveau_fence_emit() can fail before and after initializing the
> dma-fence and hence before and after initializing the dma-fence' kref.
>
> In order to avoid nouveau_fence_emit() potentially failing before
> dma-fence initialization pass the channel to nouveau_fence_new() already
> and perform the required check before even allocating the fence.
>
> While at it, restore the original behavior of nouveau_fence_new() and
> add nouveau_fence_create() for separate (pre-)allocation instead. Always
> splitting up allocation end emit wasn't a good idea in the first place.
> Hence, limit it to the places where we actually need to pre-allocate.
>
> Fixes: 7f2a0b50b2b2 ("drm/nouveau: fence: separate fence alloc and emit")
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

nice find,

Reviewed-by: Dave Airlie <airlied@redhat.com>


> ---
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c |  9 +------
>  drivers/gpu/drm/nouveau/nouveau_bo.c    |  8 +------
>  drivers/gpu/drm/nouveau/nouveau_chan.c  |  6 ++---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c  |  9 +++----
>  drivers/gpu/drm/nouveau/nouveau_exec.c  | 11 ++++++---
>  drivers/gpu/drm/nouveau/nouveau_fence.c | 32 ++++++++++++++++++++-----
>  drivers/gpu/drm/nouveau/nouveau_fence.h |  5 ++--
>  drivers/gpu/drm/nouveau/nouveau_gem.c   |  5 +---
>  8 files changed, 45 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> index a34924523133..a34917b048f9 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -1122,18 +1122,11 @@ nv04_page_flip_emit(struct nouveau_channel *chan,
>         PUSH_NVSQ(push, NV_SW, NV_SW_PAGE_FLIP, 0x00000000);
>         PUSH_KICK(push);
>
> -       ret = nouveau_fence_new(pfence);
> +       ret = nouveau_fence_new(pfence, chan);
>         if (ret)
>                 goto fail;
>
> -       ret = nouveau_fence_emit(*pfence, chan);
> -       if (ret)
> -               goto fail_fence_unref;
> -
>         return 0;
> -
> -fail_fence_unref:
> -       nouveau_fence_unref(pfence);
>  fail:
>         spin_lock_irqsave(&dev->event_lock, flags);
>         list_del(&s->head);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index 64f50adb2856..56427b6a00a4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -875,16 +875,10 @@ nouveau_bo_move_m2mf(struct ttm_buffer_object *bo, int evict,
>         if (ret)
>                 goto out_unlock;
>
> -       ret = nouveau_fence_new(&fence);
> +       ret = nouveau_fence_new(&fence, chan);
>         if (ret)
>                 goto out_unlock;
>
> -       ret = nouveau_fence_emit(fence, chan);
> -       if (ret) {
> -               nouveau_fence_unref(&fence);
> -               goto out_unlock;
> -       }
> -
>         /* TODO: figure out a better solution here
>          *
>          * wait on the fence here explicitly as going through
> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
> index 1fd5ccf41128..bb3d6e5c122f 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -70,11 +70,9 @@ nouveau_channel_idle(struct nouveau_channel *chan)
>                 struct nouveau_fence *fence = NULL;
>                 int ret;
>
> -               ret = nouveau_fence_new(&fence);
> +               ret = nouveau_fence_new(&fence, chan);
>                 if (!ret) {
> -                       ret = nouveau_fence_emit(fence, chan);
> -                       if (!ret)
> -                               ret = nouveau_fence_wait(fence, false, false);
> +                       ret = nouveau_fence_wait(fence, false, false);
>                         nouveau_fence_unref(&fence);
>                 }
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 61e84562094a..12feecf71e75 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -209,8 +209,7 @@ static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
>                 goto done;
>         }
>
> -       if (!nouveau_fence_new(&fence))
> -               nouveau_fence_emit(fence, dmem->migrate.chan);
> +       nouveau_fence_new(&fence, dmem->migrate.chan);
>         migrate_vma_pages(&args);
>         nouveau_dmem_fence_done(&fence);
>         dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
> @@ -403,8 +402,7 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
>                 }
>         }
>
> -       if (!nouveau_fence_new(&fence))
> -               nouveau_fence_emit(fence, chunk->drm->dmem->migrate.chan);
> +       nouveau_fence_new(&fence, chunk->drm->dmem->migrate.chan);
>         migrate_device_pages(src_pfns, dst_pfns, npages);
>         nouveau_dmem_fence_done(&fence);
>         migrate_device_finalize(src_pfns, dst_pfns, npages);
> @@ -677,8 +675,7 @@ static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
>                 addr += PAGE_SIZE;
>         }
>
> -       if (!nouveau_fence_new(&fence))
> -               nouveau_fence_emit(fence, drm->dmem->migrate.chan);
> +       nouveau_fence_new(&fence, drm->dmem->migrate.chan);
>         migrate_vma_pages(args);
>         nouveau_dmem_fence_done(&fence);
>         nouveau_pfns_map(svmm, args->vma->vm_mm, args->start, pfns, i);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_exec.c b/drivers/gpu/drm/nouveau/nouveau_exec.c
> index 98a7a94cec5a..72f6543a0790 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_exec.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_exec.c
> @@ -91,7 +91,8 @@ nouveau_exec_job_submit(struct nouveau_job *job)
>         struct nouveau_uvmm *uvmm = nouveau_cli_uvmm(cli);
>         int ret;
>
> -       ret = nouveau_fence_new(&exec_job->fence);
> +       /* Create a new fence, but do not emit yet. */
> +       ret = nouveau_fence_create(&exec_job->fence, exec_job->chan);
>         if (ret)
>                 return ret;
>
> @@ -143,13 +144,17 @@ nouveau_exec_job_run(struct nouveau_job *job)
>                 nv50_dma_push(chan, p->va, p->va_len, no_prefetch);
>         }
>
> -       ret = nouveau_fence_emit(fence, chan);
> +       ret = nouveau_fence_emit(fence);
>         if (ret) {
> +               nouveau_fence_unref(&exec_job->fence);
>                 NV_PRINTK(err, job->cli, "error fencing pushbuf: %d\n", ret);
>                 WIND_RING(chan);
>                 return ERR_PTR(ret);
>         }
>
> +       /* The fence was emitted successfully, set the job's fence pointer to
> +        * NULL in order to avoid freeing it up when the job is cleaned up.
> +        */
>         exec_job->fence = NULL;
>
>         return &fence->base;
> @@ -162,7 +167,7 @@ nouveau_exec_job_free(struct nouveau_job *job)
>
>         nouveau_job_free(job);
>
> -       nouveau_fence_unref(&exec_job->fence);
> +       kfree(exec_job->fence);
>         kfree(exec_job->push.s);
>         kfree(exec_job);
>  }
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index 77c739a55b19..61d9e70da9fd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -205,16 +205,13 @@ nouveau_fence_context_new(struct nouveau_channel *chan, struct nouveau_fence_cha
>  }
>
>  int
> -nouveau_fence_emit(struct nouveau_fence *fence, struct nouveau_channel *chan)
> +nouveau_fence_emit(struct nouveau_fence *fence)
>  {
> +       struct nouveau_channel *chan = fence->channel;
>         struct nouveau_fence_chan *fctx = chan->fence;
>         struct nouveau_fence_priv *priv = (void*)chan->drm->fence;
>         int ret;
>
> -       if (unlikely(!chan->fence))
> -               return -ENODEV;
> -
> -       fence->channel  = chan;
>         fence->timeout  = jiffies + (15 * HZ);
>
>         if (priv->uevent)
> @@ -406,18 +403,41 @@ nouveau_fence_unref(struct nouveau_fence **pfence)
>  }
>
>  int
> -nouveau_fence_new(struct nouveau_fence **pfence)
> +nouveau_fence_create(struct nouveau_fence **pfence,
> +                    struct nouveau_channel *chan)
>  {
>         struct nouveau_fence *fence;
>
> +       if (unlikely(!chan->fence))
> +               return -ENODEV;
> +
>         fence = kzalloc(sizeof(*fence), GFP_KERNEL);
>         if (!fence)
>                 return -ENOMEM;
>
> +       fence->channel = chan;
> +
>         *pfence = fence;
>         return 0;
>  }
>
> +int
> +nouveau_fence_new(struct nouveau_fence **pfence,
> +                 struct nouveau_channel *chan)
> +{
> +       int ret = 0;
> +
> +       ret = nouveau_fence_create(pfence, chan);
> +       if (ret)
> +               return ret;
> +
> +       ret = nouveau_fence_emit(*pfence);
> +       if (ret)
> +               nouveau_fence_unref(pfence);
> +
> +       return ret;
> +}
> +
>  static const char *nouveau_fence_get_get_driver_name(struct dma_fence *fence)
>  {
>         return "nouveau";
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.h b/drivers/gpu/drm/nouveau/nouveau_fence.h
> index 2c72d96ef17d..64d33ae7f356 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.h
> @@ -17,10 +17,11 @@ struct nouveau_fence {
>         unsigned long timeout;
>  };
>
> -int  nouveau_fence_new(struct nouveau_fence **);
> +int  nouveau_fence_create(struct nouveau_fence **, struct nouveau_channel *);
> +int  nouveau_fence_new(struct nouveau_fence **, struct nouveau_channel *);
>  void nouveau_fence_unref(struct nouveau_fence **);
>
> -int  nouveau_fence_emit(struct nouveau_fence *, struct nouveau_channel *);
> +int  nouveau_fence_emit(struct nouveau_fence *);
>  bool nouveau_fence_done(struct nouveau_fence *);
>  int  nouveau_fence_wait(struct nouveau_fence *, bool lazy, bool intr);
>  int  nouveau_fence_sync(struct nouveau_bo *, struct nouveau_channel *, bool exclusive, bool intr);
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index a03fe3e92059..254524fee4fb 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -914,11 +914,8 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
>                 }
>         }
>
> -       ret = nouveau_fence_new(&fence);
> -       if (!ret)
> -               ret = nouveau_fence_emit(fence, chan);
> +       ret = nouveau_fence_new(&fence, chan);
>         if (ret) {
> -               nouveau_fence_unref(&fence);
>                 NV_PRINTK(err, cli, "error fencing pushbuf: %d\n", ret);
>                 WIND_RING(chan);
>                 goto out;
> --
> 2.41.0
>
