Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593947666D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbjG1IUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjG1ITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:19:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF11FEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:19:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9ecf0cb4cso12268805ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690532370; x=1691137170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTRAUA86DMwPcFqB4EOMcdl/jIuL//Bqgq4yKPwIOVA=;
        b=k51hjEtGq4Fu6nizolQujtF+RcNWSH3hDh30DbXTZr3CONr1XcJgHrfTWZQxG+I4Vx
         dACH4eQ9/L/+n4uKtvjbCryuyWZIgZooK5GVYvFJzKxhkoV5oASbxDVkGTwVozSidDzr
         o4VerURU8BXe5Dw/rZMZfOo2q7kMRjr5oPHdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532370; x=1691137170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTRAUA86DMwPcFqB4EOMcdl/jIuL//Bqgq4yKPwIOVA=;
        b=PW5YzsVPlDYThG3+tEpJU0b9hVCITvnsUbsnVtoplJdKYkQcEpgNtZdfV5mk51XayF
         Y5tz7+jgsTr8H5vN2MKprCSVNoQD83rHCERLXPaT33MUZ+crIMt1GcDwgsajPkZNOEAE
         7slTFfP56yvepDS6h562VaDWcT/OYZBFF94ogYSFMSEzrGWKHgaddw95SFxdnLaGYygb
         XQv6uDrhYZ7iNNrYTA5kRcxt2h380x2oUFMu7hzJRBG1WylZfXQoJaFTHuuyz0ytjldu
         InYnvjytJXQJosFgWY4XzPQkeA8vAgcTEwpYuoSPXyrcwRaiadrO5OMACvC59vQKQVAc
         QbrA==
X-Gm-Message-State: ABy/qLb00CHBHhdLIp1euHCQ0eKOqYb+smFZM+/FguAAQEJWhQIcL0NV
        Jjz+mekPrZqi0xSq1/TVuVW9bQ==
X-Google-Smtp-Source: APBJJlHOywpeSc5O//hdAtSg0dDFk7vLQt3ARelT1cXOcfrU2Xqgy9cN/mspvkUKAPb+7fidjukodg==
X-Received: by 2002:a17:902:b603:b0:1b8:89fd:6213 with SMTP id b3-20020a170902b60300b001b889fd6213mr601150pls.35.1690532370124;
        Fri, 28 Jul 2023 01:19:30 -0700 (PDT)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001bbb25dd3a7sm2967182ple.187.2023.07.28.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:19:29 -0700 (PDT)
Date:   Fri, 28 Jul 2023 08:19:26 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] videobuf2: handle non-contiguous DMA allocations
Message-ID: <20230728081926.q5xbacjq5ahqy4da@chromium.org>
References: <20210302004624.31294-1-senozhatsky@chromium.org>
 <20210302004624.31294-9-senozhatsky@chromium.org>
 <08fa86bf-b4bf-408a-89f6-a0ebc222b253@synaptics.com>
 <CAAFQd5AW8ue4haSn9=yi7gSA6bw2pUtPFVSLpkZXrRu1HFZwsA@mail.gmail.com>
 <91c7e958-4f58-7f8c-d413-158d691809dc@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c7e958-4f58-7f8c-d413-158d691809dc@synaptics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:21:23PM +0800, Hsia-Jun Li wrote:
> 
> On 7/5/23 18:45, Tomasz Figa wrote:
> > CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > 
> > On Tue, Jul 4, 2023 at 7:51 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
> > > Hello Sergey
> > > 
> > > I known this patch have been merged for a long time. I am thinking
> > > whether we need this flag in the new v4l2_ext_buffer.
> > > 
> > > On 3/2/21 08:46, Sergey Senozhatsky wrote:
> > > > This adds support for new noncontiguous DMA API, which
> > > > requires allocators to have two execution branches: one
> > > > for the current API, and one for the new one.
> > > There is no way we could allocate a coherent buffer in the platform
> > > except the x86.
> > > 
> > The flag is for requesting the kernel to try allocating *non*-coherent
> > buffers if possible. If the flag is not given, it's up to the kernel
> > to choose the right mapping type, which for vb2-dma-contig is
> > coherent. For compatibility reasons, we need the user space to pass
> > the flag to change the allocation behavior to avoid UAPI breakages.
> > 
> > I don't get what you mean that there is no way to allocate a coherent
> > buffer on a platform other than x86.
> 
> I wonder the case for the x86 platform, does that means we don't need to do
> dma_sync_*() neither DMA_TO_DEVICE  nor DMA_FROM_DEVICE.

It's only guaranteed if you allocate the memory using
dma_alloc_coherent() and friends, regardless of the architecture.

For memory that is not allocated from the coherent memory allocator,
there is never a guarantee that it would be coherent, so the drivers
need to always call dma_sync_*(). It's just that on x86, for 99% of the
cases, the corresponding implementation of the sync ops would be no-op.

> 
> When a remote device likes a PCIe peer write to the system memory, the CPU's
> memory controller could be aware of that and invalidate the CPU's cache?
> 

The details are specific to the CPU implementation, but yes, the CPU
cache would reflect the data as it would be written by the DMA peer.

> >   Most of the platforms implement
> > dma_alloc_coherent() by remapping the allocated memory in
> > uncached/write-combine mode. x86 is an exception because it usually
> > has the DMAs coherent with the CPU caches and no special handling is
> > necessary, so dma_alloc_coherent() is just a simple pass-through
> > allocator.
> > 
> > > Should we make this flag a platform compiling time fixed value?
> > This is not a platform-specific flag. There are use cases which
> > perform better with coherent buffers (i.e. when there is no CPU access
> > happening to the buffers or just a linear memcpy)
> 
> I wonder how to implement the coherent memory in the platform likes ARMv7 or
> later. Disable the CPU cache for those pages?
> 

Yes, that's exactly how dma_alloc_coherent() does it. It re-maps the
memory as write-combine.

> > and some perform
> > better when the mapping is non-coherent (i.e. non-linear access from
> > the CPU, e.g. a software video encoder).
> 
> One problem from migration from ION to DMA-heap is that we don't have a flag
> for allocating non CPU cache buffer(coherent),
> 
> I was thinking, marking all the buffer in ARM to be non coherent, it sounds
> a bad idea now.
> 
> Maybe I should send a patch to userspace utils, which let them allocate the
> non coherent buffer first if no mmap() would be invoked.
> 

I have to admit that I'm not really familiar with the DMA-buf heap
UAPIs, but I think we could add some allocation flag that would be a
hint from the userspace that the buffer doesn't have to be coherent.
(Which is exactly what we did for V4L2 MMAP buffers.)

Best regards,
Tomasz

> > 
> > > And I didn't see Gstreamer nor FFmpeg uses it, it is obvious that they
> > > are running in many(almost all) embedded devices which are ARM.
> > > 
> > It's likely that those generic frameworks don't have any specific
> > advanced use cases which would benefit from the performance gains of
> > this flag. FWIW, ChromeOS uses it in the camera and video stack
> > whenever complex CPU access to the buffers is needed.
> > 
> > Best regards,
> > Tomasz
> > 
> > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > [hch: untested conversion to the ne API]
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >    .../common/videobuf2/videobuf2-dma-contig.c   | 141 +++++++++++++++---
> > > >    1 file changed, 117 insertions(+), 24 deletions(-)
> > > > 
> > > > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > > > index 1e218bc440c6..d6a9f7b682f3 100644
> > > > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > > > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > > > @@ -17,6 +17,7 @@
> > > >    #include <linux/sched.h>
> > > >    #include <linux/slab.h>
> > > >    #include <linux/dma-mapping.h>
> > > > +#include <linux/highmem.h>
> > > > 
> > > >    #include <media/videobuf2-v4l2.h>
> > > >    #include <media/videobuf2-dma-contig.h>
> > > > @@ -42,8 +43,14 @@ struct vb2_dc_buf {
> > > >        struct dma_buf_attachment       *db_attach;
> > > > 
> > > >        struct vb2_buffer               *vb;
> > > > +     unsigned int                    non_coherent_mem:1;
> > > >    };
> > > > 
> > > > +static bool vb2_dc_is_coherent(struct vb2_dc_buf *buf)
> > > > +{
> > > > +     return !buf->non_coherent_mem;
> > > > +}
> > > > +
> > > >    /*********************************************/
> > > >    /*        scatterlist table functions        */
> > > >    /*********************************************/
> > > > @@ -78,12 +85,21 @@ static void *vb2_dc_cookie(struct vb2_buffer *vb, void *buf_priv)
> > > >    static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
> > > >    {
> > > >        struct vb2_dc_buf *buf = buf_priv;
> > > > -     struct dma_buf_map map;
> > > > -     int ret;
> > > > 
> > > > -     if (!buf->vaddr && buf->db_attach) {
> > > > -             ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
> > > > -             buf->vaddr = ret ? NULL : map.vaddr;
> > > > +     if (buf->vaddr)
> > > > +             return buf->vaddr;
> > > > +
> > > > +     if (buf->db_attach) {
> > > > +             struct dma_buf_map map;
> > > > +
> > > > +             if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> > > > +                     buf->vaddr = map.vaddr;
> > > > +     }
> > > > +
> > > > +     if (!vb2_dc_is_coherent(buf)) {
> > > > +             buf->vaddr = dma_vmap_noncontiguous(buf->dev,
> > > > +                                                 buf->size,
> > > > +                                                 buf->dma_sgt);
> > > >        }
> > > > 
> > > >        return buf->vaddr;
> > > > @@ -101,13 +117,26 @@ static void vb2_dc_prepare(void *buf_priv)
> > > >        struct vb2_dc_buf *buf = buf_priv;
> > > >        struct sg_table *sgt = buf->dma_sgt;
> > > > 
> > > > +     /* This takes care of DMABUF and user-enforced cache sync hint */
> > > >        if (buf->vb->skip_cache_sync_on_prepare)
> > > >                return;
> > > > 
> > > > +     /*
> > > > +      * Coherent MMAP buffers do not need to be synced, unlike coherent
> > > > +      * USERPTR and non-coherent MMAP buffers.
> > > > +      */
> > > > +     if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
> > > > +             return;
> > > > +
> > > >        if (!sgt)
> > > >                return;
> > > > 
> > > > +     /* For both USERPTR and non-coherent MMAP */
> > > >        dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> > > > +
> > > > +     /* Non-coherrent MMAP only */
> > > > +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> > > > +             flush_kernel_vmap_range(buf->vaddr, buf->size);
> > > >    }
> > > > 
> > > >    static void vb2_dc_finish(void *buf_priv)
> > > > @@ -115,19 +144,46 @@ static void vb2_dc_finish(void *buf_priv)
> > > >        struct vb2_dc_buf *buf = buf_priv;
> > > >        struct sg_table *sgt = buf->dma_sgt;
> > > > 
> > > > +     /* This takes care of DMABUF and user-enforced cache sync hint */
> > > >        if (buf->vb->skip_cache_sync_on_finish)
> > > >                return;
> > > > 
> > > > +     /*
> > > > +      * Coherent MMAP buffers do not need to be synced, unlike coherent
> > > > +      * USERPTR and non-coherent MMAP buffers.
> > > > +      */
> > > > +     if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
> > > > +             return;
> > > > +
> > > >        if (!sgt)
> > > >                return;
> > > > 
> > > > +     /* For both USERPTR and non-coherent MMAP */
> > > >        dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> > > > +
> > > > +     /* Non-coherrent MMAP only */
> > > > +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> > > > +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
> > > >    }
> > > > 
> > > >    /*********************************************/
> > > >    /*        callbacks for MMAP buffers         */
> > > >    /*********************************************/
> > > > 
> > > > +static void __vb2_dc_put(struct vb2_dc_buf *buf)
> > > > +{
> > > > +     if (vb2_dc_is_coherent(buf)) {
> > > > +             dma_free_attrs(buf->dev, buf->size, buf->cookie,
> > > > +                            buf->dma_addr, buf->attrs);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     if (buf->vaddr)
> > > > +             dma_vunmap_noncontiguous(buf->dev, buf->vaddr);
> > > > +     dma_free_noncontiguous(buf->dev, buf->size,
> > > > +                            buf->dma_sgt, buf->dma_addr);
> > > > +}
> > > > +
> > > >    static void vb2_dc_put(void *buf_priv)
> > > >    {
> > > >        struct vb2_dc_buf *buf = buf_priv;
> > > > @@ -139,17 +195,47 @@ static void vb2_dc_put(void *buf_priv)
> > > >                sg_free_table(buf->sgt_base);
> > > >                kfree(buf->sgt_base);
> > > >        }
> > > > -     dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
> > > > -                    buf->attrs);
> > > > +     __vb2_dc_put(buf);
> > > >        put_device(buf->dev);
> > > >        kfree(buf);
> > > >    }
> > > > 
> > > > +static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
> > > > +{
> > > > +     struct vb2_queue *q = buf->vb->vb2_queue;
> > > > +
> > > > +     buf->cookie = dma_alloc_attrs(buf->dev,
> > > > +                                   buf->size,
> > > > +                                   &buf->dma_addr,
> > > > +                                   GFP_KERNEL | q->gfp_flags,
> > > > +                                   buf->attrs);
> > > > +     if (!buf->cookie)
> > > > +             return -ENOMEM;
> > > > +     if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
> > > > +             buf->vaddr = buf->cookie;
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
> > > > +{
> > > > +     struct vb2_queue *q = buf->vb->vb2_queue;
> > > > +
> > > > +     buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
> > > > +                                            buf->size,
> > > > +                                            buf->dma_dir,
> > > > +                                            GFP_KERNEL | q->gfp_flags,
> > > > +                                            buf->attrs);
> > > > +     if (!buf->dma_sgt)
> > > > +             return -ENOMEM;
> > > > +     return 0;
> > > > +}
> > > > +
> > > >    static void *vb2_dc_alloc(struct vb2_buffer *vb,
> > > >                          struct device *dev,
> > > >                          unsigned long size)
> > > >    {
> > > >        struct vb2_dc_buf *buf;
> > > > +     int ret;
> > > > 
> > > >        if (WARN_ON(!dev))
> > > >                return ERR_PTR(-EINVAL);
> > > > @@ -159,27 +245,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
> > > >                return ERR_PTR(-ENOMEM);
> > > > 
> > > >        buf->attrs = vb->vb2_queue->dma_attrs;
> > > > -     buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
> > > > -                                   GFP_KERNEL | vb->vb2_queue->gfp_flags,
> > > > -                                   buf->attrs);
> > > > -     if (!buf->cookie) {
> > > > -             dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
> > > > -             kfree(buf);
> > > > -             return ERR_PTR(-ENOMEM);
> > > > -     }
> > > > -
> > > > -     if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
> > > > -             buf->vaddr = buf->cookie;
> > > > +     buf->dma_dir = vb->vb2_queue->dma_dir;
> > > > +     buf->vb = vb;
> > > > +     buf->non_coherent_mem = vb->vb2_queue->non_coherent_mem;
> > > > 
> > > > +     buf->size = size;
> > > >        /* Prevent the device from being released while the buffer is used */
> > > >        buf->dev = get_device(dev);
> > > > -     buf->size = size;
> > > > -     buf->dma_dir = vb->vb2_queue->dma_dir;
> > > > +
> > > > +     if (vb2_dc_is_coherent(buf))
> > > > +             ret = vb2_dc_alloc_coherent(buf);
> > > > +     else
> > > > +             ret = vb2_dc_alloc_non_coherent(buf);
> > > > +
> > > > +     if (ret) {
> > > > +             dev_err(dev, "dma alloc of size %ld failed\n", size);
> > > > +             kfree(buf);
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +     }
> > > > 
> > > >        buf->handler.refcount = &buf->refcount;
> > > >        buf->handler.put = vb2_dc_put;
> > > >        buf->handler.arg = buf;
> > > > -     buf->vb = vb;
> > > > 
> > > >        refcount_set(&buf->refcount, 1);
> > > > 
> > > > @@ -196,9 +283,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
> > > >                return -EINVAL;
> > > >        }
> > > > 
> > > > -     ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
> > > > -             buf->dma_addr, buf->size, buf->attrs);
> > > > -
> > > > +     if (vb2_dc_is_coherent(buf))
> > > > +             ret = dma_mmap_attrs(buf->dev, vma, buf->cookie, buf->dma_addr,
> > > > +                                  buf->size, buf->attrs);
> > > > +     else
> > > > +             ret = dma_mmap_noncontiguous(buf->dev, vma, buf->size,
> > > > +                                          buf->dma_sgt);
> > > >        if (ret) {
> > > >                pr_err("Remapping memory failed, error: %d\n", ret);
> > > >                return ret;
> > > > @@ -390,6 +480,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
> > > >        int ret;
> > > >        struct sg_table *sgt;
> > > > 
> > > > +     if (!vb2_dc_is_coherent(buf))
> > > > +             return buf->dma_sgt;
> > > > +
> > > >        sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> > > >        if (!sgt) {
> > > >                dev_err(buf->dev, "failed to alloc sg table\n");
> > > --
> > > Hsia-Jun(Randy) Li
> > > 
> -- 
> Hsia-Jun(Randy) Li
> 
