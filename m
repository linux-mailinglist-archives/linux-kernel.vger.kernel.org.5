Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D329B7CF478
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345139AbjJSJxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345043AbjJSJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A2119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697709143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s07yKdQmQaOSMtiWdOLGzN3oWEKTIekP+ixiSoBemg8=;
        b=PRpc+AQeGMLWr4Dlh+3PG5MTlRV6FC4GTfCQYW+W2tyeS6gMzf9JJoU9izh2lhTMmFHvw5
        oRnbvy91Gy9hTgzcR3N563vOSIHUKGXD2W5D8wfVppUeUw4qooDyT9wFfQCDmQpvLvekWI
        xmvCSQDl8vIy546SON14pgzfFugPfoU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-5OlR3hiQNl2RL4jgbM3Siw-1; Thu, 19 Oct 2023 05:52:21 -0400
X-MC-Unique: 5OlR3hiQNl2RL4jgbM3Siw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso3389903f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697709140; x=1698313940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s07yKdQmQaOSMtiWdOLGzN3oWEKTIekP+ixiSoBemg8=;
        b=GJABrn9ouWClqJZJPQALm+eWstdBx0WKJxDKk6RLauM+JM49tG05MDaP4opkKAFD1I
         issW2GfPt8MDEKN75DEH/4XjkqCefy2Qwwkzp9SSaEfYNgNt8e7lwKYIkTqrrbPHQQmG
         oX21lBh2y3elEPDlM/0UJkweW21nnvCEjyo7q5sahdT8GKbvic/mSgoBp88UzamR+iuy
         0w+1LCKxa8dkWoEgxQ4hwi7dgm8F5xSrTTZkmik+GmZCSA6YPO6ioWpNfSOC3Svzl1wY
         OrgQYa4iFZ3khggY2DVMdTY/fUFOQtftlZjfDyul4DWUrQkqIZtyn7kEJsl1EH0QqI+O
         no6A==
X-Gm-Message-State: AOJu0YxghyIUy7tbFoc3c82K4fmXWYflmpchXHxOvBtWj+32EwfXhiM/
        7JNeSqbHjK8iXmCP0J2zXJXbjiAszRP4pyCTglSu5DkldZzMK2glHg4/eZR3NzBvogAI9wQaj4S
        r3gzxrZKpmas6PjEf0O3bSST1
X-Received: by 2002:a5d:534a:0:b0:32d:9572:6469 with SMTP id t10-20020a5d534a000000b0032d95726469mr1411100wrv.46.1697709140701;
        Thu, 19 Oct 2023 02:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbrIg21JiUOlDeiQ+N0/lCafmoyCQ7Q6G+JcToUR3WGNATzgv3QP9FSlCqPRWoYhSWovXwVw==
X-Received: by 2002:a5d:534a:0:b0:32d:9572:6469 with SMTP id t10-20020a5d534a000000b0032d95726469mr1411083wrv.46.1697709140369;
        Thu, 19 Oct 2023 02:52:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id k8-20020adfe3c8000000b0032710f5584fsm4074029wrm.25.2023.10.19.02.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 02:52:19 -0700 (PDT)
Date:   Thu, 19 Oct 2023 05:52:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: PING: [PATCH] virtio-blk: fix implicit overflow on
 virtio_max_dma_size
Message-ID: <20231019055134-mutt-send-email-mst@kernel.org>
References: <20230904061045.510460-1-pizhenwei@bytedance.com>
 <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dedde8ee-6edb-4950-aa8b-e89e025440b7@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:43:55PM +0800, zhenwei pi wrote:
> Hi Michael,
> 
> This seems to have been ignored as you suggested.
> 
> LINK: https://www.spinics.net/lists/linux-virtualization/msg63015.html

Pls Cc more widely then:

Paolo Bonzini <pbonzini@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
Stefan Hajnoczi <stefanha@redhat.com> (reviewer:VIRTIO BLOCK AND SCSI DRIVERS)
Xuan Zhuo <xuanzhuo@linux.alibaba.com> (reviewer:VIRTIO CORE AND NET DRIVERS)
Jens Axboe <axboe@kernel.dk> (maintainer:BLOCK LAYER)
linux-block@vger.kernel.org (open list:BLOCK LAYER)

would all be good people to ask to review this.


> On 9/4/23 14:10, zhenwei pi wrote:
> > The following codes have an implicit conversion from size_t to u32:
> > (u32)max_size = (size_t)virtio_max_dma_size(vdev);
> > 
> > This may lead overflow, Ex (size_t)4G -> (u32)0. Once
> > virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
> > instead.
> > 
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >   drivers/block/virtio_blk.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 1fe011676d07..4a4b9bad551e 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1313,6 +1313,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> >   	u16 min_io_size;
> >   	u8 physical_block_exp, alignment_offset;
> >   	unsigned int queue_depth;
> > +	size_t max_dma_size;
> >   	if (!vdev->config->get) {
> >   		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > @@ -1411,7 +1412,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> >   	/* No real sector limit. */
> >   	blk_queue_max_hw_sectors(q, UINT_MAX);
> > -	max_size = virtio_max_dma_size(vdev);
> > +	max_dma_size = virtio_max_dma_size(vdev);
> > +	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
> >   	/* Host can optionally specify maximum segment size and number of
> >   	 * segments. */
> 
> -- 
> zhenwei pi

