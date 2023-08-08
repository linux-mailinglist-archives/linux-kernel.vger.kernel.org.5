Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3C7740E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjHHRM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjHHRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7367680
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691510642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CaNxduUzRSkEkmX7HiHWwqeoccgo57TFbEHYFZdEoFM=;
        b=PSn1uga9V0FSXRe6WKzmrcLp0WOf5UjW7TdOoXcN6R4SjF/gamVDme/3v/gMAwIbqvEy1h
        hZ0mdpYJxPOIP2kuez+A+Y/BtN4DgntGvb38gGE4gbk99xNMCO2u5Q4zdBU4g0gGaRpUZA
        ziE2KrYildekEnu6J6SDk8h6jSKNwB4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-GlPmUpI-OWyFhgOB66XUaA-1; Tue, 08 Aug 2023 01:59:49 -0400
X-MC-Unique: GlPmUpI-OWyFhgOB66XUaA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-997c891a88dso379546366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 22:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691474388; x=1692079188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaNxduUzRSkEkmX7HiHWwqeoccgo57TFbEHYFZdEoFM=;
        b=CQ3Z3lewiH/bdek4oboSgoamvIBNY1eQexOad0KzC2zPVNsZNeanesz1/pZvcflplQ
         mGYKxPFLGiaWl/TJedcanHAa/LRMti7j4X6nCzfvkUZGMb3NDaeCPeeiIRxwQQRjYyM/
         PWbFlcpNddTxWFueDuLZEX9aW72LSDN1a4C01JAFKGEVw2Eb0QcL/afKlwRz6obQJOo5
         8bWRoYHxxDPmOEMKiCrrsCEcTybLW0lyf+ap6gGU+sGMuDseIVL/DmxPqSFX1KUXL3IU
         X9BZLa+afv8GK4rYnCa8SNKmtOlDXPXFBJrkdcfy10qF12y2L1mQOU0pOZkhp9MmZasV
         Q7YA==
X-Gm-Message-State: AOJu0Yx+Lpq+rap9Cl3RD6fRXwJNjwzmJYzok37ZCkcYEyCqExDYboGs
        quIGKUGFLj22FP7p10BqBqic0o21Z+/cW3hCdBJ9IiKFlzaETk4lhGIFDvM6pLa33XLaFhO/xRu
        X56X4AmsOWO+RRiVJdrBPepML
X-Received: by 2002:a17:906:c5:b0:994:555a:e49f with SMTP id 5-20020a17090600c500b00994555ae49fmr12096095eji.31.1691474388698;
        Mon, 07 Aug 2023 22:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEApHOhFAZ65Oxm7XRuMfki27ofUpBb0cMuKVVThf/GyD90Va1/Fgc59MtyRqqiqvMTfE+qWg==
X-Received: by 2002:a17:906:c5:b0:994:555a:e49f with SMTP id 5-20020a17090600c500b00994555ae49fmr12096083eji.31.1691474388390;
        Mon, 07 Aug 2023 22:59:48 -0700 (PDT)
Received: from redhat.com ([2.52.159.103])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906139900b0098d2d219649sm6214805ejc.174.2023.08.07.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 22:59:47 -0700 (PDT)
Date:   Tue, 8 Aug 2023 01:59:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Yuan Yao <yuanyaogoog@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230808015921-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:43:02PM +0800, Jason Wang wrote:
> On Tue, Aug 8, 2023 at 1:11 PM Yuan Yao <yuanyaogoog@chromium.org> wrote:
> >
> > In current packed virtqueue implementation, the avail_wrap_counter won't
> > flip, in the case when the driver supplies a descriptor chain with a
> > length equals to the queue size; total_sg == vq->packed.vring.num.
> >
> > Let’s assume the following situation:
> > vq->packed.vring.num=4
> > vq->packed.next_avail_idx: 1
> > vq->packed.avail_wrap_counter: 0
> >
> > Then the driver adds a descriptor chain containing 4 descriptors.
> >
> > We expect the following result with avail_wrap_counter flipped:
> > vq->packed.next_avail_idx: 1
> > vq->packed.avail_wrap_counter: 1
> >
> > But, the current implementation gives the following result:
> > vq->packed.next_avail_idx: 1
> > vq->packed.avail_wrap_counter: 0
> >
> > To reproduce the bug, you can set a packed queue size as small as
> > possible, so that the driver is more likely to provide a descriptor
> > chain with a length equal to the packed queue size. For example, in
> > qemu run following commands:
> > sudo qemu-system-x86_64 \
> > -enable-kvm \
> > -nographic \
> > -kernel "path/to/kernel_image" \
> > -m 1G \
> > -drive file="path/to/rootfs",if=none,id=disk \
> > -device virtio-blk,drive=disk \
> > -drive file="path/to/disk_image",if=none,id=rwdisk \
> > -device virtio-blk,drive=rwdisk,packed=on,queue-size=4,\
> > indirect_desc=off \
> > -append "console=ttyS0 root=/dev/vda rw init=/bin/bash"
> >
> > Inside the VM, create a directory and mount the rwdisk device on it. The
> > rwdisk will hang and mount operation will not complete.
> >
> > This commit fixes the wrap counter error by flipping the
> > packed.avail_wrap_counter, when start of descriptor chain equals to the
> > end of descriptor chain (head == i).
> >
> > Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> > Signed-off-by: Yuan Yao <yuanyaogoog@chromium.org>
> > ---
> >
> >  drivers/virtio/virtio_ring.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c5310eaf8b46..da1150d127c2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1461,7 +1461,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >                 }
> >         }
> >
> > -       if (i < head)
> > +       if (i <= head)
> >                 vq->packed.avail_wrap_counter ^= 1;
> 
> Would it be better to move the flipping to the place where we flip
> avail_used_flags?

I think I prefer this patch for stable, refactoring can
be done on top.

>                         if ((unlikely(++i >= vq->packed.vring.num))) {
>                                 i = 0;
>                                 vq->packed.avail_used_flags ^=
>                                         1 << VRING_PACKED_DESC_F_AVAIL |
>                                         1 << VRING_PACKED_DESC_F_USED;
>                         }
> 
> Thanks
> 
> >
> >         /* We're using some buffers from the free list. */
> > --
> > 2.41.0.640.ga95def55d0-goog
> >

