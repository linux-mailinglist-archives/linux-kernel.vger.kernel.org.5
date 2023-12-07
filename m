Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E74808B26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjLGOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjLGOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771551AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701960940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
        b=TPNtrttgHTh1VEdO2hkqZO9dEL6Dtu0a5+s7RPB1vvzFWqKZTwMIkpuh3A2bcJmMZ91Hbh
        sHNgmjVVclQQ5hLF0l+Rtq/6OIp2q6FtnnXloQ5jdErDo7oB6FDRahb+waDZ8NTePA5j88
        hzd+vhXyzpxurgvlW8O4Och5EPuAinU=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-8axHlxATN5moUwMqpmJ7bg-1; Thu, 07 Dec 2023 09:55:38 -0500
X-MC-Unique: 8axHlxATN5moUwMqpmJ7bg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7c5f24e2b06so264713241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960938; x=1702565738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFUwTkwUasQAuYCMcpY6aWYFjKBTvsfILYuExDUI9Xs=;
        b=Vfkt1fScvBk3PRNPhf6OcYZ3Ry27obXKImw4QkPuvO+lIvjY/YOZAG5zYORbfbt4kI
         cRUGzZb6aAuGbxQAwWNy5qSmJAEXQes2sMVjmFHWCTsboDEW/nZH94bZpyzn2Ftfd8RE
         TjUdTNruF27uHxnq+ydbN/dxlIHhE9fnB/vVR/xODvmAsHaWnZ5hQ/qFWCMuWtdQmXCG
         imG+EgixY7MENyuKg5DRl0gY+cP4Zy0A7+6YWZcKRkAH43WFJvPxcbIr6ViEUgg/lSX7
         EZoWGSArv8SuC7CR+ka1GA70Jc68PZUuDrsp/BwTVDOjVW16/NNFgp1aqnDg5TeEdfky
         tkQQ==
X-Gm-Message-State: AOJu0Yy7d8FJ+ZiEX6jdXhAlSSdeZB7P+3+XsRLuvF1wI2oxbzrjOoa/
        ufEFU5lZSy3x7w75aIX8ZYThyp0NiG8ukprxaFAL3ivKulFbFYeuE3WPVDXXd2Rxfd6f1Ku4LEe
        PlUIYCWR+TlMcrlAVZeECp7BDguFErjPwoPyr/IBq
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id d14-20020a67fb0e000000b004647c84f2cemr2428516vsr.33.1701960937521;
        Thu, 07 Dec 2023 06:55:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExPh5/hFE8CE6pwdTcln4SPXa7YsxLmil/VdfPW34AuIerYiD738D5CYb9gwkY7cCXF4lnoAE2qa1q+zUlTFA=
X-Received: by 2002:a67:fb0e:0:b0:464:7c84:f2ce with SMTP id
 d14-20020a67fb0e000000b004647c84f2cemr2428507vsr.33.1701960937193; Thu, 07
 Dec 2023 06:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231207145159.GB2147383@fedora>
In-Reply-To: <20231207145159.GB2147383@fedora>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 7 Dec 2023 15:55:17 +0100
Message-ID: <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 3:52=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> > virtio-blk is generally used in cloud computing scenarios, where the
> > performance of virtual disks is very important. The mq-deadline schedul=
er
> > has a big performance drop compared to none with single queue. In my te=
sts,
> > mq-deadline 4k readread iops were 270k compared to 450k for none. So he=
re
> > the default scheduler of virtio-blk is set to "none".
> >
> > Signed-off-by: Li Feng <fengli@smartx.com>
> > ---
> >  drivers/block/virtio_blk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems similar to commit f8b12e513b95 ("virtio_blk: revert
> QUEUE_FLAG_VIRT addition") where changing the default sounded good in
> theory but exposed existing users to performance regressions. [...]
> I don't want to be overly conservative. The virtio_blk driver has
> undergone changes in this regard from the legacy block layer to blk-mq
> (without an I/O scheduler) to blk-mq (mq-deadline).

IIRC there were also regressions in both virtio-blk and virtio-scsi
when switching from the legacy block layer to blk-mq. So perhaps I
*am* a bit more conservative, but based on past experience, this patch
seems not to be a great idea for practical use cases.

Paolo

> Performance changed
> at each step and that wasn't a showstopper, so I think we could default
> to 'none' without a lot of damage. Let's just get more data.
>
> Stefan
>
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index d53d6aa8ee69..5183ec8e00be 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
> >       vblk->tag_set.ops =3D &virtio_mq_ops;
> >       vblk->tag_set.queue_depth =3D queue_depth;
> >       vblk->tag_set.numa_node =3D NUMA_NO_NODE;
> > -     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
> > +     vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED=
_BY_DEFAULT;
> >       vblk->tag_set.cmd_size =3D
> >               sizeof(struct virtblk_req) +
> >               sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> > --
> > 2.42.0
> >

